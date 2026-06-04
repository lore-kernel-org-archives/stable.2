Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A749A340A6A
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 19:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780600681; cv=none; b=YuJ/ZZ1SyJX/lG9O6TxvGshURT0qhFgwsJjZDuVKhJT10XDihyNYc5lzNJTFiweyqDu/3QLnuK7w9xCOsJkGPIjU+uZXTxBXOTbGKwQqvYqsT2iIqjA35AGOrZoA9qfmmUP3nJ/glzRtp/9TSjkXb+XbY4qUo6/OWjZFtMYwm2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780600681; c=relaxed/simple;
	bh=vOade6XS0hShnSn8xyuagOxlUUOnow8Z1tXRpSgyo2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W6QBezYRGB8EuEuZ1m4cnUbim16S8B49ql0Bx/+Nw9otKr7fQoZaKRJUvmdTzozCMXJFVYGWqcVIj7CFRjoa5iB6PVE+IpHeSD2XuF19Knh5TE/w5OMQs1O+SiOJ67e9xMGNOd5fNZ9diD94uVEzrrJdoOZbtoJIq8AgoQUThIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dn5ZTrPI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dn5ZTrPI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81D8A1F00898;
	Thu,  4 Jun 2026 19:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780600680;
	bh=wg+kj/wNGWwdzPS8ADb4654NjHgOPqcww9HruSoFSas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Dn5ZTrPIs0OpRh3lPz/8TtW7pZSaZtoy19OEcHB5K0u3sVFY0Gi//RhqUmgQx0rpC
	 Xwe6Tpw2s+MDAwh/6lkBfz/c7Nn0dyDZNUMSV/3UkDTsmKBhx1s+/S4NPw3OP8FGUn
	 DeSAfOMQSM9ze+ncpmcNyiENFVy38ZwC6oIfVoGrKUX0p+BTe9UK+zQ9nM5AffdMvJ
	 m3BNrkNPhwq1DkkUykNCjBL/RqsuwBYgLxzMAmPzdgQaspKoLywsArolxjiXHZBgUY
	 +k3WB5t3G5mWRYRxkTkK9Akf3+DpkgBXtdrwU7dXpzscP2u5C+Wn8/RujjBCJALEr4
	 YdjYyBcNdL7Qg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] iio: chemical: scd30: fix division by zero in write_raw
Date: Thu,  4 Jun 2026 15:17:50 -0400
Message-ID: <20260604191751.743012-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604191751.743012-1-sashal@kernel.org>
References: <2026060456-grimacing-crop-73d8@gregkh>
 <20260604191751.743012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Antoniu Miclaus <antoniu.miclaus@analog.com>

[ Upstream commit 5aba4f94b225617a55fed442a70329b2ee19c0a5 ]

Add a zero check for val2 before using it as a divisor when setting the
sampling frequency. A user writing a zero fractional part to the
sampling_frequency sysfs attribute triggers a division by zero in the
kernel.

Fixes: 64b3d8b1b0f5 ("iio: chemical: scd30: add core driver")
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/chemical/scd30_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
index 180c29bf99cf36..306ee3e7075d85 100644
--- a/drivers/iio/chemical/scd30_core.c
+++ b/drivers/iio/chemical/scd30_core.c
@@ -257,7 +257,7 @@ static int scd30_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec const
 	guard(mutex)(&state->lock);
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		if (val)
+		if (val || !val2)
 			return -EINVAL;
 
 		val = 1000000000 / val2;
-- 
2.53.0

