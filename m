Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794689418;
	b=HYxRAP9BbF33RNZZZzo+3VVC0IUGaEP8v/VpypuvnTFgq7rMSXunrRUWOVPFfdrY5CR4
	 Y316S+PPS59TarfvOa4gER6wLKPA8zrbDDE9Asw7OwT4WWu4asLYfzRd3kDtedS9YknfF
	 Tp50ndOpKJ+lynIY7kDNWG8a+SfOExxHO3cKpP1R9Nl5UFVl1WLNejMYYMXC827rK9AHl
	 yrshGoi+hRqs5G7wcsbkdkM1Pfp8zVmW2HGjnmIoFPKHGKXRqtO26XZ8DTu6xjEqNH/cg
	 GL4ssaSFcWF2HBS25drsoWitTAVrucZsU68nqEwE84QjF0/aW5cXzLxy6EiJldGT+kQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794689418;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Subject:
	 Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=dF10Ry1orC93XMULaC91fNwjyR4vc8EBN3igMfPGd6o=;
	b=KQnPa/9DbEY56j5sf+qFMCw7FTqqZEPySD3nD1JJwLYFYeqj1HxyzV5pnyccrGBFut/h
	 6vXbNnp0nj26lfnG00NX1VZkyNAW+LzTvFawjLpn5ajENZ9Dhuz1bP56Nr4fNNDTJZh1w
	 Oj3c7A0OTBZ+JVM4Trof3FkxFR6BHamnSMp4CNAJq9HfXpgCD8vBWmrYY76eaV2CckYaX
	 ZzNaC94Yruz/LYkOZ++88wX3tl0pFcDDxiHq82+evk3snwdoARPk5snZ5oss/eWhLsOwF
	 TMa8Y5OZ/n3rGEJGR1jxdruKAIbOudi4H3Cp0xA1ypcS3XvJJ6AAzvzcKQVEGAdfgxg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b="B/LCxr2r";
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EA6606A32E;
	Sat, 14 Nov 2026 20:50:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71EA6606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=B/LCxr2r
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 6155A201CE0;
	Sat, 14 Nov 2026 21:50:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794689415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dF10Ry1orC93XMULaC91fNwjyR4vc8EBN3igMfPGd6o=;
	b=B/LCxr2r4sbaq5+I5XUD6sCn4Z9j2eEAQR3FV4/F9cPWYmIEsgqgpiVrwRyb4UPdbVWs4e
	B937caGIAJBWvRv/lU26j0zTlvAxlbM6kvibRf0YF/ZMT8YxFZ5HEKPwFYyK2YWnuY79cR
	SqT1DoK8BT2uan+x2vdvR+du9lKxOHqlFfX9vb1TPonytM/Ve8c44+n5NgPd/uebMyd6Ed
	c25uLP4scV023M4I6mI3Puycu2w4hJeFynplu4rMz93Ev/Vx1S3KPfAlorNYB7enqqzjpz
	s/83xqKQdREhJilqZ+nD0+zX3NKzyeyYriYMAqhyjPbztAGeLKvKKjsgiEzdSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794689415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dF10Ry1orC93XMULaC91fNwjyR4vc8EBN3igMfPGd6o=;
	b=epoaFDMrH++bBLvupb6b/HJhaYVxYnv2TYBYq4DOfeDO5i6V6orgC/Ghmwfzt4Bxnm0bLA
	AqIB/XVIRuuiZ+4gXmjTmKI4pRnLkx4zqDdq6b+yRPIXp7+FTX51SHsGE91m+fODg7kpcF
	/mOxKAKNtetyvV1v5Nln/kd31CBQG/AXl5IFA0vQKoHP2o0BShhxk+9Nlj2IcYO6yT2CNa
	wtvLBB6ft4xN1ZS1Ln8G3u39kGgCLwOZD472c9nr0d3Wk03CwqOvgcOZYDH8MQFM+uCn+/
	N10MQSxAb0b+LWIsvzbeTsW7Bb+oqrHSE4N7o1Ane54+KWy4UZe3PzOBuiN+Hw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794689415; a=rsa-sha256;
	cv=none;
	b=JggQlH7eOShQYh4o38veKNmyt8dji2YrYkYSSjE1e/nyUd4V2STMYMfzwG+1+U2GN1Vadu
	JvfFLTUOUeLH23NzlXEVc7F1j5nkcAhMBtPfiHrPp8wqXTztmSF/N94EYR+Ip2eloMrgrc
	Sl0xbSmTTJWjQSyBLwtzjpXialmXHg8IoP1vtL9z6bB5UU+yngWl/FC5pCSy6l1xoK0Jk2
	OUQU5v5MnNcsQgyfu786oiDv3XeIlCjKs9PO2xFfh0aWro3r7aK0gqWXozuM3RpUWjpAA2
	17IUNcCjwF3qoZbS6qSx2xgKP3Q97uKoICQI2VmyfnkZ3vd3uhIj5j3SruYZIw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xSKhT-004BfI-0f;
	Sat, 14 Nov 2026 21:50:15 +0100
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id ABB7B5EBD6E;
	Sat, 14 Nov 2026 20:50:14 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH can-next v8 0/7] gs_usb: fixes
Date: Sat, 14 Nov 2026 21:49:54 +0100
Message-Id: <20261114-gs_usb-fixes-v8-0-f615502b005b@pengutronix.de>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33SzW7DIAwA4FeJOI+Nf0hPe49pmkIwKZNCukCiT
 lXffSSdtCqLerSMP2PwBSUYAyR0qC5ohDmkMMQSmKcKtccmdoCDKzFihClKmMRd+piSxT6cIWE
 miefGcE6JRqXkNMKaKBVvqG0ijnDO6P2WSZP9hDYv2nL2GFIexu+180zXiv0mM8UEey3AWidcw
 9XrCWI35XGI4fzsYPVn9khgRZBcOiFJrb1muwK/F9RG4EXgjTKeesUM5buCeCSI5Q41cKu4IkT
 uC/JPoMRsBFkEJ5lzohbEif13UHcC5RtBFYG0hNdArXda7Ar6XhAbQS9TmDKDoJa2xPwTrrfPH
 uFrKsuUf3fBNglwO/R9yIcqQl4X46VvQiwV1x9bne5AhgIAAA==
X-Change-ID: 20261025-gs_usb-fixes-250f38833107
To: Vincent Mailhol <mailhol@kernel.org>, Peter Fink <pfink@christ-es.de>, 
 Eric Evenchick <eric@evenchick.com>, 
 Maximilian Schneider <max@schneidersoft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>, 
 stable@vger.kernel.org, Shuangpeng Bai <shuangpeng.kernel@gmail.com>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Vincent Donnefort <vdonnefort@google.com>
X-Mailer: b4 0.17-dev-d7211
X-Developer-Signature: v=1; a=openpgp-sha256; l=3418; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=ZIUqnuhZMdsHHy1a94dEB/Mr8ry3CEwFq24sBLR6xUs=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsj6cbLWsHpCf9Wp0xwHclWthP8EP2LKNlC0OH3v6qOiE
 OOSwsXhHaUsDGJcDLJiiixLf5xQFAh0KO19mTAJZg4rE8gQBi5OAZjIeidGholHprWIXPNfG2db
 vkxzjV30uzbVjZ7Htx6PM0x6IvRI+D7DP3u3u1nHVh1QmqrOvmDlxVT1I+Ye8xb8n+VfcipuFue
 VG+wA
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

Hello,

this series contains fixes for issues found by sashiko. Also picked up the
patches by Ciprian Marian Costea and Shuangpeng Bai and integrated them
into the series.

regards,
Marc

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Changes in v8:
- patch #6: move function context annotation to patch #7
- patch #7: new: add context analysis support
- Link to v7: https://patch.msgid.link/20261114-gs_usb-fixes-v7-0-58b6341b1c08@pengutronix.de

Changes in v7:
- patch #1: update patch description (sashiko)
- patch #2: moved to linux-can
- patch #5: update function's locking annotation
- patch #5: drop active_timestamp_channels, use active_channels again
- patch #5: remove testing against IFF_UP (sashiko)
- patch #5: annotate that driver relied on RTNL for synchronization
  (sashiko)
- patch #6: new: move use of new {enable,disable}_delayed_work() API here
- Link to v6: https://patch.msgid.link/20261113-gs_usb-fixes-v6-0-0c039e1bfd74@pengutronix.de

Changes in v6:
- patch #5: add missing initialization hw_ts_supported in
  gs_usb_probe() (sashiko)
- patch #5: work around race window in gs_usb_timestamp_start() (sashiko)
- patch #5: start time stamping worker if the device supports HW time
  stamping, if least one interface is brought up
- Link to v5: https://patch.msgid.link/20261108-gs_usb-fixes-v5-0-d52dd4940d46@pengutronix.de

Changes in v5:
- patch #1: add new patch
- patch #3: gs_usb_disconnect(): first unregister_candev() all CAN
  interfaces, then call gs_destroy_candev()
- patch #4: update Fixes tag (sashiko)
- patch #4: use stats pointer directly (sashiko)
- patch #5: add new patch
- Link to v4: https://patch.msgid.link/20261026-gs_usb-fixes-v4-0-59e3b6360053@pengutronix.de

Changes in v4:
- patch #2: fix cleanup if register_candev() fails (sashiko)
- Link to v3: https://patch.msgid.link/20261026-gs_usb-fixes-v3-0-3a68f1f62813@pengutronix.de

Changes in v3:
- patch #2: fix cleanup if register_candev() fails (sashiko)
- Link to v2: https://patch.msgid.link/20261025-gs_usb-fixes-v2-0-535d45097f72@pengutronix.de

Changes in v2:
- patch #2: add missing cleanup if register_candev() fails (sashiko)
- patch #3: do not increase rx_errors during OOM (sashiko)
- Link to v1: https://patch.msgid.link/20261025-gs_usb-fixes-v1-0-f74ebbd4da36@pengutronix.de

---
Ciprian Marian Costea (1):
      can: gs_usb: gs_make_candev(): check can_rx_offload_add_manual() return value

Marc Kleine-Budde (5):
      can: gs_usb: gs_usb_probe(): init netdev completely before register_candev()
      can: gs_usb: gs_usb_receive_bulk_callback(): check for overflow flag if SKB allocation fails
      can: gs_usb: gs_usb_receive_bulk_callback(): add missing call to can_rx_offload_irq_finish
      can: gs_usb: properly shut down timestamp worker
      can: gs_usb: add support for context analysis

Shuangpeng Bai (1):
      can: gs_usb: fix hardware timestamp state for mixed channels

 drivers/net/can/usb/Makefile |   2 +
 drivers/net/can/usb/gs_usb.c | 174 ++++++++++++++++++++++++++++++++-----------
 2 files changed, 132 insertions(+), 44 deletions(-)
---
base-commit: 573af801552999954caa8347e4490b04cf4763f0
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git master
change-id: 20261025-gs_usb-fixes-250f38833107

Best regards,
--  
Marc Kleine-Budde <mkl@pengutronix.de>

