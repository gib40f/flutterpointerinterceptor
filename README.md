# interceptor

A minimal Flutter project to demo a PointerInterceptor behaviour.

## Getting Started
The page loads a PDF document in an HtmlElementView. The 2 buttons then show an AlertDialog, one
with a PointerInterceptor wrapper and the other without.

The issue is that if you scroll the PDF file it will reload if using the PointerInterceptor and the
document will be back at the start. If not using the PointerInterceptor the mouse clicks are lost.
