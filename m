Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB203C553B
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 01:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780624318; cv=none; b=lJkMpA/F11dUOvJbTG4XT7sI2XyrrNBlRhrYIVR0F4zrIAumwtuYVZd/7do14hwsDlbzsD3TVUR2y4oaBnyD4SYhAU4QXwDxeM1HHbhW1dk5+fi2tSmmv9o8BwSHPqB0TSZLHR7awesMYOyT/+bZdupfkwnC+PC431zh1aMGg4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780624318; c=relaxed/simple;
	bh=zITTwIAON6e9dhGjU43w9I3P+mmgfo1ItB7juydjMb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iBedJxObzQ/CxWcRO0r+c8nVs9C7e/72uabV7WqnUDgnSPgKi9jah6TXtwbm/IampBC+DxVqrzObeWfth3gApNZ/XxnNaE77ri5/n8EwbBLpUpCm5Wcj6j6p5klXjYkMw77TOurYton30Cap2T+HteyGCO5vCZn27MKTmvXtNVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A65RbMWK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A65RbMWK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0279E1F00893;
	Fri,  5 Jun 2026 01:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780624313;
	bh=okwUuAxQAc24ui5FamoGQJ48o0tO93P3Cr8pvXd+5sY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A65RbMWKbkigkzGrH4ve21SrOD+D8qrYTj3gcoMDf0Aci7TueuIae1Y1wYAVxrmEU
	 SlEYkFv6VbuFSwDIiPwg1i/O5cju4wOE/92LnJOC7WLTyN/xzI9ExGS5rw3BuToxWh
	 rSDirPPu3cBKMe/mPOLt8LlTo07ymdGPC0WkEmUmCoGbAiXi7gM5bXC3yGhJHKpACY
	 X5NFIeOh8pXQeWyVSikCM3v4FLbFBnUe2i8La/XaYivyPLS0vhv2+DGpzldXczsRCL
	 sopRuYcKKnZSESKdf78QKG4AmN/LGlw3h1J0JHFHFRVW7cbW5ftEZkSdw2TSd/1WN0
	 OGcTcwgmn5WIg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Rodrigo Alencar <rodrigo.alencar@analog.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] iio: dac: ad5686: fix ref bit initialization for single-channel parts
Date: Thu,  4 Jun 2026 21:51:51 -0400
Message-ID: <20260605015151.3131582-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060404-armory-omega-643e@gregkh>
References: <2026060404-armory-omega-643e@gregkh>
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
index 3f10bb872c7924..e1c2e44c5113a0 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -488,7 +488,7 @@ int ad5686_probe(struct device *dev,
 		break;
 	case AD5686_REGMAP:
 		cmd = AD5686_CMD_INTERNAL_REFER_SETUP;
-		ref_bit_msk = 0;
+		ref_bit_msk = AD5686_REF_BIT_MSK;
 		break;
 	case AD5693_REGMAP:
 		cmd = AD5686_CMD_CONTROL_REG;
@@ -500,9 +500,9 @@ int ad5686_probe(struct device *dev,
 		goto error_disable_reg;
 	}
 
-	val = (voltage_uv | ref_bit_msk);
+	val = voltage_uv ? ref_bit_msk : 0;
 
-	ret = st->write(st, cmd, 0, !!val);
+	ret = st->write(st, cmd, 0, val);
 	if (ret)
 		goto error_disable_reg;
 
diff --git a/drivers/iio/dac/ad5686.h b/drivers/iio/dac/ad5686.h
index a15f2970577e96..8aa0300bd404d4 100644
--- a/drivers/iio/dac/ad5686.h
+++ b/drivers/iio/dac/ad5686.h
@@ -44,6 +44,7 @@
 
 #define AD5310_REF_BIT_MSK			BIT(8)
 #define AD5683_REF_BIT_MSK			BIT(12)
+#define AD5686_REF_BIT_MSK			BIT(0)
 #define AD5693_REF_BIT_MSK			BIT(12)
 
 /**
-- 
2.53.0

