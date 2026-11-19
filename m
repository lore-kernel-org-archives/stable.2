Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795082776;
	b=G1kQ8hkyzGihDKxV0zSk+YSZL4eC7gUOxTXNQydKh5SnCyAKDv9A9O+HNjtJ3gOR2Nox
	 o7P/WjG2nG780XJ2cRam3HdLzx0CRV/ul4HwlSUMPFnETNS4EZyZ5I8lVimwEfaIAzLld
	 mhlIox0JHOp6aACzssw57XhIIfSZ4uCiLXUxTi59qhRPFz0BeZgBalzu4EicV+CRxCg0L
	 0fq3TlP53PUqhxZPAUA/GzM8oWqpHziyJtbbjNB4xKc6f9BNP1f+dt6ubeiulTAULJBEf
	 eUJ2pFQm2DDQFyJZRhERzql7dV4j8aObFwcykwf2QmjQWRNwRD6dh9A5zVVA53ttflw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795082776;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=G+yf8Opi/PoX6Tds8cSLMSM4duoTp3+4gtT19yIltIM=;
	b=5WDrU/LaS9z9QvZvHjfMNNXruIhE/e2pthRIUrA++G8SjriaF77Sun7t7xprRh2BX/bm
	 5GJPQRScnOXMoMqpM3WF2qIW5EAVo2PrInncjUfhsA6BAxx5ZQllQPoQb7NNittqJtb/+
	 L7T/WXBle6GRMLvJpXdwOiSQH97gpWg2aK+bOCAZTgFmt2DuPtf9uABE6VKehj03MjhNW
	 Oh7IOTfdZMRmnlA1nedh7mEYyCbCIkmPrm36f4yq/7f8HLATEPFAUYCPdQQFv7j/T+F9t
	 QvRgnqJsL3OSdSKDRyKrgbH3F2XJ17T2uT9S6o9RR7bHkLsNMFPl1vSBLCSWnpWQqEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vYiDeVvD;
	arc=none smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BA3606A324
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 10:06:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11BA3606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vYiDeVvD
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cde5a7d7849so165361a12.0
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 02:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795082775; x=1795687575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=G+yf8Opi/PoX6Tds8cSLMSM4duoTp3+4gtT19yIltIM=;
        b=vYiDeVvDZZwO3XnUHlYSAYnOM7R82X2/ZhQ30J1E4KOLubASfUN0xid/RcP/M6xe2e
         VN+Z2NYlzDCwj9pQE13L9P7xalWnZfAnwftfOEo4l+9k24BfjxYk2hExbx0dkgRC514S
         ChaJikPDl98E03ZSoONWrIPvSFhNVO/tFZehVH2y+xiLi7TFIuZ0910eMcUfBsEkSxhQ
         +y52k4tm4k++EffDiRQMDmwkbsyAWweUpaVtMUvt4JIyrBq74KZqmjxR2StMkkCrUtjT
         I+1aheebLQcWNMZfvCld/GdoKykFW4AhBEgoevqoRv6//N8dE3w8+8yaM9pvY6ul6s8c
         cTOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795082775; x=1795687575;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G+yf8Opi/PoX6Tds8cSLMSM4duoTp3+4gtT19yIltIM=;
        b=YsVePuMp/O2Yux3GGIEn2yA+Ssj9NCnM5Ld52WEtMYTmzwoA3NrbanOl96Z84vpDb8
         Y9hDoV6USg9SGZB1Wvor14bHjhNjTpxXvecH5SfC3lfVBjNESgMhEIalleBouEDGkHW3
         gt0GElT2nAxwwvK2lH5NDGje3XG6wWqngM5sdcti8HIHvcQdtY78bl0Rscj4IuS57SeR
         mPhWDd6fWWJLPNNLtJPsy4klgFT5C5IuMDOnvdFCWlZVfyO+ldE6jVU65jJL9xTkHBab
         G+iMdaq2Qh7UF8so9EI0aCfpObp5P1/OCqn5C4MTlesK6kPlH9NfqKRx/905KNglBPvd
         Ef9g==
X-Forwarded-Encrypted: i=1; AL+hErEtqTlrIf0fXW6ft0whjnQI4Hnu3DbpzqeGbxZSFTFfjHZX9TSCDSDmfh7jQvhXhimBXqXEr3w=@vger.kernel.org
X-Gm-Message-State: APuU4Z9XugWtEp6+DOdGCmpt3ixjMrCww6sO+HisnA/UqATxgJ8BLlFX
	vFgStl/8/46AO0UHl+1pYEOWTgiIFT/xPN7n4q1J2qe/ggOngh/OXis=
X-Gm-Gg: AZFdTZdfwfiVj4etxy8LIhKtqHo+zzxmALCAGaZHhLNvXZyM+ucogIYrUaHapkaYTtA
	hAOs5VJvAoQQCoqoksQlEPVQbd8siRVE+SXJS5s3F7ZdpJ5oOOSiU3SWx8BQH48E+j+M652UyJY
	SRMUC9D8k60UgajRm9inssPfCEiWGfLZC+sRv5Vsxpx4PrLGJdylUxPYQiS4rb4qbIB+ASX9mH9
	o7B5gv2t+mjNWCOnyAIREYpTYsU09GZhlNG6eLpxHd1/Qcp81C9j8JpTmeYBxmPaCikgTOwU5VA
	U33ayVfxvkstlVF80BYy+s3lTxn2ZcEUjNyxSDjXh4FwWA10/tNg5uw/XAwE5JM2p0AcdhfIvfv
	gLj+ntNX0ZYvQNT/NpRNaFredYqNFwBxARe66fYL8KPv70lsMeSCV132g1aCfOq3Q5ZnhlEiZZx
	tcLwuCRI9si12yrSOlC/1dsxC5cOLZJc9sZgLtIU+PHVV8pdcc24ZEyCPDR2gL1w75cHqOMS4RN
	IBkjygOikpPtF3Z99+hXjV8VgrJmYb/yvfdNUvRmyDcWlgW6oHHGth8JKigFF7ZiUQxQDAMj8vY
	I5ScZI+A9rNM73ZDmxgC7q+DSpJ/UMQqgs1d4ZOGOBApcUrhabvnYeliD1Wq6hduRytF
X-Received: by 2002:a17:90b:1dcf:b0:3a4:e735:b39d with SMTP id 98e67ed59e1d1-3b3d0815de0mr5023900a91.64.1795082775366;
        Thu, 19 Nov 2026 02:06:15 -0800 (PST)
Received: from localhost.localdomain ([2406:3003:2002:639c:e9b9:3878:5565:ae99])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eff62e38eesm28622955ad.76.2026.11.19.02.06.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Nov 2026 02:06:14 -0800 (PST)
From: Yige Jiang <yigejiang86@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>
Cc: Yige Jiang <yigejiang86@gmail.com>,
	Eugenio =?utf-8?q?P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Francesco Valla <francesco@valla.it>,
	sashiko-bot <sashiko-bot@kernel.org>
Subject: [PATCH] virtio: Release the OF node when unregistering the device
Date: Thu, 19 Nov 2026 18:06:06 +0800
Message-ID: <20261119085343.virtio-of-node-a02bd3cf522b@gmail.com>
X-Mailer: git-send-email 2.50.1
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

virtio_device_of_init() acquires the OF node reference once during device
registration. virtio_dev_remove() currently puts it on each driver unbind,
although rebinding the driver does not acquire a new reference. Repeated
unbinds can therefore consume references not owned by the virtio device.
Conversely, unregistering a device that never bound to a driver leaves
the reference held.

Move the put to unregister_virtio_device() so it is paired with device
registration. Save the node pointer before device_unregister(), which
can free the virtio device, and put it after unregister has completed the
driver removal.

Fixes: 694a1116b405 ("virtio: Bind virtio device to device-tree node")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/all/sashiko-outbox-203883@kernel.org/
Cc: stable@vger.kernel.org
Signed-off-by: Yige Jiang <yigejiang86@gmail.com>
---
AI assistance was used for analysis and patch preparation.

Based on next-20261104 (8b7179210b22).
The same OF node mismatch was independently noted in the linked review.
Compile-tested on 2026-11-05: arm64, GCC 14.2.0, W=1,
drivers/virtio/virtio.o; baseline and patched objects built without warnings.
The code diff is unchanged from that tested version; this refresh adds
the public report attribution and updates the mail headers.
On 2026-11-19 the patch also applies to the identical virtio.c in mainline
4405c18c95d2. No new build, hardware, boot, or KASAN test was performed.

 drivers/virtio/virtio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index a8588d7ad109f1d65135dc7394b1dd4ae04978f1..c8be1a3f479d6abf1249f5fde66b6c93cb260d0d 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -381,8 +381,6 @@ static void virtio_dev_remove(struct device *_d)
 
 	/* Acknowledge the device's existence again. */
 	virtio_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE);
-
-	of_node_put(dev->dev.of_node);
 }
 
 /*
@@ -604,10 +602,12 @@ EXPORT_SYMBOL_GPL(is_virtio_device);
 
 void unregister_virtio_device(struct virtio_device *dev)
 {
+	struct device_node *np = dev->dev.of_node;
 	int index = dev->index; /* save for after device release */
 
 	virtio_debug_device_exit(dev);
 	device_unregister(&dev->dev);
+	of_node_put(np);
 	ida_free(&virtio_index_ida, index);
 }
 EXPORT_SYMBOL_GPL(unregister_virtio_device);

base-commit: 8b7179210b22f8e48a82c5ceacb9d56a9c4cfec4
