Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF7D4C6515;
	Wed, 16 Sep 2026 16:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577603; cv=none; b=edCnXtJCUWaaaCSsVWly32ZqVXF0zW6rNgkyiTleLJBGMC2eI5bFOiuPv2+BPlO8Esm62VrZlXCv+fbYmzJM8Zs70VFYM8YmwDATiiB9uiyfayPLGMeqUuQL7S1G4HkQder6/lrvMP7O9dBp7ujsIzemxCXGExqWSzDFNhd7g+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577603; c=relaxed/simple;
	bh=dPZo3LSu9a/yakAaWi7jqjb8hMyJHbQA5bsD2Vijpfg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JpwZpvhVc+vxPWrziV+Q2ERjf0++sjgOBCqgPO1SbQnpeZwbabTdbnL5DwkFgwBKwOlnu8bX6E7NY4OCgFjPh4zIXkaKQ69ApDmnPBW530fpKRxux/S90crUZOftA3oCvkM5phncMTO0Jixx8Z+imm2AxWaZIxR9aWNIUklZ5Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowACXAj14yapq5wNuCA--.21781S2;
	Thu, 17 Sep 2026 00:53:12 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	yoshihiro.shimoda.uh@renesas.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] usb: renesas_usbhs: Fix runtime PM leak in usbhsc_power_ctrl()
Date: Wed, 16 Sep 2026 16:52:45 +0000
Message-Id: <20260916165245.2085374-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACXAj14yapq5wNuCA--.21781S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJr1kGr1Duw4Dur45XF1rXrb_yoW8Gryfpr
	4ktFWIyry8JF4jvwsxAr1kZFyrGFWayry3Ar97Ka1kuw13Aa40kFy09F1Y9F1qyrWfJ3Z0
	qw1vkF9rAF15CrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv014x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8
	JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUj
	nmRUUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRQMA2qqozVcEwAAsL

usbhsc_power_ctrl() takes a runtime PM usage count with
pm_runtime_get_sync() when enabling the controller. If the subsequent
usbhsc_clk_prepare_enable() call fails, the function returns without
dropping that usage count, so the device's runtime PM usage count is
leaked and the device can never suspend.

Put the runtime PM reference back with pm_runtime_put_sync() before
returning on the clock enable failure path, mirroring the disable path
of the function.

Fixes: 3df0e240caba6 ("usb: renesas_usbhs: Add multiple clocks management")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/usb/renesas_usbhs/common.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/renesas_usbhs/common.c b/drivers/usb/renesas_usbhs/common.c
index 8c93bde4b816..187d6298c265 100644
--- a/drivers/usb/renesas_usbhs/common.c
+++ b/drivers/usb/renesas_usbhs/common.c
@@ -412,8 +412,10 @@ static void usbhsc_power_ctrl(struct usbhs_priv *priv, int enable)
 		pm_runtime_get_sync(dev);
 
 		/* enable clks */
-		if (usbhsc_clk_prepare_enable(priv))
+		if (usbhsc_clk_prepare_enable(priv)) {
+			pm_runtime_put_sync(dev);
 			return;
+		}
 
 		/* enable platform power */
 		usbhs_platform_call(priv, power_ctrl, pdev, priv->base, enable);
-- 
2.34.1

