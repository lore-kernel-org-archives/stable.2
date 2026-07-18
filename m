Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61F838B124
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 13:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784382302; cv=none; b=oBanUcrcBinAZZe+uZc1aSH4oz2a/qhcHkdrj+dZSrfuwncsm1qNxhnkBOnzih4ZzzCQU+G7qXXlsGuUtkBPIkrOXXZuluw4GHCoCC62q+9S8VzGhd29XyMFAiedxGJku6TZOCJXWldQ5V5BhkCSd4NlAfbTHMkeazWBhLhr4RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784382302; c=relaxed/simple;
	bh=QnQcBYp6xY0uqSFicbOvXcGAfWZvdvmkRh/MezFdQ6M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qSzyXDSXzBpnaPNtrtgrGvzmGHFktYO8yhe4MdXJ7U3kZXsXVvh/ZksjEIICEheuTJRUtNi9tI9/FEYhzzry+sl4n8YaTt52uVx66rzbSWG0XYRSDNir0r+o9wTqYXRvHlfVE+CnRhLEh0TaIFAoyi7LEHmx/or3YOQqZBe32UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=EALpOPfD; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="EALpOPfD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:From:Reply-To;
	bh=DQ3OZ98rWXCqM52MtHtWFrOSnPd9u4m+9VklW0dOlyI=; b=EALpOPfDZ6HOBJdRluml/ExMQx
	e5IQ+TPPGO9TqdQr0wQSRLfg5XWa9pMloTpy9QC847Hyi0CfOYBchTXGh35osb+vAnf9e6td/OM9J
	lhYkPN6nEuXepBjQQpHl+kgSp6AGq8uU81lMfH0aodAkYAnSZhOcID2b6fxY82fROg6BHc/wDVdsm
	rSfFWmSzzX7nw14Kmd94ZlKkExy3B98wPV+7nVf7a0zehhQEcHE+wMlrTEPwaVLk6NXIF6bxr02TT
	bv4w9BtUyq2vUubFichVHIWyEJG/PuoFNGdfwPXpfzO20RSuSIXt3INAujYrjrDXZMJGpO0M6TnRE
	4DmJkaDA==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wl5LU-00HSXW-TD; Sat, 18 Jul 2026 15:44:49 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Sat, 18 Jul 2026 10:44:37 -0300
Subject: [PATCH 2/2] drm/v3d: Idle AXI transactions before disabling the
 clock on suspend
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260718-v3d-pm-axi-transactions-v1-2-4ecd7729ed70@igalia.com>
References: <20260718-v3d-pm-axi-transactions-v1-0-4ecd7729ed70@igalia.com>
In-Reply-To: <20260718-v3d-pm-axi-transactions-v1-0-4ecd7729ed70@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral Quiroga <itoral@igalia.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 stable@vger.kernel.org, =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3186; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=QnQcBYp6xY0uqSFicbOvXcGAfWZvdvmkRh/MezFdQ6M=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqW4NInp0yEnEu6ApXIs1POwnLnAjnQfWI1sTcT
 aD8Gr5+SC2JATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCaluDSAAKCRA/8w6Kdoj6
 qvjdCADbO4BH0IjQwOI+OTYXjkhyqtWBT3APNBGvGspHMePY4wejS6SKXWBWge+3zXqb8kCkrO4
 rhNkPhwidlSK3om33xDfTIny2rxNem91j+1utM7JDnKrsBIZDrxmAUw8LIe54Sx51iiJEFVQ4VR
 3E7nKKeuKzGnGx87Dfjy7ZGTnWXJgRwI9VVpu6SwzuPaa/SahnO+Nv+cI1ZbociRAdNnsaGpwMn
 YLWQSLaz7+kcUKrbBHNxW7Ux8EzA/s2AJvpvUfqHjrPS0/T6ja0tQiBaYttWD471ILbRaAK75n+
 ZzjPw0gHsK9v016qZlc/WAwcV0fr0ikPvZZMdANV7b3u39ba
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA

Currently, v3d_power_suspend() removes the GPU clock without first
quiescing the GPU's memory interface (AXI). If the clock is cut while the
core still has outstanding AXI transactions in flight, the hardware is
frozen mid-transaction. That corrupted state survives the power cycle, and
the first job submitted after the next resume will cause a GPU hang
accompanied by an L2T "pte invalid" MMU fault.

The hardware already provides a safe-powerdown sequence for this: request
the GMP to stop and wait for outstanding reads/writes to drain
(v3d_idle_axi()), plus the GCA safe shutdown on pre-4.1 HW
(v3d_idle_gca()). The driver implements both, but the runtime PM support
added later never invoked them when powering the GPU down.

Perform the safe-powerdown sequence in v3d_power_suspend() before
disabling the clock, while the core is still powered.

Cc: stable@vger.kernel.org
Link: https://github.com/raspberrypi/linux/issues/7443
Link: https://github.com/raspberrypi/linux/issues/7488
Fixes: 458f2a712ab4 ("drm/v3d: Introduce Runtime Power Management")
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_drv.h   | 2 ++
 drivers/gpu/drm/v3d/v3d_gem.c   | 4 ++--
 drivers/gpu/drm/v3d/v3d_power.c | 7 +++++++
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
index 1b88b3dff757..f28b19237c0b 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.h
+++ b/drivers/gpu/drm/v3d/v3d_drv.h
@@ -618,6 +618,8 @@ extern bool super_pages;
 void v3d_init_hw_state(struct v3d_dev *v3d);
 int v3d_gem_init(struct drm_device *dev);
 void v3d_gem_destroy(struct drm_device *dev);
+void v3d_idle_axi(struct v3d_dev *v3d, int core);
+void v3d_idle_gca(struct v3d_dev *v3d);
 void v3d_reset_sms(struct v3d_dev *v3d);
 void v3d_reset(struct v3d_dev *v3d);
 void v3d_invalidate_caches(struct v3d_dev *v3d);
diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
index 41dc3617fb44..bc88ebdcdbea 100644
--- a/drivers/gpu/drm/v3d/v3d_gem.c
+++ b/drivers/gpu/drm/v3d/v3d_gem.c
@@ -36,7 +36,7 @@ v3d_init_core(struct v3d_dev *v3d, int core)
 	V3D_CORE_WRITE(core, V3D_CTL_L2TFLEND, ~0);
 }
 
-static void
+void
 v3d_idle_axi(struct v3d_dev *v3d, int core)
 {
 	if (v3d->ver >= V3D_GEN_71) {
@@ -61,7 +61,7 @@ v3d_idle_axi(struct v3d_dev *v3d, int core)
 	}
 }
 
-static void
+void
 v3d_idle_gca(struct v3d_dev *v3d)
 {
 	if (v3d->ver >= V3D_GEN_41)
diff --git a/drivers/gpu/drm/v3d/v3d_power.c b/drivers/gpu/drm/v3d/v3d_power.c
index ade8e932fb9c..f608e6d5516a 100644
--- a/drivers/gpu/drm/v3d/v3d_power.c
+++ b/drivers/gpu/drm/v3d/v3d_power.c
@@ -56,8 +56,15 @@ int v3d_power_suspend(struct device *dev)
 
 	v3d_clean_caches(v3d);
 
+	/* Wait until V3D has no active or pending AXI transactions. */
+	v3d_idle_axi(v3d, 0);
+	v3d_idle_gca(v3d);
+
 	ret = v3d_suspend_sms(v3d);
 	if (ret) {
+		/* Staying active: undo the GMP STOP_REQ from v3d_idle_axi(). */
+		V3D_WRITE(V3D_GMP_CFG(v3d->ver),
+			  V3D_READ(V3D_GMP_CFG(v3d->ver)) & ~V3D_GMP_CFG_STOP_REQ);
 		v3d_irq_enable(v3d);
 		return ret;
 	}

-- 
2.55.0

