Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794301406;
	b=B0tCOvnJN4xxGGq4Gr4K2q8FSwe5Zt+vaXd6yftiCIzEgt99936w5YpzqpoSxqrBc+aJ
	 xDLQ1tHvIOa3LVmIf0SXdsHO4gh/qyplc2bsuZqI+hvMqNe8mGERl+cQ53cSaXTpzMwu5
	 DH3xr2dczgtmFeHciIp5Q9KpWdXu4jaYAzr8DPh6MS7VbynLBp62Wwhl015uur/KxUjOh
	 4PwqzlaYw0l8jTZFpW/GVNnp5d489Ts1pUBvH5PV7/9PFcN3vufx+UG6YzEkBNE2Oy5hH
	 QtpLWrtIq9JDct+RBgUd586GbGYfHEIni2ALsByikc0SQyt3DMDTZWS0sIk124tWLrg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794301406;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=C2i4lkgCNHuL77WPS8g6z7ScnYZzVUFlX/5CnzjjXPA=;
	b=oI1TDEntWnIxyXPBLsknsRfqD2HU/1+rLS809qighi8uY7bt+7Et/8d5NXROp+GkRTFG
	 pHyWyGII6ojFGlkaAwcMRu2rvmZQhyK8xKFoxF/i0CVoknvCCbBQ9akCoFL3JIASA5pSs
	 MLRTrZi+83GjmVhAPumGc6EE+bHpfUHmr944KywxnN49AR6P2JBDoU6Y1fULZLBzkULtc
	 1HBCtQUUKZlazvHLEsYoPQkkBMWpyiR2eVtPeHE5aByPe7Bq4W+pltpmjmiCH4IDD0Ix2
	 L3yAH76jKN9SpaZZv0bx5odi7Pb5yLP7ZkBPpLTr6wDnY+yWfVfZT0j2ysKXVxvQaug==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="OziTR/9y";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF6160A3813;
	Tue, 10 Nov 2026 09:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OziTR/9y
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794301405;
	b=I7wPL6iYqr4kzc9b3KJpPbNt5f9c1naGJkmbtERal7y5LYODdAIKFG9mQZepEtLt9uhQ
	 Aas5RQnzmmnBADcjVnch79dJYTkFGUH0TyoJWGRs5yDN7viUClT+J+RBMUDI+vZfIBsTv
	 ca1Kc6I0ufGE/qDoL8wx8K6nhgoCt4U6htYTZLrUxZRnykfWgBTpnxBe7UIIDomsjfYe6
	 2p76Qj3Jc5QgG5FFlhh7YSGes1OcfdEW//87V1A+hzivqqDDY9gF6Zn9FrHxbnf9C35qJ
	 jcWOlb2vh2/jIVyPecTi64GbgqrwRM5uSpEZ65J3zXmdTSjkbxa5lzv3yJtaTSTbzYg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794301405;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To:
	 Content-Transfer-Encoding;
	bh=C2i4lkgCNHuL77WPS8g6z7ScnYZzVUFlX/5CnzjjXPA=;
	b=VExCWyJ4wcZF72aiWuh8xOO0YjQd02PLjnlE9wglAbNu/RtnFSIgnK6Fn2wek57wKVkz
	 wRGlT8moTbvQ/wNCy3pkw9hTE47mFuyXrkCzmvY6609R/1IGG2bvaZe+yPhz3frveaJTZ
	 jjfzv9pr1Z6LT/DkC/nDigyeJGQJOrQaSPM3Vz8KY+btKVHtS6xyqS2nZDS5r2hz8qmyW
	 +3bR92h3VgmX6qih8ZFwxrmVn0xAeP0sE6IRo9yy55QETjK4yy6ZMM5UNczxGrx18P9JZ
	 CoaP3jTb2IxAGXqDbae+FQI68Vxjit++48VTiyh4WA+8q/KU2Gpv4O7hD3OHWIZS8Hg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 14E061F008A3;
	Tue, 10 Nov 2026 09:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794301405;
	bh=C2i4lkgCNHuL77WPS8g6z7ScnYZzVUFlX/5CnzjjXPA=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=OziTR/9yUqewNjsTzwJM6jFn+EZOtyoLbd+cv9WsbJZ8SoTH7GgA44BbZJf+0wYro
	 NjAej3AfEqGjo2K+hcMLAiDKhziI4IKropYl7nsxZ5jySeTOuiCOiGutYyUePd7O0L
	 S1Ge2cK4kPdtCAnEXgzl4lxkKiXw7/FsJ4w3zacJK/rt0KygGgSVMVqVehvqBe4OCX
	 LCl2R/BsSR6IZ5/9rD45nktGYD9ATCrFT4S+4YHeoYIvtqa7j/e7YKzibmNp5q3J6L
	 YvlBFhQIYMvDjKW/6LU+RlgPXcW6v0WBMtTu8ymczTj0IpGNjCHtmdXKryCG2ZUQtu
	 nonRdl8jpMLYw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 9577648A57;
	Tue, 10 Nov 2026 09:03:24 +0000 (UTC)
From: Joas Antonio dos Santos via B4 Relay <devnull+joasantonio108.gmail.com@kernel.org>
Date: Tue, 10 Nov 2026 09:03:25 +0000
Subject: [PATCH wpan] ieee802154: atusb: complete each transmitted frame
 only once
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
Message-Id: <20261110-atusb-tx-once-v1-1-43e2b92f2072@gmail.com>
X-B4-Tracking: v=1; b=H4sIANzd8moC/x3MPQ6AIAxA4auQzjahmjB4FeOAUrQLEMCfxHh3i
 eM3vPdA4SxcYFQPZD6lSAwN1ClYdxs2RnHN0OveEJFGW4+yYL0xhpXROPKD0+QWZmhNyuzl/n8
 TXMkGmN/3AxupegBlAAAA
To: joasantonio108@gmail.com, stefan@datenfreihafen.org, 
 alex.aring@gmail.com, miquel.raynal@bootlin.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, 
 kuba@kernel.org, pabeni@redhat.com, linux-wpan@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794301404; l=3532;
 i=joasantonio108@gmail.com; s=20261031; h=from:subject:message-id;
 bh=Vqtsi3F3WbF3wGvBDjFI4OLrDf6LJpOQrNpq3siz01Y=;
 b=YLDXtuy52tYz/Ou2wD1yFBUb5xWkkhrAYZYVum7ArT6TZsxMUmWPGBGC9NpSFJwXBfn82Ts/E
 n2Vw5tqBS4XCwRu9XnMgFWckLqbWTmmIWEqWKo12JF0M2afhiv+Iwvm
X-Developer-Key: i=joasantonio108@gmail.com; a=ed25519;
 pk=ZxAznJT/FcPPdzLrDDFJQm4LLjjHVGBBqDSG3TXS23w=
X-Endpoint-Received: by B4 Relay for joasantonio108@gmail.com/20261031 with
 auth_id=1371
X-Original-From: Joas Antonio dos Santos <joasantonio108@gmail.com>
Reply-To: joasantonio108@gmail.com
Content-Transfer-Encoding: 7bit

From: Joas Antonio dos Santos <joasantonio108@gmail.com>

atusb_xmit() stores the frame being transmitted in atusb->tx_skb and
atusb_tx_done() hands it to ieee802154_xmit_complete() or
ieee802154_xmit_error(), both of which free it.  tx_skb is never
cleared, and atusb_in_good() calls atusb_tx_done() for every one or two
byte bulk-in transfer it receives from the device.

A device that sends a second tx completion report after a transmit
therefore makes the driver free the same skb again, and drop
phy->ongoing_txs once more.  A report sent before the first transmit
calls the completion helpers with a NULL skb, which frees nothing but
still drops phy->ongoing_txs.  The stale pointer is also left behind when
usb_submit_urb() fails in atusb_xmit() and mac802154 frees the skb.

A malicious or malfunctioning USB device can use this for a double
free of an skb once the interface is up and a frame has been sent.

Take the skb out of tx_skb when completing it and ignore completion
reports when no frame is pending.

Found by LLM-assisted source review.

Fixes: 7490b008d123 ("ieee802154: add support for atusb transceiver")
Cc: stable@vger.kernel.org
Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
---
This issue was found with the help of an LLM-based code review tool
(Claude).  I checked the code paths by hand against v7.4-rc3 and
reviewed the fix myself.  It is build-tested only (W=1, arm64); I do
not have the hardware to test it at runtime.
---
 drivers/net/ieee802154/atusb.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ieee802154/atusb.c b/drivers/net/ieee802154/atusb.c
index 5f7fc4ee7a07..2460eb19b72b 100644
--- a/drivers/net/ieee802154/atusb.c
+++ b/drivers/net/ieee802154/atusb.c
@@ -195,21 +195,26 @@ static void atusb_tx_done(struct atusb *atusb, u8 seq, int reason)
 {
 	struct usb_device *usb_dev = atusb->usb_dev;
 	u8 expect = atusb->tx_ack_seq;
+	struct sk_buff *skb;
 
 	dev_dbg(&usb_dev->dev, "%s (0x%02x/0x%02x)\n", __func__, seq, expect);
+
+	/* The device may report a tx completion when no frame is pending,
+	 * or more than once for the same frame.  Complete each frame only
+	 * once.
+	 */
+	skb = xchg(&atusb->tx_skb, NULL);
+	if (!skb)
+		return;
+
 	if (seq == expect) {
 		/* TODO check for ifs handling in firmware */
 		if (reason == IEEE802154_SUCCESS)
-			ieee802154_xmit_complete(atusb->hw, atusb->tx_skb, false);
+			ieee802154_xmit_complete(atusb->hw, skb, false);
 		else
-			ieee802154_xmit_error(atusb->hw, atusb->tx_skb, reason);
+			ieee802154_xmit_error(atusb->hw, skb, reason);
 	} else {
-		/* TODO I experience this case when atusb has a tx complete
-		 * irq before probing, we should fix the firmware it's an
-		 * unlikely case now that seq == expect is then true, but can
-		 * happen and fail with a tx_skb = NULL;
-		 */
-		ieee802154_xmit_hw_error(atusb->hw, atusb->tx_skb);
+		ieee802154_xmit_hw_error(atusb->hw, skb);
 	}
 }
 
@@ -351,6 +356,8 @@ static int atusb_xmit(struct ieee802154_hw *hw, struct sk_buff *skb)
 			     (unsigned char *)&atusb->tx_dr, skb->data,
 			     skb->len, atusb_xmit_complete, NULL);
 	ret = usb_submit_urb(atusb->tx_urb, GFP_ATOMIC);
+	if (ret)
+		atusb->tx_skb = NULL;
 	dev_dbg(&usb_dev->dev, "%s done (%d)\n", __func__, ret);
 	return ret;
 }

---
base-commit: b3dfbde62cf1981c4638939c159dfd087b7a72e9
change-id: 20261110-atusb-tx-once-6d1f3d01dbee

Best regards,
-- 
Joas Antonio dos Santos <joasantonio108@gmail.com>


