Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795300582;
	b=zrjjGDkyoyceXn7aTlQejdRvUZDm5y3WXQ5JnjP9qE4kwHaLHuHgZS5IEjJJi6pmwD4+
	 QVJG4Sj0+5nBiSZ2/CooZioxY0QwQXULsS/yhrrl84/lmYl718Xos40NC+Fyh2rrumsnc
	 H8csCHdZ83GZv+zUdhFkZZO23vaQekBfH2HYi4fm604y7dD7NSZgCxF3XOTnysgwMTGgC
	 mTDQdiK+AuWocUSq6wE16OVo9j/v2/k5UtvxDIdXsDUA4DS/YEMIr0yRDywXcFFc9kEUE
	 bc89IMq2TToA01pgaPDbfHEuIXXhnHrX2QdvzrKPro3AgREsuKqZj0hVQG96LAL6fmA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795300582;
	h=DMARC-Filter:Received:DKIM-Signature:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=dWURxB22X8mmPjRlj49EXuz1QVxjX/+CF6IEME6A/Rg=;
	b=ZgJ7/sSJZa3PE43MLMFpWyT899o1tPrJQpLw7qmu4OEEp1Y2phyrE+j/7ygiATGgBSEg
	 ra6zMoJUujM0AhR5pafOmcPmWCYgPJApOtM7BW3cNFRvyzj1oRYL8EhL8I3KWZDqem94U
	 fvYlMDqaD7ZIToPOzu630FqLwW8pjans/vN36f5HemRz1vOjb7ZkuC5/yGYMsgheMEhk7
	 EBHvq2f27XtreZs5xIMs6cF0/tccS8G/CDvr4RZxT5V2KIpeaAYQ26Ffs5PxpLvvBDsqa
	 c+GJcVS2vawtWiG46zYOigCpkv3sxXmxrvRArc4PStANWsnJz035NbwI4EtNqJUsjRg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=hHR5V9tk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF07606A32C;
	Sat, 21 Nov 2026 22:36:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDF07606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=hHR5V9tk
Received: from hardanger.blackshift.org (p20030102af17cb00849b19770537dbc5.dip0.t-ipconnect.de [IPv6:2003:102:af17:cb00:849b:1977:537:dbc5])
	(Authenticated sender: mkl@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 89FCF201CE1;
	Sat, 21 Nov 2026 23:36:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795300579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dWURxB22X8mmPjRlj49EXuz1QVxjX/+CF6IEME6A/Rg=;
	b=hHR5V9tkw7nsOmpnlAVpA2WwbJzj3nUh2iUDVCg4F/5J8ch1rxvKNfNoVlEDtlPy9NZIZk
	BcT3SaXj20R79PHJbTAZuEg6G2khB6v+TE+QAA8QA0ZzoubJW4rG5KKuMhJTczUnVZ+6ZX
	TfDSmhn65xnD2+lBhybIZeJqPGuiKulzG1b5SZL+0/0bvibxk9/VzZgBqAdreIcHN7u8BR
	e9BRbhh2c1OMUUoJrBKhW/fjmLHp10/hVfiM61XrmwTEicrO1qHPwmneUnaK9NKJTZpy8a
	c2ryfy63zfKeT+bKyq+zfnb153it7NlfWgHb7Xu9plr6odQhTe/HU9PI8QKbSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795300579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dWURxB22X8mmPjRlj49EXuz1QVxjX/+CF6IEME6A/Rg=;
	b=CyBeZTQcy8B2v9hSPcf1vGZTW7Tz0YkdnkwfyqfMOAWHTbgAYAtaltPYod5pPx1vaJsqI+
	PtzFX/5QJKaGhpEn7iYk9uCOSEaVYioUP6OKGQm4RCtNNVXWsmRfQ4K1ZsZMLFJLYLOw1Y
	vC42cAQWGmBFF5Z8KKKGpqUqyfTDLBOd4jrGlvC80xk1eJNyoVINm5K0OCeBPh89u4OnzJ
	g3TVI8lv1FD0cm48cq+kacyBM3vgc5H6kV806ycNyeJlxIPzH1iHuqh8Wg7OrLHeE1EYpP
	SsaaeVJ0DuZgVwLPOqgCybCgW+ohUZzHGEr8ItZaxEY2QzORovHgxpdU7pkRCg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795300579; a=rsa-sha256;
	cv=none;
	b=QajCEqeEy+2OG+q+UKx9RyD49zENftiSovR1nbisT2Q/89gWAHzVY/aM+kX3vct1VO081c
	3/icjPn6gFCsdXhOhoifHOT2cZTgpMS6ANpYc0VurZA0nm/YJTV0RPRTNtx98n29fajieS
	A1BJxTPPUnmLgDzAI689ef/sxL6UKR6K0+DOVDJ564MoW0b38Vsq2nMkuLe0FLXNZz3J5e
	h486dAToK92/IhlgL1jQs6YcCJuMOkWRm1ZAvHJitGScQxAsUiY52eDEzH3laKDGzvFgvA
	ItQmt36r4WTKVVrEoddC7l8y59At4Dih/Gt3YUFpUSLPLvjiE0dmqofRI4+PZw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=mkl@pengutronix.de smtp.mailfrom=mkl@pengutronix.de
From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH can-next v9 00/13] gs_usb: fixes
Date: Sat, 21 Nov 2026 23:35:58 +0100
Message-Id: <20261121-gs_usb-fixes-v9-0-db121d488945@pengutronix.de>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33SzW7DIAwA4FepOI+Nf0hPe49pmkIwLZNCukCiT
 lXffSSdtCpDPSLjz9j4ghKMARLa7y5ohDmkMMRyaJ52qDu28QA4uHJGjDBFCZP4kD6mZLEPZ0i
 YSeK5MZxTolFJOY2wBkrGG+raiCOcM3q/RdJkP6HLi7bcPYaUh/F7rTzTNaNeZKaYYK8FWOuEa
 7l6PUE8THkcYjg/O1j9mT0SWBEkl05I0mivWVXg94LaCLwIvFXGU6+YobwqiEeCWN7QALeKK0J
 kXZB/AiVmI8giOMmcE40gTtTnoO4EyjeCKgLpCG+AWu+0qAr6XhAbQS9dmNKDoJZ2xFQF80gwy
 28qKiVhtszB/hOut3UZ4Wsq65h/t8m2CXA39H3I+12EvK7WS9+GWDKuPwEVXmLIAgAA
X-Change-ID: 20261025-gs_usb-fixes-250f38833107
To: Vincent Mailhol <mailhol@kernel.org>, Peter Fink <pfink@christ-es.de>, 
 Eric Evenchick <eric@evenchick.com>, 
 Maximilian Schneider <max@schneidersoft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, stable@vger.kernel.org, 
 Shuangpeng Bai <shuangpeng.kernel@gmail.com>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Vincent Donnefort <vdonnefort@google.com>, 
 Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>, 
 Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.17-dev-1b309
X-Developer-Signature: v=1; a=openpgp-sha256; l=4530; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=ARmibvjZW9t5eVrSXqlAyg3NbGfn9kbgzVzKa+7MF4Y=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYshmkrnELRnpuXyn9PkJoiy28+Las401r59i4K6a2/JlS
 a1eVqZORykLgxgXg6yYIsvSHycUBQIdSntfJkyCmcPKBDKEgYtTACZiwcfwV+BacneQ0uXoArt5
 BxJVnFaKrJtx1nH5JDcZGfHp0+c9v8XwP1m3wZXjs1T5p6krDjA96Tn6ee2CNAUXtUyFSWF+Ble
 buQA=
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
Changes in v9:
- reordered patches, so that patches to stable come first
- patch #4: new (sashiko)
- patch #5: update commit message (sashiko)
- patch #5: init struct gs_usb::cc under lock (sashiko)
- patch #5: if gs_usb_timestamp_start() fails with -ENODEV, detach devices
  (sashiko)
- patch #6: gs_usb_get_timestamp() fix annotation
  (sahiko)
- old patch #7: removed
- patch #8...#13: new
- Link to v8: https://patch.msgid.link/20261114-gs_usb-fixes-v8-0-f615502b005b@pengutronix.de

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

Marc Kleine-Budde (11):
      can: gs_usb: gs_usb_probe(): init netdev completely before register_candev()
      can: gs_usb: gs_usb_receive_bulk_callback(): check for overflow flag if SKB allocation fails
      can: gs_usb: gs_usb_receive_bulk_callback(): add missing call to can_rx_offload_irq_finish
      can: gs_usb: use spin_lock_irqsave() instead of spin_lock_bh() to protect struct gs_usb::tc
      can: gs_usb: add support for context analysis
      can: gs_usb: gs_usb_receive_bulk_callback(): use dev_info() to print re-submit info messages
      can: gs_usb: gs_usb_get_gs_can(): introduce new function to consolidate validation of struct gs_can
      can: gs_usb: gs_usb_get_gs_can(): report channel number out of range error
      can: gs_usb: gs_usb_get_rx_data_length(): introduce new function to consolidate validation of host frame
      can: gs_usb: gs_usb_host_frame_header_valid(): drop invalid CAN error frames
      can: gs_usb: gs_usb_host_frame_header_valid(): drop CAN frames with invalid DLC

Shuangpeng Bai (1):
      can: gs_usb: fix hardware timestamp state for mixed channels

 drivers/net/can/usb/Makefile |   2 +
 drivers/net/can/usb/gs_usb.c | 384 ++++++++++++++++++++++++++++++++-----------
 2 files changed, 290 insertions(+), 96 deletions(-)
---
base-commit: d23de0bd0bfd62405e6c80028008838ec140af25
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git main
change-id: 20261025-gs_usb-fixes-250f38833107

Best regards,
--  
Marc Kleine-Budde <mkl@pengutronix.de>

