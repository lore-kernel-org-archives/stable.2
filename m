Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6FF353A90
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 08:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784882636; cv=pass; b=uXptMaDx9iJLUjdj3z5U5EKlhIH783h/eioONuhy+VDPFg7/S6uZ2WlBZLGJrduf1aMULpbXqlXrNDayYCS/v0vrgucvwcqKpPyc1l7GMg83OjH9jnxBoOTg1RGKAlrzQ5B7kc9MSmgfxEdYMHdQW6aUQPo0v7KjEH6xXlxHB4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784882636; c=relaxed/simple;
	bh=a/vBBuwJSBshhCLVVaOQUtYcLKY5wgGI5/NhrmgPGYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WAkCOMis0QpmvshEfSLzaIYS9a/YezsqKeKJ7Ju2gjNv2+ownyuh7nEbh5KB4rGzD2aRzFfluni9Gm7k5HxLtcygBFRatDh8BXtHYHjiER1flBDjIeXashkYMk8FDL3vxeFEZN2w13vEGMnoRBf/IWGYRCBilPk3k75ADB3pS4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Pg6aGRR4; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=cgLpcgXu; arc=pass smtp.client-ip=85.215.255.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Pg6aGRR4";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="cgLpcgXu"
ARC-Seal: i=1; a=rsa-sha256; t=1784882450; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=qaXUjID+4642gGacjDUNMKGM/3hnfYLIud66KgxheoXkROevQZmh2XuylTKsnpZGKR
    h1KruSYF1QFl9dECD/55nZWChj9soqCRWp45cMTO76qhT4l9H1GRwFCVxCM3fUAJ96qa
    7N+Ho3B3kzPqBDqwveNKg19B4z4G39a34o2suTD805jDH4dJ/Ze0cnW2HCG3N+oP2aKR
    xRTHJ+ePadzPdGvKbPr8I+Rx5zdC2ifUp7Ma+u47FNTEFVdDEf3htRPXZbDZslva0OWO
    //LCRY/Iy/ajRpXIZ5I0W6DggBx4PanyPORHbN0mTGdeOxHMLt5ZtpMhGl2g39fXoB2o
    f08Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784882450;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=j5IujcmNkUu+VfJwudSKwugmNcm6oCFg/6VavWcAaDQ=;
    b=GTS0SR67IE4iR1NW4MJ8IR7Goti3QPa6JBwKzOZDCt/5RD/w+HGmrMEdm7lY4W7ywL
    b+8c1kPbsYhOFRIlTgK0gygsySoTAJeRqdhLZ8BfH7lG1EYK731QireKxIUx55Pvu65o
    I0e1n9uSlVCk4Pz5ILwgPTU76OvXuLBTJ4Vi+fbx86DC1MRBN/HJlVN4ePekvPfKQg8T
    hkBW5i+3/Ug81gxi5ixQhzoL30tfsT4MrvYvmybTvkLMHNGE6NfKNv9/Yt7/uPwEjfVS
    zrj3LrkasnASMyUHCEiOc58oKVxQTvAPdtbIhdUgo93/WVAdD3iJFvgOyJV9bGako1ZV
    E77w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784882450;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=j5IujcmNkUu+VfJwudSKwugmNcm6oCFg/6VavWcAaDQ=;
    b=Pg6aGRR4Qw0x0ymJZFp3aG1ij6GLwQMraZ84unRVchjWNXFTixoMY3m4ZGic8fnkRc
    pv1gjsyG+f+UYZ0wEf8uX43OgDniPyp3KhYLf09GPaEKR780CG9CROTj4HTRUDdsg1zg
    YvsQQy5WDEaEXi5jOWCwUE23117YU4wGwDXlyo+AJwHwdeKU8qBIrgP+M3dT7bYdYIcf
    xJwar27VrO8e6z3rnPbaaAY2fwwnjpTwIWRD4fcp3Cq5CPGwfPBX2BsiwaVM3y3GPgSt
    BJOj8FCRMH8D0l9EJOhV556YaqwdbkmT1G0LAiun3/DCxbM2LgBK6zjoX4Lv4EswzK++
    xD0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784882450;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=j5IujcmNkUu+VfJwudSKwugmNcm6oCFg/6VavWcAaDQ=;
    b=cgLpcgXu0SBizxni2xmmrPw9xcxeuUcWU4O0C41qbxo6YzlB7a2VFztdlXWQkO2s/K
    /liIsCzS0wbPQpc8/SDg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926O8eorWx
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Jul 2026 10:40:50 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 7/8] can: bcm: fix data race on rx_stamp/rx_ifindex in bcm_rx_handler()
Date: Fri, 24 Jul 2026 10:40:41 +0200
Message-ID: <20260724084042.12984-8-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072057-matchless-bungee-baa6@gregkh>
References: <2026072057-matchless-bungee-baa6@gregkh>
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
index 845797b..51eade0 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -793,11 +793,6 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
 	/* disable timeout */
 	hrtimer_cancel(&op->timer);
 
-	/* save rx timestamp */
-	op->rx_stamp = skb->tstamp;
-	/* save originator for recvfrom() */
-	op->rx_ifindex = skb->dev->ifindex;
-
 	/* op->flags/op->frames may be updated concurrently by bcm_rx_setup() */
 	spin_lock_bh(&op->bcm_rx_update_lock);
 
@@ -829,6 +824,14 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
 			traffic_flags |= RX_OWN;
 	}
 
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
 		bcm_rx_update_and_send(op, op->last_frames, rxframe,
-- 
2.43.0

