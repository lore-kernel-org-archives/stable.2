Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686F8483831;
	Mon,  5 Oct 2026 13:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791206911; cv=pass; b=KHG5/GcUSrRYsHk7p7ILKLmuujwZjAjDuwyoc2jO3jNTLbQkufZeWj2omFGQ88M7/LKBFORxjlLmasSupYRynPeZXlRIiSUN7wBfkcEZvV//MUSniGI4ta6nkhraHQrnBL9vho2SRa9prM35hfWUfSLgtHHgJ+GScIJ9G8cBRVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791206911; c=relaxed/simple;
	bh=zqMjDW9XcckY4Q9BC4MUHyEe/RMuBVvJWCYstB1ZWyc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TsntmCWfTCh/eq6ZRpvUOsMP4heZI/JBAXiULNKpaFunCWK0TNnyukCRR7Tw3bHohkzwO/DL8EwJWO80RSMJTDixZOfIJQAFnriK+AtvEZtRH1n195Oy7kXL8whfpdv6vvYDinLRnlG1jC6kvSvWV58k3TZlkFZfVnrEgfX31BI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=GDrb1D6k; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="GDrb1D6k"
Received: from [127.0.1.1] (unknown [IPv6:2a02:560:5ca5:d100:9ebf:dff:fe00:fdb5])
	(Authenticated sender: sha@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 3DC7E202013;
	Mon, 05 Oct 2026 15:28:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791206902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qprud1QZ951MHLpiIP6SCwgCJESiKNFWNtMKb7r9D60=;
	b=GDrb1D6kDme+esnJ03myAfioVSDafAD07XGrR/ImSY87WPTdwm+B2ckGRdtirkfspONXvr
	eyMKTKWM8lDb7a4M3fVxPusqIHMxbvr6miI8APXxkxErPbezO/eK74y/OB0XOrxU6yVA9a
	8DcWRouWd7WaCRDw8zikTguDt9JpJhb736ICcmqk1sahXI9T/hBToAfn3CV4U8p8K7ut+l
	egOuriuvOLKdpUM3+SX1GRK8pBiognh9F8Buel7ABz0GVX6BYLN1lFBNazTz//HxohA6rC
	Q1DtUYPagtIGBg+DUSPJI3EUvQPH3TzVmPEM6yQ6ZxZG72Qqk8OvizHBFCToUQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791206902; a=rsa-sha256;
	cv=none;
	b=CosbWXjZueWDjOyUCdSLM4cx2jhaDdgiCmgy8fseUn964BNLrHcFAfDSPYj7y8kcJe1fXV
	bEISNhASDnJscky8VToOTHb35Cg9k3yjlSeKygCnQ7Il4Pratl+3dg+Vr+J+2IGjmPW/TH
	HM3aB/3kWuUeizE4jH9FZBJSMJOpCtAVWYLD5Ge1fU4lLL+djuoAXch2IYWD1Ts4j7hg9k
	olQyELKWRuTt3gWMmniMXOKUl0JyN+WkKJoZW/zH4TJ5DKlFCdgAg94qqP9XU+9giF/Iyh
	fUU/vo+fcVZ4uPaBcapU+uGyim25iwHNkyykVLSCT+YAEKxhncvQKiiy4P6xow==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sha@pengutronix.de smtp.mailfrom=s.hauer@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791206902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qprud1QZ951MHLpiIP6SCwgCJESiKNFWNtMKb7r9D60=;
	b=d4L9kVYIe3HMhfQHIkUk4HEpauGFP0b5wwCETpj9LrNO0AUbx1fsgHeAYcfnzmR+z6pf9m
	+w+rvzLHj7VDDgqM1ZhFlQ7eyTdd2Td2HSx3cUMKuaBtuS7amMhF7vTLWrzwNBxzZxW/MB
	n/4BvXH35BaGJF0qg20PuuHDUedvgg4pyGwbpbrvz5Wf5xNVH1zJV+Ny4ZzNCMEMP+Omvg
	srVgYFDqQEF65s76XBzMcM2OEeUiucYo9jXf3SFZ3NC6YD4fZH4JaHSIsU7RHxZGmLvQad
	AtDzgkoh51AGhEyfMY6oK3XchUzyVtqwe+C4bNZ9e/nQIdcebUjrzf7Hz3DzBA==
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Mon, 05 Oct 2026 15:28:20 +0200
Subject: [PATCH v3 01/10] media: synopsys: hdmirx: free the driver data
 when the last user is gone
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-hdmirx-media-v3-1-71a11a2e3e76@pengutronix.de>
References: <20261005-hdmirx-media-v3-0-71a11a2e3e76@pengutronix.de>
In-Reply-To: <20261005-hdmirx-media-v3-0-71a11a2e3e76@pengutronix.de>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans Verkuil <hverkuil@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dingxian Wen <shawn.wen@rock-chips.com>, 
 Shreeya Patel <shreeya.patel@collabora.com>
Cc: Gerald Loacker <gerald.loacker@wolfvision.net>, 
 Lucas Sinn <lucas.sinn@wolfvision.net>, linux-media@vger.kernel.org, 
 devicetree@vger.kernel.org, kernel@collabora.com, 
 linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791206902; l=6170;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=zqMjDW9XcckY4Q9BC4MUHyEe/RMuBVvJWCYstB1ZWyc=;
 b=CgQUg/L2jKmRCAeVGNnv6lJw0QGMQsiZjAGqPdGWtTas0188c6IHfW8zi6D9/EC04z+4AIGoQ
 R7pvknq8XHjB/TtRkG7cSsc2i4tf5CANNfISFs00bBVJWv+vx2UBmZp
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=

The driver data is allocated with devm_kzalloc() and contains the
video_device, the vb2 queue and the control handler. devres frees it when
the device is unbound, but an open file descriptor on the video device
node keeps the video_device referenced beyond that point:
video_unregister_device() only drops the reference taken at registration,
and the core's release of the device node is deferred until the last
close. When that close comes, the core calls the vb2 release fop on the
freed queue and v4l2_device_release() reads the minor, the cdev and the
release callback from the freed video_device. A file that subscribed to
control events additionally has the core look the control up in the
freed handler.

Documentation/driver-api/media/v4l2-dev.rst asks drivers that embed the
video_device to free the containing structure from a release callback,
when the last user of the device node is gone. Do that, using the
v4l2_device release callback since that refcount is taken per registered
device node. Allocate the driver data with kzalloc(), free it together
with the control handler from the release callback, and have remove() and
the probe error paths drop the reference instead of relying on devres.
Error paths before v4l2_device_register() free the allocation directly,
no reference exists yet.

With the controls alive until the last user is gone, hdmirx_disable() can
run before the control handler is freed on both remove and the probe
error paths. The NULL checks in hdmirx_plugout() and the pointer clearing
in hdmirx_remove() that worked around the old order go away. The
hdl->error path in probe also no longer leaks the handler.

Fixes: 7b59b132ad439 ("media: platform: synopsys: Add support for HDMI input driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 .../media/platform/synopsys/hdmirx/snps_hdmirx.c   | 56 +++++++++++++---------
 1 file changed, 34 insertions(+), 22 deletions(-)

diff --git a/drivers/media/platform/synopsys/hdmirx/snps_hdmirx.c b/drivers/media/platform/synopsys/hdmirx/snps_hdmirx.c
index 25f8ca0d6d946..bc541431638e7 100644
--- a/drivers/media/platform/synopsys/hdmirx/snps_hdmirx.c
+++ b/drivers/media/platform/synopsys/hdmirx/snps_hdmirx.c
@@ -637,13 +637,9 @@ static void hdmirx_plugout(struct snps_hdmirx_dev *hdmirx_dev)
 	hdmirx_writel(hdmirx_dev, PHYCREG_CONFIG0, 0x0);
 	cancel_delayed_work(&hdmirx_dev->delayed_work_res_change);
 
-	/* will be NULL on driver removal */
-	if (hdmirx_dev->rgb_range)
-		v4l2_ctrl_s_ctrl(hdmirx_dev->rgb_range, V4L2_DV_RGB_RANGE_AUTO);
-
-	if (hdmirx_dev->content_type)
-		v4l2_ctrl_s_ctrl(hdmirx_dev->content_type,
-				 V4L2_DV_IT_CONTENT_TYPE_NO_ITC);
+	v4l2_ctrl_s_ctrl(hdmirx_dev->rgb_range, V4L2_DV_RGB_RANGE_AUTO);
+	v4l2_ctrl_s_ctrl(hdmirx_dev->content_type,
+			 V4L2_DV_IT_CONTENT_TYPE_NO_ITC);
 
 	hdmirx_dev->plugged = false;
 }
@@ -2646,6 +2642,16 @@ static int hdmirx_register_cec(struct snps_hdmirx_dev *hdmirx_dev,
 	return 0;
 }
 
+/* Runs when the last user of a device node is gone, possibly after remove() */
+static void hdmirx_v4l2_release(struct v4l2_device *v4l2_dev)
+{
+	struct snps_hdmirx_dev *hdmirx_dev =
+		container_of(v4l2_dev, struct snps_hdmirx_dev, v4l2_dev);
+
+	v4l2_ctrl_handler_free(&hdmirx_dev->hdl);
+	kfree(hdmirx_dev);
+}
+
 static int hdmirx_probe(struct platform_device *pdev)
 {
 	struct snps_hdmirx_dev *hdmirx_dev;
@@ -2655,7 +2661,7 @@ static int hdmirx_probe(struct platform_device *pdev)
 	struct v4l2_device *v4l2_dev;
 	int ret;
 
-	hdmirx_dev = devm_kzalloc(dev, sizeof(*hdmirx_dev), GFP_KERNEL);
+	hdmirx_dev = kzalloc_obj(*hdmirx_dev);
 	if (!hdmirx_dev)
 		return -ENOMEM;
 
@@ -2665,23 +2671,25 @@ static int hdmirx_probe(struct platform_device *pdev)
 	 */
 	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
 	if (ret)
-		return ret;
+		goto err_free;
 
 	hdmirx_dev->dev = dev;
 	dev_set_drvdata(dev, hdmirx_dev);
 
 	ret = hdmirx_parse_dt(hdmirx_dev);
 	if (ret)
-		return ret;
+		goto err_free;
 
 	ret = hdmirx_setup_irq(hdmirx_dev, pdev);
 	if (ret)
-		return ret;
+		goto err_free;
 
 	hdmirx_dev->regs = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(hdmirx_dev->regs))
-		return dev_err_probe(dev, PTR_ERR(hdmirx_dev->regs),
-				     "failed to remap regs resource\n");
+	if (IS_ERR(hdmirx_dev->regs)) {
+		ret = dev_err_probe(dev, PTR_ERR(hdmirx_dev->regs),
+				    "failed to remap regs resource\n");
+		goto err_free;
+	}
 
 	mutex_init(&hdmirx_dev->phy_rw_lock);
 	mutex_init(&hdmirx_dev->stream_lock);
@@ -2735,11 +2743,12 @@ static int hdmirx_probe(struct platform_device *pdev)
 		goto err_pm;
 	}
 	hdmirx_dev->v4l2_dev.ctrl_handler = hdl;
+	hdmirx_dev->v4l2_dev.release = hdmirx_v4l2_release;
 
 	ret = v4l2_device_register(dev, &hdmirx_dev->v4l2_dev);
 	if (ret < 0) {
 		dev_err_probe(dev, ret, "v4l2 device registration failed\n");
-		goto err_hdl;
+		goto err_pm;
 	}
 
 	stream = &hdmirx_dev->stream;
@@ -2771,10 +2780,16 @@ static int hdmirx_probe(struct platform_device *pdev)
 	vb2_video_unregister_device(&hdmirx_dev->stream.vdev);
 err_unreg_v4l2_dev:
 	v4l2_device_unregister(&hdmirx_dev->v4l2_dev);
-err_hdl:
-	v4l2_ctrl_handler_free(&hdmirx_dev->hdl);
+	hdmirx_disable(dev);
+	v4l2_device_put(&hdmirx_dev->v4l2_dev);
+
+	return ret;
+
 err_pm:
 	hdmirx_disable(dev);
+	v4l2_ctrl_handler_free(&hdmirx_dev->hdl);
+err_free:
+	kfree(hdmirx_dev);
 
 	return ret;
 }
@@ -2792,16 +2807,13 @@ static void hdmirx_remove(struct platform_device *pdev)
 	hdmirx_disable_irq(dev);
 
 	vb2_video_unregister_device(&hdmirx_dev->stream.vdev);
-	v4l2_ctrl_handler_free(&hdmirx_dev->hdl);
 	v4l2_device_unregister(&hdmirx_dev->v4l2_dev);
 
-	/* touched by hdmirx_disable()->hdmirx_plugout() */
-	hdmirx_dev->rgb_range = NULL;
-	hdmirx_dev->content_type = NULL;
-
 	hdmirx_disable(dev);
 
 	reset_control_bulk_assert(HDMIRX_NUM_RST, hdmirx_dev->resets);
+
+	v4l2_device_put(&hdmirx_dev->v4l2_dev);
 }
 
 static const struct of_device_id hdmirx_id[] = {

-- 
2.47.3

