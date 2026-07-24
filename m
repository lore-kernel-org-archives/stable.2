Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC40279DAF
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 08:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784882298; cv=pass; b=jqtprfEJ3beiWV437PiHgEY6ec4bYOR+so2+jnnP0aDBgm9itWWZXT/qxGT+aZZz2gewrWyqvwlDSKdZxVuuVQttprNfVECtpwrvpKXx6anpnSjxZXSh/iuuCB0eJf/Ud8ZgWM+OmC0ysS3VoWSEiEOIz2kSx1G7tSK4xvU8hHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784882298; c=relaxed/simple;
	bh=6zPjHnU1UUq0JI4Y13E3M7wR+dvHB/hQ828pHiTCu5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZeEtf4g+FBBfE3WaDMq2pq2lSUOn8EpLeqvuKYUTEqcXn7Bp7A9ANPtCScCOeaBF/Dtlt03qozgOzlNQDKog7FxlNpqq1Gv9fQbwcseCfMSWCHWEy3Kjf2YYqPKnbdZNCZqClvMgc1FaG+Z3vaLdM4DBoZdiHgJUhqF50Dv5lEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=fDhIXWOu; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=58Tr3Bf0; arc=pass smtp.client-ip=81.169.146.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="fDhIXWOu";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="58Tr3Bf0"
ARC-Seal: i=1; a=rsa-sha256; t=1784882288; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ng9b2c9+RBov+5UtKa9dh5fCF7MSw0vJCxhqkB5DPndGJhGpLE63aSl04QJM9WbcQa
    j13ah5hKywWPKQSBp/rkZTVWznWeqsVCkPfyksvA3u1j4p7XD05Veim9s4NY1QtQvUee
    vBLF9O7nO7vgn0dfs2E3F4J6cy8BC7OISbIEBiz2qUTxgLt2phVRfrWvbFLw4WVzLcpi
    Uk75nuni+bfECp7v7qW3HL7e2K2epP1YmvmpZ7LM9oyY3l7r1ybcLDJc9WH09U1PIk/S
    /ltzmErBFaMzeWxNCnE2xZMDTXcUCj+DI7y0LfHZ6I3tg0JMVhJjjEK+9/O7HpPFS7Vt
    Czrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784882288;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=dR8Xy6bbu19HXLHVOsSaC8p+SD/nMuwPiuRMGCN9AFo=;
    b=Re2imWMn87N5rpPL+gSCJ22P6eZp9vs69oBXTNG6QXkwtoB76WcXQbpQBgB8cXLRtF
    3XmZWinK9vsE3NxKltKZn62c/SAhgEVxLmuvDTctuSojOmWcuIUmShyRTnV0c0leC7Va
    EwDGEwxt1RhHfQzGJ15k5CevHBHNzeEq+hkRcqzda10eewhd69ljPzy1DX8IvTz1tqyc
    BzboOncVMVk3B5a/fVwnqk4SSuL82g2sp1XALyVIHOaoAaNjK2aulw+bIAzana1vwu4y
    e45F28RIcl6YtX3fC/xsthFF4t1vXaemjLNNFPYMLJbbkdsu5MJ86Jmd/X34iISD2X0/
    5YRA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784882288;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=dR8Xy6bbu19HXLHVOsSaC8p+SD/nMuwPiuRMGCN9AFo=;
    b=fDhIXWOuiiqs7J8A1YVnCKHuQG52M7V2NCIB9cE/Uch6i4Hf8D8T5HvnvB0DePl3+t
    8RnCegMXoidFNVeeh+oeEHobnnLpSTzSkqdjHPowU0EYuMsKoniVgMHCl17m/bEghYdc
    DQjhM5NvzRPrhodKsyfr0YlIWVjpTW8ErlLvHQT76MrnGjzr/A6bBcJDVHHu0p+D4BZs
    tHySdY49Sea0HRrHqgdHOgEKmKGpSxWER0nrsGtp3ycgR6JTsswrAO2tXqFbNdg/CdOQ
    treTyZtUJb9zxb0BZJ27mCS807foW6TJOOm7l3Uhfo0a+dTYGeaD5qPIFINCW1ZXmGZX
    +5oA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784882288;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=dR8Xy6bbu19HXLHVOsSaC8p+SD/nMuwPiuRMGCN9AFo=;
    b=58Tr3Bf0W78vfpJMnWip3WdTKizQTEMUiT+YihoFhMep9LmbueJbQaZfxTI/vrgwsZ
    0/6yenh1+db+7Zn65BBw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926O8c8rQ8
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Jul 2026 10:38:08 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 8/9] can: bcm: fix data race on rx_stamp/rx_ifindex in bcm_rx_handler()
Date: Fri, 24 Jul 2026 10:37:55 +0200
Message-ID: <20260724083756.12430-9-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072058-tableful-statute-00d2@gregkh>
References: <2026072058-tableful-statute-00d2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

commit 58fd6cbc8541216af1d7ed272ea7ac2b66d50fd8 upstream.

For an rx op subscribed on all interfaces (ifindex == 0), the same op
is registered once in the shared per-netns wildcard filter list, so
bcm_rx_handler() can run concurrently on different CPUs for frames
arriving on different net devices.

op->rx_stamp and op->rx_ifindex were written before bcm_rx_update_lock was
taken, allowing concurrent writers to race each other - including a torn
store of the 64-bit rx_stamp on 32-bit platforms.

Beyond a torn store bcm_send_to_user() must report the timestamp/ifindex
of the very same frame whose content it is delivering. So the assignment
is placed in the same unbroken bcm_rx_update_lock section as the content
comparison.

As a side effect, the RTR-request frame feature (which never reach
bcm_send_to_user()) no longer updates rx_stamp/rx_ifindex, since only
the notification path needs them.

Fixes: ffd980f976e7 ("[CAN]: Add broadcast manager (bcm) protocol")
Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/linux-can/20260707145135.5BC831F00A3A@smtp.kernel.org/
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://patch.msgid.link/20260714-bcm_fixes-v15-10-562f7e3e42da@hartkopp.net
Cc: stable@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/bcm.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index 4afc2ed..0db9c48 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -756,11 +756,6 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
 	/* disable timeout */
 	hrtimer_cancel(&op->timer);
 
-	/* save rx timestamp */
-	op->rx_stamp = skb->tstamp;
-	/* save originator for recvfrom() */
-	op->rx_ifindex = skb->dev->ifindex;
-
 	/* op->flags/op->frames may be updated concurrently by bcm_rx_setup() */
 	spin_lock_bh(&op->bcm_rx_update_lock);
 
@@ -784,6 +779,14 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
 	 */
 	bcm_update_rx_stats(op);
 
+	/* save rx timestamp and originator for recvfrom() under lock.
+	 * For an op subscribed on all interfaces (ifindex == 0)
+	 * bcm_rx_handler() can run concurrently on different CPUs so
+	 * the CAN content and the meta data must be bundled correctly.
+	 */
+	op->rx_stamp = skb->tstamp;
+	op->rx_ifindex = skb->dev->ifindex;
+
 	if (op->flags & RX_FILTER_ID) {
 		/* the easiest case */
 		bcm_rx_update_and_send(op, op->last_frames, rxframe);
-- 
2.43.0

