Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794615256;
	b=Ow6qIpq6SkY2dSzPjuKxPOgiEv8XjLaJ8lzk2ue7FoUMqYq/Y6hdOyqkhOXUT8JIQ9m9
	 4aVea0Ki1VMR6HgpiRyasu+/u4yWIAg1sSuhMeh6+A9hw1fG8NBIU5NhYPT8rs27M0wmg
	 cYy2j1gITGEfHGjUKgxBezUemYDV2Ff6uRRbFDwi94RT5kbQ5zau0wAUr+CRW5EfvpOLO
	 advLAMIty64kfCRs4MhP6vJjwkt3PftKz1386AfPYaldIuL8FcsWdraqkSruGnKmLH3hI
	 1FQg5tRzUan1zsf0JKI9wzPTtO/xCmrLhuSB8zKkr+K8zBPiZiaeefAwB3kCbpejHuQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794615256;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=INCpImX/8ghfJXOT7zk4UXv6j0qgHeP3OUy1ZzJF0X4=;
	b=KCUHT9f1E17pH9Wwe1xIv/sKDBOzWnNmUHAvZXj6J1oN0r8RmPXP464XJ9qwO3qxIZIE
	 sLjCJ8MiMp2di8rwmI4Sei1CPO7pBgrN8wTA0WMmRFv+J2IqqaVCZQxzuJ7ZB1n8uAdhQ
	 EhaYjvQqEMkFx3Tk40AaYhM8xpdUaSxKyX76zVIPfNitiyZ3ZQRK6ENwGrIdQGo+e1QYG
	 sYzfZEBqpvOnxeZgdiN4SQs8bfFRjc+QVHimN8+82pOxv0NHZ1BQMpbpz6/61moywAsLz
	 205yzEyqaQR+/S8rFMvIa0sfxtK5SkvVYj2KPI5QLSyHHS5O4kfu0Fasa2U46cORkMw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CoZKEJun;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16920606A338;
	Sat, 14 Nov 2026 00:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CoZKEJun
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794615256;
	b=MM+u64tY9PTu88dwU6RhBaaEa/31DtOE70owRlF1ZbFTlaQXmasng7sOOIt87yjRiSat
	 /zz0MdGGUHpa2zUM+wL+TvSYb6f9lHW1cjoTxpOzDJMWhV2R8Sl9ReqdhJx3nJAtIJkJL
	 ZhQ/4neMrHS874ghk6RUKk76dNEVp3sCvw0rCrOrnD/5Mu9ldSNpFUqC8A/CMZEi9YzcY
	 1hgbi7OHrOxXG7Adr9w+prfTLSLw2qbnvJMlqqcF1NHrpfNKvHUQqKoxE5uBlBilt7aZx
	 16VnK62pqTUDeMCRmTk/7zHlUG8IAo8KRJAPEY85Vf+vDoXvdYLJ4sB3dVks5dh05Lw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794615256;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=INCpImX/8ghfJXOT7zk4UXv6j0qgHeP3OUy1ZzJF0X4=;
	b=pyCBbO8mddy1RRUtwqr/UGyc+/m2iNreuvxLNxNIZO7vhdXElbhRR1+eRL5AbqqzjKmY
	 gbB4w3zoErVEIAF6+9FKwFtscJDkjyk/WrU0Iyz9w1R9GlXn5TJuCgfcJb66VsfhZzzRq
	 mWyFvNJC7+lNeLtVf6zrTyza7Q7eevWb7cZ665T32UVGitrtDDg/bL5ErKOyLB9r4adfs
	 /Wcnb18ZJMKHgkugSYx5FXnkMI6nbsbQi53kFmeeHODZvyNkDgCf2Z4CI/3ztS6ZL2+m2
	 CFflFnGlKhKr5sIwu5zKtYhPI4OmAsAshRNdS0Upvo4jHdH+UDPEPaQ6k5Sg/VzJQbA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id CECB01F000C6;
	Sat, 14 Nov 2026 00:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794615255;
	bh=INCpImX/8ghfJXOT7zk4UXv6j0qgHeP3OUy1ZzJF0X4=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=CoZKEJunXiYtNVAnfAHwH2kgQgEAHtQMCgGSPPiB2Bt3X93RoSPYYRVbK9I9M90o9
	 Bq64ShKaLBFBYlk+jjhWCwPyUnuxAJKhQko3yVFC91dGXXMgrj7GzPXHK/wxfE+085
	 QajA+II/h9fG4viu9dTx0B7/Tm5DsoCG7RPrwh/nR86Z85dJDIMfybPaK3xBkXAAXD
	 Y3ve/Fg1B/awLYmDa/OA21OOeOEj88iuevvIPO+aHDbq5AOObRqq1l5/FdwEkozaxM
	 7iURQKNet8zSDI21bhX7kg2An81HQaBfjm00ds6NXVXddwMYwc6/zp1jkn78PU+yvs
	 iomdA7yogyMpg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 5F7AC49BAF;
	Sat, 14 Nov 2026 00:14:12 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Subject: [PATCH 0/4] media: verisilicon: Keep the CAPTURE format in line
 with the decoder
Date: Sat, 14 Nov 2026 00:14:11 +0000
Message-Id: <20261114-hantro-fixes-v1-0-abb78264801e@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMyw5AMBBFf0VmrUlbj4hfEYuqwVggHUTS+HeD5
 Tk350ZgDIQMdRIh4ElM6yJg0gT85JYRFfXCYLUtjTGZErmHVQ10ISvnPOq8L2xZdSDJFvAbpGj
 an/noZvT7+wH3/QCC6dXdcAAAAA==
X-Change-ID: 20261113-hantro-fixes-aace04d5268b
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Andrzej Pietrasiewicz <andrzej.p@collabora.com>, 
 Hans Verkuil <hverkuil@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc: linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Arun Iyengar <aiyengar1990@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794615252; l=2262;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=mnIntMiDrfV9YjjKOqzkuVqV2d/DXAOYr9w8YQ7vPoM=;
 b=ZsXIqa4xz7yC6IWsADXwoKvhmpLUUwInD/83g5bAC8paxA1GqysIVovLKzvpVy9QYhtou1KQW
 lwutzSb62cyBcN6mzhZIK8mzDa1LBKyD8rJ8JzdtETumKBE0HOfKaA/
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com

Pre-existing bugs where the decoder writes more than the CAPTURE format
or an auxiliary buffer provides: the VP8 segment map when the format
grows while streaming (1), the AV1 motion vector area after film grain
is turned off (2), and an 8-bit CAPTURE format for a 10-bit stream
(3, 4). Found by Sashiko on my hantro-dec-size-check v1 [1].

Tested on an Orange Pi 5 (RK3588S) with a v7.3-based kernel, on the AV1
decoder: after film grain is turned off, the CAPTURE format is the same
as a fresh one (stock: 3133440 instead of 3525632 bytes); an 8-bit
CAPTURE format set for a 10-bit sequence is replaced by the 10-bit one,
and the 10-bit format comes back after the sequence is set again (stock:
8-bit in both cases). VP8 and AV1 fluster: no new failures; no splats.
HEVC and VP9 (G2) are not tested: the RK3588 has no G2 core, so AV1 is
the only 10-bit path here.
Patch 1 is not reproduced: the test kernel limits RK3588 VP8 to
1920x1088, and frames up to that size fit the single page the map gets.

Benjamin Gaignard's "[PATCH v1 5/7] media: verisilicon: vp8: Use
alloc/free helpers for auxiliary buffers" (2026-09-16) has the lines
patch 1 changes as context: a trivial conflict for whichever lands
second.

Developed with Claude (Anthropic), which wrote the code and the commit
messages. I reviewed every change.

[1] https://lore.kernel.org/r/20261112-hantro-dec-size-check-v1-1-e5f1180b625f@gmail.com

Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
Arun Iyengar (4):
      media: verisilicon: Size the VP8 segment map for the largest frame
      media: verisilicon: Set need_postproc before resetting the CAPTURE format
      media: verisilicon: Keep the CAPTURE format at the stream's bit depth
      media: verisilicon: Set the bit depth again when its control is rewritten

 drivers/media/platform/verisilicon/hantro_drv.c  | 14 ++++++++++++--
 drivers/media/platform/verisilicon/hantro_v4l2.c | 20 +++++++++++++++++---
 drivers/media/platform/verisilicon/hantro_vp8.c  |  6 +++---
 3 files changed, 32 insertions(+), 8 deletions(-)
---
base-commit: ad6549a46748d00818483b535e5cd2a704685c98
change-id: 20261113-hantro-fixes-aace04d5268b

Best regards,
--  
Arun Iyengar <aiyengar1990@gmail.com>


