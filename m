Received: from mail-pj2-f26.google.com (mail-pj2-f26.google.com [74.125.227.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CAE4BF92E
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 12:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790773155; cv=none; b=iLbLLXbjpJrPaCXDwCOWSzVBnvkbfWCkJa9Ue19tEAiHpHCCBydxAoEnY+YD2Xm4ESzumMvkIB+BjEYjCm0XBkvJhnQJGeQep1vhI4/NVjwU11IkWv+ujG8t5jX+Yu3R2XmUiz9xURu2TD6gj2bshfQKRrszj+GsKC6QMl7qoZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790773155; c=relaxed/simple;
	bh=ZOZcnBA24NO/pa1vXrsjd8y9HWBPKelZsbY931OX+ow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rajsVQwoN9E7f6Lfo3FW4c1xi1OqZFou3Y12rGLQ3d4/Ppa6Vcr7gbr84HVmtq397VhfbvectIQ0ENExRFzH8748DFdhxBSHgsTtzBeMLVGjr6Ng9Zid4AECrDy7Srfz6Y6tJ0EAfiTYqRudET0x83he8ZGlP+cuBz/SI7KmsS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nfazufTM; arc=none smtp.client-ip=74.125.227.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfazufTM"
Received: by mail-pj2-f26.google.com with SMTP id d9443c01a7336-2d8fb334e72so21323855ad.1
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 05:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790773143; x=1791377943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=m4F4f3/aIvZt5ojYeBT1ImcwfjE5cVxgdJesU8F13F8=;
        b=nfazufTMB/TLsGxbX9221aXt/VLrQxHmzjlo2IlQrnraKUN8wyNfRggB+q+ni2eKFg
         L/KLcuBg2kqKp2pRQAk9c7SFP4UhuCe2PoV/HNovQ3eWpw7vLzNtwA0KBYMMFZDm9zKg
         64d7xXE+OtM30X5+2qnKZ6NQo0+choAqYA6E4NL7Upa2Zw78Kg/qLOwpuG1G6beiWq2g
         dLbyVJU99DJzYuGiJ8PQnCjmGYQtadzAmmg5PQmRdpFFD6ve880d4tBtTWuaPY8C3I1K
         j174IKdfvd0avAB4T9mKgF/f6+GL0cA/UQoh3F81sTzmgi7999o5Rq4d3KJZtgVquu8Y
         hM+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790773143; x=1791377943;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m4F4f3/aIvZt5ojYeBT1ImcwfjE5cVxgdJesU8F13F8=;
        b=ocUx7kXLAc6nGHWD2vZFs8ykARjvp0yjkRX0HqdA1RnT/pF4Chy2OuzMoGkJyJuTXv
         Vo3iEIihQytXYxHCfgmnJwySxAtc4tAkTft2ocMW/crC3rtatwDbEUKdBmYFQlns/N4D
         W8RG/gpWVFi/kyPYPlHc5FmYtHjVTvpum8dpr1iGvUbByLDSsK2H6TLh1ne5cfVS1Vlo
         IUUgbAZiEecHaoYdD2yZLe3n/vnULS+8tVuPd4R2dhQCIY9D4jd9C4c26PdHZpLQgBpP
         GvPm2roxOwDeDgIOJROccDyA+IfvSSq2QiNJQH9ExIup7QPesoJZEgqwkqDoxd/yELcH
         biew==
X-Forwarded-Encrypted: i=1; AKwUvBzckhLnuzPRo3r4S/7/8r5EmtzYNo3JFiBLcVA+EB6c6iqkcLNEH5U2iyKmMNST4vRvcJtjMaA=@vger.kernel.org
X-Gm-Message-State: AFq9FYI61Hws+NNPcxD/rFvxwcSBMe1veta3RLisVFSbqDkNWYlWxqYJ
	BwyfkfrII+SJhCel0a3FwTLvwSZIkAcbGJfl/JcTyKlenW4PPOZY+s91
X-Gm-Gg: AYBFou2eIwadTUHfisnleYb4CseM9nIpv0epSjq6P4Mq+KpoBB81FwqxTp/ZzYEokHa
	tc85ViftTQE5OSEUR/Y9Vq3ENQ7c1hUU2pgatA6cPUsLg9ioeWTNI0rOOnze+tdPMCQR0ZeG23i
	HJQDMaZG4v/L2MMxC6ZDyLFr4kyi1hH/KWzPN0CZnT8+RrqfjSUCiCquUPJ4uFWlE/zpGhnQFUN
	s2gLN7dfXVinmmM50BQEp+BQcgYLbUXCs418nHOYEVfz1bFb3lpgudfuzRiCLYTyWAvk9XfpP8y
	LAEbojLVHcBQYSjOr+lNHcnlBjMMEDt7WonoD2YdDuEm7tw3jzpyJncWQOsZZhG4QBR5c7HRfp3
	jfrNODNY+Ag28cwUfRHLY5KaLz/+0fRzuVcBOkp5TIrIDgJcPoJykHcHOHhPbruB33EA0HeJ3fA
	48rhTnSsTUIJ+p7zcvTKqldsp/OLY7z+oPqXEEVqOW7UAqYuUOlba6S2xvhItywePhEXKec+DQO
	UKYrFBMymFY+SxHb2u02Jvq++i8ksHV4mDnSu+aKdHfUjsP3krAI9FzBfJEHqZ07TWF5YwJx564
	CYis+XOJZw==
X-Received: by 2002:a17:902:f644:b0:2d3:716e:e2ae with SMTP id d9443c01a7336-2e2e48b30famr11257585ad.6.1790773143429;
        Wed, 30 Sep 2026 05:59:03 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (25.187.82.34.bc.googleusercontent.com. [34.82.187.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e2e5c1b3d7sm6751925ad.70.2026.09.30.05.59.02
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
Subject: [PATCH v7 0/2] serial: core: fix baud rate fallback loop and baud_base overflow
Date: Wed, 30 Sep 2026 12:58:59 +0000
Message-ID: <20260930125901.778868-1-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series addresses two issues in serial core:
1. Division-by-zero WARN/Oops during baud rate fallback in uart_get_baud_rate().
2. 32-bit unsigned overflow in uart_set_info() when multiplying new_info->baud_base by 16.

Note on v6 1/3:
Patch 1/3 from v6 ("serial: 8250: fix deadlock in serial8250_register_ports")
has been dropped. The hash_mutex race condition was originally found and
reproduced on Linux 6.18.14 (where guard(mutex)(&hash_mutex) was dropped
inside serial_get_or_create_irq_info() before serial_link_irq_chain() linked
the port). We did not realize that it was already fixed in mainline by
commit b339809edda1 ("serial: 8250: use guard()s"), which refactored to
serial_get_or_create_irq_info_locked() with guard(mutex)(&hash_mutex) moved
into serial_link_irq_chain(). Apologies for the noise in v6 1/3.

All remaining patches are ported to the latest tip of mainline (551c722f4080)
and dynamically verified in QEMU KVM with CONFIG_KASAN=y.

Changes in v7:
- Dropped patch 1/3 (already resolved in mainline).
- Clarified in cover letter that 1/3 was found and reproduced on 6.18.14 and
  we did not realize it was already fixed in mainline.
- Retained patch 1/2 and patch 2/2 using check_mul_overflow() as requested
  by Jiri Slaby.

Hui Peng (2):
  serial: core: fix baud rate fallback in uart_get_baud_rate()
  serial: core: reject baud_base values that overflow port->uartclk in
    uart_set_info()

 drivers/tty/serial/serial_core.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)
-- 
2.47.3
