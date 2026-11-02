Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793637236;
	b=LDkeMeh0cvB1Bm6vSE5q59U6t+ZWVZbCdYA/9kGC1fWePBxTqIP+wChAzU7hwAxIqb6p
	 IapNww3eJhUvwtOREXj34G5fm6xruE0uCQ+c27f33j41MORjCxh9G/iYUVjyt/DhSZXcV
	 9PNUiy86q2yNSeVEyowp0n+2i5Xq8V0MUGkYYH//2MZz2n/QMH8/QY9Q04OF6y/k5mzlj
	 3KPjpdhRw0RIlayuUReOubFFTjonZpwGa1EX3F02uCq2NY1VBsXky046U12Cq6ekSTBGy
	 VJCkVT+eY0b09HW+FeGoYVptmlV5VvYP+Ccj5pSwp+AWlHyjsWrn8VWC0KoyQoaSzSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793637236;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=4Jui1jwEZ6v5nU3mpOAiFTjiS0PcXBHZtIqyyHsg9zQ=;
	b=PyDCqkvpaOBfvwf5tJV0BV4XodacneddxUEdznu52DmvwQ6Wj+mvGAjXj7WHssyFb01M
	 B4hcIdEjEx6hn8fyIeLNZETHgIS87wK/iBui0NDQThxddJEOzhJw2MTVGBUugPrM9l9XF
	 06/oq4NBhef4wVLv7bZbHKxUCXCTmMlSGtUsoTFJAD6J0sGLVsJM6E8+56uhiAbNBfk/3
	 /wUW7fS7yqs3lgm3xu0sCPIe2QgxPVd5rVBwTAdRHMu7ZLE85QDQhclmiT+CVNRvNrrov
	 ApY/1i0qV5l2TicoyjIuROA4nosVRw3AdY6/kpzLd9yVuszM97cKfS6DQI7TP2THLVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=My7gCCvP;
	arc=none smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7D760A0CA5
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 16:33:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D7D760A0CA5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=My7gCCvP
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8a06210b29fso1343892b3a.1
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 08:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793637235; x=1794242035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4Jui1jwEZ6v5nU3mpOAiFTjiS0PcXBHZtIqyyHsg9zQ=;
        b=My7gCCvPocIPthUt3ekAhWaXFRB8P7rEuCRKQwOpiR22UXo/BFlfh6n0ARpMz3/7I7
         K97F9n05CWTAhk+0+A7OeVNxz2grnCFrYf0VcbgfslRZIf/WG0dFhGUzdUYiMRXAR4S7
         /WKgfX/mxLfJoDk86tLA+6IMdCGGl5BXSLyzex/0ZQKFj/LZIvHEMEZHsdrJ9ckzVpE5
         7QdPs1srKUg7sYBMOAKrV1Ziym1KZvIxvFgaii16kr2Z6WkaS7qhlOb5kpMDsvF2qmji
         VkVfQhEZKRcuJH9tgFvJtnZl61I4LhPnB8yOIVtkkNyQj+qi1O4RCdHmmXpk6jVOGidR
         v0wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793637235; x=1794242035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4Jui1jwEZ6v5nU3mpOAiFTjiS0PcXBHZtIqyyHsg9zQ=;
        b=gbul5G5lpY5OlWiiynORdh6La2DMUPpsnB5Kox7COtPCfOs2HcWewveEJDzH5PA23Z
         WOwvZZhWMQI1G6n/v+LEhGjV8/laSTnPop82k2jnGFqfVOsIEMVRrLZ6owl95Oid1kzg
         VB/KlsM9lPCDxGDC359YwRAP3Gu/0HIHBKNTB6aUQqwQ1lWY+2CHOGp7ndpcXEErpTYB
         8To+YKm59XGytNWR+v0vXLP/YPsPDAaQfFfnPIru84l9TWOC+AL+02DzOcqnUTzRaSK6
         maJA6lxZuhmC41Pyr6EUSspwfn4e2PUV2nz+n3ltsBBGmeoXjiYt+vPdQD83GuOkEoj5
         nPyg==
X-Forwarded-Encrypted: i=1; AKwUvByXCk5yXyRSi/Qp30sogzkNmkj6ua51jO5+nCXmNIb1mZlstgHPQIObFSpSygfzzp7osUNtfgg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKiAluoidDie715KJXMBCcGK9zxoa7BiWoeocEQGdmAtvtfqFTF
	6e1IYM19aTsf98ykl3ZM6BA8IP/pa5t3rmuDG4tmdhxcP4Z3p7GiZp5p
X-Gm-Gg: AYBFou3Mswiv2qhHPbHBVmbdwvY6BzZhDKvGjMzFVbksoHGiDyqExw64PvBxCpKzg1x
	YQUlO32O0Q6Q6B/iENVrmV8bjZ8UPB6vFx/f9S47ApMDrmHxBhhNtNfV/NBvjPQtC24AlopXSs0
	2aCJFCIAZBqdGSeGlwlkbTMV+Jk7rDCG8qUnGZhMENsgTRcHDdo2kQp0fy90zfCq6ajmpCr7q4k
	+YhLb9vYPNkeBir++xx7zvF3WxULUbozq7uU2ZbWFIeUu7iNh/9R5MJNnptIloNALgsWqenBMnH
	XD9v9JBSUq/pzIFYe9jpNL0dZd2tTWGR+f3R4ayd1q6zsrAwRFAZoHhMnf2t/69sD5LUAqXLYpc
	nG35tfPq8TEAwuRyO/FK2yau1+TUNLYmCodocMhZhOjNhJh9DMmqeGmE8nOqwPMirLn9+5bu6ow
	7s2vbfZOPPQ7xXFWOJ+XqxjQXrmuGmZBuGjsrzritAuKz9Z6hfV1aEYxcjRVN5avNHRHuCv5/aF
	LZBLtVM7eYNEjQ5aFMkXYZ/GYFDCWxWf8ur0kMh7Lj9GNMLiV62hOfNF7FesxN1g+g6tB9zXPPO
	yQyi7UNDD9kt6Ag1h1tVirqVTjPYg/uYo0FLc/9Dt0NxBh4HhPRK8ufYAP7o+BIsah3OLgfdUjg
	agXMkxs4CsC45jdfSJo80wN+WY2a+97UqF2/+sUc6RudwOWJy5dAcV/KX83Xt93V5SZ5zSjcoBN
	pBQbEYejRxCaw75x2rQkSsr9h0gr0puK2Ha5K8CWRcMXTkuZsxvu0=
X-Received: by 2002:a05:6a21:6190:b0:3e2:4162:f1e4 with SMTP id adf61e73a8af0-3e928dfb0eemr9573750637.61.1793637234800;
        Mon, 02 Nov 2026 08:33:54 -0800 (PST)
Received: from josephctchan-96c-1t.c.googlers.com.com (95.100.125.34.bc.googleusercontent.com. [34.125.100.95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aada3d4092sm2184549b3a.41.2026.11.02.08.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 08:33:54 -0800 (PST)
From: Joseph CT Chan <jctchan@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>,
	David Lechner <dlechner@baylibre.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-spi@vger.kernel.org,
	Joseph CT Chan <josephctchan@google.com>,
	stable@vger.kernel.org
Subject: [PATCH 05/14] spi: spi-ti-qspi: finalize message on transfer error
Date: Mon,  2 Nov 2026 16:30:14 +0000
Message-ID: <20261102163023.2574632-6-jctchan@gmail.com>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
In-Reply-To: <20261102163023.2574632-1-jctchan@gmail.com>
References: <20261102163023.2574632-1-jctchan@gmail.com>
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

When ti_qspi_start_transfer_one() hits an error in qspi_transfer_msg(),
such as a transfer timeout (-ETIMEDOUT), it unlocks qspi->list_lock and
returns ret directly without writing QSPI_INVAL to QSPI_SPI_CMD_REG,
setting m->status, or calling spi_finalize_current_message(host).
Because the message is never finalized, spi_sync() or the spi_async()
callback waits forever on queued transfers. If spi_sync() took the
no-queue path, it returns -EINPROGRESS instead of the error, and the
message's optimize state is never released. The frame is also left
open, because the QSPI_INVAL write that ends it is skipped.

Set status to the transfer error and leave the transfer loop, so the
error goes through the existing tail: unlock list_lock, write
QSPI_INVAL, set m->status, and finalize the message. This fixes both
paths, and the caller now gets the error from qspi_transfer_msg()
instead of -EINVAL or -EINPROGRESS.

Tested at runtime with KUnit (spi_ti_qspi, ti_qspi_test, added later in
this series) by injecting a QSPI_SPI_STATUS_REG WC poll timeout
(-ETIMEDOUT) via logic_iomem emulated MMIO on ARCH=um.

Assisted-by: Claude, Gemini
Fixes: 505a14954e2d ("spi/qspi: Add qspi flash controller")
Cc: stable@vger.kernel.org
Signed-off-by: Joseph CT Chan <josephctchan@google.com>
---
 drivers/spi/spi-ti-qspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 091a8b8842f5..7360ee6bd122 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -708,8 +708,8 @@ static int ti_qspi_start_transfer_one(struct spi_controller *host,
 		ret = qspi_transfer_msg(qspi, t, transfer_len_words * wlen);
 		if (ret) {
 			dev_dbg(qspi->dev, "transfer message failed\n");
-			mutex_unlock(&qspi->list_lock);
-			return -EINVAL;
+			status = ret;
+			break;
 		}
 
 		m->actual_length += transfer_len_words * wlen;
-- 
2.56.0.317.g454f8302e1-goog

