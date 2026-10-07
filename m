Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9479C2F616A
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 06:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791353450; cv=none; b=ljIxW3HOVFYBxUt6eXcuHZKGsmJ0BmohOznNnEIDKTTPsY557ckLhdA4sAZAh1xUrMtDoMqoTVEXpi67xCgwGgMn+rnPJZ6UQ8GWOMdqw1saLA3EB+AR/okR67mZ8KKtQcW4VQoVA4OsnQutMEYRLHqJw8merCo0rV0WvM5SCxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791353450; c=relaxed/simple;
	bh=4ZzM6IQBPSWL3ZwcnS6E3uR2cUjtf4qvrWa3Zwbz/nk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eOrPtwrjFxGfeR+xFwRdROXTbIcS2ehApSnylcu6s5JY8ofmyaAGSXaR9P4X5xJC4EBMmuAojqPU6uw/CzC2OYdotMHeMolW92LI214O+jrV1/hnKcG10uz0MmOadrNqSTKczsIg/3oRU2VEzlgRWolOFp1ZJck1PQ5rsaaDMAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3wR640+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3wR640+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD09B1F0089C;
	Wed,  7 Oct 2026 06:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791353449;
	bh=j91zJtbzPHGgVzwyF5LKgbsiwNQQetjfNLlc5pBJDJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l3wR640+lXIaxTDZDqnm5Y7zNmUmlq6gO56daZtLGOC97Q4IJxfe/MhhQP0WjxsMC
	 xNqV/Aqu4nYq8vDz1w5IZjDxouXRzIuZ/jpDgEa5z6Kekh/9t9kBKwxISHRGaMu/cz
	 V0uycHMmtze9TqhNzc1Ag6zBrAloRWd9WcI4sFyx5rus9D8wrxFqgpT3ECL0HW5gOf
	 vR63rtmJeVBP6/781jnaQB1kS8D28ScVdsGRaTXExHSylfbNvNaSOXhJFSOzwd6hBS
	 Btf5zCUesQSNLJrtIi3zMuTHAhjpVzl9E9AEr4qb+tdweE4NCno/u3Q/fmyjK7ozf0
	 lg15VMBtGgB0g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/3] iio: adc: ad4030: Use BIT macro to improve code readability
Date: Wed,  7 Oct 2026 02:10:42 -0400
Message-ID: <20261007060913.1488382-2-sashal@kernel.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Marcelo Schmitt <marcelo.schmitt@analog.com>

[ Upstream commit a10f6dd4eef2e64fe1f366613bed45aa308494de ]

Use BIT macro to make the list of average modes more readable.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Stable-dep-of: d61521056420 ("iio: adc: ad4030: fix invalid oversampling_ratio validation")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/ad4030.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
index d8bee6a4215a3..aec95aceb81fa 100644
--- a/drivers/iio/adc/ad4030.c
+++ b/drivers/iio/adc/ad4030.c
@@ -232,10 +232,16 @@ struct ad4030_state {
 	.num_ext_scan_type = ARRAY_SIZE(_scan_type),			\
 }
 
+/*
+ * AD4030 can average over 2^N samples, where N = 1, 2, 3, ..., 16.
+ * We use N = 0 to mean no sample averaging.
+ */
 static const int ad4030_average_modes[] = {
-	1, 2, 4, 8, 16, 32, 64, 128,
-	256, 512, 1024, 2048, 4096, 8192, 16384, 32768,
-	65536,
+	BIT(0),					/* No sampling average */
+	BIT(1), BIT(2), BIT(3), BIT(4),
+	BIT(5), BIT(6), BIT(7), BIT(8),
+	BIT(9), BIT(10), BIT(11), BIT(12),
+	BIT(13), BIT(14), BIT(15), BIT(16),
 };
 
 static int ad4030_enter_config_mode(struct ad4030_state *st)
-- 
2.53.0

