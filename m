Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795102393;
	b=P9IjyikZ2n8Q1SnTPFC8AVGWtVk5KEhbC4BYWH+WVPA/011Im/lzBDoALIp5/Ix5V/+1
	 hCz3iTRxoXNKT5EXU30r6pMW/wosJgh6LUN3yDAX6AObWzltXKjg30/QxiqS/TlosAUma
	 meHWBIHqOWuquAX4KJgJSJyyW3HQsMKGi7f5QlTVsgyotCvTqtPW5hFINs2dj/9bD4fbW
	 ypkarI2dt4TsadoTU3vASw7lfCVJbthfY4mL9uAEuMOv4YpvVIAWBE8enbUnnOLg+ZIyz
	 YqEncVwzqZqfFlkMLo3+GNnclFmV4YiediSiULzrT7e5f/S0w0R/9eFZ+aPX+UzZJsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795102393;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=C47UU6sNzV/YSeG5if9AX7uNFFdIQB9n03wIr1O1wrc=;
	b=EuJIR3EJhBwIsn/GsI4sC+9+s16tiK4UU7d26INqJ1S0iAP+Cjbjh7+Q7LS54jWXPbqQ
	 n0s135saeDWzhxiw+JpRm4lx0pXdYF+E/3+prwdGPTrDPEQNKse1o5GxGKgSZHTtZL4FD
	 RBir9U9mMUQHrwD4Cj/buCGmcUhII4wdvxEmug42UhhWz+2MIY0cOMcbpvFjIZwmYQQAb
	 N3wwJwyJcTGrZKu4buDp/CKFrHaHlf1496aJjRULNilsMLv4wP74buOXoxY21wyp4QLt4
	 k+ncM7Oso+GTbb78PHxRpqXnFUZPfUrYMkh0Ipf0l70C6X/qUz04c1QchKtNncQ9HHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Up1otlbj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F85606A32C;
	Thu, 19 Nov 2026 15:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Up1otlbj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27F221F000C7;
	Thu, 19 Nov 2026 15:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795102392;
	bh=C47UU6sNzV/YSeG5if9AX7uNFFdIQB9n03wIr1O1wrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Up1otlbjZIa/OUSEcTozZtnhEEQx6HmyXRxXPL6Cd2XiEl6jvHQfSQWDHnv4Syt3v
	 K44HwJm9o+kBYdtzdipAT4BhfVg1O/OmeTOg4OAqPxAqMkc0HbO2C7Oira2Awv/TmX
	 wvgIpv9i/SJbofWkn7zDV9S3lWPbv2wLzrCql9YL92rdqhd82BIkktli66AvUJFToU
	 QKFB9YwcvlhfEzqutcJVUFXuHdw9Am6fzvOcJ+9zmALH/G95sDVVHdFwYbHgjqRZFZ
	 nIJf1AI/3crpHbht0Mi3cvsXWJFe/j9Zzy0f+L1xFqgYWyxNQF/uQdkO+YUVV5vLD0
	 8LsCsREGb//bg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
	linux-arm-msm@vger.kernel.org,
	linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 08/10] iio: adc: qcom-spmi-adc5-gen3: Reject empty reg property in probe
Date: Thu, 19 Nov 2026 15:30:41 +0000
Message-ID: <20261119153151.1397003-9-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
In-Reply-To: <20261119153151.1397003-1-lee@kernel.org>
References: <20261119153151.1397003-1-lee@kernel.org>
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

Return -EINVAL when device_property_count_u32() reports zero elements.

Fixes: baff45179e90 ("iio: adc: Add support for QCOM PMIC5 Gen3 ADC")
Closes: https://sashiko.dev/#/bug/linux-d8ad5868-82f5-4c97-bc67-84ceebb10a1a
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/iio/adc/qcom-spmi-adc5-gen3.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/adc/qcom-spmi-adc5-gen3.c b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
index 52f039795418..9102346feea9 100644
--- a/drivers/iio/adc/qcom-spmi-adc5-gen3.c
+++ b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
@@ -756,6 +756,8 @@ static int adc5_gen3_probe(struct platform_device *pdev)
 	ret = device_property_count_u32(dev, "reg");
 	if (ret < 0)
 		return ret;
+	if (!ret)
+		return -EINVAL;
 
 	adc->dev_data.num_sdams = ret;
 
-- 
2.56.1.708.g77570a6a1d-goog

