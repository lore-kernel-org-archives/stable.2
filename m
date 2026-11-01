Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793556042;
	b=cAHVVD+9c33zK2/Wc8TQmONAe9XeFs27vfq1su9FT6In1N8rjGVYQ/fD2HXFAqls/3Ho
	 8dQDCoGZbdIZit1hr8STNWe1J97/jtLt5h5Z9Oard5gY+J1y8c4ddJGHkt08eQlAu1pJM
	 YBpHtmNS0OkMBACGVhxJSvpJP7ulmDaDKRgi3/OMkUsdQf6qbHxPaH3uBnkvOU4145eod
	 hecI934u/ZP0e8pJqfRXkirGrnYzI6fu3NJTlkwf6+82oR6+318Hdyp4ymd2vPu0BeHw7
	 tpJIQMIua9/Rb+32gHXmhi+F4T/3FAayOzehlDE7xbQ5Zza7ZRlAKaEZVnrmtOxwEgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793556042;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=90aqdG+SrfJSGek/huInxfvZ4wZJxbtx8iY/wQCJzXI=;
	b=UX2PMaBolzWRkShDAfP0itjeMmiw1S/wzQwqJe/cX5dRhS64oNWSbUauNERwmPnu1P65
	 zL882zBCyEx9FNdBYFEGdzdYuNea/S0vhvizqz75W2rLZ/ouLjQ9zwxV7thit29GbtbY9
	 4AQlwfV9AWsyVzAHOK09Ylxrjgp9FeqUAyAqOwCxhU6Lxy8tcgX1A+V7n8Rt4Kvzgag2g
	 g5LotKTFiIlonCAEQIaDw0Ix7r/18c0R9gVdyqJybyyPnkBqLmOW4/V3Hx05u5mh0NqcM
	 Y6dZwaPUo30BQqf9iJyqirY3S+futFT6/W46xUli/yxkC+Bss7BbLAri3aJ8lKoa9AA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=POJbI7uY;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0DF606A324
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 18:00:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E0DF606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=POJbI7uY
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3ad41b47541so1792782a91.1
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 10:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793556041; x=1794160841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=90aqdG+SrfJSGek/huInxfvZ4wZJxbtx8iY/wQCJzXI=;
        b=POJbI7uY6k/OxJGlxrcy13JLDXROLJxeNth0W7JfbndI4sCBCabjMnlTToZSFBnDvR
         5rwKhR1DDuuWR6l9+6FdakgBMT562qMeVqjwV+Fd7xCuNDiSTc2Y/eVMERYj+W1g4eDb
         T5Yd/fUifm5+fpIEMH1hpfEQBto259Q9bPAAF1bUHM3+N29g6L6UxH0sH7eaVoPB/Wfu
         Eu181Omwqs9pjObZ0wWXg7fHws1cRv9VXOVajYrN8K7rNwU/tYp+vCCqcfZcgZVHxkNa
         S0RQzYuSi3JkjD5sxfbkNtjME6TDvfm8RQOfu3i+hF3XnZl2I2viioATM8KIvbv6w30U
         LM0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793556041; x=1794160841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=90aqdG+SrfJSGek/huInxfvZ4wZJxbtx8iY/wQCJzXI=;
        b=U6r1F9oyFCOB5agO3JROC5EbhXXoSh1FTw7WIgmXlJfENsLz07huKlOb9PNhLl5Zx4
         2WoOTR51+GncSBJ423fR5bWSqnT/4IDX9QVJwLMcdbpXHFAYAX+QJ7PtYyjYX2Ie3+0r
         Gr0U7XGUFXnAxkysiLLPg3xqiDy9/6NVracXnCFZx/jUy+QUM8906e/XRgnYVYakBkQL
         TowIWmY2nBqnRhEkqeQvRzSYC42l6oMtig8NwaMYmp+7/t2xcwpVixkyZjxgdYwLMiTP
         40+jvfAOsYFaLFAizUcuKWUKVf9SXEaZ0f9EyF6qDRL8dbH8gyk29XBbDxS3AhWFfJuL
         fUOQ==
X-Forwarded-Encrypted: i=1; AKwUvBxaXAQR5NjJKSWzwMfs7ZvsLqoc2u3q+go7qLkluL86vwkxpvbYzFfYKe5uKtKS80ljoIsuhYw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8SEQ6j6RZlCWJwZQsfa07MBuN+ApkAV53/fgyyZttieDx7OoQY
	hkEnNqaJTSXzr1owy08FENDRoi+qJ1uMf684oQ+KQK0UFvqkFhUwVZYm
X-Gm-Gg: AYBFou2X0yVMGVb6UGGsWuVBWfJwVEVG0eooLSpIN4s/MffCCjjvxYPTxy5e9SOrEkr
	1vj6pcQteuqHI4aVmds63Zm86hbiufOnGXTxYjhNjz7M7G3+psDi0BdlniUs0zXDMvVaEzgciJ5
	ekHWLr8/KWsUHVDE5gs1hmR6NLvFH58740sJnLyedlCJ129yQz90JXgqLF+dpOAgGMC4Qkb8f0y
	MqNBsae0W3k1LFlWnkLJcw/I2RcDG1tKQNF20Wov+F39w9qq1FHmyH53VZ84O/uvLWu/UO4OtDe
	9aGvtdMPfMobNtK//0gRzQEEwgLbzciyEwCv4/o/H5mOlvu/e3L/jaO2MtWLLv+ICt9xD02S2b8
	K0OFMEH/yXG0MQCxd8NvkbWJM9XZ2a9yNv4+7a0UHMyd/3egeZjdgo/dc+0jAHAVhLg7VbTcWc7
	mdjMM4FGen9865PARHU26mCghswjxXxG+tbqsJFnldhuM7HMz3776395+Cp3jiUiXGWal5uzxfL
	61wtTvGB8el7A4Vxv3ptHIRhnY+5CtMD2UPTgNVRK/BSbOGrr//jQmbQzeWUuDNtzhOMqm2TX13
	pE8FMtBR2EQTfL38b+Yyew==
X-Received: by 2002:a17:90b:4f87:b0:3ae:5572:c4e2 with SMTP id 98e67ed59e1d1-3ae897e5685mr6397230a91.57.1793556040776;
        Sun, 01 Nov 2026 10:00:40 -0800 (PST)
Received: from tabby-boi ([2a09:bac5:4fad:e6::17:370])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e949077sm15194159a91.9.2026.11.01.10.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 10:00:39 -0800 (PST)
From: Nico Angelo Dela Cruz <nicoangelodelacruz@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>
Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Sean Paul <sean@poorly.run>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Jessica Zhang <jesszhan0024@gmail.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Connor Abbott <cwabbott0@gmail.com>,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Nico Angelo Dela Cruz <nicoangelodelacruz@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/4] drm/msm: don't wait for a fault devcoredump during GPU recovery
Date: Mon,  2 Nov 2026 01:55:50 +0800
Message-ID: <20261101175553.53746-2-nicoangelodelacruz@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261101175553.53746-1-nicoangelodelacruz@gmail.com>
References: <20261101175553.53746-1-nicoangelodelacruz@gmail.com>
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

adreno_fault_handler() calls reinit_completion() on
fault_coredump_done and then blocks in
msm_gpu_fault_crashstate_capture() on mutex_lock(&gpu->lock) to take
the devcoredump.

If recover_worker() is already running, it holds gpu->lock and, from
the runtime suspend in a6xx_recover() or a8xx_recover(), may time out
in a6xx_hfi_wait_for_msg_interrupt() or a6xx_gmu_set_oob(). Both loops
then fall into an unbounded wait_for_completion() on
fault_coredump_done, which has just been reinitialized and which only
the fault handler can complete. The fault handler is waiting for
gpu->lock, which recovery will not release until the wait returns, so
neither side makes progress.

A fault dump that needs gpu->lock can never complete while recovery
holds it, so waiting for it is wrong. Add a recovery_in_progress flag
to struct msm_gpu, set by recover_worker() under gpu->lock, and check
it in two places:

 - the fault handler doesn't start a devcoredump capture while
   recovery is running, so a fault that arrives during recovery no
   longer reinitializes the completion;

 - both GMU wait loops stop waiting for the completion while recovery
   is running and fall through to their normal timeout handling. This
   covers a fault handler that had already reinitialized the
   completion when recovery took gpu->lock.

GMU waiters that don't hold gpu->lock, such as the devfreq frequency
change path, also skip the completion wait while recovery is running
and report their timeout right away; recovery is resetting the GMU
at that point anyway.

On a OnePlus Pad 3 (Adreno 830), recoveries that saw a CP page fault
within 2 s of "hangcheck recover!" were stuck 3 of 3 times, while
12 of 12 recoveries without such a fault completed. With this patch,
three natural recoveries that took a CP page fault during recovery
all completed.

Fixes: 50a0b122cfc8 ("drm/msm: Wait for MMU devcoredump when waiting for GMU")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/CACu1E7EApr6Ne3XxFv4cUa2JuwNW2kfo1c5wSsAUN78iWyQ2sg@mail.gmail.com/
Signed-off-by: Nico Angelo Dela Cruz <nicoangelodelacruz@gmail.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c   | 7 +++++--
 drivers/gpu/drm/msm/adreno/a6xx_hfi.c   | 7 +++++--
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 3 ++-
 drivers/gpu/drm/msm/msm_gpu.c           | 2 ++
 drivers/gpu/drm/msm/msm_gpu.h           | 9 +++++++++
 5 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 662f09bec..32ed49abe 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -445,12 +445,15 @@ int a6xx_gmu_set_oob(struct a6xx_gmu *gmu, enum a6xx_gmu_oob_state state)
 		if (!ret)
 			break;
 
-		if (completion_done(&a6xx_gpu->base.fault_coredump_done))
+		if (completion_done(&a6xx_gpu->base.fault_coredump_done) ||
+		    READ_ONCE(a6xx_gpu->base.base.recovery_in_progress))
 			break;
 
 		/* We may timeout because the GMU is temporarily wedged from
 		 * pending faults from the GPU and we are taking a devcoredump.
-		 * Wait until the MMU is resumed and try again.
+		 * Wait until the MMU is resumed and try again. A fault dump
+		 * cannot complete while recovery holds gpu->lock, so don't
+		 * wait for one then.
 		 */
 		wait_for_completion(&a6xx_gpu->base.fault_coredump_done);
 	} while (true);
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
index 6b34e704a..fe4e35728 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
@@ -122,12 +122,15 @@ static int a6xx_hfi_wait_for_msg_interrupt(struct a6xx_gmu *gmu, u32 id, u32 seq
 		if (!ret)
 			break;
 
-		if (completion_done(&a6xx_gpu->base.fault_coredump_done))
+		if (completion_done(&a6xx_gpu->base.fault_coredump_done) ||
+		    READ_ONCE(a6xx_gpu->base.base.recovery_in_progress))
 			break;
 
 		/* We may timeout because the GMU is temporarily wedged from
 		 * pending faults from the GPU and we are taking a devcoredump.
-		 * Wait until the MMU is resumed and try again.
+		 * Wait until the MMU is resumed and try again. A fault dump
+		 * cannot complete while recovery holds gpu->lock, so don't
+		 * wait for one then.
 		 */
 		wait_for_completion(&a6xx_gpu->base.fault_coredump_done);
 	} while (true);
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index dadfe4c69..138bebf5e 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -289,7 +289,8 @@ int adreno_fault_handler(struct msm_gpu *gpu, unsigned long iova, int flags,
 	struct msm_mmu *mmu = to_msm_vm(gpu->vm)->mmu;
 	const char *type = "UNKNOWN";
 	bool do_devcoredump = info && (info->fsr & ARM_SMMU_FSR_SS) &&
-		!READ_ONCE(gpu->crashstate);
+		!READ_ONCE(gpu->crashstate) &&
+		!READ_ONCE(gpu->recovery_in_progress);
 	unsigned long irq_flags;
 
 	/*
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 0c2c35636..caa86279f 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -474,6 +474,7 @@ static void recover_worker(struct kthread_work *work)
 	int i;
 
 	mutex_lock(&gpu->lock);
+	WRITE_ONCE(gpu->recovery_in_progress, true);
 
 	DRM_DEV_ERROR(dev->dev, "%s: hangcheck recover!\n", gpu->name);
 
@@ -585,6 +586,7 @@ static void recover_worker(struct kthread_work *work)
 	pm_runtime_put(&gpu->pdev->dev);
 
 out_unlock:
+	WRITE_ONCE(gpu->recovery_in_progress, false);
 	mutex_unlock(&gpu->lock);
 
 	msm_gpu_retire(gpu);
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index d27d54bdb..5cf220f75 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -258,6 +258,15 @@ struct msm_gpu {
 
 	struct msm_gpu_state *crashstate;
 
+	/**
+	 * @recovery_in_progress: true while recover_worker() holds @lock, so
+	 * that fault capture and GMU waits don't wait on a fault devcoredump
+	 * that can't complete while recovery holds @lock.  Written with
+	 * WRITE_ONCE() under @lock; readers (the fault handler, GMU wait
+	 * loops) don't hold @lock and use READ_ONCE().
+	 */
+	bool recovery_in_progress;
+
 	/* True if the hardware supports expanded apriv (a650 and newer) */
 	bool hw_apriv;
 
-- 
2.53.0

