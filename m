Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDF9432E6A
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 14:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785420383; cv=none; b=HPaMdA9WKZFjLZ00JZ0ajPdTs+LE0+WzyBgKZfQ/aIdiZlsy81c/azetNeJ8lN81ZpP1shfXAa8eeuh//f/1xblE9H+DKu38ZIVq7LbqJCWfzp2s5GdyQkItEn7+tVUV+cGqy9IlQIeqZfo7xWYCJ8P7zvUgeYB3gnxouDS6CzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785420383; c=relaxed/simple;
	bh=YTb8yR40iOYpKegNE+8mwKr3YMI4bcAY0+ruksBoN2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C6JScVMN42y3rZpWW5H4SD0GaqC2vae0HOZ8pCYQVcNOFs1HTDu/asuFmEAPwFRvucXWq2vCVo9rJixkxWMxwIIJaIFDFoDGf8E7O2iOzhE6T9aMkT9XFTBNSLwNn7XpuxUltFP+zqHFoUg4q5gISYPi77iOGoqu5zt4mMGfYMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jjwqMi0J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jjwqMi0J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A7541F00A3D;
	Thu, 30 Jul 2026 14:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785420382;
	bh=gNJjnL797EpJRsR0rzNjGxf1yaUwuJFIpX0QfsOxBr0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jjwqMi0Jnpxfn7f1HTIXSmQ3b3AtDRamkJm9tP/QSVD/St8Y6GgXgFLKSplMSxIeL
	 55N+P7l5+aFF3jTqDqeuTG+kugYKnEE8Fj6+2CPQql9Rcx2d5TMAk9oiaChfoUn0BH
	 h72OVckWhRU/3y2zjJD9WLxcrdxMBzB8jLAdLHFHJHwZ0zwLVrtal0H9jdEeqBjKxM
	 /PuQhzAWnpnC2Jp2lF1+2lUM0eRIfS81cO7q1zEZF5+lR2wOwxV8Qf7KZoV/OEUQm3
	 +IqZ/eG5wHAYpx4Ceo1UZNHTgofbuc3bwwB1qgvPwBS/aDVpqgYYxuEs3PzXO5Tyos
	 H3mWwive+t1Rg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable <stable@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] usb: musb: omap2430: Do not put borrowed of_node in probe
Date: Thu, 30 Jul 2026 10:06:18 -0400
Message-ID: <20260730140618.2464039-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730140618.2464039-1-sashal@kernel.org>
References: <2026072753-efficient-culpable-80d7@gregkh>
 <20260730140618.2464039-1-sashal@kernel.org>
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
index f1506aead4e0..4b7a2013db8f 100644
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

