Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794503141;
	b=jAm+bv0/y6ia2ivY0PqDRReofLHFuCA5jMeDmHUXYiizeVjR/FgP5bMNK/A6qq9V8vJd
	 awcZzL+lEXlS8c6k1Yi85XN8D7n3WfRAoqvb6+RdF8L0I/BbQeBX+n8J9aS7+W3fX9c+B
	 shlH9T2JJc3l8iFWhQnmxHBkHkEbK6l+YE0VaYU74zikiJBthO0vEp18gep8Fy66pvInQ
	 xzileWO4H63qXB0bifvdUQpP1IzRNSzNK9PrUoDzLWftDVdjWmly8fFyly/mtPZCRCgui
	 biTk+zdzqG3HYGOzsgBrSu/Gf0uVhMz5qQGrjfnJ46koNTlQ/lADVB3jG5My4BlLeZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794503141;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=BvPcq56D9sUsV+B7BHS70r3XcMZWWt5y6vvyIztgn8I=;
	b=APpoe4E9xlwE0V1U80z7n32Dz9O+mw6tPkpHA2TyUc8ieiPS+oAvJmInl3ttVTxOQ5YI
	 fpnloOjnK8j4t6f96V4/5+Abrs387oNJuLUNRbHRve8taBZzsnDX1vccFrvias2ztczgr
	 guRzM98v6IO9RW2k0O14881oPwPrqVd3BYuUAlSi7yjG6hC/GPztXp/bmuf/q9krb1pkU
	 JBMyHPT2pQYFb+gfo4UR4hxkY6bnjnvhLXBJgRINzScjCEHl6iy8uYUDFhUGAFRdNDs1u
	 /u3WJA9nPmjcsaenDlY+Xo9ewd7tQVHmOd0nakjLDKLyTr48BMxMsPpMruzBIm7eUNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SuBCgUgf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66917606A321
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 17:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SuBCgUgf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D0E91F000C4;
	Thu, 12 Nov 2026 17:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794503141;
	bh=BvPcq56D9sUsV+B7BHS70r3XcMZWWt5y6vvyIztgn8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SuBCgUgfCfzx1NEw50jb7dufyHTzuOE0jIqdHKZdorlDjo8uRydkR4/EWpCunviWJ
	 mdLM/5LfCoJTXHQ/g1Phxag+XLIPgrIDa1kto0O4xZzdDyLPsC23fvwGJ9Uhoys5x3
	 IOPXq/YfKzGZSM4ef8xl2ZTk9bfYsiSiofjD127NK/ZHABUNe/KRfhTs7T6NaCz031
	 wyJHLjUBqYnwq2SEQPe6RSWbknxsqy4NeqkmfZbDfL69WN3RuEmnahonGyhpCiP02m
	 F36jRhMEFoKwevl1WxSz4BbJDGjUsZv9vt6QU2xjzf5QCFkUQpDQmDFWLTeO7RtbwM
	 VeCgdE2fZNXiQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vincent Mailhol <mailhol@kernel.org>,
	stable@kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] can: dev: can_dropped_invalid_skb: drop CAN XL frames on non-CAN XL devices
Date: Thu, 12 Nov 2026 12:05:39 -0500
Message-ID: <20261112170527.3085868-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200446-failed-6.18-0fce44e29fce@kernel.org>
References: <20261109200446-failed-6.18-0fce44e29fce@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vincent Mailhol <mailhol@kernel.org>

[ Upstream commit 0fce44e29fce4b07642491b098afb41bd571e4f2 ]

Sending a PF_PACKET bypasses the CAN framework logic and can directly
reach a CAN driver's xmit() function. The PF_PACKET framework only
checks that skb->len does not exceed the net_device MTU.

For a CAN device that is not CAN XL capable, anything above CANFD_MTU
(72 bytes) is therefore dropped before it reaches the driver. However,
CAN XL frames are variable length. can_is_canxl_skb() accepts lengths in
the range CANXL_HDR_SIZE + CANXL_MIN_DLEN up to CANXL_MTU, i.e. 13 to
2060 bytes.

As a result, an ETH_P_CANXL skb with a length between 13 and 72 bytes
can pass both the MTU and the can_dropped_invalid_skb() checks.

A driver that does not support CAN XL will interpret canxl_frame->flags
as a length because of the overlap with can_frame->len. And because
CANXL_XLF is set, the resulting length is between 128 and 255. For
drivers that do not check can_frame->len before copying can_frame->data,
as most drivers do, this results in a buffer overflow of up to 247
bytes.

Drop ETH_P_CANXL skbs if the device does not have the CAN_CAP_XL
capability. Keep can_is_canxl_skb() for the validation of CAN XL skbs.

Closes: https://sashiko.dev/#/patchset/20260731-master-v5-0-5b27029dee20@qq.com?part=1
Fixes: fb08cba12b52 ("can: canxl: update CAN infrastructure for CAN XL frames")
Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
Link: https://patch.msgid.link/20260731-drop_canxl_frames-v1-1-7387b70353b3@kernel.org
Cc: stable@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/dev/skb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
index 6fb1f9b2a9e20..6f609d6a21288 100644
--- a/drivers/net/can/dev/skb.c
+++ b/drivers/net/can/dev/skb.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2008-2009 Wolfgang Grandegger <wg@grandegger.com>
  */
 
+#include <linux/can/can-ml.h>
 #include <linux/can/dev.h>
 #include <linux/module.h>
 
@@ -354,7 +355,7 @@ bool can_dropped_invalid_skb(struct net_device *dev, struct sk_buff *skb)
 		break;
 
 	case ETH_P_CANXL:
-		if (!can_is_canxl_skb(skb))
+		if (!can_cap_enabled(dev, CAN_CAP_XL) || !can_is_canxl_skb(skb))
 			goto inval_skb;
 		break;
 
-- 
2.53.0

