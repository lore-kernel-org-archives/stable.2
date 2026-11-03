Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793688953;
	b=0X/54oJJndit/YpkYu2MCgt0C3GAFCWEOCndmCcheBJE4cdXCHtpIeg9HWoxg0BQRglP
	 EtLVBOnAH6pjbkgAEA7xIpZrQ8q4pUC/OcMlU/ELuKwUDvjL+G9I62PjBqgXlg6CRgNw4
	 h7Cka76FhJOrroz5K2ZYaJG8d7vRaV4Yt+u1WSRkdmrQuuOVSo61Dg3G7tBy6ryeZpeJw
	 IBfeVUy9xTJDwrQsbU27z/BFLiF3sbMyku32utiTxah0O2MOp81sio8yEwSRhGs0AzlXr
	 PBaDve6OMNtgP/OVRNpFG0qmG8m2QYl43aXUUcbdCsIbGSQdi2E+ZuR5xrb8wbEELUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793688953;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=oikgS2B6IGDcMc5ZobuaBxV9WkOq5/iIVZdtdr/KAqU=;
	b=IRDvZ2s4klBCsmqrXAZRZXeraUdpymA+EIJXM/7zJBoFqOZ9yjCiLeGNj8DmqpH/g32E
	 Hl90QSKvYCfIvnBlZpF9zJPUkH96JzFSMjpgRUrc6bgt91pvNYiFguOg/rgW0vhUS1JsS
	 8kStFwW2a+ouTmQO0XB7kihXU1HTFdRdJlaDp5N3STnnYoB99ZGR+8htKg0YqIWRZSupv
	 6i+c4R5oqWSyaQqiPi4vryiiHjWSmeGEmOmoLw13DL3kBx/nEaO62SdfW1UDnruqfM+rH
	 +8dYbbL8p8uLgljd70/CXRD77QA+X1iqGegFqVXVWWZbN3PMqtU/7dBn/204+oeFszA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CB9606A324;
	Tue,  3 Nov 2026 06:55:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37CB9606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowADH0JFxhelqyZE5AA--.4106S2;
	Tue, 03 Nov 2026 14:55:45 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: jani.nikula@linux.intel.com,
	joonas.lahtinen@linux.intel.com,
	rodrigo.vivi@intel.com
Cc: tursulin@ursulin.net,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/i915/selftests: Put GuC test contexts on early failures
Date: Tue,  3 Nov 2026 06:55:54 +0000
Message-Id: <20261103065554.1073445-1-vulab@iscas.ac.cn>
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
X-CM-TRANSID:rQCowADH0JFxhelqyZE5AA--.4106S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KF4fKF1rZFy8WF13XFyUAwb_yoW8uF45pa
	93Xa4YkFy5AF42q3W7Aa40qFy3K3W0vayxuw1kJw1kKw1UZasYqrySvayUJ34DCFZ7Wr1a
	yF9Igry7WFy2yFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j
	6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUog
	AwDUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgcAA2rpWmWOeAABsJ

intel_hang_guc() creates an intel_context before changing the heartbeat
interval and initializing the spinner. If either operation fails, it
jumps to err without dropping that context. intel_guc_fast_request()
also skips the context put when spinner initialization fails.

Release the context on these failure paths. The existing put after
igt_spinner_create_request() handles the later paths.

Fixes: 69142c0a5f9a ("drm/i915/guc: Add selftest for a hung GuC")
Fixes: 706785c19fe9 ("drm/i915/guc: Add a selftest for FAST_REQUEST errors")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/i915/gt/uc/selftest_guc.c           | 1 +
 drivers/gpu/drm/i915/gt/uc/selftest_guc_hangcheck.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/i915/gt/uc/selftest_guc.c b/drivers/gpu/drm/i915/gt/uc/selftest_guc.c
index 63a75272924f..8ee4ccdb80cf 100644
--- a/drivers/gpu/drm/i915/gt/uc/selftest_guc.c
+++ b/drivers/gpu/drm/i915/gt/uc/selftest_guc.c
@@ -333,6 +333,7 @@ static int intel_guc_fast_request(void *arg)
 	ret = igt_spinner_init(&spin, engine->gt);
 	if (ret) {
 		gt_err(gt, "Failed to create spinner: %pe\n", ERR_PTR(ret));
+		intel_context_put(ce);
 		goto err_pm;
 	}
 	spinning = true;
diff --git a/drivers/gpu/drm/i915/gt/uc/selftest_guc_hangcheck.c b/drivers/gpu/drm/i915/gt/uc/selftest_guc_hangcheck.c
index 83801c992488..a7c48941ead7 100644
--- a/drivers/gpu/drm/i915/gt/uc/selftest_guc_hangcheck.c
+++ b/drivers/gpu/drm/i915/gt/uc/selftest_guc_hangcheck.c
@@ -65,12 +65,14 @@ static int intel_hang_guc(void *arg)
 	ret = intel_engine_set_heartbeat(engine, BEAT_INTERVAL);
 	if (ret) {
 		gt_err(gt, "Failed to boost heartbeat interval: %pe\n", ERR_PTR(ret));
+		intel_context_put(ce);
 		goto err;
 	}
 
 	ret = igt_spinner_init(&spin, engine->gt);
 	if (ret) {
 		gt_err(gt, "Failed to create spinner: %pe\n", ERR_PTR(ret));
+		intel_context_put(ce);
 		goto err;
 	}
 
-- 
2.34.1

