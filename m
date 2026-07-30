Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB5B4248D5
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 12:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785413765; cv=none; b=ndj6F2Zr79blBLs4BgCjC32hQn1nWJ69kj8Fgtg69KPsBlThuCLV/YVRA3Bk9D9M5shSTAVdiaBQQVlduRq+bVj+A3j64SFmwPem5+K74ptfxijLymjjC7MSa2muOhzVuMiDS+/tc1x1028IFrOJTm9t8EVYoj6+n+SftEyqt2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785413765; c=relaxed/simple;
	bh=bd1PJZ5ZT5FtLy63dsKikjSIc9YR9I6axR8ktAoMT28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T8ZNSmQKTNcxaa2p5DhN3Zz//DhbeKyvSkLsyDTzWptRozY5O2kXcJUuPJkM7EU8Mu0PTXmhOS3wRVxI8/6++goOm+xMGAMQhVr7yQI/zTHzJdhN2HinUOq4ER12Jz3eAvHA0Tqxb5C1kpDcUzzBRo4YspcvF962w4ho1XO2yZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o1q7AFLq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1q7AFLq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDA851F00A3E;
	Thu, 30 Jul 2026 12:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785413757;
	bh=lPun2jR7kLaAwjvxz2fMSxRzzrv530JFtqNx79rRIro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=o1q7AFLqV3cXgWcqNZb6HbN0aQzDwq0mhocd7F/+CaBnr8IEMpDXmOTbUAWErPUQc
	 96KAKbh/6yqhODSz94iSIgAieA6oFwlleQ9UXn5+reUbzb3SogiSl0vxkXIAjlw6tZ
	 s4YzJdxMWMs6/OYP3i0CZ7b/4tDu5dJYx2fuMjrHgA87nnlcrI2in01XOcZeztGO1j
	 hGI45D429+RyL6pRLDNDj8ahqRGbs6S8WLIqvDgbc5dzTm0l29jka9ra4Vk9h3ebw+
	 K/2C1pUPXmQ9Ysr+t/WvHtq74BJ89USvfHA4VplhaZ9s+XbnbWMPfHgttEaU0vGhdK
	 Q9Ok5yeqPd35A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable <stable@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] usb: musb: omap2430: Do not put borrowed of_node in probe
Date: Thu, 30 Jul 2026 08:15:54 -0400
Message-ID: <20260730121554.2211933-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730121554.2211933-1-sashal@kernel.org>
References: <2026072752-stoning-canister-689f@gregkh>
 <20260730121554.2211933-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guangshuo Li <lgs201920130244@gmail.com>

[ Upstream commit c947360ae63eee1c9eacc030dd6f5a53f717addf ]

omap2430_probe() stores pdev->dev.of_node in a local np variable. This is
a borrowed pointer and the probe function does not take a reference to
it.

The success and error paths nevertheless call of_node_put(np). This drops
a reference that is owned by the platform device, and can leave
pdev->dev.of_node with an unbalanced reference count.

Do not put the borrowed platform device node from omap2430_probe().
References taken for the child MUSB device are handled by the device core,
and the ctrl-module phandle reference is still released separately.

Fixes: ffbe2feac59b ("usb: musb: omap2430: Fix probe regression for missing resources")
Cc: stable <stable@kernel.org>
Reviewed-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Link: https://patch.msgid.link/20260713114711.955253-1-lgs201920130244@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/musb/omap2430.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index fcfc024e3288d0..d79169d37b7266 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -455,7 +455,6 @@ static int omap2430_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "failed to register musb device\n");
 		goto err_disable_rpm;
 	}
-	of_node_put(np);
 
 	return 0;
 
@@ -465,7 +464,6 @@ static int omap2430_probe(struct platform_device *pdev)
 	if (!IS_ERR(glue->control_otghs))
 		put_device(glue->control_otghs);
 err_put_musb:
-	of_node_put(np);
 	platform_device_put(musb);
 
 	return ret;
-- 
2.53.0

