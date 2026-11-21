Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795300582;
	b=XEBFdVtMdEaT/KzcNvEMHJKgx1bhBR9LCE6AD5/Ao/8oTT6LrD36I73Kl1/u/Vdq27r+
	 GcbY4Wpyi6kqWej9XUelf90WUI8rOL+fS1d1oSSibDI0wp/0AE6/JzXAXtgpmMfUUwP93
	 F+InraVl2dswuYPeFqq1R0IzAfZF7VE6WPdHzepmo3wksFXz1vr/CIOdG11I4rB3jqkLJ
	 KupX4QmhVKrkrQRQx3vtALzCfRUJzkdXe1jIFiQ/IPoNWvmUmcylZVR5+jfjC1NmBu/Jt
	 DGoKIlaDPE2ceEEzdLJJ+wu6UAgwthzNm6HewOPN0GmjfXmakGl8bWqynqXY/x31TvQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795300582;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=OKYdjcTi5SSi/Cr26FPG21A1olMd93TOctfURoEDvZI=;
	b=4PE6A0yih09PLHi/esSldeMSHtzDnBP8zrSdcQ3wZOz8CIRWJUjSNQL4qpF3xIN+5Rq2
	 FfFbjrtKacINMCxo1JVOzS2iIQ+GVCL74uYyEgu66d/X4TFt8QB/o8x6GaGNvAht9/vj3
	 n9hfXQ7rZoxRC0j+fAkaO6ExAuKb/lg1Y0O58jp/oktptBPOBFbEiBpOjINl5OkrGNBY9
	 P0RLwgUVIZd159i2WlYjoNRFTcbdneiS2quc4cX7yIN4yy+NIgv5/fZr/5t1B2O4ciC50
	 RHjaw0d7PsO1jqwNQT5zfNdVy5zZFOQ7+Frbuc+Cln3rvRO1WB2zySyNhni0t8OqUeQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=ajN++7d4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F6E606A331;
	Sat, 21 Nov 2026 22:36:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33F6E606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=ajN++7d4
Received: from hardanger.blackshift.org (p20030102af17cb00849b19770537dbc5.dip0.t-ipconnect.de [IPv6:2003:102:af17:cb00:849b:1977:537:dbc5])
	(Authenticated sender: mkl@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 695602059C9;
	Sat, 21 Nov 2026 23:36:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795300580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OKYdjcTi5SSi/Cr26FPG21A1olMd93TOctfURoEDvZI=;
	b=ajN++7d4ZqnERox0vw/NRPBIw4eVxuBSIK+TMlmXua9BmbEMc5X68UZnSpyzAlZupX9tdw
	uFWil9muOqPs7+tfDPPBXY4+YM/Om952TDtO/GLk04vcERgHwSsZ+MSZvNBuna9bVx/jE8
	rTDcv5FWxUobfXZCJFn6GUC+JPOlXVH+UaC6VARvZ7xQkXCgTZPfcNEesyY707Uffukg8S
	lXe9hRJxykfnVEQmIE/psi0PrGXLGqzokKwHl51wuJRf2Z1tabUBBJNznHZZf/s/eLx+Hc
	n0CVh9IahOq1C6jusy0+UO0ZQmhkA51T/n8Btwl+PWYlqjGdIC2fugO/LItyMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795300580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OKYdjcTi5SSi/Cr26FPG21A1olMd93TOctfURoEDvZI=;
	b=EogAn0uQMErU8IdLrnXo0EJgLsiZgZzgYWbvMmbA4knICGgTMZRPGumwr3MVVOXaIpLzbE
	JKk4vS5dNvuv5vFRVJmshvhtLMapcxa/SOFaQreP2joe6etVIUulKPkNkXJMZ1R53Uv8Uv
	gZ1NMLUn12OGVS3+QZitEfsdJnqYWkNIw+kEXKBR93U/vG7a7f+uvHID8Y6qKb039hz1LV
	L2tTISGKZVp/gMn5F+X1ksIyaoFXREE8tPr3Cm8Ql1SZxlDOsufOnxOcjqx7kbfspkhWVt
	PCjVOidbSuiF1Jec8U0ID4O9T8qzuEzC8uzzL8HCMq2SxgR04nuvVIRYgZc3AQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795300580; a=rsa-sha256;
	cv=none;
	b=W2qnGS7cyohZTJLjpUhVdfWOOCrd/j7BavaHHd1W3OA12jL5f4S+bDeLz7SeBeb9rli9xD
	UPiigIjXhHXnmEUtUSZJPu5JbamSmOO8ihUivKHCPYdOQKFzyXza56IT+O+w13gFSIw9Rz
	S8X/SkjXgWipFm5vQbxcf9CFVFtqouE8v+TPzkVl65nzGmT6ynrj7elZ/qxLijNuoo7nKy
	OKdbbrwQ6Zuavz2SyEHBAws+bO5+loYqQY8VUpoQbctVslN+raw6McmtuVTYjtLoUTVwLC
	WCyxAo5NEX/lvQO4DrXOghb/2l+110L4VP84WKijxl7yN6LMBgdpHEfsY7zflw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=mkl@pengutronix.de smtp.mailfrom=mkl@pengutronix.de
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sat, 21 Nov 2026 23:36:02 +0100
Subject: [PATCH can-next v9 04/13] can: gs_usb: use spin_lock_irqsave()
 instead of spin_lock_bh() to protect struct gs_usb::tc
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
Message-Id: <20261121-gs_usb-fixes-v9-4-db121d488945@pengutronix.de>
References: <20261121-gs_usb-fixes-v9-0-db121d488945@pengutronix.de>
In-Reply-To: <20261121-gs_usb-fixes-v9-0-db121d488945@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, Peter Fink <pfink@christ-es.de>, 
 Eric Evenchick <eric@evenchick.com>, 
 Maximilian Schneider <max@schneidersoft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-1b309
X-Developer-Signature: v=1; a=openpgp-sha256; l=3387; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=5mk7PGhYcPpAKkjI7nXojoB+nyueC+VzI+Biwkysdg0=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYshmkrn+UfNh8JUt7Dn1j0JXeWQel9wss4kjU3piRc+5T
 za6bLPqO0pZGMS4GGTFFFmW/jihKBDoUNr7MmESzBxWJpAhDFycAjCRKfKMDN8rZ0Tt/up74mfd
 Lrs79Q489w5smJ/aN+39ci2N6/4sf9gZGV4lF+ftXPNq6//QLxf1rvMeCz+oo/0+tbnSJjujrLZ
 tAh8A
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

gs_usb_skb_set_timestamp() is called from gs_usb_receive_bulk_callback(),
the URB completion handle. usb_hcd_giveback_urb() calls the URB completion
handler directly when the HCD does not set HCD_BH.

Replace locking the bottom half only with a proper IRQ save spinlock.

This issue has not been observed on read hardware, but found by LLM review.

Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261114-gs_usb-fixes-v8-0-f615502b005b%40pengutronix.de?part=7
Fixes: 29a8c9ec9090 ("can: gs_usb: add missing lock to protect struct timecounter::cycle_last")
Cc: stable@vger.kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index c9306e715552..470dd52d97df 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -333,6 +333,7 @@ struct gs_usb {
 	struct cyclecounter cc;
 	struct timecounter tc;
 	spinlock_t tc_lock; /* spinlock to guard access tc->cycle_last */
+	unsigned long tc_lock_flags;
 	struct delayed_work timestamp;
 
 	unsigned int hf_size_rx;
@@ -432,9 +433,9 @@ static u64 gs_usb_timestamp_read(struct cyclecounter *cc) __must_hold(&dev->tc_l
 	lockdep_assert_held(&parent->tc_lock);
 
 	/* drop lock for synchronous USB transfer */
-	spin_unlock_bh(&parent->tc_lock);
+	spin_unlock_irqrestore(&parent->tc_lock, parent->tc_lock_flags);
 	err = gs_usb_get_timestamp(parent, &timestamp);
-	spin_lock_bh(&parent->tc_lock);
+	spin_lock_irqsave(&parent->tc_lock, parent->tc_lock_flags);
 	if (err)
 		dev_err(&parent->udev->dev,
 			"Error %d while reading timestamp. HW timestamps may be inaccurate.",
@@ -449,9 +450,9 @@ static void gs_usb_timestamp_work(struct work_struct *work)
 	struct gs_usb *parent;
 
 	parent = container_of(delayed_work, struct gs_usb, timestamp);
-	spin_lock_bh(&parent->tc_lock);
+	spin_lock_irqsave(&parent->tc_lock, parent->tc_lock_flags);
 	timecounter_read(&parent->tc);
-	spin_unlock_bh(&parent->tc_lock);
+	spin_unlock_irqrestore(&parent->tc_lock, parent->tc_lock_flags);
 
 	schedule_delayed_work(&parent->timestamp,
 			      GS_USB_TIMESTAMP_WORK_DELAY_SEC * HZ);
@@ -462,11 +463,12 @@ static void gs_usb_skb_set_timestamp(struct gs_can *dev,
 {
 	struct skb_shared_hwtstamps *hwtstamps = skb_hwtstamps(skb);
 	struct gs_usb *parent = dev->parent;
+	unsigned long flags;
 	u64 ns;
 
-	spin_lock_bh(&parent->tc_lock);
+	spin_lock_irqsave(&parent->tc_lock, flags);
 	ns = timecounter_cyc2time(&parent->tc, timestamp);
-	spin_unlock_bh(&parent->tc_lock);
+	spin_unlock_irqrestore(&parent->tc_lock, flags);
 
 	hwtstamps->hwtstamp = ns_to_ktime(ns);
 }
@@ -481,9 +483,9 @@ static void gs_usb_timestamp_init(struct gs_usb *parent)
 	cc->mult = clocksource_hz2mult(GS_USB_TIMESTAMP_TIMER_HZ, cc->shift);
 
 	spin_lock_init(&parent->tc_lock);
-	spin_lock_bh(&parent->tc_lock);
+	spin_lock_irqsave(&parent->tc_lock, parent->tc_lock_flags);
 	timecounter_init(&parent->tc, &parent->cc, ktime_get_real_ns());
-	spin_unlock_bh(&parent->tc_lock);
+	spin_unlock_irqrestore(&parent->tc_lock, parent->tc_lock_flags);
 
 	INIT_DELAYED_WORK(&parent->timestamp, gs_usb_timestamp_work);
 	schedule_delayed_work(&parent->timestamp,

-- 
2.53.0

