Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7236F33A9E1
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 01:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788312448; cv=none; b=n7DroQgysaNNf4DOlNhhR+7+1vVJlcC9ElizqLvoB2fGSHe6+c+cNzQk1HrSQC/1JpKP2irrznAAZyRZwI6/bw34oOpPlgZbrXG/sTYm8/XyKzn8dBu/Le2Yvshq4G+8B2jUq6xpZJlHDAvhJsVsR1wsCxZnEYkOTtkBgtkmejg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788312448; c=relaxed/simple;
	bh=1o25bNFKXc1tdmfeAc6nY1z2y8dwiXqYg/7xa51jfL0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jR4nxTlxqQInyBwqrwrw1QRBsm6WGL3vWNQWzCeQN+H9jKKwWd7N17jHaGp1ILHVZ/1tQaJLkmHwn7xW2qu0RHDPWtzMUHTWR2u38mPJ+HQNgdHjip0kNxuUGe5pxHkoK2MarrvXZXyMpVKVN+mMXPfRxDAcxyzuhPgYZ90G7ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A7MtkBlZ; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7MtkBlZ"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-852c481415fso646737b3a.3
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 18:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788312447; x=1788917247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=e5O92yk8UhYFXMSpdx81mnV2Y01T+eEkYBzZoAbcWuA=;
        b=A7MtkBlZ48aQxxiU8AvKXAKCJNIrBYbURYY63Iow5nY5MEokFBAb4YMalmCfLIOgYH
         USurFrTtg5rBtB6XdFdBRSveQ3w/Tp81wdVl2u6LYoUQOPdMgOWTRns9ZXkvgYI6y2rG
         wOIO/AWcj5peKBE2JIubqaRp/3ebgYg0nKqsxx03tvvRycpF/HpFMLEgO2iwOQr0FO9n
         +3fyVGxaW4cvRht8hT7lILynexImOVo2d7rku/G9JQRg/H2rWQRapEERxtU/DFRlbAFr
         xGL3dhLyiXv9zjuKx7iZSvZCUoKM3/3BwIXjJe2EoV3mcFIIECZ+16DnkKw0m2usOq6W
         YkuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788312447; x=1788917247;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e5O92yk8UhYFXMSpdx81mnV2Y01T+eEkYBzZoAbcWuA=;
        b=Qsn2aF5P1WS70Zh+HQTvCe9qrqtWyaD5kxzajmIzrFHyMoTTlvRCog9zPTWK9czoq6
         mXKXe5M/9lZ3xxIPcXKcc7P9nUhySMjJAOXKO7Lj7noE773oWotEhKWY9qIsT1W77oCI
         eHMa5ojN9HmsJ+jCd3tPst54goJWUZjwvfXnrQdFhhOqpgr6rptQlGcv/ra+Vm3OSuCa
         Lv5pSYcdhzObmTuuwqt5pkeeW7sqBfOpfk9gtmNvGCEMb5+CSAQXdqiyfRUsaAg8id/y
         Mv3tYSNEy0vbnSnzEMy5j3FsvrdePioLSy7egE9hPmQTwjH0QbPLxG7ziK9WUjkLoeCM
         S2hg==
X-Forwarded-Encrypted: i=1; AKwUvBxkYR5NRqnxXEDnKQrU7w7gzilreHvtseyNu0K+B3IR+ph4NgBUH+K8ZtjYAHf0KGOtCSkOduw=@vger.kernel.org
X-Gm-Message-State: AFuF++mHuSzV2pm+NzQGUXuiL4BDom3+haU0bprcPTXj9RAfKFzpxeZF
	JHdSBKbOJbZn5tkx+PsT+Y7t+71tmE/uYFpiWoVRPKmkmcHNHCRQ5dI=
X-Gm-Gg: AYBFou31BPO/O4qFNbZzXIcCB3/l3xRc/gw5VeLWMAcJeUXUCs7gs10g7NeoAkdKNTl
	Q3iCCXzrbmeuLPs+075c+ftpHIHHURmVFLrPFZmYEFeu2UdHnkzmFkyclsg7tVpb7SBzdHWmeQJ
	kOGQ06/GoMpbETBOhb/YpxexN4jrqnwgrFbxLJ/DjzML77BJnTI6omQkI8/8wTK2JP+1owU3bUR
	5+Z9l7gbQeRoUHQaG3wcrOGn2aZUfEilCcIPd7ED04r2S3URb/h0nlRVTMBWQJyI26jahe+R5zQ
	r7gY5kWbEmoATBwuxUk24CY99KuvMMP7KKwnm5fZH+F4zTNAxmbdIQhtOjGlBc/Zc0DARUbdYnC
	rMCvzXYXBBfSLnfxjMUZm9VNkzEO4kmnawD75oJ4djn545jvB67ObLPCJo8HxLNWKQigcbyhycS
	xws7RC3hipO9167tWoZyhN+4+IqM3xOSgYqJmMwP/opHSUt3j3bRphLe+tV6C6UzJwg1xfvMfIQ
	iybQ9cTiaja2WaZ5Rwfanzo2A==
X-Received: by 2002:a05:6a00:3c8d:b0:853:5152:a3e9 with SMTP id d2e1a72fcca58-85ed8023e20mr2355505b3a.11.1788312446696;
        Tue, 01 Sep 2026 18:27:26 -0700 (PDT)
Received: from MalHyuk.localdomain ([211.201.32.99])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85db2bd6de7sm560259b3a.23.2026.09.01.18.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 18:27:26 -0700 (PDT)
From: "Jonghyuk Kim(MalHyuk)" <malhyuk97@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>
Cc: Abhinav Kumar <abhinav.kumar@linux.dev>,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] drm/msm: RCU-free the scheduler-containing ring and VM objects
Date: Wed,  2 Sep 2026 10:27:20 +0900
Message-ID: <20260902012720.880783-1-malhyuk97@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both struct msm_ringbuffer and struct msm_gem_vm embed a struct
drm_gpu_scheduler.  msm_ringbuffer_destroy() and the VM free callback
msm_gem_vm_free() call drm_sched_fini() on the embedded scheduler and then
free the containing object with plain kfree().

drm_sched_fence_get_timeline_name() returns fence->sched->name, and the
scheduler fence keeps a .release callback so it is not ops-detached on
signalling.  A finished fence exported to userspace (the submit out-fence, or
a VM_BIND fence, via sync_file / drm_syncobj) keeps pointing at the embedded
scheduler after the ring/VM is freed, so a later get_timeline_name() --
reachable unprivileged through SYNC_IOC_FILE_INFO -- dereferences freed slab
memory (KASAN slab-use-after-free read).

Per the dma-fence lifetime contract the exporter must keep the data backing a
signalled fence alive for an RCU grace period.  Free the scheduler-containing
objects with kfree_rcu() instead of kfree().

Fixes: 1d8a5ca436ee ("drm/msm: Conversion to drm scheduler")
Fixes: 92395af63a99 ("drm/msm: Add VM_BIND submitqueue")
Cc: stable@vger.kernel.org
Signed-off-by: Jonghyuk Kim(MalHyuk) <malhyuk97@gmail.com>
---
 drivers/gpu/drm/msm/msm_gem.h        | 3 +++
 drivers/gpu/drm/msm/msm_gem_vma.c    | 2 +-
 drivers/gpu/drm/msm/msm_ringbuffer.c | 2 +-
 drivers/gpu/drm/msm/msm_ringbuffer.h | 1 +
 4 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
index 762e546d25ef..43a938e8f288 100644
--- a/drivers/gpu/drm/msm/msm_gem.h
+++ b/drivers/gpu/drm/msm/msm_gem.h
@@ -68,6 +68,9 @@ struct msm_gem_vm {
 	/** @base: Inherit from drm_gpuvm. */
 	struct drm_gpuvm base;
 
+	/** @rcu: RCU-delayed free so an exported sched fence->sched stays valid. */
+	struct rcu_head rcu;
+
 	/**
 	 * @sched: Scheduler used for asynchronous VM_BIND request.
 	 *
diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index 3ed05ab0eeef..a427e9b331ac 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -166,7 +166,7 @@ msm_gem_vm_free(struct drm_gpuvm *gpuvm)
 	dma_fence_put(vm->last_fence);
 	put_pid(vm->pid);
 	kfree(vm->log);
-	kfree(vm);
+	kfree_rcu(vm, rcu);
 }
 
 /**
diff --git a/drivers/gpu/drm/msm/msm_ringbuffer.c b/drivers/gpu/drm/msm/msm_ringbuffer.c
index 0d14c31bd4e4..a11c25fb4608 100644
--- a/drivers/gpu/drm/msm/msm_ringbuffer.c
+++ b/drivers/gpu/drm/msm/msm_ringbuffer.c
@@ -138,5 +138,5 @@ void msm_ringbuffer_destroy(struct msm_ringbuffer *ring)
 
 	msm_gem_kernel_put(ring->bo, ring->gpu->vm);
 
-	kfree(ring);
+	kfree_rcu(ring, rcu);
 }
diff --git a/drivers/gpu/drm/msm/msm_ringbuffer.h b/drivers/gpu/drm/msm/msm_ringbuffer.h
index 28ca8c9f7463..05206f523eba 100644
--- a/drivers/gpu/drm/msm/msm_ringbuffer.h
+++ b/drivers/gpu/drm/msm/msm_ringbuffer.h
@@ -55,6 +55,7 @@ struct msm_ringbuffer {
 	/*
 	 * The job scheduler for this ring.
 	 */
+	struct rcu_head rcu;
 	struct drm_gpu_scheduler sched;
 
 	/*
