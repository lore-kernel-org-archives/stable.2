Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794967652;
	b=gUkGPE+KAUjBjdvSM1KXgGpoAlr1I2+xdYzy25HFjlYgyGfoIFlrdBADl7G+Xc3uz1dD
	 LMhhJHEzVw4u+Xr3fJqc7AleuEEEQCjchcCWGXEMUXDIhwbK6RK6reUWSk62YV5knIeZm
	 dl9MAaIf3ibpVAK4STc0JfZXgapeXMq1BgLny3NvR9Y1txsNdCs9NSBkdtZu85mTpwTK8
	 5lffbO+cxeTDVSxfnGOCCKO4UVeuDoXaZF92J4VyPZOXGcburWBZTwKtCVGATI/B7h7gi
	 1U/L6TuAIyx/W19mANNpHRGGKnXtIpYQwJVPJNApd8qXnGnASNqhi3JEdS1ybWEWUSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794967652;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=4XYNeMt6VNMRAiLe5EbRBvBhMDIpn29m4tUHZ+DRyz0=;
	b=qUiTzu7BTUn7eO/XgCV5xPA4hZYq3W+8Ih/ohkBW4ZN+Lp/Cl1OCRMUGkc7GVw6/5Hcn
	 C1tMKFR8J8n9fo0/j298ngcrMsMLhev137ZL94X+GqOsP/FDVy6dJHR9iKqEa34Ai6r+Y
	 +1X2WqqNtT6WboImLTpgSDuK7uhSz49sBD43SEhgNxqaMM4lF/VnLxswclJyMi4qv48gJ
	 W/VPzUdOOwjfPJuJRUrBx0sB9WbnfFWJyzbAyQcwLcEb8zKnifqlmXF1A5l9EJGk/OcKk
	 r+Bwe7GuWxhLFaXOl5vlB7szy02mUC0V6e+aa83LynlikSGO4mzYZAYTyPv9hMrnsSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tfrItGmZ;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17835606A32C
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 02:07:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17835606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tfrItGmZ
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-378915168c7so4741eec.3
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 18:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794967651; x=1795572451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4XYNeMt6VNMRAiLe5EbRBvBhMDIpn29m4tUHZ+DRyz0=;
        b=tfrItGmZyurqbc7AlNCYAocIN4DcMjwq1XHmG9CUCxqlUqqTzPbwPuqUy4p8jbdZxg
         Qg7eLGUPoU0Mq5TAfgxhb70/JJZrt1fUYhuMSEegIZiAoUrRgAZVmgT0Xha2WeAffogU
         oyFGGQL01j7wZBfLQR4eK2E8HlWpRIkZOkoObmeL6nNFFYSIEILCc3whXwdyEoofO2fw
         tH8iNwWoEJXL3T7vUmoJPIjf8dzzVb0nJrqKtuTYQ4ASpxpf3sCUADQB/sMlrTs1p7mx
         X7pVMUx1Iqs3sc0BFZLsZ6EaPauyyYz1Rt2l/EgRSmkYT44Q/Wl/1+xhCd3hHoyTlWB+
         d53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794967651; x=1795572451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4XYNeMt6VNMRAiLe5EbRBvBhMDIpn29m4tUHZ+DRyz0=;
        b=k+4OmY8dDDXNs7UbB0c9C3NNnfoE7OMd9uhDHksaj4yG1lhvjpEZZ21H+fAbQ8UzSE
         CiayfmRKwl94vqWwvlAMtkr6KQ8KhoO/eTkymucmzdSfAHB2Ae5lzwIm39y7yWUoZ/vb
         6NgN+NDlGAzH04M5PHWRLTMgZc0qb7VaXZbZB/1HnWd8WuQzxj/moKZp8J5s3nn6Stqg
         W5ZnOHIZUKysC/HXqB1BACmdbfVxES9ts7m6UoUPvQ5xckAjF5WsGIGP+MoXONw92k/Q
         PES1KOFRk1mxnUK2IlZjyLDd1cng1ceglWv06NmZcHaCOKwJhA6eUYVFFUZ+V39Yo1Dp
         S7rA==
X-Forwarded-Encrypted: i=1; AL+hErHMlKge1RGm1V7Qign6w8ccZqQ8covlCyuMIYekMo9L4dKKFquh5BaIrEDdvU/02fXDCH3Lf3o=@vger.kernel.org
X-Gm-Message-State: APuU4Z9EzWJBeS97OTl6IK8PMVdNI9n3KFsWLBStU2eOSb2808y2kFMI
	TS/tjXfYQB4jOtuUKCbRHZluztL999M/s/RclGVCpPbocrxk+uOZ8CiJ
X-Gm-Gg: AYBFou16FWXJJxM6ydRvoAj5JrkS8CgQ4TxK1D7QItMhi5WbGU7T8NO+qQ7rTb9ilMz
	tHyhDZ4BTN7BTmxBI5P83lV/a1gpPhDvqruw0f1A5kbqokT7SKrfNI7HPhJ6u6i5Fuqnmv9MI/D
	A1I6eck6gR5l3d+rfHe6TX/vHGDr+3vSJHkUYzOUNY7n2CtchPBt7xYV16kFN/oD/3CVCA7aF3N
	mP3/lEulVzgw6iB5aB3vZTLJsmz3GXLcrVTtmmaRbJt7k/xHL0b7C0HgpVYWFi4n9Ra5DuEARAC
	T4u14UYm83kFD1BW8T9HynFcHFnDaaQRPC7PzKJRzEBTw8djSWmB/oOS6nIxY3DkhWNupkuCG7J
	Xp+R6n0x+LJo582bPwqpRH0saqY0N+1u0+VwOdYjLHBYdozK1/BpoiW4Fg7g/Ko9RMdPUbjPFn8
	MjVUX9T48kKxCwOcOBuT+2IxeyBFvZ5UoMiqYA0uvgIa6Wr8BB6VomOnPQvzNX3/uvjTKL6h7eM
	R0+Q1kFNBbE7coaWZ1rzz9PbGL+eNOvYDJMtKzSm+tNIN7uBurM5+CzeqXPXP9FJ0NXuGQr/Htc
	mZ800m2BPB60NUiOeKSjzhMQyt1kVKnRmY0/EcveZmeJm9Jhx8CvPPnZYsEo6uPfSsfimxwPoxp
	pzu7DHtI=
X-Received: by 2002:a05:7022:698b:b0:1b2:5884:a039 with SMTP id a92af1059eb24-1b543a1715bmr2662340c88.0.1794967651150;
        Tue, 17 Nov 2026 18:07:31 -0800 (PST)
Received: from DESKTOP-CJ1L666.dankook.ac.kr ([220.149.255.57])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b544784008sm2862327c88.5.2026.11.17.18.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 18:07:30 -0800 (PST)
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
Subject: [PATCH v4 1/5] drm/msm: Wait for VM_BIND jobs in msm_gem_vm_close()
Date: Wed, 18 Nov 2026 11:07:12 +0900
Message-ID: <20261118020716.1698-2-arpe1618@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118020716.1698-1-arpe1618@gmail.com>
References: <20261118020716.1698-1-arpe1618@gmail.com>
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

msm_gem_vm_close() waits for vm->last_fence before it tears down the
VM's scheduler and its remaining mappings, but only submits add their
fences to it. msm_submitqueue_close() flushes the VM_BIND entities
first, but drm_sched_entity_flush() gives up after
MAX_WAIT_SCHED_ENTITY_Q_EMPTY when the process is exiting, or on a
fatal signal, and a queue that was closed earlier with
DRM_IOCTL_MSM_SUBMITQUEUE_CLOSE is not flushed at all. A VM_BIND job
that is then still waiting for its dependencies is not waited for, so
its pgtable updates can still be pending, and the job still queued on
its entity, when the scheduler is torn down.

Add the fences of VM_BIND jobs to vm->last_fence as well, as
submit_attach_object_fences() does for submits, but keep the previous
fence if dma_fence_unwrap_merge() fails. As for submits,
msm_gem_vm_close() waits for these fences without a timeout and
uninterruptibly, so closing the file now also waits for the
dependencies of the queued VM_BIND jobs.

This does not cover a job that is killed, e.g. on SIGKILL while the
process exits: the scheduler signals the fence of such a job before it
frees the job, and the free can drop the last reference to the queue.
That is fixed by "drm/msm: Destroy the VM_BIND entity when its queue is
closed".

This was found with an AI coding assistant, which also drafted this
patch and its changelog. It has not been reproduced, and the change
has only been compile-tested.

Fixes: 2e6a8a1fe2b2 ("drm/msm: Add VM_BIND ioctl")
Cc: stable@vger.kernel.org
Suggested-by: Rob Clark <robin.clark@oss.qualcomm.com>
Link: https://lore.kernel.org/r/CACSVV00ZppfBKwsHJ+NBYBB7a2f3g1O=6J4Gt1m_A74fudZQoQ@mail.gmail.com
Signed-off-by: Jiwoo Kim <arpe1618@gmail.com>
---
As for submits, a VM_BIND job whose in-fence does not signal now keeps
msm_gem_vm_close() waiting, uninterruptibly.

submit_attach_object_fences() drops vm->last_fence when
dma_fence_unwrap_merge() fails. This patch keeps the previous fence for
VM_BIND jobs instead, and leaves the submit path as it is.

 drivers/gpu/drm/msm/msm_gem_vma.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index 8b702422030a..2f0698df1a9a 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -6,6 +6,7 @@
 
 #include "drm/drm_file.h"
 #include "drm/msm_drm.h"
+#include "linux/dma-fence-unwrap.h"
 #include "linux/file.h"
 #include "linux/sync_file.h"
 
@@ -1443,7 +1444,7 @@ msm_ioctl_vm_bind(struct drm_device *dev, void *data, struct drm_file *file)
 	struct msm_syncobj_post_dep *post_deps = NULL;
 	struct drm_syncobj **syncobjs_to_reset = NULL;
 	struct sync_file *sync_file = NULL;
-	struct dma_fence *fence;
+	struct dma_fence *fence, *last_fence;
 	int out_fence_fd = -1;
 	int ret, nr_bos = 0;
 	unsigned i;
@@ -1586,6 +1587,17 @@ msm_ioctl_vm_bind(struct drm_device *dev, void *data, struct drm_file *file)
 	msm_syncobj_reset(syncobjs_to_reset, args->nr_in_syncobjs);
 	msm_syncobj_process_post_deps(post_deps, args->nr_out_syncobjs, fence);
 
+	/*
+	 * Let msm_gem_vm_close() wait for the job, as it does for submits.
+	 * The VM's resv, which protects last_fence, is still locked here.
+	 * If the merge fails, keep waiting for the previous fence at least.
+	 */
+	last_fence = dma_fence_unwrap_merge(fence, to_msm_vm(vm)->last_fence);
+	if (last_fence) {
+		dma_fence_put(to_msm_vm(vm)->last_fence);
+		to_msm_vm(vm)->last_fence = last_fence;
+	}
+
 	dma_fence_put(fence);
 
 out:
-- 
2.43.0

