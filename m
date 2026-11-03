Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793709027;
	b=WFP6SDdg5RvQW3f/54IxwLJvMZaxapTl7FK61dvGvHP8NztotJ6TZyheuk7cAPqKhRll
	 qVp7U6KNHGFmLuReoVeuUwjXjqVr0vmM8MMYXZfhpE+Ri1j57UIr4vpe2X31Y1+au9XKe
	 MoTrxiAyWHpjH+2O8jK+jvym03jaK4PAhUttdsZrXgjoKuks6sYjRZASXaCAFNy4KZRp7
	 jbQ7oFVBhtqboG0S7C+PlLhmvkcxrPqsEEBpUbYyyY4BndgU40A4FAH5giX9ssQ84mWcY
	 +rFYtiYeIizlPo7nXuiYWSKREniMQ1mSDp61B72LHzt7W0xXOgcnT3TGc7iP9Gzd6Xw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793709027;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=JghuYMkJ+RKrCa+a4BdjNWaUX25zwciItep+KwOBI7Q=;
	b=tRg5Vb+KT9J9QqO3wfQMthMKA7fHpbCtmjDzYmRo0rLv/CyZ96o5r12zf8BdxYtehdYy
	 OOoSs/9k+do0lLTy3Nkv8rfTIAoc1oEec843LZOq1jcm+RfNYzKCsg43oHe4mMK6dx6Qr
	 jAiIC4k16BCm41uX8vW/yrXcNVPyXszbkZMk4fDQvml4Uoc4N9OrB6KQIHA/fLLJyDEeY
	 cVjxlDcQcHRz/5mB7vq+nMuWWLjHmsuCP8XOwPGwvvez0oVwpMzl9zKl2KG/vT9xd2e+j
	 mDvZQEMFoWktQxE047AY2TzmXXsgd1+zOg22xm7FN49ewY8Qc2utfGeL5v+fqwimeZg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MTppc4Jy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7282F606A332;
	Tue,  3 Nov 2026 12:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MTppc4Jy
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793709027;
	b=raw00CZ5ChFTJIn2GyIyJb7qUfnHqTj2GrZyestO31FnTvHoLRwpCCqU7P7qqZQwRNXD
	 p3jtQ8FMxZj+b3YL9s+51yP5GpJiLczQ9d0jbtRjNQG0I71BpnLHTtjeI95fIZg8mZQb6
	 nS+ce+PD4d859KO0Yhi1GeorqhoRgD1n9LltV81hBZTOqA4Q3JaG5VQtziDTkXw/uJRbP
	 bMy+OkMDtk8tm4hT2a3hK3D/6V9ugh5ugPMFkvq/JC533o+zuvpoURXPzDxTjGJNaux4Q
	 p4DSBe3i2BC5MFeglYKSLaI1jibgu9aLs/T9Zt7Gkdd30tFtILJu+sBx1DPQMnSK+CA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793709027;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=JghuYMkJ+RKrCa+a4BdjNWaUX25zwciItep+KwOBI7Q=;
	b=M6vmY6wTGG38tlWB78r548O4Xg0wx6hyMbXSPuLF26b+DFw/BWdHVnWFzeLhNqRgNLHl
	 oRNL+zOe0ZpaScAbUQ1XTJGiZapQ/eeLz7tRNSxj5PGaA6T9hxQfxBbfuS+cHI3fzJZ7R
	 ibcut4aGG9/heTmsP3sfAgLuhi0tIKwAbqdtICHBCDe4UXJUZV8uNSvahnTm9Gk5tl9dr
	 6w14yHAWx3hphR+lfy2kQinRkWM/ZkrcThAChrkkLtqOhLWutFT3F4oZXPM1oY4/6A1Ue
	 EQ7w8aE4apdlNqMvViUm30mvhvQUcrduIaFGvomOc4zAk/4LgVX6ywebh8CltZUz2cw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C152C1F0093A;
	Tue,  3 Nov 2026 12:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793709026;
	bh=JghuYMkJ+RKrCa+a4BdjNWaUX25zwciItep+KwOBI7Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=MTppc4JyIk4NJsaztNMdqU0fbBGgmHss835KyCCtWY2uy0T+oo1ymDq0qWC4BfwAv
	 UNLD3XLP2puBMs5Eqa3APvuxVVD+GD992647epq2H5Y421fh8HbQ92UhyIryqWOJ6K
	 XXBGv7KK+hUB/Zvy6i32mu5wiBolaY2KuQMyXTqJXeezB7zBuNzenwV9GcGS5TdskU
	 a5z9oeAgoe8kK/kL4bGxNpicw3rjTik0bsgbarFp2Nyxdh5+HiVEVfkuAAbyusKmY0
	 RGFpbPNcjRZdQvNiuUDN6QGIWznnZmzt3n9XrASwnqUrcu76Mo3+gBnyHXc8skyjKu
	 5NeNTF8rRnxvg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 2A3384690D;
	Tue,  3 Nov 2026 12:30:25 +0000 (UTC)
From: =?utf-8?q?St=C3=A9phane_Grosjean_via_B4_Relay?= <devnull+s.grosjean.peak-system.fr@kernel.org>
Date: Tue, 03 Nov 2026 13:30:17 +0100
Subject: [PATCH v8 01/14] can: peak_usb: fix missing CAN_ERR_FLAG when
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
Message-Id: <20261103-canfd_check_channel_idx-v8-1-4e8b2c0a8806@peak-system.fr>
References: <20261103-canfd_check_channel_idx-v8-0-4e8b2c0a8806@peak-system.fr>
In-Reply-To: <20261103-canfd_check_channel_idx-v8-0-4e8b2c0a8806@peak-system.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Wolfgang Grandegger <wg@grandegger.com>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>, 
 Dan Carpenter <error27@gmail.com>, Lukas Magel <lukas.magel@posteo.net>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tristan Madani <tristmd@gmail.com>, 
 =?utf-8?q?Stefan_G=C3=BCnther?= <stefangun@pm.me>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793709023; l=1298;
 i=s.grosjean@peak-system.fr; s=20261020; h=from:subject:message-id;
 bh=j5PVoCog9b3ym+t4Mbx6Cbdrz8WWMcNp50N4an/gOT4=;
 b=ACY31B2JFuc1V3zAsNS/1b2DNbGH8upxbAww0YdISmAAwnC/Ym1muUtP4HlYBTuPfRV8pAzIs
 tHSqFqa1QNrADOylz4yMSDuB7oY1jFwvf9UYaCV+Dgwl0dLJbAFuewj
X-Developer-Key: i=s.grosjean@peak-system.fr; a=ed25519;
 pk=bP7QV2zvvAKAfConZlUOGKGEcXL64SNUpVUm++Ai+/c=
X-Endpoint-Received: by B4 Relay for s.grosjean@peak-system.fr/20261020
 with auth_id=1250
X-Original-From: =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>
Reply-To: s.grosjean@peak-system.fr

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
Signed-off-by: Stéphane Grosjean <s.grosjean@peak-system.fr>
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


