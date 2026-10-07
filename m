Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FFF3F3278
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 07:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791357170; cv=none; b=pp0lud8wxvGhYdMrkZuOwRHxjxJWuv81bxfPqNUdQ6NnoKZ5N5rFCxVjfKUMQZlyTtrvlrZwKycjBI7bjb61HAoB7hR5SscVqjBwN0wj47AcgiEBCii1hB5T5VGFmixT/MvzKPrXRZ40MdNW+U1iz6jPCkaoKB7qoINQkwpN6ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791357170; c=relaxed/simple;
	bh=cTDYcmA10lt2XYgXfFsAmN92sdHx9AZp8Wdn9ASVH04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LIb9V4z1ZcfPWQErStq/TE4aK7modmlQ7XQABrbIIk7F2fv58EG2HN388E/Y1tZziIvliDI8Pe/+AHdtw6r5/vnpBB0tzicS4Dr9iTLwIxeT+mUBruQbfjauHGKYKkG+2X2ZOYgK7QiOkZ4HEBYm09WlFgckBy56rovzAoyW09w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FjNKshRU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FjNKshRU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED99A1F0089B;
	Wed,  7 Oct 2026 07:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791357169;
	bh=LYkJC6wXFVtyUJJc1cEaXqaaPjxWHk+7v0BCmzQPqcw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FjNKshRUcuYBcnA5i/Id3gCq/2T3+fKPfZfuAcehaZcs+4MjRe+Fz/NgVNDiRIs/Y
	 BG7rIOtnCbJaSZRdl7qByHQQ8dx67X5kGnVhHWHMkz+Brx3Vky03j/BfX0uiAQbRcV
	 BptF5TCvoA4gesr8jCIz1yXmU5nSVgqxfj8qSu9RjnG7W1lqA5Vd5s2iF6uVOGSKrE
	 NqXnk6S+lkDHn60MsF4O65CKKNneB+4bG+Uf3ajG3mAIwPcakGs2rXx6RFoGXXGyU1
	 WxXNR0dYuvnthJ/BB/61UlPQiEYwmJdXPUIfS747Ac3V+OtPeG8aftsDT0JsJ/5GQj
	 NPNkFqUgfIstg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Cong Nguyen <congnt264@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] iio: adc: max1363: sign-extend bipolar differential channel reads
Date: Wed,  7 Oct 2026 03:12:44 -0400
Message-ID: <20261007071152.1694320-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100624-payback-oval-084c@gregkh>
References: <2026100624-payback-oval-084c@gregkh>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/max1363.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
index 5304235d733f1..d5afb9440d1b5 100644
--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -406,6 +406,14 @@ static int max1363_read_single_chan(struct iio_dev *indio_dev,
 		}
 		data = rxbuf[0];
 	}
+
+	/*
+	 * Differential channels are bipolar and the device returns the sample
+	 * in two's complement, so sign-extend it from the resolution bit.
+	 */
+	if (chan->differential)
+		data = sign_extend32(data, st->chip_info->bits - 1);
+
 	*val = data;
 
 error_ret:
-- 
2.53.0

