Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E36475336
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 09:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791366452; cv=none; b=o6Io75h4+ROoDB7mvZ/314krldaylQBTzsOGVCZvH6gePqCf7gbm8J+R4w5IuALXPXUMzh9ZAJcCoHYzfVnbWr7Zf1mhSYJozkba2aJ80K0/u66VPu6NL9JHTsfXVLBcK+joEys1NHiRY8fA9TEVrFI09eInMxR+u0DNbIzlxUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791366452; c=relaxed/simple;
	bh=FpL7jjwMY/apfHM93jjTPCGNB7TYjMZroVkZzCHVyBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LZEY+VTbs3X5qW+LeZaOunnj74QbitUInJk9dXrQDoige2y7Wv9gQJuQzZL3aBxc1xidS32cDYCk5MMvzc14cRC79J16M7GJ9XJnEx7Zsyd9P1P5jFxLZRqFZPE/W9jK1uMXsNyfm8iu0a8OhcM1rU+oSC/Pru9lJGEDR/66rbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JW54BEM3; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JW54BEM3"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cc1d57602e8so720256a12.3
        for <stable@vger.kernel.org>; Wed, 07 Oct 2026 02:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791366443; x=1791971243; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jPKaHWa3Bx0TPeANjm1JQtALevFITXOT/HiMP7XTIdE=;
        b=JW54BEM3ausoXQujOKMZ+r0q8jC/BsWwEH8cGfb1PO2vwdb5Ee72keVqcjFcJXlW7j
         ViJw5mNZ4HpWVh1A+CjDtQSOoXzwLherRj0+ek4lo17k3CB4xiGGoZEHJYMsCv1wi3Wq
         XIQrLvGQv668fat1ECsG4dzCnjBBSmvRSFiUsKLkX8Wzv5sRWOvvNObpZLgRS5+3Ac03
         1mw2WEKfc2YIGAOc6781LxoO8GJmUZLa3T+0vKTxtUe/pR7motpcAE9NhLn3ds+McXeD
         2QtLsaQ9H+doWi9Xy/tEGD+kKhxzVrHm6FUKlSOGL/P7JDkZwZN1Nb8CwpkA1z8vMJLC
         6C9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791366443; x=1791971243;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jPKaHWa3Bx0TPeANjm1JQtALevFITXOT/HiMP7XTIdE=;
        b=qVqF2glxhFThhMJZa+iLu8dEsmmLwgozSIH+VRJZyr14bAj5UndVtO/07Ui/6i1+pn
         0ko9nma6FZfuMzD6PFt7I/XvTYo2HDGs8fXxMGMaTj3QyVR/RyDGLFQ6oFKlRBCDjPAm
         77czyZiNvK1pr3xRFyRIwCQdURWnI5tiOy2KEQd7YJa+DCwsWlZlvNYsw2M13HeJDvC0
         aIJ/xkgvVvu8EPZlDsQr6fki8sX3TRrOp5EcyKbspx3wl7Y1qKe5s08DB+9+zqaGCtlh
         t//Wh02obTA38XRtqprWfnSbysEcQ90uZyctTfBRQfsQOE/Ksy2eJLFc7KRT0A29IpTM
         GyuQ==
X-Forwarded-Encrypted: i=1; AKwUvBwzFubsLTfWUCMtxuWcfWVQ2ofYfHyuGu7KMIwPtzOmkhHoj/T0m8R60BOy1UU1NNRlFQzIwSs=@vger.kernel.org
X-Gm-Message-State: AFq9FYIkO7EaDraU+koZ2eSm2GkuqEUTC9spLFRC87zF+90+uXXKPCBX
	LHZZmA/FQIeo7ey8AnBdhEkg1KW64NtbSthAwmYamJ9ilr2CH94RRLAB
X-Gm-Gg: AYBFou0Bu+J3yOd55W40qk+4MVEXl3o88bb+J+egLdkJ2HQwi+MVMfIPwlnUCQlWdK7
	uTRYP7hwbze06JhJEl0FmMMXnmpzztvq7gW5eN+HgC1v5Id68n9/uky+49g7hvnLK9PGivy32W2
	oQ7cXuFjgZBiWr6XR7HjjN4KYfLtjnGNoVZ8HtLiRGlSin8a/rFDVzKo2vEEUyo8LqwMHIy+1VV
	4ftqZ7Sp+l1f5rtOkUiSeOAuxRuRnwzrMhWxp35mvdfrssGrSbNKjPEvaAypnnGEhGY19F2yBCM
	/fVS4k0Zq3c3Z8+D4T35hhy3HQ9zwdoijJMh6X6/CuR/EXv2rVVd4ICHgef7BH+3LD34EANl7CA
	9/WyPqmGg5fwCgLA++f5Mt1n+VGKhczw53XY8tVi52KmByaXx3SwDeiI4GQfxdj/1iF9V1RtOlg
	hHe4FBpflrjAAx/vX0FfuLe4/x+LIJpt4ddNAsA2ZAGS3wcUU8WqB6ZwYm9pGyRSC+YrVQBs8P6
	gN1SmFUTPmbAyGbmj0NcH54C4dGvk48FaunkF/cAJefpqyTLFaaMCYU6hsWImKbQkyJUnBI2+kC
	eBAhsi/+FA==
X-Received: by 2002:a17:90b:564e:b0:3a6:e8fb:76b5 with SMTP id 98e67ed59e1d1-3a8a1b48770mr1335998a91.37.1791366442618;
        Wed, 07 Oct 2026 02:47:22 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (25.187.82.34.bc.googleusercontent.com. [34.82.187.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a8c46a2f9bsm265866a91.2.2026.10.07.02.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 02:47:22 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hugo Villeneuve <hugo@hugovil.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH v8 1/2] serial: core: fix baud rate fallback in uart_get_baud_rate()
Date: Wed,  7 Oct 2026 09:47:17 +0000
Message-ID: <20261007094719.1362769-2-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
In-Reply-To: <20261007094719.1362769-1-benquike@gmail.com>
References: <20261007094719.1362769-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When uart_get_baud_rate() evaluates a requested baud rate against a port's
supported limits [min, max], the retry loop operates as follows:

  try == 0: Evaluates the requested baud rate. If out of range and an old
            termios is available, it switches termios to old.
  try == 1: If old is also out of range (or unavailable), the fallback rule
            at the end of the loop clips baud to [min, max - 1] and encodes
            it into termios via tty_termios_encode_baud_rate(termios, baud,
            baud).
  try == 2: Evaluates baud = tty_termios_baud_rate(termios) for the newly
            encoded clipped rate, which now satisfies min <= baud && baud
            <= max and returns baud from within the loop body.

However, because the current loop bound is for (try = 0; try < 2; try++),
the loop terminates immediately after try == 1 without executing try == 2 to
re-evaluate the clipped rate. Upon loop exit, the function hits WARN_ON(1)
and returns 0, which triggers a fatal divide-by-zero (Oops: divide error)
in uart_get_divisor():

  WARNING: drivers/tty/serial/serial_core.c:548 at uart_get_baud_rate+0x136/0x260
  [ ... ]
  divide error: 0000 [#1] PREEMPT SMP KASAN

Increase the loop retry limit in uart_get_baud_rate() from 2 to 3 iterations
(try < 3) so that clipped fallback baud rates are re-evaluated in try == 2.

Tested in QEMU against Linux 7.3.0-rc3 by setting B4000000 on /dev/ttyS0 via
tcsetattr(): on the unfixed kernel it triggers WARN_ON(1) and divide-by-zero
Oops, whereas with this fix applied uart_get_baud_rate() smoothly falls back
to 115200 without error.

Fixes: 091ea8e5d34e ("serial: core: prevent division by zero by always returning non-zero baud rate")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v8:
- Rewrote commit description to detail the step-by-step loop iteration
  progression (try == 0, try == 1, try == 2) as requested by Ilpo Järvinen
  and Greg Kroah-Hartman.

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
