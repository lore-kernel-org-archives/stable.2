Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B7231E820
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 22:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785104524; cv=none; b=NyHx+PSJLAbJYfVmvhxD3KjYK0enF0hECBN2YfboRVYWRNjx3vhtSUjsPD4NeRjkGsAzkdIpq3HoZux4XIe3dkyWQOuXIoWptZkrrRKZym/kLnzNY5+6TMkpdvlK8QkIsr1nmylfTzwu2Wen8RWtA8R0K+YRhLpPk2NDTBwtssg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785104524; c=relaxed/simple;
	bh=QYX6KKoozvRZlIib1aZZDW+NSylO3GrHs91X17xqXIk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g6E+jDzHiuoQhEF1UFLqDscrrxpGNhi2pzIy71CjMqbolKEREnsOj/S8fjxhhMKMn1QefuunsQEpfyPUFpZh21oVizdvwWDvzILr6H8FZJDDrFKvWcTSwVpgyS1sLhyzWTKg4j2cPWYovVm4c+XaIh0GEa9bSJj28svJ4G0nQyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=gdYJa9eV; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="gdYJa9eV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:From:Reply-To;
	bh=sgG09Bj+OFHPqopUOsnfZjwfVwjhh8/cAB4JsW7RTXU=; b=gdYJa9eVAvNunCnHB+sqLhxoxz
	a3dD3igKnLIPItykPlwwy0TB4TquTb+EfOMNFJYGDe+l4oH0KU9PKD0c34D1aiEdTSl1W4V5F5BgN
	jnCDzlFL2LbZsgp4qYIPIVMGcHpwUv00V1DaIx8cHCbVbzPd5kBqE+1y0gb9hcnTHDHakaahUAelC
	88JOwLkGpsCt4lUv+nThze8gbgyvjvHiJi5dmskP2zdFA76trEHMoKgMJf1jrsIq04eZxw2ghqIzn
	lmHHxrY4lChALQqBJskO0aEuJaiYCKc8dm4MEjrhA9YrrmdDyCq5aeXya2MmuspZslL4AE3s3t3C2
	4Qe1q/rg==;
Received: from [187.36.208.132] (helo=[10.0.0.1])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wo7EA-005jKV-ER; Mon, 27 Jul 2026 00:21:46 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Sun, 26 Jul 2026 19:21:37 -0300
Subject: [PATCH v2 1/2] drm/vc4: Supply the overflow slot size in BPOS, not
 the whole bin BO size
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260726-vc4-bin-oom-fixes-v2-1-7157e634affe@igalia.com>
References: <20260726-vc4-bin-oom-fixes-v2-0-7157e634affe@igalia.com>
In-Reply-To: <20260726-vc4-bin-oom-fixes-v2-0-7157e634affe@igalia.com>
To: Jose Maria Casanova Crespo <jmcasanova@igalia.com>, 
 Iago Toral <itoral@igalia.com>, Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 stable@vger.kernel.org, =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2012; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=HlcdIdrKDQdlDk3DhCiv3RVPzx+2v9fGg12OcAB36Ps=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqZoh050nNNctkHC4RoJ5vKOnbuyoJo046olh/W
 jB2x9x+qjGJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCamaIdAAKCRA/8w6Kdoj6
 qp/IB/9I8eifljFC0l58ArOjnUu8tMiFvW16xJiimufBmlIoLmNLG7Xvdh2bVJZnQdac0vlvX4l
 B2nzydSO12piDxYvMswdkgoPuOTr2rB9EUrFc/577MJhaTXZLrtbw/r0Kq6i6kO5krMyHNUwP/T
 yBcLAD/8uuyRqAfLBw5TFWZ1CWUtZT9uG3UhrsxLUExiVK4F34EQwtRhz97TsqZd9X9Clc6bzQv
 FzZlrrI2PFYojaJUnj43l/3PSgbh+MXnCs6WCU75A1dj5TY3noFo+hOYZ9JjVNf7Klzwy87yPvB
 +nLhY5biGrwQu3yPOJnzfchVETLh/nVO8Ql3V9Ou3sOTmTQS
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA

From: Jose Maria Casanova Crespo <jmcasanova@igalia.com>

vc4_overflow_mem_work() points BPOA at a 512KB slot inside the 16MB
binner BO, but writes the size of the whole BO to BPOS. On every binner
out-of-memory event the PTB is therefore authorized to write tile lists
across all the other slots (which may hold the tile state, tile alloc and
overflow memory of in-flight jobs) and, for any slot but the first, past
the end of the binner BO into unrelated CMA memory.

Since CMA pages are recycled into page cache and user allocations, this
is arbitrary memory corruption by GPU DMA. In practice it shows up as GPU
hangs with corrupted control list pointers, userspace heap corruption, a
GPU that stays permanently wedged after the first hang, and occasional
full system crashes, whenever a job overflows the initial binner slot.

The bug dates back to the conversion from a dedicated overflow BO (where
writing the full BO size was correct) to the slotted binner BO.

Fixes: 553c942f8b2c ("drm/vc4: Allow using more than 256MB of CMA memory.")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4.8
Signed-off-by: Jose Maria Casanova Crespo <jmcasanova@igalia.com>
Reviewed-by: Maíra Canal <mcanal@igalia.com>
Reviewed-by: Iago Toral Quiroga <itoral@igalia.com>
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/vc4/vc4_irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_irq.c b/drivers/gpu/drm/vc4/vc4_irq.c
index 8e5141bb5075..7877d493d80e 100644
--- a/drivers/gpu/drm/vc4/vc4_irq.c
+++ b/drivers/gpu/drm/vc4/vc4_irq.c
@@ -104,7 +104,7 @@ vc4_overflow_mem_work(struct work_struct *work)
 	vc4->bin_alloc_overflow = BIT(bin_bo_slot);
 
 	V3D_WRITE(V3D_BPOA, bo->base.dma_addr + bin_bo_slot * vc4->bin_alloc_size);
-	V3D_WRITE(V3D_BPOS, bo->base.base.size);
+	V3D_WRITE(V3D_BPOS, vc4->bin_alloc_size);
 	V3D_WRITE(V3D_INTCTL, V3D_INT_OUTOMEM);
 	V3D_WRITE(V3D_INTENA, V3D_INT_OUTOMEM);
 	spin_unlock_irqrestore(&vc4->job_lock, irqflags);

-- 
2.55.0

