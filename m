Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CE230FC33
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 01:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788312440; cv=none; b=bw6t30uHJnPkT3ndADDYF+6BhUVhm1osbFtW7RAq9oUldCAk5Sc3kQ4NnlFqvVodzIeq+6RxlTvcPXQW7ltIBIGkSKajep1BeRSZv3axo+WnUbNj4u3VndOtmnl7IgvADdcHX02HxK3eP0fsgDnWLnh1VvvZontSsUDwvXz2gog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788312440; c=relaxed/simple;
	bh=JlqJQkMLfE8F8bIGFtwJfEZaXVD0yXG+K6DypbeL5hU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DV9sUVtqa/cqGE888xbhIB0v5zFRx3OUiXgxEFM2a4uHk+WY1wvVj9MkttLy8pT1l1rLv0BIqncLpT+NjDN5im0gibzFhB1ZXwDIK7fTO0JIKAry/gTUlT7MaT93VkO+Ow88n6hNxTE0ruAVUZsSAAUnT9blpuEHZujozBI2cTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M4par1pq; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M4par1pq"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so681010a91.0
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 18:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788312438; x=1788917238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BrgdRCCQy4wk9/bV+rhJB1ZWew/obSOSpX6szpMZY4E=;
        b=M4par1pqcNs1i1prMxAV9OpR36GDCkk05jQ77bzKzou4+45h3DL2bzL/JXBf7YmcpR
         hXooErD7Op+u0Tm4hDqsUwwc8vDV7ZAwnx6PrGxqJ+3m4SD5xyo6J5ef8lGLijkGawp/
         ZYnsifguqsHc6RGStLYBHNPirDuqrLEKEVyJXpjx3z88F0LolQ2efiCGJBLE3Kyj+PYa
         oUnLNojlt+TEpkknUT7kYuLSB0c4tjB1iixi6qYC9Gejs9eTmRVHoEM77EX25Bt2BuEp
         VNvVvhQ4gBWYxEtduRFilGcAymRODyPqfNe8JTh9htldARwZepaaKYIDVkej8lC1GrQi
         8grw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788312438; x=1788917238;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BrgdRCCQy4wk9/bV+rhJB1ZWew/obSOSpX6szpMZY4E=;
        b=KQ2Avxwd4O3OSw2ZLflE7LsWX4/ZyaRIeYqD1QFY6pd3/uCVyGBRpb5z1N8JZREVy+
         rETOLRcwQSkBFK/WZfsnVpADw6hB0fXxP9wVVLfFHkTYaaMWtwkg5GqsLpyYXRiYlG9o
         m6pLYDJRklxYzhgBBPtN4qQxqF24UcMnzXcS9I6bwH/ivbcGucE2Ea3Hf5tz05D8B5zn
         lTNJndY33k7lcLes8d4fDrGb4DVVFoNO6U2X/k2JltFW3KGyGHcGuzHivJpDi0Z7gnIL
         iTnj98bFkTtrihydO664zV5NbNGWoqftcz0Fd0OqX9q2zi6fKdH9gcTaZ9JUf1akBsU/
         hg7A==
X-Forwarded-Encrypted: i=1; AKwUvBwrvNfd7sfNHy53HNCEufl1LJ/QnI9teRUWmklTxBubiVXZ2CZvyMz3xpY4h7cCN0n7yRJGDqI=@vger.kernel.org
X-Gm-Message-State: AFuF++k8pYeUv2vDCCKXlQZlgEEo4YISo8xN11I0RusuFCYQKribezdq
	YdKlymluUwhnlNYcyDJrlhTkvGD4LNnvr9oPE0IpidDw71cQnnk3tFk=
X-Gm-Gg: AYBFou12eTQLMnIA5uR7exX7wXN80PMXSsWVMz/73B00HlSYmMa/OHiOLLN7C1pIv1G
	8Pxb1dgydK1rgjX1J4A//eOPnBgV53K2EyqfuM3Hf6yukG8DyBtyEmMsajKnqlVVjX/rXSQFE4I
	hC/zWYORwSvdZAH/B/UVvoC5sRF6p8CKEimfnUC9yfxISoHYyGba2NKgGG4zlFDoC3VriJVI5D7
	LC4/3+5X5z/KLox/PA5ZodiuAecHGt5ez+UWplj2B0aOs/BU6WA9Cl+FUNZV724AZ8uEfgRIks7
	9CbW1REuysnLkM1tfgMOgipxdEtJtmTBT8JBztGrC0pRr1fBdTHK5WCPQ3FsRFUZFDaKzsifHTh
	T9/O6BeRDMsxBo1/MXGclqKjyVlDhFr+zUK+/FDL4879A7izrYTV4TV+cbQN3ng6Cyg+baxtbJf
	0JgHyOLotSsG+lkOPifVhpRQtsaFfhiuwWrOapBfBJFwFcBVW/jCmauI5r/nN7oavYZwEGm3z5R
	DswlQKM99Loa7jzBcaicX5qDxc=
X-Received: by 2002:a17:90b:4c52:b0:38e:6aa7:68ad with SMTP id 98e67ed59e1d1-39aedf7c6aemr1567465a91.5.1788312437952;
        Tue, 01 Sep 2026 18:27:17 -0700 (PDT)
Received: from MalHyuk.localdomain ([211.201.32.99])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39ae0f2a315sm2443563a91.8.2026.09.01.18.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 18:27:17 -0700 (PDT)
From: "Jonghyuk Kim(MalHyuk)" <malhyuk97@gmail.com>
To: Min Ma <mamin506@gmail.com>,
	Lizhi Hou <lizhi.hou@amd.com>,
	Oded Gabbay <ogabbay@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] accel/amdxdna: RCU-free the scheduler-containing hwctx private
Date: Wed,  2 Sep 2026 10:27:12 +0900
Message-ID: <20260902012712.880520-1-malhyuk97@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct amdxdna_hwctx_priv embeds a struct drm_gpu_scheduler (priv->sched).
aie2_hwctx_fini() calls drm_sched_fini(&priv->sched) and then frees the whole
object with plain kfree(hwctx->priv).

Every drm_sched_fence produced by that scheduler stores fence->sched =
&priv->sched, and drm_sched_fence_get_timeline_name() returns
fence->sched->name.  The scheduler fence ops keep a .release callback, so the
fence is not ops-detached on signalling: a finished fence that userspace still
holds (exported via drm_syncobj / sync_file) keeps pointing at priv->sched
after the hwctx is torn down.  A later get_timeline_name() -- reachable
unprivileged through SYNC_IOC_FILE_INFO on the exported sync_file -- then
dereferences priv->sched->name in freed slab memory (KASAN
slab-use-after-free read).

This is the amdxdna instance of the dma-fence lifetime contract: the exporter
must keep the driver data backing a fence alive for an RCU grace period after
the fence is signalled, so a concurrent rcu_read_lock'd dma_fence_timeline_name()
cannot observe freed memory.  aie2_hwctx_fini() already waits for all submitted
jobs to complete/cancel, so the fences are signalled by teardown time; only the
teardown race window remains, which an RCU-delayed free closes.

Free the scheduler-containing private with kfree_rcu() instead of kfree().  The
init-failure unwind keeps plain kfree(): no job has been submitted there, so no
drm_sched_fence has been exported.

Fixes: be462c97b7df ("accel/amdxdna: Add hardware context")
Cc: stable@vger.kernel.org
Signed-off-by: Jonghyuk Kim(MalHyuk) <malhyuk97@gmail.com>
---
 drivers/accel/amdxdna/aie2_ctx.c | 2 +-
 drivers/accel/amdxdna/aie2_pci.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
index 4b3a62aa8798..26bd6e001792 100644
--- a/drivers/accel/amdxdna/aie2_ctx.c
+++ b/drivers/accel/amdxdna/aie2_ctx.c
@@ -842,7 +842,7 @@ void aie2_hwctx_fini(struct amdxdna_hwctx *hwctx)
 
 	mutex_destroy(&hwctx->priv->io_lock);
 	kfree(hwctx->col_list);
-	kfree(hwctx->priv);
+	kfree_rcu(hwctx->priv, rcu);
 	kfree(hwctx->cus);
 }
 
diff --git a/drivers/accel/amdxdna/aie2_pci.h b/drivers/accel/amdxdna/aie2_pci.h
index ea1dac106400..e08b8f64328c 100644
--- a/drivers/accel/amdxdna/aie2_pci.h
+++ b/drivers/accel/amdxdna/aie2_pci.h
@@ -107,6 +107,8 @@ struct amdxdna_hwctx_priv {
 	struct amdxdna_gem_obj		*heap;
 	void				*mbox_chann;
 
+	struct rcu_head			rcu;
+
 	struct drm_gpu_scheduler	sched;
 	struct drm_sched_entity		entity;
 
