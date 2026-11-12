Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794504477;
	b=FxKAhKF8vWh3gjRwXXmoflqwkzSH2aEKHWfAVVXCtL0m3ATD7W4y/2CCcxYhN+y1hgEq
	 OPYiGjHnSHHPS6kYbYlyLxtSplwWI22XiyZEtRa1TuSkqU6Xke0J8kTpX7Xvnmn6gIVFa
	 wTKIrYUxoxlnwmVOlALQV5mwWNpXPGFCSGxVxyZVFJkoh0NQBXrU4DZUcp1cCqSbJxPv7
	 DUwfLKfOAStlsMWr8SoY3ugg/oYJMHKXBEJ8WljWLlvwwzefUYVCocCf3F74N0MXQmslh
	 rghah3koTo5dqGkEpQiTRoEGIAhOnst8aKMKnxrqAuzVerV2CnmwiWipfRlDj3XPpuw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504477;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=DayjquPUShg8AYZcLOG5z9wJlcjDaZD4s/KcCdMHRHI=;
	b=YYO2/FXAp9JNYLR8PCOpsIGsX1Q0EcI8/wB1uwU8vsBnnYI08j/ULyiSHK2/vsTqSjzG
	 zEeD59dJ2Xtx0j4ZcCUu14jpjEBUxBrb9niGWwIWv/naxHHi1q1KkfnPykM/hiDKd/KgW
	 3YF3YOhHn29ol42YIdZkbN1happaZ+fy0BWD4msNvLsGOtVG2+h3aAJFsYx4u6IQ71dDo
	 jJXd8suS6sAmcXmGXWo3FcHru4uJOKOCS8OF4rRxFHCtdrijCLha1NkPYlobl0ekbyaSs
	 eGKDTxtSOvOACumrB4qSaHt/TxTlcHnwdtxh6f10L+gRxTgHQzgdyGQ54hks2Tl17qw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="FT3Mb1c/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E35606A8A3;
	Thu, 12 Nov 2026 17:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FT3Mb1c/
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794504476;
	b=0h4T5INbtUcr3oZlNIue3+2OkZn0pfJ+MLl70IqUht9xq3p0sTcPiA3gAM0HkTRyrl0G
	 b9fjqRv/k7n5JMZcZCJ0mDdOHikv8kiueilhiNVCQpJKa7gGyTyQ3hMQzZjFGZ6yfNEO8
	 2lOFPfC9ewvlsYEk5iee7NdN88sWR1qLSnJU3kP7Z3xhjXUPGHD1TwKouiz4Ayx+Uy3x1
	 7K9ZwlW/v6UOdiORtFPWK4LB4sRcB8o8F8M1WqAHBpidXKjxNJlVpjTysjkus7Bnbpmr6
	 Ut32hOvyiZAv9rk+GML0w7ufVDAOdJQHXAtjEE29GkqeHRpxFNECGPGR6jjryFmhHMQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794504476;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=DayjquPUShg8AYZcLOG5z9wJlcjDaZD4s/KcCdMHRHI=;
	b=wMiV/32w9ShxgvPUzAmFb1XahpYqe+Y/ojT8NjjPjSA0CAXZiQHEId5n9ePkzQKtu1tY
	 jodRafSlNwp+tE/0m1tMWCkMdI6XFiLKNGc+pc1jG62R+FAjA00yw82DheflSeVL/xH9j
	 D1Wj8SqHwE2LIT/D/AfgJppxP0RCIcqn+zrGaJ75RbFytpqJE8UFCkgY7HiyFwO2OspN7
	 2Dnow7c4OiHNsNMxt+oTwWCi6gxDnddikG06B3sqvdyi9rz66nZz4O9kKTw0ce+uDqzGq
	 raEB0s/wIU2aIf88rrYIBdjUuaCV+2J0Ib8egxT/+/Yw7JjGcsRF9LVlbjzpmqeyjJw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D43C61F000C6;
	Thu, 12 Nov 2026 17:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794504476;
	bh=DayjquPUShg8AYZcLOG5z9wJlcjDaZD4s/KcCdMHRHI=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=FT3Mb1c/XZ7CHEH/v2CNQejS3XhzdZkEDgfOIC8mbHMP3KAERZMsWKwp6t3ulHw3R
	 OiD3CYbY+DfrhJUoijFWbCZEXPpPGmk7jZ0Wa6jUd2rDmY6bdn8uF/W+hgTjApr0PZ
	 jR4kddoYP38eb7UNVgL0puSrPrqwKdlUlYbWtYDknDM6dJrVu20gL0S2NL5d8VNG6/
	 DzG7wNe9WvF5YevBlYpyQGi82Wz7Zf1+7ct/BnyJsHTi/5Y369aJn35d1DFHxhydb8
	 0HXQF8IO+4Ujxhp0bDrQmNI+ZMeVJbBPXvpAjs/Ux4oMxceUszPROuZi1cTb/rO+3+
	 9cRXpKzrBxmgg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 414AB45A78;
	Thu, 12 Nov 2026 17:27:55 +0000 (UTC)
From: Joas Antonio dos Santos via B4 Relay <devnull+joasantonio108.gmail.com@kernel.org>
Subject: [PATCH v3 0/4] can: kvaser_usb: validate values received from the
 device
Date: Thu, 12 Nov 2026 17:27:54 +0000
Message-Id: <20261112-kvaser-usb-validate-v3-0-61587f639508@gmail.com>
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
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABr39WoC/33NQQ6CMBCF4auQrq3ptNqAK+9hXExLgYlATYuNh
 nB3CysWxuU/yftmZtEFcpFdipkFlyiSH3OoQ8Fsh2PrONW5mRRSA4Dgj4R5wl/R8IQ91Tg5rpS
 VTp2MVqZhefkMrqH3pt7uuTuKkw+f7UmC9frfS8AFb6TWpjwjVqK8tgNSf7R+YKuX5N6A34bMB
 lSqtiAsQmX2xrIsX80ZOwL6AAAA
To: mkl@pengutronix.de, mailhol@kernel.org, joasantonio108@gmail.com
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794504474; l=2827;
 i=joasantonio108@gmail.com; s=20261031; h=from:subject:message-id;
 bh=XWzeKKvhWdX7todL0hlA4VyWBOX4TkKHC0Wx+Kfy1gI=;
 b=24yTyHwDGxTN5P/VVmUPo8Np8ZGtusXHmYbJoPLgDPF73hV2nHRSP/WuD4ngT/bTyS0AtX3QN
 AD0z2s690LrBSciTkJ2eranhRoPsFqonYDMYqKbxP7eVFQZ+6ybKium
X-Developer-Key: i=joasantonio108@gmail.com; a=ed25519;
 pk=ZxAznJT/FcPPdzLrDDFJQm4LLjjHVGBBqDSG3TXS23w=
X-Endpoint-Received: by B4 Relay for joasantonio108@gmail.com/20261031 with
 auth_id=1371
X-Original-From: Joas Antonio dos Santos <joasantonio108@gmail.com>
Reply-To: joasantonio108@gmail.com

Four fixes for values that kvaser_usb takes from the USB device without
checking them.

Patch 1 rejects hydra commands whose length is shorter than a standard
command.  A length of zero otherwise stalls the command loops, and a
short extended command makes the handlers read past the command.

Patch 2 rejects devices that report zero max outstanding tx, which
otherwise leads to a division by zero.

Patch 3 stops the hydra command parsers from reading the length of an
extended command before it has been received.

Patch 4 checks the error frame data and the payload of extended rx
commands against the command length.

These issues were found with the help of an LLM-based code review tool
(Claude); patches 3 and 4 address the points of the Sashiko review of
v2.  I checked the code paths by hand against v7.4-rc3 and reviewed the
fixes myself.  They are build-tested only (W=1, arm64); I do not have
the hardware to test them at runtime.  In particular patch 4 assumes
that the firmware includes the error frame data and the payload in the
command length, which follows from how the parsers advance through the
buffer but which I could not confirm on a device.

---
Changes in v3:
- New patch 3: do not read the extended command length before bytes 4
  and 5 are received, in kvaser_usb_hydra_wait_cmd() and
  kvaser_usb_hydra_read_bulk_callback() (sashiko review of v2).
- New patch 4: check err_frame_data and kcan_payload against the command
  length in kvaser_usb_hydra_rx_msg_ext() (sashiko review of v2).
- Patches 1 and 2: unchanged.
- Link to v2: https://lore.kernel.org/r/20261111-kvaser-usb-validate-v2-0-193dc10ca19b@gmail.com

Changes in v2:
- Patch 1: require at least sizeof(struct kvaser_cmd) instead of the
  4-byte header, so that the extended command handlers do not read past
  a short command (sashiko review of v1).  Subject changed, it was
  "can: kvaser_usb: hydra: reject commands shorter than the header".
- Patch 2: unchanged.
- Link to v1: https://lore.kernel.org/r/20261110-kvaser-usb-validate-v1-0-f266b85aa908@gmail.com

---
Joas Antonio dos Santos (4):
      can: kvaser_usb: hydra: reject commands shorter than a standard command
      can: kvaser_usb: reject devices reporting zero max outstanding tx
      can: kvaser_usb: hydra: do not read the command length before it is received
      can: kvaser_usb: hydra: check the payload of extended rx commands

 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c  |  6 ++
 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 67 +++++++++++++++++++++--
 2 files changed, 68 insertions(+), 5 deletions(-)
---
base-commit: b3dfbde62cf1981c4638939c159dfd087b7a72e9
change-id: 20261110-kvaser-usb-validate-33c2e34b63bf

Best regards,
-- 
Joas Antonio dos Santos <joasantonio108@gmail.com>


