Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794531941;
	b=BrCCq5q2UoyKBt666xTs6YHaUogqHds+gSc6ibAueJBMbrrVOd+LhzR2TyZIX7iw/7/Z
	 3oTV7f/BMU752+OJy2Nxv0cBmkCrvWHwUOenw3g84p0HEPzMGdLlPrkpPRhUEpZDpj36Y
	 TWx5L0E+0pn4lx3+RVglZuxvTYsnXlWrHh0Kn064Rmzsea4hMScMmm/O1kbbhsDhrO/KF
	 Og/5zltYBeYyjDmXIipSSGjAtp3y00IJm6aX0e3R+lX/rPDA4Hl99it7XYTJgiFMYMoIl
	 IYuasKNH0dF+cujyOOM9vdX3GDBEarRT9djLn6goq//gEDxosaXz/GWfuLuLozSNepg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794531941;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=3onjlPE0aNtWXkAETxOWtjeOcUxVDxYLzutBFrCt8ow=;
	b=RhZsX2UNlREQf7BW7JcKDr8NBveZXAVQOrb6HfgPBsQD5BR4Nnp8BikfFdiirQ7OEQCa
	 Gy5ok8VvsBPurIiKktAVURtVYcUf0IXE5PjqdKAeRQz+1GvRWYbqrWj5KttRAuIGUKBSy
	 WA7IoQZfBgMyngFNZASaB2kprfZAVzR8VKe8FVtgTDqg2aJYqegx6JxaDs/QFpmielqob
	 ji3iDY2BaRH1y8d2xlFF5JHb+7VQg+7siP+ZhP7fWK5hivstuCjpk8TbxZd33UHNHPbJ0
	 hqsoEzvgldFO+cCjRxpcF1y2cwe1SjTzw1+VTj+0CJCucJCp86OuRiO05xdBUg3JcTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ml9t7XeJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2EE606A323
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 01:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ml9t7XeJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCEBD1F000C6;
	Fri, 13 Nov 2026 01:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794531941;
	bh=3onjlPE0aNtWXkAETxOWtjeOcUxVDxYLzutBFrCt8ow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ml9t7XeJHWo2fQwJM9b+jiOkb9R2oVijhEmUAxmzEYsYUrGuGTevUgyOB/ii1OMkR
	 6Ho3Q4jgvK7ouUHd+XKluLin6ItmPLJHLbhQ2UogdFI34T9R5S+ay/Ku2Uo7ypqi0H
	 oWTTGw7ytYbd+11ib6kEqN26x3QB/EpjhcHqd0lU4Ga+t0CF6Qf+vA6LLqTkchxLf8
	 8Np7Zmk1RUgUGMtlCYztUukWb37whxtkNwMgrOvLQEZKulN6prNDLKoIjGZ3Pr2O3/
	 GvPQlaUA0jbihAzO5+GHOw7Jbsnq9aSfSom8to/60j2JCBiqd04QcxgCorUpzoaXIs
	 DaVq9gPxdRySQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vincent Mailhol <mailhol@kernel.org>,
	stable@kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] can: dev: can_dropped_invalid_skb: drop CAN XL frames on non-CAN XL devices
Date: Thu, 12 Nov 2026 20:05:39 -0500
Message-ID: <20261113010504.443628-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201311-failed-6.6-0fce44e29fce@kernel.org>
References: <20261109201311-failed-6.6-0fce44e29fce@kernel.org>
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
[ sashal: Replaced unavailable can_cap_enabled(dev, CAN_CAP_XL) with can_is_canxl_dev_mtu(dev->mtu). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/dev/skb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
index 6fb1f9b2a9e20..4f5eec05db220 100644
--- a/drivers/net/can/dev/skb.c
+++ b/drivers/net/can/dev/skb.c
@@ -354,7 +354,8 @@ bool can_dropped_invalid_skb(struct net_device *dev, struct sk_buff *skb)
 		break;
 
 	case ETH_P_CANXL:
-		if (!can_is_canxl_skb(skb))
+		if (!can_is_canxl_dev_mtu(dev->mtu) ||
+		    !can_is_canxl_skb(skb))
 			goto inval_skb;
 		break;
 
-- 
2.53.0

