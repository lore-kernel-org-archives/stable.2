Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4623D1ABD
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 08:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784882454; cv=pass; b=F6YxDPCGSl6A+eEsmf5krkPd1daAwOH1N2KN6DPoPcT2IujD3WtYs3kaNkEzc2YsNpo1AYoBZaHOzmkMlh7QDvq3KrENe+/RE/Y2jGDlEXUs+2op7Gsh6U1sqwEYoL24CSjoeEQdmv0EhvAzppAvq9g+VhrMCfNWLU3/r7F6RD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784882454; c=relaxed/simple;
	bh=Rg9S0G9XxUMFPsj2eavKiuV6NBspTr5UDBRPXuFt5gM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s8MYXoq0BhvMmWZkwOVGJm0YdmnRY8oH/IgUZ6IVNeLFYiH8cjyS55ttLb9wEXkhoQUyxV9Rl71ZLtoDXTlZvCjhWtgjd7s04f6oDV+9KRw/Y+omSMWhfknJVEM8pezpNigso3g9Qw/7DpVjIwsB9OHbunw9FIYRh6F8BkCBT2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=ClRjEJsG; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=C48AyIWt; arc=pass smtp.client-ip=85.215.255.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="ClRjEJsG";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="C48AyIWt"
ARC-Seal: i=1; a=rsa-sha256; t=1784882448; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=qRCyMRfXj6RCWFXdB96XPhT626klVcZ+26XDZbYly8aA0zp6R54MH/bDdAubqz1xEt
    UYDExELOixqsUe8KH0XrDNBSytgeGCbdvTarEKQUljWBTFr02UlgQyFv0NbAsxFOcmjR
    nGke/gON+RstbMAYwQFQBqpJFFVevphao5Y/Ug0L4cFleod1AXnQzgfSZcUOmTKkCqTT
    0BNINivoqDWZxq3tl8q2ihtTKtXzxHQ6HDh4mk+Kce5aH9lah1B7qbSAAsAwSrfvrfp5
    3n9deBk2L4rNihJHyweocklJcTzILPVlzNqXevfjoGq6nZ0CsGjy9SzDhrtaOOI5SOlx
    MEwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784882448;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=ujwwGV2WW5Xyh1Wp0AUtcn9YxVktk5wBgvUvrCqzvf0=;
    b=SU1vMjD5willvowXgn62muJCOgUNFIP53lTx/zMSm9zpFYepsDa5CGhG24d8o2GJik
    sLoFplnwQmm49wJfdKbI2Dz3qqyTMbNLHO+8hi9T53GekMOZqNYGO6G5qh9uarBBsTag
    f/GuGgw+iysj1m38ak8DJgYO5wazvSZxASiEXOVCQOHcLH6oEbCApYWLfLJUiDnO+LWj
    bETbwES4EPQlRp+7I6wfQwAidI3kpFwpzuRIkcUEGv4MoOmlwkd707N8/80uuiA/zf8B
    xq4fgfDzAwiF64ZrYkaUUCAoX1cv6snQ/M/lJSfQey2qrxUzaBMqihp48QEsRCEwUO5V
    v1LA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784882448;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=ujwwGV2WW5Xyh1Wp0AUtcn9YxVktk5wBgvUvrCqzvf0=;
    b=ClRjEJsG2kR5drFIRdvZ/s/LvQfYGuTMTGH/cDSKeYcj1JQVShtGYY637tEGjQHgNV
    XjT720fsofiY3Dg9CHbMB45vs8GhvTjcO11BPLkndvfaz16mcvu0N/QXx1sDUXFhKFfK
    xicbZAUeAn4zBpeTcT1OzrKddODVRvH2M42YYwAtyM3uaSLSeZXBUE62d2KF1c/XRUZo
    o8/5RNzigyLET2/+3u0S5d1BR/Imt9TpiejarUa7cAyzV4PNegMxR4lT+vwqaqtRqxm8
    yLwW3WQeSWMTtyE05MpmqZfyMxRpRyZvJ20wEMcilVrAnZ+/2688u3FLwqnsHEpwjkO2
    npxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784882448;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=ujwwGV2WW5Xyh1Wp0AUtcn9YxVktk5wBgvUvrCqzvf0=;
    b=C48AyIWty+BEHXBFLsBBM3te0GxuC6RMz1c1yeHoo0dbBLb5QF/9tOth5/Sn+0z22z
    M2jNpaVko7Z/yRTiLEAw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926O8emrWq
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Jul 2026 10:40:48 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6.12.y 0/8] can: bcm: backport of 8 patches that failed to apply to 6.12-stable
Date: Fri, 24 Jul 2026 10:40:34 +0200
Message-ID: <20260724084042.12984-1-socketcan@hartkopp.net>
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
which failed to apply to the 6.12-stable tree, together with 7
further bcm.c patches from the same upstream series that build on it
and would otherwise fail for the same reason. This is the full set
of 11 upstream bcm.c patches from 7.2-rc3 minus the 3 already queued
by the normal stable process for 6.12 ("can: bcm: defer rx_op
deallocation to workqueue to fix thrtimer UAF", "can: bcm: fix
lockless bound/ifindex race and silent RX_SETUP failure", "can: bcm:
add missing rcu list annotations and operations").

This assumes the 3 already-queued bcm.c patches for 6.12-stable have
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

