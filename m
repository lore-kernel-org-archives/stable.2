Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793692679;
	b=vEVNYkK0Avf259pMJkS39HQc8YE1H7ATtKqebUps3cygao5TuWYR//QvsByHrJU2msjm
	 4oPkz3eIChUxWWt+m2Wi1L01jHK622BQcPk/QO4+V3fa7c3rZtG3mdaVyt3kA82hIPFl+
	 foXm4OTwlai5D1UllWPJj+de3oeCrwfqnLD/hrrVoVWwyYWMZl18NkInhMKcHqUmKDcRP
	 Zdohn2bdleX9E0ajwloEP5Yg+Oo4l3Lubpa0aS8e5TYZ6CfXhBMOyzJPulimcgsMarelS
	 v1+5M630mrFHe/Ityl7krZWwbGIh6Mv5gjJGbtUAf7N/c/VBTKkNySUttS4mhg+1Ljw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793692679;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=mjB1FUwUtT5QGUCuwrBFNie1AYnLTotMNeb6EtwPTNY=;
	b=jB+5w6kXD93TyA3nwXmBD47rtYGNUmqLCp64PEikTQjvkjaobvSBYMrHP6K9T88HwV0t
	 6ro9n7KrxgHlV6UyfrYIapXRzTfpASwSF8gx7oqsPNRUAivvSLdA2b52OTEEpTtE+TrXJ
	 QRB05o7Y0ibnAoQOLGvclIElKtM0FS/OSU8Z+fwuv5dsoEFK+vi4KE4KYo+KfiwMgVwsG
	 qaPi0osCZzZx+f6cXUxk0e9aDXzKkfSOuTbKUFluOt4/W9xbU2q5S+DoMkJDEWCh2is55
	 JflG6KshMv4BUSJz5VFIQ2/4PbG++fzTD5H4vxweG8lAG3YUxJba3owF8/Ld9sby80g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48799606A324;
	Tue,  3 Nov 2026 07:57:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48799606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAB3h5j9k+lqwCY6AA--.1005S2;
	Tue, 03 Nov 2026 15:57:49 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: andrzej.hajda@intel.com,
	neil.armstrong@linaro.org,
	rfoss@kernel.org
Cc: xji@analogixsemi.com,
	windhl@126.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/bridge: anx7625: Release the MIPI host node at teardown
Date: Tue,  3 Nov 2026 07:57:58 +0000
Message-Id: <20261103075758.1119919-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:rQCowAB3h5j9k+lqwCY6AA--.1005S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr4UtrWDWrW8tFy3XF4xWFg_yoW8uFy7pF
	4UKFW5Xr1kAF1xKws7ZF4DZr90v392grWfG3s7twna93sYya4DJrWqvFyrXas0kFyrJF15
	tr4UtF9xZa1jvr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVWxJr0_GcWlOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	tVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfU7nmRUU
	UUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRIAA2rpWfXQggABsk

anx7625_parse_dt() obtains a reference to the MIPI host node and keeps
it in the platform data for DSI host lookup. Neither the probe failure
paths nor device removal release this reference.

The existing put before looking up the node only releases a previously
stored value. The platform data is freshly allocated for each probe, so
that does not release the reference acquired by the current probe.

Register a managed action to put the node when probe fails or the device
is removed. Drop the put of the initially empty platform data field.

Fixes: 8bdfc5dae4e3 ("drm/bridge: anx7625: Add anx7625 MIPI DSI/DPI to DP")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/bridge/analogix/anx7625.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index c3af88e14f8b..3ee22f5f7bc2 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -1841,6 +1841,11 @@ static int anx7625_get_swing_setting(struct device *dev,
 	return 0;
 }
 
+static void anx7625_put_mipi_host_node(void *data)
+{
+	of_node_put(data);
+}
+
 static int anx7625_parse_dt(struct device *dev,
 			    struct anx7625_platform_data *pdata)
 {
@@ -1850,7 +1855,6 @@ static int anx7625_parse_dt(struct device *dev,
 	anx7625_get_swing_setting(dev, pdata);
 
 	pdata->is_dpi = 0; /* default dsi mode */
-	of_node_put(pdata->mipi_host_node);
 	pdata->mipi_host_node = of_graph_get_remote_node(np, 0, 0);
 	if (!pdata->mipi_host_node) {
 		DRM_DEV_ERROR(dev, "fail to get internal panel.\n");
@@ -1883,7 +1887,8 @@ static int anx7625_parse_dt(struct device *dev,
 	if (of_property_read_bool(np, "analogix,audio-enable"))
 		pdata->audio_en = 1;
 
-	return 0;
+	return devm_add_action_or_reset(dev, anx7625_put_mipi_host_node,
+				       pdata->mipi_host_node);
 }
 
 static int anx7625_parse_dt_panel(struct device *dev,
-- 
2.34.1

