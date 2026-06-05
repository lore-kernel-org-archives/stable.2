Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841493A9852
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 01:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780623082; cv=none; b=n6kPkIvFGahajgirk8N4JSHAl/5n3qMx9HneDDqeRqlTBB2/lXw5Cy2GDcNLJlMN6YM3HyvrihzEwwVQUumuFDQOJV6PQFiGnW7ZwZS817gJx6BdRTZiHKH75GdFg+Xrfkiw05TytaYMAUQNt0CMtpUvtdoKg3WcY0pRStk/QNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780623082; c=relaxed/simple;
	bh=Ayjgb4pxuksq2255wr7xwXM15oMJ8ThgKe5kSFE9Re8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lKEYDveDlcIcpmUJX8ntzzyRinHVXEkGrtyARvzeC5Y4956UNtXLsg7JxllPIG4isHBbfPHCjU4IOpUDlrRDREH6W7PTAgbrTxDaty6FUb0QS78ZGK/uJY6m5eNkUPyMAEXOj5fLjlUQOB8xAZxfr82TK9Cev2IDQxZ+OJOE0Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WK9kHhKO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WK9kHhKO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D74B1F00898;
	Fri,  5 Jun 2026 01:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780623076;
	bh=Ze/Rd0X74n0Zs9PgQCb1alJ24HyEr45sooq/Qgt4Jx8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WK9kHhKOWCI5Dgx9ne7VK8Qo/qnWJizQ45PimWrOh1wPPzKk3BM3eolfPLPrgeNdb
	 F6eYjR4NhH/5zlN2r7hpHNiSyv3AEm0w5bLwG1q5CEwWQ8Xehb+Kk5ZH7M6M+YuOB1
	 mQqh6+0p+L0Sw5qzX3iA12ZMMoeicd7avI0KvjqcmKPT5l+jnxteRtDkVLKGRvkE+T
	 afVTsm7vYsBQzfMYecoDOws/fzhcRqxu/zaFJ1oNPNat47VIaGMJf96NzOAd7wnHA5
	 2xjDbd9GOZu7LBKAass20xqWI7IfODy3wA9lLF4dyFwqVCH4X3+E3dvupcBbtsbZ2L
	 eAB5kgECmxXLA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Rodrigo Alencar <rodrigo.alencar@analog.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] iio: dac: ad5686: fix ref bit initialization for single-channel parts
Date: Thu,  4 Jun 2026 21:31:12 -0400
Message-ID: <20260605013113.2963901-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060403-trembling-dragster-73ee@gregkh>
References: <2026060403-trembling-dragster-73ee@gregkh>
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
index be705f8148cc39..7069f1bc3cf545 100644
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
index f89a6f92b42706..62f6c52b0316d0 100644
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

