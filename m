Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC44B3A16B2
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 07:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791356641; cv=none; b=Aa3axvMlvhkGrH153vWMjwJO+Ig93bw6S8BWry2v3uG9C6Zrv8FW06PBIHO4X4IUsGpVmihAOGPOW2Teu4mhf/jmZWKwZsJj8aj6CbwqOq20wXhHR14KcogtJJiTHYY02mH/wFnrToUgynZCeRFVrxE45KpQyryyETKnkkiaZrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791356641; c=relaxed/simple;
	bh=A2U4VngD3cWZQW00F4L95Jya6AvcmJK3p+jie5jN8PY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XW3i5mMCyPXC0QvVE4L1E8q63AL3Vl6s7Aio/+Sn4wcaJua8TESc2c+JZk2/8xo9hF/SHzhd0KsutIJ89VpdSMlHAZuK9YDWuri+Bl9oJzDV0RzYruqJVYYPDYr2lMYn+SAXc+CGX17wglh4e6R8V4P6e9tDF+dgWR08t61aMUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NKDvT60i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NKDvT60i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 124C51F0089B;
	Wed,  7 Oct 2026 07:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791356640;
	bh=vD6FOw2J82TI8UL5Dt+We5gSV+xSKRd1/nSfIai3mAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NKDvT60i0q+rV8z/OfY5JVZljcd2mvRRSA1VdLu/jmatOaiK7VkBkeMTuF2QJkWMd
	 uZZ6UCBlKQpPBFVeKdcl4W9Ng4BJLSnMH9GFCRHm4bOCMlWVD5IYhPfgIh7xPkyLlB
	 oKUINK8u+H4g51QmngkMT7fVEh3TCjiuSxzx2YxWfcx5zAA+8r3G3uaykexYGdUGyT
	 Tj5DalJBxw7bohvru/vaV5rDWcSGzrhW0LfZHHvitDw4FI0yfoWcJk01J84WrIKNI9
	 YBzqEPe4+CLGjEgi80sA8o/L9j+vxm9W+uDJniU4Hdyg7BPoBgqVDbKFr423ejaCjk
	 uUJT9B4xayJQg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Cong Nguyen <congnt264@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] iio: adc: max1363: sign-extend bipolar differential channel reads
Date: Wed,  7 Oct 2026 03:03:56 -0400
Message-ID: <20261007070254.1634238-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100624-simplify-bouncy-3264@gregkh>
References: <2026100624-simplify-bouncy-3264@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cong Nguyen <congnt264@gmail.com>

[ Upstream commit 91908c0a78baddc8572aa3ab69e62ee2eb496ba4 ]

MAX1363 differential channels are bipolar, but max1363_read_single_chan()
masks the raw value to the ADC resolution without sign-extending it.
Negative differential readings are therefore reported to userspace as
large positive values (e.g. -1 as 4095 on a 12-bit part).

Sign-extend the masked value from the resolution bit for differential
channels. Single-ended channels are unipolar and are left unchanged.

Fixes: d1325cf45077 ("Staging: IIO: max1363 ADC driver")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4
Signed-off-by: Cong Nguyen <congnt264@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
[ sashal: Adjusted indentation to fit the existing iio_device_claim_direct_scoped() block. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/max1363.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
index c9d531f233eba..e5d7cefef414f 100644
--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -402,6 +402,14 @@ static int max1363_read_single_chan(struct iio_dev *indio_dev,
 
 			data = rxbuf[0];
 		}
+
+		/*
+		 * Differential channels are bipolar and the device returns the sample
+		 * in two's complement, so sign-extend it from the resolution bit.
+		 */
+		if (chan->differential)
+			data = sign_extend32(data, st->chip_info->bits - 1);
+
 		*val = data;
 
 		return 0;
-- 
2.53.0

