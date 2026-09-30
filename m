Received: from mail-pz2-f37.google.com (mail-pz2-f37.google.com [74.125.228.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772AD45562A
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 07:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790754538; cv=none; b=KDZOyiVDmA0zaGsDn9d/J5Qk7woqEtR5e3GIgNkhTG6sUXUJ9VXM7NZPEsvlrBNhi0O/WPZy+Kb9Mv07SPVYJfwV8TIpJigUMxaxFK8X+Qd+mLJeuB14zznHkFKaAwTtm1qrjOfUvo5N4tozsV+/HmJbiOHDLAxslJ0iF8aTPCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790754538; c=relaxed/simple;
	bh=eXAaGtfQqZtfHlLvEQ5eAyQ46SAkAH073bIT8yM0wlY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BjU0Xvh8Dou0U7DOH7KJhCEDOb0/v8QcezlhMLBaE3wxf1mD9ypVsnNeqZGJJHyhzZqwSUbwoE0bYygiIsaOP2sufWd4l77JzmVkC6G7d7+sBEwUNglAbt+tvBoowdhE/7WPSOUmFj9MSwIKv45NJSNxAhGQsSbTVRe1Tp2Z7F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I89WJoAd; arc=none smtp.client-ip=74.125.228.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I89WJoAd"
Received: by mail-pz2-f37.google.com with SMTP id 41be03b00d2f7-cc7d1802740so568734a12.1
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 00:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790754533; x=1791359333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9U104falSUzknxY8qwLcjJ2uwnfV+Zs6GVzKWFFHPQ8=;
        b=I89WJoAd59z6mSk3ACk7YCNOtw+T1zdDt7nmpwI216pz4E0hbWajrtBs3TmV937WJU
         0BxAEKh+HT2LhxLgM1QwbgudxKE0wrtYaEJNzSPgt21Q+CdCLgx/QqceQy3bRI5Gpdn1
         ws3XkKDC7uw0+toxmqq/XcYy5lve96KzIZsMnuA0zDHkIqKlgxasN9gzSd+rmWmkdEBF
         DyRAJW6a4uWmra81XqqxRRN4Vz4TpqoNULpv8Am4PEVx4CUL6Wm4oXV+rjFYOZWxCr+w
         13lBKt66vzzF1wsRkUydOWe7Cy1ur+1cYfWCwZiON8J4lBp3NPtS5iGCENc8km55eEpt
         b2Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790754533; x=1791359333;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9U104falSUzknxY8qwLcjJ2uwnfV+Zs6GVzKWFFHPQ8=;
        b=jBdsi63tEHR5dxyl89CtEgPiWYNpdipYKtdKWW5Cf1w1ZhJ5TaVu8hjQsyahpioxMT
         T1WmuiZULX+PFAuIO01GGWJTfsEy98/evI93v0wr0LiGu3mUHp4BSGA2/Sx2xyfzIR6U
         kP4KtO1FwFvuBKWV2qNi06ixaFOPOCT4WFE4NZ636MuwKfHNyfE/oFr/xzbbJMwTsRT+
         Wo2/J4NGQVewKXsFvktbuQaNrqEKNk/MKR+iH6aStdOBLw8vTzHKQ9mChsvQ7h7TKYiY
         7WKC8QX4vOwklLuSy4dSQtDq8vkPdYhWWQfHRbL4iuBbwvOIJpXajjJsA7krRhcINKVf
         b4Lg==
X-Forwarded-Encrypted: i=1; AKwUvByRYtt96q7YFe5oPFZEeMjaETHzVwHpQkngQgZcQOqCpxnRkV9oFyp1xXVJ99NmTkU9BdTEkuQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lwDmLGWZFoM3VTIasISXByEThhFA1NoLHaLZs5wh0AWz2Or2kG
	hSfIaO23OFLzv/qBxOL0i/b6QInmi1kr938QHlfhU0vzWYGjC/8y//6n
X-Gm-Gg: AYBFou3RUBfVJ7ZytdG2piAoZ4iSUMTWo65fUpVPwyHjcsTWxIK945HqZTFlRnjlHgm
	8ou5UiMCR7tbSlLq8U7UMImz7XaBORjKdBcfZ69clnjT5OlVntlH/2BULqWE6NF/1IEvYj3H+vd
	BQwhX9bMO1wl588wnepUYMIKzXIu0P7w6tJGgop62qNuXAq7fxhbTecQpid4YjR2AZsLrLBu3WS
	vqoFW/wM5H4cE8V+NK/ih1sJtozKZ8IS1xgCiQFzbY8eQD17I4heW415cdrc3mc4I9WiuQMzLBi
	sXBBTn2GL+X1RaHv1nvCwTKXSyH/b/55Uqqc4qdf9dxAFj82ggU+J8e8rbQpa5UslnqyThYdmEd
	NNnsKABTA8tww8ifh0g+a6WnIwi1acctQsLp31mhUPPaTwItrowZAr03v4dZ7j+h1i+5Fk4V02D
	q4agaBWDQ/S1A8UK1n4zIqkpOtuStBXEz7klNVBt6clQgDeAXbj1NLziqV5QS+3NmC2pPWNPA/c
	uKCiJMhpaH/1vNMG2c4sBA+rW1k12BTzecrXrYxlbaszxJka5Gl/lrP23ulL72oOzpRX4VAhEdc
	dHErhIm3J/DFd8Vaogex
X-Received: by 2002:a05:6a20:734f:b0:3dd:a196:53a8 with SMTP id adf61e73a8af0-3de9e8cf9c8mr532280637.74.1790754533381;
        Wed, 30 Sep 2026 00:48:53 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (25.187.82.34.bc.googleusercontent.com. [34.82.187.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-88725881fa6sm376732b3a.27.2026.09.30.00.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 00:48:52 -0700 (PDT)
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
Subject: [PATCH v6 0/3] serial: fix IRQ chain race, baud fallback, and uartclk overflow
Date: Wed, 30 Sep 2026 07:48:47 +0000
Message-ID: <20260930074850.465003-1-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series addresses three concurrency and integer overflow issues in the
serial driver core and 8250 driver:

1. Fix a mutex vs spinlock deadlock in serial8250_register_ports() during
   IRQ chain setup.
2. Fix baud rate fallback in uart_get_baud_rate() when custom divisor is
   in use.
3. Replace manual baud_base overflow check in uart_set_info() with
   check_mul_overflow(new_info->baud_base, 16, &uartclk), preventing
   32-bit unsigned arithmetic wraparound.

All 3 patches have been ported to the latest tip of mainline (551c722f4080)
and dynamically verified in QEMU KVM with CONFIG_KASAN=y.

Changes in v6:
- Use check_mul_overflow() in patch 3/3 as suggested by Jiri Slaby.

Hui Peng (3):
  serial: 8250: fix deadlock in serial8250_register_ports()
  serial: core: fix baud rate fallback in uart_get_baud_rate()
  serial: core: reject baud_base values that overflow port->uartclk in
    uart_set_info()

 drivers/tty/serial/8250/8250_core.c |  4 ++--
 drivers/tty/serial/serial_core.c    | 12 +++++++++---
 2 files changed, 11 insertions(+), 5 deletions(-)

-- 
2.47.3
