Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CD0390986
	for <stable@vger.kernel.org>; Sat, 22 Aug 2026 22:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787439311; cv=none; b=IGLVJxgnSNv6BYNKNPD5dC9g32vbp2qQ8WKLLK6LMqf3G4+BX7DXW8X5G7DMEnyOP80CjG+nimLQ7eaVRQWfwIP2gGQtIXCg4NRq4V7PDzupoQatJcK24GbV51jS3UtTLSWjKIteAqkRODsr4fSnKqG6DajgkCaQd98OyRWCapg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787439311; c=relaxed/simple;
	bh=kfsxWCDCTE3qKxnn/FzTQ6c6nt09AysTFKOlPuw10EA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YUKQKqPuZxMb/wQdBZGO5ea5gihxlneEXMC/ZO6WUi75S6Km2HAw0hhXt+kq30L/jdAXuAqDE9UAtJ/PT7yAXvCJzdte3IPlL2UjIyR5f5z9PWt7L8frtOH7ZEfzGW4qV6tvTWrchD+HUAIdLxlXlwmrWxZJ/s5Dm7Pc/kx/Rkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=swine.de; spf=pass smtp.mailfrom=swine.de; dkim=pass (2048-bit key) header.d=swine.de header.i=@swine.de header.b=LMmMFuKo; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=swine.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swine.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=swine.de header.i=@swine.de header.b="LMmMFuKo"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4953e04ef16so21315215e9.2
        for <stable@vger.kernel.org>; Sat, 22 Aug 2026 15:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=swine.de; s=google; t=1787439308; x=1788044108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lQ/+I9QQ3TX0N+j6Z35P9TmsQL5z9sD0jb/BpcutceE=;
        b=LMmMFuKofFhJiVJmwPr3Ryn7j2uV5dwTSIRay+SBxMyLpuMKdiRbhSWXsWtrg6jIl+
         +TzbURwUIbfuiHeooJtitgmr8YHiPA9S8119L+XXYbGhvQKUX3A9A18ubfXFCO8j7XeH
         1nQ0co+4MnXgzGNNe+tCw2o8buq5p9X8OVjQdmVSlZm2K6rinwjbcYTQTY1ebbmRny+5
         paB5m/d2Qq6HBMXuXcyF7pIggUneMe1zcD+pusw8Sa5c2tFjd6RcEFJlcctGdKbTJeW5
         UCpQ0jSy7JZTxZZMzeLqmAnQy5xrCkrtNP/HekERW954/qF2wb02TZ42s5YVRSDSuXBc
         c60w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787439308; x=1788044108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lQ/+I9QQ3TX0N+j6Z35P9TmsQL5z9sD0jb/BpcutceE=;
        b=iCvgzOTs6hZ2UPttJsunZT7MlF3iHaHDpc8/6pFxz7GQ8QgjiXgqjvoQxGi5bdu2J9
         iQx99nWZ/zzlCATerURRXBGrgycE7gta9x4eI2760W7Sbzg/ZEeSrxVjy0t1vd0Qx/ZN
         QkeaLpBR7OA19KkUzx/rD9PZ+wH3aNK1pd+jn8yk1piztWXIK5GVkeWUfH/Dm8GYlmIi
         chUKGeiDH6W3zn5k/rpT6/+asqlmF0OY3K/x6YazTJ6k5gmDW2aHwTkpVILgt/wCzPJd
         UPBJmMFCZt7rxiRKDutSiQu6j9MY1BuCfeLgiZR9TVCdmF3dWiaviPKIv3/zUiCQKdIV
         SvBw==
X-Forwarded-Encrypted: i=1; AHgh+Rpq4nFvK4EL1RQBlVltyhNYHR/CNQnKsfjosMPymBM4hIb5y7J9ka7VzrsMp3qAB5d0hgQLKng=@vger.kernel.org
X-Gm-Message-State: AFuF++mvvnCgFoUStaTG5RKItJP35ZA5v+uBKGn7wX/HoHA5/PFs1IhH
	mcbfg6a6AOSOSC+QhCcEMZXpOw4VhzVQeBEqqlPiLThvPKzR9mp+rDcnGofVGM9+7gw=
X-Gm-Gg: AR+sD11KBpCfoXV8zR7hl8Lkd+n+Muvr1kUA0ppN/vkG3iy4da0FKYvXEVkv4Ro2vMG
	l7Yh7dMolYynB96kgDqvFFyUPr0gX8Nw+r7pa65/+iscGYa5QEZcyMc97DP3AYcP0mx6mzDgvoz
	Meo0pl8aB9MAhAlLD6o/kifyTYfpGCMmtWAvbl+n6dqSkfA1TrU2+5RaZen3hTrsd9cGxo6zdkh
	ikvlQQJmvEwf1V9dX75Nmu8fCBxJm21FY9a5nmY7yL1HuO8h9+2d5GvTNAdVOATx/67e6iAC3DC
	QIRg5aSitzPS+DBTD4dTrQc8oRRbCYFtPgR5M/PCY6LcgtxeWRUYvQq17dSDuVhWlKBw2YyQjcx
	nXTviPbd+lN0x25EblPEBVUM8NyKnBOVRVe66efuvcA8mVXKZZVLPI3du1/2exCox/RwXLvnDc/
	NWQpu0GJEfyD4267qYc+oF8K7Kr2OdkzIf3Vls4m5/THl1GqCzclQbYm3FGG+OSPhdiBO064g/c
	kIB2GTtXLh+Dhk=
X-Received: by 2002:a05:600c:1383:b0:499:84fe:ca8c with SMTP id 5b1f17b1804b1-499b830dd98mr177591265e9.5.1787439308003;
        Sat, 22 Aug 2026 15:55:08 -0700 (PDT)
Received: from christian-gtr9.tailscale.swine.de ([2a02:6b67:d11b:4200:385d:79ca:2b97:1169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499b9ba5139sm41376435e9.2.2026.08.22.15.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 15:55:07 -0700 (PDT)
From: Christian Simon <simon@swine.de>
To: bpf@vger.kernel.org
Cc: Christian Simon <simon@swine.de>,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org,
	tj@kernel.org,
	yonghong.song@linux.dev,
	stable@vger.kernel.org,
	andrii.nakryiko@gmail.com,
	olsajiri@gmail.com
Subject: [PATCH bpf v3 1/2] bpf: disable private stack for sleepable programs
Date: Sat, 22 Aug 2026 23:54:43 +0100
Message-ID: <20260822225444.2774461-2-simon@swine.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260822225444.2774461-1-simon@swine.de>
References: <20260822225444.2774461-1-simon@swine.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A JITed BPF program can use one private stack per program and CPU.
Sleepable programs can be preempted, allowing another task to run the
same program on the same CPU. The second invocation then reuses and can
overwrite the first invocation's private stack.

Disable private stack for sleepable programs so they use the regular kernel
stack, which handles preemption correctly. This change is intentionally
limited to programs marked sleepable; preemptible non-sleepable dispatch
paths require separate protection.

Fixes: 7d1cd70d4b16 ("bpf, x86: Support private stack in jit")
Fixes: 6c17a882d380 ("bpf, arm64: JIT support for private stack")
Fixes: 156d985123b6 ("powerpc64/bpf: Implement JIT support for private stack")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Simon <simon@swine.de>
---
 kernel/bpf/verifier.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5e37ca75e5c4..038753ef07a9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5237,6 +5237,15 @@ static enum priv_stack_mode bpf_enable_priv_stack(struct bpf_prog *prog)
 	if (!bpf_jit_supports_private_stack())
 		return NO_PRIV_STACK;
 
+	/*
+	 * Sleepable programs can be preempted, allowing another task to run
+	 * the same program on the same CPU. Since private stack is per-CPU
+	 * and per-program, the second invocation would corrupt the first's
+	 * stack. Disable private stack for sleepable programs.
+	 */
+	if (prog->sleepable)
+		return NO_PRIV_STACK;
+
 	/* bpf_prog_check_recur() checks all prog types that use bpf trampoline
 	 * while kprobe/tp/perf_event/raw_tp don't use trampoline hence checked
 	 * explicitly.
-- 
2.54.0

