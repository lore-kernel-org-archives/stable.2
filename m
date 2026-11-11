Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794370422;
	b=nefj1gxSPp9lbtwVcNYX1ut/7MtaDi1QEhukL9Z/VEGQT2pzMfYjgAW9OSP59lSsNg+w
	 IlJMvVZH8Kkn3bQRj6wTU3vx+1DoADTl5fsx0iT4S03fv0KXyUdovBaBrW9M1rhHb1waM
	 tribhsj8YoVy0FI4KQZ21fwTcuhP8kFq759yFym3XBaFJbj9xuvkrjJH+EuNCkaXxj61r
	 5wOYScmzdjMNfG99Xh5EnEGt1G39raSF1zd2exj8jYn7X7Ak+CK7YP0BnGhuHNMzPXQc7
	 0NrRTZ6J6eyBhNckf6W+ae9mjC4fu+x6/PwlR/aRdIdI65YE52zQj2vafreBCqtVtqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794370422;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=YbtALk4dd1qrpZHNl+/9xgOArCWTKjMrGnDQ73nTsNE=;
	b=v0ML2zh+6zYHMf6sUJBoWjKhuKgBb4SAA67Vr7O0FDL3DMf5hugcvitxDO4YLiBtAR4X
	 jFSwDJGLOSE2brgDC3dCdO+hkFogROgLBtEKRaTU1j9e6NUttyqIOb5cZTzW9Em9t2QwV
	 rspSFSHvLYB38orp0ArPukgijQqeYU74AGG/cg+uZ9rrn1dWuVzqy7U1Vh2Xa1IouIJc9
	 ZMlX+TI856ym0rWypMQpsdI+v1JGf98JpoLJ6lcsj/7p8f9Tn510YcgQaW+fvfKfh2Pbk
	 Og6Z2PbfXL8qofLGImwOCAjKJ4ob20q1abwt50igVCzsoT3v5J4zNjHhPS9glPDF8wQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G5awP36u;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972BC606A320
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 04:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G5awP36u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A25951F0093C;
	Wed, 11 Nov 2026 04:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794370422;
	bh=YbtALk4dd1qrpZHNl+/9xgOArCWTKjMrGnDQ73nTsNE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G5awP36urou0a0elaqwrTy7KbBgbJXuIff0aeylfwb+haEa45Zfe5dCHH/90o6JBz
	 DswPGvZUEoTknvg48jIHDfFpXPJNxJyq3KgbkYwMDUGwaz10H7Mb4IqVxbmZvlODHW
	 c+ZhKWbG9tHRbRZ4rEaWb/WdqFnDox8jxF6/iHaGKRdL3YFn6QAwvSwzWk7weGChhF
	 ddx/qQwD25BYV3qisJvxHfT1RHgvfJRCWf5VNxOpYOQfH3WhFfF6xqhT+1mZ8TZp2c
	 R0YyK8n++GaRh5F3QXYf9BeHf1tr06h+sq2zYuAl4RvnbrLqINyjUDLSkOgujkymFH
	 +Rw3wuGbDbP2A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Robert Foss <robert.foss@linaro.org>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/6] media: camss: vfe: Remove vfe_hw_version_read() argument
Date: Tue, 10 Nov 2026 23:13:35 -0500
Message-ID: <20261111041132.1029567-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111041132.1029567-1-sashal@kernel.org>
References: <20261107060052-failed-5.15-e5d4b0e69a40@kernel.org>
 <20261111041132.1029567-1-sashal@kernel.org>
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

From: Robert Foss <robert.foss@linaro.org>

[ Upstream commit 5ad5866737991d83cb4a74a02d0c32a18adb9246 ]

The device argument is not needed, since it is accessible through
the vfe_device argument already.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Stable-dep-of: e5d4b0e69a40 ("media: qcom: camss: vfe: Fix VFE reset while another line is streaming")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/qcom/camss/camss-vfe-170.c | 5 +++--
 drivers/media/platform/qcom/camss/camss-vfe-4-1.c | 4 ++--
 drivers/media/platform/qcom/camss/camss-vfe-4-7.c | 4 ++--
 drivers/media/platform/qcom/camss/camss-vfe-4-8.c | 4 ++--
 drivers/media/platform/qcom/camss/camss-vfe.c     | 2 +-
 drivers/media/platform/qcom/camss/camss-vfe.h     | 2 +-
 6 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-vfe-170.c b/drivers/media/platform/qcom/camss/camss-vfe-170.c
index 9a1f2a6bf3fa7..ad3c375a33fbf 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe-170.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe-170.c
@@ -176,7 +176,7 @@
 #define VFE_BUS_WM_FRAME_INC(n)			(0x2258 + (n) * 0x100)
 #define VFE_BUS_WM_BURST_LIMIT(n)		(0x225c + (n) * 0x100)
 
-static void vfe_hw_version_read(struct vfe_device *vfe, struct device *dev)
+static void vfe_hw_version_read(struct vfe_device *vfe)
 {
 	u32 hw_version = readl_relaxed(vfe->base + VFE_HW_VERSION);
 
@@ -184,7 +184,8 @@ static void vfe_hw_version_read(struct vfe_device *vfe, struct device *dev)
 	u32 rev = (hw_version >> 16) & 0xFFF;
 	u32 step = hw_version & 0xFFFF;
 
-	dev_dbg(dev, "VFE HW Version = %u.%u.%u\n", gen, rev, step);
+	dev_dbg(vfe->camss->dev, "VFE HW Version = %u.%u.%u\n",
+		gen, rev, step);
 }
 
 static inline void vfe_reg_clr(struct vfe_device *vfe, u32 reg, u32 clr_bits)
diff --git a/drivers/media/platform/qcom/camss/camss-vfe-4-1.c b/drivers/media/platform/qcom/camss/camss-vfe-4-1.c
index 53c56a8d45458..614c266e8cd1f 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe-4-1.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe-4-1.c
@@ -210,11 +210,11 @@
 #define MSM_VFE_VFE0_UB_SIZE 1023
 #define MSM_VFE_VFE0_UB_SIZE_RDI (MSM_VFE_VFE0_UB_SIZE / 3)
 
-static void vfe_hw_version_read(struct vfe_device *vfe, struct device *dev)
+static void vfe_hw_version_read(struct vfe_device *vfe)
 {
 	u32 hw_version = readl_relaxed(vfe->base + VFE_0_HW_VERSION);
 
-	dev_dbg(dev, "VFE HW Version = 0x%08x\n", hw_version);
+	dev_dbg(vfe->camss->dev, "VFE HW Version = 0x%08x\n", hw_version);
 }
 
 static u16 vfe_get_ub_size(u8 vfe_id)
diff --git a/drivers/media/platform/qcom/camss/camss-vfe-4-7.c b/drivers/media/platform/qcom/camss/camss-vfe-4-7.c
index 13f0fa6a7d60c..aa175e0f6331c 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe-4-7.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe-4-7.c
@@ -254,11 +254,11 @@
 #define MSM_VFE_VFE1_UB_SIZE 1535
 #define MSM_VFE_VFE1_UB_SIZE_RDI (MSM_VFE_VFE1_UB_SIZE / 3)
 
-static void vfe_hw_version_read(struct vfe_device *vfe, struct device *dev)
+static void vfe_hw_version_read(struct vfe_device *vfe)
 {
 	u32 hw_version = readl_relaxed(vfe->base + VFE_0_HW_VERSION);
 
-	dev_dbg(dev, "VFE HW Version = 0x%08x\n", hw_version);
+	dev_dbg(vfe->camss->dev, "VFE HW Version = 0x%08x\n", hw_version);
 }
 
 static u16 vfe_get_ub_size(u8 vfe_id)
diff --git a/drivers/media/platform/qcom/camss/camss-vfe-4-8.c b/drivers/media/platform/qcom/camss/camss-vfe-4-8.c
index 03f92a6737b0f..b897f5163c5da 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe-4-8.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe-4-8.c
@@ -247,11 +247,11 @@
 #define MSM_VFE_VFE1_UB_SIZE 1535
 #define MSM_VFE_VFE1_UB_SIZE_RDI (MSM_VFE_VFE1_UB_SIZE / 3)
 
-static void vfe_hw_version_read(struct vfe_device *vfe, struct device *dev)
+static void vfe_hw_version_read(struct vfe_device *vfe)
 {
 	u32 hw_version = readl_relaxed(vfe->base + VFE_0_HW_VERSION);
 
-	dev_dbg(dev, "VFE HW Version = 0x%08x\n", hw_version);
+	dev_dbg(vfe->camss->dev, "VFE HW Version = 0x%08x\n", hw_version);
 }
 
 static inline void vfe_reg_clr(struct vfe_device *vfe, u32 reg, u32 clr_bits)
diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
index 72a26dea84212..8aeba618ad380 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe.c
@@ -1300,7 +1300,7 @@ int msm_vfe_subdev_init(struct camss *camss, struct vfe_device *vfe,
 		return -EINVAL;
 	}
 	vfe->ops->subdev_init(dev, vfe);
-	vfe->ops->hw_version_read(vfe, dev);
+	vfe->ops->hw_version_read(vfe);
 
 	/* Memory */
 
diff --git a/drivers/media/platform/qcom/camss/camss-vfe.h b/drivers/media/platform/qcom/camss/camss-vfe.h
index 844b9275031d9..cca251816d284 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.h
+++ b/drivers/media/platform/qcom/camss/camss-vfe.h
@@ -103,7 +103,7 @@ struct vfe_device;
 struct vfe_hw_ops {
 	void (*enable_irq_common)(struct vfe_device *vfe);
 	void (*global_reset)(struct vfe_device *vfe);
-	void (*hw_version_read)(struct vfe_device *vfe, struct device *dev);
+	void (*hw_version_read)(struct vfe_device *vfe);
 	irqreturn_t (*isr)(int irq, void *dev);
 	void (*isr_read)(struct vfe_device *vfe, u32 *value0, u32 *value1);
 	void (*pm_domain_off)(struct vfe_device *vfe);
-- 
2.53.0

