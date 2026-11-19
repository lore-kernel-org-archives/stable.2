Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795075303;
	b=NIcj7V5UfOkpLEvnaw9A4So2nXEMClbZFkzWv3ZAv+5zBVTySVNYSwGL2cQZIB3zWw0U
	 lvyrlcxKb/P9hwjNWRWPoddnquIMtbG72g6yQrVCWJFXUafKCgmEkPdgRydTgfqVv1zxO
	 FeOphHBKoC/gbobLLvmknhKqMWSX3hvY2uhFFbanRBr7aG+vkng0MccwPbXyQXyV62B7e
	 9KFYp74o0PxuclyuZptI/FGFkT0U9Qd8fKL7BUDoakRF4eK514weJG5Seq76RBftigzRX
	 iExAI1uzRalo2D41m4nFs2MzckFvsVUFAj3enGAo4A+zz/FUDLCoq7v6xWDq6T3irXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795075303;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BI3GiHZy5PM41ztBgWptxPosjP5yVUX7sfT56sMb9/k=;
	b=GwQeoQZeNwk2KhieTNnKq+GGXps9Ori2QeH+t52B8gGk4ehgZsctBq4Sw0yeO8BVLkuv
	 JBTBk0R3Ev9lNzbjFOZ7fgXDQWiGlOh87W42ihbFGbAZcSFyGcaqwU5H019AadaIk1Kwu
	 makaihSsEXgshxu4zgvNyr5SBvfIt8h4pNa4hx2Jm5ic4IdCbTL21xjm9y0hV92pDZzmA
	 4wLarofgjB7A8S9VgRLszRvnwwLhoz6ukxyMvK3hjKeL2bT9W7mjsBbboeTJ8QQp14LPY
	 KMhtlssPlrUBfirZ1HSV//y0Aizn3GDzIe+9el812fQg7tULTEDyzBCxymSwuR3EcNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bMu2ZlI2;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAA6606A324
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 08:01:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DAA6606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bMu2ZlI2
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a5177d78c7so16598005e9.2
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 00:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795075301; x=1795680101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BI3GiHZy5PM41ztBgWptxPosjP5yVUX7sfT56sMb9/k=;
        b=bMu2ZlI2o6HCtUAxMfEv1ledyJ03bapITiRAATkmdTsD09Vx/yhmG65NF47xEQyFYM
         yyUHFv/l3p9H9os8ztvdv5Y0xu28YstZXhjuJBo13XU6nqBkRVl4YzAehVMUsAfk+url
         wRi3jJszRTnEDG4/Zo5veRySKoTFPrhH/rByARHkF1AQKsJkrHSZRR5FW4O1AwClPeZ5
         rZoWQ7RwrOLHbxRYnc1bRyGj5fGgHJ4liIAbd3FkXKhVdjDdZFkLMn7bcbQGxNBr5Zqz
         z2DvuN7cJShasX6d2OmreaIpVZUSKLYyB8mKk0ACrEbp86SLBarcz32UGenx2mjGds38
         M/8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795075301; x=1795680101;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BI3GiHZy5PM41ztBgWptxPosjP5yVUX7sfT56sMb9/k=;
        b=ZlMhZkrsnMTZUeZtY5Kv616y0ZXte7r9HrEY6fnUHzjN9bC0IIAAh2PpWh+m6pQiT1
         bfa+Lm6Gzm/TKz++/2ddtJaoaRf1ZUaK1TJVruHDEfxYX8w0PI9EPJQSsIMA9+LGxOuR
         XORx7TrFNGqXwH9Yo0sTfr02OUUfHI1N0nkEu9l8mtKFU2x4kFgMK0qNcJTAbMMMgJJu
         qc76GF7BmUvStTcnKq3/4DLmIdCZe2wGtEOIwLWQ8fpUWsLT5zUUuVzKw/+7oKQf19WT
         zp0Zgh6tFSgOeADXBDcS3uikCnuTCakdjdxtiUjEDt3FFBdj5sV/o9YBIi7PLPR1/kAj
         Q1CQ==
X-Forwarded-Encrypted: i=1; AL+hErF2+XxVxTpKPbA13FKzNaCfYTn8ud9QTtcun+0MukcLiZaLlm/VJINQyT49Bjj5JldBrvnr2h8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8eFeMOpOGozetWfIoCNaUr3WMbbPM4JCDi/ZQ3qprjSJzBEgb1
	ZvXPxcWPdtyvwROIgca3xuNvIt33ESeSwOUlSgb3gefmiUyELM5n9Lgf
X-Gm-Gg: AYBFou2/tNetBOSzYet6yD+e1DhSKSpDlblHUqHtQW1sZG307bzehw41nkC+P1YPUys
	pIM8ujfbq/MkSH1j6ADQvNnDi+gTTvuJzr7b2RlXSG16GDDLwWng51BKKdBJE25rGTF+Vd2o+0q
	41y+uknLg0qLFoITlIANuD7z3+Lx8LNGZ4P7LQ/GAwnE3ASvR29Ar46yViam/TeTybnU88f90yA
	kqaZwCSybHAMaDV9lMKA3X25ms68O5Z1b0KygdF+X2EMFevTdwHtDkVTKLcqWDSii9wJvTjsFhA
	ptN4sv+rPbCohXIm8CLYS4kcOUdI+1swNui7exvK+VcK9UY+y3cRgLiA0IWnmOxdJcz4CrC26kF
	nlugLmSTLnt3RKBzDbrB7GAsAbdOqRQXcyXqm8eRhb4Qpona0hrEMQyKwrLuEU9VKqKo9zkxNGD
	qlNsr9oiRWUhEW/O9tO8Za3g2lJ1UWQtMFzx2Ee5lLQdPty+RjMRKAw7ojmaswQv8bNtLU+UAgK
	oPoFti9/+KMC+a7dlXIc6kB2N3NWrlM5e8FwDGBOZiSpeKIivE5C0Pi/qbDNs6xHuqRk9kfcKE8
	jr5iDnhhyyhl1lVAm/9xiqYbI+ayQow9fj4CoyaZ8EuoMDvRNowFCEgsRFKywxF9pGlhXKbTgnt
	idJnUZQxnLgNUpQ==
X-Received: by 2002:a05:600c:1396:b0:4a4:4d57:8462 with SMTP id 5b1f17b1804b1-4bb7da21b76mr103724785e9.24.1795075301248;
        Thu, 19 Nov 2026 00:01:41 -0800 (PST)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb84e50512sm11628805e9.3.2026.11.19.00.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 00:01:40 -0800 (PST)
From: David Carlier <devnexen@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Daniel Wade <danjwade95@gmail.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] tracing: Ignore .function on the function trace event
Date: Thu, 19 Nov 2026 08:01:39 +0000
Message-ID: <20261119080139.131834-1-devnexen@gmail.com>
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

The "ip" field of that event already takes a function name, so ignore
the suffix there and let the function event case handle it.

Fixes: cfb58e278c6a ("tracing/filters: Dynamically allocate filter_pred.regex")
Cc: stable@vger.kernel.org
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: David Carlier <devnexen@gmail.com>
---
Changes in v2:
- Ignore the suffix instead of rejecting it (Steven)
- Fixes: points at the commit that made regex a pointer (Daniel Wade)
- v1: https://lore.kernel.org/linux-trace-kernel/20261114195914.2678414-1-devnexen@gmail.com/

 kernel/trace/trace_events_filter.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index c10951bcfc5f..2bbcc2abe794 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1708,7 +1708,9 @@ static int parse_pred(const char *str, void *data,
 
 	/* See if the field is a kernel function name */
 	if ((len = str_has_prefix(str + i, ".function"))) {
-		function = true;
+		/* Ignore if event is already a function */
+		if (!ftrace_event_is_function(call))
+			function = true;
 		i += len;
 	}
 
-- 
2.55.0

