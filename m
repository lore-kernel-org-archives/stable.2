Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795373338;
	b=yDfTvQ+VmQYRnmu0UvyW3xydZA1PT7oxx5Wq626i9ZEU5Hqagwu2Zlx0W7JbFJ4FRrhM
	 cLxLgC7PYOt63A3lH7x0c/3FcbZvvE0u27Kza8mVsHzZ63999TcCpscEJcMuADXaUkArX
	 gAFrkWopkDtS0HrbgpcdbD7z23jjWi7CgaqtqwIiwncCJiJDjdWxP4l6LPtOn1LjgSHGd
	 0lVXcErS8KyEv+AG5mmkhfmyu4ERX03iPsGhNh3xz/xmeJ9WRMznQ6NDVgRbCbjn07R4U
	 D34/s57/xxOtmLvy9MD8dQ2gliwxAPMG3xrUqAn2gqGIfuCZN6zjwL+NsE4QB/2kVpQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795373338;
	h=DMARC-Filter:Received:DKIM-Signature:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Y3HpjTOkReQYvQ1UIn001MQTOhcP2/JDb9H4b5BZKBg=;
	b=k5uscSHyg9E5pKuMX54BbN7JUvzOwTHeTDzlyA51jiGlUOA68RNCzCC/KoPbDjx7NCKC
	 mIfbVHixFeUXeG85f8YGuCygzp5Wy4+M0UQr+WyUfL8LzgfL7idmY2LGe1nxyvSaojyPF
	 wdWh8h/0wd7CKyGEFVFhWbQ0rSpmxn3dsPCVwYbrMIqfi2nVukPk+9q7LKdA9qxN1b9Ho
	 TL0v3dy+73T7cBBTBD4whYCCp06/KRs3tnbqPH1Hv9u6eXNIxWSsTtTeo2PFJqvjK2aM3
	 cHfsVmYogsx67+sb5X61GfpTz4dxeNe1G+SsJ7ShpSDOKB87PG3tU0keZFhgEnHRVoQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Z5tizPNi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AE7606A32A;
	Sun, 22 Nov 2026 18:48:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4AE7606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Z5tizPNi
Received: from hardanger.blackshift.org (p20030102af17cb0015d71b554e0d6387.dip0.t-ipconnect.de [IPv6:2003:102:af17:cb00:15d7:1b55:4e0d:6387])
	(Authenticated sender: mkl@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id A7CB6201BD1;
	Sun, 22 Nov 2026 19:48:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795373328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Y3HpjTOkReQYvQ1UIn001MQTOhcP2/JDb9H4b5BZKBg=;
	b=Z5tizPNiFgq1VICZVfomMVnXhy4kq9CeoFlTPfxxHjKKO4s34OwBSktfZ8lIUoY2CNKylS
	tQL0ptd+SU2xqxujqf9BqXEq4W67CBefgKXlvTNiGmhuX69SmoFCacBkLmwhk61gKxELjo
	m4oqi3byfGAHxOF9u5jc8kwrPDI1mJKP3CW8ZN0Rq9rkCcj1NTustsJxNNBnEFn7Wp3y1e
	5jZwGvKAZR3r3rS6f/KJH7AzgFBaUmnHEaGG4gnP+uUKPc/NZh8r23RCFltGEByIBwLUlc
	sLjplRCsycBiYUOwn2HCvmSf2Nin7lhIUX3z1D8YnWiXyvOL9501eukNAhZ29g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795373328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Y3HpjTOkReQYvQ1UIn001MQTOhcP2/JDb9H4b5BZKBg=;
	b=d0XvZf7ePYk4NRsw/2Y9BpSRA2oTVhWJ6fbdwKJtyXInMyfiRqBS8vylSftRVlScoVJLGV
	WI3XPkWLe5gYTGNE8fx7oe9wtUgBJdAQrDkBu3atD5eLMw5ynX6MLmsAbrp13EMAX2akmU
	oecaKwtj2IDSo3kt+oyx4u1kRQxXFsc1tBDzJb9QF35Eg7wm/5g8xD7KdhZ57PaQlXkCNm
	29ejn/VUH4Tdf/nKRhToRoY2kfhlRzp3e9wvYBlmkPGYtN7wX+PFTTSHY0oJCSfDByrraH
	8taBeGEnZCzhF+33G0UfmK4P/duoRSx4Nc9jKgavigow882BXNJzFgKRiUKhjQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795373328; a=rsa-sha256;
	cv=none;
	b=AlAN4Hw64S13tCFlIWfmQt3vaOJNwEVdgwVQ7LupMc0wCXFh6EFsduoQvI/hlAO7nLvfW2
	xLXsBowoAHenHJp9x0vJSXfPIdgNGlop4PjZkSeeSyKjTIgj9l3n1piMdjOrBQHCANqvGA
	VdzYKApi83jsHdOP8p86KxXw44tv5HMbuLWZvAYf86eorrp6oRX8wAZaxHlb+keF9jM24f
	bsyJYiPlaO+VGoR/te4TgTqzEQ2YARYQvndpyYayXjlXMucs14yohPLgD8R8+9arRdWsqL
	ACKkrqsDVkiGI5bCr61F63vF28hrV/t944oGg656LHQwKYwTG0cCDJh8EcewjA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=mkl@pengutronix.de smtp.mailfrom=mkl@pengutronix.de
From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH can-next v10 00/14] gs_usb: fixes
Date: Sun, 22 Nov 2026 19:48:24 +0100
Message-Id: <20261122-gs_usb-fixes-v10-0-7c165c35d04a@pengutronix.de>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33SzW7DIAwA4FepOI/N/AZ62ntM0xSC0zKppAtJ1
 Knqu4+kkxZlqEcw/gzGV5KwD5jIfnclPU4hhS7mBYOnHWmOdTwgDT5vEA5cM+CKHtLHmBxtwwU
 T5QpaYYwQDCqSU849LoGc8UaaOtKIl4G83yNpdJ/YDLM2nz2GNHT991J6YktGucjEKNC2kuicl
 74W+vWM8TAOfRfD5dnj4k/8kcCzoITyUoGt2ooXBbEW9EYQWRC1Ni1rNTdMFAX5SJDzHSwKp4U
 GUGVB/QkMzEZQWfCKey+tBC/LfdArgYmNoLMADQiLzLW+kkWhWgtyI1TzK0x+g2SONWCKgnkkm
 Pk3NVMKuMt9cEXBrgTONoKd++DyvpfGWKn+Cbf7wPX4NeaJHn7n0dUJadOdTmHY7yIOy3C+nOo
 Qc8btBwMeyqsLAwAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4988; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=EtMLaqxTRfggKJlSNKKd3OzGUuiPSkROFs5GAFYUXMU=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYshmtvi/x8XruJiZ+JPm1xqb7hzR+NEiYmPdybKQadL+4
 g8+l6bJdpSyMIhxMciKKbIs/XFCUSDQobT3ZcIkmDmsTCBDGLg4BWAiswUY/ilPrrJ/eJ4jLCRs
 7xPRPTeusLv7RBbUM02NuPMtipHl8z9GhoZV5nn9745IGOa2fgv27GjecOmw+RbNxXEXXsjP1s6
 cyQoA
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
Changes in v10:
- patch #5/#6: fix single opening curly braces problem (sashiko)
- patch #8: remove net_ratelimit() (sashiko)
- patch #12: new - mask invalid parts of CAN-ID in TX-path
- patch #13/#14: apply host_frame checks only to RX'ed CAN frames, not echo
  frames (sashiko)
- Link to v9: https://patch.msgid.link/20261121-gs_usb-fixes-v9-0-db121d488945@pengutronix.de

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

Marc Kleine-Budde (12):
      can: gs_usb: gs_usb_probe(): init netdev completely before register_candev()
      can: gs_usb: gs_usb_receive_bulk_callback(): check for overflow flag if SKB allocation fails
      can: gs_usb: gs_usb_receive_bulk_callback(): add missing call to can_rx_offload_irq_finish
      can: gs_usb: use spin_lock_irqsave() instead of spin_lock_bh() to protect struct gs_usb::tc
      can: gs_usb: add support for context analysis
      can: gs_usb: gs_usb_receive_bulk_callback(): use dev_info() to print re-submit info messages
      can: gs_usb: gs_usb_get_gs_can(): introduce new function to consolidate validation of struct gs_can
      can: gs_usb: gs_usb_get_gs_can(): report channel number out of range error
      can: gs_usb: gs_usb_get_rx_data_length(): new function to consolidate validation of host frame
      can: gs_usb: gs_can_start_xmit(): mask invalid parts of CAN ID before sending
      can: gs_usb: gs_usb_host_frame_header_valid(): drop invalid CAN error frames
      can: gs_usb: gs_usb_host_frame_header_valid(): drop CAN frames with invalid DLC

Shuangpeng Bai (1):
      can: gs_usb: fix hardware timestamp state for mixed channels

 drivers/net/can/usb/Makefile |   2 +
 drivers/net/can/usb/gs_usb.c | 407 ++++++++++++++++++++++++++++++++-----------
 2 files changed, 310 insertions(+), 99 deletions(-)
---
base-commit: eb6d6c80d35449c27471b1874f13066c09a8964d
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git main
change-id: 20261025-gs_usb-fixes-250f38833107

Best regards,
--  
Marc Kleine-Budde <mkl@pengutronix.de>

