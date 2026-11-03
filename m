Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793709031;
	b=VzqFygzFTtCpUpLYNDOvfh90KefnDmgRE0lY/0lXvvxWCPDBGLiQsFnGp1la+txG5RuA
	 6Bcyw8fRsqmrUH5Ncxb8c/5wLHnQ3xoZY5f8RvwsJRV1YL7/XOv49EjcPn4xJ0kvEMMYV
	 1GptNpLIo4jPGkZs749uTmEy7reey1bOw6RNev835SCruUUDEjQY0fmTP5sT5ij5oZ8Mk
	 m4vMsGGkhMTIWEieHjD6tvjkzIfvwE4nBHgYQPxKJm5JZZKy+7rIfz81KlsmEEQkYQG82
	 RVFVOpbVqnpdMvNI/MhbRejSajSMQSHoq9J145v9XFLojq3UIlhLvVfJaaqgCtaG8fQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793709031;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=A9gUAZH2ttwM0hbojD5FKRPbn1G4bBqAWKuw9MT+Ln4=;
	b=FvUCIGXxiAs1rIwzOXBALU3Sv3O8GjtsObfK6DWbJozpwRUvBVueoZ5CC+4+yuchOXbU
	 x6zB9z8e9epV4zPp/RQP2j4dTYYtwWKHL36AfEwI3b8WV/OloFHuA1CBJcEOtribHhsTL
	 o9V6EroAoZR3whTuVISUS8lZ+AgXn59n3AfGNksC5ikD92KVd/zC9G41hvGKaI0VRBx//
	 4c8iNOnOYh1iZURA3ibW2vwsO1CBNhzb3ahpLFWI0SV1PndBTd8Pc3aXlGkPnGrXUWs5k
	 ZpOHy7oNrDQpU2jr7c7xbQAloyqrOIyYQNzGRP8MJj+r44ddNFCi2LNCg+vzkAxrulQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PT6Ehxrg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D5D606D838;
	Tue,  3 Nov 2026 12:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PT6Ehxrg
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793709030;
	b=fGz4vsP7ansZzN8DuGAK9EhUKEnKv17NXL8pH1qI4ZWLWwDgDXzXHRT1RPrkN8scmRzT
	 B3bR7zq1ZwcetZXvRc/T8GdP3tR1Gg6YRhs8ktaSN1Svk3ops01WY3kaMAO/H28YnqZ/8
	 La4RggK/2GT3zqjXHQHwwsNenWm/XBGppfooL9sjC6P1zN4yrwLcfnPrT/VCPJzMi3YUi
	 hoFr89eQFD0AAePXD9mzwgt88ZzYXR5TWjR6u1WPRo21pUYDv6c/SPrKfEEMwZO1PO65E
	 WSbapBE0hQ2tD1m7DdHrTQOoFfXAcg/fdI1GAf/psKofK/stzv+Azn1t7mm2DtnE0jg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793709030;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=A9gUAZH2ttwM0hbojD5FKRPbn1G4bBqAWKuw9MT+Ln4=;
	b=285+T1DFY1gieLYManjc8tSzjYiWLbWfSDDuzPVC8Wes+cDKYSuVGsOdfHf6kSNsAwwF
	 L7hGbGaBCnoVaNfhTcdCupn9OIi6xPV3lxBy856cLbJT1IoDMxX5kYDhnvE2FuoW6biTO
	 lUszw0uCMAEVrnV/aEa1XX5OSitIEsDEccYVGMhTjz3dX2t4IP/wVCHlb28VSReCLRgvU
	 jjDIky2VEScHPmmRlJdRcSk/UQYTF055kTSv0Zuv/oTnMKNEfsHBqR9b1DeVt8jdKkZ8M
	 LcTID3PfYsaaqWi6+B4WDMVhO+o4BJlhW+VhEv05d5nz3QZ7+Sgwf7aayvXFq0aaLRg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 9EBBF1F00A1D;
	Tue,  3 Nov 2026 12:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793709030;
	bh=A9gUAZH2ttwM0hbojD5FKRPbn1G4bBqAWKuw9MT+Ln4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=PT6EhxrgIZRovoyVKep2lWynvP9NmoFcA5Z9EmPW44XP72MLgvw9M7k2vz2VoLXjC
	 qG9qVmdFT9Xg8CXZ+3YJ4GKK1jBTk+meM9BqJ9MXvf9CyvD/dVnpgTY1BilmOR1gO2
	 nTbXHpeq5OjoAbtzOmKwhjNYsWF2LkDLJBeT1c9K+uHs3HLsia98ziODlrsNJB7IPp
	 Vi0UCZL86A1WC5mpzsA/LaMKHIkSRWtqy0xOIFKIe8U3h5a78836I9+mWO8Fu/lyrk
	 opHlaTsISFEpQVqCYhgrNd7Pxr3jqgfeitWaszZttu/s/fPUXUPQgY9/immKIPGY47
	 LLehTWu/1mLUw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B90EB4694C;
	Tue,  3 Nov 2026 12:30:25 +0000 (UTC)
From: =?utf-8?q?St=C3=A9phane_Grosjean_via_B4_Relay?= <devnull+s.grosjean.peak-system.fr@kernel.org>
Date: Tue, 03 Nov 2026 13:30:27 +0100
Subject: [PATCH v8 11/14] can: peak_usb: don't return an uninitialized
 PCAN-USB CAN channel ID
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
Message-Id: <20261103-canfd_check_channel_idx-v8-11-4e8b2c0a8806@peak-system.fr>
References: <20261103-canfd_check_channel_idx-v8-0-4e8b2c0a8806@peak-system.fr>
In-Reply-To: <20261103-canfd_check_channel_idx-v8-0-4e8b2c0a8806@peak-system.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Wolfgang Grandegger <wg@grandegger.com>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>, 
 Dan Carpenter <error27@gmail.com>, Lukas Magel <lukas.magel@posteo.net>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tristan Madani <tristmd@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793709024; l=1579;
 i=s.grosjean@peak-system.fr; s=20261020; h=from:subject:message-id;
 bh=XTYBjy4yb13vaFv4aqnZff98DE+OwHKq+8xejejfzos=;
 b=7khOwn4hDhScEFd6NSKZknYLL1oeF5HNEv795yMlwzhHQjpx/an7ti7Ek8UL0pkzpt4TCP2uZ
 VWAgM6hzsxFCyUHJ0is8+/Jlf12ibqwuuRTammqMGE03u5HGMWA9usM
X-Developer-Key: i=s.grosjean@peak-system.fr; a=ed25519;
 pk=bP7QV2zvvAKAfConZlUOGKGEcXL64SNUpVUm++Ai+/c=
X-Endpoint-Received: by B4 Relay for s.grosjean@peak-system.fr/20261020
 with auth_id=1250
X-Original-From: =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>
Reply-To: s.grosjean@peak-system.fr
Content-Transfer-Encoding: 8bit

From: Stéphane Grosjean <s.grosjean@peak-system.fr>

pcan_usb_get_can_channel_id() takes the CAN channel ID of a PCAN-USB
from the args[] array, which pcan_usb_wait_rsp() fills with the response
of the device. However, args[] is not initialized, and
pcan_usb_wait_rsp() returns success without touching it once the device
is no longer connected.

peak_usb_disconnect() clears PCAN_USB_STATE_CONNECTED before it
unregisters the netdevs. An ETHTOOL_GEEPROM request handled in this
window makes peak_usb_get_eeprom() copy an uninitialized stack byte to
userspace, and cache it in dev->can_channel_id.

Initialize args[], so that a null ID is returned in that case.

Found by Sashiko AI review.

Fixes: 36d007c6fc79 ("can: peak_usb: add ethtool interface to user-configurable CAN channel identifier")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Stéphane Grosjean <s.grosjean@peak-system.fr>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index ff1921779065..83cf6fe7d258 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -386,7 +386,7 @@ static int pcan_usb_get_serial(struct peak_usb_device *dev, u32 *serial_number)
  */
 static int pcan_usb_get_can_channel_id(struct peak_usb_device *dev, u32 *can_ch_id)
 {
-	u8 args[PCAN_USB_CMD_ARGS_LEN];
+	u8 args[PCAN_USB_CMD_ARGS_LEN] = {};
 	int err;
 
 	err = pcan_usb_wait_rsp(dev, PCAN_USB_CMD_DEVID, PCAN_USB_GET, args);

-- 
2.53.0


