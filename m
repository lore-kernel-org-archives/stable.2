Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793746416;
	b=u2PFVr80CtMCDwVjNXEeAbrpvzwSFunGJXp//ec+niaZ4Q71IGrs5uakMc6AgQW9M4tx
	 XnJnAEIiwgB4W8WlmqzAhegGaF7JkVt4KbMijZh0WomDDXouyE84ROT5Vrn185Y/P77dQ
	 fuv/76JQMbYvTS6ReTyUQyFaIDMeLg7pDKnV59wzbbwxKiu2oHG9gvSTuDvI4PF7wijle
	 VtCYt/Us2rzlAqqJ0ZHygp9u/ss5k5OCM3h2ctMBzqLUaveZMSseJ2AIu4SaTCSHe0mQ4
	 V4cbySyJm70tI3Pv9BuyOV9exTlLnkYLYe7/umRmDdx/mSiyt+DKQZRtcf9//vOoejA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793746416;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ELQT8PeElS2CLCx+BMjW8wK6GMbuf7QpxZNV1+LRRek=;
	b=0p1/lnRBWPm4tuGLZAPXCpoqDJ4ekAWhy/HwDQ8znYHSjgEAKpgm3wkznLCTryEDS4P3
	 VqZNUlyOoiar9LNCrzvNBLe+j3yUZtnE321Ghj74I7EJ5Jw9Fpr1QRaykKE2MLB1FJEuq
	 or5kBMRQPkN/Jy21L9gu2U96Vac4GYcGsEk0oNBVWkHacJSkTfP4EEjfM8ZX3SUSBhquf
	 EFaTiLfVjnUEPLnc1PVW1+A4adCpISz6r4SzUCAsuAti7bl2x+5mFZl/bZjqV/rYOdBMn
	 FAmImhRtXHTPBFCoxrCkyDpu8YM8NgPCC1cfsioaHYj1AgAjqxPOCwJNmI+qhDJ4gLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GHGKp09H;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D875D606A32E
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 22:53:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D875D606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GHGKp09H
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3adc4590de4so125152a91.2
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 14:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793746415; x=1794351215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ELQT8PeElS2CLCx+BMjW8wK6GMbuf7QpxZNV1+LRRek=;
        b=GHGKp09HKB+1avkemVAzp96e2ezvezM6SjbvPwIV3KBZhK2wNgjDcbhc+LP3ehYzt/
         nS6L0yz3E5rEprRbiEmc1QYT1hjnxOJCwq3/o0bM1hsHEANCGyIjqR1BdtvG4gcP8bpA
         3Z98DW3coGq+xNQW1d8pYNgThAC3YLjGiATRGzjbkWsqZIVhPYZizOexkRokQ1ESs3N+
         +HDdup2tg4/sKRCKc7zbO4u72KrHTi0MCShfUgZSjcx+dhwb3sPTOY8a1VI0mC1G3Ku6
         PH3Y7yrYeTiB98CnJXxxmCfdVJDFb7EDZqWvdEtBLp5PyCILwLooxssV7upZ8a/z6G0s
         ODJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793746415; x=1794351215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ELQT8PeElS2CLCx+BMjW8wK6GMbuf7QpxZNV1+LRRek=;
        b=EcsAz8fPOEY96VSNgZy3xzRF+xpM4nG89uN8theKIlVSyo0j611WNegavPH0llbOHl
         h4alzijoQeue/tqHqivI/0i84DeDyqRQFnt0pfwQ3z/8VRuvtsjGwZWCU0M5e8h8WEWH
         b71BTxdxWVDeXhPlVkaHdV9iZM0ynotzb6Q5VlLvBOfxnRmuHq0J8FqJTLouc4+WStBE
         7WJM8mhy5vVVAXsdez0waF0k0sCEGMy/DQZrvY2DaecwV+I9okzGeBkC4NkCTnjAJS1q
         jO59T8vsq7PyMr/HuUrI4dMGnbwY/L57PLhby0sTcg/apsrIsIYsNrE6YsW3YkA3Dhxc
         yhHw==
X-Forwarded-Encrypted: i=1; AKwUvBw6nvNLoh0Vy8+EPKnEP14r/hHRoCow6k05aVPZSYuoElC/fd6QC39NcILBTAcEL3k5qiA0lIg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+oBjt66IS8poNIuQnT0yRkdCfkxOgrf8gTpr5Wi/wAIuCdDGCZ
	ZQ5wyugS8HNs/d29uOewJea9iodFXFIXHzQPQGjwgv40YSoL0Hmx1rlt9eG7bhQ1buc7+L/e
X-Gm-Gg: AYBFou3HWskaCwk56fE5SIMmzsSecwPa/DbS53lVacku1FGea5t5lLqYIk4ZCXkpB/e
	ghxQz0SmMwCOBkch+d29+Dj+myfN/JHHJQMgLmXjboRyoYyI6g5sydXRKGIBe8IFKMi+u+jQEnV
	q/+zY2jMpfs+SddqyCXOx8nZgA955nQjq27m31XrOh+wR/YwwLFAMu4C9272pC4sRMkACi+8AOB
	2Ixeizqg9l+VHo+pZeoIoJ5pukcxH1n5sc+8mAM/L1O8DHKCWLOftXtRgWWagNWnZyxYb4pXKNs
	v8trnoNVsZIFn6XTIjcnKQGt1NTlSFfMW0m7l0TwvW99a7gwk/E99zxwn2WINImahmDJ5MpXKXy
	/OBh9RXCOb9Qv8eo/fyPNvXgQRnbag2hyELSU8UgmuEIt9YXY4DtskFZzAgcvSHymhLf02RsFBs
	6dCYW1AVu2eE9tU9ZS1MCRQxyBoOffKh60qJyrRjFS9VdUSOxmerb2HiCbcbXlIDzM5ZtmvRJxJ
	5qcu29NboMnYTgMU9gjP3sWHDaTe0Mg+i0+emM51/hpi2hgBKOVN8dcKXEJl8M5ME//EcIMAJIF
	XxvW/6alQ4QQ+VG/9FBsPc0dNJk7Ikd+66FAzzkFHTWKE+omGERespKTvSJZEy9Kzz4/X97OON0
	oD6Meepmp2D1opxhxHxQ5UT5lUEx0orx+5PT3eEnfkOelihwzA6/5R3LamCdM+SBlRgY+n8RRFX
	TSUoPIAecPPQBmi2RV/9OTOlUeQxVgmm5Z/0FnSvWpkxeRiRNsojGbWmJMF4KOUBX8jrZcUbzrQ
	ahX1FJ9KXAh4m8=
X-Received: by 2002:a17:90b:3e81:b0:3ac:8fff:5a1b with SMTP id 98e67ed59e1d1-3ae8982ab40mr12229687a91.34.1793746415281;
        Tue, 03 Nov 2026 14:53:35 -0800 (PST)
Received: from josephctchan-96c-1t.c.googlers.com.com (95.100.125.34.bc.googleusercontent.com. [34.125.100.95])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c896cc6sm6096249a91.9.2026.11.03.14.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:53:34 -0800 (PST)
From: Joseph CT Chan <jctchan@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Joseph CT Chan <josephctchan@google.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 3/5] spi: spi-mux: finalize message when forwarding fails
Date: Tue,  3 Nov 2026 22:53:06 +0000
Message-ID: <20261103225308.3633046-4-jctchan@gmail.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
In-Reply-To: <20261103225308.3633046-1-jctchan@gmail.com>
References: <20261103225308.3633046-1-jctchan@gmail.com>
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

From: Joseph CT Chan <josephctchan@google.com>

spi_mux_transfer_one_message() forwards a child's message to the parent
controller. When spi_mux_select() or spi_async() on the parent fails,
it returns the error without finalizing the message. The SPI core then
logs "failed to transfer one message from queue" and does not finalize
it either, so the child's completion callback never runs and spi_sync()
on the child waits forever. After a spi_async() failure the mux also
stays locked, so the next message on any child of the mux blocks the
spi-mux message pump in mux_control_select(), and the message keeps the
spi-mux device and callback in place of the child's.

This is easy to hit: spi_async() on the parent returns -EBUSY whenever
another device on the parent bus holds spi_bus_lock(), which mmc_spi
does for every request. It also returns an error when the parent
rejects the message, for example a transfer with 16-bit words and an
odd length, which spi-mux does not validate because it defers message
optimization to the parent.

On select failure, set the message status and finalize it; there is
nothing to restore yet and, with patch 1 of this series ("spi: spi-mux:
release mux when parent setup fails"), spi_mux_select() has already
released the mux. On spi_async() failure, set the status and call
spi_mux_complete_cb(), which restores the child's pointers, finalizes
the message and releases the mux, in the same order as a successful
transfer. In both cases return 0: the message is already finalized
with m->status set, so the error reaches the caller through the
message, and the core does not wait for it. Returning the error would
only make the core log "failed to transfer one message from queue"
once per -EBUSY while another device holds the bus lock.

Behavior change: a device behind spi-mux now gets -EBUSY while another
device holds spi_bus_lock() on the parent, instead of hanging. A device
wired directly to the parent would instead wait in spi_sync(), because
spi_sync() takes the bus_lock_mutex that spi_bus_lock() holds
(drivers/spi/spi.c spi_sync() and spi_bus_lock()); spi-mux forwards
with spi_async(), which returns -EBUSY while the bus is locked. Making
spi-mux wait for the bus lock needs a core helper and is left for a
follow-up.

This depends on "spi: unoptimize message when queuing it fails", which
is in a separate SPI core series: spi_async() on the parent optimizes
the message for the parent, and without that patch a failed spi_async()
leaves it in that state when it is handed back to the child.

Tested with KUnit (spi_mux: spi_mux_error_test, added later in this
series) on ARCH=um; before this patch they time out with the message
never finalized. Builds with W=1 on x86_64. Not tested on hardware.

Developed with help from the Claude and Gemini AI assistants.

Fixes: e9e40543ad5b ("spi: Add generic SPI multiplexer")
Cc: stable@vger.kernel.org
Signed-off-by: Joseph CT Chan <josephctchan@google.com>
---
v2: Updated the patch references in the commit message after the split.

 drivers/spi/spi-mux.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-mux.c b/drivers/spi/spi-mux.c
index a7ea6585b374..0e770137b5bb 100644
--- a/drivers/spi/spi-mux.c
+++ b/drivers/spi/spi-mux.c
@@ -117,8 +117,12 @@ static int spi_mux_transfer_one_message(struct spi_controller *ctlr,
 	int ret;
 
 	ret = spi_mux_select(spi);
-	if (ret)
-		return ret;
+	if (ret) {
+		/* spi_mux_select() released the mux on failure */
+		m->status = ret;
+		spi_finalize_current_message(ctlr);
+		return 0;
+	}
 
 	/*
 	 * Replace the complete callback, context and spi_device with our own
@@ -133,7 +137,23 @@ static int spi_mux_transfer_one_message(struct spi_controller *ctlr,
 	m->spi = priv->spi;
 
 	/* do the transfer */
-	return spi_async(priv->spi, m);
+	ret = spi_async(priv->spi, m);
+	if (ret) {
+		/*
+		 * The parent did not take the message, so it will not call
+		 * spi_mux_complete_cb(). Call it here to restore the child's
+		 * pointers, finalize the message and release the mux.
+		 */
+		m->status = ret;
+		spi_mux_complete_cb(priv);
+	}
+
+	/*
+	 * On error the message is already finalized with m->status set, so
+	 * the error reaches the caller; returning it would only make the core
+	 * log it once more.
+	 */
+	return 0;
 }
 
 static int spi_mux_probe(struct spi_device *spi)
-- 
2.56.0.385.gac671c819a-goog

