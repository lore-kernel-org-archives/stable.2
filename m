Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D6E1A6823;
	Thu,  8 Oct 2026 09:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791451484; cv=none; b=dpGCdUmNYncs3yw+ByDbWvadP5RZIkzhRkfyaAC3adkj1k9I0myf+EyoU/SGAYNwaBAZ/4MRs29Tjph+eZMgITaPplaqcmEjz8Aq10k73GD8erwVuwWN30dHCvjvf4xWvYD9x5xs4atqN5SFE6WW9bww6pqJyyDtETZtbQ4Au00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791451484; c=relaxed/simple;
	bh=GPGOdaWdplu01K3aIn+73Fq/nmgtxNm+riSMwWIit4k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D1OgZ3XmePIh9YuYPqUlBQUaF3fWM13zRrh4KlDhng1U8AJf79PxGkcN+Si8hyvA5R7Bdn9Z5fWvHkSbJGp+9pzmCKeuKMx370dZMiElBeO1vE3dWIXVSfMUdJPT24lv3U/KabQILf/ioZiDCs21xtqesyeTpicBNGL3N9SU12Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=AFqTecPA; arc=none smtp.client-ip=212.27.42.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="AFqTecPA"
Received: from localhost.localdomain (unknown [82.96.140.143])
	(Authenticated sender: stephane.grosjean@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id B637D780331;
	Thu,  8 Oct 2026 11:24:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1791451476;
	bh=GPGOdaWdplu01K3aIn+73Fq/nmgtxNm+riSMwWIit4k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AFqTecPADd9m+f0GaSCay4eDH9kXKAEZzoIgBsKxw1aDisiQxDnx52E1W2PpqqHBh
	 kyWaR2n46tqmQE5Gz2f4kagWspOggSvgjLjBbq6coPjOjKg4YSX3+HKt9EQXZ5VU48
	 R2ilFfUCh3WORhO6u9bAOskjV1BMR4OsnjtSh0PGeIn8QeXj6ZnXtOnUyCD3V6Xwm0
	 54LpBUTK8zrZZH5yhjhqN1MPM8bjsYT+tgQG5d9Xv8FYxQe5BYvWJKiDwzJeRlnaaj
	 F02/wImEp9aXyfARZ5ocIWLtnLGAXuoXo/E+Nc7k9C5zbP0oOZwvODUExf4twCCMY2
	 F8eL3oB2W0nQQ==
From: =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@free.fr>
Date: Thu, 08 Oct 2026 11:14:55 +0200
Subject: [PATCH 1/5] can: peak_usb: fix missing CAN_ERR_FLAG when reporting
 error counters
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261008-canfd_check_channel_idx-v1-1-0a3bb82f4e09@peak-system.fr>
References: <20261008-canfd_check_channel_idx-v1-0-0a3bb82f4e09@peak-system.fr>
In-Reply-To: <20261008-canfd_check_channel_idx-v1-0-0a3bb82f4e09@peak-system.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Dan Carpenter <error27@gmail.com>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>, 
 =?utf-8?q?Stefan_G=C3=BCnther?= <stefangun@pm.me>, stable@vger.kernel.org
X-Mailer: b4 0.16.0

From: Stefan Günther <stefangun@pm.me>

When the device reports error counters, the driver incorrectly uses an
assignment (=) instead of a bitwise OR (|=) for CAN_ERR_CNT. This wipes
out the CAN_ERR_FLAG and CAN_ERR_CRTL flags, causing the error frame to
be sent to userspace as a regular CAN frame with ID 0x200.

Fix this by using a bitwise OR to preserve the flags.

Signed-off-by: Stefan Günther <stefangun@pm.me>
Cc: stable@vger.kernel.org
Fixes: 3e5c291c7942 ("can: add CAN_ERR_CNT flag to notify availability of error counter")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 8fd058c32856..785224e00c4e 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -526,7 +526,7 @@ static int pcan_usb_decode_error(struct pcan_usb_msg_context *mc, u8 n,
 			/* Supply TX/RX error counters in case of
 			 * controller error.
 			 */
-			cf->can_id = CAN_ERR_CNT;
+			cf->can_id |= CAN_ERR_CNT;
 			cf->data[6] = mc->pdev->bec.txerr;
 			cf->data[7] = mc->pdev->bec.rxerr;
 		}

-- 
2.43.0

