Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794472250;
	b=G75kOOMSgzjBqB4a/X658ypSdqeSEu9yj4KBD6GHvDuE5iNM5m/BbTi/e563aWBPoWQ7
	 nT2tuoWQ7YkyZEU4XYupCDOW1Ry+TBbrLD3p/HfLJYsb5QXMSC18zBQ3szZcHYABiz/wQ
	 NbvdEoFznO4yQh1RIjSZvIsTe4J07tGe1RnYBz+K8x+QydCwXWSAGIf7z1/ZRGUSrfS7Y
	 e/f24k2DF6NmjMMYKXbJAVQHM2RGbFJCyuBt03WexpV8p0jk/lPd0VTmmAhveSDYNdKYO
	 F1m6LVWfBVA5cpLvsFZhgT3b8CCgaq03qMhDI3GJbsFqkHSqt3nOwOGAa/aogqygxFQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794472250;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=hKuahGHQ0APnWIJaFL6RA1DFujLrUACycNekn7BglGU=;
	b=jb3nwyfpN3nfYKunCHhchI4KGF3DeFSI/iN5GKM1QzzzBQPs6Kj6d7BClWqxP016wE7d
	 PJ65l6/logKlbsn21SOp+57Je9bizWwfvsAOqupAmQwUdlC5IY5r/J5VJtRizXSGkvsP+
	 7egHF7DFHynRqkh0+25ugjKRy1RJKal+Dza8p84Q/zgjGq6E/v2EXW9dDxF67i+QXfYiD
	 HDHSrMA/XSoMPFSFrbFnyzOG45qdByBW9pZdTam6Cp4L8MwPBUJmDPwvKzA2IVrmDuac9
	 u5dM2MDQLtsxomQYUHjk6nLN0L5+OSTYuGmsQBiBiPzgc+JnpEqcxHziX0hxTywWciQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WYkpzBLe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDEE606A331;
	Thu, 12 Nov 2026 08:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WYkpzBLe
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794472250;
	b=KtfNqADoq81K3tziX8Ra6eFlkF/d8Bkjj8/A5zShulhyYH2LXgui2TenBv7XXl0bvmCc
	 IJ7YWBjNEnDvjJx6xKEciyVIKvfzIbqiS5FG9wYMBuH0VoD/0xfFzj2k4bX5HsnJDwpOq
	 H5dSZ66k7iV0jKMEGcqUj51VyWJLmAo+dim5ejIAQgrcmi8/2ppz2ENaoTALAlT/Wz/7Y
	 IKqPfHAk6CMXDmwLgrJWEoOGvenEOdNJK/g126ARRisMEJtCj6bcCfW45pMXAWFggdtjz
	 n8eOpJiEt0psAFUbUYCMXBpnflDTHQkXiEp0dLdwF6geepckIsQCkJ1l0bFKK2uShgw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794472250;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=hKuahGHQ0APnWIJaFL6RA1DFujLrUACycNekn7BglGU=;
	b=ZsV/tbq2tqWLsXNL038JVbaFfsUU2i0+ekwxJe/PL1xFO7nqoFp40cVIe20r54yqUEax
	 CxltctBCkP4PsbcPGVVugVdoMw6Nke+uHnOL4mNdxPS4Ghwg232SNr29NErBxQujG5b/x
	 x+TWtCLSGYuLB7J26wZ+/RUPeCCJGImip3jm75xe4GzWreGT4vxwLLXh7bDTxh5RHC1Kp
	 tldqkxI9Fu01BPsffcXFiVj8YZODPZGdmdSDnvZhs0M52uBhfmAKA8c+j+n6FwnxPi4uI
	 za5EiMjhwRePsJDi3RBT4X0AGifTKQqNDZ4KwdQp6Vh8jP2AfxvJZkqIKkI3k8uHeyg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 8579D1F00A08;
	Thu, 12 Nov 2026 08:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794472249;
	bh=hKuahGHQ0APnWIJaFL6RA1DFujLrUACycNekn7BglGU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=WYkpzBLenmwUPf2zd3uq1njx4uMjWtSAQCgvaijuZCh9CJhVV3UA1SFOq1Ntlyo3w
	 Bhe3c/JklCRAUyQghlVbMfoLHpIjEnDnAxwgx1zPO4ZAGnh+V8M34IF1DsGDhbgoU0
	 zReUijHlJVAKHw2PP7mF8jfI5kq6CiTPjH+f8fjts1cfv6cAQVPyX847mrwgoYrv2I
	 FD7R7bdA8nzM7T1mcOB3hMtoskktPe89RhkrF51Ra5YzDiCyy8fD0z2DG53lV1nvKS
	 l/3WZx92gzEogZ7wpiVK3QLmQjb5y4OdP5guRfRKE7sOR70fWcEYq/IgsaMNWFz5dr
	 eOKwaUHxzB0gw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 0C7964937D;
	Thu, 12 Nov 2026 08:30:48 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Thu, 12 Nov 2026 08:30:48 +0000
Subject: [PATCH v2 2/6] media: verisilicon: Don't hold the VPU in reset
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
Message-Id: <20261112-hantro-robust-v2-2-18561fd48838@gmail.com>
References: <20261112-hantro-robust-v2-0-18561fd48838@gmail.com>
In-Reply-To: <20261112-hantro-robust-v2-0-18561fd48838@gmail.com>
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
 Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Sergei Khomenkov <shomenkow@gmail.com>, 
 Tharit Tangkijwanichakul <tharitt97@gmail.com>, 
 Arun Iyengar <aiyengar1990@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794472247; l=3396;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=anNmhGiL7WByI9+zM577XJx5bZa3C8k/V1V7McF0Fl4=;
 b=2EFkfYTDn6pLkeZxwuRwLY45wAj10XzVKpR2UnGp21Z3SBiwzuU8sYxnpb0Ga7wuPijpxXsKJ
 45neb9AXVThCQHWvnSPHT3H7YpXL4Dd+4YAW875XWa2VkLpO4PxprBi
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

This was hit when reloading the module, unless the decoder happened to
be probed again within the autosuspend delay of its IOMMU.

The IOMMU is not the only one to access the bus interface after remove.
Commit 8e26d4c20ed2 ("media: hantro: disable runtime PM before hardware
teardown") moved the assert after the runtime PM teardown because the
power domain code faulted on it when powering the domain off. With the
resets left asserted, the same domain code runs again when the domain
is powered on for the next bind, before hantro_probe() deasserts the
resets, and when the domain is powered off after a failed probe.

A runtime suspended VPU has its resets deasserted and its clocks off.
Leave it in that state on remove and on the probe error path instead of
asserting the resets; hantro_probe() deasserts them anyway.

Fixes: ea71631b7129 ("media: hantro: add support for reset lines")
Cc: stable@vger.kernel.org
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/media/platform/verisilicon/hantro_drv.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
index 26e5d5547466..4542322dba71 100644
--- a/drivers/media/platform/verisilicon/hantro_drv.c
+++ b/drivers/media/platform/verisilicon/hantro_drv.c
@@ -1210,7 +1210,7 @@ static int hantro_probe(struct platform_device *pdev)
 	ret = clk_bulk_prepare(vpu->variant->num_clocks, vpu->clocks);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to prepare clocks\n");
-		goto err_pm_disable_assert_reset;
+		goto err_pm_disable;
 	}
 
 	ret = v4l2_device_register(&pdev->dev, &vpu->v4l2_dev);
@@ -1264,11 +1264,6 @@ static int hantro_probe(struct platform_device *pdev)
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
@@ -1290,7 +1285,6 @@ static void hantro_remove(struct platform_device *pdev)
 	clk_bulk_unprepare(vpu->variant->num_clocks, vpu->clocks);
 	pm_runtime_dont_use_autosuspend(vpu->dev);
 	pm_runtime_disable(vpu->dev);
-	reset_control_assert(vpu->resets);
 }
 
 static int hantro_runtime_resume(struct device *dev)

-- 
2.55.0


