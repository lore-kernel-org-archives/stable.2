Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793033131;
	b=ygaxy08bhiOGjT1xDMXDz3764yu4Gy4zoluTmKGPS/twY8MEkSRivhzpAdo7w9lt7HQW
	 C3WOpGGU5r6G5rC67VEoA+EiJsKAEkAgJ0vZhBnht0I+ruLwoDaEGVzZiNJCg4ySl+UP7
	 khsmUHfGv4vvm5jt6w8CmzDCN6UNdjKXi3BgqyGEq0Z1QApLWw6bIWG3eZACdeA5NS6jo
	 NTQYylxvuo0zQtrY9VjslxIgdCyaIs3ArocwVebvsWO68j2TZosahLAgOej/utCv5oFqX
	 BsdQAafJjYFOOCIOTWkN56SkJIykbaeuWjdHaCaOUagoFdSrHFYJCNfb307ph9G3L0w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793033131;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Subject:
	 Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=FL3agcMEj+ZGasFhDzJBHOjfkRUKfbW0Sy3yJYyJpvo=;
	b=IhMqm3wJzq0msDNFc7bDIRSr+THt6xvzb9algqfjFgnOiUfEcVrMH5PICXPHtEidt3y3
	 0Ysu5jVbYqS+jJdT2DfikQXQE71iosvtKK+W32RBINndWRh9jxxRwiD/GIsNMG0t3A0mD
	 j7IWdx9czCs1/9MHtAfbZcM+aRc+5fnUClAaWzcI00eZs3q4lFuraoiFsfII9KQU/7jd2
	 jI4X1Ja0ydUNbAIMQja+0SKJ4b/4FoYT8hqtWmouUbpN+zj9HyHHnllslnGEjEtx8v5YK
	 OGtlwfrDYOPKAQW5QzBKXpaN7hOBuStbm3ar/aCBp8pGhRoriGyvER4U1Vu9bbpsvfw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Fpk8YuPV;
	arc=fail smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57962606A31A;
	Mon, 26 Oct 2026 16:45:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57962606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Fpk8YuPV
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 34B8120291D;
	Mon, 26 Oct 2026 17:45:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793033123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FL3agcMEj+ZGasFhDzJBHOjfkRUKfbW0Sy3yJYyJpvo=;
	b=Fpk8YuPVZRnHvnbSRqVaAkzSTJ+7wK/rPFbvybW5fs6dGyC5UexpVV+k2Y4fmMTqFhqYbS
	SGk5AvE+0/SFuRACOpEUiDHWQItm04u5StGzF6LgipgLDSgvBzt47JMnGUmv/YQNnsprQ9
	lLzfXhM7KDIoc8J8JY+kBpmbMJHOSsheBW7VnN3hHrnbQOZBdv4VgMYqFP8a6pl5XlUouy
	OWgeeC834SWMXnwPC0i3FcG/uj/xTEKD7Bw/FMxzIz1zj3vpKES2ZtyK7yGi6PKKxsz8Tm
	1hyx9zp77kyckFS//mXFq0qCfW65LS38QuNazTxrc+93408+X4KOYGoStkXqFA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793033123; a=rsa-sha256;
	cv=none;
	b=R488NGWreu9tOAbjuSLXhaC9HrvQjp2UPs2ZMvHzNgzFm4SqiGAWiw/f4BJynjE9rq/zlp
	FrdEHHUjShKy2lb9AXfxoAlhMw/vRZRVSiaJLLEEe1qtdnI4z9NL1oe+rvBGfIUhcEFrIy
	d8+6kIaEOqnhdYDidapgGDde2mKCQ82sr7Rxgkn3lydo/o+raSOBq5sMbjMwjbwCU1lsmN
	gBeLxgi5O4zYyI1sGehTTqwOza66dNuE1olkXGT+FEW2Kypt59cfMYWZS8xMCscYTcXChA
	UW/35hXBvhTJfjBOv0y46SdhKrfF6+IVs4l2FGbZ6qPu7dkR5arqbWgWHFv7MA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793033123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FL3agcMEj+ZGasFhDzJBHOjfkRUKfbW0Sy3yJYyJpvo=;
	b=SqOKOrU+qp8SaoSXmFIFLQHElhP0SxB2n9tWy8EhNMZ5msttljAyQV/Ik0m5QIavFpa9a0
	BljIHIaQVayI83P+AozSGOljvmwIri7LsJI6lNJc7wnpU3AwgFbaQWAm2egaINyjw1Jdi5
	4CQMyuD1kB4bbzezYCpFyJ60F5D/JZ742VWpe/R+Ks2oZo/ThIhpnIZu0P+aiEvW7wl0dS
	WInwuq05/ZJTxNrJwTpA0fI2PzhywjOl/39hRXx1RRyTH9XCFcpCkAXHrG58e7AkEbHrue
	O7p1i6VX9gtv4OawnY3fEQ2ravjRLHiOIJ+wip2gZbyuH/rhtWN3XH0SbCItMA==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xLNp5-001JFY-0K;
	Mon, 26 Oct 2026 17:45:23 +0100
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C98215D7167;
	Mon, 26 Oct 2026 16:45:22 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v3 0/4] gs_usb: fixes
Date: Mon, 26 Oct 2026 17:45:04 +0100
Message-Id: <20261026-gs_usb-fixes-v3-0-3a68f1f62813@pengutronix.de>
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
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32PwQ6CMBBEf4X0bLW0VNST/2GMoXTBNaFgtxCM4
 d8tcDR6nOzM25k3I/AIxE7Jm3kYkLB1UahNwsp74WrgaKNmUsh9KqTmNd16MrzCEYhLLSp1OCi
 VipzFSOdhOcTE5bpq6s0DyjAzZscdKbT+tfwb0tn3Az2kXPAqz8AYm9lC7c8duLoPvnU4bi2wm
 T/IfwQZCVppm2lxzKtcfhGmtaKHZx+Hh7U3MwUBL9umwXBKHATuYAy7pkAXE9MH2ferJDIBAAA
 =
X-Change-ID: 20261025-gs_usb-fixes-250f38833107
To: Vincent Mailhol <mailhol@kernel.org>, Peter Fink <pfink@christ-es.de>, 
 Eric Evenchick <eric@evenchick.com>, 
 Maximilian Schneider <max@schneidersoft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, 
 stable@vger.kernel.org
X-Mailer: b4 0.17-dev-d7211
X-Developer-Signature: v=1; a=openpgp-sha256; l=1373; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=qaYRdb2B5hsbTU25Nu6Xn6o1GaDEbwS64sH/0oP08Rs=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsi63zztabH7n+2WPXUqMTOXcYf94WfgeW+0O0D/rv92l
 e6Ja88Ud5SyMIhxMciKKbIs/XFCUSDQobT3ZcIkmDmsTCBDGLg4BWAihaoMf4X0E5VXPp5zM43h
 qvcXy3mrNk9v/x24/NDSjgBOFo6QH4sY/spurdIvvb34WNit0DqejTs7b8lY786p2dbYG+W7RGa
 nEAMA
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

Hello,

this series contains fixes for issues found by sashiko.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Changes in v3:
- patch #2: fix cleanup if register_candev() fails (pointed out by sashiko)
- Link to v2: https://patch.msgid.link/20261025-gs_usb-fixes-v2-0-535d45097f72@pengutronix.de

Changes in v2:
- patch #2: add missing cleanup if register_candev() fails (pointed out by sashiko)
- patch #3: do not increase rx_errors during OOM (pointed out by sashiko)
- Link to v1: https://patch.msgid.link/20261025-gs_usb-fixes-v1-0-f74ebbd4da36@pengutronix.de

---
Marc Kleine-Budde (4):
      can: gs_usb: gs_can_start_xmit(): don't leak uninitialized memory over USB
      can: gs_usb: gs_usb_probe(): init netdev completely before register_candev()
      can: gs_usb: gs_usb_receive_bulk_callback(): check for overflow flag if SKB allocation fails
      can: gs_usb: gs_usb_receive_bulk_callback(): add missing call to can_rx_offload_irq_finish

 drivers/net/can/usb/gs_usb.c | 77 ++++++++++++++++++++++++++++----------------
 1 file changed, 49 insertions(+), 28 deletions(-)
---
base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git main
change-id: 20261025-gs_usb-fixes-250f38833107

Best regards,
--  
Marc Kleine-Budde <mkl@pengutronix.de>

