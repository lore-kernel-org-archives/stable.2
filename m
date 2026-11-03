Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793692753;
	b=VfWSHd2moFxwrmnQ+gH9TzLjUJv/10zFIrbGNWCtgueXfVid2wJsheoCL73BYm/37vN1
	 J8SfQLIbxP9BP+wD8whrukgPMpYnyn+UaifGAyFP87M8UPF0snnL5p5B0849B/xcjl53n
	 N+7FAfZAe4Mp7npubT68899LLvlXU+FSd8vAD+5BxU4ddz9XBW1zPr7qIW6HTl+hOTwdM
	 wZZ4GXa6KO6a2rNfxgiT+seWa2/f9TzkbY6mb9ewoESNWVYcdKOBTCCARFsw9zK6EE4s9
	 Qjc3YcKEdOS/0hSkdfPLA6+EIIlSTi60442gwYuK7GtQ0Ik408qtikqDmuFCYKVK0gA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793692753;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=WWjKOI0SdsiCS2WD0/QHJpoPhNs0Ahj17GF+Mp/MARc=;
	b=J+wS3or56nypOOaKEkvDidJJ6ycmnYb38AC7SzZ3kVCcQ9fuZZxpy4Dj48tW43olvobA
	 4H+27GzUVoHBmWQMr50967qd0LpJ9m3aMqNx19UNL0eUWc4SQbnTvaRjE9ecd2VM6JC8D
	 DzcMoNTUXe0SXffNX33XNT527Z763lVYeZ1D6UGHa7WdZJQRyECUwYvR57KrcJ7x3vNT8
	 OdP/yRtrJFCs5hpkji5poItVPFnQ6KCwKiTQUSLnQJB1yoZvqHrPI6SbHktuWUiQdsWDG
	 eHoRzqhDlKvruBCpWAgQZlmkrTfZXrENkMS3q1ngD/YupfZRZi5KDD58utSjmLgdDBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F290606A32C;
	Tue,  3 Nov 2026 07:59:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F290606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowACneZpJlOlq2Ck6AA--.4203S2;
	Tue, 03 Nov 2026 15:59:05 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: jani.nikula@linux.intel.com,
	joonas.lahtinen@linux.intel.com,
	rodrigo.vivi@intel.com
Cc: tursulin@ursulin.net,
	daniele.ceraolospurio@intel.com,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/i915/pxp: Unwind component binding if HuC loading fails
Date: Tue,  3 Nov 2026 07:59:14 +0000
Message-Id: <20261103075914.1122975-1-vulab@iscas.ac.cn>
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
X-CM-TRANSID:rQCowACneZpJlOlq2Ck6AA--.4203S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr4DXw4ruw47tF1fJFWDArb_yoW8ArW3pa
	1aqan0krW5WF1Ig3y7Aa18ZFyfX3WFkayfCa9xKas2krsrCFykZry7tFWjgryjyrs3Xasx
	tr17try2gFy0kaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr1j6rxdMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcS
	sGvfC2KfnxnUUI43ZEXa7VU8jQ6JUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgMAA2rpWmXWhgAAsq

The PXP component bind callback publishes the component pointer and may
create a stateless device link before loading HuC firmware. If HuC
loading fails and the device is active, the callback returns that error
without clearing either resource. The component framework does not call
unbind for a component whose bind callback failed, leaving a stale
component pointer and an unreleased device link.

Clear the published pointer under tee_mutex and delete the link before
returning the firmware error. Check the error before the suspended-device
shortcut too, so binding failure does not depend on runtime PM state and
PXP hardware initialization is skipped on failure.

Fixes: 087b681805f1 ("drm/i915/dg2: setup HuC loading via GSC")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/i915/pxp/intel_pxp_tee.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/i915/pxp/intel_pxp_tee.c b/drivers/gpu/drm/i915/pxp/intel_pxp_tee.c
index 1784153f0cf8..97169ae51d3c 100644
--- a/drivers/gpu/drm/i915/pxp/intel_pxp_tee.c
+++ b/drivers/gpu/drm/i915/pxp/intel_pxp_tee.c
@@ -186,6 +186,18 @@ static int i915_pxp_tee_component_bind(struct device *i915_kdev,
 		}
 	}
 
+	if (ret < 0) {
+		mutex_lock(&pxp->tee_mutex);
+		pxp->pxp_component = NULL;
+		mutex_unlock(&pxp->tee_mutex);
+
+		if (pxp->dev_link) {
+			device_link_del(pxp->dev_link);
+			pxp->dev_link = NULL;
+		}
+		return ret;
+	}
+
 	/* if we are suspended, the HW will be re-initialized on resume */
 	wakeref = intel_runtime_pm_get_if_in_use(&i915->runtime_pm);
 	if (!wakeref)
-- 
2.34.1

