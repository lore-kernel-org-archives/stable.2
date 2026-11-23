Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795420333;
	b=SfkidSNqS0pDvZJnM2fC7NHTo+Hljzl8sV64M0TFuZmdS1to3bdXqYwyHYLYGr7VbcXr
	 FKzLJAL1+GVPwYhExsQw1S+6y6A/00a3iNeaKViMX2rIy76gzWffcbOH16/cTpkhfYBR7
	 NGAM70ZD+KDNW5QvwaQnaqX5CWDOxX/UxOnQ6Do9NdoRQ18chtZqOdFeuZCnsowQZDphY
	 tHro35QqOymS17TfynO2fHjyW5Hdc1mlUDThp25XqcMB4B6WLWr/pLdex3nAs3WyoxIxf
	 VQ/wu9EHUUnuIqyW17XNUSwWlF9gYK2KSQ6FdMRoROxpyRpY/HxJ2NaZd9S07QXX3NA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795420333;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9L/uB9YKTqcIXG5snVM/1M/beitHoknzxunxoF1iTN0=;
	b=C9VDyR7Vgsz+5h2Vudq8JYhpC+Qcx5k8rqIC48DPLFRcJODFkoVb4uVxTz9IWoX1I7He
	 X0KpsVeBPa+GxBXpO4Kyv9DwOJuRhblktWt6/FQq+HvsWjVNLI6qv/gmpbe44xNnbJOwK
	 mFnS6w7WYZBm7cLnPRACE6hxfAXs/FpWg8bL0NPca22tJkfZt5sxgoZQ9U7RO2v7vGVwv
	 pw7mBdqNcY3gcHjNuyMIN45LVH75bG85hIkxuVYPZdlrbSbIFOGuFkGsmjS488ktNzH5I
	 m1Sppueqae5z9NrvQaVRpGoR6QTmLF4arscbhmLjpPEX9fm1JjpRQmQbUOydZi1jhQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RPrAzqwO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEB5606A31E;
	Mon, 23 Nov 2026 07:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RPrAzqwO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF861F000D4;
	Mon, 23 Nov 2026 07:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795420333;
	bh=9L/uB9YKTqcIXG5snVM/1M/beitHoknzxunxoF1iTN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RPrAzqwOw9XPFQZrikGt3pcMD8WGP2ipxlnAmY0OTOYvPnmCFGL15UXF3iukXOT8X
	 YltaN3xU4Wv+2ZU8vzXeg9ECqj63VTICUr57qaSREFywhu6q/FTT1JhvwVXIn9VM+I
	 R2cyXr/YE2rrIUQThzYNYnD0iyPLGE7kL3Edxh7erzFV5xC3+hYa91HFtWBVvjWusf
	 +euACf1jdEsMHrqhj0ET/udGrhvb3aEBgzgSebc8bWLfa0rzLMjDiAVsBw4cQS8GdX
	 lrn8NlsDEn4I1ZXkhnv8IW8Fq8+QeAwtFviQIJkIzRHsOg+48BfebzFSaXhLrlsQqW
	 I4r3Xxb8stbOg==
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
Subject: [PATCH v2 5/7] iio: adc: qcom-spmi-adc5-gen3: Free TM auxiliary device wrapper in release callback
Date: Mon, 23 Nov 2026 07:50:31 +0000
Message-ID: <20261123075122.373060-6-lee@kernel.org>
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

struct tm5_aux_dev_wrapper embeds a reference-counted struct
auxiliary_device, whose memory must be released from its dev.release
callback once the final device reference is dropped.

Allocating the wrapper and its tm_props array with parent-managed
devm_*() helpers and providing an empty adc5_gen3_aux_device_release()
causes parent devres teardown to free both allocations immediately when
the parent unbinds, even if external references to the embedded struct
device are still held.  It also leaks the OF node reference taken by
device_set_of_node_from_dev().

Allocate the wrapper and tm_props array without devm, release them
together with the OF node reference in adc5_gen3_aux_device_release(),
and register auxiliary_device_destroy() via devm_add_action_or_reset()
once the auxiliary device has been added.

Fixes: baff45179e90 ("iio: adc: Add support for QCOM PMIC5 Gen3 ADC")
Closes: https://sashiko.dev/#/bug/linux-b738d116-f32b-4edf-aa73-77827b79a407
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---

v1 => v2:
 - Allocate tm_props without devm and release it alongside the OF node
   reference in adc5_gen3_aux_device_release() (Jonathan)
 - Move auxiliary_device_init() earlier and register
   auxiliary_device_destroy() via devm_add_action_or_reset(), avoiding
   devm_release_action() (Andy, Jonathan)
 - Note: <linux/container_of.h> is already included

 drivers/iio/adc/qcom-spmi-adc5-gen3.c | 57 +++++++++++++--------------
 1 file changed, 27 insertions(+), 30 deletions(-)

diff --git a/drivers/iio/adc/qcom-spmi-adc5-gen3.c b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
index a23eb5c9096d..85450aa37e65 100644
--- a/drivers/iio/adc/qcom-spmi-adc5-gen3.c
+++ b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
@@ -21,9 +21,11 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
+#include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/unaligned.h>
 
@@ -598,24 +600,22 @@ static int adc5_get_fw_data(struct adc5_chip *adc)
 	return 0;
 }
 
-static void adc5_gen3_uninit_aux(void *data)
+static void adc5_gen3_aux_device_release(struct device *dev)
 {
-	auxiliary_device_uninit(data);
-}
+	struct tm5_aux_dev_wrapper *aux_device =
+		container_of(dev, struct tm5_aux_dev_wrapper, aux_dev.dev);
 
-static void adc5_gen3_delete_aux(void *data)
-{
-	auxiliary_device_delete(data);
+	of_node_put(dev->of_node);
+	kfree(aux_device->tm_props);
+	kfree(aux_device);
 }
 
-static void adc5_gen3_aux_device_release(struct device *dev) {}
-
 static int adc5_gen3_add_aux_tm_device(struct adc5_chip *adc, int id)
 {
 	struct tm5_aux_dev_wrapper *aux_device;
 	int i, ret, i_tm = 0;
 
-	aux_device = devm_kzalloc(adc->dev, sizeof(*aux_device), GFP_KERNEL);
+	aux_device = kzalloc_obj(*aux_device);
 	if (!aux_device)
 		return -ENOMEM;
 
@@ -624,11 +624,20 @@ static int adc5_gen3_add_aux_tm_device(struct adc5_chip *adc, int id)
 	aux_device->aux_dev.dev.parent = adc->dev;
 	aux_device->aux_dev.dev.release = adc5_gen3_aux_device_release;
 
-	aux_device->tm_props = devm_kcalloc(adc->dev, adc->n_tm_channels,
-					    sizeof(*aux_device->tm_props),
-					    GFP_KERNEL);
-	if (!aux_device->tm_props)
+	ret = auxiliary_device_init(&aux_device->aux_dev);
+	if (ret) {
+		kfree(aux_device);
+		return ret;
+	}
+
+	device_set_of_node_from_dev(&aux_device->aux_dev.dev, adc->dev);
+
+	aux_device->tm_props = kzalloc_objs(*aux_device->tm_props,
+					    adc->n_tm_channels);
+	if (!aux_device->tm_props) {
+		auxiliary_device_uninit(&aux_device->aux_dev);
 		return -ENOMEM;
+	}
 
 	aux_device->dev_data = &adc->dev_data;
 
@@ -639,28 +648,16 @@ static int adc5_gen3_add_aux_tm_device(struct adc5_chip *adc, int id)
 		i_tm++;
 	}
 
-	device_set_of_node_from_dev(&aux_device->aux_dev.dev, adc->dev);
-
 	aux_device->n_tm_channels = adc->n_tm_channels;
 
-	ret = auxiliary_device_init(&aux_device->aux_dev);
-	if (ret)
-		return ret;
-
-	ret = devm_add_action_or_reset(adc->dev, adc5_gen3_uninit_aux,
-				       &aux_device->aux_dev);
-	if (ret)
-		return ret;
-
 	ret = auxiliary_device_add(&aux_device->aux_dev);
-	if (ret)
-		return ret;
-	ret = devm_add_action_or_reset(adc->dev, adc5_gen3_delete_aux,
-				       &aux_device->aux_dev);
-	if (ret)
+	if (ret) {
+		auxiliary_device_uninit(&aux_device->aux_dev);
 		return ret;
+	}
 
-	return 0;
+	return devm_add_action_or_reset(adc->dev, auxiliary_device_destroy,
+					&aux_device->aux_dev);
 }
 
 void adc5_gen3_mutex_lock(struct device *dev)
-- 
2.56.1.750.gf70dc682cf-goog

