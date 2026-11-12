Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794500608;
	b=Gdmn3mCpwoD0NLUsd3Or2eM5FyVeyK/CTR8pQRebrn0687n/aC0R8ej6+nyHJrChp4AP
	 7IDK0i6IqE/SrSjBTArx1wYjbxd79Bptc+UchA1E8wU+ct/KjU0LOCILARq+ACBrc9IgZ
	 ZN2zxevyavX0PUINX/Fld1UMxjN5I8/IhDSToGHE/Bq0k2Pv5GzXUwP3pcam1Ubdx5cn0
	 ekr3p2e704nO3tOMh4VE3YjFNElMpUW3wziRRHJxO+CYe0djP0aHt3O/eurTBr0Io9Vzy
	 jvsS+D4PCQ/tHT2zcG0+fQgz83NBkbMc8ZLCR4S5kcM0Xep60uJ0zzB9WQxXecI+eVw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794500608;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=pYXPlS8ROzYN1Pjw5sKrw1zWinTArIcM5b5Sg8enWjM=;
	b=cRcSJV71yABdJ3titiQ0KZpiSCpn1W2U2Tj2mAbwPt2jmmPFHATvU7e493wyXUQmwZoM
	 r76b8b4BHY0njJCwWPVek88k6wKFKhKhB0+TxvAvrj1pl4h5UG1ojzKsu+HxyrsuH9zfS
	 bc1VwfHXu3jE7CnPuQ9C2J2HpaVfxxLvQlvhqyvvntWTgs3cnFOjMPwMXy7gjdxpIxdsg
	 Kx+N4UWFYn54w4Qb9PiULOZhRxiHqlu89jlCNcthjDKO+jjsN5e/a/OXatsIjApYbpkbg
	 GbH5QLHSa2jCZyt6QeYejQS8IosxqtYACd9D0DtnUmMYBi5DgV1NnNqpcDcnaXZIf6w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AQ4aHI3I;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DEE606A327;
	Thu, 12 Nov 2026 16:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AQ4aHI3I
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794500608;
	b=ufoCvvuLnTe6zoS6T5eL7LgjMB8Ju2U8i2b3fzHmN/xLvlFWumZuFRvYtxyqHCg/sgRx
	 u87c7B9VoaUD2R9l83/x6raoxLLwKZHdl6dNRDC84DyMgqiOr5mI1x8n65qYeckCpjqgN
	 DSMq6WOZ359yDt5bCw3GvyQIeuJkKzoaHwms7XVJgmkU83D4mUFLR7nxUY6ux+DWJFvlb
	 Ne2OlfddMyrZsJWRuR9F61+/MOh3/aEZKtCOTYB+JSOW6ZaGAPXTXOJ+u2lXsxCWtm5Bn
	 Mfq/PMDcoDMMeVyP8+8dfdCHVo0yK/9xRJJ3q/o4S2KVX8+xZB2LMa5yVXsKYUv/kkA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794500608;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To:
	 Content-Transfer-Encoding;
	bh=pYXPlS8ROzYN1Pjw5sKrw1zWinTArIcM5b5Sg8enWjM=;
	b=MjvTh9xzDT/zSpenWdpLJv1d0RtrfY9Lw43P9OysK1Eezmxi91XgUP/2c35QRgL6d8dZ
	 Ry2aJxle7jpLjmbnD74Tbgomaqa/5rtdkaclBwsdbEMesfa0YEIEamr6qKQ6jYiQqg92E
	 FXxleM8+0WlTOYtkm3u0gpuguFZ46uiAl3bbbSquSJCMZKpmspzciFPrg1Wn3rsLqceRL
	 mHn/JNzWw42Ay+7Oa2qANejGKFBh1usWcGSSIfmBAiN8eBaqu0opCn1GMWTMPIp7KpyCS
	 6I+9mqju6ZJsR3k9YF+PjnxvRFVTH8iTx9Y9UbiTnSHXm8l3O6Fkerdw3g+LHyu0xvA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 81F431F000C4;
	Thu, 12 Nov 2026 16:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794500608;
	bh=pYXPlS8ROzYN1Pjw5sKrw1zWinTArIcM5b5Sg8enWjM=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=AQ4aHI3IfbnpmYX1QEJPZFbQaruMJ8sRMGxnmSG25hY8eejsCNq3BS59U88xRk8JR
	 xN/7Mi5IErfI7K9HdSC1LN2xOsN4Sj1wT9puN4NOzI7x1hcoQZGrmq3t/NUGH9rGza
	 sWx2+3Rpy8XgbP/3hS01m9FBWi4cnT8fnGpYD8tK85ocH1vZLVh4ZR+pbPA9KJMIXW
	 3jYDP1KIXqQt8VMumAUB6XqnagTkFT0yneHy7p4jV3dQGkgZ2GUFlplkDtMDvnL6GU
	 GNC0YvOn7k8VAvtyKujOu2dWd5T9SWTp6u7MmFxr3+pzH98lw/oy6W6tpFb1R6c+VY
	 PWelC4lA6Iz6g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D6E0C45A33;
	Thu, 12 Nov 2026 16:23:26 +0000 (UTC)
From: Joas Antonio dos Santos via B4 Relay <devnull+joasantonio108.gmail.com@kernel.org>
Date: Thu, 12 Nov 2026 16:23:27 +0000
Subject: [PATCH net v3] net: usb: smsc75xx: reject frames without a full
 header and FCS
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
Message-Id: <20261112-smsc75xx-rx-fcs-v3-1-6ad0378d0384@gmail.com>
X-B4-Tracking: v=1; b=H4sIAP7n9WoC/3WNQQrCMBBFryKzNtKZtjG68h7iIqaTNmBbSUqIl
 N7dkFVBXMzi/897s0Jg7zjA9bCC5+iCm6cc6uMBzKCnnoXrcgaqSCJiJcIYzLlNSfgkrAn59EW
 qzmJnGDL19mxdKsY7TLzAI5eDC8vsP+VLxDL9FUYUKBquGvW0hpStb/2o3etk5rG4Iu15/OUp8
 4RSt5akakjv+W3bvhOXSvnzAAAA
To: joasantonio108@gmail.com, steve.glendinning@shawell.net, 
 andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org, 
 pabeni@redhat.com, mim@microchip.com, Eric Dumazet <edumazet@kernel.org>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794500606; l=3488;
 i=joasantonio108@gmail.com; s=20261031; h=from:subject:message-id;
 bh=rUwS80b4pePMA3lfNfGIdy/LrPjLf6uFSScwd46/NRk=;
 b=PjXJ+J6T52qsH1PoEBA5N2iSUdmlYhsSAul/hw6JU6yWLyzYTWSvTnAmiKua1jYn+m/UF91/+
 hW0xqfGGr9rDJRoT4dGflYVEkjbo1Rwtl4SLnTI/KMbuPSXeJatgpsZ
X-Developer-Key: i=joasantonio108@gmail.com; a=ed25519;
 pk=ZxAznJT/FcPPdzLrDDFJQm4LLjjHVGBBqDSG3TXS23w=
X-Endpoint-Received: by B4 Relay for joasantonio108@gmail.com/20261031 with
 auth_id=1371
X-Original-From: Joas Antonio dos Santos <joasantonio108@gmail.com>
Reply-To: joasantonio108@gmail.com
Content-Transfer-Encoding: 7bit

From: Joas Antonio dos Santos <joasantonio108@gmail.com>

smsc75xx_rx_fixup() takes the frame length from the RX command word
supplied by the device and strips the FCS by using "size - 4" for the
allocation, skb_put() and memcpy() of each frame that is not the last
one in the URB.  The length is only checked against an upper bound and
against skb->len, so a device can report a length field of 2..5, which
gives a size of 0..3 after RXW_PADDING is subtracted.

size is a u32, so "size - 4" then wraps to 0xfffffffc..0xffffffff.
__netdev_alloc_skb() adds NET_SKB_PAD to the unsigned length, which
wraps back to a small value and the allocation succeeds.  skb_put()
adds the length to the 32-bit skb->tail and skb->len, which also wrap,
so the skb_over_panic() check does not fire.  The following memcpy()
then tries to copy almost 4 GiB from the URB buffer into that small
allocation and writes far beyond it.

A malicious or malfunctioning USB device can use this to corrupt
kernel memory or crash the machine.

A frame that holds an FCS but less than an Ethernet header is not
valid either.  usbnet drops it when it is the last frame in the URB,
but the other frames go straight to usbnet_skb_return(), where
eth_type_trans() reads an Ethernet header that was never copied into
the new skb.

Reject frames that are too short to hold an Ethernet header and an
FCS, which covers both cases with one check.

The driver does not set FLAG_RX_ASSEMBLE, so usbnet already counts
rx_errors when smsc75xx_rx_fixup() returns 0.  Also count
rx_length_errors for these frames, as usbnet does for the short frames
it drops itself.

Found by LLM-assisted source review.

Fixes: 1b3b2d9e772b ("net: usb: smsc75xx: stop lying about skb->truesize")
Cc: stable@vger.kernel.org
Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
---
This issue was found with the help of an LLM-based code review tool
(Claude).  I checked the code paths by hand against v7.4-rc3 and
reviewed the fix myself.  It is build-tested only (W=1, arm64); I do
not have the hardware to test it at runtime.
---
Changes in v3:
- Count rx_length_errors for the rejected frames (Andrew Lunn).
- Link to v2: https://lore.kernel.org/r/20261111-smsc75xx-rx-fcs-v2-1-216a5f26842a@gmail.com

Changes in v2:
- Also reject frames too short for an Ethernet header, combined with
  the FCS check into a single test (review feedback on v1).
- Subject changed accordingly; it was "net: usb: smsc75xx: reject
  frames shorter than the FCS".
- Link to v1: https://lore.kernel.org/r/20261110-smsc75xx-rx-fcs-v1-1-4e048bfc28f3@gmail.com
---
 drivers/net/usb/smsc75xx.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/usb/smsc75xx.c b/drivers/net/usb/smsc75xx.c
index 6f72a3f15907..d1eca6bf7770 100644
--- a/drivers/net/usb/smsc75xx.c
+++ b/drivers/net/usb/smsc75xx.c
@@ -2217,6 +2217,14 @@ static int smsc75xx_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 				return 0;
 			}
 
+			if (unlikely(size < ETH_HLEN + ETH_FCS_LEN)) {
+				netif_dbg(dev, rx_err, dev->net,
+					  "size err rx_cmd_a=0x%08x\n",
+					  rx_cmd_a);
+				dev->net->stats.rx_length_errors++;
+				return 0;
+			}
+
 			/* last frame in this batch */
 			if (skb->len == size) {
 				smsc75xx_rx_csum_offload(dev, skb, rx_cmd_a,

---
base-commit: b3dfbde62cf1981c4638939c159dfd087b7a72e9
change-id: 20261110-smsc75xx-rx-fcs-fca968df1dce

Best regards,
-- 
Joas Antonio dos Santos <joasantonio108@gmail.com>


