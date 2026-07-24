Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BF53CEBA6
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 08:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784882406; cv=pass; b=a/qtlKvaaYuK/K1Xjh7mnDNpdTaz/yZ+LDqe6VEP3xwYf9DauHWZYT58C59b84dcwPBZ4ZejTqGuHIgliHX4t0K24n/fVmjJlB7ts9um1cDILzfzLc54XxplIaXoXlU0Wvx2KKStx5j2iawJ35TeM0L+V/5oFPZTiNplCUy3Um8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784882406; c=relaxed/simple;
	bh=2iVmBg2VgcsqPGuTgclJze3F74HAHiMz6O+DHrWwdmY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KkklVyx99nhwWEaoPVkPjaG/uwMTzQ1QyDxUid1z+EECKORzlWpVFQI73b2viHJ3wpCgPJGmxmko7ZIhZBNjPfAmzQFUhnwhVKupglIeA03VsUJvAG4ryacgVhToTEmQjndUINpKsG/FUnJGu3TZ2ByXVPM4DCUNvp2h4tJlQDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=YZnWa+ex; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=djwO6bGV; arc=pass smtp.client-ip=81.169.146.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="YZnWa+ex";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="djwO6bGV"
ARC-Seal: i=1; a=rsa-sha256; t=1784882401; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=qB8l8JvKrKGTvK0BMyB//YW6IBjxtuEJ1CLg7g3jPPBcNgYQDi6BIOJ4uVJXif7pgM
    Tf2YiC7+UTvLjjeLST4c0dM0AXsHroMnsPfhxJjX0wfwksF6c9yo/dcBHH1rkXrnFY8r
    l29ce3/d+iv+0ci5y2ub+ZYRX836Ot6CZ+CJdTXPrY3pRYfGVQy+g20VlFU+Ef3aqCdR
    1mWwFVJdM1+228+GatfZFpyvvJd7DiGXIUzLsYs3GOf53+Ak5uOMWdDu8kh7pzOiQjNs
    PXDJ/IstFBtl8Xtq8SS2s5ouNReskgUUYmDY1dXZwYn4PJK5JHyLN7wKSIyag24J/4V5
    Ea+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784882401;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=it+2PlYHUj6+l458dw+vGxR50ENHXLb+A64TRI2ihRg=;
    b=FnT6PLJ4Rc64zbFbMjJtXl9EWLm76+KNJ2J/c0rLi0/rxbBtumSQj3fcxhD72XqI3Z
    kNL6qYttmzFTKbJbYXYeDSxi0KihlGtoVo4MGIzdBJtnMCCi9JSwYJPiw38KjcPNo+sE
    5j/uaCE1H51EYtj60G1n/CYTlJaUNUaSYEOLKCnZ7Q8nlPvJUaO2y7FWHTiRSr0AdBn7
    4DBz4yEaJWItE/Au3tayVE3O2s14gF88UFZTrpFgOX9+l87Qtv6zdNu5oGszCf7OCR5b
    5aQG0zZx9VNuvnUJ8Iv7PViCHXz++1e4qfO9hFNJvJEkXa8OFeBY7dSX2re5iO1IaFKG
    EYrg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784882401;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=it+2PlYHUj6+l458dw+vGxR50ENHXLb+A64TRI2ihRg=;
    b=YZnWa+ex4p2Sdean/rCQH0ChHnDXQI+nHLrFZUfdrXHfUKU5ir6G5ZdRuxSVurJ+wT
    V+TJKV3SJNuIpmbEsd7v6Cy1OM+NPfowYRlxveKY2/ZYM8LKaQglPPCATEuWXVgNdsbY
    B/J+1n7iNLoaJkkIrKZflpTwRrA7qTeiFO0T8J6FtYMiiH8n9/Q7qDht7c/8zDCEpT83
    +dE4wolTj1O1WOhh3WrOyH/cWDcEmvPQfWnAhdRJeETicvH9QLYzBtBOfmrC2pFZXQ4a
    Q/0fKl8rN48EnP1VSgjhxKnELhmIEYQanor+UCoZ1RGk2Mkyw3UPtRL0W5vf2o2tu8FI
    pAyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784882401;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=it+2PlYHUj6+l458dw+vGxR50ENHXLb+A64TRI2ihRg=;
    b=djwO6bGVgjK+5SmCryNMYjOpYoJR4S6vKh6G2xzpo0WBoSB/u9AGmFPxQW5f1NwcG+
    S1jVIYXz8QroORvJGOBg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926O8e1rV0
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Jul 2026 10:40:01 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6.6.y 0/8] can: bcm: backport of 8 patches that failed to apply to 6.6-stable
Date: Fri, 24 Jul 2026 10:39:46 +0200
Message-ID: <20260724083954.12817-1-socketcan@hartkopp.net>
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
which failed to apply to the 6.6-stable tree, together with 7 further
bcm.c patches from the same upstream series that build on it and
would otherwise fail for the same reason.

This assumes the 3 already-queued bcm.c patches for 6.6-stable
("can: bcm: defer rx_op deallocation to workqueue to fix thrtimer
UAF", "can: bcm: fix lockless bound/ifindex race and silent RX_SETUP
failure", "can: bcm: add missing rcu list annotations and
operations") have landed by the time this is applied. If not, please
let me know and I will rebase.

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

 net/can/bcm.c | 520 +++++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 391 insertions(+), 129 deletions(-)

-- 
2.43.0

