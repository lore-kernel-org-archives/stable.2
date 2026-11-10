Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794312633;
	b=QC/Xi0WGi8anhujBfHsc4H9gn3rFpgky2QvxSLgs9Z3zPK9OZ2+/j9I7u+/4YFFdyzuo
	 hig7eMdbLCytLpSGBYKdnVN2kPm4bxc+LoKw8uVId8nU1UfAKHpwPNJOyv8G5Puf1Md+m
	 VgdOwf9jc5+67qxCy+lottmDbkGxrJ+wL4WEp2HvFJ0edEoWkHVM6FErEi1dByPAmDB3p
	 pBtM1SGodSAw3DJrDuLZgBu3uxH3te+S3ddmjkT1UzM9NdobPeughTAUF76WsitkFMMW4
	 qCXntDrF9KjJIDxS4fgyMEn0LafwBRhZ/EhOvH1j5ZifCGsS1u4qe1Lzh/0xKoV8DaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312633;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=rCox+Cfz2K7YJ9mhH4ZnTTcUR0nfUZtZxBr1n2ts0z4=;
	b=msD+o9pviPGhvivNidq7cgRtFl/U+mePagJ7l9MKXDKjDqIn8t3lz35cX/AJTJ32QCD8
	 ALosbA5So0aVmVIPLzXtKts3bqm22vDmZ/Cs8roIXxLQ5nvHAMSKMhs1Mu0e5ZGG36l3r
	 s9Fy5/75oDJQaVGDYFjlF4NSVs1q0dQUcugMJrXENlJYahVpZLKJ8jrwnmalHqExSI0tp
	 d9RdBSPjrEPY0mKmbusE0oBlIM39cw2RhZozYOuSb5kQDORk9KqPvIgLKWBWotiWNrTtM
	 OKx2jcMD0hYdJDjfyKl7n+UwVPWz0RsUnAAjnCSN7vyUEtmJHmnFq2VurdnAjW5+TWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AtWK4NDB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3308606D503
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AtWK4NDB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F2D1F008A2;
	Tue, 10 Nov 2026 12:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794312632;
	bh=rCox+Cfz2K7YJ9mhH4ZnTTcUR0nfUZtZxBr1n2ts0z4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AtWK4NDBdy311caUUtygPTEdkW5EYRkhi4Ms/o4MkX8TfUzjzgz5l2WEvoCwy064p
	 JnaX+8pN3Imda1ppH/AcIyegKdfvTUT+bTQNth7haiaXmmaip+lCsXq22wsQZMf1GI
	 Q2dmoZqTRyxiS/sfXS1Zv8VTKe3Fk9OauvXv32bS4tYzpwNdzzsC0sjcQyoEsCdOcX
	 TYTXdT4fmHqHJsUHcAkV2QMhJnd2yVFYSUzWLqEFRlBSc2D4H5BzKq2d64NqCzIOa8
	 8rzcBSeV2sP4wA8rfoq9V9+be2mR3PYDa81TzRxcm6pdVDJ/I/Dx7u+8JikFOf+prA
	 buLr9LJhebQdg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] iio: adc: ad7192: reject devices without match data
Date: Tue, 10 Nov 2026 07:10:29 -0500
Message-ID: <20261110121017.969666-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110121017.969666-1-sashal@kernel.org>
References: <20261107050733-failed-6.18-7f7a119a370e@kernel.org>
 <20261110121017.969666-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiale Yao <yaojiale02@163.com>

[ Upstream commit 7f7a119a370ecf6c8d4ab9e9ee0a8cdd77afedd3 ]

SPI driver_override allows a device to bind to this driver without
matching either the OF or SPI device ID table. In that case,
spi_get_device_match_data() returns NULL.

ad7192_probe() immediately dereferences the returned chip information
to initialize the IIO device, causing a NULL pointer dereference.

Commit 572a00852635 ("iio: dac: ad5686: missing NULL check on match
data") fixed the same driver_override issue in another SPI driver.
Reject devices without match data before using the chip information.

Fixes: c3708c829a06 ("iio: adc: ad7192: Convert from of specific to fwnode property handling")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/ad7192.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 8b1664f6b102c..394137a127abb 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -1402,6 +1402,9 @@ static int ad7192_probe(struct spi_device *spi)
 	st->int_vref_mv = ret == -ENODEV ? avdd_mv : ret / MILLI;
 
 	st->chip_info = spi_get_device_match_data(spi);
+	if (!st->chip_info)
+		return -ENODATA;
+
 	indio_dev->name = st->chip_info->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = st->chip_info->info;
-- 
2.53.0

