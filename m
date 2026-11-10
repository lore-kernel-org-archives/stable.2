Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794294534;
	b=1kyqYwDaJelp0fYbF90vmgekV74xLITO1cvYpKd3kfPUv7OQC9SUL0eUPc0RPnrFrsx2
	 ggWe5fjdp+4S0yMRxGHEQYXIVD309wxkMagjpc6pCKVcT47LHBXsCh7DWuzM2ma7Q8Y0t
	 qt6rQQ/2JjH8ugpZzWDlqi2kXxd/iDxDz+CW3ZTKVlMFXaX9I1M8TYDEx3DAn980lpJAE
	 vuWtWrkVKJBD6KFK9Q9OQoF6vpV1ocD/lhpbYmVdrnuEwOExlXOL2Ar8GHONx3I5AJjOd
	 pReVTOsi7SkLt1+D18kqahFupFttxO89pvQWcwr5P9GGXxcXR3X1H+XAPv8H/nFv/3g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794294534;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=4GGcNU5e5uIHD896KUGG6qBkwzY4UuTfmj4ZpF6Jokc=;
	b=g6R/9wBCwrrLvm9jqKE5fLVIAQyR0yQAffq29rEqVS88gnNJNhSUmZJoN9mKIM+hElaI
	 Gewul3ALU1osxmPJeLhvJvFhZVpl3/3qMh0NoT4vsihaZLiQ+uaonM37H/1Vk066C3WlH
	 IMXoXlHytOpMjYQeA1kBKSwbz4T47qzb+UOP/s85upcCpRFBdyAbfzR6KXSXJzY5da85C
	 qMpbqb3Ce+u783RQwCQcNK52sYslPanO6pSZq5+JM/LdPnaf4b/oVBNBG68PJA9vnOUsX
	 Pn7QuS7ZnztFEQR0UIZTXqdlGhkBpniytNhmDskHS4/LGzWbqNXoqmKs8ZHUa8R2QkQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YwZbRMXn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812D2606A33B;
	Tue, 10 Nov 2026 07:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YwZbRMXn
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794294534;
	b=DckU4pmtAQo4uHypGbKbDRFd0x9El26uDTnW7rhJfDnhsHeCoo6UQ3uC6WG2CvMZwfiL
	 hrVjGzvjhVUVFdsVbFf0SwIiknfueWsCCeYA6B6NCLDAxY2KPy4/zOPlh2RsDM5lUWUf8
	 +vGw0P8wgmBT/tAbJUUofy/YhcGCBqk8kBc4Eh2if6vEXT+EUNt+G7FYSlPYmhZEUU73s
	 t9ZCGtP0LwQM5334ke1VWB/12Ric82F7LWSfoJ8SAM3KPro/KPd8gEaG1VFzhslrIt/fj
	 UXPRwPDdc0DVCPPKnSlAYOZ/dsoUekEsl0r8eO4XHp6Oe7z7icfEY3W9Mc3nt+P1I6w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794294534;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=4GGcNU5e5uIHD896KUGG6qBkwzY4UuTfmj4ZpF6Jokc=;
	b=p7/5hVlfxekU+luGhnfPuNU6R2RUqvkxY10Gn3yTnN9WzjdYikJSAyOZ7/rgPx6OnIwK
	 nmDGVVjlyiYItW42AbZM99uRIGx877IfTaAt9NjcJbN+2L3jFnAVUO3V1WFjXzylV/xJK
	 d6Yom+QqrdWEPMmKaFwSMC8wmtkY9Wa6qkTSSzOK38YHd4fXTrM7dQy72SasoRl+XHrUh
	 lQt2gX3zUsOiR/fW982SJ+TprlfRXySkYmrVnPUMCnJSCllvuch2rY7264bYBHhdMQYqv
	 LNJXrY5S5tIidZTYZyvdhJtRcaPmnnY0bt6VXurP3TbTibTS6U6GYuVRHMa4ikJQy5g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 0AC2A1F0089F;
	Tue, 10 Nov 2026 07:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794294534;
	bh=4GGcNU5e5uIHD896KUGG6qBkwzY4UuTfmj4ZpF6Jokc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=YwZbRMXngb1885fy75xHZ7gEZRxqJi4GuObApJ6P2blGY0vF8oQuptWckZ0aHWtIW
	 Jsk4PhmZuGSwBI3y9RLE9jP561nV6TGz8R75mKD9OMuClF3YjisHG6p4DWRR1TVdUw
	 jb6mdkHODOaEvcwRwC1FMXweCupc1/EuEvrZtlR3T7E9lkRi6Cveq6mwseJSC79lLB
	 XW3qMJCj40ee0xQubJliv3HWFYA6C8O8xAtH/oUasnfwdMemk8RnStXTv3x77OSFu6
	 IbxbcyFjHOc/Kjnkre33q6w3G2GsDLbGXTPYlp8R/Yfcepf9/97RGfVLQ+CzhdnA4i
	 m5MXaauf+jd/w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 88F344890A;
	Tue, 10 Nov 2026 07:08:52 +0000 (UTC)
From: Rajan Yadav via B4 Relay <devnull+rajanyadav0307.gmail.com@kernel.org>
Date: Tue, 10 Nov 2026 01:08:52 -0600
Subject: [PATCH 1/2] usb: musb: sunxi: Unregister the generic PHY after
 dropping its reference
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261110-musb-sunxi-unbind-v1-1-d821584fc4a4@gmail.com>
References: <20261110-musb-sunxi-unbind-v1-0-d821584fc4a4@gmail.com>
In-Reply-To: <20261110-musb-sunxi-unbind-v1-0-d821584fc4a4@gmail.com>
To: Bin Liu <b-liu@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>
Cc: regressions@lists.linux.dev, Zijun Hu <zijun.hu@oss.qualcomm.com>, 
 linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Rajan Yadav <rajanyadav0307@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794294532; l=4698;
 i=rajanyadav0307@gmail.com; s=20261103; h=from:subject:message-id;
 bh=eUHfUOy8mHnS4tm+sNyfT5FtNME+N65p3UiFyU70Ldc=;
 b=93/spdKuFn6nPrVDmAMIQZKoYK4cgQR8a2VXwb5WXdpzGlWQ7Ic5L36HW8mRwYr7mHCUJlTpe
 XWCZLNN04/MDY8OWQbFG6WWtp4QHLUP1IkMGhO0PMTBIbCjSrZC4O2H
X-Developer-Key: i=rajanyadav0307@gmail.com; a=ed25519;
 pk=4ZPeiP5qrv2b44q/Obxi2koUS70Q6npbttJnpUoTlgg=
X-Endpoint-Received: by B4 Relay for rajanyadav0307@gmail.com/20261103 with
 auth_id=1391
X-Original-From: Rajan Yadav <rajanyadav0307@gmail.com>
Reply-To: rajanyadav0307@gmail.com
Content-Transfer-Encoding: 7bit

From: Rajan Yadav <rajanyadav0307@gmail.com>

Unbinding musb-sunxi oopses on v7.4-rc1 (KickPi K5C, Allwinner A133,
KASAN enabled, no out-of-tree modules):

  # echo 5100000.usb > /sys/bus/platform/drivers/musb-sunxi/unbind
  BUG: KASAN: slab-use-after-free in devm_usb_phy_release+0x2c/0x68
  Read of size 8 at addr ffff0000057ef080 by task sh/329
  ...
  Allocated by task 48:
   ...
   devm_kmalloc+0x5c/0x140
   usb_phy_generic_probe+0x30/0x184
   ...
   usb_phy_generic_register+0x9c/0xd8
   sunxi_musb_probe+0x310/0x5c8
  ...
  Freed by task 329:
   ...
   platform_device_unregister+0x24/0x40
   usb_phy_generic_unregister+0x10/0x1c
   sunxi_musb_remove+0x44/0x54
   ...
  Unable to handle kernel NULL pointer dereference at virtual address 0000000000000010
  ...
  pc : devm_usb_phy_release+0x44/0x68

sunxi_musb_remove() unregisters the usb_phy_generic device. That unbinds
its driver, which frees the struct usb_phy_generic holding the struct
usb_phy. The reference that sunxi_musb_probe() took with
devm_usb_get_phy() is only dropped after that, when devres runs, and
usb_put_phy() then reads x->dev->driver->owner from the freed PHY with
dev->driver already NULL. The probe error paths unregister the generic
PHY with the devres reference still held in the same way.

Commit 6ed05c68cbca ("usb: musb: sunxi: Explicitly release USB PHY on
exit") fixed this oops in 2017 by calling devm_usb_put_phy() in
sunxi_musb_exit(). Commit 498dbd9aea20 ("usb: musb: sunxi: Fix
accessing an released usb phy") removed that call again, because
sunxi_musb_exit() also runs when only the musb-hdrc child is unbound,
and the PHY must stay valid for the next bind. That brought the oops
back.

Keep the reference for the lifetime of the glue device, as 498dbd9aea20
intended, and let devres unregister the generic PHY device as well. The
action is added before devm_usb_get_phy(), so devres drops the
reference first, on unbind and on the probe error paths.

Tested on the K5C with v7.4-rc1 and KASAN: unbinding musb-sunxi gives
no KASAN report and no oops, the generic PHY device, musb-hdrc and the
UDC are removed and come back on bind, and 11 unbind/bind cycles stayed
clean. The probe error paths were not exercised, and no USB gadget
traffic was tested (no data connection to a host).

Claude Code (Anthropic) found the cause from the oops, wrote this fix
and the commit message, and helped with the tests; I reviewed the fix
and ran the tests on the board.

Fixes: 498dbd9aea20 ("usb: musb: sunxi: Fix accessing an released usb phy")
Cc: stable@vger.kernel.org
Signed-off-by: Rajan Yadav <rajanyadav0307@gmail.com>
---
 drivers/usb/musb/sunxi.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/musb/sunxi.c b/drivers/usb/musb/sunxi.c
index a6bd3e968cc..d880c3758c9 100644
--- a/drivers/usb/musb/sunxi.c
+++ b/drivers/usb/musb/sunxi.c
@@ -674,6 +674,11 @@ static const struct musb_hdrc_config sunxi_musb_hdrc_config_4eps = {
 	.ram_bits	= SUNXI_MUSB_RAM_BITS,
 };
 
+static void sunxi_musb_unregister_usb_phy(void *usb_phy)
+{
+	usb_phy_generic_unregister(usb_phy);
+}
+
 static int sunxi_musb_probe(struct platform_device *pdev)
 {
 	struct musb_hdrc_platform_data	pdata;
@@ -768,11 +773,21 @@ static int sunxi_musb_probe(struct platform_device *pdev)
 		return PTR_ERR(glue->usb_phy);
 	}
 
+	/*
+	 * Registered before devm_usb_get_phy(), so that devres drops the
+	 * reference to the PHY before the PHY device is unregistered.
+	 */
+	ret = devm_add_action_or_reset(&pdev->dev,
+				       sunxi_musb_unregister_usb_phy,
+				       glue->usb_phy);
+	if (ret)
+		return ret;
+
 	glue->xceiv = devm_usb_get_phy(&pdev->dev, USB_PHY_TYPE_USB2);
 	if (IS_ERR(glue->xceiv)) {
 		ret = PTR_ERR(glue->xceiv);
 		dev_err(&pdev->dev, "Error getting usb-phy %d\n", ret);
-		goto err_unregister_usb_phy;
+		return ret;
 	}
 
 	platform_set_drvdata(pdev, glue);
@@ -792,23 +807,17 @@ static int sunxi_musb_probe(struct platform_device *pdev)
 	if (IS_ERR(glue->musb_pdev)) {
 		ret = PTR_ERR(glue->musb_pdev);
 		dev_err(&pdev->dev, "Error registering musb dev: %d\n", ret);
-		goto err_unregister_usb_phy;
+		return ret;
 	}
 
 	return 0;
-
-err_unregister_usb_phy:
-	usb_phy_generic_unregister(glue->usb_phy);
-	return ret;
 }
 
 static void sunxi_musb_remove(struct platform_device *pdev)
 {
 	struct sunxi_glue *glue = platform_get_drvdata(pdev);
-	struct platform_device *usb_phy = glue->usb_phy;
 
 	platform_device_unregister(glue->musb_pdev);
-	usb_phy_generic_unregister(usb_phy);
 }
 
 static const struct sunxi_musb_cfg sun4i_a10_musb_cfg = {

-- 
2.34.1


