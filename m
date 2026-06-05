Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1CE2F3C0E
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 00:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780621178; cv=none; b=HaTCYwpA52otZsQG1EwbF2xySxX1ucx5zRcH20LXp2UDSK7wD++HObDHlVuLV9+g8cV83fjSWS/MWpg0Luf9Ofs79PbxvfErWXTRvTjojFPmtrN+/YhPS2gxlTJZ3wvxMl9CNy41hrK3FZP29ou1MS6lDvBDfq3P6z57jZgyZ7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780621178; c=relaxed/simple;
	bh=lV+a5utCZbF4T8qfeHbhVsnAqPU5KBsfptgnsg/dAz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F5TyMitsDdL/maatsmGSQ77MDio8ehrrdff/qAG055PkJ5PGFHGp+17Kr8UzS2/GtUgoAFSigm0akqGbTCGaT3iv4gjNNqryOBxo2XkdveFo1r8j/eFCVNzCy4MroWZ6EDCFz7KQo33GCxORjEqvY2630xuQDLCNfwL2chPhML8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JVWakS8b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JVWakS8b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47B9A1F00898;
	Fri,  5 Jun 2026 00:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780621158;
	bh=1vrxIyOiVV/IEZP+3v3ogpkeWRvZs8QLt1SjDwAHeWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JVWakS8bknwn24E6YvueMoc4I33DluOcgaaVLCw3dKJr9xYsmM4wiYQzqOikebf0T
	 6LAi9/5fUhRjLXeSmUVblj0gxQNzzHhZoHLIkj643we/hQ+/QndGfocJjok2uceEtx
	 dO4VGHV7Tb6BAazIQwb+ZGedQfXPPlBPpXNi8dLvgmQqdU7+quXjtq8UYfFuaQV38t
	 RB4gTkO+r+VGMrjLQLeA4uesxTpJfAD6MqtHqHEO+H5qm5P2xwUMkGSt+oLwfPTsPn
	 rP7PEqRTEAnZNhfGApqVHrvfPS0mmd0TEcfcKKNd20QUT7lVjUCivsJdPybrjG6w5D
	 MOYMES35N03HA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Rodrigo Alencar <rodrigo.alencar@analog.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] iio: dac: ad5686: fix ref bit initialization for single-channel parts
Date: Thu,  4 Jun 2026 20:59:16 -0400
Message-ID: <20260605005916.2803184-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060403-gallon-annually-a48b@gregkh>
References: <2026060403-gallon-annually-a48b@gregkh>
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
index 7d1b2b83172de9..b5ea1561a11332 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -513,7 +513,7 @@ int ad5686_probe(struct device *dev,
 		break;
 	case AD5686_REGMAP:
 		cmd = AD5686_CMD_INTERNAL_REFER_SETUP;
-		ref_bit_msk = 0;
+		ref_bit_msk = AD5686_REF_BIT_MSK;
 		break;
 	case AD5693_REGMAP:
 		cmd = AD5686_CMD_CONTROL_REG;
@@ -525,9 +525,9 @@ int ad5686_probe(struct device *dev,
 		goto error_disable_reg;
 	}
 
-	val = (voltage_uv | ref_bit_msk);
+	val = voltage_uv ? ref_bit_msk : 0;
 
-	ret = st->write(st, cmd, 0, !!val);
+	ret = st->write(st, cmd, 0, val);
 	if (ret)
 		goto error_disable_reg;
 
diff --git a/drivers/iio/dac/ad5686.h b/drivers/iio/dac/ad5686.h
index b7ade3a6b9b6c9..3657f45869b628 100644
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

