Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795458749;
	b=DD5tHhyEuj2DA3K5hJcXBUoCvkXSUdKEfJND0mTSptSzcKHdMwJSJsii/MXBidBko3MG
	 JBsXCqFPL6iiNYSrwa4Roiv/rpFhNZKPzv08nKrYYScpWLi7YFysKfgB3jMbbPvZmqrOF
	 laQ6WMXul+w4qBFMfjKTnxixGwU71+hpMGH/Lm4E74XeWij6go+HN2TmK1lr4tqKR2QSC
	 9QUH9tkqVP7mWl1hEdQPJXDT+2Yw10agZQMmPEL9Zz28o/YKNieT7/AA1YoVG67jS7HsR
	 u13+Ecrz0rWvB3ZMVv+Uw90AKmhBzgjsnRGvkoCxEPimPewgWVyJ0q7bAHI+I3vSF2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795458749;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=HixZivlW5EbPj0EUn/UCMLuXWIHadDmuB9x5A36DekI=;
	b=IJQOX5Mq5UMUzenvwvguvRpO7ZHUD8FQlK6GnLCVt48BloXh7B9eMnfYnhs6WXco8JfA
	 brkNl3FhyI8jsWiA4y3fadHYAO1RGuTxn/KAUYQiDRfsqoQvwDzawRA0qjHpznBaHlNx7
	 A7eO3ZcHWXSrx7x1vLmv3tABcL6/Lf6DVtfAwr98l+5ZNrg9PNSQz1kGUAwiQNXNn7PUb
	 f9ZIeS/4dhc3Dk4dZW//qb1/n4B2YiyIXvK+zI7FGMT/HnFEAVY5umAsaKll4s7530MDH
	 9Xf0FDb0o8MabZnJlqrnhOk2akUj7h40GQgXTmgURmxFaT79A6LWknI7pNMWXU6wAMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="jnSmY1/x";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2745B606A332;
	Mon, 23 Nov 2026 18:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jnSmY1/x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B2E61F000C6;
	Mon, 23 Nov 2026 18:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795458748;
	bh=HixZivlW5EbPj0EUn/UCMLuXWIHadDmuB9x5A36DekI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jnSmY1/x1+84MH89QxsJGXB2k6SwdJXZkWHbJaZkW1t1CX7gzIwV5KcX9/TyPIn05
	 qbcUD4OWwV/tKFmejTH9CiCk/IZ2S71Ynu+9Y5V/uQMvkteB0AMkQgd9LcOYDS6I/y
	 aDhlO7PSCnbJU3yhdUcyx1psPhwL0xfQPAvPCjZ8eWzjyFNVfKHtKl2uZOTadmRwgV
	 eKhWgMij3sICFESCl+vx6vGvJQg2Iu7xuiaj9MpShk+itYxlW6bLJyIBl8OXXNTmXS
	 BHOpo8k+Rw/MDHy0kO/4z4FYdM+UqehuQLGTHZjJ224/JbxgEz6H0UumA0hGOtBkUq
	 ojnvAdqKwwmkg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>,
	=?UTF-8?q?Ronald=20Tschal=C3=A4r?= <ronald@innovation.ch>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 03/10] Input: applespi - cancel touchpad registration work on removal
Date: Mon, 23 Nov 2026 18:31:09 +0000
Message-ID: <20261123183200.3900004-4-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
In-Reply-To: <20261123183200.3900004-1-lee@kernel.org>
References: <20261123183200.3900004-1-lee@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

applespi_probe() allocates its driver state with devm_kzalloc_obj() and
initiates an asynchronous touchpad information query whose completion
schedules applespi->work to allocate and register the managed touchpad
input device in applespi_worker().

applespi_remove() disables the ACPI GPE and drains in-flight SPI writes
and reads, but never cancels applespi->work.  If a touchpad info
response scheduled applespi->work just before applespi_drain_reads()
completed, applespi_worker() can run during or after devres teardown,
corrupting the device resource list via devm_input_allocate_device() and
dereferencing freed driver data.

Cancel applespi->work synchronously after applespi_drain_reads(), once
no further SPI responses can schedule it.

Fixes: 038b1a05eae6 ("Input: add Apple SPI keyboard and trackpad driver")
Closes: https://sashiko.dev/#/bug/linux-bb2fd773-6c20-468c-a092-6814f008077f
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/input/keyboard/applespi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/applespi.c
index 96c504f28495..d964cd3ee5af 100644
--- a/drivers/input/keyboard/applespi.c
+++ b/drivers/input/keyboard/applespi.c
@@ -1819,6 +1819,7 @@ static void applespi_remove(struct spi_device *spi)
 	device_wakeup_disable(&spi->dev);
 
 	applespi_drain_reads(applespi);
+	cancel_work_sync(&applespi->work);
 
 	debugfs_remove_recursive(applespi->debugfs_root);
 }
-- 
2.56.1.750.gf70dc682cf-goog

