Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0143F12E5
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 07:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791359082; cv=none; b=CQdE83ibtehozFS/97Mi+11dy10yGVccrXrO6KsHsp/7DjhsMQYjtE/83F6/BDd8RzOA10rW/2P9yT0uwlR6Lp+lBY+P4vj4mBma+fCcU7lweblnA3pR2oa3dUX9UjGwIvIjvXxv6KsbaYByklNoOF0VburUT7EPpRaNJpmJbGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791359082; c=relaxed/simple;
	bh=nN7yWJUJBm+T/CaKITVRqJBb1DTdXv5OUmfpfD8VZ3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N/g8lcxqkqeu5/HW3FA275jCn3KjoqGrHBm2wC1FKkrqSfVLP5lvfhQWFY9b7RJ1ADF7EVVRNGEOi9QrPbXdN5/g5QuO4kXgDN9xyEoT9/SoP+nbI8ph2dXgk8JSFzNUJo1nnSYece2KVH50wUJCBmOzmaeGn7m0b6ALSy/fHt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SG/F81cw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SG/F81cw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C7B21F0089B;
	Wed,  7 Oct 2026 07:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791359079;
	bh=YWnmnkRE9Z8Fpkm7vOqeWndmDOodjDLTD2FmQF+M8jY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SG/F81cwq5bl8aTDiH1wIHld8Uhy8p8rn+meXV+9G0PysVRHTvnV4fr3YplvVjtVV
	 dUPCEcoYErEnnVu2vC6Yo1PwdcPqLvGqHwmK2bKKhoVI1N6zpHjGGrEj2PMXt8fbxG
	 zR3rV1nR8cbetEHeE3i3UdKFfUPr52/eMV2jFdIs1zf+xm+X/XXYEMg8VDZ3nJDm27
	 WwfmXj70Gwf7s+G/g4ulJxEra7Au7bWH7DBqgs/L2NbWTMOyRjRULOmorOBl9Wvt65
	 gmP/VfXUsh/rQreULccObvqyyR4vVAgCCZgKObaOUKM+P1qQy84HAKMQS+dcCZWRYB
	 +n5yFjy18QVXQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Sashiko <sashiko-bot@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] iio: adc: stm32-adc: fix possible division by zero in processed channel
Date: Wed,  7 Oct 2026 03:44:36 -0400
Message-ID: <20261007074415.1750009-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100606-vitally-sprain-dbc6@gregkh>
References: <2026100606-vitally-sprain-dbc6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

[ Upstream commit c5de6a6f855fdcf1e0ea549fb227a316db51c405 ]

In case the conversion has failed or returned zero, processing *val
can lead to a division by zero. Need to check for errors, or converted
value is zero, before processing the data. In case the converted value
is zero, e.g. the Vrefint channel, this should be considered as invalid
in all cases.

Fixes: 0e346b2cfa85 ("iio: adc: stm32-adc: add vrefint calibration support")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260911161555.244F31F000FF@smtp.kernel.org/
Cc: stable@vger.kernel.org
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
[ sashal: Changed iio_device_release_direct() to iio_device_release_direct_mode(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/stm32-adc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index 2ce521871bdcf..3b78581c5e785 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -1478,11 +1478,16 @@ static int stm32_adc_read_raw(struct iio_dev *indio_dev,
 			ret = stm32_adc_single_conv(indio_dev, chan, val);
 		else
 			ret = -EINVAL;
+		iio_device_release_direct_mode(indio_dev);
+		if (ret < 0)
+			return ret;
 
-		if (mask == IIO_CHAN_INFO_PROCESSED)
+		if (mask == IIO_CHAN_INFO_PROCESSED) {
+			if (*val == 0)
+				return -EINVAL;
 			*val = STM32_ADC_VREFINT_VOLTAGE * adc->vrefint.vrefint_cal / *val;
+		}
 
-		iio_device_release_direct_mode(indio_dev);
 		return ret;
 
 	case IIO_CHAN_INFO_SCALE:
-- 
2.53.0

