Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34CC3909A3
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 08:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784882351; cv=pass; b=TXaU/4SMF5r0D6XLrKFsGAfWOurJL852Y46cBBCF7TLpcBZgOb87FqeUbEnL8rVoSF80NITAt/DpzwNidZz67E2M9L86mzl+/SxLAA9kO6LRkyThGVw/dVPUiWwIBkrE9HjyG1obLE31dH9yfTBT3Flj8jZXtpw1pM4Yr3lsZIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784882351; c=relaxed/simple;
	bh=aY++yJXCGozWApk6h7HsU6pP0vURZYQSu4GtO/f4Adk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fsQvwhrVJnHHa83r9dk8dJgPmcJ/DeaWvaUocaGYH9O8hDupcRKGTQfTAbdpZkEV9tvDG70C4mT3VO5isoFVS4c4CPBzvc92gpeK/4vmjosshnd7q1kRzmQAbFYUTgZCk7/mai4I9Loieiq5l/QR6K7h0eW6xtLLMGFmxIuH2Uc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=ce+BbO+K; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Km8Mek1b; arc=pass smtp.client-ip=85.215.255.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="ce+BbO+K";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Km8Mek1b"
ARC-Seal: i=1; a=rsa-sha256; t=1784882341; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=YajnPiyfI8aRuWDcZwZWhfEQToiOeAc1N9tKpkBPTLFwO0APc9bk5gxocpWgxByaNH
    fcokZDpXcGGk7I/og7DwwcSjqKgXuc2Zknt3BM7CPupuH9p5+ifpFK35kUfsAtm4Bz7s
    jqusXh2BflNprmeiXwfWp/p2Lhp1wcSKx/gbWSFqA9/mXc+KARecQZuYbLuHurQyDxDD
    c5jQStD+T/LgNkB1lmOnPuASfopJU0Q/t2pusIklLpOzzFNzOUdQF6gQxZekg8lZv6XF
    bbCsfby6517B9d8LFX65QlM4PyK1sxnsCWQPbbCms/n+mHPwmNnGwecQSW8dHc8qD0N8
    neaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784882341;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=kqQXbuZqT+WAxa36BNSi6GKcXKLxuMZOagclQ9d2gFU=;
    b=HbwS1c5gBAOqLG1B5z1cvmdGjZ+ORK6w9PCFQbMI/rePvlcx7YR1xt07K4vOul1TSU
    QHav5GsEkqENf7vxRNt+7cbUT+3e9Z559YoF6YWOcsRsX4kUwsUTup0JKHRY3QCihmjV
    NEmeaRuDiH9KU9jtF722ArKdG9gXSO2OGqb+ZRqOX6/6hdM5Y2Hg1Uwn3FeAX8e4BURO
    CVOMy2wQMPnhNDIVOEscS7n4h4+G2amWkXLNuqt9w71X1FnA5EJY/fogUzHPSJsDWFGL
    xP8E/94RoyLlc589kzNeU/acPlghoQk1YOr/J/81LdNRjqGgcdMyHEwiOzp86vZYqn80
    a9zg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784882341;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=kqQXbuZqT+WAxa36BNSi6GKcXKLxuMZOagclQ9d2gFU=;
    b=ce+BbO+KvbgZfyDsuxkkxZScm7xZD9eseD4sagj0k8ERNFbkGAAI0XFTtZvcp/NB3N
    MpvWOfKCfTtDOgVyPiTOw0NKBF887CH2KSM3RclsEyluxETOYizTgR5uPvydrobPWjx7
    +WnymIYdpnTE29AH52y3Gr+36SLKiESTha7bTxualcr71fvmVqxaRBWfIalOl2xD4MEv
    JHv43BPegBlgZXrrCMtcAmQJk5ky6rhwxVE+UbFEgJ10V76lRvutK8B99yHgdV8ES/ZQ
    UpC3SJ4VjrRm0qFfCWRptELo+O1CBcOVCIO+WzJLS8UutZEejMwFR+gXWHIT846u+zFr
    ddKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784882341;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=kqQXbuZqT+WAxa36BNSi6GKcXKLxuMZOagclQ9d2gFU=;
    b=Km8Mek1br0phaBfJ4S8WmY1VpwbRYs7qIZ+g3VQDuDt2aSMfAUKkP5BxYHz0vtHaXQ
    SrI+GMjnq4QLDetE7qCA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926O8d1rSy
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Jul 2026 10:39:01 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6.1.y 0/8] can: bcm: backport of 8 patches that failed to apply to 6.1-stable
Date: Fri, 24 Jul 2026 10:38:43 +0200
Message-ID: <20260724083851.12603-1-socketcan@hartkopp.net>
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
which failed to apply to the 6.1-stable tree, together with 7
further bcm.c patches from the same upstream series that build on it
and would otherwise fail for the same reason. This is the full set
of 11 upstream bcm.c patches from 7.2-rc3 minus the 3 already queued
by the normal stable process for 6.1 ("can: bcm: defer rx_op
deallocation to workqueue to fix thrtimer UAF", "can: bcm: fix
lockless bound/ifindex race and silent RX_SETUP failure", "can: bcm:
add missing rcu list annotations and operations").

This assumes the 3 already-queued bcm.c patches for 6.1-stable have
landed by the time this is applied. If not, please let me know and I
will rebase.

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

