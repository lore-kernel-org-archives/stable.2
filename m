Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D147431AF24
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 08:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.163
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784882339; cv=pass; b=s0Yh+npkJv5G0+5Ldg9/hPWIpeQzduyMJFIHIGpSc2DGwoksDsbrDFehOg3bmgN9KZwNTJNfVqJmYOZcxs/VW9snGYqTzT35F+qrLzvZu/oOaE6s/XVySUH+UPrMIxAlLVrXLfdTDVl4fO+cDR1mN5OzUAXDvZ8YcJ/beBxMjc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784882339; c=relaxed/simple;
	bh=uprKPwayNY2EIZ/5zvmt9unxPELrtNyCIe6ylsl6YJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bIqEV3YB4oMFjZVD7p4T15mKzko6X8gj85g5UMHtO3XnASjpQl8awEJmo4F45EhgxuP4BWXmWjzwOeTp9khAg677GjOcBrC71iZ134MTLeSJo3wUcVmikxXrkMOpj3hTDlB7hyFPseZTA5/mZEoKveAu296rxyrHQtrdHx9aD/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=gWAztwO9; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Rqp/n34S; arc=pass smtp.client-ip=81.169.146.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="gWAztwO9";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Rqp/n34S"
ARC-Seal: i=1; a=rsa-sha256; t=1784882146; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=IXbP14+hQx3UYwd3E0pBFOXZTe8Xi8ggDfArvMneShW34VrSoMsA4r31qOMUI8DM2t
    mn78E9pLGmv/8JWxgpyAZHkRICHowyKkXbTnZLNbZjBv1Q+QICvzStlsXJ1AgJ/UYXcd
    FJM7lptUWHd5rJgkUHdm5oyrpJc6JPMbPgyd2GsQcGJkDHPIDO0oV8KjNNlzaW/yeQPX
    zdmxc6hnsscnDTpiUhkdI1ldgDmmxnpb3abNvxVI1Bh+PJWmcrK7l/+gnw1vKggrg6Fb
    QdXIGvDNz8WNTlzTYsSumZlgK3jLgTupGtnIevXHYhuYAM+EuTVbze/sC7wpvw/TeFsg
    KG+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784882146;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=WOmy23c3+2wxuOdJFQr3E67x/d/YwmNMe3IgqwYs54Q=;
    b=rPp4k6o/ajwPxzUvO9KRVAX1ku1xJoD5zM20NtldQ/D9ax36HvWEJqEuPrcqIRuUKe
    QUIpRMAgF4PEV5r+zo+jEHPUKQP6He1DWmbONQ4A43sgRCoyI5erk8N9sUnl4T471MW4
    dIsxBqYZZZBF/3XqIv3iVtEAiBVYBDdq594zRZd0NiocV0p8PfVJbDuIwMXXU+pZlvk7
    zgh0W32B98pd+maQdygs/l7pfcx/O58n+wGgdGgZDJUsjWklaZbzTzOUGwTn0fFaIWuC
    DJd83erbUV3ovdBTdXiZZumOidvRvsZZQ/iBgm6JSAgdo/MNl+69xj3OA02vyKbWS42R
    hatA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784882146;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=WOmy23c3+2wxuOdJFQr3E67x/d/YwmNMe3IgqwYs54Q=;
    b=gWAztwO9JCu5ACf1IfdpgpHHR3P1uQSOuwI+tpiLzsSHuiVxoHly5aeJ4ljZt3HJLg
    ORI6m4X4L1eBpYHgAFagXX0qXVLxdAwgeMh0bQitZdx4cMUIdkyA2g+VsAF0vKoUBy4f
    G4vHlCWyMF+79jsi0dGIZToMgVlWai3wWMZBmFQJzA3N9RNcjOAE+kRArapR98owpROt
    67GqfowWc03GA28XXp4G7izCOpHeCoicsSslAU4TI4xQ72gkTnsMVbbt7Z1VynXQUfAs
    HQqZ3SjoEB7TIv1hzYvBZzXiT1LyDFFSuUBjSoTy9t+hVRgPFfe6q/rP/36wB0Ti9gPz
    kkJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784882146;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=WOmy23c3+2wxuOdJFQr3E67x/d/YwmNMe3IgqwYs54Q=;
    b=Rqp/n34SQM7TERlslwueePaJOEYE0OigiqkJndXXSow8Jvoedfdmp7j5YLDe+sHazY
    x2Khed97skwVkgkWkgCA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926O8ZjrLw
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Jul 2026 10:35:45 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5.10.y 0/9] can: bcm: backport of 9 patches that failed to apply to 5.10-stable
Date: Fri, 24 Jul 2026 10:35:25 +0200
Message-ID: <20260724083534.12119-1-socketcan@hartkopp.net>
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
which failed to apply to the 5.10-stable tree, together with 8
further bcm.c patches from the same upstream series that build on it
and would otherwise fail for the same reason. This is the full set
of 11 upstream bcm.c patches from 7.2-rc3 minus the 2 already queued
by the normal stable process for 5.10 ("can: bcm: fix lockless
bound/ifindex race and silent RX_SETUP failure", "can: bcm: add
missing rcu list annotations and operations").

This assumes the 2 already-queued bcm.c patches for 5.10-stable have
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

