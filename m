Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EE33932DC
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 08:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791362293; cv=none; b=BuYBRoGSvg0VnPN+AQtKaht4LW24w3IEgCoEl0HBskjZh1G4d7TfWfb03V2d9VR9x8r7xFiCrQsPUUvcM/5qVICg3OLJZAgRvul8vCJzvC3kzUwUGvwBVCwOVnxfVkAvOXeQln8mRXd4/rGtQHQwGav0AN9cVmgsjMaus3kbWEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791362293; c=relaxed/simple;
	bh=UE2SfNeXmzfE2YXHe3i2Fih7cxlmOsQTqDNV/C83RqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nsUXeV3QAyxcGkcbF2jGpnGSFQPQxSBD5+hoCHDSyYgMwEuVHBSXQiXOE7INq2N0GUrGX9qBhvcL0ufA0mKjBrSwDbZ6qpvnPDUmHKmB9cMsIUzzPeCDwidZjfUaoVt25hg6Ejcwk7wVUCHG2pATTeyWRVmD1/2cLg907RCD+sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dkbN0z0C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dkbN0z0C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 204D11F0089B;
	Wed,  7 Oct 2026 08:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791362288;
	bh=AIHfkAF99mPxj1wML++zsMFVopWNHmxyF7Uk0fyW1hs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dkbN0z0CMlnU0DOgJOFT9dipcwNyPtITF3SOouKPqc7A8oZBrFqt+evN32gVrn38L
	 z3o5EuiHPJc1wY0kwgatR9c6tJtR+RcHbhplIwWnPgD0JXdl9qIhUUJ43JKObZ3/KU
	 YHP7J6gFRguG0VRnRuumJaH89foV65bfjwQ7ztviQDV4zMm5iamptR3K4YXkkxF4Hb
	 KocOZVi72MznYHVEFKfhqkhOIU+2AHRD2RFOqNnFzc8y4/Mfpt9BVKVuL1J7kJjYqc
	 I20g2D6wZuQy+LrpQUbHgeX4pY2q96JzbAqSYK+mx+TnILfnXblTBZDnnBQAerjPAE
	 2754+NaWt+VGg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Sashiko <sashiko-bot@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] iio: adc: stm32-adc: fix possible division by zero in processed channel
Date: Wed,  7 Oct 2026 04:38:04 -0400
Message-ID: <20261007083719.1930677-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100606-manual-botany-e7cb@gregkh>
References: <2026100606-manual-botany-e7cb@gregkh>
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
index 6fede34091cc2..6a666d14a609d 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -1372,11 +1372,16 @@ static int stm32_adc_read_raw(struct iio_dev *indio_dev,
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

