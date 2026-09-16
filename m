Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004DD4C9DE5;
	Wed, 16 Sep 2026 18:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789583101; cv=none; b=H11o13ymPDhOOiJ8i3+0XyCrLRnTxhgzs0d+wLprrUgCo3PD57N6X/xlh9+85NjOz0eaOARm30XOAwifNmcN2zwX4AeQUTvd35qHLYNb3yU/+S85ouXd3ufO/8culIQ4wq61nuzTZbwkFIzB/FON7NC+hfTZcUWKgFZTJr69G+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789583101; c=relaxed/simple;
	bh=plb//BthYcXLQATz/pBSy5f+m6949UjkGPuUQG86j1s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Mccj9AB6a4zaOLysRXF4apR+wroS94p/BiqAD5GpkzkcCBWiDhtRQCBZebNYgr59IQjHl2O5KR1R3iPcZkgAhB3PKqLQlx2PbPJwmPPTAD6imKCTCcdx+lXBlb36EsUL3EtmIHSjYVfc8hJieZ7l4vMuMtu0Z85a0rbghROZmCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowABn0Tvo3qpqV3ZvCA--.24596S2;
	Thu, 17 Sep 2026 02:24:40 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org,
	jernej.skrabec@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	samuel@sholland.org,
	simona@ffwll.ch,
	tzimmermann@suse.de,
	wens@kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/sun4i: Fix pdev reference leak in sun8i_r40_tcon_tv_set_mux()
Date: Wed, 16 Sep 2026 18:24:12 +0000
Message-Id: <20260916182412.2091681-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABn0Tvo3qpqV3ZvCA--.24596S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XF4rWr1UKF18ZrWxur1kAFb_yoW3urb_W3
	95urnxZr1kGr98AFy2vr1YvFyS9FnxWFW8Xw17tayrJ345ZrWIqr95twn5Xw4jqFyxWFn8
	twnrWa1qyw12gjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
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
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRMMA2qqozWCnQAAsc

of_find_device_by_node() takes a reference to the TCON TOP device
which the error paths release, but the success path returns without
doing so.  Drop the reference before returning success.

Fixes: 0305189afb32 ("drm/sun4i: tcon: Add support for R40 TCON")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 960e83c8291d..07350361fc4b 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -1444,6 +1444,8 @@ static int sun8i_r40_tcon_tv_set_mux(struct sun4i_tcon *tcon,
 		}
 	}
 
+	put_device(&pdev->dev);
+
 	return 0;
 }
 
-- 
2.34.1

