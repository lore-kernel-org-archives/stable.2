Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86124302F7
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 13:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785417221; cv=none; b=Gwt/2Uy1t67+YIpS5AttFLSB4zqcgUnyYaWVHO271CsucE7At25mzylbUWUBVoSnhwVV3IBD7TsSTPdGp5U5yaFXp6ccCqM+mGlxAIUVgcGcBGuVU4zfXe4FA95RauX+izs5YRo95v+WcQ+Yh1j6nJBS7fdXehaXfGZ1PJh2FHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785417221; c=relaxed/simple;
	bh=bd1PJZ5ZT5FtLy63dsKikjSIc9YR9I6axR8ktAoMT28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qMLG0RxIMfwfZwkI72s2NUYrxHGj1rqxJQfYBRB7wFDRh+J+TWmXsh2NkHETKfjRFuZUMyBUu58jT801LfD3T+bwsuc1+E66kj+3skjEKyFO7Xjs7SXfXK06NeNkjE/OVa4dWE/iay3wu2m3it4tY0upq+bDsTDyFkUwDkA58JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fEojrqng; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fEojrqng"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D8491F00A3E;
	Thu, 30 Jul 2026 13:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785417219;
	bh=lPun2jR7kLaAwjvxz2fMSxRzzrv530JFtqNx79rRIro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fEojrqngmJIJ/fRU1661DFSMA8HYqxDMBZujj4LhSJkVRF8ib/Nwx4MZe/8ef6686
	 oDXsX2l3544yyQiNri/QYtUbjBMvDTKwhmCbinMQocOMt7qx9POconB4pqS5c4hyco
	 kyXw5rIoiXzbAcweF/3piV8daiC43oPheje71F7r5ReOBYce6NxlN18NRzWa/Rr5dx
	 zTV5W5k4R5mcf11Ak4HOV5SrtyZxKQTMbjJHTrl6Ib19RItCoXZf1beq93FtYe05kR
	 y/kepWixu9iCIu/5qKj9zI0oze5MNc0K95i+XoW8roRrmVPMqEp234uNwxN0xamD6c
	 X9bbCpwevfSxQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable <stable@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] usb: musb: omap2430: Do not put borrowed of_node in probe
Date: Thu, 30 Jul 2026 09:13:36 -0400
Message-ID: <20260730131336.2345145-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730131336.2345145-1-sashal@kernel.org>
References: <2026072753-washstand-wasp-7982@gregkh>
 <20260730131336.2345145-1-sashal@kernel.org>
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

