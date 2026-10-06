Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59656387364
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 22:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791327410; cv=none; b=YcsMsdxkK884eGrlLXdIL5Havn5Nn9p7nfTe6pCF3DoxBXqkWAC7Ugux8mvsQx1MApf03wfmKBMhZNDDmVopLxa4jpYUa1sG8P5hJ+1Oua5g42yu8hIGabCtnMZj4NbvbMHCNEhvEnNqNTYiTDk99yBLtcgbIZCZGTk1jX9B/jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791327410; c=relaxed/simple;
	bh=MzJid57T7kvVDqpjL+7+fiHFXPk+H9FgHow2luDCwDU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ISIzrpMVDzGNP7S1hRGUkILMCJoyuqz77bNttJ8O+f8PXhTXGu9zzOE1ElFQRmovbsuf5b6gCL7qeYgp091D2JVfcLHzm4Vvrrtw1GtxYfsnINC3YXq4FLoQSUVm0Ie9CaH/p+zcMKdvf7pb1yhdIIgLbwOq+QJXgJnRiXSGBY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=Ncjx6BPp; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="Ncjx6BPp"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-4f512029e45so2534265b6e.1
        for <stable@vger.kernel.org>; Tue, 06 Oct 2026 15:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1791327409; x=1791932209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9OqI0lB2VAAehqC+cvR7VBFVsvBHKaFqIk6BYnoJbq0=;
        b=Ncjx6BPpcFCsCiN4HUaHVN9lrDTLmA9v7Fdv466s+ugJ6hVKNU8pOEFYCaE5CD2JDZ
         fZLujPXZIVRWemw9LaAw00iKSb3MyqTqcMacLNV+PkpCqWiugd3pCsRfVw2o0DX7sf7a
         92OY8mW9fFo3gKuL3gw5e9o//4e4hyyPclOtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791327409; x=1791932209;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9OqI0lB2VAAehqC+cvR7VBFVsvBHKaFqIk6BYnoJbq0=;
        b=alMRjdixsG6nwRD3EhwoNRobv304I+jw4pxHPVhd3NAad0E6emPc2G2TZB/gZ8Hzj+
         EFgIzVa+rYI4GTzj1u0KNA6Pa7ZEA6EdryP1gpoZA/S4xVGErv52wigFfRYBY6gVLDbD
         70pY4gJ+knsZFdKx5TO4szK1cEcTYdoytqMpatdzNIxAdBmt0i+sx8n8GLxxCndVoIRT
         5WWUjb7vuPz8OxY+hnNX+oYBzWbk+/ElseOJrxY91wIf7Fu1fGSKvWxKpAO4HnbJno8V
         6CBbNGeTnLLG3Uv2sOG3Lxjn83h9BdJqsc9X8ZYpLANAYm8cksdeRmP1Ju5kU+ZPt6gD
         1GRA==
X-Forwarded-Encrypted: i=1; AKwUvBzvV0C/CiEFCIfg+ZAVYjpfBhug4+ua+wl7euvLX04/7aVE11lH3/bKWQdIy2nButWmlOnUu/8=@vger.kernel.org
X-Gm-Message-State: AFuF++kawl5j+PRN23ICnITbluVAzNKkoYvRSP6+qk0n6IMmD8ZqmGDM
	qsaOHLnaqFQBJ446Zr7BRFDAqnZrGmK5xxhyEIzKZkLeDfBDMvz+IGUyAf6JixAj99Q=
X-Gm-Gg: AYBFou3HQjL6OTk541irXCsoBuZ672C3UCv2AQUmpYx7I8vVExQ5d2qVT84wAc4j2TZ
	zKJDLsrhIisxxsKV1H+reFjUvqLfRCDvglZ7L/QKCA8/G53oBxZpgfZezLkRXVaUrqwclf8SxLZ
	L6Zs98NBzDFVqsHyPgh81fpQwiSYU7DdhKhp6AxNhHTGeCA9ca7c0IBcqQ4aF0qR9vu0Fr4VMVh
	AGdQXZbpZhJ6XpzwZojFeXZObfdXIDxf16BoYM6J1c3BqofJFF86qkTrcphC4CHItWQkvLkjkta
	kOKatjhodnkJ8qBdxlKrvgYocqAqu2/QVaVRGF2EZmM62WIT/cZj8NrHc2hDDE9hLtKFyL2b/gY
	8wB+1NHUL5ZtVVJphZPabIgemxGLiC5vEZfvtm0DuAJi6uR2/cH8MVUjEgXWryQkby2ApoVDdGa
	qLeT2W97ypslBRHMWcIvPgpL/snlWgonM9x68KN/6R3SWAhTy0gRUVklh++hShTS+LdzEPX+E3q
	8gGr+c1/FI9MQ9kjCg73/OaaE5oSR4fT14l8N5SmXOqCU6SWH7nu4mIQ7yEApsmo5cmPEnvMoc=
X-Received: by 2002:a05:6808:5094:b0:4fb:90ae:2b02 with SMTP id 5614622812f47-4fc4626c663mr837917b6e.52.1791327409290;
        Tue, 06 Oct 2026 15:56:49 -0700 (PDT)
Received: from com-75606.corp.openai.org ([199.47.143.7])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4fc48b0cb3csm671474b6e.7.2026.10.06.15.56.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 06 Oct 2026 15:56:48 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	outbounddisclosures@openai.com,
	Kyle Zeng <kylebot@openai.com>,
	stable@vger.kernel.org
Subject: [PATCH] tracing/filters: Treat zero-length dynamic strings as empty
Date: Tue,  6 Oct 2026 15:56:42 -0700
Message-ID: <20261006225642.58778-1-kylebot@openai.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Assisted-by: Codex:gpt-6-astra
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
 kernel/trace/trace_events_filter.c | 38 +++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 2b46ca536045..02aaa92e0361 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -884,6 +884,25 @@ static int filter_pred_pchar_user(struct filter_pred *pred, void *event)
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
@@ -900,13 +919,8 @@ static int filter_pred_strloc(struct filter_pred *pred, void *event)
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
@@ -923,13 +937,8 @@ static int filter_pred_strrelloc(struct filter_pred *pred, void *event)
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
@@ -1014,7 +1023,8 @@ static int filter_pred_function(struct filter_pred *pred, void *event)
  *
  * @str: the string to be searched
  * @r:   the regex structure containing the pattern string
- * @len: the length of the string to be searched (including '\0')
+ * @len: the length of the string to be searched (including '\0'), or zero
+ *       for a NUL-terminated string of unknown length
  *
  * Note:
  * - @str might not be NULL-terminated if it's of type DYN_STRING
@@ -1023,7 +1033,7 @@ static int filter_pred_function(struct filter_pred *pred, void *event)
 
 static int regex_match_full(char *str, struct regex *r, int len)
 {
-	/* len of zero means str is dynamic and ends with '\0' */
+	/* Zero is reserved for a NUL-terminated string of unknown length. */
 	if (!len)
 		return strcmp(str, r->pattern) == 0;
 
