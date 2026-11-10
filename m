Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794314376;
	b=J0Xby2duH9IRl0GGCNZ9yDMdsn2YRT7OKp8eT9DTKa3LdU2ABuUj9DigFq8hlnRQyDpz
	 UM077uVSWolqCkF9hTi42fPi6xNd9UPsBiwBifbMqM9cVhNSlxHeoD4q5Avs/990fl1Ho
	 5CTd7EksJnWKZ/QwRngdSEY1QwTb6lwiRQIF7FP4sCycAfPOaOwIMsMcPvG68sRoBniMK
	 5LzMH5B98Rt9lCNa3UN+C/sntvHx4oWRvFQxrdc20h157W45YCTuKLhFlffv1jx+O0mrG
	 mfT6GEAdeE9W+PKahzGwhnWj2k2pjZA/+ozH+5yA6dG5AVxqPaeLL6P7oi2OSce9q8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794314376;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=XZkohOBCNW/myDH3lC/RvZjkNbDjctQKn+HUHOtEmOY=;
	b=rmKWGs75/37HB7S4q16Ko32SSb306w+jEkURjVQzhIGucGQmLuJSnsGKfoZCh+mvLUti
	 LMnxCILjsatPD26wbotGyLfLA45LtHBqE777TrXIZq59ibhZ/wc28F7AQHvc49bU1Y4Q7
	 2seYALMlSXm7QEDQY0CKFxDLPRR/qYNwKl1x+u9ywW/DpsHW9urGVr8vSorLGzy0I8d0G
	 Sla1PKHlCTz0N61RzTiYduLWv+w5hNWZWVt4UEGPglhbtFD0qUrTs6FPW1u4lHRqGjmGA
	 Y73So1EyasTecOBYvGKMLBlcOX6WLNGBptHosHYlntTTbcuy6iwU12UUSd3wvh28Gsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SdY4CJFJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F16A606A339
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SdY4CJFJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E03B1F008A3;
	Tue, 10 Nov 2026 12:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794314376;
	bh=XZkohOBCNW/myDH3lC/RvZjkNbDjctQKn+HUHOtEmOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SdY4CJFJzodP0tM+eiBVBdxTkMVebBUBIFdvRYU+TM5cUvNNXBCKRXqAKwwlu1yI7
	 wFJu+WmFrB+ud7kdUAP3O0h7i4otj6Qrycfd0ZAglitqvGZ0eAmPjwcBCca+EKTNei
	 EWtSGBwqUgnsH18R050I7WryAXbtCzfcy6Ot0elX1WVTm8tngXZjIuuW+MbC4JuSAc
	 z+HvjsZprlqjfRDwHAM8IMmFkMXlzrbYHUtLjCdsooM/u2CgVb3pZVhJwKExlnWPre
	 s0vh8x5aOVZEshz1bX3zV5sUNS53xb0aTA+3xUBR5s1oofGjezpAJ84l3Ezyn6WfnQ
	 TdMYAR0hI9cVg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tharit Tangkijwanichakul <tharitt97@gmail.com>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] media: hantro: disable runtime PM before hardware teardown
Date: Tue, 10 Nov 2026 07:39:33 -0500
Message-ID: <20261110123927.1392922-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110123927.1392922-1-sashal@kernel.org>
References: <20261107054409-failed-6.1-8e26d4c20ed2@kernel.org>
 <20261110123927.1392922-1-sashal@kernel.org>
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

From: Tharit Tangkijwanichakul <tharitt97@gmail.com>

[ Upstream commit 8e26d4c20ed218db6c3123480a4a4e2545680566 ]

Removing the Hantro driver may trigger an SError on RK3588:
	SError Interrupt on CPU6, code 0x00000000be000011 -- SError
	...
	do_serror+0x5c/0x74
	el1h_64_error_handler+0x34/0x50
	el1h_64_error+0x6c/0x70
	regmap_mmio_read32le+0x10/0x20 (P)
	_regmap_bus_reg_read+0x6c/0xb4
	_regmap_read+0x60/0xdc
	regmap_read+0x4c/0x80
	rockchip_pd_power+0xe4/0x600
	rockchip_pd_power_off+0x1c/0x60
	_genpd_power_off+0x98/0x198
	genpd_power_off.part.0+0x178/0x288
	genpd_runtime_suspend+0x210/0x300
	__rpm_callback+0x48/0x1e0
	rpm_callback+0x74/0x80
	rpm_suspend+0x10c/0x580
	rpm_idle+0x134/0x1b8
	update_autosuspend+0x30/0xc4
	__pm_runtime_use_autosuspend+0x48/0x64
	hantro_remove+0x8c/0xa8 [hantro_vpu]
	...

hantro_remove() currently asserts the device resets before disabling
runtime PM.

Calling pm_runtime_dont_use_autosuspend() causes an idle device to be
runtime-suspended immediately. At that point the Hantro hardware has
already been torn down, while the generic power-domain genpd code
still performs the power-off sequence. genpd regmap_mmio_read causes panic
subsequently because the reset lines were asserted.

Disable runtime PM before asserting the reset lines so that no runtime-PM
transition can race with hardware teardown.

Apply the same ordering to the probe error paths as well.

Fixes: ea71631b7129 ("media: hantro: add support for reset lines")
Cc: stable@vger.kernel.org
Signed-off-by: Tharit Tangkijwanichakul <tharitt97@gmail.com>
Reviewed-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/verisilicon/hantro_drv.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
index df81ca3903ca5..d0ae492e51e6e 100644
--- a/drivers/media/platform/verisilicon/hantro_drv.c
+++ b/drivers/media/platform/verisilicon/hantro_drv.c
@@ -1119,7 +1119,7 @@ static int hantro_probe(struct platform_device *pdev)
 	ret = clk_bulk_prepare(vpu->variant->num_clocks, vpu->clocks);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to prepare clocks\n");
-		goto err_rst_assert;
+		goto err_pm_disable_assert_reset;
 	}
 
 	ret = v4l2_device_register(&pdev->dev, &vpu->v4l2_dev);
@@ -1175,8 +1175,11 @@ static int hantro_probe(struct platform_device *pdev)
 	v4l2_device_unregister(&vpu->v4l2_dev);
 err_clk_unprepare:
 	clk_bulk_unprepare(vpu->variant->num_clocks, vpu->clocks);
-err_rst_assert:
+err_pm_disable_assert_reset:
+	pm_runtime_dont_use_autosuspend(vpu->dev);
+	pm_runtime_disable(vpu->dev);
 	reset_control_assert(vpu->resets);
+	return ret;
 err_pm_disable:
 	pm_runtime_dont_use_autosuspend(vpu->dev);
 	pm_runtime_disable(vpu->dev);
@@ -1196,9 +1199,9 @@ static void hantro_remove(struct platform_device *pdev)
 	v4l2_m2m_put(vpu->m2m_dev);
 	v4l2_device_unregister(&vpu->v4l2_dev);
 	clk_bulk_unprepare(vpu->variant->num_clocks, vpu->clocks);
-	reset_control_assert(vpu->resets);
 	pm_runtime_dont_use_autosuspend(vpu->dev);
 	pm_runtime_disable(vpu->dev);
+	reset_control_assert(vpu->resets);
 }
 
 #ifdef CONFIG_PM
-- 
2.53.0

