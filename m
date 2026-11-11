Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794370424;
	b=CPFR17BhFMRSiQJSQjV6kI3Vt9/YxehQlLCEkaJbv5EFSa5J0swmczy/Ir/xjV+vNSCv
	 sOgzoTOQ6oEiBiqmrwLqwqz5vXd6TexNLnzwP958dNog9UnkfcchCoM/xWcWDYoUI2CNm
	 pVJyodYyO2ac+7bTcIQ7edR3u2pO/WghiS+xi09RnX8pcQg001c2q5wH9wLxYQjuL9Gx6
	 sMFhWqbcWvWnUchZ7ggjmrcu/WCW0B970Jd/WNV58bqGGsFYhIUrI4fuTXOB6DMYhXZVV
	 tSYidRzncmtoPAhrZ4/4aHJJL9xJW/8ygGm2NCuzEDM7h98ob6ZoYLqVFZ6Xr0GT29w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794370424;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=X1FS6B2lFFw9jiLdQNdUiLEp2DCNDJsCj7hNyHT2Ov4=;
	b=1dihjZ1r1kmhlmp5UfPe3VG2rE69YYqMpBTshnQHiFmhHcv/vDceI0SrZ1AV4MapSpVH
	 GYuBCiKU550RJ3qJSb/N+I3dLmWSmJ1T9EHyHLOY8s3097pN1vVR2082AghSoDyHeyxSf
	 XMsW9D9DTis7XFy19mhdhy8kNVapXRY1n9jShyS9apiqR4obuSrMsF2jQvptMvMQp+C7l
	 m+LKtQRnpfUQdDV1t/2YE6CSUrxPTI/wkx7gFWw9jiOdpVAgb2V56mLQ7VokvBa5FBbwf
	 LlhySzlsbHTttn0UAJOBz6OrXVkTZKrNtzUqOGFeVh/HloTka69mDa76L+GxRiSuTBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jfby4rcZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C2C606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 04:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jfby4rcZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C5E91F00A05;
	Wed, 11 Nov 2026 04:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794370423;
	bh=X1FS6B2lFFw9jiLdQNdUiLEp2DCNDJsCj7hNyHT2Ov4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jfby4rcZnzLJbpFKXz+fU71vFWmQ+mIFNEBfRfURh0P90t/gy82aKD+78iaM0VPK+
	 Z24DauGRHDnxanZ5ow2o7X0F08oVDpRAoJIv7fMsbJRewLwcnD4CJV23FXl2Hbsgkb
	 yPrYYV17+WAlniO5mzPi+LvpjGTYFyfM8JO0BS3FZ6EFHa4ubnC7r9+T5IhV1uzmG7
	 ayH9XDipstqNDNBoXLZuheHs4uaoDPaL1CJEkZ03i2DXHbXzZdzCPgxMA48XEUPHG5
	 eLsxuRp10MsKeb34eQopmtcJf3rLJgMoJAWHASYy9gQoVOgZ+kkQFhFuA2ruEe0C2v
	 sV9Frz/3SVGzQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 5/6] media: qcom: camss: Move vfe_disable into a common routine where applicable
Date: Tue, 10 Nov 2026 23:13:37 -0500
Message-ID: <20261111041132.1029567-5-sashal@kernel.org>
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

From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

[ Upstream commit 90cc4555730bfd0fc6af5c8a5a81d80bfce4cff7 ]

We can move vfe_disable() into a common routine in the core VFE file
provided we make wm_stop() a VFE specific callback.

The callback is required to capture the case where VFE 17x currently isn't
VC enabled where as VFE 480 is.

Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

Omit the VFE 480 conversion because that backend is absent. Include
the upstream reset-error propagation in vfe_disable() so the
follow-up reset-ordering fix applies cleanly.

Stable-dep-of: e5d4b0e69a40 ("media: qcom: camss: vfe: Fix VFE reset while another line is streaming")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../media/platform/qcom/camss/camss-vfe-170.c | 40 +----------------
 drivers/media/platform/qcom/camss/camss-vfe.c | 43 +++++++++++++++++++
 drivers/media/platform/qcom/camss/camss-vfe.h |  9 ++++
 3 files changed, 53 insertions(+), 39 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-vfe-170.c b/drivers/media/platform/qcom/camss/camss-vfe-170.c
index e2ca0aec3a697..3c678b6de8203 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe-170.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe-170.c
@@ -499,22 +499,6 @@ static int vfe_enable_output(struct vfe_line *line)
 	return 0;
 }
 
-static void vfe_disable_output(struct vfe_line *line)
-{
-	struct vfe_device *vfe = to_vfe(line);
-	struct vfe_output *output = &line->output;
-	unsigned long flags;
-	unsigned int i;
-
-	spin_lock_irqsave(&vfe->output_lock, flags);
-	for (i = 0; i < output->wm_num; i++)
-		vfe_wm_stop(vfe, output->wm_idx[i]);
-	output->gen2.active_num = 0;
-	spin_unlock_irqrestore(&vfe->output_lock, flags);
-
-	vfe_reset(vfe);
-}
-
 /*
  * vfe_enable - Enable streaming on VFE line
  * @line: VFE line
@@ -560,29 +544,6 @@ static int vfe_enable(struct vfe_line *line)
 	return ret;
 }
 
-/*
- * vfe_disable - Disable streaming on VFE line
- * @line: VFE line
- *
- * Return 0 on success or a negative error code otherwise
- */
-static int vfe_disable(struct vfe_line *line)
-{
-	struct vfe_device *vfe = to_vfe(line);
-
-	vfe_disable_output(line);
-
-	vfe_put_output(line);
-
-	mutex_lock(&vfe->stream_lock);
-
-	vfe->stream_count--;
-
-	mutex_unlock(&vfe->stream_lock);
-
-	return 0;
-}
-
 /*
  * vfe_isr_sof - Process start of frame interrupt
  * @vfe: VFE Device
@@ -759,4 +720,5 @@ const struct vfe_hw_ops vfe_ops_170 = {
 	.vfe_enable = vfe_enable,
 	.vfe_halt = vfe_halt,
 	.violation_read = vfe_violation_read,
+	.vfe_wm_stop = vfe_wm_stop,
 };
diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
index ce8c53f07ea70..41c63eec091e1 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe.c
@@ -405,6 +405,49 @@ int vfe_put_output(struct vfe_line *line)
 	return 0;
 }
 
+static int vfe_disable_output(struct vfe_line *line)
+{
+	struct vfe_device *vfe = to_vfe(line);
+	struct vfe_output *output = &line->output;
+	unsigned long flags;
+	unsigned int i;
+
+	spin_lock_irqsave(&vfe->output_lock, flags);
+	for (i = 0; i < output->wm_num; i++)
+		vfe->ops->vfe_wm_stop(vfe, output->wm_idx[i]);
+	output->gen2.active_num = 0;
+	spin_unlock_irqrestore(&vfe->output_lock, flags);
+
+	return vfe_reset(vfe);
+}
+
+/*
+ * vfe_disable - Disable streaming on VFE line
+ * @line: VFE line
+ *
+ * Return 0 on success or a negative error code otherwise
+ */
+int vfe_disable(struct vfe_line *line)
+{
+	struct vfe_device *vfe = to_vfe(line);
+	int ret;
+
+	ret = vfe_disable_output(line);
+	if (ret)
+		goto error;
+
+	vfe_put_output(line);
+
+	mutex_lock(&vfe->stream_lock);
+
+	vfe->stream_count--;
+
+	mutex_unlock(&vfe->stream_lock);
+
+error:
+	return ret;
+}
+
 /**
  * vfe_isr_comp_done() - Process composite image done interrupt
  * @vfe: VFE Device
diff --git a/drivers/media/platform/qcom/camss/camss-vfe.h b/drivers/media/platform/qcom/camss/camss-vfe.h
index f166d176cb771..28a4c69d96c94 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.h
+++ b/drivers/media/platform/qcom/camss/camss-vfe.h
@@ -116,6 +116,7 @@ struct vfe_hw_ops {
 	int (*vfe_enable)(struct vfe_line *line);
 	int (*vfe_halt)(struct vfe_device *vfe);
 	void (*violation_read)(struct vfe_device *vfe);
+	void (*vfe_wm_stop)(struct vfe_device *vfe, u8 wm);
 };
 
 struct vfe_isr_ops {
@@ -197,6 +198,14 @@ int vfe_reserve_wm(struct vfe_device *vfe, enum vfe_line_id line_id);
  */
 int vfe_reset(struct vfe_device *vfe);
 
+/*
+ * vfe_disable - Disable streaming on VFE line
+ * @line: VFE line
+ *
+ * Return 0 on success or a negative error code otherwise
+ */
+int vfe_disable(struct vfe_line *line);
+
 extern const struct vfe_hw_ops vfe_ops_4_1;
 extern const struct vfe_hw_ops vfe_ops_4_7;
 extern const struct vfe_hw_ops vfe_ops_4_8;
-- 
2.53.0

