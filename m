Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B2736404D
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 06:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789970430; cv=none; b=tLeoYB+nVN8cGbuaFlM4/mUWu0A+NxBz8CtYhXZkP1V3Y9GMEjNIgaCCIqrVTGHvwe23VDlAkglvXFodVYg6OzfMVGMJLJQ2r7m0i7shB101zXr9M/0mObRVloXNhtY4SS4eH60+eUXlk1jq4rvpn0F7Ls01guseKtPsC9rtSkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789970430; c=relaxed/simple;
	bh=onN4wmQ3R+mhzbGXit5pCMgHTHvfkzs4ty0N89GJZJc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lRj8g1XoXXU6d0RJnn0BsSJQOAL+zKhcLFccWoAjzmt+sl7/WISZe6usAhDS3kwj6yB4wwXUl3t+YoUAahAQk4xf8dvqaniBrHYPlLV099UHBm/buGRCL+NNKwpMz6PaWz1w+tpIUTBGmuxhZcLRHhjtAvDMmF4gYrDIaQHFf40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UIMSILDW; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIMSILDW"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd38e0f79so13532695e9.3
        for <stable@vger.kernel.org>; Sun, 20 Sep 2026 23:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789970427; x=1790575227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ro+FMNk45PgRPb4vSmer/o4ptFIHYgVUebCic5ooA+w=;
        b=UIMSILDW95dTr7Zqpdx86bv8LSj/Ipmu+xNnhn5Dxi7eDFHR0kUmkxrT4Z2YIWqDzZ
         tuZVHSTM0/gPChRl+ieQaCBWz0FLKmyIAD2rKPwj6JwTdPxAuWGAwpGW1KrHY2rIi8Oz
         ZbZEqy0yNVPkEzA4TjMONVrFbxUHeGKrB8G9Ribv+SrK2F7rCPsAuPzdW4IT/nbqUvSU
         0k4q2+sO5JPawTPlG8AlTWxvPR/zlqusoFW2VRIKSD8fkHz+akxdJn4egGgpC9VC3VSy
         dk2yZMWVELihDW4Hs/N3dRFJb56oWszzp4rKt5CdePZSbKe05cYzPhvD9xh0d7z21aUZ
         qjgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789970427; x=1790575227;
        h=content-transfer-encoding:mime-version:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ro+FMNk45PgRPb4vSmer/o4ptFIHYgVUebCic5ooA+w=;
        b=Y7eScbVT1diUIfVMH3mn/G6+EIwJQSxPofM/+u0g/Ys0b4K3krOGQs37LKXV8LIFVT
         lFDDDDys9r/2K6wTZdBCtcoIqk/v8qfOhlyFzYViDv6Ty1o8AUpmHiKpl24VDHDh76sE
         NmxhGJ6k2eJjVKN/KB/ONWh8zmPmVHo9Rd1rl0r7UIvTGTRd/slWx6Y4c37rnSxnvNcy
         wYnl6ukel9SQ2Pjmf6C8rO7pqxpfCYBLco3W4CJ3ghImsjk/nL4t2cbABa3Y2A40rDvk
         Mf0X41x3eulzoGGeWFkzayRAX2u/6MnHBV/cmjP6p3fDiEXcHuJXlxvLp8lcXIbC5LUV
         oc2A==
X-Forwarded-Encrypted: i=1; AKwUvBwkk6LYDxudUNfdQDiCO/Ow03G7LNo6eeDjgxlurPwnR4LFeTbEayMiL93tS6Dwq6lnqlLOmLg=@vger.kernel.org
X-Gm-Message-State: AFuF++nDWj1QU0HaNZLOYLgV/Ygs/x5zBbtWDF4TjTCYBPaWDjZDoDau
	AF4/crKOyggwEhR0cGrJp86XPN/5fCSrvR92B5bR6mE6FQr7WGlmUcnD
X-Gm-Gg: AYBFou2BveEH3Bt/vBMgMtIru8qR8A2sqExHLJc8j9ntgJ7AUdcDJqHksfiTRbZRcAS
	/0JRGT+fGtw0LqRNws+8BcjgpRFKTBHPhPzUr2PqUrjOtBcRRhJLssFIQGhghoxp9pKu9OvOGeg
	XaDCdHO5ZwYtTdL2AAGmRla5Yw0MN2IaVAoDCrtSQl5FbqQ/ClqW8HCFq+n/rhqXs8QLQHJ6I8/
	zsC1MIDHk1Ry6jTBh6oHcdusHOKEThjHR0AHDH7rs2pkYCMECq1Net1V1gjphJy9yMU47eZuaEj
	dbu0+AbOkFxQg6zJdI4FcxfjwAEdVSrvR56Bpn6ujH0aM0siplqqfMKmbD9eS71BqD7vV0L9jTT
	3/FzbEr5bzzuPkDGF+yM7Gg2L4N6rwmgdkY5MGQm82bEToeHAywz0tPIdrSTzAkovVB7G/CtKi0
	/Mvey2D1CfO5tfFSx0A52d8/ppIxAE4HrbimbUy3i2Y/TBovrhs7RuzypbfRKJxXEzxMjHX0aOj
	HoXV7m0xZIqP4o/or/lFA4EgMmVVMA94PHxy+Xk1NCTYyC/KsI7lha6zIJrv/csPMhqNJfgcmvh
	vskT3Jb5zPu+y+j0HeL8tBtZdq9vcL22iabVXLCYgQ71NMS4WBIlKe8kSvNO72enRNvNURT4+fZ
	5HYH6Qs+IVnKj
X-Received: by 2002:a05:600c:6305:b0:49f:c2ef:cfb9 with SMTP id 5b1f17b1804b1-49fc56719a8mr103694715e9.4.1789970425753;
        Sun, 20 Sep 2026 23:00:25 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a8e9-c501-f941-243b-87f6-e5a2.310.pool.telefonica.de. [2a02:3100:a8e9:c501:f941:243b:87f6:e5a2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd1149e0sm198706585e9.13.2026.09.20.23.00.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 20 Sep 2026 23:00:25 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Sudeep Holla <sudeep.holla@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Linus Walleij <linusw@kernel.org>,
	Radu Rendec <rrendec@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 2/4] ARM: cacheinfo: count external caches in early_cache_level()
Date: Mon, 21 Sep 2026 08:00:11 +0200
Message-Id: <20260921-arm-cacheinfo-v2-5892c4531ad9-2@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260921-arm-cacheinfo-v2-5892c4531ad9-0@gmail.com>
References: <20260912195552.76673-1-kmehltretter@gmail.com> <CAD++jL=7OSrPMax9GRj3D7ehjmmG2uMyws53F8U0x7YGx+RNOQ@mail.gmail.com> <20260921-arm-cacheinfo-v2-5892c4531ad9-0@gmail.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

early_cache_level() counts only caches described by CLIDR. An external
PL310 is absent from CLIDR, and its arm,pl310-cache compatible is not
accepted by init_of_cache_level(), so early allocation falls back to
an incomplete count. init_cache_level() later adds the DT-described
L2, forcing reallocation on the secondary CPU with interrupts disabled.
This defeats early allocation on PREEMPT_RT.

Use init_cache_level() for early sizing too, so the initial allocation
includes external caches described by the device tree.

Cc: stable@vger.kernel.org
Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://lore.kernel.org/r/20260912195552.76673-3-kmehltretter@gmail.com/
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Fresh full-series rc1 retest: three builds and seven QEMU boot/CPU
hotplug checks passed; see the v2 cover for the matrix.

The detailed testing below was performed for v1, before this rebase.

Without this patch, patch 4 keeps the warning on QEMU vexpress-a9
(4 Cortex-A9, PL310): the early size is 2 leaves, init_cache_level()
wants 3, and init_level_allocate_ci() reallocates on the secondary
CPU. With it the warning is gone and the cache sysfs tree is unchanged
(L1 data, L1 instruction, L2 unified shared by all CPUs).

 arch/arm/kernel/cacheinfo.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/arm/kernel/cacheinfo.c b/arch/arm/kernel/cacheinfo.c
index 860eeb03cfe5..31591c947254 100644
--- a/arch/arm/kernel/cacheinfo.c
+++ b/arch/arm/kernel/cacheinfo.c
@@ -111,13 +111,6 @@ static int detect_cache_level(unsigned int *level_p, unsigned int *leaves_p)
 	return 0;
 }
 
-int early_cache_level(unsigned int cpu)
-{
-	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
-
-	return detect_cache_level(&this_cpu_ci->num_levels, &this_cpu_ci->num_leaves);
-}
-
 int init_cache_level(unsigned int cpu)
 {
 	unsigned int level, leaves;
@@ -146,6 +139,11 @@ int init_cache_level(unsigned int cpu)
 	return 0;
 }
 
+int early_cache_level(unsigned int cpu)
+{
+	return init_cache_level(cpu);
+}
+
 int populate_cache_leaves(unsigned int cpu)
 {
 	unsigned int level, idx;
