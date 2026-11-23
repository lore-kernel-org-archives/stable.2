Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795420346;
	b=u0ZWoUaMm8XDWQJ20uucaeabmXtOBCFaV96zmY9S2Mho88+Sj75u92OVbW+XNa5AUyp0
	 a3bCk41f3/Vx2DEyaCZhkVfoCWtxljVM61Ikxa7SYojeOBkQRXevooesjSbk+jGrtQIls
	 9mt41GH4PHbUTzy2PG2SXbDI2IhXgU2IvoDd0nUUS5yvqrSbYpDoP4Iffq2o8x2F6uP7Q
	 5GbCmU3ZrULbA3jEur3GHNDRtzj7IXcC677AMISOaKqEQrLWmMk6W85CtIhoKqTdTHZ+Y
	 ARsI/hjGgvZ2Z0SoDj/ZPUEuUzRMpqto2eX+uOjwvNz1wCLKnLcEZJV3dW5HLoHb1fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795420346;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=pzBruCLqcjTUf993fFO1zsE6F8+uGYlxYUHOWN/SV4U=;
	b=l4qTaN+UJ7krpWEml4yvrxSKi5hj+nAayB7sy8tPUydSMdEBrBhhZ/kMG8A37QGUwNKN
	 D7unE/CSldC2JUafH+8gWmw/CcAgXUOmcnQz/aOVwla+U2g1SwDFCpispFklXscNFBKja
	 T64yTSa00eox0T+q8dKkfMqEQILgE+Qz7HV8elap45gILSZGbNiWbF/mxxrAtuD3zCCEA
	 jPbb3JVBeugs/1hJy6WnVPRVdTClQq0Xb5rr28P4/prQohFu4W94LRbcfBy+Jl9/dqBQ1
	 +9ABTz/N4qCgbbX5c5cdW1mI8O9S/HLM9E6o/KmzZb19aaewyKJ5ptRTtw9a+YJxvtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T8WAQKBS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725FC606A688;
	Mon, 23 Nov 2026 07:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T8WAQKBS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC7F1F000D0;
	Mon, 23 Nov 2026 07:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795420346;
	bh=pzBruCLqcjTUf993fFO1zsE6F8+uGYlxYUHOWN/SV4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T8WAQKBSFSa+AYF4ma/3QxzVEqIGxhTDeaBYC5fDApUW6Q2MnCu8CQ8g0alJZ/FsG
	 8EEYKMcowfWLHZ86+Md4g7SXs3auULNQWpi+vTU5+UZTEiHzYXYmk7VbxUZ4e5jK4D
	 2YP04mQQp00xj1ZIFKESyZbmRiRLdwXs6rPXSWszuYU6Pt0r2qsKJ9xCuoklgl5mCo
	 8R6xeF98wltDir9AcX4DZ0LdVKco+nhMiYm0NSqNpBY+8KqsREbkKEY93iln0rvOsR
	 byYRTJX4jFA8xCUGB5kWpAYj5Och0Pqn/HOUX4mfDlI7CWMvKcEShCr4r/gpE40Y1k
	 8G2d6d6K81v4Q==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
	linux-arm-msm@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 6/7] iio: adc: qcom-spmi-adc5-gen3: Reject empty reg property in probe
Date: Mon, 23 Nov 2026 07:50:32 +0000
Message-ID: <20261123075122.373060-7-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
In-Reply-To: <20261123075122.373060-1-lee@kernel.org>
References: <20261123075122.373060-1-lee@kernel.org>
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

If a firmware node supplies an empty reg property,
device_property_count_u32() returns 0, which passes the negative error
check in adc5_gen3_probe() and leaves num_sdams set to 0.  Subsequent
zero-length allocations return ZERO_SIZE_PTR, which is then dereferenced
when requesting the VADC SDAM interrupt, and num_sdams * 8 - 1 wraps in
unsigned comparisons when counting TM channels.

Return -ENOENT when device_property_count_u32() reports zero elements.

Fixes: baff45179e90 ("iio: adc: Add support for QCOM PMIC5 Gen3 ADC")
Closes: https://sashiko.dev/#/bug/linux-d8ad5868-82f5-4c97-bc67-84ceebb10a1a
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---

v1 => v2:
 - Return -ENOENT instead of -EINVAL when reg is empty (Andy)

 drivers/iio/adc/qcom-spmi-adc5-gen3.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/adc/qcom-spmi-adc5-gen3.c b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
index 85450aa37e65..8e316aa88f48 100644
--- a/drivers/iio/adc/qcom-spmi-adc5-gen3.c
+++ b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
@@ -736,6 +736,8 @@ static int adc5_gen3_probe(struct platform_device *pdev)
 	ret = device_property_count_u32(dev, "reg");
 	if (ret < 0)
 		return ret;
+	if (!ret)
+		return -ENOENT;
 
 	adc->dev_data.num_sdams = ret;
 
-- 
2.56.1.750.gf70dc682cf-goog

