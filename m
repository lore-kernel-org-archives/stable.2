Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEE427732
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 23:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780616971; cv=none; b=FHsIekIJe1CWVbL9+LZM5it9auH3GnMLGiLvB5YhUleFRtf2yB0S5Zp9T7dCakn0BaIUza8ra0vPNDYsmdBRa/48AdjR1GIOxbkTeYqoPoBV1oS/xgrwMbxG2zdY1ne8sovj6eBGZ/x1bHNUXAQGWOABr+dpOmjPtOZS9iR0rFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780616971; c=relaxed/simple;
	bh=pIolN5570spNUdNQsCklhSm0ztp2kaKLZj1BZAptKJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bQCZxY7sbSa85H596bKOXdTwUbAmuS/q+WTiW1d1jhV6m2MGqoQui3hhxEXXemlgQivdyhOi7CiG9I53A9KiDI5DE/fNlCUU6FqtdH+4RG8AaA1r5rGlqy/OgM7DGYjA2UdVb3oIYRjPTTRfiA6QC8HXwfNm0T6r5odC/pOy0oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lylJumZR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lylJumZR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966081F00893;
	Thu,  4 Jun 2026 23:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780616970;
	bh=oxirtgLsJutk74g6gc8hAyOb21XceFC09uswNbHNOiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lylJumZRKzcLPwAv3/WrjObFzloi8VJ9zKs20BdXy1BCl9Dkcl1WwOGJ2vNPV4kpB
	 qaui2EZyqYqoOSNGdDWmJPVwPMY6O2IG8Hsx4Gjmvt1r3loehB7YSZlqSsMZdqWhYQ
	 jFaYDllzV2IHRhEzSPJIdUi1OZmBKTJlTUeuiEZvsU/kpMFKPOycvXa2PWS1i2C9Dz
	 1C0i0yXTJe52ThiqolZgRyl0p2wv/hCQXz9pNX40g2zLrvbq16E09DO4weSszJj+zk
	 NI+a++Nbm7VxtuwXKrJjTdzYfL4t2H7N7VmvjayHHh5mBL8fOTiG6bjv2k0vfxQ+Ip
	 iHpT0zEUacbxQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Rodrigo Alencar <rodrigo.alencar@analog.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] iio: dac: ad5686: fix ref bit initialization for single-channel parts
Date: Thu,  4 Jun 2026 19:49:27 -0400
Message-ID: <20260604234928.2470788-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060401-dislodge-unlovely-c2aa@gregkh>
References: <2026060401-dislodge-unlovely-c2aa@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

[ Upstream commit ecae2ae606d493cf11457946436335bd0e726663 ]

The reference bit position was ignored when writing the register at the
probe() function (!!val was used). When such bit is 1, internal voltage
reference is disabled so that an external one can be used. For
multi-channel devices, bit 0 of the Internal Reference Setup command
behaves the same way, so AD5686_REF_BIT_MSK is created. The issue exists
since support for single-channel devices were first introduced.

Fixes: be1b24d24541 ("iio:dac:ad5686: Add AD5691R/AD5692R/AD5693/AD5693R support")
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
[ adapted `has_external_vref` to the in-tree equivalent `voltage_uv` variable in the `val =` computation ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/dac/ad5686.c | 6 +++---
 drivers/iio/dac/ad5686.h | 1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 4c9f7ade52b32d..39c76e9dcb498c 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -520,7 +520,7 @@ int ad5686_probe(struct device *dev,
 		break;
 	case AD5686_REGMAP:
 		cmd = AD5686_CMD_INTERNAL_REFER_SETUP;
-		ref_bit_msk = 0;
+		ref_bit_msk = AD5686_REF_BIT_MSK;
 		break;
 	case AD5693_REGMAP:
 		cmd = AD5686_CMD_CONTROL_REG;
@@ -532,9 +532,9 @@ int ad5686_probe(struct device *dev,
 		goto error_disable_reg;
 	}
 
-	val = (voltage_uv | ref_bit_msk);
+	val = voltage_uv ? ref_bit_msk : 0;
 
-	ret = st->write(st, cmd, 0, !!val);
+	ret = st->write(st, cmd, 0, val);
 	if (ret)
 		goto error_disable_reg;
 
diff --git a/drivers/iio/dac/ad5686.h b/drivers/iio/dac/ad5686.h
index 760f852911df76..182d951912d847 100644
--- a/drivers/iio/dac/ad5686.h
+++ b/drivers/iio/dac/ad5686.h
@@ -46,6 +46,7 @@
 
 #define AD5310_REF_BIT_MSK			BIT(8)
 #define AD5683_REF_BIT_MSK			BIT(12)
+#define AD5686_REF_BIT_MSK			BIT(0)
 #define AD5693_REF_BIT_MSK			BIT(12)
 
 /**
-- 
2.53.0

