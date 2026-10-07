Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A122AD35
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 07:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791357510; cv=none; b=JqF7trQMKq8GZJLcyISpW+sDxo8BqHRpuQ3WvKXbs+kJUBhVh9jcop60yeYk2QTEFtUtrDpHy9voymwHiymC4ArOFxOti2Q35XXoOIscn0lIjd02vSjlU2Sl/BcqxJp+wdWnmSJmgwKS8+kdvuJ2FElBv6i1j2xscR3a3/Mx1Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791357510; c=relaxed/simple;
	bh=2VSeId0ZJlJGk0VPQ+qaC3CcCAlH/qV1gGC3Y+CBeAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V7COXcIT3vcGQMBud5FZcm1oKzzlwdnsS0O63tZT56iBPvCt77IKzmc7mKKW6kEReLrDmpjYPeZXleM4UURZa2drIHkWQT7TBlsIXHGAs+YkJrPU9TWlMOqhRsEgz0pscqoURVS6nPFYFKxZcz0BpwIs8QTrjhWC01KdHH29Ogw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fv7s7DXo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fv7s7DXo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A75071F0089B;
	Wed,  7 Oct 2026 07:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791357509;
	bh=+Ubw/lO8MdrbhRSOePmuongtSoOH2sszv/1W0s2FjxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fv7s7DXo4Ee5FaYbM4Vb4K+gI4vX2FyH/a4KsKGBHJEak1eoNd0nXM/cfD032O2Yx
	 UuHKIBHLmMcuwthdw6X0CRVzIorJxzLX6/J9zxWiNLqyNqjcyLB7TdQe5u6gcjDRa+
	 2XhOeqfGdfjwhq+MVfhPS6IGwoowtzkLo6FTrhHbEOqq2YLNHxZlOSwXcxvpt2ltYh
	 yafBfWm/1pDs9BoFaZHKMxssTPEMEwmA5J3GOAT1xRDbOg+o4w8t06gcu0a5kcjcnP
	 1oZZ5f2+iojXtWvUEQ2ALFXG7gqbnMcR82dbtv1g1//ZDlOv39l7bCRuNqQtygQWuz
	 /hyFuE7dXOBfA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Sashiko <sashiko-bot@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] iio: adc: stm32-adc: fix possible division by zero in processed channel
Date: Wed,  7 Oct 2026 03:18:24 -0400
Message-ID: <20261007071804.1640286-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100606-uncle-ranger-4f3a@gregkh>
References: <2026100606-uncle-ranger-4f3a@gregkh>
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
index db8dd129b0614..2513146639171 100644
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

