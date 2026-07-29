Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7FE3F86EE;
	Wed, 29 Jul 2026 23:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785369333; cv=none; b=VH7iQY4Y8BLGUetG+y8zSyxLF85ihUXrjPKV9ycyAfesm7zx4fG+SGy3GgnWZez1EkavbveI4xDrB6bWKeuYNs8QeVPQRlwX/6u9sh3gld9pv+Y9GKQ8/2Lp4gQIAApWvH7zy13u05oDUGpIp+0i7fimQBW9QRtW3RMJDGOQHDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785369333; c=relaxed/simple;
	bh=tuohBUJKFSqYOqjc85G0iN3EBdqtyF3Q30WgfgaLxDI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=jLj6puF3hjDqjyP3SasTsenxyI0drrXPMp37dysx8rFfFBgyM1WGeIF1d4OweXFP6FSZ/3vxQzFOk25hnSLVQyQhguQyZDFeZRdOmERM8L9sbTAaZf8NT913X0sZYOFak+/7ab9o+34vERcrTIdCvpjP+Lp8XQIFJ76cGwENF8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDJb6wjr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDJb6wjr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E6F11F00ACA;
	Wed, 29 Jul 2026 23:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785369332;
	bh=cI04/dvLyhE4Un/Fm7LB2XCXtWTXB9GW4z1o31WH2lA=;
	h=Date:From:To:Cc:Subject:References;
	b=YDJb6wjr0MpXC+2PisKinAtwDLmPZI1X9O+2077UedvTTchbqXAbKmyE5ebFP9+/j
	 Rmha/Ok2GIACsBls0k+yVnJGod8doURnOE5yTqAZ5Pajq6gmjhxYAQzzdNPfO+PUcX
	 6R8aMBPRPOuiUiQUYGgQ9f6yq7hYZY/WY5JISQvgfRA//oORPw5VFv7vrbEDFhHRwj
	 Y+PpRklcDWUxmXAGPp3UE62xsjGNCYbWrTB7ZKlJ0IMqTBxVYyj45s1ufPusJkyPh5
	 XejyHwN5lnK59cGsI6eMe6sqeEodQYTACVtbS8Mr3W+aQrtH6wuU2Paff33Cx21772
	 BbQ1DSzLL1Abg==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1wpE89-00000007Ha2-02l4;
	Wed, 29 Jul 2026 19:56:09 -0400
Message-ID: <20260729235608.867999945@kernel.org>
User-Agent: quilt/0.69
Date: Wed, 29 Jul 2026 19:55:55 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org
Subject: [for-linus][PATCH 4/5] tracing/filters: Fix false positive match in regex_match_full()
References: <20260729235551.356165691@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

regex_match_full() calls strncmp(str, r->pattern, len) where len is the
target field buffer size. When len is smaller than r->len (the filter
pattern length), strncmp() checks only len bytes of r->pattern against
str. If those len bytes match, strncmp() returns 0, resulting in a
false-positive match where a shorter string in a fixed-size field
matches a longer filter pattern.

For example, a 4-byte static string field containing "abcd" matched the
filter pattern "abcdefgh" because strncmp("abcd", "abcdefgh", 4)
returned 0. In this case, @len does NOT include '\0' because it is
fixed-size array.

Fix this by returning 0 (no match) early when len < r->len.

Fixes: 1889d20922d1 ("tracing/filters: Provide basic regex support")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/178528488779.124250.5571741156199253769.stgit@devnote2
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_events_filter.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 6385cd662d8d..2b46ca536045 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1027,6 +1027,9 @@ static int regex_match_full(char *str, struct regex *r, int len)
 	if (!len)
 		return strcmp(str, r->pattern) == 0;
 
+	if (len < r->len)
+		return 0;
+
 	return strncmp(str, r->pattern, len) == 0;
 }
 
-- 
2.53.0


