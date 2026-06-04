Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D047F4949F7
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 17:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780594689; cv=none; b=naL1tOc5c75KoChJbZ5/zzkoNwvswxkL4FnnB4YV4BH5dlpJZ8Ah5oIElYKR/14hQFANu/F9G6G2vFbt+HFt3838QHqFkjMVtsplXyKS8g/Jqb5q+Vy6+1xXU/qTNLekdAV2cjBMa2lQrbsg/c1KaBiaB1Pgsciop1jk0FbCjyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780594689; c=relaxed/simple;
	bh=v591x2wawKpQ/nQCiXOJIqUOJoKGZ0618hDTVk6Hm/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=frO/ed//z1BYNRhKlBmtzqXNzfDjMZAcK8bF++k+bI1kj7TGhUgNxyudqOzXUhsAIFf/bBEhFssqMjPsGw3YcrlmjxglpNu5Of3w+md08Rfsu6pIPpVZVsClV9h+fdovGqGmIdxdZo/yIyZvG79rPTbdHyleuDvL8dp3OxpWq1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCAEKjvY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCAEKjvY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3CB01F00899;
	Thu,  4 Jun 2026 17:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780594687;
	bh=CfPEcD/4YlenGSNwJ5yzQE8RkweveaYpeTgqhludeSE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DCAEKjvYves+P5ONbsS5xtkw7nBdn9Un7NCpavbK0vTAcB0tvUJIvTbLpg5jStb1X
	 Q/tTIoWEvEkAVzGRonoscOHRF7Nlkab0Rx0OLCPPolKxLtorcKeR4IALPlUgQLdmG0
	 5XMFp1rC7PM3fta0AepnZPajkYAoaAUzvqsttnHqGrBTtMLpZZYHUmPHCUtdUjaFn4
	 e3NwzDuOgg+TL6/Csu3WMylG7z0IpCGTSatk+s/cTZnn9CzmolsoHIe/aYuQftg7xs
	 qBH9fgs0yI7XzqScnC2cUeMGpkLOhR9aGx6ROISQ38Ptkjh4yAjTVexm7NpK3cEh4j
	 OQCdSTxGrND2w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] iio: chemical: scd30: fix division by zero in write_raw
Date: Thu,  4 Jun 2026 13:38:04 -0400
Message-ID: <20260604173804.26980-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604173804.26980-1-sashal@kernel.org>
References: <2026060455-lunacy-bunch-34bf@gregkh>
 <20260604173804.26980-1-sashal@kernel.org>
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

