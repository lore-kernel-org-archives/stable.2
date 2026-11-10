Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794301402;
	b=EVSymZDtsGHDH7ac6M5Ml4WBrw/mFwhuAbw4NIiD6CiwLvpPDnea81gIbgrFItDpcTlM
	 Ac2z4JRytrGW+2zRdHj8GbnVmx+TxSqB7f7BqntsPXnQL5acVIG2XKlQFPr3dQKhghA2h
	 P3DrcK0mps2R7z4glR/9mH30UqRkFBy1FKMUOKXfeT70HLaa7Yb9n0mhugIQL+l8F5Vam
	 c2fYJbGxvtk1VG0bHhdhpnm+CfM5l3+5bU/YXBUGoH6aCsBQ//N/nG8fxcMwY9dSpukNZ
	 /1m+oz6LvMK2AG2d642pSzHCWupO+nMZ0FS3eYej6ZWpc5GOPr89rADcKFLtrIyDxsA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794301402;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=cBdLGql5qq7PJAdgce+bLZBSDKa16JrnsVeVNrIquuM=;
	b=ZEWLPQBdXlcx8BRT385b/mNI4E3bB6EdYpR5sfbe2YdSqhs25Aqsxo7oXuxfPAfmwDCl
	 HFId5H7rmIAS4Gnj39PyJ1vyvOZRd30lDzeelc3zIORNdEPQHLUizBYKGUtS5uFz8XytT
	 rxndetm9V7dwho9unnO4AOePa98u5irZsN69BzxK0FipTnscc+EOJOm4DleKlXD58a4Kt
	 mtbP9XYIsur21HRMCSxRUI3sFOZjcRp9hrAwaYc9+Gr/0k+lfL+5l7Ua1FKW4mv7dhiol
	 XxnJzbApLqeYUNs2liZ6CikqWE6O2Mn7LqcWORC1OP6VrLIAsubICTyiOpUrcMHBVBQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PaZc33gW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7091C60A260D;
	Tue, 10 Nov 2026 09:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PaZc33gW
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794301402;
	b=uv+xUwLbFqd5NbNB/qeLBKWueU5s/9+B37zcr+z9eCne4k8NBu2qWVRIflQsHDHp0mUS
	 na0FmYGZTsflnjbfoMIzUM8rzARU+9mnM7ksUdeOw/pOeE7xyWc1XfdgLuTvFYIntORXU
	 sAS7+Emav4LTHGd+kEdKCSl//a1R3EiGWDPAGEXJmNIWflYbBR4BddNWdr8/1ULIwNzou
	 ixucQ/EToV2uZy3hjX7gr4OyRtNuZNVtJ3gg4NuDLLYxc1fkBAltqnMN6WhaudV+Ug95/
	 KHyK9bDoeC+N3bOYf1CyoeW6qUoROXirh+62XYQ/dG63ll7Se4v8PM76ZaY7RL3chlw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794301402;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To:
	 Content-Transfer-Encoding;
	bh=cBdLGql5qq7PJAdgce+bLZBSDKa16JrnsVeVNrIquuM=;
	b=sCqLMuDa0snlcSMHYkJJNojGMTbPKYXrU1u6zepvHaZpjxRz6jJQg+U/7VbYbA3Ysbrv
	 zVrKwegwAAodts3+LOeGXWrENeKZGrA4J8LKdsZ/5/a4BnGoU5/qOygnRErnVLevvv8bT
	 6P7i0hvqGsrfKTaPOvFUMf8AHjSbsReucKBAT2aIOk2wMcky+HccN0tkx8jHNSnGp/RDm
	 cedSa2cVGp14JtL/Yncg0PP8dQmrs9y8eXPNOd0EFwpAQNgkUZaTT7ONJXV6E43eeKB9p
	 cXzmABQ+oKybSr68fmvIJ68hWpg3gqsu0w2tDmR9gdMEc9KAKhrW6cQPq3F3ATzBv9Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 8DF671F008A4;
	Tue, 10 Nov 2026 09:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794301402;
	bh=cBdLGql5qq7PJAdgce+bLZBSDKa16JrnsVeVNrIquuM=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=PaZc33gWB1OtK0/tMHG8mbymqqShas6FfY70ncQ+AHyzsSv0oGG30u2v7VecK05Ue
	 eSpAJWvlsfTivGG1uaiOgJEnNLx1QkTGZsq+WJh9qq3jGhY0OmVsCeP5hv1oro7xYK
	 I9L6YMg4XzwaKlHr8PmYEk01CnclWsTt8H9ZJen9nZctSWR0pZSqmArEoLEMGMtff2
	 0hsl5SwnXikU0rNUpghx5S3d59NC3oDDT83QPmtf4/4qD1U3IBYQKkSet22vhMX8M8
	 lhi7asrA+8zt75z3L8zrkCr0EXLmes9xNzTaC986qBUiaXAXmqfMTlDD7Io45R/sM6
	 HVDFEpVOd56Pg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E28B148A4B;
	Tue, 10 Nov 2026 09:03:20 +0000 (UTC)
From: Joas Antonio dos Santos via B4 Relay <devnull+joasantonio108.gmail.com@kernel.org>
Date: Tue, 10 Nov 2026 09:03:21 +0000
Subject: [PATCH net] net: usb: smsc75xx: reject frames shorter than the FCS
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
Message-Id: <20261110-smsc75xx-rx-fcs-v1-1-4e048bfc28f3@gmail.com>
X-B4-Tracking: v=1; b=H4sIANjd8moC/x2MuwqAMAwAf6VkNmAKPn9FHKRNNYNVGpGC+O8Wh
 xtuuHtAOQkrjOaBxLeoHLEIVQbctsSVUXxxsLVtiahG3dV1Tc6YMganhWVoex/IO4ZSnYmD5P8
 4QeQL5vf9AAyj1IhmAAAA
To: joasantonio108@gmail.com, steve.glendinning@shawell.net, 
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, 
 kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794301400; l=2363;
 i=joasantonio108@gmail.com; s=20261031; h=from:subject:message-id;
 bh=G1cAL4e/Pmr3AzCsbxnGrjhhPlyOjfRjUMp1/pULOYE=;
 b=p47NHnLvmlqjWX1hzQxuofh7VEdXnFhY3NCjZj6MpBzk3zeO8NcmasCQR8/uUCoyO2fKF92W7
 aHXxY9fV06dAOPQfEnMx8MrmlR/DWsrO407E5TgGXibSp0E65RTRccb
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

Reject frames that are too short to hold an FCS, as lan78xx_rx() does.

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
 drivers/net/usb/smsc75xx.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/usb/smsc75xx.c b/drivers/net/usb/smsc75xx.c
index 6f72a3f15907..e923fa6c1785 100644
--- a/drivers/net/usb/smsc75xx.c
+++ b/drivers/net/usb/smsc75xx.c
@@ -2217,6 +2217,13 @@ static int smsc75xx_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 				return 0;
 			}
 
+			if (unlikely(size < ETH_FCS_LEN)) {
+				netif_dbg(dev, rx_err, dev->net,
+					  "size err rx_cmd_a=0x%08x\n",
+					  rx_cmd_a);
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


