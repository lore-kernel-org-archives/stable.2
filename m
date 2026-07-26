Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A65379EF5
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 08:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785053059; cv=none; b=gcoOIfBxDg/yaQZ24O/TNFpqKweHRCkboSgXM7iaPA4FkAUn93z9fZhLDD4PpP2jV6+HzrWKS2qRW5mCfjIiqDGT4n6PqBaYAeX8L9Zap5VwMNYO4YmVIDPL7VFEEiraGlbNY9ndhil1bwfWvpGQ18GzwoYsxD4usDWZ32G4G5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785053059; c=relaxed/simple;
	bh=JPDvRgPMEgrp/SfBhoi+eonuQeUKz6vijZ1u2OR98K0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ftl/wZoJKtvIHKi9kQHvQpC2zzS7RrbPHfjlJgJSGICG+CuJtsUcve+BZPACVyPQ22CqXpDUPPuFBLReuMWRDWc/n3fxWL0ATWKryZAlw3ynvk5S/dynpGsg2YFANQT4GI3gd2r86QnMcDtgfzDRavf8WXARHnw57zY0raMJUeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tKOTeF7E; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tKOTeF7E"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cad4170e8eso26326085ad.3
        for <stable@vger.kernel.org>; Sun, 26 Jul 2026 01:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785053057; x=1785657857; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0cSaUuxqvKb2G+bbaTUBH2R6mWDoaRfWDXnqyNQToyg=;
        b=tKOTeF7EpvgbKrfJWXlXDDlW51iMk3rtTICMCzgkNRWvpxvhKdYlvAAv6QrNzPNp11
         nwcrIpT2tb/KKC9rcyFG2XpnJCfzEy3uDyzcp2/s2uN+QJTNDNQ8/7+rD6GhYO0v8ry1
         ATLsfA/R4qiBWdJn12h7VwToj1BrsDFZI5NeLuXRXUkCKq+UEudEsjkXpqU1i/HRDMSR
         NuUIhpKuZSdlEni6we+DkDufSN7RQnIS1PDHlldeuOwghDzyfnssnHiEvhyj6EWM8HS+
         DdCk0u/jbdg3KHcu7dVgvlbiLE0BaB6h1kLghvgynrbuH0jHJc511UzY9WeS/9h+OQ3K
         saLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785053057; x=1785657857;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0cSaUuxqvKb2G+bbaTUBH2R6mWDoaRfWDXnqyNQToyg=;
        b=mbacIydBsifL/9iojh53uPYwD+vbywuCDFAxluAR8oxBLe0eld/xPeySG3mjX5+cZ3
         ojJhtPdf66ouu2hTZdT2A1PRolt0OOWbjGPG/cogPc0N0yDmA7/RlBMewuV+1GSGbX18
         RSEQW15kSaGX2cH/u+OS+49cA1aBYfoj7D1QTBjGgyNT1KtaohLoveZitwYRpnqEyGZ2
         LrKMSZMO3vDaB2ZhDJlJbz7FCC/6RrRKb6K/ySa5adPWgQngoJHrVKmi9CZ5GrlHQNhG
         /jWoWgghWSSyvlrpCy04qM9S6EuzXsgtDeC1PbkCMtSNKNnhg3yU+TdQ8OvgyH7mlslK
         8O5g==
X-Forwarded-Encrypted: i=1; AHgh+Rru3ZFTofEzqyK/YFAYjwQCLZL3Qum19KrY9F/sS/KVhDt3VJY3U83qRxqaV3L6gg3zXuvHojQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdEbU+9PIo7hTW4goXnBeWvV6VRCQ3LzR5GhCzRw4VzL/bLkNl
	dO75TZbCeyue5L1Zc7i4DNG/DQ68ZQbDq9SRP9r4fcUtG+i09L2G3sOA
X-Gm-Gg: AR+sD13Ubc9+SL9gD9IFknej1OCfSZVr7ykej9G0aDnrVz+sCKf51W1ECfPFMLxTmou
	gvnjt3sZ40R92ToGOob7d6uEPAeipAlhnS/1d4PAf1grM0qEvVlFeCTiZn3ZAtDVkaDfTeQ8tcC
	AiebA5qq4kgBX93sZ3jCXaV79iLWTrSRlR1oX7QirV5nH9+wP/ecP4/gmf3t/ofixyRsmopl9Vs
	Frg6ifSghKyRUfBXhFrBLZU0veGDWk3Az8/AJMRWLZ2NRzzFUnner5EMP8nF5f1U00HbkCGDhSK
	I2quKx6vv3p6FEyUkroNoeq1SgOU8otONXoZq5EkPJ+vaabLnnYh6LeHeRPGZjaGvuY9zpTSkK1
	XashHwPb3BILcwumdMMn05XEBS8ULNXBK/UKvNVbgyLk2dkLm/P9GGB9QuiCq+wlvKlVEzYnUPD
	4El7isKkn6s+3dCxlJ4/UC+EktBPqIu58okPSd/+2/Nz3baQntChW01+mjv7h8YPI=
X-Received: by 2002:a17:903:24f:b0:2c9:97a7:71af with SMTP id d9443c01a7336-2cfde885b28mr39561865ad.42.1785053056893;
        Sun, 26 Jul 2026 01:04:16 -0700 (PDT)
Received: from localhost.localdomain (211-20-143-81.hinet-ip.hinet.net. [211.20.143.81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde5e2b8esm17503365ad.31.2026.07.26.01.04.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 26 Jul 2026 01:04:15 -0700 (PDT)
From: =?UTF-8?q?HE=20WEI=20=28=E3=82=AE=E3=82=AB=E3=82=AF=29?= <skyexpoc@gmail.com>
To: Israel Cepeda <israel.a.cepeda.lopez@intel.com>,
	Hans de Goede <hansg@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-usb@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	HE WEI <skyexpoc@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/3] i2c: usbio: reject bridges with undersized transfer buffers
Date: Sun, 26 Jul 2026 16:59:12 +0900
Message-ID: <20260726080129.44969-3-skyexpoc@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260726080129.44969-1-skyexpoc@gmail.com>
References: <20260726080129.44969-1-skyexpoc@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

usbio_i2c_read() and usbio_i2c_write() derive their per-transfer chunk
size from the bridge buffer sizes:

	u16 rxchunk = i2c->rxbuf_len - I2C_RW_OVERHEAD;
	u16 txchunk = i2c->txbuf_len - I2C_RW_OVERHEAD;

I2C_RW_OVERHEAD is sizeof(struct usbio_bulk_packet) +
sizeof(struct usbio_i2c_rw), i.e. a size_t of value 10, while the two
lengths are u16.  The subtraction is therefore done in size_t and, for a
bridge reporting less than 10, wraps before being truncated back into a
u16.  rxbuf_len = 8, a legal full speed bulk wMaxPacketSize, gives
rxchunk = 65534.

The chunk size decides whether a transfer has to be split:

	if (msg->len > rxchunk) {
		/* Need to split the input buffer */

The adapter quirks cap msg->len at 4096, so a wrapped chunk size makes
that condition permanently false, the splitting path becomes dead code,
and the single-shot path asks usbio_bulk_msg() for more than the bridge
buffer can hold.

The boundary value is worse.  rxbuf_len of exactly 10 gives rxchunk 0,
and I2C_AQ_NO_ZERO_LEN guarantees msg->len is at least 1, so the split
loop is entered and never advances:

		do {
			if (msg->len - len < rxchunk)
				rxchunk = msg->len - len;
			ret = usbio_bulk_msg(...);
			if (ret < 0)
				return ret;
			memcpy(&msg->buf[len], rbuf->data, rxchunk);
			len += rxchunk;
		} while (msg->len > len);

"msg->len - len < rxchunk" is 1 < 0, so rxchunk stays 0 and len never
grows.  The only exit is an error return, so a device that keeps
answering keeps the loop running indefinitely and uninterruptibly, while
holding both usbio->bulk_mutex and the client mutex, which blocks every
other user of the bridge.  txbuf_len is independent and can be left at a
normal value, so usbio_i2c_init() succeeds and the read is reached.

Check both lengths once at probe time.

This is a behaviour change: a bridge reporting a bulk wMaxPacketSize
below 11 no longer gets an I2C adapter at all.  Such an adapter could
never have completed a transfer.  usbio_i2c_xfer() runs usbio_i2c_init()
first and bails out on failure, and that needs obuf_len = 7 to fit in
txbuf_len - sizeof(struct usbio_bulk_packet), so anything below 12
already returned -EMSGSIZE for every single transfer.  Failing to probe
is better than registering an adapter that cannot work.  No supported
bridge is affected: they use 64, or 63 via USBIO_QUIRK_BULK_MAXP_63.

This additionally covers the case where usbio_get_txrxbuf_len() returns
without writing its output parameters because the bridge is already
gone; the lengths then stay 0 and the bridge is rejected instead of
being used.

Found by code review.  The non-terminating loop was reproduced with a
userspace model of usbio_i2c_read()'s split path; it has not been
exercised on hardware or on dummy_hcd.

Fixes: 121a0f839dbb ("usb: misc: Add Intel USBIO bridge driver")
Cc: stable@vger.kernel.org
Signed-off-by: HE WEI (ギカク) <skyexpoc@gmail.com>
---
--- a/drivers/i2c/busses/i2c-usbio.c
+++ b/drivers/i2c/busses/i2c-usbio.c
@@ -245,6 +245,20 @@
 
 	usbio_acpi_bind(i2c->adev, usbio_i2c_acpi_hids);
 	usbio_get_txrxbuf_len(i2c->adev, &i2c->txbuf_len, &i2c->rxbuf_len);
+
+	/*
+	 * usbio_i2c_read() and usbio_i2c_write() compute their chunk size as
+	 * "<buf>_len - I2C_RW_OVERHEAD".  Those lengths are u16 and the
+	 * overhead is a size_t, so a bridge reporting less than the overhead
+	 * makes the subtraction wrap and the truncated u16 chunk size then
+	 * defeats the splitting logic, while reporting exactly the overhead
+	 * makes the chunk 0 and the split loop in usbio_i2c_read() never
+	 * advance.  Refuse to attach to such a bridge.
+	 */
+	if (i2c->txbuf_len <= I2C_RW_OVERHEAD || i2c->rxbuf_len <= I2C_RW_OVERHEAD)
+		return dev_err_probe(dev, -EINVAL,
+				     "Bridge buffers too small: tx %u rx %u\n",
+				     i2c->txbuf_len, i2c->rxbuf_len);
 
 	i2c->rwbuf = devm_kzalloc(dev, max(i2c->txbuf_len, i2c->rxbuf_len), GFP_KERNEL);
 	if (!i2c->rwbuf)
-- 
2.51.0

