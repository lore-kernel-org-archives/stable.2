Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBED938F929
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 08:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791362339; cv=none; b=OMflgl3hB4nNHFvD6W53VkpZeyQO2NiRPIhNIoepy1GC6xSwX+KPorAXTqDVsbIqjwiZPWQ+WwFEwJIK9jBNzgfMhFtMuw8K/H7Yv+ltDSlpkkprgwJFfLb59Fpm17kzcJBNm6TlgYNIA7kfz+OArAWuUpZPgsH0DesgZFZi3Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791362339; c=relaxed/simple;
	bh=L/sYfwbZ6KCl3YeYakaG94mBMsJ3X7S0aICqvITqzxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LDWiODYahRVL6VG/pRd2SMH4VijbVSBhlse8y45T+NxJX9WJEtx9TmCeb+vOmFwn34VgQbQgVJDchVMguGG5Gx5Z8X6b9NJb1T1Neth8aM1wqgJBmpz1olemIxM8j9cCBshFoScpsfqa6KWbOOed2jnzUniTjyGAdoi8i/k+6aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IIm3KFAg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IIm3KFAg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 303441F0089C;
	Wed,  7 Oct 2026 08:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791362337;
	bh=9cFv+gupaevm8qz9rg2BaHQT7KCgwNOCbyTGG3D0cOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IIm3KFAgytDZVOHKJGqqGzdcofWHaa9XwzQcLRjypBSIVv1NqGvNl842fkOuoSwxF
	 cH2Cyv7+5bjrb93vNIPkTtqscBDhFDQwnRHPHN8Hk5z8RzYomh7NDgCJHayuv2TS4x
	 de2co5hwP3Dc0Unt272NUzBlGM4DootkTPu7xAnfxSAhBid1MrFQ1e5bzP3+scqXxW
	 5/VLMNElRphVmX3vsT4oIRQEvlnfus7ymxz3hSCb9lE2XVOzKrO0qcuCo4C3WPxDYa
	 A7Y/yhiEilWDhsm6sHZUYd7vmTqJt2w6ud/S3aUaEojm1FS2xMS5miYFSlCj0SbWCy
	 L2AojUWIU4+jA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Cong Nguyen <congnt264@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] iio: adc: max1363: sign-extend bipolar differential channel reads
Date: Wed,  7 Oct 2026 04:38:53 -0400
Message-ID: <20261007083720.1954946-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100625-specimen-axis-124d@gregkh>
References: <2026100625-specimen-axis-124d@gregkh>
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
index 29c1824162cd0..c427fdf93dcbd 100644
--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -409,6 +409,14 @@ static int max1363_read_single_chan(struct iio_dev *indio_dev,
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

