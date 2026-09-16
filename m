Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8644389E1A;
	Wed, 16 Sep 2026 17:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789580969; cv=none; b=FZX7ybc6WLIv+bDmmGYH9b6mBA19jILA9rBX6iLXWuGN4mVV3d8zFXUpZ3yQhwRKzfdvhOhHmuxwFMUtHsCO9dF/EXnA/U3f3U4LW8GcQoIxC20RbPoqN2P7/U6iOO3o30Cv1f0pkFecmsQtsQOBB2dx9PZtoU/8n9AbKk9tsHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789580969; c=relaxed/simple;
	bh=fuD3CdZr8I5VHiDP5SDUDPglDILp1CKYBcDBteOxMyk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cyBq/AT7ft2CrNd896EhP2rKSK+ewbk2g27jA28Ez2PSKOoAQpeqE+WN9NERWTc8+i4hLflIJj3iw4uMzvYp+9SaEmHB60s093umTn5TM07sv5CG+gByb9aATmJcJvYWU1+LyLhIykmrK2HxIjlai0axcXmq2pGFyI+YNbQZ9bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowABn0TuT1qpqQOZuCA--.23890S2;
	Thu, 17 Sep 2026 01:49:07 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org,
	jbrunet@baylibre.com,
	khilman@baylibre.com,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	maarten.lankhorst@linux.intel.com,
	martin.blumenstingl@googlemail.com,
	mripard@kernel.org,
	neil.armstrong@linaro.org,
	sam@ravnborg.org,
	simona@ffwll.ch,
	tzimmermann@suse.de,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/meson: Fix platform device reference leak in meson_encoder_hdmi_probe()
Date: Wed, 16 Sep 2026 17:48:39 +0000
Message-Id: <20260916174839.2089240-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABn0TuT1qpqQOZuCA--.23890S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZryDCFWrGr4UZF1rWw18uFg_yoWktrXEgw
	10kas7ur1xKFs7Kw17ArW3uFs2yFnxuay09rsFqFWfta4rZr9rXFW7CrykXr4ava4fCayD
	J340gF1FgFn7KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb-xFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F
	4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7Cj
	xVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JF
	I_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG
	6r1j6r1xMIIF0xvEx4A2jsIE14v26F4j6r4UJwCI42IY6I8E87Iv6xkF7I0E14v26F4UJV
	W0obIYCTnIWIevJa73UjIFyTuYvjfUw5l8UUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAIMA2qqpO9tdQAAsS

of_find_device_by_node() takes a reference on the HDMI transceiver
device, but the successful probe path never releases it; the reference
is only dropped when cec_notifier_conn_register() fails. The CEC
notifier keeps the device as a lookup key without taking a reference of
its own, so put the device right after the registration.

Fixes: 0af5e0b41110 ("drm/meson: encoder_hdmi: switch to bridge DRM_BRIDGE_ATTACH_NO_CONNECTOR")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/meson/meson_encoder_hdmi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/meson/meson_encoder_hdmi.c b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
index 1abb0572bb5f..8e727f0a7a8c 100644
--- a/drivers/gpu/drm/meson/meson_encoder_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
@@ -472,6 +472,9 @@ int meson_encoder_hdmi_probe(struct meson_drm *priv)
 		}
 
 		meson_encoder_hdmi->cec_notifier = notifier;
+
+		/* The notifier keeps the device only as a lookup key */
+		put_device(&pdev->dev);
 	}
 
 	priv->encoders[MESON_ENC_HDMI] = meson_encoder_hdmi;
-- 
2.34.1

