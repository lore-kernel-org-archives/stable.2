Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794686361;
	b=qHzaiw5IccY+0eX1G6kX/fzzueB5vJ/dUorizw9zQ2G0L6ZSPZbyuV2D0lljdn7F0U3v
	 ajySEwSJHJR/h1U50bRomGIQQWMcv84KsTj9C3cVVbkGwaoUAzzWggtwA8S2re0gbAnl7
	 cdjH7hKTVgpHUERZcHcnEyaCVkb+l6qnQ6hSCAso3bJ1bRs7sLra2uFyU2thlmDPMp0GL
	 ZtUqTDP91rgDWZXJuLSEB2x4tjpqu/gFhbFJz+V5uBngTnsG3+i/eXBVnjwcAg+EYl7O/
	 oIP3pbHurxKEPVl/At0USCRFVDZzPOD5ruv1UcWpQtSFzWwBjA9Vs5h7aZBkLE2JPyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794686361;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kEf2B9QYpi3ckJDBCR/s09wzAUjGwxpz/3KtgUVx8/s=;
	b=PKKkgJPAQQTujE2qMqHkq2GTpqQHpmKKVgsLhNzrHsIj6cucdkLpUMXxei3gFXi1fOko
	 7J9p2XkNplkPEtu7BF3hXH5xHrwAmXRVgN23U01MN09M16kBPwiLE/jv+75ZRgBebs0n6
	 XjbfhxfHb2DXHoUl/uto2/Xfzu1drNM7j377Kh+2n2uYOpJ/ZNvG3H7j8eYjWn7XkKRPD
	 3PvYBFdDgg6rDDDbesmCU9aQ37KTflrDCgDQ7KAioO8luYjVOquESu7o/SBcTFUNF6Ot3
	 fwTzhgiqna5rkhbNDW81B08VpWoyyXG38rXzty49/6cE9OhyTU+QwtNxzBCzYam8k8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=epNIjQ67;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A30606A329
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 19:59:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8A30606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=epNIjQ67
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-492690dd5daso2273813f8f.1
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 11:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794686359; x=1795291159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kEf2B9QYpi3ckJDBCR/s09wzAUjGwxpz/3KtgUVx8/s=;
        b=epNIjQ67nCN3j7wLAT7F/mQhaZcAZaFpGbT9sEyMcTUT10Ob81+mPa/O8MX3E1hUU5
         jk5WPbgcZ9mhEoktRxGqidHA+EwmVOubKe4261DXsWhZ/LbKRj4vef6wVToiW8hxK5n8
         7eCRornhAole6nBV/nY4TMAs08cTMpWYExHjwAiDKB4oTu8B0HGHRkpICP2Z+LgnopAn
         k8HYEhBuaUkoqyka3MPupohJYTqB04ofUspDvdnGKr50YJdVnU/19aKaaHqQq2VlnY3i
         UXpPIRDl0KIsZaeLYqUZj+naeNShP8N+7JlWp/THRL/i8QhPPNcOrliM3JgVlblvplmL
         +CxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794686359; x=1795291159;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kEf2B9QYpi3ckJDBCR/s09wzAUjGwxpz/3KtgUVx8/s=;
        b=DxS3+mFbzVwBFqJAONSwuXtcDAmTVcYu10i5Pi0L4dVx8PW7SCa8quALSlqvyWeZiC
         AhSxa1W08gooAcAs1nMlSC/x/4UYNamUTWBkH0LedcX2jR5s7pP7pLbiP3D1zdvr596B
         tzbRLMJ+j95EdBjVucqE8Pxw0ssGPEghiw01n17AsfLvUxxBoeHZiWNZs4SVm85R0JCF
         HgsNSiq5rH7X7MzUO1aV5NdxmkzejuMK8WtHOAhxsqK1IrOU07SoGvt4SzPbU0p3oD0m
         IfbseIX1tLetqKjCzmhtxBXZYkOeID0OU74n4IAEUqOady6PVf6+eTpQHHIVfQUMwlb+
         PmFQ==
X-Forwarded-Encrypted: i=1; AL+hErEO2/Ui78mmRgawJxTwS8lCV9KESeJ/TKRWW2uLmVvmE5I9uaWxTp9uEAHm4/0bZ6nm7kwSmYE=@vger.kernel.org
X-Gm-Message-State: APuU4Z81COQIuN6h6PnOD5EIBjjy96dc342i85B2rx7mKOEPuTPYkL9Q
	+B68MPwazTyK3BR5EepBaFVVi9HOyPjQm9pe5ubtEcOGMTtmHVF6MxKY
X-Gm-Gg: AYBFou1isi/d4mZED8CILO07MhaSEzxE8eUJ9cJVHFuR+IC3/h21Ppvo7xB461cVdny
	BJfqqMvvRfPcMtKgTOlE04lBFzU2mMvC2pAIzkzSDcqqKlgBHimiNIAJzCaCI2ODyDci2rgOakP
	Tt5BjbHpPtT2hwVdJ4QrKJ1QrCrDw9YzEa+vjFkdHJBiNz9kFiAe17aJa1+8Piar4e541FGD+Ye
	dmsow6oEDPLymUOCb2FyxjRYCAGL8a1PtpEUsvS3keFOdg+DIF5EBLfnT+T/C8G3UQB2PhBcpYL
	sEplEY0pFolm3+tt3RpKFVsXl1LGG87b5SHokNvGqNXoOJNGmmRUTL/LlvYdyNKduYtmtY08ynU
	E481NXf3k9MQzeBO7yAk/fg4kuq5Hxiiuq/oUVXF9SVCbD+h/dYpv0dGEPxXdo1ouvBl+RKjmSf
	YlphVeRH0ju+DItaGJr3SlLJa1Dy55t3WqQgYiS8o3O3xNLq8cNhfnCjpINSQ6ULhZdQs0g0XV+
	EBNdKKMfSrKw17RQD4fQzwNZYptxLKSEP5oOn3NtYs8MmqGPKfL2zWtYH9LeC1ikq5HhmmxBl2t
	58AhRK3aZ5mNwG5PVkn2tL/bUc1/xu7wzH3BpsAWEIVBTI5XjslMTJD4YQSLBUpahOfbKUJZq2l
	dStGFdVVHuXzC4R2G8vP7r54XAOuH41B6Zis=
X-Received: by 2002:a05:6000:3103:b0:48e:5cd4:aa60 with SMTP id ffacd0b85a97d-49c71783077mr13999489f8f.42.1794686358935;
        Sat, 14 Nov 2026 11:59:18 -0800 (PST)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5f782396sm12989691f8f.24.2026.11.14.11.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 11:59:17 -0800 (PST)
From: David Carlier <devnexen@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] tracing: Reject .function on the function trace event
Date: Sat, 14 Nov 2026 19:59:14 +0000
Message-ID: <20261114195914.2678414-1-devnexen@gmail.com>
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

For the function event, parse_pred() handles the .function suffix
before the ftrace_event_is_function() case, so "ip.function == schedule"
builds a predicate with no regex. Setting it through perf then
dereferences the NULL pred->regex in ftrace_function_set_filter_pred().

The "ip" field of that event already takes a function name, so reject
the suffix there.

Fixes: e6745a4da964 ("tracing: Add a way to filter function addresses to function names")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 kernel/trace/trace_events_filter.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index c10951bcfc5f..11bb751c4388 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1743,6 +1743,12 @@ static int parse_pred(const char *str, void *data,
 	pred->op = op;
 
 	if (function) {
+		/* Function events already take a function name on 'ip' */
+		if (ftrace_event_is_function(call)) {
+			parse_error(pe, FILT_ERR_ILLEGAL_FIELD_OP, pos + i);
+			goto err_free;
+		}
+
 		/* The field must be the same size as long */
 		if (field->size != sizeof(long)) {
 			parse_error(pe, FILT_ERR_ILLEGAL_FIELD_OP, pos + i);
-- 
2.55.0

