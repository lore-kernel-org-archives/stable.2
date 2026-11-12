Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504858;
	b=jxPjUEYh8JZA/akWQzLuySVTa+OCVN+s76ctlenp5P+0BIwSS/1GaQDs+/5Tc0W+rm1P
	 /r5ZeVn1GPDQQqpHj+0Xact7OAuRe0Ehu41ftx41lco6vAjtrrwwj9WY/xbfX8HJ0pqqT
	 JspDAdxCJbIvbCicBvdj6EO6IjM9FlEDzBx5jwKAWjEaGrUKJE80bbDK/vRWbaYKsrjPE
	 wd21Yjn+Jn2AlC3/mr1boIQezvvnvIrYUaB0EKFf4Ny6yHuc61cuy+ReN8njDH3OwCqD8
	 Tn1RRcutqZbjcb8Pb208unYBDiU1qJPLzgyMycaQ7f5vETaAakS79ZigVtQgTaF6iUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504858;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=t4psMFQvNuaL6UOww/WoISGQPKa9j6zquQntY+j9i3Q=;
	b=16sdBGYGfFMmhvG3X3Z8n1Qw7sj1BTgWHmWA2V6YkiE1X5CgoxVjaRsL4Dkn4SakFD/a
	 Os9kTtrjj6OcjwJnWeJNczG3UbcrDNWTL2sYVU9fyp66lY0zqdJAnqSK3VfRDS7UfVJP5
	 SIygL7Yr+dCIj85QIUgD8/st7TAOncgtvMH/cf/R1b8oT9JEko6zPdumxCK4vUGorJJYj
	 jwKqFrlrmLjTOhJmflcPsfHpmHN4K/DdI9+D++2wAGtVu862Tdz/wrOWi6SSynrW9wecT
	 c9IY3bH7W6zK3HT7bXbjfWjSdJiN45FOEQgmNujQ+iC+wRiwfcZXpWYkQ7o4X9Fc3Hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NDncarZT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E6660A6F76
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 17:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NDncarZT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24EDA1F000C4;
	Thu, 12 Nov 2026 17:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794504857;
	bh=t4psMFQvNuaL6UOww/WoISGQPKa9j6zquQntY+j9i3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NDncarZTk9peIpHUtJxD6E1DdQNWesRMHU0xUUvSMClH1N1IriYBcRwyKj7m67Es5
	 pD2HcY/ToVdkAwOMWUlcoOs2R3vpze2bNYPO49168eaIXmJk+WJ3BHFIJUsOOon790
	 gR5APmTwfGmMq8e+bnIbH5kDt0rXe/MCoN09h9b5BvcGJuIKtnFskL/OLDqrvPCoAh
	 xuKpjSnwwj/yo6WLavC6U8Gr4jlP2vDtym1DKbu7hCPiBnZNUgM0nTpOE+VOgAYJ77
	 zqNCV4cxDuKEug9sGGemqIxlkKhufPYaseWE/AbB5R9lHzT/bizC1EeaKMmDJXdM9W
	 Ex+qSC3y6iHVQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vincent Mailhol <mailhol@kernel.org>,
	stable@kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] can: dev: can_dropped_invalid_skb: drop CAN XL frames on non-CAN XL devices
Date: Thu, 12 Nov 2026 12:34:16 -0500
Message-ID: <20261112173353.3206543-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200840-failed-6.12-0fce44e29fce@kernel.org>
References: <20261109200840-failed-6.12-0fce44e29fce@kernel.org>
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
[ sashal: Replaced can_cap_enabled(dev, CAN_CAP_XL) with can_is_canxl_dev_mtu(dev->mtu) because the capability API is unavailable. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/dev/skb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
index 6fb1f9b2a9e20..b643995fc5369 100644
--- a/drivers/net/can/dev/skb.c
+++ b/drivers/net/can/dev/skb.c
@@ -354,7 +354,7 @@ bool can_dropped_invalid_skb(struct net_device *dev, struct sk_buff *skb)
 		break;
 
 	case ETH_P_CANXL:
-		if (!can_is_canxl_skb(skb))
+		if (!can_is_canxl_dev_mtu(dev->mtu) || !can_is_canxl_skb(skb))
 			goto inval_skb;
 		break;
 
-- 
2.53.0

