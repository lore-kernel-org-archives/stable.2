Received: from mail-106113.protonmail.ch (mail-106113.protonmail.ch [79.135.106.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF6039DBD4;
	Mon, 10 Aug 2026 07:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786345904; cv=none; b=iHHp3rugHU5jzQZi0TLmb/7vvkvEOWXwLaxPJ29oCbIH3Rahteo5Y9EEBv72atuw7VCEJvNWxgEit50Z/H2t9Ms6ruJCUxV245WOhQo5y7W+V5MxzEZKipmtymxWuEYH6c450XGjo/fO/RjsBP4i5IZp0DgGY1tv6NIuhdTbZ7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786345904; c=relaxed/simple;
	bh=tgaAMT3putwQDIBHlFcNK+kb/GsQEpgAEExM0xBnjaA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QF/24Y7tIDqy9NG8cRaU3dtHpzWGeQHUa68DqVnu0nPrj4zCQnrgpuFATf6XhbUtkiOdG71CwUxMOMjtxDoMyUj070A96YghO+62f6Sz5jYf5sWPgCXxtdwiHk/wA0kcG7oq/HPSjpkDP+LbkxoO2IOCtVPyoOdHk6bjoYxRYz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=00nDSR4e; arc=none smtp.client-ip=79.135.106.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="00nDSR4e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1786345894; x=1786605094;
	bh=jcjb6KcJp2tJBulE6Nr5ZteDMHbBWNo2OJQLEFFKlwY=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=00nDSR4e2rV58n7YQOQwcSAL9HxbyK/hCO/Q++AU9ZKj986OlOXD2z+vhMzvGptZ8
	 5bPIGC5TA7IpyDg4mZm9yBQ1DQsUlV+OEILDpFOYrqm+UE7S5gSw/uh/9vExmDGuR0
	 J6PZHz1w4+B85xI3ctV/rUmFt1fc7uBea+CzJg65CWLmKczibntq9c0G42/bgE/7mZ
	 KdyIUCJoUUHS2REWMvlekYT2Ka7hkzjZ0SoQXt93oXx5dM244s1m6tNGDuMqzKpEs2
	 6UoiXCR+tdvy79v8p5QnH8o5w+r2N0lbF+IuTW232UUbwsFoF+BTFl6FZLi8bB6fqP
	 2wHtjV28uXbNw==
X-Pm-Submission-Id: 4hJQsc3Ghyz1DFFR
From: Esben Haabendal <esben@geanix.com>
Date: Mon, 10 Aug 2026 09:11:14 +0200
Subject: [PATCH v4 4/7] iio: light: ltr501: Power down chip if request irq
 fails
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-liteon-ltr329-v4-4-8bd3dfd15280@geanix.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786345884; l=965;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=tgaAMT3putwQDIBHlFcNK+kb/GsQEpgAEExM0xBnjaA=;
 b=JdhDNToQ0uoqWTs3aTRsiqihl+OF/OIeiJp6LZO2fbNTGc2zuTrcR6OFEY2vX3jXASYSF7sr8
 F/lktM9D+AxD4Nl0G3CTf4fCAAJu6h56cV1qymDqj2cbSluT/0ju1Fy
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

In case devm_request_threaded_irq() failed, we were leaving the chip
powered instead of powering it down again. Power down the chip switching
ALS and PS modes to standby.

Fixes: 7ac702b3144b ("iio: ltr501: Add interrupt support")
Cc: stable@vger.kernel.org
Acked-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/iio/light/ltr501.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 7d045be78c6d..7746d374688f 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -1540,7 +1540,7 @@ static int ltr501_probe(struct i2c_client *client)
 		if (ret) {
 			dev_err(&client->dev, "request irq (%d) failed\n",
 				client->irq);
-			return ret;
+			goto powerdown_on_error;
 		}
 	} else {
 		indio_dev->info = data->chip_info->info_no_irq;

-- 
2.55.0

