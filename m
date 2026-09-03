Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C8B4B514A;
	Thu,  3 Sep 2026 14:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788446534; cv=none; b=roLJH1PfeM/I6bfFX6NH32xhPc6ZHbJ65g7U2t7DSahKywWzT5/6qMLMnYX8ShfOIkXMxPgCy3v2cJJXJ0ncMra+xxBsJB2dO/6QKMWCOaJcRlH25ZS0Kqy4n/1t5R6CJrtCXgXXTGsgvaKHeQZvpxs/rwxL9kKQXhmXEEQBIck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788446534; c=relaxed/simple;
	bh=1eU2JFdLN2zRvrHwu2M2unvrPHYwHBvrDbFtZEd4H5c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DvB7himsr9aKq/+FDvYwubDK+f8Ti48uj6Q9qpuIDOtUO2NaUEGOvDMUs036Rkq0GCLwWQ3YiUmHIezC1/+eMTx8CzksMkMP4TUrwTAV2frKbDj2qT7IydjVHikVsev3I11hxpzcr1OX0Fd6NtrlSvb1dBnqdfrXqngwZkExb4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MdJz1xkr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MdJz1xkr"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9D3B0C2BCF7;
	Thu,  3 Sep 2026 14:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788446532;
	bh=1eU2JFdLN2zRvrHwu2M2unvrPHYwHBvrDbFtZEd4H5c=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=MdJz1xkrnmALYw6gGUhKMSkYTC/Z35Si2duFv1yeuRveqAJOxYZVkCV6YY3lkhiS6
	 Mlh7EzOA2vOoRMFZMThdYPwuffl0HYkxGEKWW95jOB9fa/+QmZrSM7wXC+kel/JlSw
	 NiVZ5zphcOLuOz9YFkLH8kMj9cHLkvutZO4f2CYnhPk6erxpB66RQmc8TDiFLslv5H
	 z6aY8O1Sv11QP50G0LgsCS91arrYyjisqpii7kciCec6UV3eY9DYLrZbI9oTTCc3Kw
	 sviwIOyNSx8LolPacaNaZQZmMa9mTnRpr3ErDlKMHq/q+D+/hmRwo7Mf2CA/Ephohn
	 XL1S0Ek4iy/jg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88BC9C624D6;
	Thu,  3 Sep 2026 14:42:12 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Thu, 03 Sep 2026 16:42:05 +0200
Subject: [PATCH v2] mfd: wcd934x: set DMA mask on parent to silence "DMA
 mask not set"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-wcd-dma-v2-1-189cff560a28@ixit.cz>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WNwQ6CMBAFf4Xs2RraAhZP/ofhAO0iayKQFitK+
 u+2ePQ4ybx5Gzi0hA7O2QYWPTmaxgjikIEe2vGGjExkELmociUke2nDzKNlnakER5S1UieI9my
 xp3UvXZsfu2d3R72keTIGcstk3/uV58n7r3rOOKtLLIpW8lLr/kIrLUf9gSaE8AWA+Hi8rgAAA
 A==
X-Change-ID: 20260823-wcd-dma-bd621ee39887
To: Lee Jones <lee@kernel.org>, Thomas Tai <thomas.tai@oracle.com>, 
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: mfd@lists.linux.dev, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org, stable@vger.kernel.org, 
 David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2047; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=e4yf9rBUgYZaQShtQ8iyZHTpSxzA2vYCFo3z/MlZY7k=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBqmYdDchD6Bd3Yl6ccNGcFCf3Ai6x3Lw/D3jIDW
 2YJIeSNfW2JAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCapmHQwAKCRBgAj/E00kg
 ckh8EACFNiPKRLYjFzbw35XOYudJEilTISA7Ga/oT9BQJkjVL96HVhfEuDvanfZ355eFGPQL3tg
 wQYAyXODxcVpS/KmkIbka04Ac+avStrbOHsHP9UbgZLaS9i9G2rhQuDOEMqo2mwRCFd5WnVzpEU
 ZKnk92+t2tpAPj2mbRERBkB2MEadp1rLei9r4jeMp87U5m7iPAlCGBLSv5MI5gGIKO0AHiJ5EKz
 OWm2SqAcJklTDxJO6cCfUdFbhXWPna5Bf4rlotAaQexTbLiYp9lv6wUaNkOWWU+so0HMW/YQUOD
 yYjzEU9bFxPywa7+xv/Wm9LMmCBSQQ5YQI999nLfm1F9/vauNphJ7JDSl7UpcT9Vgqlm0EglXJS
 9qkVGc+sHI+/dDaVwKgkDONY/XHn04ASfCTIZVDYDWxdTCCvhAwbxHaTI9wZiV8NaI/UmAsDvDo
 Pl/tQPcTp42DeJe4xN2olti6LZ7YwHd828Qvopuw08zvn2wsN4Jv70mcEnJ9KFwWip2ApFYP6fc
 v6ICk3KHfbgAQuaGyy4v0RxF40qKFfKEObApfeDg9c3V6eohDlYXO4BMlen2R/7VBeDiG3PaGRh
 pzE+cetTpYuDjEJFZulaaXZz4o7DzfJX0bcN+W825JJYh+R8BTLMIrpvaE10tcJDJBh0zwgT8CH
 wwjTx069DSMe2fA==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: David Heidelberg <david@ixit.cz>

The wcd934x MFD parent (a slim_device) never initializes its
dma_mask/coherent_dma_mask. When the DT-aware children pass through
of_dma_configure() this triggers the "DMA mask not set" warning for
each child.

Cc: stable@vger.kernel.org
Fixes: f959dcd6ddfd ("dma-direct: Fix potential NULL pointer dereference")
Assisted-by: tencent:hy3
Signed-off-by: David Heidelberg <david@ixit.cz>
---
Changes in v2:
- Use dma_coerce_mask_and_coherent. (Lee)
- Link to v1: https://patch.msgid.link/20260823-wcd-dma-v1-1-95e44a315ccf@ixit.cz
---
 drivers/mfd/wcd934x.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mfd/wcd934x.c b/drivers/mfd/wcd934x.c
index 3c3080e8c8cf7..853edda9b6da7 100644
--- a/drivers/mfd/wcd934x.c
+++ b/drivers/mfd/wcd934x.c
@@ -1,12 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2019, Linaro Limited
 
 #include <linux/clk.h>
+#include <linux/dma-mapping.h>
 #include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/mfd/core.h>
 #include <linux/mfd/wcd934x/registers.h>
 #include <linux/mfd/wcd934x/wcd934x.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -212,16 +213,21 @@ static int wcd934x_slim_status(struct slim_device *sdev,
 static int wcd934x_slim_probe(struct slim_device *sdev)
 {
 	struct device *dev = &sdev->dev;
 	struct device_node *np = dev->of_node;
 	struct wcd934x_ddata *ddata;
 	struct gpio_desc *reset_gpio;
 	int ret;
 
+	ret = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(32));
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to set dma mask\n");
+
 	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
 	if (!ddata)
 		return	-ENOMEM;
 
 	ddata->irq = of_irq_get(np, 0);
 	if (ddata->irq < 0)
 		return dev_err_probe(ddata->dev, ddata->irq,
 				     "Failed to get IRQ\n");

---
base-commit: 7079a12d7506b07fb53b54a664bfad5fa9b16d70
change-id: 20260823-wcd-dma-bd621ee39887

Best regards,
--  
David Heidelberg <david@ixit.cz>


