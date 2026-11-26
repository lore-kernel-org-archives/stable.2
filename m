Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795683713;
	b=kzbFgFSALg6f5NsNw7ayDdCaq8LqbvIerSXAOYnVtCTGmnZtf/pMo/+mN2MfyWEQy32A
	 PgQenLx6sxqFoInjvE/2zmp5kNdlzOwdU5n3bqFo43rqEkJdz59LzMNDjP2RCvSqiRlIa
	 +AtJH4za4STYU+klj6FdR4YQ223wqxAYExcmkKjKiDhwWiRWTssRvN7RNoxhWbjk57qzB
	 brtS8aHBml1zpapx1IDAo/xWkeVABbN1PADcf56a4TypEZBvbXgCuQZHAC94pv1Sb910B
	 rLoiAZQVus6F5Q8nTDEC5FiTa1IW8OeQMOrWxXuk5jWQi16Ht0Nj65Uifd0TmGYjSZw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795683713;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=DA9fxl3A0gpl+EBLGABxU1yrSe2gbGjtynXvZthwbfE=;
	b=r3zwfJvB0ErF+z6DJk2gShizbLpojNYOhFPoPw44keahPlzWGHoJBD/YX+NltNCiyR7L
	 3xC2olZ9RU/CnZPG8R48/gb6AO0tPGCvVvUt2ug02iiGNWX1XgFqulIwL4RfXaa78flVG
	 NP/KvGuGgNAa4pgUPb1aKx1420BWOSCCdDYqr5PrR18GfnWdtXWkrk++xDQ/f3dA4Q7NG
	 jbE4Oopdma3FcQQI5FWSRLW3++qXIhw9PSmoN3czWq1KR87A/lOeLL+2n2dyHng0nG5Kv
	 h6eL9g+UxcmHvJwOmZtTrAqWtoxB5NPsgokfHuv1TN9vPLh++iEDmt/gJiMpro4+CSw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PipWVLxU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879CA606A337;
	Thu, 26 Nov 2026 09:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PipWVLxU
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795683712;
	b=BF+bmUFYPknHnHMp2H6ORkyRE8rlZYrOzbpOoeyj9o2uVMkbjgC1YLpJ/ZI5NuOTiw6P
	 OuVCZLQX9Mm/HFpJA/M9fNkARiX5vtksLnw/dGTv3TaxrRihjV8BIboX7gLf5sQdCo9Bm
	 nyTnhlO9lfm0JpjwTFQ8OQ1zaaFRANSdazahEdJeXp8xzUgGgdWsrb8m9XDq51tY4TtR+
	 3+Ym4cKW3PQSnXudMVh1UD5YaYaARPBWYsvhOBx1OHO7ufqQ0peKKC41bNJfyG1d3fABe
	 K0sOyg1gbNQMqgrLYHCa/hAZ80s9vMu2AWpG2Xi5zMReDXls/q9W5+dpSLDK8FkG5Ag==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795683712;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=DA9fxl3A0gpl+EBLGABxU1yrSe2gbGjtynXvZthwbfE=;
	b=j0Id1BJfheyVfPkHMnIWNF/IekH/km0ei1pctekjJa1AApiV6zx/agUQuSKfQBRPXfUd
	 DfNUdIJMhv7bnBEXFd2tdnYFxAeQWIsowKrj84JIXNCU9uHVsUq6Tj7lyGqKHlB0DeX5Q
	 SL3y00KdL3MKYHktTNtFphLoDHE3FEVxxj3aBX4E+xLN49RD0s64fRBSj9FCHu2aR29Uk
	 O4I0Nrv2Nq34mcbP7BIvvI7CP3yWCLhnKBeR//uNk7q8nfFQwG0OilKH0eFlt1P+3amEC
	 T6mUcCQGx7Uarr3jG9O41UrqIRldJot95vtfdioUfc53bO+9YQ+sKj2Tpx1dFIn8oQg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 461141F000EE;
	Thu, 26 Nov 2026 09:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795683712;
	bh=DA9fxl3A0gpl+EBLGABxU1yrSe2gbGjtynXvZthwbfE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=PipWVLxUuL/9N+9FLW+PoQOKJUqUx6puscfOLqCDqSeGahOcqNDTe4mIamhOBr1Pd
	 tVLvExlOHcrnsYq7LhFOpgKrcQ1v4e70jV2C9DyEIfk1uC4EokQVaNx0o5+mT/oLos
	 Wiwu0P9NfVnfkSpNxoEEs4aD/vobxqfgH4NfSOzyJeym9BuVrXXQCuh1QYJeYPEtc0
	 gP32V4COwm2L50uMKAYHAYORwaSC1B+ktT52D56Y1dllFIEOvbY6d2abDByCQ8pOOG
	 iU4GpLAM3odi7v0dXw4C73yHB1WF1eD8nMgVXjnMpUNt2annExj6UUcVwSe5VHLA3w
	 dTLVAVSb9yo0A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 81CBB4D346;
	Thu, 26 Nov 2026 09:01:21 +0000 (UTC)
From: =?utf-8?q?St=C3=A9phane_Grosjean_via_B4_Relay?= <devnull+s.grosjean.peak-system.fr@kernel.org>
Date: Thu, 26 Nov 2026 10:01:15 +0100
Subject: [PATCH v9 14/14] can: peak_usb: don't send uninitialized heap
 bytes in restart commands
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
Message-Id: <20261126-canfd_check_channel_idx-v9-14-abe0099b4585@peak-system.fr>
References: <20261126-canfd_check_channel_idx-v9-0-abe0099b4585@peak-system.fr>
In-Reply-To: <20261126-canfd_check_channel_idx-v9-0-abe0099b4585@peak-system.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Wolfgang Grandegger <wg@grandegger.com>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>, 
 Dan Carpenter <error27@gmail.com>, Lukas Magel <lukas.magel@posteo.net>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tristan Madani <tristmd@gmail.com>, 
 Joas Antonio dos Santos <joasantonio108@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795683678; l=1833;
 i=s.grosjean@peak-system.fr; s=20261020; h=from:subject:message-id;
 bh=QXT/myCDgJ3otLPXVyU9P9OwS7Dydow3hlp0UZ9UAWc=;
 b=ZrLWYIdrwODw7nIJisgT/tWxly52e8XlAajpO7d/mC1R4en39Z6cVT1KgX3EOJSpySbwBI47y
 Bg9LYp3tt0SDD1xgIsukeOGLzC1ey7NQcGdaA5B8pHYapXusMwxhEmW
X-Developer-Key: i=s.grosjean@peak-system.fr; a=ed25519;
 pk=bP7QV2zvvAKAfConZlUOGKGEcXL64SNUpVUm++Ai+/c=
X-Endpoint-Received: by B4 Relay for s.grosjean@peak-system.fr/20261020
 with auth_id=1250
X-Original-From: =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>
Reply-To: s.grosjean@peak-system.fr
Content-Transfer-Encoding: 8bit

From: Stéphane Grosjean <s.grosjean@peak-system.fr>

peak_usb_restart() allocates the buffer of the asynchronous restart
command with kmalloc(), and lets the dev_restart_async() callback of
the adapter build the command in it. None of these callbacks fills the
whole part of the buffer that it sends to the device:

- pcan_usb_restart_async() sets 3 of the PCAN_USB_CMD_LEN (16) bytes
  that it sends;
- pcan_usb_pro_restart_async() builds an 8-byte message, but sends the
  whole PCAN_USB_MAX_CMD_LEN (32) bytes buffer;
- pcan_usb_fd_build_restart_cmd() leaves the unused field of
  struct pucan_wr_err_cnt and the args of the final struct
  pucan_command unset.

Uninitialized heap bytes are thus sent to the device each time a
channel is restarted after bus off.

Allocate the buffer with kzalloc(), so that the unset bytes are zero,
as for the other command buffers of the driver.

Found while checking the other adapters for the uninitialized command
bytes reported by Sashiko AI review.

Fixes: bb4785551f64 ("can: usb: PEAK-System Technik USB adapters driver core")
Cc: stable@vger.kernel.org
Signed-off-by: Stéphane Grosjean <s.grosjean@peak-system.fr>
---
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index 1d306160fa35..95c1454b4116 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -702,7 +702,7 @@ static int peak_usb_restart(struct peak_usb_device *dev)
 		return -ENOMEM;
 
 	/* also allocate enough space for the commands to send */
-	buf = kmalloc(PCAN_USB_MAX_CMD_LEN, GFP_ATOMIC);
+	buf = kzalloc(PCAN_USB_MAX_CMD_LEN, GFP_ATOMIC);
 	if (!buf) {
 		usb_free_urb(urb);
 		return -ENOMEM;

-- 
2.53.0


