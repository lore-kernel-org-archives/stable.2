Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795373338;
	b=OQ6Xwaz5xNFWPbw0OssGtGLE2YZUqTN8vuk1Hz8Lcpt7i08ZBMrUhjNu3feFSQtHSiCw
	 A9v8ul+tvn3bwCfzBFj3gd3KaTj/V10IKWStd5j/2I861Pvcx26VGx6RzMcbcw3n/Tibe
	 0SmKqtBOCn586sdQlKNVLFtfs4+ctADdwt15vXYPCc3Y5usqgeu2xx0RDg3FLlVk4yszH
	 EVyHlfWqm7yi6BQER0giaRUOis6nxQy8BYvZUiymVAgQrIC11EhY08IEZ2E8ixmRdik0W
	 sEQJevWPuEP1RZ6IgZ65ervfr7unEhlcEt+fF5KHovRg59FmKjWWxGgOYlWJfDstZ7A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795373338;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=OKYdjcTi5SSi/Cr26FPG21A1olMd93TOctfURoEDvZI=;
	b=c/gZW3+LSqnxVa4vuhUDFKN5me1oGR4NKmylla1ldATLjS9mt+VYBUiXEQ/vY7pHQCOR
	 dXa/OHoAZAnFIEu5CYfh4USifH+ebLgSf6HqD2pZxarScMMvFfM9LCQDArvGCEgSOmuEF
	 17/bcoPxLHy6b7h05PBE/4b2IkWD5C2B4YPvb9giCf4bYra5j3FvM08VP3PcHvF+GkMRg
	 /NS59ZhHGI1cU+tAr8yNcQogyGXbdOcf3LXEqA2k8VcpFdI85HGWqvbdTvoxsebBAjxUB
	 PJrKjKXS75dZMPHu0vO9Mu9gcpU6LmRU/Si/gjc82bNAMrC0shxjOJQeFmex8SZzYDg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=BvVkYYMi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420CA606A331;
	Sun, 22 Nov 2026 18:48:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 420CA606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=BvVkYYMi
Received: from hardanger.blackshift.org (p20030102af17cb0015d71b554e0d6387.dip0.t-ipconnect.de [IPv6:2003:102:af17:cb00:15d7:1b55:4e0d:6387])
	(Authenticated sender: mkl@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 8BA1A205A1B;
	Sun, 22 Nov 2026 19:48:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795373329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OKYdjcTi5SSi/Cr26FPG21A1olMd93TOctfURoEDvZI=;
	b=BvVkYYMiG344nxqij0Iz5clkal8MVQwMdi0ClX4OD4LIDVKj6Frdm7fS31361qXhW6bkYQ
	6lh9GssZ9tcdNMdEEOdnzOb2uPTJlEVB1tHOCGr/y1rzbPrTuwVNtg9pF2qrPr2RP/IuYM
	kHk0Bjsu9WpoOqtodrcoTfN1i4qvoF1Pldl/tIhyThY8MdVCoTyo0qBFinGiV8tMPj1xSg
	+/rKCLTzTlzPioM/ZpI9fWEV5KDeFQPs1AgaWKNoz3bALppKW1quDvrmc4MXVXvhSHBFP/
	AzIN9lhVHEZKG2m5aCERl5PcbKDo5dgKi2MC6YsHn1UyTrx+uhzZ+2dUTOscVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795373329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OKYdjcTi5SSi/Cr26FPG21A1olMd93TOctfURoEDvZI=;
	b=GEGRcpgpM3il9hkCxye1hNRqFod+CpK0GMEvEXEZzteTY2vlbm0NvD8x/w4CD7gEK6TnF5
	yniqs+7d4Meyib38Qmh180lNK/G5pBJuqpKxCLizMr3SKvF1Tv9WkkYnVuFr6827qtD3Xe
	nW9lIX2197eWbhihv/cbs4PcqLGlRv/bPjBrvaR/Y+q+wwCCkccYi5vmoS0vgCyxOVH8CX
	vJ7OlxEutaxwDwg/np7Bg/3kIYD/jFQE9x5Q+G1AwZqsAjCjLnuOHOqtoJY2b6y9HqMwk/
	whPV0cbV0Wpf+DJDb8uS4IeCnKj8fHJiPFkSt/MCNt4mFFkwhFzPKxxZsuW7Ww==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795373329; a=rsa-sha256;
	cv=none;
	b=RrPYJEXARo4h8SBIyng+x7PHgpaonjj4reqYLVFJsHxdRkEh5U/EQevYDbE+01XybN4nHG
	szMEdY5X7XHo+b4OK8V1hQckxTB8lt2cgyx9YpjFqRMXeNbZmJMnJeurN7DT/zBtIGRqQ+
	0f1vOqv1XJK0JIITPM3aXluYBj8CfVLHgQJZaOR9SuIQ6puyIzcvUej0oArgKF8yJVfhI2
	n7G1nqmzY/i2gbTCp/x3BMmbjbcjxlF8IJ0JKB+fMiAPTiXL4N4hrM7LjeUybreIQXogOx
	skpXZYlV6LuU+1dQJxpb+ya+vSHCFTR6jJRk9YI1/zZkPECxWk0zGkPS9F2lLw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=mkl@pengutronix.de smtp.mailfrom=mkl@pengutronix.de
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sun, 22 Nov 2026 19:48:28 +0100
Subject: [PATCH can-next v10 04/14] can: gs_usb: use spin_lock_irqsave()
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
Message-Id: <20261122-gs_usb-fixes-v10-4-7c165c35d04a@pengutronix.de>
References: <20261122-gs_usb-fixes-v10-0-7c165c35d04a@pengutronix.de>
In-Reply-To: <20261122-gs_usb-fixes-v10-0-7c165c35d04a@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, Peter Fink <pfink@christ-es.de>, 
 Eric Evenchick <eric@evenchick.com>, 
 Maximilian Schneider <max@schneidersoft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-1b309
X-Developer-Signature: v=1; a=openpgp-sha256; l=3387; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=5mk7PGhYcPpAKkjI7nXojoB+nyueC+VzI+Biwkysdg0=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYshmtmTZ/0bmrFmfrPLP5M6lDHNvfPodK1FapKnC7Bzz4
 zeXgGprRykLgxgXg6yYIsvSHycUBQIdSntfJkyCmcPKBDKEgYtTACayZBrD//zqreGt3DcUWq7b
 aj09uZvxbPum7TEP+LVf9Z62ft0kncbI0Hjf7qiZlvuenR6XdCWZpp+STTpyT0Ryac/742qirly
 F/AA=
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

