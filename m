Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B243191D6
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 11:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786187842; cv=none; b=c3vQGHTllMXYeyoBia0IBU9oHeSq0HfoKlimx2W5y1POoX8qescztDBQHIjrzhOsImCTm9EM6UIR6zDyMQ1ivpWfo6Q4NY0ji8LztrxFtTGNkRXo3OfADEFQvbSdEhe9ZjbTtvQ8TvsP+bQUOsvsW10pxYk+FPEBJbaX3CEjqWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786187842; c=relaxed/simple;
	bh=/o1udNNLV+FNe1R9p8BzEoEJfIqD9mThtLK2mmEohxQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b/58C2bg5mi5oIUfsKfj7tpGLI/bgvt79Rhe26FCVeWayTQCLS1SdtSNLtY8udGEPsQl6l2g3dW6X1pH93oI8CT5V4vzz02M9ZZvdl+FYCuHYhddOVNqNamOyuzrpKlbhQ8O0sW6ipPMS8Hi1PhQ7b7AhzwsZwJs21TqoW1Ox7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M0ReT1tr; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0ReT1tr"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-ca80d708489so218539a12.1
        for <stable@vger.kernel.org>; Sat, 08 Aug 2026 04:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786187840; x=1786792640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VegdV0CGVtEAsdoGYq2fWs6TLBlXPmk2Egy9/veY9KE=;
        b=M0ReT1trpbHUGbvE6ipiIDdU4zdS3ysLx4hoMj5chMA28BJnjH5UFJcKzTUIIXkruZ
         /CJqS0VEOP5bh0SectkjAbRacELSDSQ8U+SJC0sLbiRgZk9PRxAbtA5V0BwBLguh9XUV
         Lct2voctfZD/31GGGfm87iXK5wKg7/RdsnCbyfh4EkTNAu8xpfayoS0qAPeKiR2U4ffX
         CWhcLdwm0UH7LrbFUMsHBn8ntP3qWzbTXKLO2Unv4MmRFxVR0JM3o2kgdeZZ464yKbX2
         2qXVNnYqz36WX0qCN0L/mm5EK3aABVBj8s4aPSAwXYIz4bCiDZ/CMUaLlcxer29uYBxH
         YNyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786187840; x=1786792640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VegdV0CGVtEAsdoGYq2fWs6TLBlXPmk2Egy9/veY9KE=;
        b=ski0ZNAaV+8PD8HprCEJftuV+PSnBNE+nXpdP4bVV0EoZPqhheqC/Z1TmRfR28MsHE
         2KwPkImjJU1yVXgAzl01PTK4xWbXsSnTzJYQIFZmAMYD7RHVTo/RyVp9ofmeFhT90d34
         P0uB90FyaO3rl65BTC5FXRWTjuANJrCFw6OOFtLuSCl94fPnbHJUpcMlgzn62anh5/3d
         jFoQbVopMQ+0IXrHLNeKFI2NUspGgzrvNwFVlaVULeW9Ldz0ERr57lSfl48TC1Ye1jTm
         aqKyJu76hF3X1jvhXQzn7T+kowa5F3jVYQUc4bZzbYMiH1GZ7EKuWn4Ytrz9orxW5uKM
         MFOQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq/LhzYIMSDXJMlkyKesXDuvyg4rL73pkm7vrB3tpwDOAO3EpYgn9kx2BUOos8Y7Y5DuLyIlEY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8CMxy3N0y8s8k5pw1gp63MFoaT4H3bvCR0FfC/z0gUuTl+sRV
	GVoQw9GfUmnoRD24Rf7AUWvwCACxiiKwRT597hR2J5Z2UZ4Pd6cCaL41
X-Gm-Gg: AR+sD11IdgY3yJ10m+eyTwpZHv1WcegAQielAW+DGthPMmSYePDDZmXZBWEBe74kvZo
	W/h6AM+d3YYh9oYu3k72gYO9/QUkJGe2Px3NHRzxvCDSIM5CSxb99GuvQyUGUqO4JvFq2gMkTFp
	/PC8Rr3SPuYzMAgv8IVsa57CClIgV6dNWRyJdb3R8FjPwzXV13NmGEVnkUak9HHlwDQH4j9+Hi3
	S/NMXLOHK7ce2d06CGUUH2ybuvDpWUMMLoswzmYUWDnXCTN5eSAlOfI54Z/Tqux3FKd5URGLBsx
	bPHDevAEjwauO5gb749TGTnOskOkmEzE7+aOsFLWi1Gq8RBYuyKa/4asmSRDEDUcwi4jR33NdDr
	ojgafZO954sqMTuikqSZgVn6AN0025Lz2ta+qkoP7xXRBMy0if7LaxZj20wigIC+fWg34sT9Glu
	qiacb/sW8F6bMx3M77qskpKb1+/W7/M2jXpNL7EXCL/6l+jqKvH5qlZmHg9L4LL6D3grYW1E7ld
	8Lclg==
X-Received: by 2002:a05:6300:141:b0:3c3:750f:3cf9 with SMTP id adf61e73a8af0-3cbd3ac3fbemr6024104637.11.1786187840297;
        Sat, 08 Aug 2026 04:17:20 -0700 (PDT)
Received: from SGN-LDSENG.tasernet.com ([2405:4800:5cc3:11a:1ac0:4dff:fe8b:4a69])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315bebdf796sm17179976eec.22.2026.08.08.04.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 04:17:19 -0700 (PDT)
From: Cong Nguyen <congnt264@gmail.com>
To: Maxime Ripard <mripard@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org
Cc: Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Cong Nguyen <congnt264@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v1 2/3] media: sun4i-csi: disable interrupts when stopping streaming
Date: Sat,  8 Aug 2026 18:17:09 +0700
Message-Id: <f0f044148ec5c160d76e6e38d1f53393ec56578a.1786184456.git.congnt264@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1786184456.git.congnt264@gmail.com>
References: <cover.1786184456.git.congnt264@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sun4i_csi_start_streaming() enables the frame-done interrupt in
CSI_INT_EN_REG, but sun4i_csi_stop_streaming() only stops the capture
engine (CSI_CPT_CTRL_REG) via sun4i_csi_capture_stop(). It never disables
the interrupt source nor synchronizes with the handler.

Capture stops at the end of the current frame, so a frame-done interrupt
can still fire shortly after stop_streaming() returns. If userspace then
closes the device, sun4i_csi_release() calls pm_runtime_put() and the CSI
block is powered down (clocks gated, reset asserted). A delayed interrupt
handler would then read/write CSI registers on the gated block, which can
hang or crash the system.

Clear CSI_INT_EN_REG and call synchronize_irq() in stop_streaming(), before
returning the active buffers and freeing the scratch buffer, so no handler
can run past this point. Store the IRQ number in struct sun4i_csi so it is
available here.

Fixes: 577bbf23b758 ("media: sunxi: Add A10 CSI driver")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4
Signed-off-by: Cong Nguyen <congnt264@gmail.com>
---
 drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.h |  1 +
 drivers/media/platform/sunxi/sun4i-csi/sun4i_dma.c | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.h b/drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.h
index 4e0c2df45d4d..51173faea871 100644
--- a/drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.h
+++ b/drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.h
@@ -112,6 +112,7 @@ struct sun4i_csi {
 	const struct sun4i_csi_traits	*traits;
 
 	void __iomem			*regs;
+	int				irq;
 	struct clk			*bus_clk;
 	struct clk			*isp_clk;
 	struct clk			*ram_clk;
diff --git a/drivers/media/platform/sunxi/sun4i-csi/sun4i_dma.c b/drivers/media/platform/sunxi/sun4i-csi/sun4i_dma.c
index e911c7f7acc5..da697f39f2bc 100644
--- a/drivers/media/platform/sunxi/sun4i-csi/sun4i_dma.c
+++ b/drivers/media/platform/sunxi/sun4i-csi/sun4i_dma.c
@@ -354,6 +354,16 @@ static void sun4i_csi_stop_streaming(struct vb2_queue *vq)
 	v4l2_subdev_call(csi->src_subdev, video, s_stream, 0);
 	sun4i_csi_capture_stop(csi);
 
+	/*
+	 * Disable the frame done interrupt and wait for the handler to
+	 * finish. A frame may complete right as capture is stopped, so an
+	 * interrupt can still be pending here; without this the handler could
+	 * run after the device is powered down (pm_runtime_put() on release)
+	 * and access registers on a gated block.
+	 */
+	writel(0, csi->regs + CSI_INT_EN_REG);
+	synchronize_irq(csi->irq);
+
 	/* Release all active buffers */
 	spin_lock_irqsave(&csi->qlock, flags);
 	return_all_buffers(csi, VB2_BUF_STATE_ERROR);
@@ -438,6 +448,7 @@ int sun4i_csi_dma_register(struct sun4i_csi *csi, int irq)
 		dev_err(csi->dev, "Couldn't register our interrupt\n");
 		goto err_unregister_device;
 	}
+	csi->irq = irq;
 
 	return 0;
 
-- 
2.25.1

