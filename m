Received: from mail-pz2-f38.google.com (mail-pz2-f38.google.com [74.125.228.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CA345038
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 07:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790754540; cv=none; b=I78xXdddZd4pMuJOMpp8LZ3d9L8LC25MhQWA1K0rCLsCcJSQm94C964BNFzNvW8OvICSzm7K90FuZ/6Qh430+LQP54upAB6k3yFw1giUL0SoqzF3IE6i2Ru8RB7BCOjGsZAaDKi1zAJCUNTxFd2njfOIwFPZnQseIq6fdkEDOjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790754540; c=relaxed/simple;
	bh=S35Yt6MMIDiu89GiENd7YXKG1VdniUNgPzYQiYvvfDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZB0eLtnbmNen0NWYxfjvZN+07YNpGOBitbjuzI/p3r3PgFba97k5cd8WBUO08Gtp1r45AvGLj+vDhGB5M4dZuPX+S8a/9tWWwgv1fAJKOJtPnj7ZfE48HLr/5BN0MKB8i7D0/kq7cZrDGR6hZB6Pi8wtinX9FMxzlLOz4TRvBZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q6HY5R04; arc=none smtp.client-ip=74.125.228.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q6HY5R04"
Received: by mail-pz2-f38.google.com with SMTP id d2e1a72fcca58-88582e2153eso1182858b3a.2
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 00:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790754535; x=1791359335; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=72PWod9CYTLQICpDGdnCAhLW0qkolhlRAfQR41QlFTA=;
        b=q6HY5R04MQMqwUs3d53UWsLpfkbVH3nUxUyQLcA9xlUEAAxJS7vtdUX2ntwQ/PN8XA
         6BG9dzrf3ahoi6CmlQxfPzaLgoPYwciH2j4D8CgM4HkSACP49vpJeir1PMYoA2rohTUV
         ygHZo1P6Y7VWuRmC0tCC2y8hDIzFYKbVI7CFuv8apVld+2sr/ZgYTWt7qeyr3xApUP5I
         nH/b4cIFFuGzfWbhRuDx3v+uLVNhKe0WSd/BWb41L2Rf4jkeaiu9uS3WRZUal4OUKsIT
         pEdhyGXBx1lWo0NyCPE5sHS/oAx0qiLSf5yeFHoLR0j5lAou5+tY5i3pJdFyIdUBfAQk
         9DoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790754535; x=1791359335;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=72PWod9CYTLQICpDGdnCAhLW0qkolhlRAfQR41QlFTA=;
        b=BLMVudFeZzp0T3R0IYrXcFDSC0ZboN+sH0XrLc51HJrUgrwS3R+gmYEZ68pveoMnOn
         PzAnGIu7WPmH3Q1Myps6AakH83PLorZRHL4SVvNcHHOMgXGlXtdJovP1HhZa2ORNyaWj
         +conAywAx+n5g9vL/Qqsvre/mC1stA3CLwGiWIwEJycpoxtqDg3qouwFzA8jv/aAIHyE
         nEoSTbxlopvYIYPRZT2X4P4ZQ5efFBsn5QDqptaSGqNOe5Uws/3LvtMmJkWVcY1F79m8
         4v+l+yHN/PHAYQ8h1NMW62LsosLbQw5H2f/bdXbt3kOqq+nCDI8lSEAXSCiEQSwIrMEV
         g/pw==
X-Forwarded-Encrypted: i=1; AKwUvByJeQcJ/54THm3gt0LDtgN1Mli0tAarJZUDONW73vfntqVU5MUTYMnSCVt1ZfBaQcMk3KAlO+o=@vger.kernel.org
X-Gm-Message-State: AFuF++nyWe9NxS1bO/kDYJIWbe8sdGcxRSXJeVFoOulFvPOPliuvYK7l
	QBIsWd8880o6V4dGWnf2hOs9BA/9OaT8WebVxC/t0jumORiNhjTsylUE
X-Gm-Gg: AYBFou3g1hutniRCLy+DZBjI6ufbymabgPmyiE65jI2EuSc2u4uBqlT0y+YuOuS6hVs
	OaW4akbPpptd0gTNFRoEIMD1FeXl81wbhK5m6bmGSv6Un3hL80K6RFduJovQNn540smmryk6WOg
	DEq+nCIA86fUQNe9YibJc04+rSQeswOpP06O05/G65kwqnsJcw9FxpDfpcYQo7fuUA5snv5FWql
	hmnQx1dRh+4q8GTeEx4YP1XtvKIVgbPTASV13poLUN70PnFreWjqL31zfjETTLGtNXtAXNA7Igo
	jNlL0vwS7A33L1ku3JwIguc6I/W+lRvV4V0j7Wv4OwDj1++CAr77m8WhrCq76Az0co1tTQJtos3
	VyZwbQvcitepS9J8KQtTzwHrFWg8cNt0vgX+435UzE8xZ42mWZwA7NCgg+xM8VGU0ZQJU1TbINy
	TYwAQ3Xyl2rgsdwiPTBPFYeflMG7sFNlQRbsbmjBkehcp2cGXlSjNlSDgHVoDzKJUrFozwk4iCT
	uvrA5T9DCRvDJIYMcIbT8gAc4f+Nn/EGNGyh0Ramkk8JOY4xOu6j8Wwg6hlEnmGtFZNIL2V9+yG
	+YFJAy9meg==
X-Received: by 2002:a05:6a20:d10f:b0:3de:540a:a270 with SMTP id adf61e73a8af0-3de9e7f2d5dmr664907637.41.1790754534806;
        Wed, 30 Sep 2026 00:48:54 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (25.187.82.34.bc.googleusercontent.com. [34.82.187.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-88725881fa6sm376732b3a.27.2026.09.30.00.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 00:48:54 -0700 (PDT)
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
Subject: [PATCH v6 2/3] serial: core: fix baud rate fallback in uart_get_baud_rate()
Date: Wed, 30 Sep 2026 07:48:49 +0000
Message-ID: <20260930074850.465003-3-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
In-Reply-To: <20260930074850.465003-1-benquike@gmail.com>
References: <20260930074850.465003-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In uart_get_baud_rate(), when a custom divisor is requested, if
port->uartclk is zero, the fallback logic evaluates baud = port->uartclk / 16
which results in baud = 0, causing a divide-by-zero error in subsequent
calculations.

Ensure uart_get_baud_rate() falls back to a valid default baud rate when
port->uartclk is zero.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
 drivers/tty/serial/serial_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 95774b0f1484..55bb1eaa27e7 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -480,6 +480,11 @@ uart_get_baud_rate(struct uart_port *port, struct ktermios *termios,
 		return 0;

 	max = port->uartclk / 16;
+	if (!max)
+		max = 115200;
+
 	if (termios) {
 		baud = tty_termios_baud_rate(termios);
