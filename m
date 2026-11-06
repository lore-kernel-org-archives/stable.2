Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793956818;
	b=P4yI5r3O+NVjyfd8Ky0aDJekNjD1k+siHgRh4mdqdITFuyZM4UFrQppembLSwiVkjFpf
	 5fHyfcmZcqPRX6mYY9/Q49F9FO1NpIMHKUXMG9duVd5C9oKaQQMSsW8Q+JlHKQ6PW7ACs
	 fhUjGJdUSCnhCNuRSJ7AOUjtAqpO8i1STn64LmNh75yBKD2TyGdWSrQVilceXY/BjL9kN
	 splJRrEJqTTGjZXUgjSpxhK/wcZvmrE0UVU/GYQAUzzEO0VeK4owglkIUL8XkscHBj534
	 3uA4/cTlMSi4vXVNtJJUwNcqnOF1hW6IbGqeLHPGrYa13phxMgrxT5k2FdVq3bApB6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793956818;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-Originating-IP:X-CM-SenderInfo;
	bh=F/tOfpxYZmCQGHqlxGX/lo3Gghl5kOhbvjqdN5993ZU=;
	b=DMZ49EV+al92zsYa+wTtNWfjg2uFelY7wwnJdyEXhjhI0QD/wPRzwxX8nByaG3BxaW61
	 QRDAhS3YOcT6WyYeqcEKKheSH9Eqt8mgaQf+E8lAXwHIFszmkBsXMJG2AmdBWVjK/HBm8
	 2gIkJF8KLbl09FNHqrd3xDX670CYbO81XaNt9sfMpSQ+NbcHhZbo4NK3nk32roMIr6LYv
	 XHzazKN7szY9gO+V7zsAKjTqf4sPR8FpQ9AR0y87rGQ6C3wHSTVLMko4VglMqQmGGOOf/
	 F/9YceouVf1WhGszE2Y48Jxj2f7pnwkbaoCOrNPHHa/023DWgXEqTKsGzSLRo6MDK0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDC7606EEB2;
	Fri,  6 Nov 2026 09:20:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FDC7606EEB2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAAXJpfGm+1qoTlrAA--.5294S2;
	Fri, 06 Nov 2026 17:20:06 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: mcanal@igalia.com,
	airlied@gmail.com
Cc: dave.stevenson@raspberrypi.com,
	dri-devel@lists.freedesktop.org,
	kernel-list@raspberrypi.com,
	linux-kernel@vger.kernel.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	simona@ffwll.ch,
	tzimmermann@suse.de,
	stable@vger.kernel.org
Subject: [PATCH] drm/vc4: Fix firmware reference leak in vc4_hvs_bind()
Date: Fri,  6 Nov 2026 09:20:16 +0000
Message-Id: <20261106092016.2282805-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <5f80ac77-c1f4-42cc-bdcd-e4222f72d853@igalia.com>
References: <5f80ac77-c1f4-42cc-bdcd-e4222f72d853@igalia.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAAXJpfGm+1qoTlrAA--.5294S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr1kGFWkZry3WrW8Ww4kZwb_yoW5JryUpF
	43GFWYyrWDGrWfK3y0yr4kZFySyan3JrWfCry8u3Z5Cr1rArykJry0y39YgryUAFW8J3W3
	GFnxtr1xJF1DArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9mb7Iv0xC_KF4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxV
	W0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr1j6rxdMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AK
	xVWUtVW8ZwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r48ZrWUJr1UMxC20s
	026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
	JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
	v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr
	0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZSdgUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAADA2rtlCIdSAAAso

The firmware reference taken via rpi_firmware_get() is leaked when
either of the devm_clk_get() calls for the core or display clocks
fails, as both error paths return without releasing it.

Fix it by moving the firmware lookup below the clock lookups, so that
the reference is taken right before the firmware property is read and
released immediately afterwards.  The rpi_firmware_find_node() call
moves with it: the device node reference it returns would otherwise be
leaked by those same error paths.

The candidate was found by our static analysis tooling, and this change
was prepared with assistance from DeepSeek-V4.1-Flash and GPT-6.1-Sol.

Fixes: 2a001ca00ad5 ("drm/vc4: hdmi: Rework hdmi_enable_4kp60 detection code")
Cc: stable@vger.kernel.org
Suggested-by: Maíra Canal <mcanal@igalia.com>
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
Changes in v2:
- Sorry for the very late reply, and thanks for the review.
- Move the firmware and device node lookups below the clock lookups
  instead of adding rpi_firmware_put() to the two error paths, as
  suggested by Maíra.
- Link to v1: https://lore.kernel.org/all/20260916154137.2058618-1-vulab@iscas.ac.cn/
---
 drivers/gpu/drm/vc4/vc4_hvs.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
index b1fb096858cc..537aaa992129 100644
--- a/drivers/gpu/drm/vc4/vc4_hvs.c
+++ b/drivers/gpu/drm/vc4/vc4_hvs.c
@@ -1677,15 +1677,6 @@ static int vc4_hvs_bind(struct device *dev, struct device *master, void *data)
 		struct device_node *node;
 		unsigned int max_rate;
 
-		node = rpi_firmware_find_node();
-		if (!node)
-			return -EINVAL;
-
-		firmware = rpi_firmware_get(node);
-		of_node_put(node);
-		if (!firmware)
-			return -EPROBE_DEFER;
-
 		hvs->core_clk = devm_clk_get(&pdev->dev,
 					     (vc4->gen >= VC4_GEN_6_C) ? "core" : NULL);
 		if (IS_ERR(hvs->core_clk)) {
@@ -1700,6 +1691,15 @@ static int vc4_hvs_bind(struct device *dev, struct device *master, void *data)
 			return PTR_ERR(hvs->disp_clk);
 		}
 
+		node = rpi_firmware_find_node();
+		if (!node)
+			return -EINVAL;
+
+		firmware = rpi_firmware_get(node);
+		of_node_put(node);
+		if (!firmware)
+			return -EPROBE_DEFER;
+
 		max_rate = rpi_firmware_clk_get_max_rate(firmware,
 							 RPI_FIRMWARE_CORE_CLK_ID);
 		rpi_firmware_put(firmware);
-- 
2.34.1

