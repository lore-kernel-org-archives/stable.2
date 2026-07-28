Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6701A25B0BE
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 00:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785200295; cv=none; b=taFVcsJ/7aWBUMZ+/rwxrHw63aqbtLrlQX2QJHrJ5+DH6dFcmH0iMfvWP4CE11YRKWuVi6EV4Gq5qTxsYqCNUKfdXitXY8BHKvTFln73ssOFC22uQgj+Dqlb1I1PW5EdYhtUXLcrYWB0AZXNYXyZpGNERQzcd1Hc7nVlk7bTiiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785200295; c=relaxed/simple;
	bh=HLxuR88mAnR3nwlvsg3EoX87g+khTvwxFI82uOwGsQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YKZVFdiS+vYfEqwkeEVesAIUrf+kIq3WrpmG71Rtx1avRUu1KAVYCZxVj3j7sFjgLEef4AoYkG1Om/2QckXX4sS+un6hUQsJ3aHVbxRkD3bNhz0HL16KmH1KBZUh9/o774yBJgf7/SAWL0GxXAIxYAn8l5dl4obx5grt1QmQFnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XPHq8rDQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XPHq8rDQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 994321F000E9;
	Tue, 28 Jul 2026 00:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785200292;
	bh=NWgnL+aw/7b6hKFmEISXGJGM7gySrZBgtBCxsnYUwrM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XPHq8rDQH96bmZCKCSl0/pliR0lNw0BYtJ7wjxM85Msib6EVQtLo40nbakSBvqoFC
	 5gs7wG3Q2vgdH/1Y9+ZpZue0csQ4a9KEssbsWFADjtXi2H8r1iLV9JwPvLAknFpt59
	 EHJ8At2UDoq/WEcoNB48DeMecy7kjhr08m1P1ZoYl7aHVJQuAiQjGkHngNNw0dYbBI
	 fnzYLgB8184A0rZj2gFqFYOi7A3b7/N8NBWsLsQzb6PesR8yuGvR3Z6OwZwE5v4wTh
	 cMbS8sPLpsOKaBm3NqOQcIsWSYnwoxMw7MU1D4zr5QYzdUBn05b5RNssTyjMMjgk/G
	 wg9ijdgVdZk9g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 6.6.y 1/3] mmc: vub300: fix use-after-free on disconnect
Date: Mon, 27 Jul 2026 20:58:03 -0400
Message-ID: <20260728005806.2694893-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072046-elves-jokingly-9d77@gregkh>
References: <2026072046-elves-jokingly-9d77@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johan Hovold <johan@kernel.org>

The vub300 driver maintains an explicit reference count for the
controller and its driver data and the last reference can in theory be
dropped after the driver has been unbound.

This specifically means that the controller allocation must not be
device managed as that can lead to use-after-free.

Note that the lifetime is currently also incorrectly tied the parent USB
device rather than interface, which can lead to memory leaks if the
driver is unbound without its device being physically disconnected (e.g.
on probe deferral).

Fix both issues by reverting to non-managed allocation of the controller.

Fixes: dcfdd698dc52 ("mmc: vub300: Use devm_mmc_alloc_host() helper")
Cc: stable@vger.kernel.org # 6.17+
Cc: Binbin Zhou <zhoubinbin@loongson.cn>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
(cherry picked from commit 8f4d20a710225ec7a565f6a0459862d3b1f32330)
---
 drivers/mmc/host/vub300.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
index b420e4d82cf404..3ff40fcd62a46a 100644
--- a/drivers/mmc/host/vub300.c
+++ b/drivers/mmc/host/vub300.c
@@ -2279,7 +2279,7 @@ static int vub300_probe(struct usb_interface *interface,
 		dev_err(&vub300->udev->dev,
 		    "Could not find two sets of bulk-in/out endpoint pairs\n");
 		retval = -EINVAL;
-		goto error5;
+		goto err_free_host;
 	}
 	retval =
 		usb_control_msg(vub300->udev, usb_rcvctrlpipe(vub300->udev, 0),
@@ -2288,14 +2288,14 @@ static int vub300_probe(struct usb_interface *interface,
 				0x0000, 0x0000, &vub300->hc_info,
 				sizeof(vub300->hc_info), 1000);
 	if (retval < 0)
-		goto error5;
+		goto err_free_host;
 	retval =
 		usb_control_msg(vub300->udev, usb_sndctrlpipe(vub300->udev, 0),
 				SET_ROM_WAIT_STATES,
 				USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
 				firmware_rom_wait_states, 0x0000, NULL, 0, 1000);
 	if (retval < 0)
-		goto error5;
+		goto err_free_host;
 	dev_info(&vub300->udev->dev,
 		 "operating_mode = %s %s %d MHz %s %d byte USB packets\n",
 		 (mmc->caps & MMC_CAP_SDIO_IRQ) ? "IRQs" : "POLL",
@@ -2310,7 +2310,7 @@ static int vub300_probe(struct usb_interface *interface,
 				0x0000, 0x0000, &vub300->system_port_status,
 				sizeof(vub300->system_port_status), 1000);
 	if (retval < 0) {
-		goto error5;
+		goto err_free_host;
 	} else if (sizeof(vub300->system_port_status) == retval) {
 		vub300->card_present =
 			(0x0001 & vub300->system_port_status.port_flags) ? 1 : 0;
@@ -2318,7 +2318,7 @@ static int vub300_probe(struct usb_interface *interface,
 			(0x0010 & vub300->system_port_status.port_flags) ? 1 : 0;
 	} else {
 		retval = -EINVAL;
-		goto error5;
+		goto err_free_host;
 	}
 	usb_set_intfdata(interface, vub300);
 	INIT_DELAYED_WORK(&vub300->pollwork, vub300_pollwork_thread);
@@ -2348,7 +2348,7 @@ static int vub300_probe(struct usb_interface *interface,
 	return 0;
 error6:
 	del_timer_sync(&vub300->inactivity_timer);
-error5:
+err_free_host:
 	mmc_free_host(mmc);
 	/*
 	 * and hence also frees vub300
-- 
2.53.0

