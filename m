Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94C23F4820
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 13:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780664742; cv=none; b=TgTcuZn5tOtQaqqYYhLT7Z8jdxPkBCB8CBYHCv5aJsYnR877lQZh06nlDdd0lMjSxQuN+YXsjLYKARAESfaPsB5MXhtb82YBKZNYJbwH0/jA3pN7xAUW4pIW5yz9qqNoQlGIfPSKeOgE8lvv1KIgiLqfCWGEPEYiIhfj386fQNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780664742; c=relaxed/simple;
	bh=bZ0HxCwfnxr1l0WSgmRsHM+PRcJ83C62DjF2bVojP8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I/sbbxT8JVXphH0rgfB5oSwOe0DxGFjQM8oSU0cJwYrgf5nOROcbKIt4YQyfCHFVfu3rttqVQLlSnFzU4pD9KatKCs4GSUHdWnknfKcUijsplaHlf6gRD3UxN/FKfDO0zF1/d+DRswMj/n2L+z6GEg3p7yXOCpSC2nGszhvOcWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7ZMwk9s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M7ZMwk9s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E47BC1F00893;
	Fri,  5 Jun 2026 13:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780664741;
	bh=y2bsahdiQeZ0gTpHjcCIsWzf3H3tvLUgy/PvgDsDr2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M7ZMwk9sMND1ubeipyG+sMF2gJtxNQf1/cNnoiCiGeCRdGQAhbuEqX045G+G49bXA
	 CJeDVy5bfUPLM8REvBbeFpl+n9zIfyqAwEUowszDomIAkKNqqqH3UBOKr/4HFuI8Fd
	 AobbTE70bBbqjp+GLctkZmse4QbmNEKoTNtOiw6znLdRSRQkJIHDfbnhUbijV/yefy
	 1ljArLg6NXV3Od/bxyXGstBq6Zn3Nn6DLBBiserem0aoGpJTavN7GmZuFaeyqQzvb5
	 nPrG1ioKIoeDkaqpamnSiluG9CZdMautfIMUU7ezZy4B3d52apmNuinjac8cZaxmci
	 ztqiAOgN8FGng==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peter Chen <peter.chen@cixtech.com>,
	stable <stable@kernel.org>,
	sashiko-bot <sashiko-bot@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] usb: cdns3: plat: fix leaked usb2_phy initialization on usb3_phy acquisition failure
Date: Fri,  5 Jun 2026 09:05:37 -0400
Message-ID: <20260605130538.413416-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060429-trifocals-granddad-3d28@gregkh>
References: <2026060429-trifocals-granddad-3d28@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Chen <peter.chen@cixtech.com>

[ Upstream commit e6970cda63fd4b4546aeed9d0e2f53a7c95cd09c ]

Move usb2_phy initialization after usb3_phy acquisition.

Fixes: f738957277ba ("usb: cdns3: Split core.c into cdns3-plat and core.c file")
Cc: stable <stable@kernel.org>
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/linux-devicetree/agKaEePSFknhDBg2@nchen-desktop/T/#m21e1d9c1574eb127ce03c0c2a1a49002ce435b52
Signed-off-by: Peter Chen <peter.chen@cixtech.com>
Link: https://patch.msgid.link/20260513085310.2217547-2-peter.chen@cixtech.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/cdns3/cdns3-plat.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/cdns3/cdns3-plat.c b/drivers/usb/cdns3/cdns3-plat.c
index 9cb647203dcf2d..6c30de9ebcb2c7 100644
--- a/drivers/usb/cdns3/cdns3-plat.c
+++ b/drivers/usb/cdns3/cdns3-plat.c
@@ -120,14 +120,14 @@ static int cdns3_plat_probe(struct platform_device *pdev)
 	if (IS_ERR(cdns->usb2_phy))
 		return PTR_ERR(cdns->usb2_phy);
 
-	ret = phy_init(cdns->usb2_phy);
-	if (ret)
-		return ret;
-
 	cdns->usb3_phy = devm_phy_optional_get(dev, "cdns3,usb3-phy");
 	if (IS_ERR(cdns->usb3_phy))
 		return PTR_ERR(cdns->usb3_phy);
 
+	ret = phy_init(cdns->usb2_phy);
+	if (ret)
+		return ret;
+
 	ret = phy_init(cdns->usb3_phy);
 	if (ret)
 		goto err_phy3_init;
-- 
2.53.0

