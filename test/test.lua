
--[[
local mime = t;
local extname = require('path').extname;

p(mime.lookup('json'),
mime.lookup('.md'),
mime.lookup('file.html'),
mime.lookup('folder/file.js'),
mime.lookup('folder/.htaccess'),
mime.lookup('cats'));
p(mime.contentType('markdown'),
mime.contentType('file.json'),
mime.contentType('text/html'),
mime.contentType('text/html; charset=iso-8859-1'),
mime.contentType(extname('/path/to/file.json')));
p(mime.extension('application/octet-stream'));
p(mime.charset('text/markdown'));
print('-------------------');]]

local mimeTypes = require('mime-types');

p('mimeTypes');
p('.charset(type)');

if not (mimeTypes.charset('application/json') == 'UTF-8') then
	p('should return "UTF-8" for "application/json"');
end;
if not (mimeTypes.charset('application/json; foo=bar') == 'UTF-8') then
	p('should return "UTF-8" for "application/json; foo=bar"');
end;
if not (mimeTypes.charset('application/javascript') == 'UTF-8') then
	p('should return "UTF-8" for "application/javascript"');
end;
if not (mimeTypes.charset('application/JavaScript') == 'UTF-8') then
	p('should return "UTF-8" for "application/JavaScript"');
end;
if not (mimeTypes.charset('text/html') == 'UTF-8') then
	p('should return "UTF-8" for "text/html"');
end;
if not (mimeTypes.charset('TEXT/HTML') == 'UTF-8') then
	p('should return "UTF-8" for "TEXT/HTML"');
end;
if not (mimeTypes.charset('text/x-bogus') == 'UTF-8') then
	p('should return "UTF-8" for any text/*');
end;
if not (mimeTypes.charset('application/x-bogus') == false) then
	p('should return false for unknown types');
end;
if not (mimeTypes.charset('application/octet-stream') == false) then
	p('should return false for any application/octet-stream');
end;
if not (mimeTypes.charset({}) == false and
		mimeTypes.charset(nil) == false and
		mimeTypes.charset(true) == false and
		mimeTypes.charset(42) == false) then
	p('should return false for invalid arguments');
end;
p('.contentType(extension)');
if not (mimeTypes.contentType('html') == 'text/html; charset=utf-8') then
	p('should return content-type for "html"');
end;
if not (mimeTypes.contentType('.html') == 'text/html; charset=utf-8') then
	p('should return content-type for ".html"');
end;
if not (mimeTypes.contentType('jade') == 'text/jade; charset=utf-8') then
	p('should return content-type for "jade"');
end;
if not (mimeTypes.contentType('json') == 'application/json; charset=utf-8') then
	p('should return content-type for "json"');
end;
if not (mimeTypes.contentType('bogus') == false) then
	p('should return false for unknown extensions');
end;
if not (mimeTypes.contentType({}) == false and
		mimeTypes.contentType(nil) == false and
		mimeTypes.contentType(true) == false and
		mimeTypes.contentType(42) == false) then
	p('should return false for invalid arguments');
end;
p('.contentType(type)');
if not (mimeTypes.contentType('application/json') == 'application/json; charset=utf-8') then
	p('should attach charset to "application/json"');
end;
if not (mimeTypes.contentType('application/json; foo=bar') == 'application/json; foo=bar; charset=utf-8') then
	p('should attach charset to "application/json; foo=bar"');
end;
if not (mimeTypes.contentType('TEXT/HTML') == 'TEXT/HTML; charset=utf-8') then
	p('should attach charset to "TEXT/HTML"');
end;
if not (mimeTypes.contentType('text/html') == 'text/html; charset=utf-8') then
	p('should attach charset to "text/html"');
end;
if not (mimeTypes.contentType('text/html; charset=iso-8859-1') == 'text/html; charset=iso-8859-1') then
	p('should not alter "text/html; charset=iso-8859-1"');
end;
if not (mimeTypes.contentType('application/x-bogus') == 'application/x-bogus') then
	p('should return type for unknown types');
end;
p('.extension(type)');
if not (mimeTypes.extension('text/html') == 'html' and
		mimeTypes.extension(' text/html') == 'html' and
		mimeTypes.extension('text/html ') == 'html') then
	p('should return extension for mime type');
end;
if not (mimeTypes.extension('application/x-bogus') == false) then
	p('should return false for unknown type');
end;
if not (mimeTypes.extension('bogus') == false) then
	p('should return false for non-type string');
end;
if not (mimeTypes.extension(nil) == false and
		mimeTypes.extension(42) == false and
		mimeTypes.extension({}) == false) then
	p('should return false for non-strings');
end;
if not (mimeTypes.extension('text/html;charset=UTF-8') == 'html' and
		mimeTypes.extension('text/HTML; charset=UTF-8') == 'html' and
		mimeTypes.extension('text/html; charset=UTF-8') == 'html' and
		mimeTypes.extension('text/html; charset=UTF-8 ') == 'html' and
		mimeTypes.extension('text/html ; charset=UTF-8') == 'html') then
	p('should return extension for mime type with parameters');
end;

p('.lookup(extension)');
if not (mimeTypes.lookup('.html') == 'text/html') then
	p('should return mime type for ".html"');
end;
if not (mimeTypes.lookup('.js') == 'application/javascript') then
	p('should return mime type for ".js"');
end;
if not (mimeTypes.lookup('.json') == 'application/json') then
	p('should return mime type for ".json"');
end;
if not (mimeTypes.lookup('.rtf') == 'application/rtf') then
	p('should return mime type for ".rtf"');
end;
if not (mimeTypes.lookup('.txt') == 'text/plain') then
	p('should return mime type for ".txt"');
end;
if not (mimeTypes.lookup('.xml') == 'application/xml') then
	p('should return mime type for ".xml"');
end;
if not (mimeTypes.lookup('html') == 'text/html' and
		mimeTypes.lookup('xml') == 'application/xml') then
	p('should work without the leading dot');
end;
if not (mimeTypes.lookup('HTML') == 'text/html' and
		mimeTypes.lookup('.Xml') == 'application/xml') then
	p('should be case insensitive');
end;
if not (mimeTypes.lookup('.bogus') == false and
		mimeTypes.lookup('bogus') == false) then
	p('should return false for unknown extension');
end;
if not (mimeTypes.lookup(nil) == false and
		mimeTypes.lookup(42) == false and
		mimeTypes.lookup({}) == false) then
	p('should return false for non-strings');
end;

p('.lookup(path)');
if not (mimeTypes.lookup('page.html') == 'text/html') then
	p('should return mime type for file name');
end;
if not (mimeTypes.lookup('path/to/page.html') == 'text/html' and
		mimeTypes.lookup('path\\to\\page.html') == 'text/html') then
	p('should return mime type for relative path');
end;
if not (mimeTypes.lookup('/path/to/page.html') == 'text/html' and
		mimeTypes.lookup('C:\\path\\to\\page.html') == 'text/html') then
	p('should return mime type for absolute path');
end;
if not (mimeTypes.lookup('/path/to/PAGE.HTML') == 'text/html' and
		mimeTypes.lookup('C:\\path\\to\\PAGE.HTML') == 'text/html') then
	p('should be case insensitive');
end;
if not (mimeTypes.lookup('/path/to/file.bogus') == false) then
	p('should return false for unknown extension');
end;
if not (mimeTypes.lookup('/path/to/json') == false) then
	p('should return false for path without extension');
end;
p('-> path with dotfile');
if not (mimeTypes.lookup('/path/to/.json') == false) then
	p('should return false when extension-less');
end;
if not (mimeTypes.lookup('/path/to/.config.json') == 'application/json') then
	p('should return mime type when there is extension');
end;
if not (mimeTypes.lookup('.config.json') == 'application/json') then
	p('should return mime type when there is extension, but no path');
end;
