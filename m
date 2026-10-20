Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.27.42.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792487354;
	b=IgZecmKSoe/nYvQuBb/IDH5h52O7paLfiH6NxHiqLUqXqvytYO34Bngm21/r7EGE5b5N
	 RE7CxAhNx4BHqXy+jYv/f+pvOiDGJ0vsRsoSLyz0Q7aFPMFUvkE3wrJme9Qhm7LVltRnz
	 wjIqzoSDR33TSY52+D4LJh+y5E3DZ76M5hmLuoBaiTIC9jmaHCnuoTHTeqxj8oTZOIgg5
	 qTeCsF+Gyp7yexqcjPUsdjX1siuqx94BMweogrjt5b7MNCR76SE938pXUx8UGzmmJbJzm
	 nG1S6A3zifhWi2bL+tYmFd1iLy7FUN4eumATfFKOuN+sxp8SNG3zjKfMdP/qdkrSLQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792487354;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=PchrU+Va3DZaNKNckQ858GV5JoQCVK375UKKXHl3JXA=;
	b=OL99dIiIfg1Ewtrd9psy3K73AnUK2L843TeIEQJeaJ3KgIbwPal4Po15Xemj6Y54lZYh
	 ORNiot3OG9N33YRVmdeTB89MjHD6qJW2cPgIJZj1bpf+CyPYfCJDcF6j3PHKQr3Grs5qf
	 twvdkwRM4+oAbsMNn5C5a7tMIysA9kBP8k645BwScadrGi37c4/tpGcLe4oROu1SYDsmp
	 xIK1hlasSk12at1TtRCiXP9r1OOhg5BXXsEkUDmY2Nx6FrwJKjl05Z7mgn7rlB/dHoMXi
	 heGerDPoDb9O6P3u3kzN+iF/Dk0W66pZMrGaf2JwAwuyOBHHJoRviWntMUb6oGYpxRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=free.fr;
	spf=pass smtp.mailfrom=free.fr;
	dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=kjsWr9Ao;
	arc=none smtp.remote-ip=212.27.42.6
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DAD606A31C;
	Tue, 20 Oct 2026 09:09:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29DAD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=kjsWr9Ao
Received: from [127.0.1.1] (unknown [82.96.140.143])
	(Authenticated sender: stephane.grosjean@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id CAB2F78050A;
	Tue, 20 Oct 2026 11:09:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1792487351;
	bh=fBbRmFAYB/NxTIZ3ycFIOuPJeZJ2J3FRaVle6IV6m5I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kjsWr9AoLqHqXpxwKDtWDWshat+T7QCVoTEEtaf10DNJpUxzl8NKeYk5/mhx2yBuw
	 MHgGwCCn5/miA1jxk9f10dUgv9icN0+1EiutLDPcyNSjpYxTxz4leUZ2R2iA1D5tI9
	 WLFMnyS1szoKFVQU0cePXT4yG6h2GYJLmTlTl+fAnGgn40UYcjqFufJPz5TmKiTO8X
	 1N0im/m8voqow4aS3IQn3svzB+nF4+wEnV2uvXNPf9pVESby4iJDZOOkhCl/CCLYVd
	 YiT+GcYUOcSCgjL0m6UpKL0oPRTxSA2RDi11VcU07jEhRGPWzfivcVgTrXjFbGIUZV
	 PThlF/fpgzrpg==
From: =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@free.fr>
Date: Tue, 20 Oct 2026 11:08:06 +0200
Subject: [PATCH v3 01/10] can: peak_usb: fix missing CAN_ERR_FLAG when
 reporting error counters
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261020-canfd_check_channel_idx-v3-1-74d17c5a599e@peak-system.fr>
References: <20261020-canfd_check_channel_idx-v3-0-74d17c5a599e@peak-system.fr>
In-Reply-To: <20261020-canfd_check_channel_idx-v3-0-74d17c5a599e@peak-system.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Dan Carpenter <error27@gmail.com>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>, 
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Stefan_G=C3=BCnther?= <stefangun@pm.me>, stable@vger.kernel.org
X-Mailer: b4 0.14.3

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
2.53.0

