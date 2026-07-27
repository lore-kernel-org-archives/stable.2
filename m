Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A6838332A
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 14:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785162767; cv=none; b=fSVwHUkpNtYP2lraXjlIApTP7unJ5lAcbQWB8+hZ4zeknrbLaZBrDUoAhpOls71Sw2ZOfz+LIzaBuA2kdQ1Y9/+Cufpzv6yHBiEc7h88SOpY9K4Oo6m27OR8CiDubIKbD140W98M5Qg+T/v7d7XmaP4S32E7dOOV+GlBGAtwlq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785162767; c=relaxed/simple;
	bh=QYX6KKoozvRZlIib1aZZDW+NSylO3GrHs91X17xqXIk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KZ9sBdCPa1gq6zirFxOoK9gwJuTs61GeQI6R1kiP4mnr6B/a7F9+2W1lteAGAkECuFFQArULDO9ngs/v5XYCoblR3ou4BobJsyXinN6xxVCMRqsctDfnMZwEhhPr+YKUcYMf6nWqqQmuLH1wCj2gL6X9D1mhsCnhsEWGoPtRIGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=qsZEErWb; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="qsZEErWb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:From:Reply-To;
	bh=sgG09Bj+OFHPqopUOsnfZjwfVwjhh8/cAB4JsW7RTXU=; b=qsZEErWbP2ky40hILACrUb648d
	CM5G0dHWgjJN0qU+K3irONO3rGTVomYuf9KGaa9YLHFcGTMZ5cP/OZWT7JEv2mVKCOvLRp1v0z4ES
	F65i4eTVm8PZhL019bUp/ZyhR0cwwgzD2EZA4YF2IJFC8qPd8vUCh0ITMAG3R539bshKTUvN5xftz
	CG+0cOhdbBZX7FqPyOPy+kl0E01a9hfxUAw/IAyW1v8cjypdkDy445j0wqfKPKFtdP0SBAIjKZ2wQ
	JN3ZLeukhA+21TFHEtnEpb8wOGuglbwpFVScy9Y5Jtew+jLb8BBKIsVN0Zj4Ss/FwLHFRB7MqXfuW
	ERZQ28Hw==;
Received: from [187.36.208.132] (helo=[10.0.0.1])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1woMNk-006B5g-L8; Mon, 27 Jul 2026 16:32:40 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Mon, 27 Jul 2026 11:32:28 -0300
Subject: [PATCH RESEND v2 1/2] drm/vc4: Supply the overflow slot size in
 BPOS, not the whole bin BO size
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260727-vc4-bin-oom-fixes-v2-1-0d8a5eddc7c9@igalia.com>
References: <20260727-vc4-bin-oom-fixes-v2-0-0d8a5eddc7c9@igalia.com>
In-Reply-To: <20260727-vc4-bin-oom-fixes-v2-0-0d8a5eddc7c9@igalia.com>
To: Jose Maria Casanova Crespo <jmcasanova@igalia.com>, 
 Iago Toral <itoral@igalia.com>, Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 stable@vger.kernel.org, =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2012; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=HlcdIdrKDQdlDk3DhCiv3RVPzx+2v9fGg12OcAB36Ps=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqZ2wBN8N+85xVn5qSkff7rJ7QksP9P265KTqA/
 LzF/AwaJSqJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCamdsAQAKCRA/8w6Kdoj6
 qpx/B/4sudsHNYRo+AfRMjI9hpGe16881Uae6yKD4hPBusJN9Ki6dnFgjYHq84AQBH55alGKmxR
 FeR9mov3RcxqsbAfegVXb1aOe3II3TLgsnGh+Ps/yfKElgWTdLcHcZTNSgLA2Qxo0U5l/qzzEb0
 rzFdtt+bhQWthWNO5IOGIHqcZrMGsaaL5tW9n8ADPMhd4vCv1es9WruXMvnY8boo18KcIK2VqfW
 3vuIa0OJkYhH1AzB/KHTfG56tut5RFOLoBehcMcSmu4CC4kyijxI45ufLgX3zfV5TDnVnMqqyds
 rVP/x8FzotlVqhWyzmFF9ByBSvYptHW2f6j3E0SU7eIR8SXt
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

