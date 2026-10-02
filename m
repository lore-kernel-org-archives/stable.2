Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F7F358D27;
	Fri,  2 Oct 2026 08:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790928916; cv=pass; b=nir7ObLGcR/2MWe89dYdN8hvorgz5tT+LksTvzkp2o88yw2KCZ0NWOCdlu+0CMigGIiQtf+I4TnqSKsv41FNnnS5Sf87IsYhcys2SM3LKxTJ/Fc9PPgfzQmOQ4QWxsZY23PFLBrLc1XTIFxRjOwHfl0GaoA8iB21Ulzgm1iNWgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790928916; c=relaxed/simple;
	bh=HAOTBdzUb3lYVQtLMGc9mEPp8NA4cIB0gJS6sQbBq6Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=G6iHzJZN891to8nWOCtQyEcEnr67qY993lFN108lD9L+cYxjwBGqX56XFSExPR+UTRi8TFGmqGWIs50FcDnn7JKUf4lMTHztrclV8Rl32Cnt64O1wjeh9RQ05hBThC5G19vXx2tFrA6suKbskdsgZePpJHNoEWNsUbOBMSnFeZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=F2qHg2TQ; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="F2qHg2TQ"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id AAE252001F2;
	Fri, 02 Oct 2026 10:15:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790928910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6+qK4JDPMh/p+e3dijc/F+DJtIAPvW8B3rCY92DYtzw=;
	b=F2qHg2TQEuBDT6bvtY3fdumZr6LBWMO1+Wsqny1mSCBuj09glaNKSNFbAY4A+sQWk/15P6
	xgu/v68VJzHzvfCWeKJSFHTwJBXSWdGjRDM1ied8YKSC+NRGPzvzUi/fRpM+80jouh1dkc
	fslqaZ0cR4CpJ7S6OZJ2zo67l+b29vIcH8t6oWILtsvROciuD1klUV6MMSgtEgZCb82Xi3
	UKvdrsA9Ubhb6K4gLyezRvIr0wKdjqtYTQDam/FIm6peDBpZNIC6jLhR/Dbg742cK+pbSv
	sT+tW9/FXHMx7X3+Xii6TKUksBKQxD+yqnJR4CIkJo78/KdBHQ4MnaVaUHRaeA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790928910; a=rsa-sha256;
	cv=none;
	b=B3yfQL+it02p+QRxEkU68344V2mSU7W+wghhBNWjAr8gS6pFblIEWzMKfqNxHxy8iascQy
	moW+6Dh/5L2wCUIxjgaUZokFhVWKMbqkker8jprL66i2DxX1Lm10kGhVkTYJtbFxwv2VFX
	4wYw61eRVaGvbEUaNYIplvLSoKR1jVgUUU093JyPNszJuqAP073NIzJKjQCSsLwpCjItJP
	UY9oPJ+PgDxUppEkto13i9833WQ6eX9FehLaZL0p3lrJrwBxAOtcCEG6RaGbqacmq8mB7n
	tkWM8OS8uKEyXtiyOTi4UmqTh2MV6Bg4jmqifsNwKm2gYZ5oH58F9fGJA+8mdw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790928910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6+qK4JDPMh/p+e3dijc/F+DJtIAPvW8B3rCY92DYtzw=;
	b=H2yLw8y/JSLCgNpWX00TP7qQAikb1eSgxRpCIY6SAWck3qmdPPvY2ixiZogAJJ5s7NOLIH
	l3+BcosP8sz9QsbYNsbNJUMXfoH+AZG4KLrPSC8dOjRBstKG85Dz3qGJAu/VWzkYs4txsb
	3BOY0pAHkTtNujtwRfk24aO+CXxKnrqVZGxCnIY/bdS2nWmbp8OksitfsEO191ZP39hBIR
	v2V2qMSm57S5Xk0OTCA029BAs0/BucN0b2lfMm47nVtUjJ5Yr5Bv51lV3wsENTVnLqAkjd
	nYGpJK0yuONvMCOCzUX3TSjbC20cNzqKaH/LZXexh3IF5P9ZfZng63nchzSV6g==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xCYQA-003rVG-1v;
	Fri, 02 Oct 2026 10:15:10 +0200
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 370245B8284;
	Fri, 02 Oct 2026 07:55:39 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH can-next 0/7] can: peak_usb: fixes, cleanups, bus error
 reporting and loopback mode
Date: Fri, 02 Oct 2026 09:55:07 +0200
Message-Id: <20261002-peak_usb_enhancements-v1-0-50e965755c06@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMUQrCMBAFr1L220BStQWvIlKS9EVXcS3ZVAqld
 zfq5zDMrKTIDKVTs1LGm5VfUsHtGoo3L1cYHitTa9vOWevMBP8YZg0DpPqIJ6SoSQe/P4Y+pLH
 vqLZTRuLl9z1T9GIES6HL3+gc7ojlu6Vt+wAkd8D6gwAAAA==
X-Change-ID: 20261001-peak_usb_enhancements-f4a35b7bfd76
To: Vincent Mailhol <mailhol@kernel.org>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, 
 =?utf-8?q?Stefan_G=C3=BCnther?= <stefangun@pm.me>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1425; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=HAOTBdzUb3lYVQtLMGc9mEPp8NA4cIB0gJS6sQbBq6Y=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsjan5y4q2ze+hkCd1zzv05JXnzCSPCys9isg0d2XHOWu
 zihZ11hdEcpC4MYF4OsmCLL0h8nFAUCHUp7XyZMgpnDygQyhIGLUwAm4tXMyNCpP5/X3f5xzaf9
 D7sVLA6I9F0r7a6v15Y7MNmzUzj1/A5Ghj67vAd/5n7n32a8+2jZGt+bfJVmU3qnbQwI4upyEXo
 7mR8A
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

Hello,

this series aggregates the peak_usb patches waiting for net-next by Stefan
Günther and Stéphane Grosjean, plus 2 cleanup patches by me.

This series adds the missing CAN_ERR_FLAG when reporting error counters,
the cleans up the driver and adds bus error reporting and loopback mode.

regards,
Marc

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Marc Kleine-Budde (2):
      can: peak_usb: add missing includes
      can: peak_usb: sort struct peak_usb_adapter::ctrlmode_supported by value

Stefan Günther (1):
      can: peak_usb: fix missing CAN_ERR_FLAG when reporting error counters

Stéphane Grosjean (4):
      can: peak_usb: Add PCAN-USB bus errors reporting
      can: peak_usb: Sort CAN_CTRLMODE flags by value
      can: peak_usb: Add bus error reporting for the PCAN-USB FD family
      can: peak_usb: Add support of loopback mode to the PCAN-USB FD family

 drivers/net/can/usb/peak_usb/pcan_usb.c      | 120 +++++++++++++++++++++----
 drivers/net/can/usb/peak_usb/pcan_usb_core.h |   6 ++
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c   | 125 +++++++++++++++++++++++----
 include/linux/can/dev/peak_canfd.h           |  15 +++-
 4 files changed, 228 insertions(+), 38 deletions(-)
---
base-commit: eb0c18404c8943356f4aa164e5db9067b79ea93c
change-id: 20261001-peak_usb_enhancements-f4a35b7bfd76

Best regards,
--  
Marc Kleine-Budde <mkl@pengutronix.de>

