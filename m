Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1163331AF24
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 08:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784882297; cv=pass; b=pTb4hcE9sBmA5zZ2CO7kDvC49EUSiW+8S1L/pd6FU/R+h3l+d8nV4386m6ZN7PzzK/2sPABLIYoDr8fKpc8oVSxSW/MZ86H9VmneshPmP54VsZGCKIlOK4lWHYSgkt0ayPLAZGZpUg6XRwgqezoN2W4G2X3q4xOizTtzCpSJzaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784882297; c=relaxed/simple;
	bh=D/vkFyAP8TmGv5/zUWGv8J6jF+RCDjQhMqeJEWi8wsk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JWjZ9SN9p/j+5SCVfS7bCi74M9jZD68LNf12Nm4bqaxprabMHcnIjCY/xj9aaZr+enhC4uWsmbYWqrVgG5G9Bt/fT3dA4yRIZK/lEewtOJOFCjwiSbjrwB793QiK4Yyi+qbH2ZY1fd0H4t0RZy+e+hlBTpIMhAlZxRl9O4iiGHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Qzz2S4PI; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=GaNUgb/6; arc=pass smtp.client-ip=85.215.255.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Qzz2S4PI";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="GaNUgb/6"
ARC-Seal: i=1; a=rsa-sha256; t=1784882286; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=hy10G9Cz2OEGG3gfSTyGAodAk611S/fpd6epHd7/TbXuzYE0Y63hr+6O3trfNhM0qS
    x7ziakxOlYCoEbPlX/IPB2aijnUzlo58V/eNWyeo9Hk5+gF6qknUMT/V4fGuCzGKkCEP
    HW9amHV4wP/X76U0lzt3ZBi0s8oYw0CYTXrN0FPXtyK3z9qZt+hpErjnhwztUfAXTEGM
    SVCNcuS1UPPgRAlopTo/Kmu7rLemZaJL4mJiZXe1LS6Cc0cTkg+vNte2kk/PYOW5j5DL
    uVN5a/VYbIkNgxO0w9elGZQaibEZr5J7oa5v5vSpLmBKa+ivNRerWx99M7pr6tIIqixf
    C5Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784882286;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=6M0fP1wmT+Dyq1BT3vwUGyCvJP+Pj0ZxzQxZBc7Djrw=;
    b=i+mhcJVw5wEuJ+x3KK5FVpzxr1rP6bY1gWym1ASW7LdO8MXjYcwLXQY9rfZFXbYQui
    qxkRj1Ek8Fn7SO+a/HRm3Z1O/PJa7hEBBrHzBZcXudyqOqbqsjgWnTknHdArcyapV90Z
    5o662/UyffwmAgqt7YOIfDl8SqpD1eHyEPINW8mQ4qu6C8mmXTh6GJLzrxLJHkEjIDJk
    X2DzeSD7Jda69IzewabLnEpVES9PwU38TMHg99mK9HD1Mx9+fIazniSgeIu6VC1NOOV7
    KOF3+/8WQ5gwDCeG0pYIKsiFKiMqYdr4TbgjYTqtPYSDBdgGPEkRPbcAP9ragKz0oaw1
    7FkA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784882286;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=6M0fP1wmT+Dyq1BT3vwUGyCvJP+Pj0ZxzQxZBc7Djrw=;
    b=Qzz2S4PI3/oGNkRugYjln1FvVFzUUAbwTKe+wBEOfEt7lv7kjjgn/o7KUtvbaep9fr
    xGJYvYjKPIt5UElohtXudYphn9Q+JMn5ugJuHSrWu+1nA8l6nnw6PDNl06LMUFBtdhYA
    IyGGJemvu2zZUk6PT5NuaVrgXCxykg+NUAxpVdn/dovLeBKIfwetq50qjBHVi4zIQjgF
    P4FoTdMvCCU23CgGr1PM+rWHvNyUBQgMBLxUldyhOQWVrRaeiLVkR9dfMSEdhu3kuiF3
    +B1Y9JZHV2lwNWvq3nIBfpDlJ7vQQ7dSmYDe1DXJb84JaylgCxtl6U1AvDtzDmyih7yl
    YDxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784882286;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=6M0fP1wmT+Dyq1BT3vwUGyCvJP+Pj0ZxzQxZBc7Djrw=;
    b=GaNUgb/6uzQQQi7GXZZ2UbsFVFwvtr1WmBPm9wP0lGOgM3aCaz1olTFuOzxQ890qHS
    xFq8yzp2yPmt0Jt6N+BA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926O8c6rPz
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Jul 2026 10:38:06 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5.15.y 0/9] can: bcm: backport of 9 patches that failed to apply to 5.15-stable
Date: Fri, 24 Jul 2026 10:37:47 +0200
Message-ID: <20260724083756.12430-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

This resubmits "can: bcm: add locking when updating filter and timer
values" (commit 749179c2e25b95d22499ed29096b3e02d6dfd2b4 upstream),
which failed to apply to the 5.15-stable tree, together with 8
further bcm.c patches from the same upstream series that build on it
and would otherwise fail for the same reason. This is the full set
of 11 upstream bcm.c patches from 7.2-rc3 minus the 2 already queued
by the normal stable process for 5.15 ("can: bcm: fix lockless
bound/ifindex race and silent RX_SETUP failure", "can: bcm: add
missing rcu list annotations and operations").

This assumes the 2 already-queued bcm.c patches for 5.15-stable have
landed by the time this is applied. If not, please let me know and I
will rebase.

Lee Jones (1):
  can: bcm: defer rx_op deallocation to workqueue to fix thrtimer UAF

Oliver Hartkopp (8):
  can: bcm: add locking when updating filter and timer values
  can: bcm: fix CAN frame rx/tx statistics
  can: bcm: extend bcm_tx_lock usage for data and timer updates
  can: bcm: validate frame length in bcm_rx_setup() for RTR replies
  can: bcm: add missing device refcount for CAN filter removal
  can: bcm: fix stale rx/tx ops after device removal
  can: bcm: fix data race on rx_stamp/rx_ifindex in bcm_rx_handler()
  can: bcm: track a single source interface for ANYDEV timeout/throttle
    ops

 net/can/bcm.c | 558 ++++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 425 insertions(+), 133 deletions(-)

-- 
2.43.0

