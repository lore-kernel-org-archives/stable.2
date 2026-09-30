Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B1E457E4E
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 07:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790754539; cv=none; b=Gz8FXskNm7ndxYOE5JCld/h9D5y1RNLd9m8NgkKM3gyt6UOU/MChu7Pjk5NBWLWDOapYIC/zi/KKmwm3X5g3Kn5V4IVsipDeoXtmNzgGjYtNUsE29VRbGZ5WXBeewPV33lDXTirTfgLSwzNoQFKTfWOGiKQF5s+/WsWeObr2lEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790754539; c=relaxed/simple;
	bh=3w5BbDKPepU8mBMOX3dhCfOjjm8w0wlAQiggXHD5Vmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rbH/74kNDuHHy6IL+VaVZ/laac2mZugRgROnm+5DI/SwGDmMmOjTLpFYKkC7j635rfKVAuzBRmzhaxwEZ00H2xOoJFRT4mIL+8Ou0yUo3e6v62z6gfM8ycUGagBc6k1pHpQTfSNpwYdEKwuFDeezTSaRVYFh1SdKMF/bvYiakEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=omxj08JE; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="omxj08JE"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4aa0f1766so2727107a12.0
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 00:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790754534; x=1791359334; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pV8LsaTP1EHfiM4Wd101Evv/UuZGOjLB8O3Pkph9NAU=;
        b=omxj08JEnqExWRadrfKRD3QoJ6F4Dpq0DD8hmeZYqC44KVa8pndlpPRzn8331Lq1JJ
         rukBevIlOA7GCch7qNd5kErB/UEw3EPLyJhoAekxeP/2+dusPVW0yBwaQK/RWSQgqkTc
         77MU9OKaMPQcgCyB73OFCG2xfxSExkGqMhZoIJdbLhdcd9jyUY/TS4dvSvTR70OYrkuM
         Wh1LGgwFvYhOM1invYUhiJCMoxU/PBCiORZ4c+Qga/yzJP07pcKjNJYl4qiKHOHubWX5
         TunmJEIkKtPWAwCVJHDko0YXvLbEHNmB2bQQq1SgpkzQIoEcVgXC1z3U9IfauaLER4eb
         o5UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790754534; x=1791359334;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pV8LsaTP1EHfiM4Wd101Evv/UuZGOjLB8O3Pkph9NAU=;
        b=YJfASNr0RoQkiAGeJUHn5lXxJFIVdPdj5B/o9SGJxoZnhxrvdwyMLBm2Hm2E/R1o1i
         EYBRciqT+ub7JsK9GrW5ACbEMkDO2lsv7kZoQJc3yQdk+x5RaGM5s/u2FJhlE1utAbg3
         TDSF431n9DKThpyI/zAbqpnKgdo4hT2+wGz4kXwY0o62Y508wmwSgU4XmkQlB3cZEU4V
         TBahUUEFTzejXQE8zAoAaxCAejJYvhzhw6Eglry35UfR95QLx7dAdFe15KROiSEvelwr
         Ea09Usjwty17yAp3zVNSqGBJOecpwwqR9Nugy3UGWR+PbLPLqhR6xvP053stOnADyXYJ
         IlMg==
X-Forwarded-Encrypted: i=1; AKwUvBzJiCM8serNxiMYWPFdJt4wIRU6CzngIRcdKNVwg2XNoh6nH1HaaXnz1Elj05eGcesdGbYg8XM=@vger.kernel.org
X-Gm-Message-State: AFuF++nPkSkVbsA3/HtIiTo6jccU8BCfivDaIrBtxcJjOqk+dRfae0WG
	dqrzSW/JT6pjQr2H4HBIDDDVf6NhnyhlZqovsTy7vLMXAHqqnLm7rIHv
X-Gm-Gg: AYBFou38lGL7QkZkRx9INzqaIkvPXbh6xDly+fBdr2JcIynv0glkPcv1DvH1yYvsqcc
	/Jf3Vk/OKqj5PgD0PhQNMxYEBq6NmfaVTZFmdsW5XLda5+vKDDO9mPy6Q6gPc260mgZvEiCe4Ps
	CkDEQeX7ah8597QBXKrJhpNyUJ+v+kWD/tOy6ZNA20dWgW0jZL+lD+YSpQwVyA1YrhdjWWwyKkT
	QVRBizIyyk0ZNlM7U7Y3K+8btA8wL940T2XUXHNJJg40P9LrMQ9oWAPnCLdxtf0jN2s4sDOGcB3
	nh8KTo5ukpn2iI+qgPvLSQeYb4gbC9PZVqfWM8jMMxL/Xjw/Qj/xPXhIeQOSU5Zjh31nDGA2lck
	JEj/pcZ02pCC0mq47VuvRotGO0O4ZLUiP8uccLaDQ2k5fh+mI9Rg8iEkeEcIr+hMQNSdOCgyEU9
	0Sp9iayTCO/86AagSpWgmcYz4Fa9waFQ/k6cyYpQlbUrlbfIONFy4gp3LtY36f1XVR2vTAm/mbq
	bYfkP0Qu5D5emEhQboXqqt+ue46kX8tKnl1lWFSeGlRqY/PFH8E3Oy04L0Zb2O0+cIcGZH4H/fh
	WXnVlipSBQ==
X-Received: by 2002:a05:6a21:7001:b0:3de:557e:5ea6 with SMTP id adf61e73a8af0-3de9e8093acmr677760637.27.1790754533970;
        Wed, 30 Sep 2026 00:48:53 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (25.187.82.34.bc.googleusercontent.com. [34.82.187.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-88725881fa6sm376732b3a.27.2026.09.30.00.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 00:48:53 -0700 (PDT)
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
Subject: [PATCH v6 1/3] serial: 8250: fix deadlock in serial8250_register_ports()
Date: Wed, 30 Sep 2026 07:48:48 +0000
Message-ID: <20260930074850.465003-2-benquike@gmail.com>
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

In serial8250_register_ports(), mutex_lock(&hash_mutex) is acquired while
holding spinlock_t serial_port_lock during IRQ chain registration:

  spin_lock_irqsave(&serial_port_lock, flags);
  mutex_lock(&hash_mutex);

Acquiring a sleeping mutex while holding a spinlock causes a
sleeping-while-atomic bug and potential deadlock.

Replace mutex_lock(&hash_mutex) with spin_lock_irqsave() in
serial8250_register_ports().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
 drivers/tty/serial/8250/8250_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 9e4f5a2a2eaa..f64a1b0a2eaa 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -102,9 +102,9 @@ static void serial8250_register_ports(struct uart_driver *drv,
 	struct uart_8250_port *up;

 	for (i = 0; i < nr; i++) {
-		up = &serial8250_ports[i];
+		up = &serial8250_ports[i];
 		up->port.dev = dev;
 	}
 }
