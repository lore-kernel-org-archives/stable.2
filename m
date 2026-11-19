Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795102380;
	b=ONjcrqLLUCIhN+3mXOgGIV6cK//4sSSB+C/I2jmg/++bmxmAnDerZKQbHQIeORJuB8AM
	 WUsA/w6sE0X+xrcVI3DH1xZ3vGouCncNRWr9Oi+Uas4R1zebCfdJeK/of9/QRY3av1NVA
	 aRKQ+beIxkD1V6SiIgiCRARf5+qC2C3ZmLjwAfkZGXxngTjdlwQn15oT9v9g8fwBNPK8Q
	 KYyJnLzWcLmHnmrZU4sOREGL1tm+rF3+zUfoql/17N64tmmdZIhLOqO3q8uN0VOJGMMXQ
	 1yH4Or8w/mVo8bn2BwgWMkJUWtOKtJubhs9rzcx0op6rIH6Ora/lJajmmEALZr+4qug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795102380;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=o3dKSUXwzpHlMu8hRVlVzuUR+DCxdptQ4xWbHuYHzfc=;
	b=MreH1IdYBKr3+Lsig+dvbymNHCqgnFzlcj+MuFrRAMP4IuB14DqpWpQvUJxKV8KsN+UK
	 c/7dhk37eutM1UgA7nedAdETC+AOAsgRzfQ67eMOJBHrvRe0F+Mecz6L5d76bSc1MvqRy
	 QXLp0mek4d+SigKAjP8AddQn2uJ3EhFMNTe+B4is7HhWU7RquH1MUOgSZENZYhHcwr0b3
	 3NELriKL2bhcOTmPv8yA+WErziZpLitkMNMKfyWx6FNopjg4Nlc+3ttKKEVGL0DXAV4mY
	 Ch9Rf2wq63NmULyq7mKOUlUvZGpZTXb09pJ6Hw6lvsFHnjwI+6gSbzXniu7q0VCOoPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=No+g73Xh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0982E606A333;
	Thu, 19 Nov 2026 15:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=No+g73Xh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E20701F000C5;
	Thu, 19 Nov 2026 15:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795102379;
	bh=o3dKSUXwzpHlMu8hRVlVzuUR+DCxdptQ4xWbHuYHzfc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=No+g73XhDjBViduEqBQ4n3MG9HKKzqd8aN7OihB7z9+BkasyDcp++vVAEi2EvjcwM
	 K0hcDUDRACHsrwTyqYW9lf7ZhrTe+jkK+Yf3nse1HQRZTDpx++NQfYvWyrnLD8NTya
	 Hau+KH9QygCrlOTDhkwLJ5BvzD1ICEXOyUO7RDvhfyBPhQJpzZrTkE8+MyKgRTi1Yp
	 hA0LQkHoNuSC9jxcJVSvECagW2QS3RmDkDwn1Tql7opR/w5OsHKwDM8jz9JTlY3zSV
	 vbJ3ncsNIEuPew2hxwXZep9JH8lX5qhmxCsDTDR1y93aAwYbRBOurhEtzpFvYCf2OZ
	 tck4lOr6thvtQ==
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
Subject: [PATCH 07/10] iio: adc: qcom-spmi-adc5-gen3: Free TM auxiliary device wrapper in release callback
Date: Thu, 19 Nov 2026 15:30:40 +0000
Message-ID: <20261119153151.1397003-8-lee@kernel.org>
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

struct tm5_aux_dev_wrapper embeds a reference-counted struct
auxiliary_device, whose memory must be released from its dev.release
callback once the final device reference is dropped.

Allocating the wrapper with devm_kzalloc_obj() on the parent ADC device
and providing an empty adc5_gen3_aux_device_release() causes parent
devres teardown to free the wrapper immediately after
auxiliary_device_uninit(), even if external references to the embedded
struct device are still held.

Allocate the wrapper with kzalloc_obj(), release it from
adc5_gen3_aux_device_release(), and unwind cleanly on early error paths
in adc5_gen3_add_aux_tm_device().

Fixes: baff45179e90 ("iio: adc: Add support for QCOM PMIC5 Gen3 ADC")
Closes: https://sashiko.dev/#/bug/linux-b738d116-f32b-4edf-aa73-77827b79a407
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/iio/adc/qcom-spmi-adc5-gen3.c | 30 +++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/qcom-spmi-adc5-gen3.c b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
index 351c4fff17b4..52f039795418 100644
--- a/drivers/iio/adc/qcom-spmi-adc5-gen3.c
+++ b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
@@ -24,6 +24,7 @@
 #include <linux/platform_device.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
+#include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/unaligned.h>
 
@@ -607,14 +608,20 @@ static void adc5_gen3_delete_aux(void *data)
 	auxiliary_device_delete(data);
 }
 
-static void adc5_gen3_aux_device_release(struct device *dev) {}
+static void adc5_gen3_aux_device_release(struct device *dev)
+{
+	struct tm5_aux_dev_wrapper *aux_device =
+		container_of(dev, struct tm5_aux_dev_wrapper, aux_dev.dev);
+
+	kfree(aux_device);
+}
 
 static int adc5_gen3_add_aux_tm_device(struct adc5_chip *adc, int id)
 {
 	struct tm5_aux_dev_wrapper *aux_device;
 	int i, ret, i_tm = 0;
 
-	aux_device = devm_kzalloc_obj(adc->dev, *aux_device);
+	aux_device = kzalloc_obj(*aux_device);
 	if (!aux_device)
 		return -ENOMEM;
 
@@ -626,8 +633,10 @@ static int adc5_gen3_add_aux_tm_device(struct adc5_chip *adc, int id)
 	aux_device->tm_props = devm_kzalloc_objs(adc->dev,
 						 *aux_device->tm_props,
 						 adc->n_tm_channels);
-	if (!aux_device->tm_props)
+	if (!aux_device->tm_props) {
+		kfree(aux_device);
 		return -ENOMEM;
+	}
 
 	aux_device->dev_data = &adc->dev_data;
 
@@ -643,8 +652,10 @@ static int adc5_gen3_add_aux_tm_device(struct adc5_chip *adc, int id)
 	aux_device->n_tm_channels = adc->n_tm_channels;
 
 	ret = auxiliary_device_init(&aux_device->aux_dev);
-	if (ret)
+	if (ret) {
+		kfree(aux_device);
 		return ret;
+	}
 
 	ret = devm_add_action_or_reset(adc->dev, adc5_gen3_uninit_aux,
 				       &aux_device->aux_dev);
@@ -652,12 +663,19 @@ static int adc5_gen3_add_aux_tm_device(struct adc5_chip *adc, int id)
 		return ret;
 
 	ret = auxiliary_device_add(&aux_device->aux_dev);
-	if (ret)
+	if (ret) {
+		devm_release_action(adc->dev, adc5_gen3_uninit_aux,
+				    &aux_device->aux_dev);
 		return ret;
+	}
+
 	ret = devm_add_action_or_reset(adc->dev, adc5_gen3_delete_aux,
 				       &aux_device->aux_dev);
-	if (ret)
+	if (ret) {
+		devm_release_action(adc->dev, adc5_gen3_uninit_aux,
+				    &aux_device->aux_dev);
 		return ret;
+	}
 
 	return 0;
 }
-- 
2.56.1.708.g77570a6a1d-goog

