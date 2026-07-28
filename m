Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB2B447806
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 13:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785246700; cv=none; b=YgHzFtqTwj933Q1wM00qeJDlnfVOCmdmxFHo6JKN1OA+R+XljXWbm/t49OpxP9MKTNIV2wtTV7Lek4u2Bg3f9vkasBmVC875lw4UFs/0+lm9rIQjTYBx5QIaD6kRKUyTnDWTwMIX69jN1yvGsuI0VmaMttNaXcFFk6tZG5fITOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785246700; c=relaxed/simple;
	bh=r96kwzBIc8Jied5GwHDPHGc6xnmckXwOtOi28k4xvZA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fUSoMpyMZQJCJN7u9Ll1edbPcXJEnLegSKUAOkFrvYbpQSVWxZsZp7kHV8Q364vs984O5ZfYfsFC3oxGZZFz2UBS5K99JGZuLeIhohuZA15/wjTSs+UWJEjEbo/Xm1NIJUDxVkBcT4FCkMtoWSYCboFbSnt+tylvKqEnNGqKSs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ax3A5mLe; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ax3A5mLe"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4954d383e64so23887115e9.1
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 06:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785246697; x=1785851497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cY1+qecTjpPQDXB5WlxHN8z+3cpmFqILEHWinOpbPx4=;
        b=Ax3A5mLeAEyA7q5K/8vfR8LVAp3bY42wrpuDezFir6OEKSRhCtHQj0KpJNTbIBQsoi
         LnX3RE2zyUUCLYgcLx+DkQ/x6n+v0RayBP71xwYraS3wXzZuufASj+xGL7gGe4qpgaVo
         9cPM3VlAfjJvBmg6OdS2Ch7Tk5TFdUejElHXvtRHPbzhLVYxjDtgBWlFFFjkbN50rIHk
         38Nnuw57aVqrmfpYJgUgC502fFEyQGhiaDTRbwMSvgFpM9rLZjcwzx0bmGMzBIXEgiFm
         wPwEKtFTLZWfvqaWqNWjBSMBoa9W+w49eB4z04PaGBeQFEN8BwRrERnj3kHwwZCa0dMy
         nvTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785246697; x=1785851497;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cY1+qecTjpPQDXB5WlxHN8z+3cpmFqILEHWinOpbPx4=;
        b=KMtcAiIpjIGRE5qT0bZXnLGCrVMfWYfT9AhGkw5I5s0583hDl2ph2sRneVE+1DItqp
         vbrTunFx9v36xBeXrJrpxUX6+EWDPu4OsWoR2HeAKIgdTa9iQdI6LCGXLhLIqQFGr/dU
         kTjlC8Dfxggm54Raelh1YBaVmXG1ASRpohYP+DH7rcXH1oJitLW6qovRmmFzdZWMvWkV
         pFafJJVLgvIVYxj5xcbaSSeyNSOe3dFLWA6pIg6KNJBkMNpoorUte3KOVoHvuH3FVjRe
         0vNXwykWBfYKd0as96wZhuygcXJxENuHia81yvwJ5REbv0Hgh0iwnNqmwrQ4AusPKoGY
         lvuw==
X-Forwarded-Encrypted: i=1; AHgh+Rp2XwJI1SYiSYCwFe4FulgbKfvPhy4V2JkkbVvgEySG/jXQ8iwglT4MHMuQBY6++4xW9n5VDnY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv7Gtis3BK40zkgJcN9bjip4gGGmI07iPX9K37z3PDCfO8dnEE
	qsKiAQFlVKwI2GygEFL5fEh9jvRJTNALkK0nW86bS9SHppAzd4rWAREn
X-Gm-Gg: AR+sD12BtUNtPT3kQc4gE7+HIjMPYdUAjC7g65Mu8RQxIAFn9VRSrm8He09Opy3iwhK
	s0AE8zNvlryeB9QM3eD7UY+apOwGJoPp0f2nTLPaawSIQ98dN0gI0D00mCYTcWYFvOqm91FmGqA
	45c1rJobmBzdsgbN33jK1gTwOcSg2LGyp6qXyBr/Gxfhd0U03oIQgd7v0LxXtJUIVcLHTeHSJUO
	pKw/4HjJq1GFG1Wp8YUhKILWJEUUJ7Hq1gpThhpVEqndQ6arNzDYymYhUaal0/Q9G1PjLMMTIUd
	4HbyZiI8jgjhhPbvrApeZC+YKZq+v4kkcSuLThqH5jRbnIOxwOkAuCXgrZiqTGA0/X07w65ezBV
	BRarZvIGIsghbLAyo82o08DN8KJagWgpd7eNYmn1RxuKf+BioAuFEyNyKSgNrVlD6jXJ0Hywtz2
	xam433cgwd+0UOG4byi4fseIXJGo8t9ekhjPawKuyvb1GhNVn3aV3pI2aVS4WXNIRY8Q==
X-Received: by 2002:a05:600c:1391:b0:495:4a34:16d9 with SMTP id 5b1f17b1804b1-496c65ab4f0mr26696655e9.31.1785246696724;
        Tue, 28 Jul 2026 06:51:36 -0700 (PDT)
Received: from fedora ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c6dc25sm57125898f8f.33.2026.07.28.06.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 06:51:36 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>,
	Herlangga Maulani <w1zardsec@proton.me>
Subject: [PATCH] Input: raydium_i2c_ts - propagate device info query errors from raydium_i2c_initialize()
Date: Tue, 28 Jul 2026 18:51:27 +0500
Message-ID: <20260728135127.48971-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

raydium_i2c_initialize() calls raydium_i2c_query_ts_info() (or
raydium_i2c_query_ts_bootloader_info() in bootloader mode) but never
checks or returns its result. raydium_i2c_probe() treats a zero
return from raydium_i2c_initialize() as full success, then
unconditionally allocates ts->report_data with size ts->pkg_size and
registers the IRQ handler.

If raydium_i2c_query_ts_info() fails on every one of its own retries
(e.g. because the device is still completing power-up when probe
runs), ts->pkg_size and ts->report_size are left at their
devm_kzalloc()'d default of 0, and ts->report_data is never
meaningfully allocated: devm_kmalloc(dev, 0, GFP_KERNEL) returns
ZERO_SIZE_PTR, a non-NULL sentinel (include/linux/slab.h) that must
never be dereferenced, which passes the existing
'if (!ts->report_data)' check. RAYDIUM_TS_MAIN is also 0, the same
value ts->boot_mode has from devm_kzalloc() before
raydium_i2c_check_fw_status() ever confirms a mode, so a
spurious/garbage first read that raydium_i2c_check_fw_status()
does not recognize as either ack byte leaves boot_mode looking like
an already-confirmed RAYDIUM_TS_MAIN without it ever being set.

With both conditions met, probe() completes 'successfully' with a
live IRQ, ts->boot_mode == RAYDIUM_TS_MAIN, and ts->report_data
pointing at a zero-size allocation. The next touch fires
raydium_i2c_irq(), which passes the boot_mode check and dereferences
ts->report_data at offset ts->report_size, both derived from that
never-actually-confirmed state, producing a NULL/invalid pointer
dereference in interrupt context:

  BUG: kernel NULL pointer dereference
  RIP: raydium_i2c_irq+0x5b/0x1d0 [raydium_i2c_ts]

On kernels with CONFIG_PANIC_ON_OOPS=y (e.g. linux-hardened) this is
a full system panic on the first touch; on a default kernel it only
kills the IRQ thread, but the touchscreen stops working and a
subsequent reboot can hang cleaning up the recursive fault.

Have raydium_i2c_initialize() return the result of the info query in
both the bootloader and main-firmware branches, so a failure there
aborts raydium_i2c_probe() before report_data or the IRQ are ever
set up, instead of leaving them in this half-initialized state.

Reported-by: Herlangga Maulani <w1zardsec@proton.me>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=221777
Fixes: 48a2b783483b ("Input: add Raydium I2C touchscreen driver")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/input/touchscreen/raydium_i2c_ts.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/raydium_i2c_ts.c b/drivers/input/touchscreen/raydium_i2c_ts.c
index 0256055abcef..a0b23772f4c0 100644
--- a/drivers/input/touchscreen/raydium_i2c_ts.c
+++ b/drivers/input/touchscreen/raydium_i2c_ts.c
@@ -426,9 +426,9 @@ static int raydium_i2c_initialize(struct raydium_data *ts)
 		ts->boot_mode = RAYDIUM_TS_BLDR;
 
 	if (ts->boot_mode == RAYDIUM_TS_BLDR)
-		raydium_i2c_query_ts_bootloader_info(ts);
+		error = raydium_i2c_query_ts_bootloader_info(ts);
 	else
-		raydium_i2c_query_ts_info(ts);
+		error = raydium_i2c_query_ts_info(ts);
 
 	return error;
 }
-- 
2.55.0

