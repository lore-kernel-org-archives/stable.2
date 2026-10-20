Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.27.42.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792492855;
	b=rwekfglZ6xSRwv8fwgDInZAmYah58kdyso+ORjvNwyvaVjkpZynLJB4W1dfoodkxiiKA
	 sNl78t2YJ5u4urnAAF02apCtRxxcu9Hfy9cjuBQ+8SuD4mISA82WVB5TBnQf61QVqvQhd
	 vdTjNDp2xNYXjDyVsaBnjU9i9uvIeJ5U6qo+LeTtwXcf0bU3HG5/ie+ps1TgZXPop/Eba
	 U0EE5T7mrjSbhychx5sAntA0F/iA/AR/eie4RLwlE0gA9M4W7pQtYZHeZWkgftsJdXi9A
	 52HW5Dr3VwJ3C14glzZkdV4bue/MEbhwksvL+v9n4lgCJ6A2eKXg7t87aafMspiRH7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792492855;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=PchrU+Va3DZaNKNckQ858GV5JoQCVK375UKKXHl3JXA=;
	b=eDbS6H6oGfkJCTvuwzCDsUhDlhenLpgAstFd5X7rgTIVFjQQ0DWj6+Ql7xPNoqZNwU5W
	 jLPrC/2K35F9GfDliKBSOzv4hQk9u7uJorm4wVvcp8s0qTHhDGnWb8SAuYM8pIFJgQHbZ
	 +pmxP6JsjpatCSCyUCqRACsTSHVj66+dQwsghM6dklslc9LrC9sWH/Lwyyp6WwsEQ9f6m
	 OWbY65Xv5ekY7HUmLuDm+/iwG8ytT7FnI3g/lv6t6ZoB1aG7Ill5VzRIGnYHagnGSC9A8
	 6iyo3hGEHYI9Ek9VGpoFXNQXV56DN+2Nv3Q8T3gsybxp9TnmQkWoRa7ZiiNrqfCX3bA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=free.fr;
	spf=pass smtp.mailfrom=free.fr;
	dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=b14UrPw+;
	arc=none smtp.remote-ip=212.27.42.6
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB49606A31A;
	Tue, 20 Oct 2026 10:40:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6EB49606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=b14UrPw+
Received: from [127.0.1.1] (unknown [82.96.140.143])
	(Authenticated sender: stephane.grosjean@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id 0EA9F78035B;
	Tue, 20 Oct 2026 12:40:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1792492853;
	bh=fBbRmFAYB/NxTIZ3ycFIOuPJeZJ2J3FRaVle6IV6m5I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=b14UrPw+rabdG1NHCryrpS6yS4P4i4v1ZbcsZ2XWxMM1TIG+AtVSh5WSR0qTI3xzY
	 4BUZj3U9JS64Ewcto4yLIcoRg5Ei3Aa1lgvX911cacvLLtEpl2M7B/C4CHgSX8t6T4
	 ix4SkmFYE17K6EBuKm56ogYWJMnKxWkQKoz7ZjabElLDDXJmwG8FvTDDgWFExcwqRE
	 wqu0Sdm5/CiUmfScDp2eaQlQdqQc1BleJL1MPjbkXtqkl2kn5kvpYbu0TA80EHBpOe
	 9y1IMsWj9XmgBAnRIBOqC8uZUrJGdbXoVgnesFcW4MQ6DHSOAjJydvGtXUjh7x7Axz
	 v//Ttdt97ITYA==
From: =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@free.fr>
Date: Tue, 20 Oct 2026 12:40:16 +0200
Subject: [PATCH v4 01/10] can: peak_usb: fix missing CAN_ERR_FLAG when
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
Message-Id: <20261020-canfd_check_channel_idx-v4-1-bfbde81f8bab@peak-system.fr>
References: <20261020-canfd_check_channel_idx-v4-0-bfbde81f8bab@peak-system.fr>
In-Reply-To: <20261020-canfd_check_channel_idx-v4-0-bfbde81f8bab@peak-system.fr>
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

