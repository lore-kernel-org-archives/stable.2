Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058E940E8D7;
	Fri,  9 Oct 2026 07:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791531100; cv=none; b=d3X5UGDaMf6b73DiXDmclHEjPp3prWshlzCLUGjJRfvzT5wTFSj1ZrCLb7r0DCYvnAunT5hZ1s6TQSaZpitUa60QyzTS6LZbkf7EAMwbF8S87X7sHJk9wX0BFOk65/7id5ufhPFOIrCNc6NVSqgb3WFlLNx1wjtc2nPbPfjG14Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791531100; c=relaxed/simple;
	bh=GPGOdaWdplu01K3aIn+73Fq/nmgtxNm+riSMwWIit4k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MuiJBQz6kQ2IbPDAKgy0BvfgXl8FkuvC9gD1WXSCBc9rkpQ7Vgm5onsw2YGqv9Rtm8UmsibJyd1fXUNcE3Xk9H+9MEvs+86HwGQ9kaweFDWuyLv9DWfeaivjYDaFdTMuwBWb9Pf77SiK9WRHbdAaTqk7O9WIKMVwXu/6fM0UmNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=SvyNHl5P; arc=none smtp.client-ip=212.27.42.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="SvyNHl5P"
Received: from localhost.localdomain (unknown [82.96.140.143])
	(Authenticated sender: stephane.grosjean@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id 72D9878035B;
	Fri,  9 Oct 2026 09:31:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1791531095;
	bh=GPGOdaWdplu01K3aIn+73Fq/nmgtxNm+riSMwWIit4k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SvyNHl5PBj9fQwuiXnFKI4SXKRMqMPawuwxBFkS+uZ1jR3fOqS0+DX6sEkN2Y9cRy
	 +xnKuW8xCjXVWUpNSDncRqtnrecv6jTe9V0n9dZ8lfkySydW83KSMQ9h7R3OzzIsuG
	 4Ni810NWTlZEy0efbqTjrcZ8uRA12piTzXhflS2TXeWDL5th0hWBDrShvCXrPFTOK1
	 dHAJqrpAIReYGZ6MfpSwn2xxRPHhIC2URU5LS/WqZmmyRja17we+5nqcgageDVkGv1
	 aoSflnwE93QKfcpaxf+4ixpIogc29SxQGDLv4bI9LRT6XeS9/1sAnrLQ8/V++JnHUB
	 NMLZg5jLO+mwQ==
From: =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@free.fr>
Date: Fri, 09 Oct 2026 09:30:28 +0200
Subject: [PATCH v2 1/5] can: peak_usb: fix missing CAN_ERR_FLAG when
 reporting error counters
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261009-canfd_check_channel_idx-v2-1-f7b772929791@peak-system.fr>
References: <20261009-canfd_check_channel_idx-v2-0-f7b772929791@peak-system.fr>
In-Reply-To: <20261009-canfd_check_channel_idx-v2-0-f7b772929791@peak-system.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Dan Carpenter <error27@gmail.com>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>, 
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
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

