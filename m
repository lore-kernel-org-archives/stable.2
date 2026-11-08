Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794171225;
	b=aJ1PTLjdDxRioI25hf823Z0N+O8vNkJ0A2q7r7AMumgq3gG3qcDdk3Ka8zlvQzJTeKLd
	 xibkYqhtnIkkbr/ikzRdBmLNJTxo8RP+ISKHh4GVnELjZ6esellrOOYhGy6w+le67VUMo
	 2ubg9wlfkHbSGwhqwK2ONJQxnqmQ9nRJkw35b9BMmOfggyaw6sFD/V91Jb2EKbJOO1IyY
	 TFogXYHzANwjpo0jrvriLb4w6SMkmtS7nMbkC/mV8MAFCYwC3OfaWYZFw+DdXwM9ecUIi
	 RknVBEDaZgE0Sl/D3X+LF31ofwNbngCqk6DOUycW3bFK+8dZ4/2V9jg6xaaocrN7wtA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794171225;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Subject:
	 Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=hQiVlfd19EixxDZ4Zmjlf7g+6tobK8NjGi6Og43YK2E=;
	b=NAwiu+RboMfg/R1mzCfsDDgHt/69dAAQT2RHJ9JnIrI2yv28s8XsecUAe8zOdygE5VVO
	 qL4pSd/+q++6n93PcmRolGblguFjPOBuZuDH0fbMOiOf9aVi82A+dBAh6ICXGsuIqzPXz
	 a9glI0jBM06ttnvL7bcQb9BjRQBGbutPKyJIAXaSYI7WU9ZsOwMjniDrGrpdnjbG57gpl
	 Nn9ihmZYLeWu0ABXXVzHPsTRIvljFdD28CF+ABlSWZNekjQCIH1UCOmjh4LeKnb2X3rK8
	 YlpP6qdv/d/mjePkgrNvqJaU8tUA4k+64smdqnWVXs2PtVDRDL9yetud2E0LO/bXSRA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=TdBvdVme;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3BD606A323;
	Sun,  8 Nov 2026 20:53:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC3BD606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=TdBvdVme
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id C0465201693;
	Sun, 08 Nov 2026 21:53:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794171219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hQiVlfd19EixxDZ4Zmjlf7g+6tobK8NjGi6Og43YK2E=;
	b=TdBvdVme0p+eHcYdQbDNCO/y5jXhItwmMe0q/qAxclzLgj50rGy4Dh7v6XHra+nThbusvC
	nO9GFcwYh8ZjPRSh8enewXUXUi/tVJj30WFIvOVw8h6ZWh+me7LFgEdblLK2ZkC8+dUPez
	C82rwhHFkp/kcD+kfBoJhmkHyaZLb392ilToucTZrbekXQqUgiPrIcbRyN3gLX15gjRTsU
	ChXSbUzxGyu3NP1bKQuwgaqxvVnWraxzDP+WhjMs8fu+wk2b1WoTr/60bVD27u45bGMpEz
	woLgyC/Y5TJmsFzyHVrbs/7UXUwEXsmfyKo53JRrfokOTkZCvAJkedVa7IWb9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794171219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hQiVlfd19EixxDZ4Zmjlf7g+6tobK8NjGi6Og43YK2E=;
	b=QzU/GUz9UVbiAncck2fp0aLQCv1OJ0ZkeW4HgKwtlFdE798ntp1tbToxZ1qvLFlHELLz7b
	MKlg4HL3mDo8PcPFHJb5xalow4kyWghEpc4YVxoi9WkC8TVfUQrHpTo0fC50mOOEEjBlqe
	dkdFF4bxcutchh+kLrYRMbSZ6Pwp6YxLU3zgK6jRBsNjLlw9quqvbOA1wm1CANw9ZV55sY
	ZDL0f3w+U6c66DXuqiJOyqYSxRi/WxG3Gk/R095RQXc7mpEpBNddF1nPnS7o5ijKYyxVHx
	+6q4q/jqUCLKzITQiKU6NWG65vxCePw8Szvst+Ff+7DRLpK4oe18L4yK4iKQSg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794171219; a=rsa-sha256;
	cv=none;
	b=TcMDpRPU3Z6WN+YsE8inWacPiV0hmJG9MwQS137FJKQvm1ythT6jBimNGqtpUhWemUhNaY
	1vuxCemAZaIZKB5EqaCX8sbrqvPhRXoKLeowC6f2pLvZnBcPDTP83yJ2L6QkMyA4uZuAXg
	/yTA+TlGD3GXtIeEL9Ru3tv+0icK1m9FKZGKO4Oy5nfYGJaovpmWTF0pVI8iIaSdOrr7hv
	9luwjDmWv9vP/463O+CAhImDtVX/FWfEQq379vL+1h9tgf8M1aIztWxTpYY/EGqVT7i6Xw
	bf1lN/PnW4tu27RzgtXXNt5Rke3gZlJPWk8FF8ke9QjejxXLZuVcN941qG1Ymw==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xQ9tT-003EmH-25;
	Sun, 08 Nov 2026 21:53:39 +0100
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 477E85E3E70;
	Sun, 08 Nov 2026 20:47:37 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH can-next v5 0/6] gs_usb: fixes
Date: Sun, 08 Nov 2026 21:47:21 +0100
Message-Id: <20261108-gs_usb-fixes-v5-0-d52dd4940d46@pengutronix.de>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33RwW7DIAwG4FeJOI8NMJC0p73HNE2QmJRJIS2QK
 FPVdx9Jd5i2qEfL/J+RfSUJo8dEjtWVRJx98mMohXqqSHsyoUfqu1ITwYTmTCjap48pWer8gok
 KxRw0DQBnNSmRc8StURJvpDWBBlwyeb930mQ/sc2rtr49+ZTH+LVNnvmW2B8yc8qoqyVa28nOg
 H49Y+inHMfgl+cON38WjwRRBAWqk4odaleLXQF+C/qPAEUAoxvHnRYNh11BPhLk+ocDgtWgGVP
 /hdt9TREvUzlD/tmiNQlpOw6Dz8cqYN5W+jIYH0ri9g2qSFzXwAEAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2297; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=X4BrHf4PUCsESdJSVClM0SOAQpAP05QP3NA6EKX5al0=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsj6cP/h/8yrnF6LGDLa1bnzq4Tn/nP7Y22cNe3jbc/lp
 ztNnkdf7yhlYRDjYpAVU2RZ+uOEokCgQ2nvy4RJMHNYmUCGMHBxCsBEpMoY/oe/ef5GsqjFdG+J
 nor564dn9oj4LdWS1IqqLF36NuEsbxrD/wB54ew3vdJ6xx5qPEsz//rxgPNOl7Vbk5duceAv9X/
 azwAA
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

 drivers/net/can/usb/gs_usb.c | 143 +++++++++++++++++++++++++++++--------------
 1 file changed, 96 insertions(+), 47 deletions(-)
---
base-commit: fa5196392691051963726787944db872420dfa75
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git main
change-id: 20261025-gs_usb-fixes-250f38833107

Best regards,
--  
Marc Kleine-Budde <mkl@pengutronix.de>

