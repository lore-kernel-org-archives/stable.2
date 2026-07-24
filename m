Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFF040DB5C
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 08:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784882717; cv=pass; b=nB91Tia3GOdwFa35uam2lhHlMblAYHPa8P/bV6yVR8WWd8NMYc2qRFNSV5qWwLhHZij6TRYNXwl2buTqFGIy6DiypB3dfaNKS+Zseje5i7lY/4ht6EWd+xElgcITPh+84MSCgSN2rz4HPeHMxIfS+od4CME5dCU6zEUdMVUmJD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784882717; c=relaxed/simple;
	bh=e5ohou5CLoYR6rH0Oc/Q7QRXZhU3JMXQlxaGvND4iD0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GsmVeuNYTh/CoqyPFkgHn2q+K1yYAvURQuLZoItw2sA8vA55PF/62rzf3Glk72Zzb1O9mXno4C9PNNzVl42RKXAtgVi/ffCLao4hDAzllHGEOEPyQSGZP9k3/M0AZw5M2PSbf/xaBJYLEYyEE2A1acTArSubGvenuE3fXtgU6Wg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=iT/F/mfA; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=rftjoMcc; arc=pass smtp.client-ip=85.215.255.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="iT/F/mfA";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="rftjoMcc"
ARC-Seal: i=1; a=rsa-sha256; t=1784882530; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=UIwrMz8QWaoMvx7eSeFlY44j7zm0AlthoGXYi24kFY3UXCoGOC/rGrAWga/FoojMsC
    CsIfVjeWcovnk9VL5gYRIovqlJndG80L29h67Np1wwWFayOrePvVseaXEDYP4h7N5hXu
    KteJ97714+eINvkTci7akNEZiw+zjFCdfVQGqXjtaRroekBIqQ/F511Nqj0/Yev/jWwm
    CL5AU92jyjtfvZ/ZNDJN/w+dVoG002Gp1cjzrTaEL+BDDTeT1VvLmsDo6Y7zdJqKzfal
    EICfzdvwdRGnnSxgVA7+CxMqSLnV0RM8DOmU9WM3zuujv0DjberWFPAZh9ObTBechtdJ
    hF2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784882530;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=nixrZUpz9OlZ2f5uX5klPCgNqW0hvTJwx6mTJMp0QsQ=;
    b=PbYLlTjlJcgiesi7oIyxPY80i6XnuxYUTcTHkh5BZFEv/jgo9JJZHMXrQWl//hB+Iq
    DjZ9rOvVxzUbI4I2v3W+eukIVqQ20lf6o2X8AIlGG+3XM/GokWY69APLPSTJyw/OStxB
    EhHUiI5CvWBF2E/QhprdVR3pISsrd63ejDxOqDMuspXIccQOXvotgcBbH+KiWxAFcPKS
    I90EUj73NR939BKzOIuhsVLv04vHjngFtv6/1tUs2R0oEWOvIhjIdNDgy/3Z8RSf4Upp
    v6l47/HcJ6jywayv5sJt+RvuyUKll50zJONbG+BGMwUp0PrQxsVuHQ4qkdpK0NaaE7QX
    UMdQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784882530;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=nixrZUpz9OlZ2f5uX5klPCgNqW0hvTJwx6mTJMp0QsQ=;
    b=iT/F/mfAWBMiPr4/WFT1CHSpgjIDcV8Syy1TwGEoVxg919WYLaSaOLtDBbMn9EpGfr
    tR9YuxfGSMpKxFgFR5iluw3b5ryAD0E+rFWtaq9QETUT7VzeZEPdxDZYhTlrREGhWpi+
    yE2uMIgXIUSDnZL1UckIK23f0P4zer39c4F8Kf29MqFahhbIT7svrfQ3A4YKzwWDNOtZ
    4zA900gfUxuEVlOJfRio/EoC/Wb9VTA67V37B0ayhw3Aqqwlooj81s/3zcu3kp9xoAsE
    Ma9ZsuDAt+XA1KdqFgRM8z0y4rhUOa9JmkXQm+BYCcUd5swuJp92aO1dE0By/5/McHqY
    IVEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784882530;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=nixrZUpz9OlZ2f5uX5klPCgNqW0hvTJwx6mTJMp0QsQ=;
    b=rftjoMcckT55rIX3RtuVXdb9fH4ludCNH79m63ZE7Xp+mvQrQZWeduEME7aGZd55lv
    Nk2O9XmW+yGYDH0wfsAQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926O8gArXH
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Jul 2026 10:42:10 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6.18.y 0/8] can: bcm: backport of 8 patches that failed to apply to 6.18-stable
Date: Fri, 24 Jul 2026 10:41:56 +0200
Message-ID: <20260724084204.13169-1-socketcan@hartkopp.net>
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
which failed to apply to the 6.18-stable tree, together with 7
further bcm.c patches from the same upstream series that build on it
and would otherwise fail for the same reason. This is the full set
of 11 upstream bcm.c patches from 7.2-rc3 minus the 3 already queued
by the normal stable process for 6.18 ("can: bcm: defer rx_op
deallocation to workqueue to fix thrtimer UAF", "can: bcm: fix
lockless bound/ifindex race and silent RX_SETUP failure", "can: bcm:
add missing rcu list annotations and operations").

This assumes the 3 already-queued bcm.c patches for 6.18-stable have
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

