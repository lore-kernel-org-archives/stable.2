Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795196475;
	b=UbDhbdWgsmro+EXWYqUrxCniTSUr6wPTCQ15910JZiaLI6zLAMgj4rVeRPBlaS3JMTK0
	 Et6iStj57uUk636DtZ3AtWoy84omCLkyFpSiXxdHP+jwdRrEWkU5Y8SyINd7wR+xLkNbI
	 X+RDKbQG27ADOZTr6iWn5o4whXFHBoLFXQeacLUed0fWq3GuvNMBNxCsUDVeVUBETE+Rn
	 rmTfbkfD5m0qlD1knY7XL3QL9AGoAn25btMz3OlaqZnueOFuVUg8ddA69wwJOZgvDB6nE
	 VVlwvp11xByB37fJpq5aWTENi6zRRwBjotHNmIXvpljBzW/BCEg28ClCbF98xP7Aruw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795196475;
	h=Received:DKIM-Signature:Received:Message-ID:User-Agent:Date:From:To:
	 Cc:Subject:References:MIME-Version:Content-Type;
	bh=Adu/Hdv9H4tgUeMLSxNGgOk0ElazLC8OxKyBikKQgTI=;
	b=VcsHqMafqoHRWuwiFolOIlEfhxB6mIlv28AMn3DotmLDvkR5EFMj4qhSQamtIcV750ZT
	 wkdXuNeWr4ESIGvvLW8bfbkuOXfX6BeqI1WqRJNxCw8Tf/ZfLu+AIpIUuwj8rTU8er8AH
	 vLGcb0Ax9uwbIRTbsDjg9kyNt+OvwY60dM6bw0lQJCaYLgx9WtCQEK4e55hg7G3MRplWk
	 jBZK4rfn75y0bwC64TW9T59GEQN018da+WTGvbT9hprkUwRwiOiozws1FTnQfouOH1yJp
	 +qmp4pNUdTcOXzIQ6l1GJ5Ja9tB8Jiqa8GnIbXQJWjqRYMQWR4KFveFUt5tFacXp8yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NhfHyRcz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB7660A2606;
	Fri, 20 Nov 2026 17:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NhfHyRcz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 980AB1F0093C;
	Fri, 20 Nov 2026 17:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795196475;
	bh=Adu/Hdv9H4tgUeMLSxNGgOk0ElazLC8OxKyBikKQgTI=;
	h=Date:From:To:Cc:Subject:References;
	b=NhfHyRczEsSD4xj8D0E+7sr9d9iVKTI2KtKtVJE7myldN7cfkitr2yV/Y77BmQf7a
	 N09EV2BT6XwPKZQvo4LLMr7v1fFO5xGiehfszpLJqiJSlMLESlyTLXvH3ZDEWx6GVW
	 o489CA6BZhjBmO9HSqdoAeTMkSkkuzPnyJwMPGXEPbbX6L/5FcqWGRPY0CTVV/ZD7Z
	 GYSwIJn8Bi3CzZZsdilRdP2bmfHLo8B3Uw/DTCDdEqYuTu977CdWAUFVdOcr77YWza
	 pDifU43zdHo9R5NAPhdQLT80Y+ZMUH3tE62xEDWKNCkRlCYHG5UEAlziw5aQAUnziC
	 +BHoD+vNwLCYw==
Received: from rostedt by gandalf with local (Exim 4.100.1)
	(envelope-from <rostedt@kernel.org>)
	id 1xUSbq-00000004aGQ-43kC;
	Fri, 20 Nov 2026 12:41:14 -0500
Message-ID: <20261120174114.766221293@kernel.org>
User-Agent: quilt/0.69
Date: Fri, 20 Nov 2026 12:38:56 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Kyle Zeng <kylebot@openai.com>
Subject: [for-linus][PATCH 04/32] tracing/filters: Treat zero-length dynamic strings as empty
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

From: Kyle Zeng <kylebot@openai.com>

The regex callbacks use a length of zero for NUL-terminated strings of
unknown size, such as the trailing buffer in a trace_marker record.
However, filter_pred_strloc() and filter_pred_strrelloc() pass the length
from a data locator directly to those callbacks. A zero-length locator
has no data and need not point at a NUL byte.

In particular, syscall entry events can contain an empty captured array
or a failed user-string copy. Matching such a field with an equality,
prefix, or substring filter can read beyond the record. The per-CPU perf
trace buffer is reused, so an unprivileged counting syscall event can
disclose bytes left by a previous kernel tracepoint even when raw
sampling is denied and exclude_kernel prevents counting that tracepoint.

Handle both locator formats through a common helper. For a zero-length
field, pass an empty string and its actual size to the regex callback.
This gives all matching modes the empty-string semantics without reading
the locator's target. Keep nonzero fields and the legacy trace_marker
unknown-length convention unchanged.

Fixes: 10f20e9f9da9 ("tracing: Have zero size length in filter logic be full string")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261006225642.58778-1-kylebot@openai.com
Assisted-by: Codex:gpt-6-astra
Signed-off-by: Kyle Zeng <kylebot@openai.com>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_events_filter.c | 38 +++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index cd0da148414d..62444db0f78b 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -891,6 +891,25 @@ static int filter_pred_pchar_user(struct filter_pred *pred, void *event)
 	return filter_pchar(pred, str);
 }
 
+static __always_inline int filter_dyn_string(struct filter_pred *pred,
+					     char *str, int len)
+{
+	int cmp;
+
+	/*
+	 * The regex callbacks use zero for an unknown-length, NUL-terminated
+	 * string. A zero-length data_loc or rel_loc field has no bytes at all.
+	 * Match an empty string instead of reading past the end of the field.
+	 */
+	if (!len) {
+		str = "";
+		len = 1;
+	}
+
+	cmp = pred->regex->match(str, pred->regex, len);
+	return cmp ^ pred->not;
+}
+
 /*
  * Filter predicate for dynamic sized arrays of characters.
  * These are implemented through a list of strings at the end
@@ -907,13 +926,8 @@ static int filter_pred_strloc(struct filter_pred *pred, void *event)
 	int str_loc = str_item & 0xffff;
 	int str_len = str_item >> 16;
 	char *addr = (char *)(event + str_loc);
-	int cmp, match;
-
-	cmp = pred->regex->match(addr, pred->regex, str_len);
 
-	match = cmp ^ pred->not;
-
-	return match;
+	return filter_dyn_string(pred, addr, str_len);
 }
 
 /*
@@ -930,13 +944,8 @@ static int filter_pred_strrelloc(struct filter_pred *pred, void *event)
 	int str_loc = str_item & 0xffff;
 	int str_len = str_item >> 16;
 	char *addr = (char *)(&item[1]) + str_loc;
-	int cmp, match;
-
-	cmp = pred->regex->match(addr, pred->regex, str_len);
 
-	match = cmp ^ pred->not;
-
-	return match;
+	return filter_dyn_string(pred, addr, str_len);
 }
 
 /* Filter predicate for CPUs. */
@@ -1037,7 +1046,8 @@ static int filter_pred_within(struct filter_pred *pred, void *event)
  *
  * @str: the string to be searched
  * @r:   the regex structure containing the pattern string
- * @len: the length of the string to be searched (including '\0')
+ * @len: the length of the string to be searched (including '\0'), or zero
+ *       for a NUL-terminated string of unknown length
  *
  * Note:
  * - @str might not be NULL-terminated if it's of type DYN_STRING
@@ -1046,7 +1056,7 @@ static int filter_pred_within(struct filter_pred *pred, void *event)
 
 static int regex_match_full(char *str, struct regex *r, int len)
 {
-	/* len of zero means str is dynamic and ends with '\0' */
+	/* Zero is reserved for a NUL-terminated string of unknown length. */
 	if (!len)
 		return strcmp(str, r->pattern) == 0;
 
-- 
2.53.0
