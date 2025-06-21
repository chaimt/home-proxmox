# n8n Workflow for Gemini File Processing

This directory contains an n8n workflow that demonstrates how to call the Gemini execute endpoint for file processing.

## Files

- `n8n_gemini_workflow.json` - The complete n8n workflow that can be imported
- `n8n_workflow_README.md` - This documentation file

## How to Import and Use

### 1. Import the Workflow

1. Open your n8n instance
2. Go to "Workflows" in the sidebar
3. Click the "Import from file" button
4. Select the `n8n_gemini_workflow.json` file
5. The workflow will be imported with all nodes and connections

### 2. Workflow Overview

The workflow consists of 5 nodes:

1. **Prepare File Data** - Code node that prepares file data (currently uses mock data)
2. **Call Gemini Execute** - HTTP Request node that calls your Gemini endpoint
3. **Process Response** - Code node that processes the Gemini response
4. **Check Success** - IF node that routes based on success/failure
5. **Success Handler** - Code node for successful processing
6. **Error Handler** - Code node for error handling

### 3. Configuration Required

#### Update the API URL
In the "Call Gemini Execute" node, update the URL to match your server:
- Change `http://localhost:8000` to your actual server URL
- If using HTTPS, update accordingly

#### Configure File Handling
The "Prepare File Data" node currently uses mock data. To use real files, you can:

**Option A: Read from File System**
```javascript
const fs = require('fs');
const filePath = '/path/to/your/audio.mp3';
const fileBuffer = fs.readFileSync(filePath);

return [{
  json: {
    file: {
      name: 'audio.mp3',
      type: 'audio/mpeg',
      size: fileBuffer.length,
      data: fileBuffer
    }
  }
}];
```

**Option B: Use n8n File Nodes**
- Add a "Read Binary Files" node before "Prepare File Data"
- Connect it to read files from a directory
- Modify "Prepare File Data" to use the file from the previous node

**Option C: Webhook Trigger**
- Replace "Prepare File Data" with a "Webhook" trigger node
- Configure it to receive file uploads
- The webhook will automatically provide file data

### 4. Customization Examples

#### Different File Types
Update the MIME type in the "Call Gemini Execute" node:
- Audio: `audio/mpeg`, `audio/wav`, `audio/mp4`
- Video: `video/mp4`, `video/avi`
- Images: `image/jpeg`, `image/png`
- Documents: `application/pdf`, `text/plain`

#### Custom Prompts
Modify the prompt parameter in the "Call Gemini Execute" node:
```json
{
  "name": "prompt",
  "value": "Analyze this image and describe what you see in detail",
  "parameterType": "formData"
}
```

#### Different Models
Change the model in the "Call Gemini Execute" node:
```json
{
  "name": "local_model",
  "value": "gemini-1.5-pro",
  "parameterType": "formData"
}
```

### 5. Testing the Workflow

1. **Manual Execution**: Click "Execute Workflow" to test with mock data
2. **Webhook Testing**: If using webhook trigger, use tools like Postman or curl to send files
3. **Scheduled Execution**: Set up triggers to run the workflow automatically

### 6. Error Handling

The workflow includes error handling:
- Success path: Processes and logs successful responses
- Error path: Logs errors and can be extended to send notifications

### 7. Extending the Workflow

Common extensions:
- **Database Storage**: Add a database node to store results
- **Notifications**: Add email/Slack nodes for notifications
- **File Management**: Add nodes to move/delete processed files
- **Batch Processing**: Add loops to process multiple files

### 8. Security Considerations

- Store API keys in n8n credentials, not in the workflow
- Use environment variables for URLs and configuration
- Implement proper authentication if needed
- Consider rate limiting for large file processing

## Example Usage Scenarios

### Audio Transcription
```json
{
  "prompt": "Transcribe this audio file in English with timestamps",
  "mime_type": "audio/mpeg"
}
```

### Image Analysis
```json
{
  "prompt": "Describe this image in detail and identify any objects or people",
  "mime_type": "image/jpeg"
}
```

### Document Processing
```json
{
  "prompt": "Extract key information from this document and create a summary",
  "mime_type": "application/pdf"
}
```

## Troubleshooting

### Common Issues

1. **Connection Refused**: Check if your Gemini server is running
2. **File Upload Errors**: Verify MIME type and file format
3. **API Key Issues**: Ensure Gemini API key is properly configured
4. **Timeout Errors**: Large files may need longer timeout settings

### Debug Tips

1. Enable debug mode in n8n to see detailed logs
2. Check the "Process Response" node for error details
3. Verify file paths and permissions
4. Test the API endpoint directly with curl first 