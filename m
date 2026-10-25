Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=92.243.27.206
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792952060;
	b=yi1aMWJG7xdHkkMNTdI9m6w1tyduaHxkn+lCBj724sjoMwQbOqO1+UuST9175iQupb/w
	 Hb6LHcpoCLIueTEHEH8i2JzxjeRFQQEZ1381nA0CCj+Yx1Cq7VXxpaObGfoppFskrVyGa
	 GldKV3I7hoc4LEfH5hTSIrt0OFTaWmqa51xafhL4D7xwZbgpmFSwRN4CBmNvv7pgBXnMO
	 uZRtidJtTHuVEGa69iIaoZe7F3troKv3cMN8NbbbMIipSqsZ57kbBhgEm2VxSmRbX7+IA
	 fmAe4CnCmh5inBd4wP53+hBaN53jiU6Rf25lQ+9ahwKWh75WFp3A3yNkgjq/VuuMnhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792952060;
	h=DMARC-Filter:DKIM-Signature:Received:X-Spam-Checker-Version:
	 X-Spam-Level:X-Spam-Status:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NdiXNwW1JAIknDVH1xQrQ8uAVlOQAHRR12+J5f4Gc4I=;
	b=P8C+iLKMNQv+6dXy4vDJJ4n63W1o9yH30oerkaBPLF4p3z+Ihio4T+R4unGga3v5oqHL
	 iQw+TUNhmh97yfM/PvPU7AA7yoDjAbEu+lQwSa0eMh+W/dS9mzBqRIp+1FZGQVk//fFyY
	 B8RbwkYkKQEbkMjoiJZ/RwwSH0cMrYBif4uvn+dcJ7hRMEsYM66Fvu22IoaaUz5JPTF48
	 D3F2/1Uk9rH2zLPH4/5y3w9rrpoZkeIt7RuJIS8hi+Zh/O4+Ud/t4q8os1/ju8/EJM+vI
	 d5DerSd3+Vok4znjeSYDYbzQ9fUquKQF8FxPCGZXAjfCQsBUDnPguSWByd9dPpc8CzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mess.org;
	spf=pass smtp.mailfrom=mess.org;
	dkim=pass header.d=mess.org header.i=@mess.org header.a=rsa-sha256 header.s=2020 header.b="PBDJx/9U";
	dkim=pass header.d=mess.org header.i=@mess.org header.a=rsa-sha256 header.s=2020 header.b="PBDJx/9U";
	arc=none smtp.remote-ip=92.243.27.206
Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6411A606A31D;
	Sun, 25 Oct 2026 18:14:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6411A606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mess.org header.i=@mess.org header.a=rsa-sha256 header.s=2020 header.b=PBDJx/9U;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.a=rsa-sha256 header.s=2020 header.b=PBDJx/9U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1792952051; bh=6aF51VyhiVp7C0gGGW704o3E+2y9Ns/3lS6WEQrGMOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PBDJx/9Uk7SaYUhpD1LYbHPsk9CJeCPJsFRWV7EDzmbaOieL0klxTYVWpEEynot+a
	 HPRUjM3UN/SC9anI4zNw4bLdoxa9lcIUephdGnLtS4YFi2og0XxHcVx2AZJOwjXUgc
	 HLkJDLqZHzAt5aeHZ7Zlau5cfu/W96U/ajWD/07SUorEV8CezIq+TFiYBJ6ZgCwTDE
	 B34kcc6zKKaf1GAcN3UP0Dlfsfyzbp61irWcDY/daMLvpF21hSEWEBe4cAPDe4Y+Gs
	 oiSTy2lxzVtXlRzYIi/lxMDkFU1WT3feKcEFu2zvCeLZsAQ+HceId7n6zcy2YpdYhP
	 RuHIsL8jUJ7XQ==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id D71FF40B49; Sun, 25 Oct 2026 18:14:11 +0000 (GMT)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1792952051; bh=6aF51VyhiVp7C0gGGW704o3E+2y9Ns/3lS6WEQrGMOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PBDJx/9Uk7SaYUhpD1LYbHPsk9CJeCPJsFRWV7EDzmbaOieL0klxTYVWpEEynot+a
	 HPRUjM3UN/SC9anI4zNw4bLdoxa9lcIUephdGnLtS4YFi2og0XxHcVx2AZJOwjXUgc
	 HLkJDLqZHzAt5aeHZ7Zlau5cfu/W96U/ajWD/07SUorEV8CezIq+TFiYBJ6ZgCwTDE
	 B34kcc6zKKaf1GAcN3UP0Dlfsfyzbp61irWcDY/daMLvpF21hSEWEBe4cAPDe4Y+Gs
	 oiSTy2lxzVtXlRzYIi/lxMDkFU1WT3feKcEFu2zvCeLZsAQ+HceId7n6zcy2YpdYhP
	 RuHIsL8jUJ7XQ==
Received: from maru.home (host86-145-132-241.range86-145.btcentralplus.com [86.145.132.241])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id 300CD40B2F;
	Sun, 25 Oct 2026 18:14:11 +0000 (GMT)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] media: rc: Do not touch rx state when unregistering a tx-only device
Date: Sun, 25 Oct 2026 18:13:43 +0000
Message-ID: <984d752bd365cbc5b787dee31cb4738cabc581b2.1792951808.git.sean@mess.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1792951808.git.sean@mess.org>
References: <cover.1792951808.git.sean@mess.org>
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

Only tear down the rx state for devices which have it.

Fixes: ab9567336171 ("media: rc: Add missing locking for keymap")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Young <sean@mess.org>
---
 drivers/media/rc/rc-main.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/media/rc/rc-main.c b/drivers/media/rc/rc-main.c
index f8cc7e4a3d95..c36a62992b76 100644
--- a/drivers/media/rc/rc-main.c
+++ b/drivers/media/rc/rc-main.c
@@ -2071,10 +2071,12 @@ void rc_unregister_device(struct rc_dev *dev)
 	if (dev->driver_type == RC_DRIVER_IR_RAW)
 		ir_raw_event_unregister(dev);
 
-	timer_delete_sync(&dev->timer_keyup);
-	timer_delete_sync(&dev->timer_repeat);
+	if (dev->driver_type != RC_DRIVER_IR_RAW_TX) {
+		timer_delete_sync(&dev->timer_keyup);
+		timer_delete_sync(&dev->timer_repeat);
 
-	rc_free_rx_device(dev);
+		rc_free_rx_device(dev);
+	}
 
 	/*
 	 * lirc device should be freed with dev->registered = false, so
-- 
2.56.0

