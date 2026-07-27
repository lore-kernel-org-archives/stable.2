Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265A93164B4
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 22:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785190850; cv=none; b=pf9Uwnr50BhmM8XXOdOjCYniOS3ETxPF84sdwl9gF8w2Aua4gLVfBmHuxtJayRI3dAsGOkMtza6GKtGNpTTopke839xqD17Z87S75XKaMF6rEtX7gGB4a9+Oru1WwZ4MbbHx83IM4Q5tFAF6tAALX67zKmVFOEhRbIAFGzTDXPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785190850; c=relaxed/simple;
	bh=xdfBX3rNKNZP4kJY7M+rbQEBhy/QkM6WugSYN2GwkWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ucQsS2sH40jf+WD3orAwmWk7hv6/3jW5qv4i/WWCiqAz5egDD+a9Rpd32GRGTwRJpXSpr1EyRo912oOmTU9CE3USS+XyQkkedixsK4iVfxH1NnnP/EC6mJMdB9T6MV3q/CYHy/P2tsJnlixp2ZkL/PJOLvmKHQWpOecDbj6tp6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OzoCiRzS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OzoCiRzS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 335D91F00A3F;
	Mon, 27 Jul 2026 22:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785190848;
	bh=nHBs1UyLpaCDKVWzhznuPmbTK6Yho2wUHIWXJAsnCVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OzoCiRzSVnVZ6Pnxptd2YkoXMpwpl4FKP00QzTgYbU2Ghnj721/DXxkscIhvvSC9r
	 J70b6sLtSQKcBfq7u3jJZw+HRcHYfYuuMPOkP+MgxnwRR8wc9E0vUiPRkymp+UUtID
	 eNG0qvXycMSguzU652L+txCXpiOfbhYBv2B3L4NAeaGvv463dnDWHSlxp6CzNpe4/k
	 j2Ijv80E9I6i56HIBy2WthOXaL4VIbvmIFwjHNEvZymO6alvoCHVyyYzyIHR14pOZ4
	 WSWxbCro78fYc8KkyeiN+ayy0CPfvBmebY+Uf09jBozWYLjxf/Yd6HnNfPkQsTIf6t
	 KZp7W0p7Fj4Yw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] mmc: vub300: rename probe error labels
Date: Mon, 27 Jul 2026 18:20:44 -0400
Message-ID: <20260727222045.2118748-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072045-starboard-ferment-23aa@gregkh>
References: <2026072045-starboard-ferment-23aa@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 5b8b35d6f4fa758dd5e8ae18526ea1c73f6787e0 ]

Error labels should be named after what they do.

Rename the probe error labels.

Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Stable-dep-of: a3b5f242997a ("mmc: vub300: fix use-after-free on probe failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/vub300.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
index 93c4e145009e00..9a864369598160 100644
--- a/drivers/mmc/host/vub300.c
+++ b/drivers/mmc/host/vub300.c
@@ -2115,19 +2115,19 @@ static int vub300_probe(struct usb_interface *interface,
 	command_out_urb = usb_alloc_urb(0, GFP_KERNEL);
 	if (!command_out_urb) {
 		retval = -ENOMEM;
-		goto error0;
+		goto err_put_udev;
 	}
 	command_res_urb = usb_alloc_urb(0, GFP_KERNEL);
 	if (!command_res_urb) {
 		retval = -ENOMEM;
-		goto error1;
+		goto err_free_out_urb;
 	}
 	/* this also allocates memory for our VUB300 mmc host device */
 	mmc = mmc_alloc_host(sizeof(*vub300), &udev->dev);
 	if (!mmc) {
 		retval = -ENOMEM;
 		dev_err(&udev->dev, "not enough memory for the mmc_host\n");
-		goto error4;
+		goto err_free_res_urb;
 	}
 	/* MMC core transfer sizes tunable parameters */
 	mmc->caps = 0;
@@ -2344,10 +2344,11 @@ static int vub300_probe(struct usb_interface *interface,
 			 interface_to_InterfaceNumber(interface));
 	retval = mmc_add_host(mmc);
 	if (retval)
-		goto error6;
+		goto err_delete_timer;
 
 	return 0;
-error6:
+
+err_delete_timer:
 	timer_delete_sync(&vub300->inactivity_timer);
 err_free_host:
 	mmc_free_host(mmc);
@@ -2355,12 +2356,13 @@ static int vub300_probe(struct usb_interface *interface,
 	 * and hence also frees vub300
 	 * which is contained at the end of struct mmc
 	 */
-error4:
+err_free_res_urb:
 	usb_free_urb(command_res_urb);
-error1:
+err_free_out_urb:
 	usb_free_urb(command_out_urb);
-error0:
+err_put_udev:
 	usb_put_dev(udev);
+
 	return retval;
 }
 
-- 
2.53.0

