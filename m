Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273193;
	b=ZMNd5eOCOieJSxXojc9QKvdlpyQnMwfcUobumryLgIMvAcLSS5zNFR1ri9C7i6Q9MRVx
	 tVfg1NGftO3yCw+cVaEnnj0G8HvmiGT9wroJxH00WOWDuEUXssDxrH/1pDU2aF8uofYdj
	 5D1F3iGzdnANtmPWM5KRGyuFTn4sxv2KxMWF7mf1Hm2O0DB1KIvjTfpWzb9WaCUUeYluh
	 5ew6FPxnxkU3jOcZNUutAiUOsEM78PYFYgpUTwV2sW6K18FHoPqADztUtPXSYyvEgEV7i
	 gN34bbrYcwpkUkDoSk2xIzBDj3Pb0Az+SsLn/E8SmWw3B5LZnkr4YOLbQhnyMnbNLiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273193;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=AQZjDUH4yFJYeWgMtCMgsvamkEsgFY3RUumdHg7BNOA=;
	b=lPi+uDDs+mB8kqajzUpco3nRC7dGuXtDfYdxPPTAc+lMOKc1CnAjnMY+h7dG0ejgVacu
	 bKGeQC+TcGTZkhYnrmu/eOg/rnfezf7/uxfrYgpg2znpPf+aAyQaCFWqaRm/V+kcPErAt
	 yXo0tGqtsKxzBrfIRZH6HlqOaB2t6t/IQEDJ+E1vUYaPuJlLsDqkaBcf75MEo7wmxY02/
	 rPozBNbZKtFxix8PRwmg0ZNiMGnxBf5sTicERyOuXcTviMBomM0IjZpUlYexvAHTFpP3l
	 fWrv96QQdZm9IAp8WSUIdntt50uH1tFug6nTzzpl3VUJKycLp3pQZGGuvqS7VYU14sA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KzdfQ9b4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5A5606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KzdfQ9b4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2B621F0089F;
	Tue, 10 Nov 2026 01:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273193;
	bh=AQZjDUH4yFJYeWgMtCMgsvamkEsgFY3RUumdHg7BNOA=;
	h=From:To:Cc:Subject:Date;
	b=KzdfQ9b4wjJICnUJ9os1eK2d/H5dfOrBBtgysBRdccAWGabbOQYDqQ1mHDWTdiqDk
	 x9lauzpbxPN1/IYiyXOoTfqg0vOL7JHr5HeoWJ9d57K428Cu5RK8V4epJXKlYAinbE
	 mCqc+sZ5VctxjuOVS0MHD//iv706lpx96+IBprp7OnRo/2iHsZIDtnpDM1o8zSnZOg
	 FHGXLne2biAlxvA6AZMcLQDiR1HmaBlFdchDmzAgSE6CsPefluxL9ZJ101w6BhCV1l
	 NadXgRouD8Qa1RCEhI09BF0JyCiOCp0nNaYVDXKUMpBo5mj/KYuCuHTAvrkcY3kv5M
	 74Gf3hdnQKlWA==
From: Sasha Levin <sashal@kernel.org>
To: mailhol@kernel.org,
	mkl@pengutronix.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] can: dev: can_dropped_invalid_skb: drop CAN XL frames on non-CAN XL devices" failed to apply to 6.6-stable tree
Date: Mon,  9 Nov 2026 20:13:11 -0500
Message-ID: <20261109201311-failed-6.6-0fce44e29fce@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 0fce44e29fce4b07642491b098afb41bd571e4f2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201311-failed-6.6-0fce44e29fce@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 0fce44e29fce4b07642491b098afb41bd571e4f2 Mon Sep 17 00:00:00 2001
From: Vincent Mailhol <mailhol@kernel.org>
Date: Fri, 31 Jul 2026 18:29:44 +0200
Subject: [PATCH] can: dev: can_dropped_invalid_skb: drop CAN XL frames on
 non-CAN XL devices

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
---
 drivers/net/can/dev/skb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
index 14edec5afb57e..bc0787535b524 100644
--- a/drivers/net/can/dev/skb.c
+++ b/drivers/net/can/dev/skb.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2008-2009 Wolfgang Grandegger <wg@grandegger.com>
  */
 
+#include <linux/can/can-ml.h>
 #include <linux/can/dev.h>
 #include <linux/module.h>
 #include <net/can.h>
@@ -388,7 +389,7 @@ bool can_dropped_invalid_skb(struct net_device *dev, struct sk_buff *skb)
 		break;
 
 	case ETH_P_CANXL:
-		if (!can_is_canxl_skb(skb))
+		if (!can_cap_enabled(dev, CAN_CAP_XL) || !can_is_canxl_skb(skb))
 			goto inval_skb;
 		break;
 
-- 
2.53.0




