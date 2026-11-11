Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794370423;
	b=MBrd9PzNdAkdhb/VW4HS/H+NNZTe9t/xeSSGiFAmv8uaxD6PMQJMTPMilt0Rl51teNUX
	 4oT43cw0jfZ6zCPQ5VmvYPmn5ore3r15oF3C71AfBFrI5lxVfnzTyxuwnYeDXknWytFlr
	 DGcfPwAP4a1+yF+0gWj7iaRd1i5HjepAGDm1VtlPF5mbfEF6NZNs6bXh7Yqm8DJVyko/D
	 oOEaBazwNgHJrVJlHTIuG1Qocuk5p+d1mQZoTlBP33B3ehD2XQZbiyU02B1exXx4Olymx
	 3eCsPU8mhZw+R+FAnqYa7xfgMmOa+iS92hMNXF69+dSSgi1QxJiD3eIKYvVggF2J9XQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794370423;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=IigvQtmWkKRzzFvhkOTNJkL7BRyRFTxRYHj9K8jGX+8=;
	b=3YaZ+V/Y1Ye4ZTFxMvHmH3io7Ecknfu3vfLkBAtknDzmh7tCrqYxkW5LKJpsOxSJbuDs
	 UsSAahiDkEDrocOL9SwtBXYJR72Hx9w3QJLLBw7n415oxCZNx+nUglC7OUORA9RHDj+SE
	 63qWpwi9O7GFEqyDv+9Hb+yuPGyBJEWv/TEHYaMh67tjhVa1UyBZnAxu+7aqhhNwFLSs0
	 YJ3BF6n5We1aUBcF3GI2U6g0wXvzYCA7MfjQ2xbt0kkWe+APR/MnHiaJHRHcsWaSFklQv
	 kymL3i2NvmMSvABmvrSHDfpyD1mwgw85tMXujG00Pqj8q2MeJFjFFMssMg5tlIf3JCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i5PZ3VPl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473D0606A320
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 04:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i5PZ3VPl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 790291F0089F;
	Wed, 11 Nov 2026 04:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794370423;
	bh=IigvQtmWkKRzzFvhkOTNJkL7BRyRFTxRYHj9K8jGX+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i5PZ3VPlowVI3oco7NjKin220gCDv1dhBKH53UK7rSNAE2OnSLftpagWVHdXz0H57
	 bT9x4ZBcG63BuxWgwu0doNMjSZuyUThWeasmd9m7782/MzdK7PmnfpaqICBLWegs0H
	 fDWhFtIo5Qo9EHkvg/TSFkjAght6sYIlFOA0vVBkadMN2gy0ZAe7vt3fTtdfHSsysB
	 OU+NV0op4rNAv4EXK6gsdUzXSDHSdlU+ASjUlP5frfm/bPZSud1qvElzI/6Vh9EG3M
	 NdnZNkMW7LXnwqbIz8wOhIp7AA7rDlunWukbGnJp+cYHPxPEKVhJ1Z9en22jaF3JVm
	 x/xq3s0x6jgxg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Robert Foss <robert.foss@linaro.org>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 4/6] media: camss: vfe: Rework vfe_hw_version_read() function definition
Date: Tue, 10 Nov 2026 23:13:36 -0500
Message-ID: <20261111041132.1029567-4-sashal@kernel.org>
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

[ Upstream commit d2e86540366e1701baf852ee0301323ff113459c ]

Expose the VFE version by returning the value read from the HW_VERSION
register.

Secondly, change the name of this function to conform with the CSID
equivalent.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Stable-dep-of: e5d4b0e69a40 ("media: qcom: camss: vfe: Fix VFE reset while another line is streaming")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/qcom/camss/camss-vfe-170.c | 6 ++++--
 drivers/media/platform/qcom/camss/camss-vfe-4-1.c | 6 ++++--
 drivers/media/platform/qcom/camss/camss-vfe-4-7.c | 6 ++++--
 drivers/media/platform/qcom/camss/camss-vfe-4-8.c | 6 ++++--
 drivers/media/platform/qcom/camss/camss-vfe.c     | 2 +-
 drivers/media/platform/qcom/camss/camss-vfe.h     | 2 +-
 6 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-vfe-170.c b/drivers/media/platform/qcom/camss/camss-vfe-170.c
index ad3c375a33fbf..e2ca0aec3a697 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe-170.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe-170.c
@@ -176,7 +176,7 @@
 #define VFE_BUS_WM_FRAME_INC(n)			(0x2258 + (n) * 0x100)
 #define VFE_BUS_WM_BURST_LIMIT(n)		(0x225c + (n) * 0x100)
 
-static void vfe_hw_version_read(struct vfe_device *vfe)
+static u32 vfe_hw_version(struct vfe_device *vfe)
 {
 	u32 hw_version = readl_relaxed(vfe->base + VFE_HW_VERSION);
 
@@ -186,6 +186,8 @@ static void vfe_hw_version_read(struct vfe_device *vfe)
 
 	dev_dbg(vfe->camss->dev, "VFE HW Version = %u.%u.%u\n",
 		gen, rev, step);
+
+	return hw_version;
 }
 
 static inline void vfe_reg_clr(struct vfe_device *vfe, u32 reg, u32 clr_bits)
@@ -745,7 +747,7 @@ static void vfe_subdev_init(struct device *dev, struct vfe_device *vfe)
 
 const struct vfe_hw_ops vfe_ops_170 = {
 	.global_reset = vfe_global_reset,
-	.hw_version_read = vfe_hw_version_read,
+	.hw_version = vfe_hw_version,
 	.isr_read = vfe_isr_read,
 	.isr = vfe_isr,
 	.pm_domain_off = vfe_pm_domain_off,
diff --git a/drivers/media/platform/qcom/camss/camss-vfe-4-1.c b/drivers/media/platform/qcom/camss/camss-vfe-4-1.c
index 614c266e8cd1f..7b7c9a0aaab28 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe-4-1.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe-4-1.c
@@ -210,11 +210,13 @@
 #define MSM_VFE_VFE0_UB_SIZE 1023
 #define MSM_VFE_VFE0_UB_SIZE_RDI (MSM_VFE_VFE0_UB_SIZE / 3)
 
-static void vfe_hw_version_read(struct vfe_device *vfe)
+static u32 vfe_hw_version(struct vfe_device *vfe)
 {
 	u32 hw_version = readl_relaxed(vfe->base + VFE_0_HW_VERSION);
 
 	dev_dbg(vfe->camss->dev, "VFE HW Version = 0x%08x\n", hw_version);
+
+	return hw_version;
 }
 
 static u16 vfe_get_ub_size(u8 vfe_id)
@@ -1004,7 +1006,7 @@ static void vfe_subdev_init(struct device *dev, struct vfe_device *vfe)
 
 const struct vfe_hw_ops vfe_ops_4_1 = {
 	.global_reset = vfe_global_reset,
-	.hw_version_read = vfe_hw_version_read,
+	.hw_version = vfe_hw_version,
 	.isr_read = vfe_isr_read,
 	.isr = vfe_isr,
 	.pm_domain_off = vfe_pm_domain_off,
diff --git a/drivers/media/platform/qcom/camss/camss-vfe-4-7.c b/drivers/media/platform/qcom/camss/camss-vfe-4-7.c
index aa175e0f6331c..2836b12ec9891 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe-4-7.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe-4-7.c
@@ -254,11 +254,13 @@
 #define MSM_VFE_VFE1_UB_SIZE 1535
 #define MSM_VFE_VFE1_UB_SIZE_RDI (MSM_VFE_VFE1_UB_SIZE / 3)
 
-static void vfe_hw_version_read(struct vfe_device *vfe)
+static u32 vfe_hw_version(struct vfe_device *vfe)
 {
 	u32 hw_version = readl_relaxed(vfe->base + VFE_0_HW_VERSION);
 
 	dev_dbg(vfe->camss->dev, "VFE HW Version = 0x%08x\n", hw_version);
+
+	return hw_version;
 }
 
 static u16 vfe_get_ub_size(u8 vfe_id)
@@ -1196,7 +1198,7 @@ static void vfe_subdev_init(struct device *dev, struct vfe_device *vfe)
 
 const struct vfe_hw_ops vfe_ops_4_7 = {
 	.global_reset = vfe_global_reset,
-	.hw_version_read = vfe_hw_version_read,
+	.hw_version = vfe_hw_version,
 	.isr_read = vfe_isr_read,
 	.isr = vfe_isr,
 	.pm_domain_off = vfe_pm_domain_off,
diff --git a/drivers/media/platform/qcom/camss/camss-vfe-4-8.c b/drivers/media/platform/qcom/camss/camss-vfe-4-8.c
index b897f5163c5da..19519234f727c 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe-4-8.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe-4-8.c
@@ -247,11 +247,13 @@
 #define MSM_VFE_VFE1_UB_SIZE 1535
 #define MSM_VFE_VFE1_UB_SIZE_RDI (MSM_VFE_VFE1_UB_SIZE / 3)
 
-static void vfe_hw_version_read(struct vfe_device *vfe)
+static u32 vfe_hw_version(struct vfe_device *vfe)
 {
 	u32 hw_version = readl_relaxed(vfe->base + VFE_0_HW_VERSION);
 
 	dev_dbg(vfe->camss->dev, "VFE HW Version = 0x%08x\n", hw_version);
+
+	return hw_version;
 }
 
 static inline void vfe_reg_clr(struct vfe_device *vfe, u32 reg, u32 clr_bits)
@@ -1180,7 +1182,7 @@ static void vfe_subdev_init(struct device *dev, struct vfe_device *vfe)
 
 const struct vfe_hw_ops vfe_ops_4_8 = {
 	.global_reset = vfe_global_reset,
-	.hw_version_read = vfe_hw_version_read,
+	.hw_version = vfe_hw_version,
 	.isr_read = vfe_isr_read,
 	.isr = vfe_isr,
 	.pm_domain_off = vfe_pm_domain_off,
diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
index 8aeba618ad380..ce8c53f07ea70 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe.c
@@ -1300,7 +1300,7 @@ int msm_vfe_subdev_init(struct camss *camss, struct vfe_device *vfe,
 		return -EINVAL;
 	}
 	vfe->ops->subdev_init(dev, vfe);
-	vfe->ops->hw_version_read(vfe);
+	vfe->ops->hw_version(vfe);
 
 	/* Memory */
 
diff --git a/drivers/media/platform/qcom/camss/camss-vfe.h b/drivers/media/platform/qcom/camss/camss-vfe.h
index cca251816d284..f166d176cb771 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.h
+++ b/drivers/media/platform/qcom/camss/camss-vfe.h
@@ -103,7 +103,7 @@ struct vfe_device;
 struct vfe_hw_ops {
 	void (*enable_irq_common)(struct vfe_device *vfe);
 	void (*global_reset)(struct vfe_device *vfe);
-	void (*hw_version_read)(struct vfe_device *vfe);
+	u32 (*hw_version)(struct vfe_device *vfe);
 	irqreturn_t (*isr)(int irq, void *dev);
 	void (*isr_read)(struct vfe_device *vfe, u32 *value0, u32 *value1);
 	void (*pm_domain_off)(struct vfe_device *vfe);
-- 
2.53.0

