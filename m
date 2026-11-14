Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794669478;
	b=vE7dkgjsPIkh6Qm0RRfe2sE0PUCxuYHx7dclreUSEST/4jD0OPCE1c+Tx8ryi+MFLj1G
	 BEB5dr7cPHqIboj5Jkp6bXkhs1uDE9Y73x6M7eLiCvQLZuVG79uTfYYwDFVKh3f9Mo+ls
	 xRpenotcxfJT5aqRCt9mQ5BBSb1Ze3UKicLYxHNnw+k1vyHZkdfIykKeIWr0sj7uNnN3T
	 RlaD36kN0cfAyXBJBOrhdaJA0hn5ZxHipCl/c45wywIMZyUPw9+zqqdxHbiErrlFaktH1
	 x7xVsg35tLQ/OwDF6ysmAYOsiVDf9gGoes+dCEfbI5B56Xyv7Ggxf5keQLVim6UKS8g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794669478;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Subject:
	 Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=hGfcpMZoPCPDGfi8c/bBBkA6J2WYhjKbx804Qu8O10U=;
	b=VJQhZxwTBlUF7GPaHr1h32F/aP198u0kCdPl1Y8rimvJRmJ3+bBnvpPXgsbaR/mHrMNW
	 La+afUgBghNjbFI4ifz+svYz2SSh2KKvFFN9ZElrmu18tFd0mAjspmH2G0UScuL7vh8+h
	 xCriiBKLxYrzXMp8Y11TGGmZSN4njZ/SPV/KvJYIZg8J0+/2EqmyfwCQlxziyQ5ruvKta
	 fVOrUlpUuWN9CdIrfeLIqCpnzDTbE5HYmEgyzX3iA7iXVzz9KtguTwfW2WlzS4z/EGUOJ
	 D7EXOXIfvEG36c5hO9xRxW2pxmVsJlDEyHrr8UdF3L9bFiSRCzVFUzRyVNeRW6+wycQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=c730pjlk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90321606A32E;
	Sat, 14 Nov 2026 15:17:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90321606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=c730pjlk
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 3B72C201FF7;
	Sat, 14 Nov 2026 16:17:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794669474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hGfcpMZoPCPDGfi8c/bBBkA6J2WYhjKbx804Qu8O10U=;
	b=c730pjlkINeTdEe3EbRxtpXedxz40tfgQW5rtX5Mti57g84L+ADuW69neN92962yN81VTl
	5VL+OYMssf15M78vOzNLxQ0+AliNlRtoX7x3bqDot59eDz40XYEEXlTvdO+mULAF7cAn23
	RaLgtd5kSHkxM6rxqHdoo+T/F78tMAAuurYc5GaLm1N7d3rnvk3GGpAv/qHJgbNfou9ET4
	7r/LhlwImrc1HfPRHV0n2MSpwei83sPpDi8LJsHF2jl/22Uqx6rVFtt5wIzjasDoNmURnW
	jd/84qRLTURf52EK5Ti6TAskbgMHmW6B5omsSt0HcUE/yCVkWp2RcXePuK22wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794669474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hGfcpMZoPCPDGfi8c/bBBkA6J2WYhjKbx804Qu8O10U=;
	b=T2ppW7afIJQfaovdnqqLiniiuZODw2kZANQSZ/2xziBLWLC3R2of8BQZGd75mD2+5uMjVi
	4hNeNJG8w0urGN4AVa50VQ7lFh5kolJVIk1s2kZp7wz+OP18iCyJZJxN2sD+jIbi7ta5YL
	5iGcpwLCBAUnlC0T5Gest7JzBTD1ag6J3DGuEdgfBGj+2FfUR+Rta+F/4K0Xl6p+Kv4sK3
	2ivLMnxWbAlv5fEVG6hEuIocSUFQDzEUJwTsipDrT6YTb/ict9kCp7ZJNQdOOtyTAvZZjl
	wcX/6AqTMrzLI4ZQRYUm+McPlZLdtPzYJYTfDCzZuBCzSFdgosS3d8Q240t6Jg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794669474; a=rsa-sha256;
	cv=none;
	b=NhVrXpGm9vO3/StlyFfMJcX6AB7aS90T8CiqCt+xZbI8lwQ8L19+MaowZrvznJ5DoYvsPZ
	VGfl2fCgy/JblqLaMuWCzn1B9o5K1WMsKIe6esbGD8ZLG1RzIle9l6+xylZwg+SKva3kZj
	vXlM8iYEErs4jMK624K4CnvT91yYDafkUhjRZDPAyhWF0wmFwBTH7xkni7OlICVMxC7p5w
	4LGeoVD/4+K+BACPYQ64lh5l4CrTgaGrcBEmrLToZzDnRfK5ysRTV8zyNCCh9u2i4BO8SF
	KPHrvzZb4Me8KMTf8HH9le//m/b1koI76D5vHElEqTcBg//j/dxRk5wRAwj0bw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xSFVq-0049oB-0S;
	Sat, 14 Nov 2026 16:17:54 +0100
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id D1B2E5EBB2E;
	Sat, 14 Nov 2026 15:17:53 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH can-next v7 0/6] gs_usb: fixes
Date: Sat, 14 Nov 2026 16:17:39 +0100
Message-Id: <20261114-gs_usb-fixes-v7-0-58b6341b1c08@pengutronix.de>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33SUW+DIBAH8K/S8Dw24AC1T/sey7KIHJYlYidoX
 Jp+96FdssaZPl6O/+8Ix4VEHDxGcjxcyICTj74PuSieDqQ51aFF6m2uiWBCcyYUbePHGA11fsZ
 IhWIOyhKAs4LkyHnAtZETb6SpAw04J/J+68TRfGKTFm05e/Ix9cP3Onnia2J/yMQpo66QaIyVt
 gb9esbQjmnog5+fLa7+JB4JIgsKlJWKVYUrxK4A94LeCJAFqHXpuNOi5LAryEeCXO5QIRgNmjG
 1L6g/gbNyI6gsWCWslZVkVu6/g74TOGwEnQXWMKiQG2cL+U+43lY14NeYv0L63aSpI9Km7zqfj
 oeAaV3rS1f7kBPXHyXNYhpEAgAA
X-Change-ID: 20261025-gs_usb-fixes-250f38833107
To: Vincent Mailhol <mailhol@kernel.org>, Peter Fink <pfink@christ-es.de>, 
 Eric Evenchick <eric@evenchick.com>, 
 Maximilian Schneider <max@schneidersoft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, 
 Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>, 
 stable@vger.kernel.org, Shuangpeng Bai <shuangpeng.kernel@gmail.com>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>
X-Mailer: b4 0.17-dev-d7211
X-Developer-Signature: v=1; a=openpgp-sha256; l=3107; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=FqBOB595rLcnOqUrh525RBoZTVVEcrGTCz+VLIfFfmc=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsj6UT3j/+X57gIPFwitaL+x8HDjzupXDX47L4gdeKe2b
 M3nOxpTIjpKWRjEuBhkxRRZlv44oSgQ6FDa+zJhEswcViaQIQxcnAIwkde/Gf6KiM7+LJJwJeHq
 aYGAzFmyZ5iFX73s3/fhKLvS3ediO+6aMDLsN4jkOfXSaLFPx4R9W5bPLTIrW3/7pdgflfXyZcb
 nG29yAQA=
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

Marc Kleine-Budde (4):
      can: gs_usb: gs_usb_probe(): init netdev completely before register_candev()
      can: gs_usb: gs_usb_receive_bulk_callback(): check for overflow flag if SKB allocation fails
      can: gs_usb: gs_usb_receive_bulk_callback(): add missing call to can_rx_offload_irq_finish
      can: gs_usb: properly shut down timestamp worker

Shuangpeng Bai (1):
      can: gs_usb: fix hardware timestamp state for mixed channels

 drivers/net/can/usb/gs_usb.c | 170 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 128 insertions(+), 42 deletions(-)
---
base-commit: 573af801552999954caa8347e4490b04cf4763f0
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git master
change-id: 20261025-gs_usb-fixes-250f38833107

Best regards,
--  
Marc Kleine-Budde <mkl@pengutronix.de>

