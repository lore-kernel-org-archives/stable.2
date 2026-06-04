Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD84123D2B1
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 23:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780616944; cv=none; b=EO+02dse74H93RtSjUVurd94WC8SfVdaWT4fkgBQBOfphwVxOmW6WXBLXuZ0VhJpbPFfJ3uJPpOYCfQ7+/RiEDDjOa48jSY0uMxiObrqUORHGOn9nPADFIR6Frwo93QNabOsKt/HnLEuYJKRhioDLIAsA8hj8qG7RuRkQqPgwdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780616944; c=relaxed/simple;
	bh=O4PDZbDnXWuNAYquRFCuqIe7IszbssvURL9HaT1KG5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DWoI935rs31bJe5ZBlcYIImKcnsfRLn8nhtutteKiYDVt1ksnRe5KJM6E+01Hy8+W48kHRqUgoEdbt2/iLMydUmECkna8KbR5Sl4AM3v9K1+SZNg9jgfHqCLXvusHk6MvCSZsFCXHiVJoluJSo8b49QuIm7BXU9xCyS2pi2csyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QC7xqhSH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QC7xqhSH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 283441F00898;
	Thu,  4 Jun 2026 23:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780616943;
	bh=gAtqo9cjLqEFmXHTps0e0su8tHFGAIt/h9zkXch/fZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QC7xqhSHUKFWEhSOoa+kMJ+KcU1MtGyRGcMLOtq4rCuu6tWByr3Vc3/J8RIr95GhY
	 foXZGnYpImoOGVKMbSqyHrHRzZVJoNvjHy+7nUG8uRgFtS2pjhXaviyApiH4T3qiYb
	 WSdpCFdBK1OkPY4Fw8zzsIQ6UNIwiVZfXS0lMXKuwc71Mck0+jLwF5GKkRZ4R6ZJwQ
	 R9peAA5PyirYpQU6RRzLNS2ENCQygWk4FCccOOeV/UFbAR6tp3+frvfeIXZ3tuPSCU
	 KcgeFr4Cm29b/GDnLehuPPT1fp4YYEktWmHCWSMhFo5guXmqBdFuV0hDj/IBaNiyV9
	 WGzBnL5AEuqWQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] iio: chemical: scd30: fix division by zero in write_raw
Date: Thu,  4 Jun 2026 19:49:00 -0400
Message-ID: <20260604234900.2467781-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604234900.2467781-1-sashal@kernel.org>
References: <2026060457-rubdown-rival-345e@gregkh>
 <20260604234900.2467781-1-sashal@kernel.org>
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
index 10d44a14ac62f8..1f1b93f722cd2d 100644
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

