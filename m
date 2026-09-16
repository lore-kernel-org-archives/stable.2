Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE19B3CF96B;
	Wed, 16 Sep 2026 18:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789582856; cv=none; b=Vh7DKdkXL7cSsYHJfMX3Mt3u3XCG6YcSVWkuRJJubZ0CA4arkMPHX27YvsRP7xhmH+5PO6porEpaPa222phbrfvkjkb1ceJdJzyO/RGUCdvpA98Xhysy3OTrvSFJK0LGuvuXOlKysRUTz1lAyYO3lUxyZXUxDWWfK/075sNM6gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789582856; c=relaxed/simple;
	bh=15zt54fKG+OAyTrpnKcFIDGMMsOxF2x8qHLvuPfaJZc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Qwo/2PGA9lafQs+uVIaa4ohuUV8EP9jJbVc/YgFAg0E8K+EBRC/un/HVVOUHjcjmEkgVJhBe+Qp7KGvrkz93gYFfyi+vSd9xY/3qTWR/JxTE1s5h1KcbFoje12LQExOx02tPLOPntb+4jgqIdWw/fexZEbHTCqg/3AtN68gzf7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowABXh0Ho3apqBWVvCA--.24210S2;
	Thu, 17 Sep 2026 02:20:24 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: airlied@gmail.com
Cc: alain.volmat@foss.st.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	rgallaispou@gmail.com,
	simona@ffwll.ch,
	tzimmermann@suse.de,
	vincent.abriou@st.com,
	vladimir_zapolskiy@mentor.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/sti: Fix ddc_adapt reference leak in sti_hdmi_probe()
Date: Wed, 16 Sep 2026 18:19:56 +0000
Message-Id: <20260916181956.2091393-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABXh0Ho3apqBWVvCA--.24210S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZF1xZF48XF1kWF47XrW5Wrg_yoWkArb_C3
	40grn3WFsrCw4Dtr12yr4Yyas2kFW5uFWxuFs7tFy3JrW5Jry3X34qyFyDCr47Z3WUK3WD
	tw4Igry5Zr13WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb-xFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F
	4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7Cj
	xVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JF
	I_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG
	6r1j6r1xMIIF0xvEx4A2jsIE14v26F4j6r4UJwCI42IY6I8E87Iv6xkF7I0E14v26F4UJV
	W0obIYCTnIWIevJa73UjIFyTuYvjfUw5l8UUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRIMA2qqozWA8QAAsz

When component_add() fails, sti_hdmi_probe() returns the error without
going through the release_adapter label, leaking the reference to the
DDC i2c adapter that only sti_hdmi_remove() would otherwise drop.
Route the failure through the label instead.

Fixes: 4d5821a71ce9 ("drm/sti: hdmi use of_get_i2c_adapter_by_node interface")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/sti/sti_hdmi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_hdmi.c
index f8222e60b1e0..ed5646545f84 100644
--- a/drivers/gpu/drm/sti/sti_hdmi.c
+++ b/drivers/gpu/drm/sti/sti_hdmi.c
@@ -1460,7 +1460,11 @@ static int sti_hdmi_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, hdmi);
 
 	drm_bridge_add(&hdmi->bridge);
-	return component_add(&pdev->dev, &sti_hdmi_ops);
+	ret = component_add(&pdev->dev, &sti_hdmi_ops);
+	if (ret)
+		goto release_adapter;
+
+	return 0;
 
  release_adapter:
 	i2c_put_adapter(hdmi->ddc_adapt);
-- 
2.34.1

