Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2862F616A
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 06:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791353452; cv=none; b=CfX+VRorhLAp22HMmiZW/6phVY4P/eVku/b4LBcY/2oIsX7mVYucaPlPpVdNSFrTx6qR6Ivk3i4LzNy8/G/6hZC4eDR7Zz2F7g5RVe9bJG7e0/WswES8iXIGwZzxk2O2R6+b6pAm5gOisyv43NVfeYD8pagwnKJ2EhwSpWijnYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791353452; c=relaxed/simple;
	bh=04hX1Q7p2fntvode+nLx3RiF2tI0ToUCUYtx8VK+JDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xm6qPo44SRmKLNIooqKmHZVUCyxtptkvG+2Todj8r8uzlQvUMtWH19rHh3xUjPlNAVFHjhieDC6EtNKF9IQwjAmLepexI7Rc3RWUKIakDiLst23wlhtcxSOJHg80DhsaZFjyJ9xTXpktgYQ0EP3RPFA5G0ISxyEwhiJfV/UlfsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VjfIUnkI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VjfIUnkI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DBE11F0089B;
	Wed,  7 Oct 2026 06:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791353450;
	bh=TPI/HCYvO5aoJ0icaQooT45bymAM0NM/DziPwge3Pvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VjfIUnkIkcSFoPwPLYBTYlGFA6WMR1NrNA0d1BBJ+hNJOVO04ML3nvlmCSL9vYs0M
	 kfiw0KRw1fri+ufx+WG0IG6idAFkbeM0Rg1HC6XiEkVdCh/LU9MdRjyoJf3KI1403s
	 NQhtuYzoDvXS9EnfgwG24yhaxvCkn0NennZB9FDqhEgqYtn27QoeLZ2dPs8ZEcLYa0
	 Hp6g7smC6o6sQuwNzn3fjZfwp5d48l68sYe1DwB8IDmI98dDj3w7vm49BpdCGNuvbY
	 wSZmWlFphlh82cedTsBwTSqXo9Yzc9gw/calm3JaHCcx7YwcpCOVLMh0ywVx9n9ynl
	 HHgv5g5qT04jw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Salah Triki <salah.triki@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/3] iio: adc: ad4030: fix invalid oversampling_ratio validation
Date: Wed,  7 Oct 2026 02:10:43 -0400
Message-ID: <20261007060913.1488382-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261007060913.1488382-1-sashal@kernel.org>
References: <2026100606-wolf-obsessed-e5c2@gregkh>
 <20261007060913.1488382-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Salah Triki <salah.triki@gmail.com>

[ Upstream commit d615210564205993e8f0e7ccb57cc2e66b7d5706 ]

In ad4030_set_avg_frame_len(), the logarithm is calculated before input
validation. Passing zero or negative values leads to an undefined result
from ilog2().

Validate that the input is strictly positive prior to computing its
logarithm.

Fixes: 949abd1ca5a4 ("iio: adc: ad4030: add averaging support")
Assisted-by: LLM
Signed-off-by: Salah Triki <salah.triki@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
[ sashal: Adjusted context for the missing SPI offload code. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/ad4030.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
index aec95aceb81fa..b7cb589168c3b 100644
--- a/drivers/iio/adc/ad4030.c
+++ b/drivers/iio/adc/ad4030.c
@@ -514,13 +514,20 @@ static int ad4030_set_chan_calibbias(struct iio_dev *indio_dev,
 static int ad4030_set_avg_frame_len(struct iio_dev *dev, int avg_val)
 {
 	struct ad4030_state *st = iio_priv(dev);
-	unsigned int avg_log2 = ilog2(avg_val);
 	unsigned int last_avg_idx = ARRAY_SIZE(ad4030_average_modes) - 1;
+	unsigned int avg_log2;
 	int ret;
 
-	if (avg_val < 0 || avg_val > ad4030_average_modes[last_avg_idx])
+	/* Reject unsupported modes */
+	if (avg_val > ad4030_average_modes[last_avg_idx])
+		return -EINVAL;
+
+	/* Avoid invalid values for logarithm since it's undefined */
+	if (avg_val < 1)
 		return -EINVAL;
 
+	avg_log2 = ilog2(avg_val);
+
 	ret = regmap_write(st->regmap, AD4030_REG_AVG,
 			   AD4030_REG_AVG_MASK_AVG_SYNC |
 			   FIELD_PREP(AD4030_REG_AVG_MASK_AVG_VAL, avg_log2));
-- 
2.53.0

