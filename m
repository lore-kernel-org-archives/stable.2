Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795102352;
	b=y5wz+vzzWPRDhYXyocfNxZC8GLboSvyMQc7ECKPGAHhQdy1XGzN3v/8Dhd7Il7e7b1G6
	 YrDsGyxCZV2mmCFxb2RwK1w/8Gg9uYX3rU2TcMiSrb3I83RG3tkglCLEQh+f3eUpxWjMq
	 Qwgc9/Xq4qAX3JKR+cOFO3nL1/BaVo0Z7Nvexy4EbNCjy9t4l6geanzT3Teo+MruAR0nM
	 TadWSFi3bUFWwb0jmy5GNnuH2Q+xJP8Ny8hsvs+zoZFupmQ2kFyXLFBYBNjQrGYnp6GlE
	 uIc+KYDOtBvoPUQ7v6wzrDIBEFFU7i8bdamk65xL+D38Z1YEdgTIWTH/dhdNrpus5pQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795102352;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=D8f1UahNUjgzMsm8znFE5WLj649JFdIGcxM6MQpNpD4=;
	b=49VpKk2hdS2ND/atMy5S/Rt/XUWnwL1I0Oa7tDq501o22maJBYXxpw2FAxLvTtZcivcu
	 efi/id7d6Uc+DU4Jh8IW9r3n/ufO2oPtzzv+8HmhDjASLSGCSAtMKCOWrpcCKZ5E481ru
	 vv5hKo0104jO+hMGVNDW+dLB0LESDooXVExTRD3Tzjk9j2UAbFEiBttW5nV4wqyuxiPnZ
	 oROvLaoGg5WYOnsYMFayjagQS9kd9TPAGboNnYCMA0bYcRjIUUqArfhuIGntCL3Q4Dl+0
	 JG/skhcsITUq6wjod/Fkw0oXUIJvhqXjTP604q8YT7znnUQr2+mRDGmOcrz57k/UQbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BSHRraet;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A5560A380B;
	Thu, 19 Nov 2026 15:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BSHRraet
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 690581F000C6;
	Thu, 19 Nov 2026 15:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795102351;
	bh=D8f1UahNUjgzMsm8znFE5WLj649JFdIGcxM6MQpNpD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BSHRraettQJFilRi/O+p2hhBy2E8UGAg3xN6SR5ZTBFoZJUw4gbvb2Cj4N8fztkfB
	 G5eqFErOREBSDVBzOjDkSQ+z5B/exnZLMjuPVJuE2O5BPBnJVbvbo4TjZiCeFkMdR2
	 qW9d+oJ+mB3aQVEScK4J7vaoRCGiRD+NxDcDA2KK0KbcM6kLVybYwvRUhurWv1xnEU
	 QsTFjrwQnwzrUekmr2aJV2oUWuV0OKGwiq5+jWE3goJ8/DCpq7A5OrzpSfVyylcnB2
	 jvKRGKA163gJxFStcCi6ccL7RHHQyeVX6tIHxmtKspw4o8/RHagVSFae8kqe3RbrlD
	 /KrDBhfOwBcAw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	linux-iio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 04/10] iio: adc: stm32-adc: Validate channel index before writing chan_name
Date: Thu, 19 Nov 2026 15:30:37 +0000
Message-ID: <20261119153151.1397003-5-lee@kernel.org>
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

stm32_adc_generic_chan_init() reads the child node's reg property into a
signed int and, when the optional label property is present, writes into
adc->chan_name[val] and calls stm32_adc_populate_int_ch() before
checking whether val exceeds adc_info->max_channels.  Because val is
signed, values with the top bit set also become negative and bypass the
upper-bound check altogether.

Store val as a u32, matching fwnode_property_read_u32(), and move the
max_channels bounds check immediately after reading reg.

Fixes: 95bc818404b2 ("iio: adc: stm32-adc: add support of generic channels binding")
Closes: https://sashiko.dev/#/bug/linux-efd2944a-ec30-488d-b2ac-1c7feb831095
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/iio/adc/stm32-adc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index ab99116aea0a..42f1fc64250a 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -2745,9 +2745,9 @@ static int stm32_adc_generic_chan_init(struct iio_dev *indio_dev,
 	const struct stm32_adc_info *adc_info = adc->cfg->adc_info;
 	struct device *dev = &indio_dev->dev;
 	const char *name;
-	int val, scan_index = 0, ret;
+	int scan_index = 0, ret;
 	bool differential;
-	u32 vin[2];
+	u32 val, vin[2];
 
 	device_for_each_child_node_scoped(dev, child) {
 		ret = fwnode_property_read_u32(child, "reg", &val);
@@ -2755,6 +2755,10 @@ static int stm32_adc_generic_chan_init(struct iio_dev *indio_dev,
 			return dev_err_probe(dev, ret,
 					     "Missing channel index\n");
 
+		if (val >= adc_info->max_channels)
+			return dev_err_probe(dev, -EINVAL,
+					     "Invalid channel %u\n", val);
+
 		ret = fwnode_property_read_string(child, "label", &name);
 		/* label is optional */
 		if (!ret) {
@@ -2773,10 +2777,6 @@ static int stm32_adc_generic_chan_init(struct iio_dev *indio_dev,
 			return dev_err_probe(dev, ret, "Invalid label\n");
 		}
 
-		if (val >= adc_info->max_channels)
-			return dev_err_probe(dev, -EINVAL,
-					     "Invalid channel %d\n", val);
-
 		differential = false;
 		ret = fwnode_property_read_u32_array(child, "diff-channels", vin, 2);
 		/* diff-channels is optional */
-- 
2.56.1.708.g77570a6a1d-goog

