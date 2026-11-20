Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795196476;
	b=uiHrtStB+ziKPpkCOPPyIMEa0Lci+OkcUjr8uluWFEmLCH7X38z/hfqPMMxixClmsMSS
	 BZev7FHV20sdzVtcbd1jSzcGm4NdbUKiX/N12vOcrYYYuzjgpN4EnpmikwKKH5d1LDkbM
	 +HEskBdPq/aTM/ic1D2O/RfqgUBBinFH4f68B3VDENByYKMrKYuw8kwPLwtuwTgLx2BJ4
	 rKOLp+fVDWorDFbY+x7cuAOKLes93HHIjQt3cPoi0pBA8IY0qwEPt1jwhYlxba5gdaS6O
	 V/1mM+eowg9Panp210hTt8EojDuth+o9HAOp3TRiNWAtZd151TZiNMGWd0NDXjM7zVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795196476;
	h=Received:DKIM-Signature:Received:Message-ID:User-Agent:Date:From:To:
	 Cc:Subject:References:MIME-Version:Content-Type;
	bh=1WZdkvxeLJm91lHWo/o/DfjLIfk7nKrzTkfg8Cp18n4=;
	b=DkVyablxVbJKlP8ad1DqZ7nzOOGgjujdw7Bmj4sSvjkffWXYgepoXnD8j3eydwPITj8p
	 0j6O9/Q0H8U6cSjpelhrSkdATwLWN+/Pe0VHHhqe/ZEMxffbhFo3hjXv60o5Qn2d1EM6k
	 Y41ICe0CHZZ9VpWv8l6W9VOZZtE5SXHA1KS3TV88EUXox4BmBCVHLGvdKTI5mGdYWYcFG
	 5szXsTN23QzS12D9stE7P7LEfGJ3xcEpWO5H0CaPfaSwVEUrHR57RJLXrilz3nrHjLetS
	 ETB900yWzrf8zJ73uEeChxWYVPKkmzhQ0R5yUbV2yPUhKDVIL5SeFiIOwAomwW4JqZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="fTfJG/HN";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E5D60A2628;
	Fri, 20 Nov 2026 17:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fTfJG/HN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AF211F0156B;
	Fri, 20 Nov 2026 17:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795196476;
	bh=1WZdkvxeLJm91lHWo/o/DfjLIfk7nKrzTkfg8Cp18n4=;
	h=Date:From:To:Cc:Subject:References;
	b=fTfJG/HNATarHgmL1H5igxpvjVb7WbgGLSszihC4gv6r4+SvLzKsUAo9ziPAryCBY
	 zHgfS6Qp6IF7n7dEyAPdc9v085eJrTaySwDNmUP+RnvVacQj1i3zUvx8Mo+Ju8jarF
	 +4yP/tpZY6YAG6Fg9RXMOopf28Mt+wFWWlzSPWS2fvW/pstlxILHUj2SppvwCCDWVy
	 +BHA8g57tTIIsDpb3htf/LTy/qDD21t6qAgmW5rL8TTUNxpOKYuNFFBdMxKwIxzykd
	 RHq9MZXptdmItZMh8KLRkTLcMHRhhLVozHFJksuh0wBDKyKpitFznp3xPxYrU6kYDy
	 YL/pUT8giKugg==
Received: from rostedt by gandalf with local (Exim 4.100.1)
	(envelope-from <rostedt@kernel.org>)
	id 1xUSbr-00000004aIf-39Cy;
	Fri, 20 Nov 2026 12:41:15 -0500
Message-ID: <20261120174115.579778502@kernel.org>
User-Agent: quilt/0.69
Date: Fri, 20 Nov 2026 12:39:00 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org
Subject: [for-linus][PATCH 08/32] tracing/filters: Fix MATCH_END_ONLY regex matching for fixed-size
 strings
References: <20261120173852.687189370@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

regex_match_end() calculates string length as "len - 1", assuming @len
is the string length including trailing '\0'. For dynamic strings
(filter_pred_strloc) and pointer strings (filter_pchar), this assumption
holds and allows O(1) constant-time suffix matching.

However, for fixed-size string fields (FILTER_STATIC_STRING) and "comm"
(FILTER_COMM), the callers pass the buffer capacity rather than the
actual string length (field->size for filter_pred_string, and
TASK_COMM_LEN for filter_pred_comm). Because these buffers hold
null-terminated strings (e.g. prev_comm in sched_switch holding "bash"
in a 16-byte buffer), regex_match_end() tests against the tail of the
buffer capacity (typically trailing '\0' padding at offset 13) rather
than the actual string end. Consequently, suffix matching like
comm ~ "*sh" or prev_comm ~ "*sh" fails for all strings shorter than
the buffer capacity.

Furthermore, for trace events like ftrace/print (trace_marker), the
"buf" field is defined with size 0, denoting an unbounded NUL-terminated
string. regex_match_end() and regex_match_end_str() return 0 when len
is 0, causing suffix matching to fail on ftrace/print events as well.

To fix this without penalizing dynamic and pointer strings with an
unnecessary scan on every event:
- Introduce regex_match_end_str() using strnlen(str, len) for fixed-size
  buffers (FILTER_COMM and FILTER_STATIC_STRING with field->size > 0).
- Introduce regex_match_end_dynstr() using strlen(str) for unbounded
  strings (FILTER_STATIC_STRING with field->size == 0).

Assign these match callbacks in parse_pred() when MATCH_END_ONLY is
requested.

Cc: stable@vger.kernel.org
Fixes: a3291c14ecf0 ("tracing/filters: Fix MATCH_END_ONLY filter matching")
Fixes: 10f20e9f9da9 ("tracing: Have zero size length in filter logic be full string")
Link: https://patch.msgid.link/179323785497.740114.7643531772387726730.stgit@devnote2
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_events_filter.c | 32 ++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 62444db0f78b..d2069ef554d6 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1092,6 +1092,30 @@ static int regex_match_end(char *str, struct regex *r, int len)
 	return 0;
 }
 
+static int regex_match_end_str(char *str, struct regex *r, int len)
+{
+	int slen;
+
+	if (len < r->len)
+		return 0;
+
+	slen = strnlen(str, len);
+	if (slen >= r->len &&
+	    memcmp(str + slen - r->len, r->pattern, r->len) == 0)
+		return 1;
+	return 0;
+}
+
+static int regex_match_end_dynstr(char *str, struct regex *r, int len)
+{
+	int slen = strlen(str);
+
+	if (slen >= r->len &&
+	    memcmp(str + slen - r->len, r->pattern, r->len) == 0)
+		return 1;
+	return 0;
+}
+
 static int regex_match_glob(char *str, struct regex *r, int len)
 {
 	return glob_match_len(r->pattern, str, len) ? 1 : 0;
@@ -2031,10 +2055,18 @@ static int parse_pred(const char *str, void *data,
 
 		if (field->filter_type == FILTER_COMM) {
 			pred->fn_num = FILTER_PRED_FN_COMM;
+			if (pred->regex->match == regex_match_end)
+				pred->regex->match = regex_match_end_str;
 
 		} else if (field->filter_type == FILTER_STATIC_STRING) {
 			pred->fn_num = FILTER_PRED_FN_STRING;
 			pred->regex->field_len = field->size;
+			if (pred->regex->match == regex_match_end) {
+				if (!field->size)
+					pred->regex->match = regex_match_end_dynstr;
+				else
+					pred->regex->match = regex_match_end_str;
+			}
 
 		} else if (field->filter_type == FILTER_DYN_STRING) {
 			pred->fn_num = FILTER_PRED_FN_STRLOC;
-- 
2.53.0
