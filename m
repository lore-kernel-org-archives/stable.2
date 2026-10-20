Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792503053;
	b=xxLuBY3WqHBujlMXbA7sf78CVka/lniGjlirUlMbkkAU/jIgu2pZYTb/yMdoBYmaddF7
	 4P/UomhYxrwrIF1Q/mdnP8W9mCEJiaBYi06UGs3fjwJWHKzdHOQSlUA8ZRUwPqr90OsUT
	 FgO35J8a6O54pyK/gAiRE0DAg13BWHyPN5GR6pXZIkhxVAMhtLA27FeCZqP4m/T8zhYtP
	 3645W3tSobrdHsrafkY05+BKHl9bFTXAAIRFNl/IwsKKMKg1ELTJDliEpsFqTpCHsar4C
	 JNe8jle1z4HBVoln6QUXVOB0ge6BoT7OJwqRO7GQv1t4404Tmv6nNDCq4oUOj7/A5CQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792503053;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=PchrU+Va3DZaNKNckQ858GV5JoQCVK375UKKXHl3JXA=;
	b=1paCtshKDemlfPY3bCLyl1rglqp6uVQOHgmlHrtTZyluAcko1iXDZ3/qHJ5ARUSG5dBp
	 ROnG5d7Q7I1oztGwQVgy7ZjnkLNEYuodO2HWnaGFGLrVnXOnPcT1Cf9H/liV2g4YebcQe
	 BJDomd+ZmLtcwQYMTSVkV2yWqwPOkN2WJUINA51ICHlWS20GfwFHNZowYhoIlVrpSUCpR
	 dyY+up3FgaZRi+knyOhCe1YEEaR+lAYEULymwZf66noc+3xIfzJSkakEaHuq4fgW16ccI
	 ab//furJ6DAnrJFupvvR9BfySGUlw0N1mZviSltlbFnq6GMy3u4qA9uSDU3ViUGv/zA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eIQUdMnN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BAF606A31C;
	Tue, 20 Oct 2026 13:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eIQUdMnN
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792503052;
	b=Eglw654LrGDyK10fg/gCKhJx0zHYkM/iaZUewDqPExBGH9vtMiXnjqYjRR/vUPEh6zfA
	 W8XKF2/f/QcrFZaJqLOYS1i2CekrCAWJCJaVFDEtA/yDHfiKtv5zWO60jDr6dazTyQN0r
	 DKAnJxlMZK4+YDpXpgjqUI6fbkSV8s1nhIsbSifyD9vMZYUKLO3Ui84HSJEEchsoP6rlw
	 uZ8Sw2f6sbQRSm0SEQ4mFqlhvttyVMdiTlOQhqguZloBw+ioipUioSgU9AtiOoAlaZnuB
	 LDMpSzTIu/0Cy5FEmpF58/hl6OgbpG9v1Hq00jc01MexN0s0QBvGDidVnltWxNquSyQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792503052;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=PchrU+Va3DZaNKNckQ858GV5JoQCVK375UKKXHl3JXA=;
	b=N/2N+Ey8+Vgc0VntEginbqF6frzQxyxwAm8tjdfBNVvQz9xK4Avlo69+rLtYpuD5SPOv
	 SETrCBKwNkzYKmZxpE6h7xjGFJLqL+pzolhPKcYzdDGAKB1u0ZEy7HHfQK8ycjcgSPdFY
	 T7peVQI2oI6F/vBnhZvF8FlwHIVAgu5s6oVCIWz7vME0d0isXmdNfdrFS1+Ui3elXdrya
	 ZWxNPVSSHvpVCpG1PrqYPfVSGhCjOqv8H75PSBNxU20DzSNrUINFbI4dSnF7IQxqhtJ9P
	 IZCkRpcy3BH0dPvTlPPoTrj39n5lBtlku4wmROyGosyDeAusoAe93PolXXMTuQXkbzQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 2EABF1F000C4;
	Tue, 20 Oct 2026 13:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792503052;
	bh=PchrU+Va3DZaNKNckQ858GV5JoQCVK375UKKXHl3JXA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=eIQUdMnNbA3zWNMqbwaZhQfWa3i8Ed3XlgdfAqmXXmyDO1Cc3tascoQFHTe5epHb0
	 xXtQ5GXRqAq5g+8l2Tl85QfOkbActCUo7DlOz/ca0SqLYJfDFbr6nlT01h33FzmxJb
	 redqq46vILUbPtXGlp6kXd+gm2nzw4n+1PjtAaDHCJ1RcnitcfvIVanFJhMaI06NnX
	 oUEg7FZmENC1ryfu2zRzXEcYSvPwqmsWEjjeXT/pssBFb74OaLatXcNRStgVo+IqOk
	 2RhKQqm/Xu1LxNIxLirvX+ozZgX5dCiuWJ344t/2Oyp9QtPXxr86SlZmM1bWGxi/GC
	 hJ8g/7IsRDtFA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 887E443142;
	Tue, 20 Oct 2026 13:30:51 +0000 (UTC)
From: =?utf-8?q?St=C3=A9phane_Grosjean_via_B4_Relay?= <devnull+s.grosjean.peak-system.fr@kernel.org>
Date: Tue, 20 Oct 2026 15:30:40 +0200
Subject: [PATCH v5 01/10] can: peak_usb: fix missing CAN_ERR_FLAG when
 reporting error counters
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261020-canfd_check_channel_idx-v5-1-a62b35b867f0@peak-system.fr>
References: <20261020-canfd_check_channel_idx-v5-0-a62b35b867f0@peak-system.fr>
In-Reply-To: <20261020-canfd_check_channel_idx-v5-0-a62b35b867f0@peak-system.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Dan Carpenter <error27@gmail.com>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>, 
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Stefan_G=C3=BCnther?= <stefangun@pm.me>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792503050; l=1235;
 i=s.grosjean@peak-system.fr; s=20261020; h=from:subject:message-id;
 bh=yJYGMmDCA5H1YtV9p82vQMvFYiAXoP2GMFxyPs3vVf0=;
 b=UQEbTICR8yutxRyifR6BbbSdE3EJ56nU2iRsETEUyHUoeUm8gNbokoIJi9VgRVI5sNjYMekmG
 UDQ9cV1srDlBAcl90Qq1od48Oxq0e7gQ1QWpzdvRr/CvsoDEQdwAzr7
X-Developer-Key: i=s.grosjean@peak-system.fr; a=ed25519;
 pk=bP7QV2zvvAKAfConZlUOGKGEcXL64SNUpVUm++Ai+/c=
X-Endpoint-Received: by B4 Relay for s.grosjean@peak-system.fr/20261020
 with auth_id=1250
X-Original-From: =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>
Reply-To: s.grosjean@peak-system.fr

From: Stefan Günther <stefangun@pm.me>

When the device reports error counters, the driver incorrectly uses an
assignment (=) instead of a bitwise OR (|=) for CAN_ERR_CNT. This wipes
out the CAN_ERR_FLAG and CAN_ERR_CRTL flags, causing the error frame to
be sent to userspace as a regular CAN frame with ID 0x200.

Fix this by using a bitwise OR to preserve the flags.

Signed-off-by: Stefan Günther <stefangun@pm.me>
Cc: stable@vger.kernel.org
Fixes: 3e5c291c7942 ("can: add CAN_ERR_CNT flag to notify availability of error counter")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 8fd058c32856..785224e00c4e 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -526,7 +526,7 @@ static int pcan_usb_decode_error(struct pcan_usb_msg_context *mc, u8 n,
 			/* Supply TX/RX error counters in case of
 			 * controller error.
 			 */
-			cf->can_id = CAN_ERR_CNT;
+			cf->can_id |= CAN_ERR_CNT;
 			cf->data[6] = mc->pdev->bec.txerr;
 			cf->data[7] = mc->pdev->bec.rxerr;
 		}

-- 
2.53.0


