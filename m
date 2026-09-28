Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C454F96AD;
	Mon, 28 Sep 2026 19:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790624014; cv=pass; b=ijXcM7L1Cstb31+KBzSx8VVEiFcSR5jB/DPu8oSMrA9fdpu7h4t00ddJk4d+RjNmu/lWlyuhlJc1WT6PnBTrlkWMpT5zAV+e/CNSYB/yY1fsY+0s4xbky2zUxgFWwZim9V3+nOYy90bhAmAVlV8wuyg/evSWE7VXqZ7fLKmBevQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790624014; c=relaxed/simple;
	bh=xlBpmG2S8ktOUfyR9BnjBv4YZtFPuPM4pSpKCik+ybo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VhgaHYGHUUGSdIXZbDuOFLzWfocaQ1pgKW/fXUSv8dU2gUQvjsLxOSss1f+jW/bUbK49HH3MupIVtyKPhhJnlIUOxhxwxxNF+Y6gI5apLVglvcYf93bLwbVMphWPUVP0UQbnCchsPyk679wFNJFCFTV81N1P/OeWX9/2eZFUm8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=f4xShQ8l; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="f4xShQ8l"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id BD5182022D8;
	Mon, 28 Sep 2026 21:33:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790623996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R0e4sLg8VRKC7HcEYnp0BWef6sI/CdcfN6PpzxAScpc=;
	b=f4xShQ8lr8eFdskt9hdYkPynMnBuOLBOJ35kGMWaoEY5I2elFfWkHxTqwKWyz6soQbvMRI
	nKhqocY2nlYPEzjYwxC2U4OxJ/jn2sNdWgL1yB6JmVH1Ol2geJI9rrWExwE/C5rcsrlkGx
	9+5XSjn5a/x85T2Ae9xjiH2FevJXZvwoFaiCljYMC0Lb1k/RtEbbGDyCTUwX05xkFVDHdK
	wF91gQrM9PYzzokgoLsBQdnBouxSXxDJgRvDliZIa2CYGjcRTZF96LkY+DmoRy02LscO6j
	UMQ3uwl78aK+RQOqHH30gnx37Tu5bY2RYfLQEKHUiAR1xISbXbolxvPv6/YL4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790623996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R0e4sLg8VRKC7HcEYnp0BWef6sI/CdcfN6PpzxAScpc=;
	b=I8Zo7pNNNdddJJ7CPJKqL5QFZXOFyrbl7SppO5f4c9mQHbdlHK7FSRL5stZ7EiFfMYOsBl
	EJxOEZamE0RzXpBpLOMkY38s+bLzx8EnCPfBkWNXmWZngJT6kKyjZbPD6CEQxJnlaIo4kh
	sdZGwbLOOgvyM/k2twSLEw8f7I8CqWgRXxQNZm6KFsb1LU8B50Sk2f3ZTaywxgn1y/u038
	ppICllzJDowZ8SudOtisLCrF4VDpCYoS8XdNsVUM89FcKxwQlgyzU2hcB5AuGOKwGivCZP
	hymqwi4rtSkUAEoCsGlpj1FIgGuvHyfRTUp/p907oGbjLCYi/Ujnux9q0G1BIg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790623996; a=rsa-sha256;
	cv=none;
	b=XxRKr7o26iEduTONaLvtHijxMwwYcHzK8qcUBMewuIFb+KJ4b3aVqd2HYm+KCH06DUi74p
	SO/ndh0l7GWRReVhD2MMApnTTiWhxRWqAHDD3T+7ng6xXDhRCXitihqi8XAXnS77jNoWSY
	WuJxMhk2ksWC3jKEdayBzhHwq3+aLonNZ2RjMztix4tETLv/E4r7x3Sw0cipv2NiltP2H6
	J3lPmPSFsTXkVWWABPmIYTCTJ8DQir0je8MM4e/7f8eiymEqH2VKgIfymY/oCbbfeUJouh
	y0uWwifMt95P/Q9/pSYcDUV5gZoHgNacfsbv5xhzbApKiLjHWrn2+U8s+0fzJQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xBH6C-003H6c-1r;
	Mon, 28 Sep 2026 21:33:16 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 53A275B155A;
	Mon, 28 Sep 2026 19:33:16 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Fan Wu <fanwu01@zju.edu.cn>,
	stable@vger.kernel.org,
	Song Li <songl@zju.edu.cn>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 19/22] can: gs_usb: kill RX URBs before destroying the netdevs
Date: Mon, 28 Sep 2026 20:45:26 +0200
Message-ID: <20260928193312.553632-20-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260928193312.553632-1-mkl@pengutronix.de>
References: <20260928193312.553632-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Wu <fanwu01@zju.edu.cn>

gs_usb_disconnect() destroys the channels one by one via
gs_destroy_candev()/free_candev(). gs_can_close() disposes the RX bulk URBs
on the shared parent->rx_submitted anchor only when the last active channel
is closed. With two or more channels up, the earlier channels are freed
while their RX URBs are still submitted, and a completion in
gs_usb_receive_bulk_callback() accesses the freed struct gs_can and struct
net_device.

Fix this by killing the anchored RX URBs in gs_usb_disconnect() before the
first netdev is destroyed, and in the error path of gs_usb_probe() before
the previously created netdevs are destroyed.

usb_kill_anchored_urbs() waits for running completions and a killed URB
completes with -ENOENT, so the completion handler returns without
resubmitting the URB. The kill in gs_can_close() of the last active channel
then operates on an already empty anchor.

This issue was found by an in-house static analysis tool.

Fixes: d08e973a77d1 ("can: gs_usb: Added support for the GS_USB CAN devices")
Cc: stable@vger.kernel.org
Co-developed-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
Link: https://patch.msgid.link/20260923070352.487595-1-fanwu01@zju.edu.cn
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 3b9b2f104d86..f604358c8259 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -1595,10 +1595,10 @@ static int gs_usb_probe(struct usb_interface *intf,
 
 			/* on failure destroy previously created candevs */
 			icount = i;
+			usb_kill_anchored_urbs(&parent->rx_submitted);
 			for (i = 0; i < icount; i++)
 				gs_destroy_candev(parent->canch[i]);
 
-			usb_kill_anchored_urbs(&parent->rx_submitted);
 			kfree(parent);
 			return rc;
 		}
@@ -1636,6 +1636,8 @@ static void gs_usb_disconnect(struct usb_interface *intf)
 		return;
 	}
 
+	usb_kill_anchored_urbs(&parent->rx_submitted);
+
 	for (i = 0; i < parent->channel_cnt; i++)
 		if (parent->canch[i])
 			gs_destroy_candev(parent->canch[i]);
-- 
2.53.0

