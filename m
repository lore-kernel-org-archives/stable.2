Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795079919;
	b=IXKO458aVLHOwDAfYq1nhPRU/Pge+xdmE0QLT3Si6XhFyIhsz2J2xPI1OWqb3K7zOTWh
	 0oujkoHct7cwmBgLSFsd7rMsCO9QEK5nwDuEgb31xWHVMOIPu711Y/EkcUEvmANVtfDE3
	 007L/CUDEdH84nKL/6Zs4qfJo74xolfNrqckAtE06zrjTLGvjvSjp6Nw+hz6159Ylvhia
	 yAixZaIgIOm+03TcmfdG1vjYV5T6fqoYMCU8bKAbunVa3ZXd7KoDUnLdoGIiH2If2WDJQ
	 6ogY16ot1oX//469bk00/oCAG72BhBz8BltGheu4+FCqlo5Dy6ch3bJ2JI3fNqCWpGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795079919;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ylRfn6+f4PgOQwYEpPxoGkzBeET3eXfijh6GNTP79AI=;
	b=P+sJJV4P4VG3/OoVHdWPNCqhl5KBVIkPVDHPwfH3rp10QmY4U7mkJ09a/38zjssqhane
	 G8ks1rYdualBVg5pi89QvUVpTYB2D/vOimWFu/RXn/F+bVpXMJVHdFoMRy6MTi4GndFFq
	 9h9j3sYIr2p4/pfvkmuFnZnSWBSgmt6068EMJQxL2SoUgHDGQuhljL4Y2OifZJWgsbkVf
	 JX1/nxlvM9eyMEKqZm5Sepqu5HKRJrxVYWRAuU6KFOwPvrm07sq9F5Be2+p8q9IzSXn6v
	 R9evHT/0ADP14f2LXvn/zCdrOVWFwm8yZwFlXjgf5ER39Xsa33nxpRlr7dXgE1pexeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nBGBmijz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16CF606A332;
	Thu, 19 Nov 2026 09:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nBGBmijz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F9DD1F000C5;
	Thu, 19 Nov 2026 09:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795079919;
	bh=ylRfn6+f4PgOQwYEpPxoGkzBeET3eXfijh6GNTP79AI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nBGBmijzVEU+Ob69MLLC7KhodquSSH4l0RiiQT+d3BZlZ5kKEObC86EWDaQJQwuwF
	 hIpwR+4FJeb0CuAQ4enhdWHVmWv0RGFBmgkhqzH0vcqJX/7e16pYvzZzMhGDgnLmrG
	 GtjCKcVsNOOjNSbqRDNbMQGfOoCWNUYzOHVIJEP4ygrZvT24PDXNyKVRQFIQRWbvQu
	 0W/v+Gw8eNOtPLgmm0avcCBaqL7LFg2dq4Nzw5mk2PuQLWyLl61I0CrhZCo+5MpRs7
	 8oKcWOwedTNHHuJmguZH9HhbU2Wq8XgLQI+GDpSw2tw2YHcstCTN7gPTb2pqbzpJzo
	 YwOPlHIninJeQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Mark Brown <broonie@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Johannes Thumshirn <jth@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 03/10] spi: ch341: Limit transfers to the hardware packet size
Date: Thu, 19 Nov 2026 09:17:15 +0000
Message-ID: <20261119091810.3440619-4-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
In-Reply-To: <20261119091810.3440619-1-lee@kernel.org>
References: <20261119091810.3440619-1-lee@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ch341_transfer_one() clamps each transfer to CH341_PACKET_LENGTH bytes,
of which the first is the command byte, so at most 31 data bytes are
moved.  It nevertheless reports success for the whole transfer.

The driver does not provide a max_transfer_size() callback, so the SPI
core never splits longer transfers.  The remainder of the data is
silently dropped, and on the receive side the caller sees whatever was
already in its buffer.  For spidev this means stale or uninitialised
kernel heap from its bounce buffer is copied out to user space.

Report the real limit through max_transfer_size() so that the SPI core
splits long transfers into chunks the hardware can handle.

Fixes: 8846739f52af ("spi: add ch341a usb2spi driver")
Closes: https://sashiko.dev/#/bug/linux-a21e23dc-14b5-4ed1-bfba-f508132e11a0
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/spi/spi-ch341.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-ch341.c b/drivers/spi/spi-ch341.c
index 56a5caa5975a..0783a2d39a61 100644
--- a/drivers/spi/spi-ch341.c
+++ b/drivers/spi/spi-ch341.c
@@ -63,6 +63,11 @@ static void ch341_set_cs(struct spi_device *spi, bool is_high)
 			"error sending USB message for setting CS (%d)\n", err);
 }
 
+static size_t ch341_max_transfer_size(struct spi_device *spi)
+{
+	return CH341_PACKET_LENGTH - 1;
+}
+
 static int ch341_transfer_one(struct spi_controller *host,
 			      struct spi_device *spi,
 			      struct spi_transfer *trans)
@@ -187,6 +192,7 @@ static int ch341_probe(struct usb_interface *intf,
 	ctrl->bus_num = -1;
 	ctrl->mode_bits = SPI_CPHA;
 	ctrl->transfer_one = ch341_transfer_one;
+	ctrl->max_transfer_size = ch341_max_transfer_size;
 	ctrl->set_cs = ch341_set_cs;
 	ctrl->auto_runtime_pm = false;
 	/*
-- 
2.56.1.708.g77570a6a1d-goog

