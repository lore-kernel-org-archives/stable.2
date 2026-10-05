Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DD24C226D
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 15:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791213057; cv=none; b=ToQODzASIkL+TuamjjFztM0NuxY7Nf25auIrlYhMLalNOhKUR+GVt3Aut/LSDv+F2gHvGSrwMCBF8ImwCtbF4j5A3rSwHGBMB9TgiuBAc8VzPknbFO8mOOib/h/5z8CRADNMahvKCLGAMwe6ZTb2i8bdamPBMDrH6YbJ73by87s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791213057; c=relaxed/simple;
	bh=vXsuY1BU+vWzHGgb4SfC8gKp/9x7UxJs1ZpK8YK8noc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VCGLPMDuyjBA71r3Q7qnOhBEJ8v7uhbC3rV8S4erf8knaYT8itiBwpdqiuq8C/cIt5TOwZXk2tz0F1L2TXwRVOVP6mEk0oQKJTw+cIlqicVHLdcx3vWLPK1kiBGoh3X7sUztpyPUBkD+cwiSxzDLUacB1amNLqQehlBt0xPjmWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dfcvZpxN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dfcvZpxN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4489A1F00893;
	Mon,  5 Oct 2026 15:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791213055;
	bh=/SEn1LVk6pxj4/FUKiv0uziOvMzmUgKCOdy/7fTiFaM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dfcvZpxNhS4yHESEB9X4kxHUgjHQF7u46ewbleadulZ42mbdE1xA9/MmpHMdeNS4l
	 zYFs98QuT3vI2aZcaaF05UanvsBUHryoYjHd2YZCq+W3RH77EFv5aCnYnYnpcERWgj
	 QpYKLcH5VFLbBkCUWJDXRh35CAfuj+l0ZK60skqzzyhmkopLJX0vnuau/H99F6n0KN
	 /AcXA6DGr8/e0xSbUPE+dN1jFGfcfob3wYcPl+Mrf59ua2h4gxa8abq/BXtfyEYcjB
	 LjYFuJNr1Ee6OcjZe+bQH9Jzqv3/EE6iyg2A4FBqNWckYhqv3PGfRKG8ChRODLyKaQ
	 Xw6WAnqO1+aXQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chen Ni <nichen@iscas.ac.cn>,
	Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] usb: ohci-spear: Remove unnecessary NULL check before clk_disable_unprepare()
Date: Mon,  5 Oct 2026 11:10:51 -0400
Message-ID: <20261005151017.3044548-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100502-nanometer-helpless-c302@gregkh>
References: <2026100502-nanometer-helpless-c302@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Ni <nichen@iscas.ac.cn>

[ Upstream commit a891b9aebcc7406fe2f439d184bac3948fb08645 ]

clk_disable_unprepare() already checks NULL by using IS_ERR_OR_NULL.
Remove unneeded NULL check for clk here.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Link: https://lore.kernel.org/r/20250617042050.1930940-1-nichen@iscas.ac.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: b1b0f8bdbbc8 ("usb: ohci-spear: disable controller wakeup on removal")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/ohci-spear.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/host/ohci-spear.c b/drivers/usb/host/ohci-spear.c
index b4cd9e6c72fd0..986406f7aeb15 100644
--- a/drivers/usb/host/ohci-spear.c
+++ b/drivers/usb/host/ohci-spear.c
@@ -105,8 +105,7 @@ static int spear_ohci_hcd_drv_remove(struct platform_device *pdev)
 	struct spear_ohci *sohci_p = to_spear_ohci(hcd);
 
 	usb_remove_hcd(hcd);
-	if (sohci_p->clk)
-		clk_disable_unprepare(sohci_p->clk);
+	clk_disable_unprepare(sohci_p->clk);
 
 	usb_put_hcd(hcd);
 	return 0;
-- 
2.53.0

