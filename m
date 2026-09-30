Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46054F7CC3
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 12:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790773152; cv=none; b=TerCYIeK1zxjtqrNiXdYxk+OEL6gE6D/QJr8ZPrmsvBc4NjIlwyZqj5Dht4j9EOAmIsGMuwNcQe5aP92gOlZ3gd+DE09dO83KybS8bXIDG/cFwhB24BqeYASulXb+pz+Hr/wfvCChBEIeZmEyqJVLSyAjHaFyJycvA2Ot3gjK5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790773152; c=relaxed/simple;
	bh=8fjom4nHFHl9t4UeW3B6CslryDoQKv7pGaOEJS5e/QI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JRt1gstjqLPMx5ZVJB5eDEAPDhvZu4MBRiWqmoLM0BQV4MVupNSrAIfXcutLVIW5noty7YY0LfNbWZ0KtrddM6s47+0NiOsCmysVknCbnNmLU8XSKRbUBlXebeYd5lq8miYzpOSyWhBgapApBdwAj4fqB6Olo8LmwJwy4bAUTrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sFK/9+aq; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sFK/9+aq"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2dd53691be5so34236335ad.1
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 05:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790773144; x=1791377944; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mLsfa7AISEbL2xx9aoGfBDqSveeoW+tgNPNPQlBJYZY=;
        b=sFK/9+aqEN9bIN5Xv5Hbc5nk/odedfrwiHFswNp8adnksHus5E/XYA/FrZ3Ny/mHNG
         rwFOmypK2rPk2Zi4ak0pA1qYDgTmk0s2+9cp0M+mwUabD3fpA1E8vEe2Cmwqam8jP1mP
         74ha5GPRFRxUVSWrM/QLG54ar6ALAT39DS/aI8cUDXHo51cWtAtEHLHL5M9vxkfypXYp
         nhdV3c9GbF2YxUpKTo0+83zW5dW9Z8uQeFp2y8mm567S5+PlvZiDOYfl5efJgrZ2mKra
         q4mQ0qPEdfWwnbxsHeCQlA7niyE7X42OPplbb1n1gmGJiJOJrmc65x/jRasXTa2wN9rq
         gDLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790773144; x=1791377944;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mLsfa7AISEbL2xx9aoGfBDqSveeoW+tgNPNPQlBJYZY=;
        b=dOwFejkxtl9rM3HP5330qxLLg5vGLD4QPOOKXpO4O8ZmDjPx9i8ILwKtHBCD/BHjfH
         9+a2/C2zlz4qaoBsxvhRX2ewdBx1msIKZ06D07cT5YZnn/hhW7dnl5jZ6oBomxEhJuA0
         ozFQh0lfAtsfkw2jbrD1iOCGRupcH98XbTz2zUrEbDPpoH1wJTH2sgsg+JOPNvJ4eMlH
         QAhol/EFHQhxfltmyQ2pUR00XkcLtY1FAVDrhq0ENLeB49A4z95frVHYuA883XLVZKtu
         qekVwm8iN5Hl/7qDsVCYiY8WTjEzh691e/dgHSH+RX0UUV+d2wcgGUOFgemxtO8GlfKI
         +C/Q==
X-Forwarded-Encrypted: i=1; AKwUvByjC2p1f9H20/1JDeHIrGeBi/OaZZ+sDRa4HsMyZtBkq6A7rwOk8COwbx8JlYw1dluLV1/0vuM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLQJNo0+FL7bfGdGrjFxlAEnN4Ob8BhntIv4otnpgveSwhVivG2
	3s4qDgI1vOJ21ap2SUmh1O35Nqhx8fmL8Hb6IShcESktgOZHtJTbhkD3XrWE+d41
X-Gm-Gg: AYBFou2lGLVjOWmzFY3oZkVdVzMoH8qjWyQ4VtDy3zvbSkJUdowCvThGdGVqoyYQrFH
	qbBsmGjbZdx6bPkgUWJjihGyT84Zp5SRnnyFloZm+Rp4lR5Q8WWeTLRPx54Y84xK654NVTS1w9Z
	vZisJ7gq3e3v0aX3sAxtq4O2+sAynmp2K0Y4scsn2MwSXypVyGKO3KUPoUI7/UvjeJENH9FMy0d
	HmT6dc2h4x3WN1RSwieCnovzq3lK3OXChLvyVxl2Qeuenm5yTXWlJVAvM+TFN25DLLX8AuWOmzh
	2NC6Bmc5nXN/SHjlrjdR8KOLMPKBrqsQ35T1pk/DBAE/hLDyEwguJIiGVNrJDiUISMUrFyM2yAX
	d4zbSVioyw5xwmLP1qmNLUFuY7x0doi1J1hcUOCf7vDuMvvpNUify7mfC4h91jVjpZGa9zVYMNM
	GU9KkMXjqlDXOj2qQYzmD0GiLN3UxW4fu+wTvjE52p9vTfWv5NS2IILUswlY6S6PV5TORMvv9Uv
	s4DHXSMTtqn6ZFdJAdSPjlWcd6+YRwnsUgmHEbJSHWDKazh8HU5ePsUrpsV1naXmG7TqQxKTJpG
	rRf9aMMoQw==
X-Received: by 2002:a17:903:2287:b0:2dd:c100:942f with SMTP id d9443c01a7336-2e2e49fd148mr12492185ad.45.1790773144112;
        Wed, 30 Sep 2026 05:59:04 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (25.187.82.34.bc.googleusercontent.com. [34.82.187.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e2e5c1b3d7sm6751925ad.70.2026.09.30.05.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 05:59:03 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH v7 1/2] serial: core: fix baud rate fallback in uart_get_baud_rate()
Date: Wed, 30 Sep 2026 12:59:00 +0000
Message-ID: <20260930125901.778868-2-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
In-Reply-To: <20260930125901.778868-1-benquike@gmail.com>
References: <20260930125901.778868-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When uart_get_baud_rate() is called with a baud rate exceeding the port's
maximum supported speed (port->uartclk / 16), it clips baud to [min,
max - 1] and encodes it into termios via tty_termios_encode_baud_rate().

However, because the loop bound is for (try = 0; try < 2; try++), the
loop terminates immediately after try == 1 without re-evaluating
baud = tty_termios_baud_rate(termios) for the clipped rate, hitting
WARN_ON(1) and returning 0, which then triggers a fatal divide-by-zero
(Oops: divide error) in uart_get_divisor():

  WARNING: drivers/tty/serial/serial_core.c:548 at uart_get_baud_rate+0x136/0x260
  [ ... ]
  divide error: 0000 [#1] PREEMPT SMP KASAN

Increase the retry count in uart_get_baud_rate() from 2 to 3 iterations so
that clipped baud rates are re-evaluated in the third iteration.

Tested in QEMU against Linux 7.3.0-rc3 by setting B4000000 on /dev/ttyS0 via
tcsetattr(): on the unfixed kernel it triggers WARN_ON(1) and divide-by-zero
Oops, whereas with this fix applied uart_get_baud_rate() smoothly falls back
to 115200 without error.

Fixes: 091ea8e5d34e ("serial: core: prevent division by zero by always returning non-zero baud rate")
Cc: stable@vger.kernel.org
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
 drivers/tty/serial/serial_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index f91bcfa30113..6ed0195e6912 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -470,7 +470,7 @@ unsigned int uart_get_baud_rate(struct uart_port *port, struct ktermios *termi
 	 * Ask the low level driver to verify the baud rate if it can't
 	 * then it will have encode_baud_rate set the Closet else .
 	 */
-	for (try = 0; try < 2; try++) {
+	for (try = 0; try < 3; try++) {
 		baud = tty_termios_baud_rate(termios);

 		/*
-- 
2.47.3
