Received: from mail-106112.protonmail.ch (mail-106112.protonmail.ch [79.135.106.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D67463B9A;
	Mon, 17 Aug 2026 17:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786986573; cv=none; b=LmkBd7aSTdQ3De1rKalWcuZnGAzbdtS7MfQWJB5xRpNgdXIMe+OtAUv1+1mQusWfBmJrC5zbl7Z8OryQIrGkq0qhHMrCPO/cJwpAEW5Hlz3xVSu+IKz9vJ8bBw/vCTYa7tDWJSVZe96/DvpLUFptfggLPn231fHKpe6FZTJiInI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786986573; c=relaxed/simple;
	bh=Ae9uSKGvt4ASpB3ozg91XlOoBrfjq9M0C5Gnnoia4mY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vf9DCT4HhHgsWdl275qqsSwl6vSKnKPyU2Psk/24AoD372d1AVQ3GjbkESl2yYQ8f9/Iuq7lSJ8HHdsVgEgeufaFVh25bJlRP6OKWUivtpm7RwBYo+aVfmukvUgPTviNa3G0lOidinrUG4l0RkdfJGDlEK3EvOnLHUR58tShV7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=eRfBYZMc; arc=none smtp.client-ip=79.135.106.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="eRfBYZMc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1786986556; x=1787245756;
	bh=NP4p0c/yQS0KodRIvOt6w1MZVmsKRmP0TxHhR6hhPtk=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=eRfBYZMcQqlxQA1P8K9N8JdxkYQKYrrRwRZcccS9Qa80IoqkY6uY1YqztinmrVqxX
	 bMJ6O1vnjTRdJQ2Lk49iQqImwmNebmw5iQgenc7gFk18knH+6+Siv2rIOIwZOsilea
	 uvge4LPPK8ScPdeYPoe62/YKnWuhLlK24dwwEAN3OkINjGH1dXhUE8c4FhwmPbVDT8
	 HPAXS1jqx0VnlKPISMbcc19FQ5XZwbhac0ivtZZuK/rZHNyQ7OzN4qlpk7nDkQZOrW
	 b1WHEM2GfjS1WfRfTBdqJnBAEGAurFPO2LhmWn/lAZ6VoNHP9OpWkhFyUzG5/+ux/K
	 UfpqCj3xw9Pqw==
X-Pm-Submission-Id: 4hNzp34Lbyz1DDWl
From: Esben Haabendal <esben@geanix.com>
Date: Mon, 17 Aug 2026 19:08:53 +0200
Subject: [PATCH v5 4/8] iio: light: ltr501: Power down chip if request irq
 fails
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-liteon-ltr329-v5-4-6f71ab2b0588@geanix.com>
References: <20260817-liteon-ltr329-v5-0-6f71ab2b0588@geanix.com>
In-Reply-To: <20260817-liteon-ltr329-v5-0-6f71ab2b0588@geanix.com>
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
 Jonathan Cameron <jic23@kernel.org>, stable@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786986543; l=1025;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=Ae9uSKGvt4ASpB3ozg91XlOoBrfjq9M0C5Gnnoia4mY=;
 b=iHGZ7Lu1u8xFaQDIdK7JD1Hfgcc93iNLEq6gpUCd1nzwW7rPkMp/+eGIy1yKChtyPLnx6febR
 3EXypfTyBThDWPyzEvyzu9P+1I3nnKmLFsDOTTBdPn3m/P1SKZvO88c
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

In case devm_request_threaded_irq() failed, we were leaving the chip
powered instead of powering it down again. Power down the chip switching
ALS and PS modes to standby.

Fixes: 7ac702b3144b ("iio: ltr501: Add interrupt support")
Cc: stable@vger.kernel.org
Acked-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
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

