Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793816580;
	b=SrOdxphlmVb526S7YNdZOZGNuaI/N9EchQ1TX5V3G+sIzQQzBEAZIapiHRmN5zEUnNo4
	 AIWaSGQXIOwurbIHhub5AZ7YteYdxRIToAFk03O1qfcKefcWAt2e6fyrYpaXxn2ZpH85s
	 1pEH52EaFtO1sJmea98dOu3DRGNcIVCwPAE7fdRpYXX1FCvthEEWFSW2KFNmf6Mxv0LLw
	 THydLbk8O+4LF7sGoRBsuK0v8j+vnokkQXozLyfGaQzjlY4y+s8+gwTHafyCwfj0nEIyR
	 oBZnOghK1AULBC5s6Vjwc+xTwZCEPJ0OFHa6TrouIhxqEZnxT5myRs3JkP2+sTzPs8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793816580;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=RPAdsIQY5Kx1joh+eUcsZRBucGrmF4dT+TKs44SKeg4=;
	b=mCOSG62hJxQ0N0IjAKW0Gjo7yS3A0xSXgt4Wv6bYuigEYY78zfzTn2z8XyOVU8WqKNq3
	 518a474LaMuRciTi6vrxKkupTb/GCmej4g+mXzVEDUz3Dx4muD6cYnCsWROOnK3TZU2Qv
	 jEGjLirEsCcAtKP9EQpEFvd+lkOq5d4KOAKR+eekVDNH626cNbWaFI4z4h1vob4FrX9tf
	 0f3/tJBe4hSwhRdEPucE7hJCnHXqJ+DlGt828sbR44SMzOQn6sCz0q06DzK22r6KsGaHd
	 jIEsGsk3+8RA5bvXyd5kHUZPwIrE41UouNisK/5G50xLzSWm2hGSDCkYfmyAbnYkuGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=keoOPYw+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB7C60702FA;
	Wed,  4 Nov 2026 18:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=keoOPYw+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5EBD1F000C1;
	Wed,  4 Nov 2026 18:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793816580;
	bh=RPAdsIQY5Kx1joh+eUcsZRBucGrmF4dT+TKs44SKeg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=keoOPYw+pXkNi3pK6fSumYCt8ftAzuk/oHMIUnoUbbR/aI+OrWxxC9ANh1TwRzzFM
	 bn/2hHBhE6AP0jOBqjiqjqC4YyqPQh7V170WyRi08qwRzCHiWEkHZKubD3meM1ivAg
	 CTCNfNdq2oB6wc/zS7JJtUSa472Q3kEEBwxnjYIk8wtG5iqmQGRd+KzUO5vVtY02ow
	 /jIMlTKjadGGkw7uZpkFeD3GYdksxYyae5C5eOLQDOMUofwXXTFNAw8FYFfy8XA7UR
	 77SrEUnaep5tHulgSRsUuDCH6OPqqTXJzOcEnsyYYfNcDJwSPy3Rlu8g5pRGhhwLaX
	 whcqecfo/vLHQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Wentao Liang <vulab@iscas.ac.cn>,
	ChiYuan Huang <cy_huang@richtek.com>,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 10/10] regulator: rt6190: Check pm_runtime_resume_and_get() return value in rt6190_out_enable()
Date: Wed,  4 Nov 2026 18:21:00 +0000
Message-ID: <20261104182148.1176116-11-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.398.g882cbad275-goog
In-Reply-To: <20261104182148.1176116-1-lee@kernel.org>
References: <20261104182148.1176116-1-lee@kernel.org>
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

rt6190_out_enable() ignores the return value of pm_runtime_get_sync()
and proceeds with register accesses even if runtime resume fails.

Use pm_runtime_resume_and_get() and return the error code on failure so
the usage counter is not left elevated and registers are not accessed
while the device is suspended.

Fixes: e6999e7cca7e ("regulator: rt6190: Add support for Richtek RT6190 regulator")
Closes: https://sashiko.dev/#/bug/linux-dcfab9b2-550f-4319-87a5-682c3f6cef75
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/regulator/rt6190-regulator.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/rt6190-regulator.c b/drivers/regulator/rt6190-regulator.c
index 21ced348a2cf..973335a9178d 100644
--- a/drivers/regulator/rt6190-regulator.c
+++ b/drivers/regulator/rt6190-regulator.c
@@ -99,7 +99,9 @@ static int rt6190_out_enable(struct regulator_dev *rdev)
 	u8 out_cfg[4];
 	int ret;
 
-	pm_runtime_get_sync(data->dev);
+	ret = pm_runtime_resume_and_get(data->dev);
+	if (ret)
+		return ret;
 
 	/*
 	 * From off to on, vout config will restore to IC default.
-- 
2.56.0.385.gac671c819a-goog

