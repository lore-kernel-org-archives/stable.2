Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794588035;
	b=fC8LrhVqvabiGHA1x+DLMwHL/UH2hu/79yFRJRHmkb415bClKvrTeQzydS3ximvYwzTk
	 8UOBgdhIIDW2kc7xljcOW7BTTg+kf6IZqLmLU71fu07zjHzJ1aBWO3IT26VN98qHCF/xY
	 evQZMfwqDb4txrcTu4OOH9PORurTSlLg9fhzMEcanKMyeWE4qqy+0E+SX56l5+zLr+5s3
	 N/v2xQH0c7+j96cCBJiL2NjHYBSZHfLVYC7VqwDGu71zIocgHkDtEO9t6HfQrs8dV7+oe
	 phW8MBK/9IyYkiM5cWVQ1B834ZkoR6ClkA4Nb3xxZFyACc3LnLs/9+D1BcsFuCDu+Eg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794588035;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=IIcORSMCHHPaaM/EomqXjuMSf3vKl+5Nk3vSHMLuEVI=;
	b=J/Pw+YtK1go9GJmAHxRVYGtcghtNx5FEF7cbX3tX8GKNHN9io1MkPew8IjI16wHjU+Ma
	 jAA6g58KyU+tCsUWXnIqwlcOzMQR2EVz2ycME+cBYFlttbmHhowb8NRPVDh8ogxeCyDpp
	 S/iagGAT/Oob/XtCjsdvjSrFI1X/7ZgmU2GDmkwmSAlgy+ThCPygrPXXh8Ktt4Ld+NO1o
	 NgnAr4ZdSyIQxGfqe3Ic9Q3En/XN1d29TN8wIcxswLn6qfctX87ggtEAaaOEn/V3F3k6D
	 RuJsb68ehuyecGbygNjRtAM7SJbJKz5YYtYjhARVDPXjj17oHnN5IB8BKJMqX6es8Xg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iOdpoGbC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B6460A6F78;
	Fri, 13 Nov 2026 16:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iOdpoGbC
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794588034;
	b=l37SEBs+uLM29R5ut4AZ7y2KIjgKzKOm+roY9W4tFmcNVBm33Q725RjsovO52mXYo3er
	 9E2S6vitYhxZUT97zxnusU2vFgyOVoif9Q7SUEaxpBzG+1RzM25oEV3UQ6mDCSyGyOyLs
	 ixWa8Aeny6h6AR2S/TxDINGFJHvWF1HnUMji3oE8LwMtmIH5Qq4nczdKOVBiUfF5mdvEy
	 AZJ4WIDdcOk2GD7VB90G6Y3ryJOiG0Va19YtQcit5bpARAGfqJ+IGeOPV1zPcB/1HNatf
	 cRghXsWubc1wvrYmYFrUYahPQsnW33cxHNPbrqru7nFnPPWQFN0jogwFaTJGm4BudwQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794588034;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=IIcORSMCHHPaaM/EomqXjuMSf3vKl+5Nk3vSHMLuEVI=;
	b=Aq0UCJTIaIZmwxYlD5w3waH8KPIOooqAZlwYFl2mRyMbstn8VSRp0/VRyj5oQSnub7O2
	 gHs4MrN+EAAtVtBKr8HyxI73hxiVXsX2E/S9ppcMO7U4ORqwF2/MOK1hO6oz377++ViT7
	 D0e6FAUU61duGBLIHcmBYX/Be5gFIz7tUepKtu3Svj/AWBWr8lKm1SXcIFTfk8KsT+meM
	 KKhkME++JP1xJO6sc3Q8/dYbfD/7oC2Zg79zUMF2NfXACiLHmBN02YqtKkEutdfgBPWCO
	 IvwzWAtWlOdvGALyLimzvbpK9lcbnPJA0DWoUPVXSDTOAPVs4DaaNVb0VtPoZ0xqoHg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 747661F000C9;
	Fri, 13 Nov 2026 16:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794588034;
	bh=IIcORSMCHHPaaM/EomqXjuMSf3vKl+5Nk3vSHMLuEVI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=iOdpoGbCGEiHaRmCdZAjmnLFzoWobWqj1FPsRaz7zfHFEukg28xV3hnXu2hOXBc0g
	 3AqdC7mL5J4lqb2uCjIvN7C5IjBrVcofyCTPNteQU8h2cx4RR8MNdoKYsWw4pas29t
	 JpYgWvvl30BodLDlUtafWcKeTJGJ2yStB0V6I/oetRlEeWiqxyX9LHqvlyq9UE2gyO
	 izDnP9OorjV40GR+TACFupdPJdvjhZjga3b05EcxOX9WayW20TebZwKlOvWXw+vnZ/
	 bPxuc32Ba/Xl/fEX5MIigMmVY3Ab/fjTGvq6olr3FmAHPXDA350PL71YI8i9cAvaQ+
	 2tCKPRIHd37xQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 0541A499E3;
	Fri, 13 Nov 2026 16:40:33 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Fri, 13 Nov 2026 16:40:35 +0000
Subject: [PATCH v3 04/12] media: verisilicon: Don't hold the VPU in reset
 after remove
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261113-hantro-robust-v3-4-82383c722ad2@gmail.com>
References: <20261113-hantro-robust-v3-0-82383c722ad2@gmail.com>
In-Reply-To: <20261113-hantro-robust-v3-0-82383c722ad2@gmail.com>
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, 
 Andrzej Pietrasiewicz <andrzej.p@collabora.com>, 
 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, 
 Hans Verkuil <hverkuil@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>
Cc: linux-media@vger.kernel.org, iommu@lists.linux.dev, 
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Sergei Khomenkov <shomenkow@gmail.com>, 
 Tharit Tangkijwanichakul <tharitt97@gmail.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Arun Iyengar <aiyengar1990@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794588032; l=3070;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=423gUTaQDvX29zH2dozaJwYSRoYQI88efAs7A7ebRKw=;
 b=tK9mQBxdWRV/qXhq69U7Id832ZFNjel5ug1ZPyHSDNSzD1jaelBWFjauAfPUIZdm2DvMYlri7
 cZ8ygCe4PpQA6cWZfiuh03rbalK2SrvLh5ZOzcYkXnSeUwuBSY/boA6
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

On the RK3588, the resets of the AV1 decoder include the AXI and APB
bus interface resets (SRST_A_AV1_BIU, SRST_P_AV1_BIU), which also cover
the Verisilicon IOMMU of the decoder. When the driver is unbound, the
driver core runtime resumes the device and, through the runtime PM
device link, its IOMMU. hantro_remove() then asserts the resets, and
when the IOMMU autosuspends 100 ms later, vsi_iommu_suspend() writes to
its registers while they are held in reset, which raises an SError and
panics the system:

  SError Interrupt on CPU4, code 0x00000000be000411 -- SError
  Workqueue: pm pm_runtime_work
  Call trace:
   clk_disable+0x30/0x90 (P)
   clk_bulk_disable+0x44/0x90
   vsi_iommu_suspend+0x4c/0xc8 [vsi_iommu]
   pm_generic_runtime_suspend+0x38/0x80
   genpd_runtime_suspend+0xc4/0x348
   ...
  Kernel panic - not syncing: Asynchronous SError Interrupt

Hit when reloading the module.

Commit 8e26d4c20ed2 ("media: hantro: disable runtime PM before hardware
teardown") moved the assert after the runtime PM teardown because
powering the domain off faulted on it. With the resets left asserted,
the domain is still powered on for the next bind, and off after a
failed probe, in that state.

A runtime suspended VPU has its resets deasserted and its clocks off.
Leave it in that state on remove and on the probe error path instead of
asserting the resets.

Fixes: ea71631b7129 ("media: hantro: add support for reset lines")
Cc: stable@vger.kernel.org
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/media/platform/verisilicon/hantro_drv.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
index 42822b2b376c..daec9f1ea968 100644
--- a/drivers/media/platform/verisilicon/hantro_drv.c
+++ b/drivers/media/platform/verisilicon/hantro_drv.c
@@ -1214,7 +1214,7 @@ static int hantro_probe(struct platform_device *pdev)
 	ret = clk_bulk_prepare(vpu->variant->num_clocks, vpu->clocks);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to prepare clocks\n");
-		goto err_pm_disable_assert_reset;
+		goto err_pm_disable;
 	}
 
 	ret = v4l2_device_register(&pdev->dev, &vpu->v4l2_dev);
@@ -1268,11 +1268,6 @@ static int hantro_probe(struct platform_device *pdev)
 	v4l2_device_unregister(&vpu->v4l2_dev);
 err_clk_unprepare:
 	clk_bulk_unprepare(vpu->variant->num_clocks, vpu->clocks);
-err_pm_disable_assert_reset:
-	pm_runtime_dont_use_autosuspend(vpu->dev);
-	pm_runtime_disable(vpu->dev);
-	reset_control_assert(vpu->resets);
-	return ret;
 err_pm_disable:
 	pm_runtime_dont_use_autosuspend(vpu->dev);
 	pm_runtime_disable(vpu->dev);
@@ -1294,7 +1289,6 @@ static void hantro_remove(struct platform_device *pdev)
 	clk_bulk_unprepare(vpu->variant->num_clocks, vpu->clocks);
 	pm_runtime_dont_use_autosuspend(vpu->dev);
 	pm_runtime_disable(vpu->dev);
-	reset_control_assert(vpu->resets);
 }
 
 static int hantro_runtime_resume(struct device *dev)

-- 
2.55.0


