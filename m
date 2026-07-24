Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD4C42F6E4
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 10:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784888725; cv=pass; b=sbnHk1FWNnkml9WbtqVt+ycl/XSO3hqmy5nuD3pvtOJGhpPJw4TTZY/msve0JFQqAUzv1B5VXNcE3UtqlrTmE1PBhGb+IpwMJXyeQkM8suJ8C6WLrtNa8k0LkyfEgrN1Qlg3pbVymxvDdG/Lw+6MBeldtJI7ECYZo05A0k+j9dA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784888725; c=relaxed/simple;
	bh=a/vBBuwJSBshhCLVVaOQUtYcLKY5wgGI5/NhrmgPGYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c7TB4uS8Jw2LZcENE6qwjWUx3bVWKUHFAaDUsu9zN3nujl43QsvjDuLZhLn+ThSfok1/ego14K/D4iCXfdnMrwBN3eLAJa3dmOQDNbm8O1qIyDmKRgOeNpNTd1/V+RYNO8yu+b3lqzj+rV/WY7U8UQyxtFelg71hMMuNRZz0VDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=SXYz6YX8; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=aYnX0bo1; arc=pass smtp.client-ip=85.215.255.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="SXYz6YX8";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="aYnX0bo1"
ARC-Seal: i=1; a=rsa-sha256; t=1784888721; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Q/GGatjFqszSAf433uJ37wjwuFP30hiSr9a2z0rxZKHzwrxv+rKOu4ij8mrBydEk+h
    /QfyAJ2ngWga3r3giucOHPQMza5YHbXYavuCo1LXx60c4qOjmFkXJ1cz2gZJ0rtsAUyq
    WPlx9L6CxQRLrYuhYL5wW7CuRUg26NpptZUCwX9CTd2twMQVJDgDFnWwOP4fUMvo1l/R
    c4TubxRQ4LNUOgYFZg279AL7Yj5cQBpOcy+0cqb+mZiA1ON8Uy1Rvfzyp59W3R8UCcli
    QMTzpabxtuSo82JQnqBSYcHGqOeHf1kQpZvX/NIwZI3GEGwM7Nnd6kpGnM8ihopJogap
    rWWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784888721;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=j5IujcmNkUu+VfJwudSKwugmNcm6oCFg/6VavWcAaDQ=;
    b=lKLW7xN9kiqfvCFDU0od/By62uDm9B2kzkjObWtTYv1Qmxm91BbnXZ5UZ5AZZhSUt+
    wJAMEBPJG1qDv149kGzXOtLZ1/FeWpYvmVPWV1ZYQoJPVWAmsE7orjfu+zEU14iCRagr
    GtrIsARghvtQDOe1XmqccBNkKPFjzoA8hvRdKmObbyqFZRWmtvUjxGmoRLELxbqgM4ej
    RJx3vMW1iFDma0f0QHr2p1gdhBt6f0oYPx1qghRqMWy+FSLkf9P28Hx0OlU6qCOGqkeD
    tzvoJ4MzJI/QeL83bm6cPIfqkFqyB4oj1ymrkn2Yhz1cZwCXrKNcExgxGtWNAJrmFiJh
    /zKA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784888721;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=j5IujcmNkUu+VfJwudSKwugmNcm6oCFg/6VavWcAaDQ=;
    b=SXYz6YX8z5bRVxoaaI6STAjASUwLsT8vk8X9yHxSvjoLlmnWKpLyRS/aWS0nuU/9Py
    RyoDNDrM6RKBH3DaXzEJ06Z2j3Or8vVbNnq73JJOiA0VeOVNnVkFyZZ2MULblP93SqZu
    r47QtRhjiF7V2JWbKhH9t347L9kKUgc5uxr662oX8bMGKmJw8IK6Q8jaAsNwwUfbCCZK
    A60vV8m+AN2dFtPcAE6TIrBDef3My0frCmS72l8A9WCC5OqWM3PTKSYD55rFyNVXrqms
    f7SQiW1689FBlsXck5HmgMCJDTa37hflCnRuqEGUu5xqlgZYDDK7gCtURBv5oYhlpvui
    V+YA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784888721;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=j5IujcmNkUu+VfJwudSKwugmNcm6oCFg/6VavWcAaDQ=;
    b=aYnX0bo1Ml8Ar/42poxS7eXH7CKuAKBJtMEIeQzJyO+H2kFV9MfnKal8NsUFKWywPy
    5G4R5CXFgT6MhirB45DQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926OAPKtIz
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Jul 2026 12:25:20 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6.12.y 7/8] can: bcm: fix data race on rx_stamp/rx_ifindex in bcm_rx_handler()
Date: Fri, 24 Jul 2026 12:25:12 +0200
Message-ID: <20260724102513.16898-7-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724102513.16898-1-socketcan@hartkopp.net>
References: <2026072011-atypical-tapping-9d9e@gregkh>
 <20260724102513.16898-1-socketcan@hartkopp.net>
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

