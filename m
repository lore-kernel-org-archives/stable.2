Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795729946;
	b=r8cJ9ji3pFNTCZkKoQX0etRJIo20YSsb1TP+KCjYx0p/3SXPb6T3e5KA7wNqgElzEKqP
	 bW1OgUUwcomO7LUBA5lR03cWQ/GL99hDEBhjtPDg7dmnLLmQiXRHlWF5fE16vOAOvaMMM
	 hg8HOxLtmqB+Da7nvgjzrkR823LxRo+UtQXkPD+iyPGUrZcLU1jfhRjeWk/TB77lTttEG
	 CcKwtQ/6caRE794n4ifSInB3aPyMGQ+k0uqFPb56+6iDDjicTBKpHnZup1Fi8GEZdvMro
	 DBrR4NmmrxN/Nt5ipk3CW/vRRMRexrkkybYUjDARjgZJO7lY5f6YTB1V+1pCvzgxabg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795729946;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1YnQvOR3Gw4bXN9YUJx9Lq77dYCC8vrMp788asvQVV4=;
	b=sbn7ysRcPQKbBITe4rMNGLdYaFwDGwz8KgnDjn8a0+lvrkL1tAB+vR63ra6hAaxpP9AZ
	 2udsgz287ITvQAC35pZ28QeXY22ZEpDE7lVpj1v9hW8iD9RIlA2sJvEirD6xK/ObN6W7F
	 iPKRjbn2AdxqtU8WRydMoPr8KZhVLAqW/Yk4I/prVbB0TCFhIt5JaFZ7Q6iBvwQjDr4CO
	 fR0BoirCyJOfIbZiliR8wttgEyfnaq4QQw78g+QkvXEtfhZrcBLjMM5lLVDzwhDlrPzEx
	 qVkqQvjvC+LT6LYHhf1cvBm0TKFPQv356+4CO93hshmzxzc17e7uLWro39G3LkUt4hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rhRgkBfE;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B25F606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 21:52:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B25F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rhRgkBfE
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4acb44dcd7bso6709560f8f.0
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 13:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795729945; x=1796334745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1YnQvOR3Gw4bXN9YUJx9Lq77dYCC8vrMp788asvQVV4=;
        b=rhRgkBfEQfLvE1Z0jzXnQdFA1S7obYbq9YpsAIojpl6lupXu83Qa5rnCMEmkz7SO+t
         41S3vzCyfG8ktfvgZJWMACce9N+m7McHMQTKFOLoCo8zW/hcnfGajl6RfJrLjcTc1He2
         UfBAnxJQaKBHT416TFk+Wu/t+727QrqAhGcygteSR/r/cDp3OnG1znT4ecUN4OX40ljo
         XUG94eZFv+FQ+zjkaoVoCxXcOurqdDdhnB7oTCWhbX0yH292J6KtTZLJWPtptUHQMsV1
         qg/aLV2L14jtCGCHCkjCDVOMKXOGDAp0BLqoeYbcCGG2Vdj+H3s1vzXGjv/Ix1753Gs1
         3j3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795729945; x=1796334745;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1YnQvOR3Gw4bXN9YUJx9Lq77dYCC8vrMp788asvQVV4=;
        b=w4GNLKktKINGLevn6kJ+n1Uqu8NXr8Pn3/N8fWnemfxT5Y1swXpkkI2RiWwKDCi/dA
         Iqb7h8+YqJJZu9In1BUWrteZczZHpS7znNV0zVFHKi8ePCSIcXQMz/JeNPjmCZ+y7E8B
         sxvRBRiZzhiDMyI3N/tAdoZ18/V+QNRwBynPID6swYipDyCGry7rtpKj0d3hNe7Uxagu
         oJ6qY3d/Wk03fsUsiSeBs2oWaBwoJCaKf2Q8B00GBAeOJrJx5YScEabnSleKEvaFAlQc
         MOYD3ainfsaFkL1TWNGse+nejNoyEVnGyNOJ62VprXwIfKIKTqKOTaQUfF+2XOvbC16l
         slcg==
X-Forwarded-Encrypted: i=1; AL+hErH3pEWiZV7UBp7VHwoFUDq3+JfixDGTONPYgXUS36v5DSlfLht58CwmSvNShn0kHkFo+cZgWSw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/H43vCvrY2w+5W/FBS/TTw7W8C/RGG3xgNqZN6S+N+h3gr7j6K
	ntpkIDZsT3BKcbis3wkBRWQ3d7Gjd5MN1l2sdUjqSuVY9Gt7iS2l2XGN
X-Gm-Gg: AZFdTZfVzDbAhrO0ktpPFceeo3O4BJMJ11ISx85XIzH7H+H9hkDAg7W7SMvrEcDZ+0d
	tjEqGn/jNKRhnRzsJ7oheb7i0b9Ip/MrWP4latoLIXxR/uYzXRt8U9Bnf7HlRBcxxW4bnZ30uy0
	Eqd78gWmAsk70FFTI3++1n5EPg3Eih8LRtbadXkvsF/+Y6Rcvxc97fpBgwGBpKZuHdu9JRiOJ+l
	yKU+igKj589N9x6JD55WO0qSNAyPE+IgW8rGxf/DrbKOlHg3BZGj3BooBJ9rKaJFNXP32MjPWFU
	YFROsNt5fMYbHh3LI/EriYbMpBHDBRhULZN5/WfyLRfUUoWRJt6wcvuTWKgC7zzlVL6YynPGACz
	7zNfjMs3iK5WM4fb4rdui5+rRYbi6LhnUS3fy0HiTKIYpSBAqDysfNvBcr/X1MTX3CMddqQWK/p
	UzIntLFbNOaFMYLSO29xKbabfPiu9da2XU4MYB3eeTDGsgXsrg2ngO6mghX+iXRHHve3PbWaxf7
	oUiCYiVvxcaKcr7SrO+HQKZGNbS9VCEty9JGiw4J84VPgqBIcfeepqE/8X36D2gPawIvdJXfQ8S
	86cmp8cWOQX6dk6266VnRtmAw2JdgoYAALBbkcyl4Kc791+EvE3Ymy9d94R7kOtliGza+euWNe+
	VQBqdRd7dCV/EL8n5MCYN29UlnEx1WtOJwHc=
X-Received: by 2002:a05:6000:2c13:b0:4a6:dfe3:fd93 with SMTP id ffacd0b85a97d-4abb41f4dc6mr41417768f8f.40.1795729944154;
        Thu, 26 Nov 2026 13:52:24 -0800 (PST)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b8b7888sm42820523f8f.42.2026.11.26.13.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 13:52:23 -0800 (PST)
From: David Carlier <devnexen@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Huihui Huang <hhhuang@smu.edu.sg>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] tracing/filters: Fix glob matching on zero size string fields
Date: Thu, 26 Nov 2026 21:52:20 +0000
Message-ID: <20261126215220.1205315-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "buf" field of the ftrace print event is a char[] of size zero,
and filter_pred_string() passes that size as the length. The regex
callbacks take a zero length as a NUL-terminated string of unknown
length, but since regex_match_glob() was switched to glob_match_len()
it treats it as an empty string, so a glob never matches:

  # echo 'snapshot if buf ~ "st*r*"' > events/ftrace/print/trigger
  # echo start > trace_marker

Use glob_match() when the length is zero.

Fixes: 0a6070839b1e ("tracing: Prevent out-of-bounds read in glob matching")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 kernel/trace/trace_events_filter.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index a9d77df3e19a..42a57cb57ff9 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1118,6 +1118,10 @@ static int regex_match_end_dynstr(char *str, struct regex *r, int len)
 
 static int regex_match_glob(char *str, struct regex *r, int len)
 {
+	/* Zero is reserved for a NUL-terminated string of unknown length. */
+	if (!len)
+		return glob_match(r->pattern, str);
+
 	return glob_match_len(r->pattern, str, len) ? 1 : 0;
 }
 
-- 
2.55.0

