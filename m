Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFC9376BC6
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 18:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790618422; cv=none; b=HabsOYkWa0lB4BDsnz8lwkY29kVcoaTCk/yqDRefrHAahp9kflKMAjdMxd7Ot8KrGv5kCk4ygNaYDtJQ9Uz3DACacLTFxMMunEjplFUuBK1rjey2arhldDsdtTX7tXk6IKxGezY3XuFnSBEd9v56SXja1jWNwf0aP1OiF1olNME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790618422; c=relaxed/simple;
	bh=TwHE1+VhsQ5XKY1Hj9MwzvPvMbeY1bMfMsA8vbZSujM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JpMyx0wrhR4e1Wxb/wRaGej3i17IYj3jLH00Aa7p8VJQDDXWLvG3ZwXNN2uhPJ1UjADU5daP/NR7pynGUZo1LzOwg42/37D/aIx0p6AppuFZB9hS9J0XTZhW19hxS+WJgVx+YL3lFzUWbTiP8IxMluWf9QINIX1MsHmf/GiUzHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NgaeOdFn; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NgaeOdFn"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-341d0522b4dso5187080eec.1
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 11:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790618420; x=1791223220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DieX0Rgvybq5PC5vgoqcCI00d3tmhTbfpgMnkn38za0=;
        b=NgaeOdFnfWAFGb35R+u+I8q0S3V1rEKc9TVgH18RvBDkA6MhqKhRnCIz0nMNLxHXdK
         VCsjlt+5+Qd3pbAu851+Nre95Rr1b/5XcfoBcXR45kaxwjay9AhqtFJRV7o39vuPi+fm
         V+eXKLfg+jKB/HKA27OngtLOllsS7GIwL4XzCfNOb98IDsanzunuItxEjMryY3PIGYUD
         Z0vljWIeIRMeb5bUAKibqJGHY9H/5Z97ffnnFYaFOZLF2NWpHEuoBY3e7M6JG3Kf/T2B
         eRl4UIjrl0+J4++ylgOV4XcGG/0FSuwyePoWrFIrBYAz9IL/zv/D2z+F7YoVNfz96OFn
         u1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790618420; x=1791223220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DieX0Rgvybq5PC5vgoqcCI00d3tmhTbfpgMnkn38za0=;
        b=frJqo1cMH0SHWAURIxkdopEWu9t6yY49nOE/gfDIHCPOAFEKYbXddZ6m2HMVAKgkRb
         Ir6Xi2fImAMRCel2yhz2Gy6YLFc9iH9yizaAl/cPRDf9FDv8yn9VrzXI4e4RByiFnYwx
         7IwHsPTnHgTF3x0l3QYoa1dD8Xn5iDrKoNWheHzh8J8U4rs1vtmsCDRztCR3LHNjVwgW
         ewVg+BP5ha5QUcyoW/dsxKE8GU1n/5axrRt5g/9KGD5UkpAwxQStmMVauRyRqQExG0Mq
         9+mwvfAQfnP19z9IMmDUWMu1f5gFUHvaMFYPB//xbvcRFNJhsLLsG83wLXXU0lZ9eo02
         uJiw==
X-Forwarded-Encrypted: i=1; AKwUvBwpESt8xYN+qWpdQ0A0g6zj2+Wh03HvneMQPsjxgnwS3AUVvsitHOINVscFZKxHIi4qji58hoA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJsJy9TqzZY/IxOFgcBw3lvv5Ojk+pgpyPzOHCdq9cJvbSM3htp
	bi8ju8VQG/mO23O+8JcWGLFODMzqMTRXTfhaEWyz5XvCKu0XoiSdvr1w
X-Gm-Gg: AYBFou1VKHxEFJwJZRskleMm61yLd1bfv6EWMrhv84In43JWT+3GGtJa3J7MVbMJNT3
	tSFXW4xdD8+vDK+bJoJr/teQ+XW4E+/hFudUTaKgNNiNn+NksrUB5kNK64eiSQqzn/RZdvjZeuF
	pLysdhcB2MMJz3qOZKL93yklfz6xNe3Qko5IkiOKbAApemiin2RXuAA4QppFXR/PzMlpCrsKzR4
	IOomwEy558shBIZYx6SLnT2UMlcOob8/Zj13xzFO/lLVkVGJNKswRg0mJ2BubbF2ds9LDudToLF
	vAfpHovSDWeQNqyUzI6A2ozdgfoFoKDF59H+6kjrjskkJ48pBjOShuSFyFXpvB8r8urzkBeWyfT
	2kSSTtVFwUdeu5kmgfKFatwOY+WBIrQovA1s5zOXgyGG8UgZeFHWWvJMfhfCfDvpKklcm4/Tqz5
	82tdr2SIpd4gPDlzbsByfSmhGw+4E/pdnCJgSlpCV/aaMvknjY69GOyX7E4rUdYVds9VG/9JVQw
	Tp14lzXFQ==
X-Received: by 2002:a05:7300:6810:b0:334:2bee:348e with SMTP id 5a478bee46e88-3427236f2bbmr10854353eec.22.1790618419897;
        Mon, 28 Sep 2026 11:00:19 -0700 (PDT)
Received: from kq.cs.ucr.edu (kq.cs.ucr.edu. [169.235.27.223])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34144b4ae50sm29808542eec.17.2026.09.28.11.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 11:00:19 -0700 (PDT)
From: Zhengchuan Liang <zcliangcn@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhengchuan Liang <zcliangcn@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/1] perf/core: Require kernel access for text poke events
Date: Mon, 28 Sep 2026 10:59:35 -0700
Message-Id: <99131354c41e23188f778b92f90363775b482395.1790573390.git.zcliangcn@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1790573390.git.zcliangcn@gmail.com>
References: <cover.1790573390.git.zcliangcn@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Perf events with exclude_kernel=1 can be opened without kernel perf
access. However, exclude_kernel does not suppress text-poke sideband
records. Every PERF_RECORD_TEXT_POKE is marked PERF_RECORD_MISC_KERNEL
and contains a raw kernel instruction address.

An unprivileged task can therefore open and mmap a task-local software
event with text_poke=1. Both opening a count-only tracepoint event and
configuring UDP GRO for ESP-in-UDP cause updates to inline static calls;
the observer receives the relocated addresses of the modified instructions.
For a known kernel image, any such address reveals the runtime kernel
text base despite KASLR.

Call perf_allow_kernel() whenever attr.text_poke is set, regardless of
exclude_kernel. Events that neither monitor kernel execution nor request
text-poke records retain their existing permissions.

Fixes: e17d43b93e54 ("perf: Add perf text poke event")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Zhengchuan Liang <zcliangcn@gmail.com>
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 634d2ccbab82..b4e6e8ae3be7 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13953,7 +13953,7 @@ SYSCALL_DEFINE5(perf_event_open,
 	if (err)
 		return err;
 
-	if (!attr.exclude_kernel ||
+	if (!attr.exclude_kernel || attr.text_poke ||
 	    ((attr.sample_type & PERF_SAMPLE_CALLCHAIN) &&
 	     !attr.exclude_callchain_kernel)) {
 		err = perf_allow_kernel();
-- 
2.34.1
