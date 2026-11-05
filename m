Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793851439;
	b=WpHIFoHn05kL69Hzp1fifxyLiHOPw90UkXcOUWaMGej9lY/vrrvzUcorbusQx7MsN2Jt
	 MmqDCoJUOB3BXvrOvh5uhAYnIWjcOhVSF6cxWKAC7nquksEUxBMfZK3qR8DjfktO0jssK
	 1C0D4EnvfT3jWX6b+rmw7mcHA64gZupQNoynDfX2liE28pMJ/9q9LaEmGON6Cbajk/oA0
	 wCy/uAGerT0pXY/AFg/iPnn2h/VGi6zxuKjGi7UNMcfQZBbpYLHwXM15/JZhaZFK6M3wT
	 g5efnTynyjPgJz/4mnI+4+znl4fznbhTwKjZd1qKGSC02PNPHwXw5IXojNpcMfNORSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793851439;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=AouVsEJi67JgAtqfY1MqGUWfrdWF3xPqbsbhWzfoN5g=;
	b=pckF7JW/wErtYueDtdo7IGpIoZ66lTq22uM1m7QCa6Ky0xUujgff+hWD9i17k/jrpxRk
	 oM9ATePACDevJGWhtKv99AGZSeLUWQyW/oQas4V5AUzOCrRZgmEz39sgG7ekAXzHYO/ug
	 Kd/ViLTrTci0MFnSR43d6jVkZTEjJqv4h0zgwpLLzT21kNXY3LbvwxkKWPguuhIsvnrEA
	 SWUl0RSzci95EiolL1MrBwB30u7x2pqDQUPEJDYVsBQ3r76lKL2/8b04M9YqC+CoEoZDC
	 Se0lKuum8E6FNyf/+A/oH3gIR7oH6FWpcKHOMtNfGJTBlFQPxDxOTnr5x3QCALteWQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QMPkghEB;
	arc=none smtp.remote-ip=209.85.161.52
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E51606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 04:03:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77E51606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QMPkghEB
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-704597ef1d8so622459eaf.3
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 20:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793851438; x=1794456238; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AouVsEJi67JgAtqfY1MqGUWfrdWF3xPqbsbhWzfoN5g=;
        b=QMPkghEBpkt8Ldmg6JQG6mf3EWelpLNaZiMfRPQmB1OmTdTwzKEwWrgEpPw1EK5V1Q
         lALkIlDp3yiEx2Zr5w2T6vNWiloqic/+yE9gB9h0jhKIagPbIaQNOcroxwWKfyE31Kzq
         l15Edr2y/vaPBY3/hHJDhLuuI3yFD3oVqEsnVQ5h0LvW2DmxUbT9KCBLSw6HOO+T8N/H
         5u7ghGm7pG9OaskIazdDFqv4xQUTzig2Ei3o3jsHf1VGrAuIuk8qsVXWou1Ulx7XdbKV
         kSuqdceAoYxQQ9kZs6iIUFBpCD5BxNz6KqYhGt7FUO7w4GFJUGWueKai4IT5WKXeeA9t
         ATdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793851438; x=1794456238;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=AouVsEJi67JgAtqfY1MqGUWfrdWF3xPqbsbhWzfoN5g=;
        b=wfqEoz43d6QEEgDQ2Z+4GzBaAqCulyCbw7swz0MiXKP4RFaeJFKGHb9Ip7M+9nXuHD
         7NjFEG3/NKT+K6RaVoetOIdgQvdP/IlO7IcWHpakXMUObodQnsEGcZYn6p45j7MwHqSp
         0HHVlA8vopznVBcUEgtMyuDP4ArPGXNTrKsZZ5zLPtRPlUYyy8gZjaFcRMtC6Q1TgaMb
         5TZ9hG/C5knaDxiP+kKenJ2ccTyLccY23mWuNPt0UN+SpS5nhi/d2afSMUuylF/EghFf
         fZ/COkEltQ/2cj/hzQzFVhhvZaJAYfduobylilFdftzyAIfAlzmfW53ITxhk4Sk1HDVo
         cp/w==
X-Forwarded-Encrypted: i=1; AKwUvBy6VyPU/aGmhXiDrvGWF3S02L4vqow9Kj/LX/QEesu8sq8TWUBOGGY4ehapzq0bFtDYm+6OMkc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9i7DCn0QQGZg/AKIf+Cv55T56ECxKRj0g6B+pe2FXeJBePyekr
	FLjfMu+HcXn5i6qg2GCnF5t03FC0028v8mCxFQS9G93Cy9dQ45wNx6L7wkS4Gwgo
X-Gm-Gg: AYBFou1Y9Xl59tAM82MWKvsgIh6EOMB+Z17w/KeQuENHhI/lU+8UgJQ78kC5ImRjlIQ
	iYKRycZjYKnOX3KJ09yOJsoD/YW6RXxtu0Od8PMTPsvxl76NlSduT5BlF+xH+fraEh6y53V/mjw
	XHdAFRAJUXy5vySqfq7ZIHyLmdww82FFnJ1PZ6fCNMAHaEP3CM5cr109ys/k6u2nRUGALBxt5RM
	pjL6/1KlPlFctLb/0Ym7MiO/cmrtzTUMlPOmYN+6A+0OMvZG8buHx1UzOHft9okg/1pnlfhunzT
	NNI6PY92rPKLbXL6KxWCGNjoRBH+6Ig8EXJfutpl4QXLnl9bx3UU0iJLT1XrKGD2+8UbHfwXXly
	VujNWYTtLXvmqBy3GE8Y8xHZeqyTg+SixXYZC+pDVb0mHBhXwKw5zp/Tjy3LVvyOLGTPpnaILX9
	zy/NHf65GmpsAyp5kycrhX2E6bxLurVFzZkjH+/4cKnvLlxyeCWiJmxAuMV/RWUsUNCD6jAdDgF
	kaeuV8k+1GD1fW9yDfPfHEE8WiGFhPbtVkymJctRiiSJifh7gITu0zXxJVPvpXPdg4uP4D18S9O
	nXO8nuy9CGS3xjzLx0PO8UNbxLLm//wv9WUQ+28C3QlXMzv57jmFZ0gkBxC9WMwWGUHKjpSO1U/
	s0/LbyXg5L7ybrqHl1wxrSvAH91UKIKIGlrdqmf+fqxu0mQXI+9+Y/K2nvz4W5EfvnwtHNhxVRv
	gZaRJxKFCdnxhwW156X/xDRBqhaGDJPoMAg/c1KnErcEIjPZ8gt6jC0qGnclMyduIXM+KBI/GI
X-Received: by 2002:a05:6820:560b:b0:700:dac:ba85 with SMTP id 006d021491bc7-714f295ac1cmr6702854eaf.14.1793851438261;
        Wed, 04 Nov 2026 20:03:58 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-716c12d1f36sm3018997eaf.8.2026.11.04.20.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 20:03:57 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 04 Nov 2026 21:03:55 -0700
Subject: [PATCH] mtd: core: avoid overflow when checking data bounds
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
Message-Id: <20261104-submit-mtd-oob-bounds-v1-v1-1-05209fce5a3e@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBA0avIrB0wQ6ulVykuTDJpp2BSMlEK4
 t2b6vIt/t9AOQsr3JsNMq+ikmKFaRtwryk+GcVXA3XUG9NdUBc7S8G5eEzJok1L9IqrQXJXF24
 UaOgHqPknc5DvsX6Mp2v7Zlf+P9j3HzneXbd8AAAA
X-Change-ID: 20261104-submit-mtd-oob-bounds-v1-2c5cf82f2767
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Boris Brezillon <bbrezillon@kernel.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

mtd_check_oob_ops() adds the starting offset to the data length before
comparing the result with the device size. On 64-bit systems, a request
with offs == 1 and ops->len == SIZE_MAX wraps that sum to zero and passes
the range check. The public read and write wrappers can then pass an
out-of-range request to the driver.

Validate the starting offset first, then compare the data length with
the remaining capacity. Preserve NULL-buffer length normalization and
empty requests at the end of the device.

Fixes: 5cdd929da53d ("mtd: Add sanity checks in mtd_write/read_oob()")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/mtdcore.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 491a27d0315f..dda976ef52c9 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -1670,7 +1670,7 @@ static int mtd_check_oob_ops(struct mtd_info *mtd, loff_t offs,
 	if (!ops->oobbuf)
 		ops->ooblen = 0;
 
-	if (offs < 0 || offs + ops->len > mtd->size)
+	if (offs < 0 || offs > mtd->size || ops->len > mtd->size - offs)
 		return -EINVAL;
 
 	if (ops->ooblen) {

---
base-commit: 1c1a342aceec79528b3ba51f376eca2be5928fe7
change-id: 20261104-submit-mtd-oob-bounds-v1-2c5cf82f2767

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

