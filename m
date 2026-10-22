Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792679276;
	b=zvYw/AK3q2Tx0eNnLvfsUU1IoE5ioH/ymn20d7hI4qUNCdORkpRYAEB+Des8EPw7LNfd
	 Py3lnzAeVkq+Ij7rBOUmJYuIrch1ZBLxLlttr5/RkAs55ROhgbbku9gA1djuSWb6UjIvc
	 3jB0K+D0Ff69eIhuGkve0az0Kkn8Kr7lD+X84rhtNWpAqGdfO/Js5c4lK6HNLYtrZDx41
	 OEd64PV+vM4IWXjxZZoyQ/Yx9hd25kaOEWHxH1QDQu33EJqGVG8SsYDm8E67UEIJmAkcj
	 9hEfWfFhVTKJE97GdSSctxe3oKVZjFMnXp4mjwvR5N9tnlCfb/TnUgcRPH/UvqnXxPg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792679276;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=PchrU+Va3DZaNKNckQ858GV5JoQCVK375UKKXHl3JXA=;
	b=D3LN05cS7FSDpIvuW5YRO7W/sPeEvjCdBZT4ObzqcIga5hGWAve6PWegmDD9XpDFZef+
	 /LrlnZI+OvZBGX1gEu/xe+43aLSoZhYhpBlLVh836CCQQVHHEYDpbEOufp0W2MqIjyJmh
	 25A1SONDwTeEcoAQdxeflPPx+1fTJ37sGZOn0qC7vmKfoo352gz6j25/ODwpshKy1ebq2
	 UqsrlsH6J4fNnjIHbrDipLKR/AIp6EmJwtIvKvgKnRVgYsvI2BZuxknAAqayzQ7w5pu+B
	 DAUgryqyxDkWEGY5dQnhoy4cbvfyzqqhd90+JZFSC8TjI+K4I6EOwqWgEwuMBHm+eEw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VadbGkM7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101A5606A31A;
	Thu, 22 Oct 2026 14:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VadbGkM7
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792679275;
	b=BmH1FibkTi6Lu9OxjV9eefwuuwuu9l4w9uM0xEx4DF6jjpnl6sYSCn9atvFp75j+2dik
	 eYvZJwYZWDyTdGAr/r27HFNCIpbE10gd7F7DgrvzJG5Q0UHnfvNNilcf24ZRDtLaIdEbN
	 NLLJUH65/IBh3r2Lm4gO4tx98aVm7unrRVRJXe63LIxWfW1DfFUjHKzKXOnn6mI5q73jS
	 hdd9hgJBDbgRUf9Cv/LFlWJQG7m9T9Y9Rlp+F/AdORzjS9YhpX9rtLlx2OMr5+RGYhteo
	 BWljocwepyEbvvngFJbxw0YgD/q2hhQxLjJbk7h82cIUlBiBRbr8rEwfAEpNoCXpXiQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792679275;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=PchrU+Va3DZaNKNckQ858GV5JoQCVK375UKKXHl3JXA=;
	b=YRVD1lLcqLvZ2RFHk/Hl/sEQEKChy2+RgFqMrkrtAwjUWAWwelfTrR7M59kwrGQbMPX4
	 Jp54xBwmHaFgVsSj1bsBLxZnDqwg2iyBYAC40DmwhWIBIGpHqMqYmRW4Wbp7fEeY8bKj/
	 SlJNA+mtk7I/aoNxqLIobHdCUbjjBM/cLw+mph6L9Yb++haolFvmkMzBZUnn8LygPes3f
	 1polyAeJkV+qHtXaavzOqDpNlYZxRnscHuNQqfN6gw/jlILRmuTOhil7N3E4vkFfbP3er
	 iDaQYy3crDFwmSwHuh8Za4/02eMAfUKbW4ZILrWHbO4JeFvpqpZwZwAWPLiJEi6y7qA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 26F0C1F000C9;
	Thu, 22 Oct 2026 14:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792679275;
	bh=PchrU+Va3DZaNKNckQ858GV5JoQCVK375UKKXHl3JXA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=VadbGkM7bWbg9Aje6k89FCVwOXNUdSTYT458Na67GeS3wabl8+FCfrNPJ2kpQ5RjS
	 RNQ/VUj8+LYKSTbC/zA3pkw8f4FWhxSuCf6b8A07DgREW4g/F3YW9uPEphQ30O04KA
	 0wKNdGjvLW1TbNqbK4cGGYKDmmLyRrLZsT1x+wsO6Br/AlHjTQG8DietO+fh1wBN/v
	 Ntmogm51OWk5YX3IuAhHahFfmVs4Kk8MRhOGfr5TxDqBMoVJhoHuJ5R0EOm74GUFsE
	 X6y0ILqNoaDjkN4l3jb5lMimr23YGOpuLqYpjLtyok3ufNHAtIDRtzulzrKgAkNTAr
	 V9nY7/viRytpA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 871B74359A;
	Thu, 22 Oct 2026 14:27:54 +0000 (UTC)
From: =?utf-8?q?St=C3=A9phane_Grosjean_via_B4_Relay?= <devnull+s.grosjean.peak-system.fr@kernel.org>
Date: Thu, 22 Oct 2026 16:27:46 +0200
Subject: [PATCH v6 01/13] can: peak_usb: fix missing CAN_ERR_FLAG when
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
Message-Id: <20261022-canfd_check_channel_idx-v6-1-197704231551@peak-system.fr>
References: <20261022-canfd_check_channel_idx-v6-0-197704231551@peak-system.fr>
In-Reply-To: <20261022-canfd_check_channel_idx-v6-0-197704231551@peak-system.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Wolfgang Grandegger <wg@grandegger.com>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>, 
 Dan Carpenter <error27@gmail.com>, Lukas Magel <lukas.magel@posteo.net>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Stefan_G=C3=BCnther?= <stefangun@pm.me>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792679273; l=1235;
 i=s.grosjean@peak-system.fr; s=20261020; h=from:subject:message-id;
 bh=yJYGMmDCA5H1YtV9p82vQMvFYiAXoP2GMFxyPs3vVf0=;
 b=giTbEhTDNz1JKGA3Nk9D3GSrBLoWSPvbnnTIHpcUF8ZsSexcQ7ZlE05peeDe8Iqr8U6Fv6Gol
 RpuAxRy2t86CfYYlij4CxeLs+N5zlrQ6ZAloDrY4zhZuo0pnNvNY7Yw
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


