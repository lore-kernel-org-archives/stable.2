Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794277803;
	b=3/hbRaQGSDFN9Bt71hLde7AI71jh5qAT5g95dT6D/79A42H2f7QgMUwwuRQazNG5kGmm
	 murYw1qIgg4r2s70iVZzIkgu/ET5F03o1MtQWfthPtptc8JkrsbrqcU52FtTqDN+Q4Hki
	 G0pFRqoHDvYsZTlmxYZRjYT1qBcUAE2kjBxcUVQAPzjP5iUoJ+02x7XOSNyOZ6m8Ra3d8
	 l1Uf0rCrwpWSG797Ei2ynMJ6wWgf02KItx4zBrXmNJhcbEz/Ig9YzMtyQmTHzc3TtYhOK
	 4F1psGfISDDHhRRrDay9TO8Rucp1gst/r96UlRvM/03YBYfKeyKkZyDSzhlMN2T3P8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794277803;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5vGcgdCyILPd/lC67XcqBA+Yz6HgZP4xfuU6fcK9QLk=;
	b=u0LbYwy2AzKRNbvef6mkYvoWI6SvF23ZOh6bzD1ixesg4g16kEn7F0/VjCvBXZO9cOtt
	 R93BfU8G+KxrWx2UBF8IKe5TDdyWBrJgte1fSyDeyhc4BC6hAyFMGMfxt3QadbhNuzk52
	 jyQE30Tk1SNwTzcKojgtnOjlUO+kTz35PJyutv+VZLCLrTy1kb4rhA6WnLk4bRvpa0jNc
	 nS6Wyej/8h/5Rur8nqjXP3MJkUnlxQxP0I1mDSsUOinmKK/kMnYj3HJk24uOSN11v5SIx
	 aeZ4lBJtpbqo2Tx3iXG2U+yvGv5hYfblYTcwA86jtpvMYbNVRWYd9pf+G35n1sAuNeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jM0Fm905;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C191C606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 02:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jM0Fm905
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B41F1F008A1;
	Tue, 10 Nov 2026 02:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794277802;
	bh=5vGcgdCyILPd/lC67XcqBA+Yz6HgZP4xfuU6fcK9QLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jM0Fm905LKCRwCWaK3takg8EnfM/+S0QtzJX5QVnGmS5CZW095FgnISUHCyZJD0ad
	 ezixr424mFJToRvUvxKTg5SWkGlgBZ5QzACC8Ac7AL2Lmsxzw+g9BVJz+ymqCOjZTQ
	 7HHf4o7vl5PnKwPdo4178wPs11P1dB5Ou6GZiUvdO9ZdD4HyZZXlvf3+c0WBxxJlNv
	 DMaU/nQNNGfi0xNmO77pQPCfzboH+agtPH+lysS86g+OWQUZm1Uu8gkFlDaZp9AxOd
	 viU5xseMSXTZEZZvFg1S2K3v9TDsTo/jmAMXlmu6vvrzlJPTmPg2UPYNEhpP1+MXJh
	 kgqv936Fw1VZQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Esben Haabendal <esben@geanix.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] iio: light: ltr501: Power down chip if request irq fails
Date: Mon,  9 Nov 2026 21:29:59 -0500
Message-ID: <20261110022951.3819474-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110022951.3819474-1-sashal@kernel.org>
References: <20261107050601-failed-6.18-8a9bcd587d7d@kernel.org>
 <20261110022951.3819474-1-sashal@kernel.org>
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

From: Esben Haabendal <esben@geanix.com>

[ Upstream commit 8a9bcd587d7d768e6c8e9fff88bb89645e412731 ]

In case devm_request_threaded_irq() failed, we were leaving the chip
powered instead of powering it down again. Power down the chip switching
ALS and PS modes to standby.

Fixes: 7ac702b3144b ("iio: ltr501: Add interrupt support")
Cc: stable@vger.kernel.org
Acked-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Esben Haabendal <esben@geanix.com>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/light/ltr501.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 36fe40fec2329..a38cf1490e13b 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -1539,7 +1539,7 @@ static int ltr501_probe(struct i2c_client *client)
 						"ltr501_thresh_event",
 						indio_dev);
 		if (ret)
-			return ret;
+			goto powerdown_on_error;
 	} else {
 		indio_dev->info = data->chip_info->info_no_irq;
 	}
-- 
2.53.0

