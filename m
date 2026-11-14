Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794665957;
	b=mpqSjMs2QGwTGevS7c7ZloX8sKjEeaIXWXTWlHBvbFDkOagf72cg6i/DLVDEosvxcxUr
	 7RekTKJt4ULxRLT2LiDy9h/S55vpaTC5B22DO8jUuzi0SsmR0opGZVw2wxUM3nxT9bTCm
	 LEVX08Er8RCmbSplAEU3rV5MAknT1vR48xgarrtyEUFgmPIgMVIw1fmof6yn93NClBv5D
	 +GWwDyPi5JlFzwu4nxoK65JnA7NicJboany2d6gv4PBouRKHxdG0ane6w1QZ+/qElkOJ/
	 4rrMrzPd7dinxSZrWuYdWyUkHgzHP6if9UztlXBGWBZ5Tgbgq0ihlglttyaGGuKqAfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794665957;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=QjbH7+OnTujQtkedXacpeWPzVbsofxl7bIa9QcXu1+I=;
	b=x8SdSOsYrODtf3mBzTLIFDC7hjqexC2WcywUONjYCbmeOg+oWcZvNH+tOHbttkW2sbRD
	 T8kDL/XD0TF4ipkjEzSt4BiCkb33fj9Jhi5NPHZXJMYCnmug3h568W4oKMGgncku/dppE
	 abiSkoDbO6fn9zyYs8FCFuboASvqUYZOARi0rsEKuQLfy0gxsF0PqXoWdBNAXmpIZajMA
	 qfEUIsKE9l3whVYbhzOaOY+tt/T8Li2ljfi8SUKxdcIVgkNfNLL7zATYq9GLe8346mOHS
	 9mhjf0z8MxKL3/pwmiRORsT1snEfGqckYKzFvep8713P5k66ey1jtptGh2Q/PPUrH6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JGaonD2E;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B0B606A883
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 14:19:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46B0B606A883
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JGaonD2E
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1b3af3aea85so12811c88.0
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 06:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794665956; x=1795270756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QjbH7+OnTujQtkedXacpeWPzVbsofxl7bIa9QcXu1+I=;
        b=JGaonD2EVegvZ7RR/LnBg7cajt/DQt3tdYO0cSZhVgHTcYXCYg1RTKKhS9J8P0VIaF
         U+3mUILGSgAnXIz78m35cLzKZ9Tg4LxxGfLyUGdxPfRiWEsC+9I3wvM3PKCJwMJD2qbR
         3FNtjGAvupblQLi4qpyTN5HzEmruo4LJrYiaAPIq37cdrXaooQXpoi1MLeoYip5yH+BO
         1Ok87M7m2t1WJJf7lgha94zYcuRG4CjImCEnCuYPKlo0Q2msrKkn57h7hj2eFAbtY8P0
         v/fgsL0r/6h/A9rTFIRKY8tNg2f98hFF7fpZvIQkdgU7RhtxdXckcCAqnr1UhGeAqVjv
         ITfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794665956; x=1795270756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QjbH7+OnTujQtkedXacpeWPzVbsofxl7bIa9QcXu1+I=;
        b=E7A67fHs3eXyGrjteA/U1K5lpHLLiSNVV6LOjkvJvfT+h7cOo6o8INbKdkY7X6F/iO
         upIVaJTjYzwZ2qfDeD3paQXwCjFot6aCpi4IVcu/ZSMS7d9gRKhE19OtRd8wOZVMV+EM
         tpQotbr3y/rw3OsEcIl6d+s73VVzRs/Jhjt9heduYSOovjW6GaidssinXn93XZYjMHXI
         qe5LBTkbLPpePSyzDQsYBLM23w2ZUg0LhE0o8iwEYmeqKkV7BhUZApq4fgpetw62Lryn
         l4Rr9pEioN7PhJ03eEBVRTbuaheXCO+bO+/JaTYU95LzcFPErPW1kn/uaAVfWCT/RZA/
         ZUQw==
X-Forwarded-Encrypted: i=1; AL+hErGGez/LxC/Drp1hocNNs4PgCoWvHidhV3IFx+7El70zqf07benq0tl5ss4yxARi7tOxXsx4ajI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9pTaYJLmgyQBh8IrPEvHfyL4DXmciG11B9WkKsH3bqELdk3H2M
	8y0EYqh0vqskx1k9Bb+c4SuptupH+s1YY63Z1G7EZBl5414kuwxuaOMy
X-Gm-Gg: AYBFou1YSJRWrDn6PDl1/BcWitMhlwI7mabWMt4n1njN1GOvfpLS8RIR4LpK4t97p7P
	yCg3JI2XFltpKxPtE+RH/0LgJl7yk/mH/kl+XUf6HuFjgfojmM4LGdXXCKrAD8jnXRl/NN6aJ5R
	/Fx3y5ZO1LBPc0AefZHw6/a9wL3K8B9xA+gSjF0+lr0/OcBAJTguxhow31kJDGlbJeimwEEKg+1
	mMdEQR4buMovv8mIp9vr/1lzY9JBsxnnBY43Nd0Dc/4QdvfkrgqHyfuKdwzhOmmq1O41WurlX3t
	886qejBL3P+uH/J+nYezMeyOndJKllM1gI65k40xct4zJTAamwRdmL3+kkygdSmiLGAfRNrSSSQ
	BM7TLAEqM7xWRZRrpM5uD7pAL0HRx2TS+zFOybj4K4lAE/ZgRWlJR4kho4S64quCOoNmfMHwy0V
	Ww8ISZjLuhlTjbqL+m5a1DjC63+gohGMBL25PJZaahLROlw1JvKn+HUmknVZHWGtG+kMRcUJNU0
	p+4iGs+2jkY3G5vXiwy6so7n5B4CNvnKxItCDCq9+uoCE9wKXx7Y9fwIw0TKjqk3h6QVcuMGoWe
	zOlBdnSnxY7cObE9Bxh+iwdtnVnPEHOuESBpgCRdkTnWJDaB0t0fwkYTNFkiZyg+vMjhCBwGK4Z
	ImI0=
X-Received: by 2002:a05:701b:4508:20b0:147:d430:7322 with SMTP id a92af1059eb24-1b5030d2df3mr8446285c88.1.1794665956061;
        Sat, 14 Nov 2026 06:19:16 -0800 (PST)
Received: from DESKTOP-CJ1L666.localdomain ([211.198.99.62])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031b2519sm14745032c88.13.2026.11.14.06.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 06:19:15 -0800 (PST)
From: Jiwoo Kim <arpe1618@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>
Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Anna Maniscalco <anna.maniscalco2000@gmail.com>,
	Julius Bairaktaris <julius@bairaktaris.de>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Jessica Zhang <jesszhan0024@gmail.com>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 3/3] drm/msm: Put the VM_BIND queue last when freeing a VM_BIND job
Date: Sat, 14 Nov 2026 23:18:51 +0900
Message-ID: <20261114141851.134290-4-arpe1618@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261114141851.134290-1-arpe1618@gmail.com>
References: <20261114141851.134290-1-arpe1618@gmail.com>
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

vm_bind_job_free() puts the job's submitqueue and then wakes up
vm->prealloc_throttle.wait. The job does not hold a reference to the
VM of its own: the VM is kept alive by the context, which the queue
holds a reference to. When the job holds the last reference to the
queue, as it can once the file has been closed, for example when a
killed job is freed, the put can drop the last reference to the VM,
and the wakeup then uses a VM that msm_gem_vm_free() has released.

Since commit 01c8d1f385f7 ("drm/msm: RCU-free the scheduler-containing
ring and VM objects"), msm_gem_vm_free() frees the VM with kfree_rcu(),
but vm_bind_job_free() is not in an RCU read-side critical section, so
a grace period can still end before the wakeup, e.g. if the task is
preempted in between. Before that commit, the VM was freed right away.

Put the queue only after the last use of the VM.

This was found with an AI coding assistant, which also drafted this
patch and its changelog. It has not been reproduced, and the change
has only been compile-tested.

Fixes: b74fae5492d1 ("drm/msm: Add VM_BIND throttling")
Cc: stable@vger.kernel.org
Signed-off-by: Jiwoo Kim <arpe1618@gmail.com>
---
 drivers/gpu/drm/msm/msm_gem_vma.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index ce9d97582df5..07f427c4afad 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -810,7 +810,6 @@ vm_bind_job_free(struct msm_vm_bind_job *job)
 	job_foreach_bo (obj, job)
 		drm_gem_object_put(obj);
 
-	msm_submitqueue_put(job->queue);
 	dma_fence_put(job->fence);
 
 	/* In error paths, we could have unexecuted ops: */
@@ -823,6 +822,12 @@ vm_bind_job_free(struct msm_vm_bind_job *job)
 
 	wake_up(&vm->prealloc_throttle.wait);
 
+	/*
+	 * The queue may hold the last reference to the context, and so to the
+	 * VM, so put it only once we are done with the VM.
+	 */
+	msm_submitqueue_put(job->queue);
+
 	kfree(job);
 }
 
-- 
2.43.0

