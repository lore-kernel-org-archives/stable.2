Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793173648;
	b=a6/nPDkt7gGbFX+WS2fjy6CqGzS5KEKTRjhI3QTnRioewAkFjOg35E9/NiQfYLLLvn25
	 m+hnMCIyo8rIBWmN1ejcdV7CQbd1xHtH071E4UrLSBMxcLQh+0usWKGGPXou5TJ+r1YIi
	 k8SSj0LvZdrGtml4DzNouuPQWW+OkwR/DLDzAIWTRfh+PgbNQgbZo2d+954+ZcpReL5A+
	 mUE8RiJwG3gQ1cX2auTmYkHuddyaJ93SyA5FHNIiXorgDQBDDFPKLND5sV52cpMXoeMPF
	 ZfyAW/DP66ncn5MxRswS6zuuCraACyPLZwThUdq+WHnj/5woD9zgloEWuGze+hoybcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793173648;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=8idl/HtLxFU4RXc5SRlZ1K4xdbzJi8/5nFcYdaBFYqU=;
	b=OZfncC7Bwnh8Os8d9rbG8rAZOUsbS0p0jZ8jrFczezbj7jWKig4352PFVNDnztjdM98F
	 fW2M8MV90tkoHUWmFimgANWfGyaM9UYXicwg9rqkb8s+80Gh8gYTqRBuEQvIjvPO/gP/a
	 ZwtkvxgSemUKpWMZBsKsxl/GM5Rwf04q4hY/0FRh2wh0cjywxJP09t8PtY4KJml37eo4J
	 jh9Z/sRq/usAKo8kIvSQe2EKkE33+rHasyk2IE8WYfu7If8Qq7ugZ8EIru0knp/x5yOQP
	 Hot82BvvobGYIFsxljQAfalLUrKv2YKGmxMYNda24/Qj8JoEeLCKY9PZ3MTfRYwSlhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Fvuj5PzM;
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6141F606A31E
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 07:47:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6141F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Fvuj5PzM
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cdab6ae1ee9so350717a12.1
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 00:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793173648; x=1793778448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8idl/HtLxFU4RXc5SRlZ1K4xdbzJi8/5nFcYdaBFYqU=;
        b=Fvuj5PzMLnp511zUOuXtW31L3gHSh9Oxmyc4svNtGfRUcaoB9SyzBMYNXrIyReUD8R
         Whghg1MpP6ft4GuJiOnRvlfr6lvlXmDN9YG6M4RcQva1FVa07hw2SJ7cAYVMOwUNMeq3
         kh5rreu+mGVhbp4ng8GL/xeiP0UdZT4oBVoJyV66/46Cgxxy3YR/EPb4yrULEfa1DwX5
         +bwlDpN6ntqqPY9dV6ceqJMrW/uGjUyvpA/w5Dy5PFaJKtQQ0GNPrZBjoF5/yIuLBqeD
         pJ1AGvboT+IMFxKUjVJE66tLc4mO3VSbzw3IRtfIOHFwYRYek9V6l+RJ6YnZ52pj7iBI
         7hmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793173648; x=1793778448;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8idl/HtLxFU4RXc5SRlZ1K4xdbzJi8/5nFcYdaBFYqU=;
        b=hcydFVXvCkbfo2DE/x+fsatXTGFmD/7lmJfJQ5R3viBxVTA2UEu73oCG3AmTGurfxy
         Van4g1sn534K0pa4vb8f8M3f5xBpUILli2Mk26PDiW54ksp1XYR3A31XMIg1eywSXMch
         cmyqxS91zDRX7XTUsP4EA4yfO7FPNRwdz5nMTS6GLSR0m322D7GkBLTCWywLW6A4uWe2
         RHPUnioJRHByRmklaFWIMKHp3+FRg3pr2xCmgS6CJjvVTOb35ly2yPy7wh0wQ62KxXpf
         Nph4YHa54YG00SS0MTRCjSuU0U6fSWczoQeTI1SC7tKjqgAEMe9XS7X8jG/5EXUm3X1E
         oxbA==
X-Gm-Message-State: AFq9FYLnchghNj2JnI8bZ1xoXVpW/SOa6BLgnkS9u1AEUdt40WI00Hos
	mXJmIjs9LAFQSxUjk2lILp90O2mh0AbLIACi0xP3p0QHv4SBu1d5Jim6
X-Gm-Gg: AYBFou3PWkb4pqz3elRi/nuYJYHAIa1P9fnqbDBs2LRccKgSgCj3GK67vyi0S6huHL7
	2ALuO6nEQjh055YbK3YUxBHoGUetLEidHKCsko2H/WF2DguEt6W/IEprpYw492h03HvfhnVfKIj
	AggprjiSpov/Z0FCY8y+yAZgOe+1S47+SW9JNMmu+UGp3OlaHASmt31UY5k5kD1zpwSgSBEZpmo
	TsoXaF8FYfKGo/NCmPnik4spNbhan88rqWmqAEunvgU4IYvcTDHP47PyXzsIeRn5Xz0B1xKZy13
	3RLoq8i64ysEA6vTLGBze0cNqktvA25cUYiHr2BfEn3uy31uHxdpPhTiGuifZUSyTtF0ty8qIpl
	6+oIsuLebj4JdcV29DeoOL3I1KylMYTZISbAvWogpgEV+Y/rJRa/8fCU+ocXTaN6+DMAUKJ/MWK
	5lRviEG47xQuGHhurNl9Y+h/Y+guu1fYGIHRuKiUMvyoH1KZBLx/wl5pUzohWqoDC93q1k7f+VV
	eH48WuhOJcNhOv2oFg+vPjebJdkI75wtmo2OJ4TTYDEhHcqPyYqj4+t5eMcBOJ6YPhEVy0E0jaP
	j4FcVXOdo/YBJbLXCwBVV7WBEN3G
X-Received: by 2002:a17:90b:510f:b0:3ac:adce:60b5 with SMTP id 98e67ed59e1d1-3ae580ae38emr1000839a91.14.1793173647649;
        Wed, 28 Oct 2026 00:47:27 -0700 (PDT)
Received: from localhost ([182.216.53.174])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae5a27f7c7sm1941127a91.2.2026.10.28.00.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 00:47:27 -0700 (PDT)
From: Jaewon Jung <jaewon8868@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tom Zanussi <tom.zanussi@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>
Cc: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing: Avoid undefined shifts for zero histogram map size
Date: Wed, 28 Oct 2026 16:44:54 +0900
Message-ID: <20261028074610.2212374-1-jaewon8868@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Reject size=0 before calling roundup_pow_of_two().

include/linux/log2.h documents roundup_pow_of_two() as:

  - the result is undefined when n == 0

With CONFIG_UBSAN_SHIFT=y, a size=0 histogram trigger reports:

  UBSAN: shift-out-of-bounds in include/linux/log2.h
  shift exponent 64 is too large for 64-bit type 'long unsigned int'

Tested on x86_64 QEMU: size=0 is rejected without UBSAN warnings,
and the histogram modifier and parser tests pass.

Fixes: 7ef224d1d0e3 ("tracing: Add 'hist' event trigger command")
Cc: stable@vger.kernel.org
Signed-off-by: Jaewon Jung <jaewon8868@gmail.com>
---
 kernel/trace/trace_events_hist.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index f39fa8942673..3de794c7f5b2 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1430,6 +1430,11 @@ static int parse_map_size(char *str)
 	if (ret)
 		goto out;
 
+	if (!size) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	map_bits = ilog2(roundup_pow_of_two(size));
 	if (map_bits < TRACING_MAP_BITS_MIN ||
 	    map_bits > TRACING_MAP_BITS_MAX)
-- 
2.43.0

