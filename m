Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794564538;
	b=Ad+y9uK+/dhC6kWR1wx6NbwsexQC4xeeSggrOn76kLwp38/WwiZeI6TJ/b9DcP0Z/xUL
	 Gu+iQJRHGTadz8mg3Y9nzRzZTTKd6oWTSMQ0jie+ivgNRudFJQcWjCUYnHj+WMxzzm0hh
	 5twPU2YaX/MbpJOQydvRtJIDhQJVx28CMr1evdtzhwrkf0RkECI047Z3KBRD5resBmA+0
	 XuldLHotjJ6wDHKX5SuJF2CQtTOZGKW43AhJ03cHVI/6lVJC0/vF1dTW+hvsl3KEnUBhr
	 q6w2EHUb00lugBhAkd1H079CsKV5lf8/8rnWZDFsoR9ccN07vCxwxW8XYgKtQdg8+AA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564538;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Subject:
	 Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=5+e3CHYuKJEwV1NPgCii821mpXJsmbUYwB6Z7Qiqpg4=;
	b=EjR2LVgJ0hZRUue4NK1sXIttNN8fRnXLOwaSagRyLEHrpS6SubMTL4YjU9xZjhkhOFfp
	 OtT/VChS5riC/WY9CcwHvuXEO4/ekZM5JKf7Bog8ze/1opRNAEo9kODvVI3xQawRWEPPg
	 IeuFt0x/hee2aAwFqrQEW/X3iurl+rYu7ipdXmswSzuHqQiY+/fiYbqMrAjoa5PuYKzl3
	 /sesiAAp2cNtwFEUcSPfVgqYdtkviAuHSYsicg21CG68KXhr2Uvlrso32I5P1ZiRt9DYz
	 /kGMVyfxzlF4qXpKoy+Satu4NLv+e3kkvWTgXVQskf82jNvFeM3eSquua6cgRWn3bEg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=bEo4La3j;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A85606B100;
	Fri, 13 Nov 2026 10:08:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4A85606B100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=bEo4La3j
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 69199200668;
	Fri, 13 Nov 2026 11:08:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794564534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5+e3CHYuKJEwV1NPgCii821mpXJsmbUYwB6Z7Qiqpg4=;
	b=bEo4La3j3rn7iB6SkZ0HRlzwUmzRChw/xmTC8/GfKL5VXM6LBkAcolwd3Odpdu0DRHKAN4
	Vy+CxCsBLQlsuJFqhjMdDuOSZeObXhdF4pkzKMBzJ31keFyuTKhJuc1vR6OKdN4V+0gYDm
	sjrXtnSR714Ds4llr1JgsxKFUD2X31U4n/A4ovzjF29Si2NDmR3yhX3x4vKowEYeGhTIZX
	bRTfYSziXP1LHqoyXubnhR0qJgcObpwqGerevMZHq3fj4CweZ64krRB83FrpwWzZ8ZJ1Wq
	EEfZwQ1AD+byphZ82paZQPXpa7d+F/ffdK0HrixgBtUblPWK4P6Eh4+xSzZOUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794564534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5+e3CHYuKJEwV1NPgCii821mpXJsmbUYwB6Z7Qiqpg4=;
	b=GPBb1TzRyVdZYIj4RWhH9SbZxQSaf8aoeZYb1ZRA9nPFcxQo0H44z3eQOMMbpjhCwCLpdy
	lx6873p5hNBr4Mps81ju87LOwrDrPkHdB3C2aSH+KPPXvpMYbPFipHKSTeChTMmjtfOOFg
	bsA3JW0IZ8ifkuCjji2K7IjzsL+MSyJvrbAzMLunFeQq1ssy0GJL0ApeCXsDUNrANKZ1cG
	5yp/RULEzRRdpklL97cZHtPIWtzhS8oBSfqT3hR9iY7iAe1ph1QEWg5WSxawUTWaFjmVfU
	3qmNHnOySTzHJFJhYDnWYA+Vi4hyCJRjC3Pbx1X8/gJUhbylLtOaeVcyh/MkUw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794564534; a=rsa-sha256;
	cv=none;
	b=DnY6Rqj8GqddL49PUZyghixIC/2UAXxJMkKeq8d+ob/TKjUJFDiGu3dYxz8O5PwO5PVhxK
	mWXLuAVG8GL5aaH5SYGWmSLQqT2FrWpQ2m2kQXcsdvxRoRrfat8mJcTGrk7+Ow9WIrwc9I
	LyK+hapr2OtbJt05OtWeLPT5t5dmVRpx+hbd5nvKRt9eCtDV6OZmgPFDV3n45UcMvatP82
	LZbeY087k+cy+561ksz4I5IUBVfDpdeywojVdt6Kt4OnZkzUhS4XAawHxSuY64KrafuZUb
	zN4mTcbiomvffFsi/ldubQJWRbhwM82vDAiPt2JMU/bwP6sis6ujVYer1MufOA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xRoDG-003ySE-15;
	Fri, 13 Nov 2026 11:08:54 +0100
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 0897B5EA84C;
	Fri, 13 Nov 2026 10:08:53 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH can-next v6 0/6] gs_usb: fixes
Date: Fri, 13 Nov 2026 11:08:37 +0100
Message-Id: <20261113-gs_usb-fixes-v6-0-0c039e1bfd74@pengutronix.de>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33RS27DIBAG4KtYrEvL23ZWvUdVVWAGh0rGCWDLV
 ZS7FzuVWqVWlqPh/wbNXFCC6CGhQ3VBEWaf/BhKoZ4q1B116AF7W2rECFOUMIn79DElg51fIGE
 mieNNwzklNSqRU4StURJvqNMBB1gyer910mQ+ocurtr49+pTH+LVNnumW2B8yU0ywqwUYY4XVX
 L2eIPRTjmPwy7OFzZ/ZI4EVQXJphSRt7Wq2K/C/groTeBG4Vo2jTrGG8l1BPBLE+ocWuFFcESL
 3BfkrUNLcCbIIVjJrRSuIFf/3cL0tOsJ5KofMP3cwOgHuxmHw+VAFyNtRXgbtQ0lcvwEO48TSA
 gIAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2702; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=ZtVctO8pqjPy09Axuc4bMUqcSLwq2uJhcUZOKE+RglE=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsj69nBt3UF7y5X67G4O/MtaPLfPXPPSqu2K+CbeUAVB7
 WdL2TX+dZSyMIhxMciKKbIs/XFCUSDQobT3ZcIkmDmsTCBDGLg4BWAi91wY/kpLRCv1cqUW2Ane
 +tZruLR94tKienXZb3cX3TiW0uxrVsHIcE9T96ibrJSOLONXC7meozwPzH+ITN1ya8ekhpnfU3z
 u8QEA
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
Changes in v6:
- patch #5: add missing initialization hw_ts_supported in gs_usb_probe()
  (sashiko)
- patch #5: work around race window in gs_usb_timestamp_start()
  (sashiko)
- patch #5: start time stamping worker if the device supports HW time
  stamping, if least one interface is brought up
- Link to v5: https://patch.msgid.link/20261108-gs_usb-fixes-v5-0-d52dd4940d46@pengutronix.de

Changes in v5:
- patch #1: add new patch
- patch #3: gs_usb_disconnect(): first unregister_candev() all CAN
  interfaces, then call gs_destroy_candev()
- patch #4: update Fixes tag (pointed out by sashiko)
- patch #4: use stats pointer directly (pointed out by sashiko)
- patch #5: add new patch
- Link to v4: https://patch.msgid.link/20261026-gs_usb-fixes-v4-0-59e3b6360053@pengutronix.de

Changes in v4:
- patch #2: fix cleanup if register_candev() fails (pointed out by sashiko)
- Link to v3: https://patch.msgid.link/20261026-gs_usb-fixes-v3-0-3a68f1f62813@pengutronix.de

Changes in v3:
- patch #2: fix cleanup if register_candev() fails (pointed out by sashiko)
- Link to v2: https://patch.msgid.link/20261025-gs_usb-fixes-v2-0-535d45097f72@pengutronix.de

Changes in v2:
- patch #2: add missing cleanup if register_candev() fails (pointed out by sashiko)
- patch #3: do not increase rx_errors during OOM (pointed out by sashiko)
- Link to v1: https://patch.msgid.link/20261025-gs_usb-fixes-v1-0-f74ebbd4da36@pengutronix.de

---
Ciprian Marian Costea (1):
      can: gs_usb: gs_make_candev(): check can_rx_offload_add_manual() return value

Marc Kleine-Budde (4):
      can: gs_usb: gs_can_start_xmit(): don't leak uninitialized memory over USB
      can: gs_usb: gs_usb_probe(): init netdev completely before register_candev()
      can: gs_usb: gs_usb_receive_bulk_callback(): check for overflow flag if SKB allocation fails
      can: gs_usb: gs_usb_receive_bulk_callback(): add missing call to can_rx_offload_irq_finish

Shuangpeng Bai (1):
      can: gs_usb: fix hardware timestamp state for mixed channels

 drivers/net/can/usb/gs_usb.c | 187 +++++++++++++++++++++++++++++++------------
 1 file changed, 136 insertions(+), 51 deletions(-)
---
base-commit: 573af801552999954caa8347e4490b04cf4763f0
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git master
change-id: 20261025-gs_usb-fixes-250f38833107

Best regards,
--  
Marc Kleine-Budde <mkl@pengutronix.de>

