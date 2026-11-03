Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793709030;
	b=a7GvRUnf4gSu0UePXrxdE+B1BSMk6f+CFqNQFcml1AdzQl491x2Y/jlgesayYJ7VPzIy
	 kQRsMb2b98YP890Q8x+uxILKhG3REAE9I8rVoQaDmYbezvlhtwF/JMcw0SiP9ApmSylyf
	 cFdyXoexY2G1ps7d0mcSbEBfZiF4D66km+oV/EVlvuG0PJwjpf6E05oAysl5Q7edeFXdU
	 mRXXn1eQkJRH1vmehWVKY65N+BqQbD33H8zz7AxpsIQdii01gtCLQhm3k1QA2Lp6YsCPW
	 ocWGDSSaMb/Gi8PtLvwkwxmR0LBiitiEVr9/1Ze0Kxs/6RwkrD2XuRZ02C5TJlHMYog==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793709030;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=0XevL9yTAuMxQ3Q7suF95NcwHbpf8E0C3KBb5meaOSw=;
	b=svbo69mkNewzaEXruJaGypvdnf79fAUl77sGl80i+vwMHD0Hr+RoBFwNOyA/M+USOcgT
	 3ZVFIiXGIAjO/dtf/i+DcCNd3ViACX6NO7mTNrE1h9QsRBEO+qBZw7pieVg8zytbXN7ul
	 5tXC1MVxYNnfY7Nuj4SRQg19Dl7SJlHTdKsLQZIohfTs+Gerz+Jo23cjg4jCOSb5ntNYW
	 lZVlpmZvQg5D+hoW5YXXS1YP4stgfPkXxKN9o+02oPCXm7z8u9P4iwOv0/n0KHnH5GtDh
	 yK2AyXfRt6+ZgG5lQ447/FWxwNlMM55uDH1JMCfy0LPgvfYCnZVBa2pHVijouEebwjA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XCRwIda5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BDF606D829;
	Tue,  3 Nov 2026 12:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XCRwIda5
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793709030;
	b=be6CotQ0yz9t2Wsdr3KZ8oQ/eFR2EvmZ5WenLY4cn3FH8+jb9Rl56Q/9aUaEK7mGsFTd
	 s9EwiAPOecEzqcHekIxRkcZ+sHY7GK4lcHTHUbB2pQs4E5pwsNHvfFEjRYDVWaINr2lqP
	 6Eq674Je1eTVIoqJhevAmF+wjgKboByn+l5ZGoEb6fcWmSwYQjS5/+7sRatUn0+wsc6GQ
	 O5eqNaeVFaLMfNVx9mPLAKXbegQxEYamZqpLElJY4rwlfYpK1pbbL5Ku4j1KcwRJub7Io
	 O46gBAuH2ia13QXO/d0ATD2nFXdjeSOfkv+77CfgiJIR+VcMeqH2GJLZkoQNVro47Yw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793709030;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=0XevL9yTAuMxQ3Q7suF95NcwHbpf8E0C3KBb5meaOSw=;
	b=WNTmj6jSTTNl6/hRUtK+nMdwht8tKPR7Q8TiHKa6Jhbvp/e12fyqw4E9tNE+5/aE82MA
	 bfrA6Vxnu5+B8naU3MMNZK2U8PZXmbC+7Aq/pf7BCn5XKPEcpnzBooMa9rfd3Y8KF34o9
	 XNKc3LqcCN58NQMbb1ciuY+er6g3PLIqPZ9VikQId6z0EBycaBKuulLuWm8T4IWz7y1Gv
	 CSPUUbjiIH8jOV9Yvu63+0mpIvM9W52Gv983AH3FmnZYXVbXvvUnzHuzGf4vTqOxLTrTs
	 N54cjwC7VVhnpjeT7gUiNJK9O/bPBRR6bYCiT0RsZeoNGEnmiy5GtLGtOVTS+7jQtag==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 0480F1F00A20;
	Tue,  3 Nov 2026 12:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793709030;
	bh=0XevL9yTAuMxQ3Q7suF95NcwHbpf8E0C3KBb5meaOSw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=XCRwIda5Rtac5eHb4r8oRgs0IpwRu6xuDF7oLZwcK4yPIT8KymVVaKNQoaq8j66h7
	 nq4eg/R9+e6v69VmWRkjgku+3iysbeTaawA9dmxad9H26H0VNscMz+klK8pGe0Ffhq
	 0ZOqAcl1YGTJHJ7+vpEu2NOWDlJav6To//odPhlqefXae5LPcychs3ym+m0MLfN6Ss
	 LMWTahVjv6NU0nGZIbFT/JeBJ0KUfq0KCvxHaWphpUcrM9825zdv+5UsWs3M0j6ldo
	 A6YseZgKEPbhjzJHKllMhNLyJmrOOxT6urfslmI8jdLSDlVgAUy/S1arvMGPphsmOD
	 HbvRVa8//njpQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E160546958;
	Tue,  3 Nov 2026 12:30:25 +0000 (UTC)
From: =?utf-8?q?St=C3=A9phane_Grosjean_via_B4_Relay?= <devnull+s.grosjean.peak-system.fr@kernel.org>
Date: Tue, 03 Nov 2026 13:30:30 +0100
Subject: [PATCH v8 14/14] can: peak_usb: don't send uninitialized heap
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
Message-Id: <20261103-canfd_check_channel_idx-v8-14-4e8b2c0a8806@peak-system.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793709024; l=1851;
 i=s.grosjean@peak-system.fr; s=20261020; h=from:subject:message-id;
 bh=BmOW8lChZGURgW2vetFo/+vllV7479yRxKErjv3sv+I=;
 b=eeludRq+npkmP51bhyvxC1ZW2Yx+qhLLi1Nl8a4ioUq8yG9gi4yKk2Y9p6jKHnJJvpKcFX87j
 lIBR9nzV9d5Aty5Kbtzpv+VNDBrzjuGXvGwI2OO9Tu2otTE1GJ6K24Q
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
Assisted-by: LLM
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


