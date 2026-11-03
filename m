Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793746105;
	b=qGQTIbdxs4/I8/rLrRZYP+dsWoLUZQbRo+FrBLXMu1UkY9UQwAlmfgwgRbyeRu/iqJMa
	 CA0u/VkL5O4aWRR8hqgXsEtc0dbMQx/snIeKuhx+c5Zniuk+u6wz3DPC5L0LqD1Q2MeX4
	 /zplWXH+MPoxEsLZkGJzdwNMeKee01IhPh/e4Ux8BERvWnzyMP1rwJ342J5Ob/ORp2eS4
	 YKg6IcnT20XMQ6fZzEXAukY+rNbDBTLwFZVWYbbg70NgVZrWaPAzKbY0xe/Yi79KDuS2f
	 u/OftHiIN6exg5fx5hQpvHy7AXCyOVHUo1d87YLqRI/JZ/FS+7LE6q2HdxHoJH022CA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793746105;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=dARvLeluVUPCf9P8XMI0JaNPOob4l9Gy1vFeKqsjw1Y=;
	b=eUIpEbfk8cSmCRi90dgbTaTlnLiVWtwv/7qfvBZt2rQSCCXYyvW8SRysgcPT+x1g+dbV
	 W7vBgyigQ6pNcz+cbCWAXm2XyxNjVt0o/jj1PhHRutDu+c84e24ZJfoCFlvA48JW2H7Hz
	 GkqVbQzCPEodid9m916J+OCyKqtiBTDKm+HVkUo2AwzGZcHsw9ftVKnew/EnP0xovgivR
	 8/rO8x7HJLm+ks1AKt/3gkyPvKtl7ijd08NJLNhT/3F9vVSxZmBrcWmpvlHXBTlFEd8jg
	 KmqzzHmtR1fPkccbDiHDGXK0HA54sJqtQncmEIjCkrsh5tyeaqaEBPn3qR+yOwciT0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mpHk7d0w;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CE9606A338
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 22:48:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37CE9606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mpHk7d0w
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3ac78f4c10bso75368a91.1
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 14:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793746104; x=1794350904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dARvLeluVUPCf9P8XMI0JaNPOob4l9Gy1vFeKqsjw1Y=;
        b=mpHk7d0w6Z9ihxp8ADY2A/eqF6TSSUMTNSCgppLUvmt1fkqOj/WjnGf3R3lbTGgUrh
         dMWEzDgaTlzQRtIbrPfqYWW7w/CqeyGcvBkwK3qIv5NmSdsb/SWYCANJRzuAIs+F/RaN
         YzE0xpy4Q7LK4zb3KWEJcXIelHkvU7IpofR0M1YH0Mi23Z4bxO/7pxP3JiDiVxE8++P2
         aTWnv3rkY0BhpsGTC9ejM7/kS9zdzxm2DnLpGEie5g1YDIILu615W/46vKPmY2xJQRmD
         Pb/WDE9DiibXMt4S99eeedEczc6wEXk9TtU9E5UodmAz75oYKeLOre0dzv1IqUqL0YvN
         VS4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793746104; x=1794350904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dARvLeluVUPCf9P8XMI0JaNPOob4l9Gy1vFeKqsjw1Y=;
        b=PYByry9nxmwPidi4V1lWKzNnSM+675W4thWjF15yldj/kZ5kUq5N2AIREhiC77gVT1
         Nnlv5XjYw6vEm2iHvmpxJkr5NTSHLon9XnWNjKQP6vcjSbZs88NmtgbYW6zHvgckes1v
         tYab3lqe2sWUAkd9WXcP7gjxQb406vbGdzBRWnCwa3LR5tB3QDYfyALMMbnyYWO7utf5
         G+cSkXc4ew4kyd65qeZvaPLzGZDttjGhy9wOyEd0vTldKm2BABtTexIMYlruZIDQ8HXL
         AaSCPO2Tw1uiDiQKoedDIxVxySLGZStLamrA00bmq4BJDMf3MttHeMPv4df5J1CJbdjg
         d9Vg==
X-Forwarded-Encrypted: i=1; AKwUvBz+sib+8SGPDujAdBwvDLTG0nWkGM1MhS/SUwd47ZbHElm11TIrPp4q36EaJ0VxXUIDG4jvnzg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9L1wjTd8OSfNsHZtkmrwA76KkL9Knef2W02c92IjCdwwOssTfh
	WUdLbVkuXfDHLB5c3omu9YiKYUKm/lqkKrYbS32C8Mg4xH9/Ldt3l6sn
X-Gm-Gg: AYBFou2dNlcfTX5RqAv//gM0p/+YvlgGbE6HFEGPOWZOedJcs/KyDynseT7ff/rs9Zd
	ESE4PPQqg6jTWQY5f3Tj/Oi1RCe0C55a/a0rlsB6UPi+sDcTy9Hf5yDWY03/dR8pvmxe8V0fRfn
	2vd1uMOUbT5kn8w0axzHNZcTqEZow0afFDMqXAfOmlLMHc6msFlQ27OukJ/l55IxPIaoj0X9eXB
	FpDXaI7vN1ToE8Bx+SqAjWc4+Owu7heyUkiZecn1bOdBdJIrrLG+1zxIfk0OgUVgvr+5lipgnYp
	YYoV794lWTWC8bQsGoAN7XpU2V2uHYbm2HEI9CjJ6NWlnOl/POUqzwae8MYYfSM2BKI02D+Y/bL
	1J+95sSOmKzcKia6nD6HYT8TThD96U39OPTEw4zpRE9Hi/l45Gb4xvtD0tvKvSa2P628Ex7/clq
	VjU0sbVe5BjUQt/1rulqlH5JsabgCcI8WnHSc6MTyJG4feytsr8ZRbdpv1lDqfJScvpoWf0bwrp
	XkEEASMdFeQYqgBoasYOEWQUXaMxL1nbrZwOsxvNcUVd+LU2+9Z/7QFPISlVXMOpA2V5VkEVj8a
	+UC6O6ajdO4UorbemuD3VCzaNxOptlwUHltscZH9eLTHlv9ZF3Ffis9nRI6euVVkPHNKZG5KAQR
	sT96qJCxtyeheUxRQ4fQyE3dDHsPdYSFuJCwubimCdqNh1AcIKZ0voEih5hDd6fqApYSzArWTL8
	W0oqDtJLy0zKaYeGfmt3wQptprhP5m3YRGXJohglfGODLlgDtsiJbMZYGDhYkhSaeqXr/9JByS2
	26xLcDZewMVUsk=
X-Received: by 2002:a17:90b:5404:b0:3ac:b3c7:de14 with SMTP id 98e67ed59e1d1-3ae897c8bacmr11921969a91.61.1793746104533;
        Tue, 03 Nov 2026 14:48:24 -0800 (PST)
Received: from josephctchan-96c-1t.c.googlers.com.com (95.100.125.34.bc.googleusercontent.com. [34.125.100.95])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0982e9284sm129962a91.11.2026.11.03.14.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:48:23 -0800 (PST)
From: Joseph CT Chan <jctchan@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Joseph CT Chan <josephctchan@google.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] spi: unoptimize message when queuing it fails
Date: Tue,  3 Nov 2026 22:47:52 +0000
Message-ID: <20261103224753.3610049-2-jctchan@gmail.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
In-Reply-To: <20261103224753.3610049-1-jctchan@gmail.com>
References: <20261103224753.3610049-1-jctchan@gmail.com>
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

spi_async() and spi_sync() optimize a message before they queue it.
When queuing then fails, the message is never finalized, but finalizing
is the only place where the core undoes its own optimization
(spi_finalize_current_message() calls spi_maybe_unoptimize_message()).
So the error paths leak the split transfers and the controller's
optimize state, and leave msg->optimized set. A caller that resends the
message then optimizes an already optimized message.

This happens when spi_async() returns -EBUSY because another device
holds spi_bus_lock() on the controller (for example mmc_spi), when the
controller's message queue is stopped (-ESHUTDOWN), when the controller
has no ->transfer() callback (-ENOTSUPP), and when __spi_sync() gets an
error from a controller's legacy ->transfer() callback.

Call spi_maybe_unoptimize_message() on these two error paths. It only
acts on messages the core optimized itself, so messages optimized by
the peripheral driver and controllers that defer optimization (such as
spi-mux) are not affected. A queued message is never unoptimized here.

Tested with KUnit (spi_core_optimize: spi_core_queue_error_test,
added later in this series) on ARCH=um; builds with W=1 on x86_64.
Not tested on hardware.

Developed with help from the Claude and Gemini AI assistants.

Fixes: 7b1d87af14d9 ("spi: add spi_optimize_message() APIs")
Fixes: c86a918b1bdb ("spi: don't unoptimize message in spi_async()")
Cc: stable@vger.kernel.org
Signed-off-by: Joseph CT Chan <josephctchan@google.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
---
v2: Added Reviewed-by from David Lechner.

 drivers/spi/spi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 40cda0037ea5..0d36460e2c87 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -4906,6 +4906,10 @@ int spi_async(struct spi_device *spi, struct spi_message *message)
 
 	spin_unlock_irqrestore(&ctlr->bus_lock_spinlock, flags);
 
+	/* The message was not queued, so it will not be finalized. */
+	if (ret)
+		spi_maybe_unoptimize_message(message);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(spi_async);
@@ -5009,6 +5013,9 @@ static int __spi_sync(struct spi_device *spi, struct spi_message *message)
 	if (status == 0) {
 		wait_for_completion(&done);
 		status = message->status;
+	} else {
+		/* The message was not queued, so it will not be finalized. */
+		spi_maybe_unoptimize_message(message);
 	}
 	message->complete = NULL;
 	message->context = NULL;
-- 
2.56.0.385.gac671c819a-goog

