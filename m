Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792822463;
	b=lGGsZdBfcPvs7m7rwzPHYDtjOE/l9QuWgRyh4N9S7ghOAVGHMZZ9wcznmOBpKebomCfN
	 ic5KLbZ35XI9Nw7s7cLZWXp/ap3nLQ6IECtPAdb9fmFbJDNAxBlksmWNa1svCpDOmRBbw
	 yKsJcZMlTZLnq7SaL1eh6o/KTf6BjnrkPP+eUrNhxs1MdrgjeZLsQKqFfDzh9+0enDPRq
	 X3bnn52XWnPBtFdS9/K/Zr4krmQKRC9s+NGRXUxq27rJ1DJ8EdnTEWAofqrtHJJpXn6uu
	 8LXYpMn4TU2tPXcwRqcM4nX2C1brd3K+8eSYn+d/3gV0AvQNVzzHorNwRzcruQDt+/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792822463;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=l+dQSq35iMWLaAG/hUbby+nPz6VKUfVtqj6bR0W+roc=;
	b=q8tAaiejyTs7qayMW3AbxdMGDuyeJ1zQrJTMHVTtujVUb0sKacYasGJmWBVdU0okvggv
	 JvblwlF4NQoyJ1r4K11V78jf6IsLkne2zEXCKWf4cDf7FYF4fcZ6wP7HmV5hYJzpYUAj7
	 pb5PQX3zSVnrnrx7Zogw7FL2wVWYbFLyirSiql4b/Jb82+tpdslEzQtpPf4KnLOnMAfqI
	 A96W9o8Zf1gsa1J6t3kR4lJxBHNhrvZPecwJnjZWv7m6MwAveAN5rjGMzOwnuh5+fMyUk
	 x+jFaHzT0t+s9ZNTGxuXOyXirD8fMOairGaBGZ34kS5k2oPKud9hl1TL5Q+DHCgX/FQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TS3HvRq2;
	arc=none smtp.remote-ip=209.85.210.42
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22119606A321
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 06:14:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22119606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TS3HvRq2
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-833e671ee9fso1323012a34.0
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 23:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792822462; x=1793427262; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=l+dQSq35iMWLaAG/hUbby+nPz6VKUfVtqj6bR0W+roc=;
        b=TS3HvRq2ZiEHda5hrwQtN4NAs0us8I+D66E0RqqjsxZb0a0emzNdWTVsRBt8ygSEM+
         3ySrug4ZfF17PAixiTPLhW6W6m7oMBrDoWBFiJUfE3HCO/tmRLyF2SjeNAL8U0J6UxrZ
         B0lWkBX38lv7V7WheGyxU+UEQfSm3iWaU2BG8wlAlKwGt2DoK6pYX4HNikOHqFCvLgMw
         FaFD8Hz+eV3p9Q2BHniD1yQHClR2c1yMyzGCEQXHkIq/J8D0eFCly5XSoLKr64qR1beQ
         vO7LCIcS5I074xA8W2YQhLhSJWl3Dakbe+HNBwxerzTm620wTsjTGgsNjTpwTj9ua+/8
         OQUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792822462; x=1793427262;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=l+dQSq35iMWLaAG/hUbby+nPz6VKUfVtqj6bR0W+roc=;
        b=c6pIJNWRI6znviVlYzA3Nh20WiRf3hroMT/VPfsT5QDDBlyLF/pSjImLo0Y2B0Jx/M
         LSn7cIp+x1L3C9zvbRvAZs2Rto3btLUlxQkzeXT8/+GshIZS2ZrG3Lx5R2uYxSYxidSK
         Bsb1jswzRO17uRDiqhvwsc6g5hUW/C5SXmMmzMuasuCJ3AqVAhLT2O88eHbClgqai4nN
         Rz8q6Q9UD2JIMntO/D0b3wrSYkb2eR0bF/eLYjf4DcZA9rkviJ/k9WWVpIWGU9ltX+p3
         O8Be4SgC+oiO66DeIXH8BbkNCyLRiMnnJjWbrZ4MggDYC5eVcDzeSSasszYkvjXQDy7B
         pb6g==
X-Forwarded-Encrypted: i=1; AKwUvBxsL2MWGeuFqb8xtYbK2j0RfYL6kY33piyJRRQ3GkfZ6letkGqeTYK5Nf/AmWbSZNJAjBSbEmU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLgocAjf9a9+zStYR5CwT5rvtiF3DtmN4sDRiZe67rYP9g+ui9h
	yWjKrLd9M5/PQfZzAqj+WbgyUJ9pGj70iE2B9pkL22aMfJRiV0Io+qgU
X-Gm-Gg: AYBFou3NGZY0cskbMEpCQQAAMkH152XFpcWRQGkWWnOH1cRghSOxdqzJPVc54d4p1EM
	NxeSeS9jME9tUPZ3/WwGnrUbJkXFDMkaRRNL1+3uNk6096lwZB5F0/RLWhL++AtFzjJbO5pDUaz
	ITk2IsOVsnsqrtFCeZCQdGCDN2iv3ZrLnSsWq+M8XiF9MCBM6A1hOAAv7vRbG4NbrvZFGp1/XE7
	PKvU5x6efP7ukAfOIjRBUOREALkuGIFS+MDx1xKnvQayHHWkU5UDOg4ZbJNjBEn1ltjZ5zSZxk1
	Awq9kBcDpAIvVJD+fgOIAkyE2ZtwZXXZFXMUCM7ujO397cu1GYZhObO5IrR9hQaCk0ZbhQ5xWia
	RSbq8drSUrPSa0kPRuOT/d2nttxy455jSS1BPzM36bGDk5IC28SF8B38EZGbosreg141VqoIE8h
	MFUbBduMRdNJAsfeQKRtgveuCyozrJqhpwQ5loD+0GD5SBvDtsxGxIh9n8MXG/yAeKl2ucQPQGq
	NUisbX4TwrkWZqrHIEEyk6OjK2KOo1atIxSclPfIZlEftPhILN3CSOtn7QYFJCSjOI6jDxUEgfo
	qRcn9qK24tMjGwGK/nktkkx33ifL47Cf0HAcp1MH8Qg4cxGSVynRCPG90k7g0oAT1QIiMDgm7bW
	DSE1EBMeJnLHS/6zlrVOmtMbGqW7agTSf0YHR6HgfhYRJsrT3sHcew7Gc814dopk1DxxeZJNR5o
	Sb+BY=
X-Received: by 2002:a05:6830:916:b0:81d:54f9:d6a3 with SMTP id 46e09a7af769-850fba2af5fmr1170106a34.4.1792822462041;
        Fri, 23 Oct 2026 23:14:22 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-850fa99c4f2sm1516420a34.6.2026.10.23.23.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 23:14:21 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 24 Oct 2026 00:14:19 -0600
Subject: [PATCH] serial: 8250_mid: lock RX DMA timeout flushing
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
Message-Id: <20261024-submit-serial-8250-mid-rx-lock-v1-v1-1-2b9afdf869d7@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNSw7CMAxEr1J5jUUSQRRxFcQiH5ca2hQloSqqe
 ncSWHjxRjPPG2RKTBku3QaJFs48xwry0IEfbLwTcqgMSigthTphfruJC7aZHdGos8CJA6YVx9k
 /cZGopNeajAi9EVA9r0Q9r78f19ufq+RBvjRxazibCV2y0Q8tKuVzrIeR1gL7/gWFevp9pAAAA
 A==
X-Change-ID: 20261024-submit-serial-8250-mid-rx-lock-v1-21c66e80df80
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 "Chuah, Kim Tatt" <kim.tatt.chuah@intel.com>, Vinod Koul <vkoul@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Raul E Rangel <rrangel@chromium.org>, linux-serial@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

The Tangier and Denverton DMA timeout handlers call
serial8250_rx_dma_flush() without holding the UART port lock. The helper
pauses the transfer, copies received data, updates RX state and terminates
the channel. The DMA completion callback accesses the same state under the
port lock, so it can race an unlocked timeout flush. The IRQ-chain lock
held by serial8250_interrupt() does not serialize the completion callback.

Take the port lock around each timeout flush. Release it before handling
the UART interrupt, since serial8250_handle_irq() acquires the port lock
itself.

Fixes: 692aa1905679 ("serial: 8250_mid: Read RX buffer on RX DMA timeout for DNV")
Fixes: 4831e0d9054c ("serial: 8250_mid: handle interrupt correctly in DMA case")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Previously included in the DMA cancellation series v4:
https://lore.kernel.org/r/20261023-submit-serial-8250-dma-cancel-v1-v4-0-e759de1839de@gmail.com
---
 drivers/tty/serial/8250/8250_mid.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mid.c b/drivers/tty/serial/8250/8250_mid.c
index 44b43163df51..83f928b1f643 100644
--- a/drivers/tty/serial/8250/8250_mid.c
+++ b/drivers/tty/serial/8250/8250_mid.c
@@ -94,7 +94,8 @@ static int tng_handle_irq(struct uart_port *p)
 	/* Rx DMA */
 	err = hsu_dma_get_status(chip, mid->dma_index * 2 + 1, &status);
 	if (err > 0) {
-		serial8250_rx_dma_flush(up);
+		scoped_guard(uart_port_lock_irqsave, p)
+			serial8250_rx_dma_flush(up);
 		ret |= 1;
 	} else if (err == 0)
 		ret |= hsu_dma_do_irq(chip, mid->dma_index * 2 + 1, status);
@@ -148,7 +149,8 @@ static int dnv_handle_irq(struct uart_port *p)
 	if (fisr & BIT(2)) {
 		err = hsu_dma_get_status(&mid->dma_chip, 1, &status);
 		if (err > 0) {
-			serial8250_rx_dma_flush(up);
+			scoped_guard(uart_port_lock_irqsave, p)
+				serial8250_rx_dma_flush(up);
 			ret |= 1;
 		} else if (err == 0)
 			ret |= hsu_dma_do_irq(&mid->dma_chip, 1, status);

---
base-commit: 1184f87e2790e8af9be3116f608d2e86b4792d7d
change-id: 20261024-submit-serial-8250-mid-rx-lock-v1-21c66e80df80

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

