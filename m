Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60C34218B6;
	Tue,  7 Jul 2026 13:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783431985; cv=none; b=NjqkPw9BW1W/hAhksPBQ/YHeOm/UHwnT4rzu7DIZ7NsNC+Q7oWLOUAkkwpn9I2uh2DtwS2APsz8iXpJEvmnIvrU0WeujBB0KtOVcrXE9Pv9LTwCkwx6tFWED0TmxyK2Ac+qcC9VlGHbN/jux/pl1N39xwS3KpGx9A2o+vYb0lL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783431985; c=relaxed/simple;
	bh=3iW7iRW3LaWmn/h2ZPnzqj+1x7yTXCh97LlZnZtXpaY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Gka4GkxSl05kIcn285kv1XhQ8DwD4tZet4zNUwRa09c7ePE4XDcSDSVKXVP4HE1bKsTos98GGBo7xpxrBbvQhuxa279t3fLp0fkXR3HY9AmX2E8T7azHbSnLMT4ngQcIHwq3IjK01otSHWxEWDy/2ak0bZua48wW1FIE8j2pn7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCFIMrJV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCFIMrJV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10D9E1F00A3F;
	Tue,  7 Jul 2026 13:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783431982;
	bh=itfil0QL1K++We8bxiSxbgpQq8sOzLNqstQlIyIxIE4=;
	h=Date:From:To:Cc:Subject:References;
	b=RCFIMrJVipdqK2MgNdcXsYxXbJm6Hdl38Le+du2vuCaJ8zhQTrrxSLqj3/VzKJYXR
	 tTG4WqbU73kEI8XFmdoz7acZDI4JtGjUDpZatZo+MpxCcPOHN5sWgt0SpQKrjD3/S2
	 bmds2dYmtU0Ve3TCR3C1aVXn4vgYwhRrW+T7BqeGt/MOvBex1miMzl0PANYU5L0FRZ
	 i1e+KSRygCVuVMZnH32bpUQQoJR/YwB+mtAVKmtwYlFC4nP5iZqp8qcupyf7dey5pk
	 aSQgBla2lT5RDE4gRSU6s0zw2dCYP9mewsC2GURT1Zv4cKyKhSww7O5bzGAC7QXc0p
	 PWz9mMMOs2WhQ==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1wh681-00000000h6a-1Us7;
	Tue, 07 Jul 2026 09:46:25 -0400
Message-ID: <20260707134625.188028635@kernel.org>
User-Agent: quilt/0.69
Date: Tue, 07 Jul 2026 09:46:16 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Yuan Tan <yuantan098@gmail.com>,
 Yifan Wu <yifanwucs@gmail.com>,
 Juefei Pu <tomapufckgml@gmail.com>,
 Zhengchuan Liang <zcliangcn@gmail.com>,
 Xin Liu <bird@lzu.edu.cn>,
 Huihui Huang <hhhuang@smu.edu.sg>,
 Ren Wei <n05ec@lzu.edu.cn>
Subject: [for-linus][PATCH 12/13] tracing: Prevent out-of-bounds read in glob matching
References: <20260707134604.275787924@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Huihui Huang <hhhuang@smu.edu.sg>

String event fields are not necessarily NUL-terminated, so the filter
predicate functions (filter_pred_string(), filter_pred_strloc() and
filter_pred_strrelloc()) pass the field length to the regex match
callbacks, and the length-aware matchers honour it.

regex_match_glob() was the exception: it ignored the length and called
glob_match(), which scans the string until it hits a NUL byte. Some
string fields are not NUL-terminated. One example is the dynamic char
array of the xfs_* namespace tracepoints, which is copied without a
trailing NUL. For such a field, glob matching reads past the end of
the event field, causing a KASAN slab-out-of-bounds read in
glob_match(), reached via regex_match_glob() and filter_match_preds()
from the xfs_lookup tracepoint.

Add a length-bounded glob_match_len() and use it from regex_match_glob()
so glob matching always stops at the field boundary. The matching loop
is factored into a shared helper so glob_match() keeps its behaviour.

Fixes: 60f1d5e3bac4 ("ftrace: Support full glob matching")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/da1aaf125fc3b63320b0c540fd6afa7c3d5b4f1a.1782836943.git.hhhuang@smu.edu.sg
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Assisted-by: Codex:GPT-5.4
Signed-off-by: Huihui Huang <hhhuang@smu.edu.sg>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 include/linux/glob.h               |  1 +
 kernel/trace/trace_events_filter.c |  6 ++----
 lib/glob.c                         | 31 ++++++++++++++++++++++++++++--
 3 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/include/linux/glob.h b/include/linux/glob.h
index 861327b33e41..91595e750936 100644
--- a/include/linux/glob.h
+++ b/include/linux/glob.h
@@ -6,5 +6,6 @@
 #include <linux/compiler.h>	/* For __pure */
 
 bool __pure glob_match(char const *pat, char const *str);
+bool __pure glob_match_len(char const *pat, char const *str, size_t len);
 
 #endif	/* _LINUX_GLOB_H */
diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 609325f57942..6385cd662d8d 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1056,11 +1056,9 @@ static int regex_match_end(char *str, struct regex *r, int len)
 	return 0;
 }
 
-static int regex_match_glob(char *str, struct regex *r, int len __maybe_unused)
+static int regex_match_glob(char *str, struct regex *r, int len)
 {
-	if (glob_match(r->pattern, str))
-		return 1;
-	return 0;
+	return glob_match_len(r->pattern, str, len) ? 1 : 0;
 }
 
 /**
diff --git a/lib/glob.c b/lib/glob.c
index 7aca76c25bcb..c80d9dd736b4 100644
--- a/lib/glob.c
+++ b/lib/glob.c
@@ -11,6 +11,9 @@
 MODULE_DESCRIPTION("glob(7) matching");
 MODULE_LICENSE("Dual MIT/GPL");
 
+static bool __pure glob_match_str(char const *pat, char const *str,
+				  char const *str_end);
+
 /**
  * glob_match - Shell-style pattern matching, like !fnmatch(pat, str, 0)
  * @pat: Shell-style pattern to match, e.g. "*.[ch]".
@@ -40,6 +43,29 @@ MODULE_LICENSE("Dual MIT/GPL");
  * An opening bracket without a matching close is matched literally.
  */
 bool __pure glob_match(char const *pat, char const *str)
+{
+	return glob_match_str(pat, str, NULL);
+}
+EXPORT_SYMBOL(glob_match);
+
+/**
+ * glob_match_len - glob match against a length-bounded string
+ * @pat: Shell-style pattern to match.
+ * @str: String to match.  Need not be NUL-terminated.
+ * @len: Number of bytes of @str that may be read.
+ *
+ * Like glob_match(), but @str is only read up to @len bytes, so it can be
+ * used on buffers that are not NUL-terminated (e.g. trace event fields).
+ * A NUL byte within @len still terminates the string.
+ */
+bool __pure glob_match_len(char const *pat, char const *str, size_t len)
+{
+	return glob_match_str(pat, str, str + len);
+}
+EXPORT_SYMBOL(glob_match_len);
+
+static bool __pure glob_match_str(char const *pat, char const *str,
+				  char const *str_end)
 {
 	/*
 	 * Backtrack to previous * on mismatch and retry starting one
@@ -55,9 +81,11 @@ bool __pure glob_match(char const *pat, char const *str)
 	 * on mismatch, or true after matching the trailing nul bytes.
 	 */
 	for (;;) {
-		unsigned char c = *str++;
+		unsigned char c = (str_end && str >= str_end) ? '\0' : *str;
 		unsigned char d = *pat++;
 
+		str++;
+
 		switch (d) {
 		case '?':	/* Wildcard: anything but nul */
 			if (c == '\0')
@@ -125,4 +153,3 @@ bool __pure glob_match(char const *pat, char const *str)
 		}
 	}
 }
-EXPORT_SYMBOL(glob_match);
-- 
2.53.0


