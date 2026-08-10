Received: from mail-106112.protonmail.ch (mail-106112.protonmail.ch [79.135.106.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B33039E9CF;
	Mon, 10 Aug 2026 07:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786345904; cv=none; b=rwJhiCw1EpaxBokzQx4ap+Pi5HyWvFzfyhM6Jxm7cbOuNRb4OTT4+IdlIbpp6SUycjpTgsJgE7x3AajBjiFQ0cmLEPGHCracNt5022WUHYEt28fm9D0bIxedEU+jEUN4bs4gEpAiF0dJy6vESJnC+faJfJasWAQu/AeNMaz2A5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786345904; c=relaxed/simple;
	bh=MHC5aV5SMMBfeFSCNY6iiEEcKVKPNClqISFwzfmtIyQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f7Ol/OzuY35y57FkgDP9XMsETMO6kVY1LYATTZW25/IkO/loE6WAILTnoPjSCJPHR2pnPNCxhBOty4/O46fLSjBGNsUpZoE6pEDYzZ4ft3uXnG74WbtsBqdfxQMH3xx5b02r2c8GdqfK2rb89EQMI2mWeo3ThDoCWrOQ+alI9sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=uQGya3i3; arc=none smtp.client-ip=79.135.106.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="uQGya3i3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1786345896; x=1786605096;
	bh=9YVDtdcEd5Nd048NuhxRqCbC6EfupvQuMHS0NxuWB6Y=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=uQGya3i3wDhiBlWR3AIEr9Q69OxtBJxVkiHKCNIPsIGcYHr29xrpc6un98kRA8Cib
	 9aZUVGL/QNRdGpBsxnRx/qYrqzEAERYWHkxSlCwUuzjUAhUo8RuO3ehx4ySdR8pLb8
	 ju1oQvadlFHfk2oP5a+y7W2Lm5/InQd88vDnX4iF2YZNF49Ak2L8Wwbyd1/JJ42Ak7
	 G7CcpOTLFhqB+GpIVOpKg/CLnnY7dwpeRXmJQWn6BrvfAGMlbSal29egKUXIPBn2Lq
	 pTmxLljNXreDp0Maasb/PCMjxM5C7wXGF/qsxQbei+LRWUv6GluxwE+nVeCylPCrNG
	 VGAiESpg+S1qw==
X-Pm-Submission-Id: 4hJQsf5w8qz1DDs7
From: Esben Haabendal <esben@geanix.com>
Date: Mon, 10 Aug 2026 09:11:15 +0200
Subject: [PATCH v4 5/7] iio: light: ltr501: Fix duplicated error message
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-liteon-ltr329-v4-5-8bd3dfd15280@geanix.com>
References: <20260810-liteon-ltr329-v4-0-8bd3dfd15280@geanix.com>
In-Reply-To: <20260810-liteon-ltr329-v4-0-8bd3dfd15280@geanix.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nikita Travkin <nikita@trvn.ru>, 
 Maslov Dmitry <maslovdmitry@seeed.cc>, 
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
 Thomas Gleixner <tglx@kernel.org>, Pan Chuang <panchuang@vivo.com>, 
 Yangtao Li <frank.li@vivo.com>
Cc: Esben Haabendal <esben@geanix.com>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786345884; l=1021;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=MHC5aV5SMMBfeFSCNY6iiEEcKVKPNClqISFwzfmtIyQ=;
 b=WNNjGWfh0CIiryM+iBqFLNNYQfiMBvixQ0Aofhj3EAVP/N5VwhQxs8wmcmzUVhCVXLZ6fggkq
 +UzFfwr/32ECOHfJP9d2mjgpGy2t4whJLkOoGEbgu5kcDw2RDNceirP
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

The dev_err() message was causing duplicated error messages, as
devm_request_threaded_irq() calls dev_err_probe() on failure.

Fixes: 55b48e23f5c4 ("genirq/devres: Add error handling in devm_request_*_irq()")
Cc: stable@vger.kernel.org
Acked-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/iio/light/ltr501.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 7746d374688f..b36bd10a0262 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -1537,11 +1537,8 @@ static int ltr501_probe(struct i2c_client *client)
 						IRQF_ONESHOT,
 						"ltr501_thresh_event",
 						indio_dev);
-		if (ret) {
-			dev_err(&client->dev, "request irq (%d) failed\n",
-				client->irq);
+		if (ret)
 			goto powerdown_on_error;
-		}
 	} else {
 		indio_dev->info = data->chip_info->info_no_irq;
 	}

-- 
2.55.0

