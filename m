Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7BD3905E7
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 18:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780599438; cv=none; b=k5EFTgbIY2hL+VfgyxgRaV2Oj1De3bqocLKX/jF61xV6wQ1EW8LrtSPKEWA0qSU5AvvzLyzc4xgzNYfbv+5cFUK/FTtiqrkEI0RepGvFZpwizB5tAkR8y6opH5z+1e0ForGjtfxHwqp+rb7b9pJqYbyYTLReN0fS7sP3AfR4vQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780599438; c=relaxed/simple;
	bh=v591x2wawKpQ/nQCiXOJIqUOJoKGZ0618hDTVk6Hm/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tO19DjcBSB3WFuVYOtkDDfR9ixiDcmmwAXSGGaBEgmiZ4KhXR7Zr3UMFvZyQPRdIlqJthGYviHnJ40pyJsBBK3ZpJs0ezfszu4xtwRqSpZjHbvfidesflhplf1sdxz0Jr+yA2f21yS/O9r8ikJ1RmwYThQ0XTMG+L/HRY/Xmz8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YX6Rwb6+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YX6Rwb6+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 287681F00898;
	Thu,  4 Jun 2026 18:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780599437;
	bh=CfPEcD/4YlenGSNwJ5yzQE8RkweveaYpeTgqhludeSE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YX6Rwb6+R/TZ9NZ40FhNVfCdjuOQhhdSNuNEIfn+Dl4/qmWfza43Ul8WHW/TaaWiE
	 UCvoj5xGqEA5GJ1PPAxixedL2HQCZxM0gnSGatc/8qEuXSkEMYBWzIiQqKlsYfwNzC
	 id3UMKbNufVgyRIepEB5R7RmV9GYm1ma24tQSTN+1xx6xSu4Vu1+Fma83QBf9QzGQq
	 3X5SD2XtJx0Upa3bkAqbL5p/hHeAXXcwghk3JJcUZijZFlmShDYed0KVZWxFAM3xdA
	 /A/rDaBlxnoxNDV/Vqo+FnGMEyci4OZWRmBtw9g768iDftCQaiilUtjO5yB6mQ0C6B
	 VvXQDLdtCefzw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] iio: chemical: scd30: fix division by zero in write_raw
Date: Thu,  4 Jun 2026 14:57:11 -0400
Message-ID: <20260604185711.605210-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604185711.605210-1-sashal@kernel.org>
References: <2026060455-strength-moisten-9273@gregkh>
 <20260604185711.605210-1-sashal@kernel.org>
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
index acab7ff9ba66d0..6ecdc7a07199cd 100644
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

