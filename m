Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF98E3CF670
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 23:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785195289; cv=none; b=WzeO+k+2RwD+/ggzRob7q+Rou/6B/Qkdz8VfZIsMlv3T9BPyPKtpZeWS1OGqOUEQyGfB07MwQ+Brd/KNpc8EKf8nFEpcrxC4cOpOxDdBCcLdj0UmQtDMdvhNTHQiZwL9gllMbJf4Ij07Arv86+o6oGVbz+3nGD7SNub2NcoogMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785195289; c=relaxed/simple;
	bh=2BsqbOk6bxQUGBZvOJ/ggRR8iGfsgtRWCBXDKS+BaRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XfFd12/jlFaNaSo3KBSyADFjWvP7v3xC/1BFFW2SI5iJs507zv0awAMypifSmVLDpDUCnsRd6buxX30jro/gYNEv47Rm5URUbjuINxqqxkKf+w0+az/p9nboFddAxmP1iPw0xJGhZXtGWV1g8WzpV4tfLVswINDBHnsvZNAkz/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rzm4Gc5B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rzm4Gc5B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47B9C1F00A3D;
	Mon, 27 Jul 2026 23:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785195288;
	bh=ZOdjr5btPTTAbxe5eWhT1WOGMZ0tLd/jdS9tol/WAdA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Rzm4Gc5BxiVi1ZyCihlbG7yY51NvXjQNkzWuWTV1wiPZVsXBV1sKiggiGdTMIm7Nf
	 5Z0+VDstOZLjgLrCyk1fqki8XSDKbtJIVwbEw73rkYD9ITpRuYTL2UYA5xls+z/N4L
	 XcKHPiffpSm0+PgnsbCdO7euYzSLSLWdS1bxL1ubqWP/GrQ6dzAjEB32aWwA6Cdjbk
	 fI6Gv3n9ES6FdkJ2zDvOTHFl1ea6yY/JUue5hVHXekS//eI6kqsGl0xqZ0aTpj6nXH
	 pkboS0Vph7XkL24Ahtkji4YwNRYZiCLAUaeHSDnraS68TydK1veX3Ga1EYZZN7FID5
	 ovMVrjrG9ReWg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 6.12.y 2/3] mmc: vub300: rename probe error labels
Date: Mon, 27 Jul 2026 19:34:43 -0400
Message-ID: <20260727233445.2426041-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727233445.2426041-1-sashal@kernel.org>
References: <2026072046-octane-riverside-49ce@gregkh>
 <20260727233445.2426041-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johan Hovold <johan@kernel.org>

Error labels should be named after what they do.

Rename the probe error labels.

Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
(cherry picked from commit 5b8b35d6f4fa758dd5e8ae18526ea1c73f6787e0)
---
 drivers/mmc/host/vub300.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
index b39978357aab28..caf19051ebb483 100644
--- a/drivers/mmc/host/vub300.c
+++ b/drivers/mmc/host/vub300.c
@@ -2114,19 +2114,19 @@ static int vub300_probe(struct usb_interface *interface,
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
 	mmc = mmc_alloc_host(sizeof(struct vub300_mmc_host), &udev->dev);
 	if (!mmc) {
 		retval = -ENOMEM;
 		dev_err(&udev->dev, "not enough memory for the mmc_host\n");
-		goto error4;
+		goto err_free_res_urb;
 	}
 	/* MMC core transfer sizes tunable parameters */
 	mmc->caps = 0;
@@ -2343,23 +2343,25 @@ static int vub300_probe(struct usb_interface *interface,
 			 interface_to_InterfaceNumber(interface));
 	retval = mmc_add_host(mmc);
 	if (retval)
-		goto error6;
+		goto err_delete_timer;
 
 	return 0;
-error6:
-	del_timer_sync(&vub300->inactivity_timer);
+
+err_delete_timer:
+	timer_delete_sync(&vub300->inactivity_timer);
 err_free_host:
 	mmc_free_host(mmc);
 	/*
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

