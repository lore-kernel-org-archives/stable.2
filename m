Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC46426EB8
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 12:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785413760; cv=none; b=fjVeEjluNmtFrWE45leMisrHlpP+ZTCggCB/bW17ioMJINDx82MPan5cVxx+c+9OlOeum6O+AE6z1XpqrYNfEXJIbbvLvpCvOx2rNGbf8qSGJe6SClwDWMjLndCRfhu2CyUkWP2kIcvgWWLRCb+kFwzQCrlIaNud33yr96Obxhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785413760; c=relaxed/simple;
	bh=C9zu4fkv9nB5tE1ojiAIevfZBopy+MB4n5o2Ej2OoR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z+PWmoiDtXuo2NoiMC3t7OemRKlMMPaK2/WqWXA2cwWN0ekgsYJgPSbzDLC+iWU7R897YuYyqEqf0VXQJZdYNrVa/vGjO/0BlioRe8+ZhkRJusJRr+ID5XNFCR0w23utT1l/aVx5b7Rpj91jxMAcxJIXmoPzPg14T3uUZooX+oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cRwRYBW/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cRwRYBW/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A7B1F000E9;
	Thu, 30 Jul 2026 12:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785413752;
	bh=mBii8ElSoPYOqc0pDcoqds4rTPKWhIA+Fk50Sd4vqVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cRwRYBW/GL4ABFjfie73jxRZRzT6BF2zwmyVJL+sTgVmNy2HMB7bK5vRjWgKCvGsV
	 LEFD24TgL8pDIiJt1dfLhRlGdRTr0gL6vkfDK5NXrfJxt8zwp6+Gcgf5wuJ/hzHls+
	 mQRbej4Up2OEvPXdfnM9pNN33xAV6uvP48tVuhFDN9JFaLeZW16pEH4dK+KSb0X6EE
	 YNgpK8q24iPJoHUuaktcy5C17ImdUH54EMELfHspDpd/SLoW16AHDwY8qSmbqV94jK
	 /JEYh/D67q2wY6uiOZ0UNRK3nMF6UVTx/4pSG1uB5CTAg4lucZtW+uKK43PKsnFXSb
	 efLm+4VfFKA3A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Felipe Balbi <balbi@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] usb: gadget: bdc: fix checkpatch.pl spacing error
Date: Thu, 30 Jul 2026 08:15:48 -0400
Message-ID: <20260730121549.2211164-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072718-obtuse-smuggling-fc35@gregkh>
References: <2026072718-obtuse-smuggling-fc35@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chunfeng Yun <chunfeng.yun@mediatek.com>

[ Upstream commit 14a46f82d74e9bd8ce03cdbfcdb9f8408c1fc205 ]

fix checkpatch.pl error:
ERROR:SPACING: space prohibited before that ','

Cc: Florian Fainelli <f.fainelli@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Acked-by: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
Link: https://lore.kernel.org/r/1610505748-30616-10-git-send-email-chunfeng.yun@mediatek.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 0583f2fbf8f8 ("usb: gadget: udc: bdc: free IRQ and drain func_wake_notify before teardown")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/udc/bdc/bdc_udc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/bdc/bdc_udc.c b/drivers/usb/gadget/udc/bdc/bdc_udc.c
index 5f0b3fd9363196..59ba6a8d69a1ff 100644
--- a/drivers/usb/gadget/udc/bdc/bdc_udc.c
+++ b/drivers/usb/gadget/udc/bdc/bdc_udc.c
@@ -531,7 +531,7 @@ int bdc_udc_init(struct bdc *bdc)
 
 	bdc->gadget.name = BRCM_BDC_NAME;
 	ret = devm_request_irq(bdc->dev, bdc->irq, bdc_udc_interrupt,
-				IRQF_SHARED , BRCM_BDC_NAME, bdc);
+				IRQF_SHARED, BRCM_BDC_NAME, bdc);
 	if (ret) {
 		dev_err(bdc->dev,
 			"failed to request irq #%d %d\n",
-- 
2.53.0

