Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794283004;
	b=i3xEzsEDoQIVWh0vqgRNkdqtELCoyh8ZadeQIeHm++oHfsrWcPueogFkK3coqXA6rYQs
	 aeFArMXEFokNtINlh224kS/xhisP1kYD2SYOs5sK9HFNkibFL1rZ7mAaVpc2XugTwhzGJ
	 Vk3YIxxNjknc25ANdi6mxtAi52t4boM+UTukYTgT/3UuqSzH1EM1k3Pb0WfaiSByR9U5t
	 cVDW4tpkdpR3z2qy/8ukg+nF5n5EkG0rJCk0bztto4qEfq2j54yTq4+TAguD3OuqK/UrX
	 2IOx/m/kQQYEXANHu8AoSyJXFwPaJnc0WDDxL+Uvyy+T++31POtmu2OWVOvbLcaBMcw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794283004;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=FQRPAOczeChNohAnaECEMnatXU5EQobFRvNRBtV70cc=;
	b=vyoEja9Vsho488WmZTaWCriHP2/2j9cP4YBwXGxHLiarJYW8etbzBWfVt2tB5A3N2HcN
	 IMEhHeqg385EBzofQsfYR/UPd6xpcPl5YziLStxTU/y6OZTk63LIfCF6fMo8BBla68wUY
	 DbFZNh/Kda+oWOdZMWkD+L8TPrWoUmH/74kmg2zbnGbaV8UGb+KhQIW4I979piA3jmTfw
	 BOkvbmg2140+cJ2wgkwbrc+Y8ctcTq29m4YNU0M9nGf15p4WMjEDVLWO7aRVRkI/r6Aq1
	 csGYgbz/xd3sYRdCa26fhVoB5s/pVsAmmnUqjHpG1LhOaxR4tsjjDwgH5QOYPQavqcg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JxgomqhI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E30606A325;
	Tue, 10 Nov 2026 03:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JxgomqhI
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794283003;
	b=bq2aUsS0lxmeUTxCHutLfGtm/H6mFmH9xFtPFtYOht99Po1f89VdcHZP63KfH6MMWSX9
	 9YvmcydHuF5dDL4MUk0nIiqfTkY1iO8dsSvhkcYQdJdgAKPL2nShExfNXdVFkE8rjFDsS
	 ANlujDI0imHdFLVBtb5noYYzruJhnW9wTCMXxX2C3sqxa1JW7aDJj3vAjjaMOH33yu7Gb
	 irkg/r9MMh+AF3B9JbLuSZJX0MgEMcMIK9sE4BZnl2f4XpxE7+pQ7alGKiznJdAohQJMt
	 1U4EJNPjPMDghfTpPjDQPCTafyeS0tJBaS7FHPNpQYHqaWHAFLJdJRIJYfLKYTTBbhw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794283003;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=FQRPAOczeChNohAnaECEMnatXU5EQobFRvNRBtV70cc=;
	b=xze/Kwg0wETMy5l3qihVE3zyETkUsVjRn96XoOH6hlDjnlfjFGWLaewmWm7raHO6bEx7
	 c/HzAcp2SRDwTec2SYi3OYXmO5MauALteNvS5q3fYP+vqaGJ390wx8fkmZEi4692B/Fks
	 /pxWO4ebGB7afxODATk05OSfzlPSMCfL4Etjcbh+XVuzFxI1CHyTUJp0sys3klGqAOU3b
	 NXG0t7iCXzJTXVkHYznhFgamzoeV9RJ+2hcjArgyBemrKknWkvmzM2hYe28Zq0qWeGgSM
	 VZ65b5SgyiUzYqP8a78mBELgEvngRLYzCF4bZ32tQpjmg7Aqx9bJo3baJ9hPQpt7Snw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A690B1F008A4;
	Tue, 10 Nov 2026 03:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794283003;
	bh=FQRPAOczeChNohAnaECEMnatXU5EQobFRvNRBtV70cc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=JxgomqhIRIaaT8f5vJlzyVMnQ9+Jz1X60pGJB/oTeNkitYTni3NcfGnMbD1HiHGYT
	 Vc6gTYUQq7M8BCYzhOQ+ciix3W/PdORphsDURUtSl39tin9jud8836U9knT+8wcmeL
	 SA5Bws1wnrlupf/hqTZnmV+z/9lIFZuykNWgsUPAcyglnzbT6cl9mMjEjTtvLIavSK
	 QUiI91KiJtGCeozs63GvqcqjWB3onz+rzh6d8JJ0bJJXvGmQZ6IMPxNYL78UmvVSkT
	 h+sPwbKpvUyUEi7M4s0pHxzEb/fBbVWbx3gQRtxzT6B1YbSzPyXuxn3z7lZRbj8CRN
	 GR2lQjGhcA+zw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3442D487F1;
	Tue, 10 Nov 2026 03:56:42 +0000 (UTC)
From: Joas Antonio dos Santos via B4 Relay <devnull+joasantonio108.gmail.com@kernel.org>
Date: Tue, 10 Nov 2026 03:56:43 +0000
Subject: [PATCH 2/2] can: kvaser_usb: reject devices reporting zero max
 outstanding tx
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
Message-Id: <20261110-kvaser-usb-validate-v1-2-f266b85aa908@gmail.com>
References: <20261110-kvaser-usb-validate-v1-0-f266b85aa908@gmail.com>
In-Reply-To: <20261110-kvaser-usb-validate-v1-0-f266b85aa908@gmail.com>
To: mkl@pengutronix.de, mailhol@kernel.org, joasantonio108@gmail.com
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794283001; l=1920;
 i=joasantonio108@gmail.com; s=20261031; h=from:subject:message-id;
 bh=CWXGNrvsTmGzERh91MhkIoNvIPE1iZLcRy1k5EnUGBw=;
 b=SPDeDXx/noF/b91sP8wtQ3fgDtpmBqDRVZprOpBYymgVpwiPSjGcyAfv1RzxJGiyaqozTTpcv
 VDkPMfR4eQLDUhRuS2IZio9mS4cfCm8xd8mU4qikfxA9++DceG7HYAB
X-Developer-Key: i=joasantonio108@gmail.com; a=ed25519;
 pk=ZxAznJT/FcPPdzLrDDFJQm4LLjjHVGBBqDSG3TXS23w=
X-Endpoint-Received: by B4 Relay for joasantonio108@gmail.com/20261031 with
 auth_id=1371
X-Original-From: Joas Antonio dos Santos <joasantonio108@gmail.com>
Reply-To: joasantonio108@gmail.com
Content-Transfer-Encoding: 7bit

From: Joas Antonio dos Santos <joasantonio108@gmail.com>

The number of tx contexts is taken from the max_outstanding_tx field of
the software info reply sent by the device.  The leaf driver uses the
value as is and the hydra driver only limits it to
KVASER_USB_MAX_TX_URBS, so a device can report zero.

dev->max_tx_urbs is then used as a divisor when a tx acknowledge is
received:

  kvaser_usb_leaf_tx_acknowledge()
	context = &priv->tx_contexts[tid % dev->max_tx_urbs];

  kvaser_usb_hydra_tx_acknowledge()
	context = &priv->tx_contexts[transid % dev->max_tx_urbs];

With max_tx_urbs == 0 a tx acknowledge sent by the device while the
interface is up is a division by zero in the URB completion handler on
architectures that trap on it.  On architectures that do not
trap, the index is not reduced at all and tx_contexts[], which was
allocated with zero elements, is accessed out of bounds.

A device that cannot accept any outstanding tx frame is not usable, so
fail the probe when it reports zero.

Found by LLM-assisted source review.

Fixes: 082d70b6142f ("can: kvaser_usb: Comply with firmware max tx URBs value")
Cc: stable@vger.kernel.org
Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index d0a2a2a33c1c..a915e529290b 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -977,6 +977,12 @@ static int kvaser_usb_probe(struct usb_interface *intf,
 		goto free_devlink;
 	}
 
+	if (!dev->max_tx_urbs) {
+		dev_err(&intf->dev, "Invalid max outstanding tx (0)\n");
+		err = -ENODEV;
+		goto free_devlink;
+	}
+
 	if (ops->dev_get_software_details) {
 		err = ops->dev_get_software_details(dev);
 		if (err) {

-- 
2.43.0


