Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBE64D7D49;
	Wed, 16 Sep 2026 17:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789580416; cv=none; b=FYANaIXLsP7feND7OnLai+RmeOpOUx45FBA1GS4fsnBtAyvYo0S3UHc1YcoglbusZlxj3SWzli/a/cdhyvExzMpnrPqLDJ1M1gEHdrA2wg3cb8UHpkRmyQf5122QAW4qxr+QJQLp78REwvwSGbgivAjkWdvWAlIgX6b3ZUnPYHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789580416; c=relaxed/simple;
	bh=6zDj+nDDyjh9YHrZ2JfzB1aq5DX481zW0e2Sp2qyLH8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pd4c8QXvRucFwsP+ZTvKB6K193WP1ltll+JietKm8uaw1IoqOZwnBlqxHKtnuQX0Cfdy523rqEEQ+7m8Ecic/0odhRyGmGCtxlr+H/HNHwM+WyawrVEx34P48s5P9EWNZ8F+aEEpzbUOIG2uER/6U47Tb60g+G2rQAiEQDDyHYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowADH+EJs1Kpq68ZuCA--.23334S2;
	Thu, 17 Sep 2026 01:39:56 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: airlied@gmail.com
Cc: anitha.chrisanthus@intel.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	sam@ravnborg.org,
	simona@ffwll.ch,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/kmb: Fix dsi_pdev reference leak in kmb_probe()
Date: Wed, 16 Sep 2026 17:39:29 +0000
Message-Id: <20260916173929.2088602-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADH+EJs1Kpq68ZuCA--.23334S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CF4rAr47tw48trW7WF45ZFb_yoW8XFWfpr
	ZrJFyFvryqkr4xtrW7A3W5Za43Aa17Ka4fuF4kZ3s8WwsYqrW5tas3ZwnrA348AFWkWF4f
	trZrJF1xur4UZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxV
	WxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
	Yx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7
	v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS
	14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
	6F4j6r4UJwCI42IY6I8E87Iv6xkF7I0E14v26F4UJVW0obIYCTnIWIevJa73UjIFyTuYvj
	fUruWLUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwAMA2qqpVhnYQABsy

The reference taken by of_find_device_by_node() is dropped on none of
kmb_probe()'s error paths: the -EPROBE_DEFER retry, the DSI host bridge
init failure, the drm device allocation failure and the later cleanup
labels. Drop the reference on each of them.

Fixes: 7f7b96a8a0a1 ("drm/kmb: Add support for KeemBay Display")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/kmb/kmb_drv.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/kmb/kmb_drv.c b/drivers/gpu/drm/kmb/kmb_drv.c
index 7c2eb1152fc2..65df630bf888 100644
--- a/drivers/gpu/drm/kmb/kmb_drv.c
+++ b/drivers/gpu/drm/kmb/kmb_drv.c
@@ -518,17 +518,21 @@ static int kmb_probe(struct platform_device *pdev)
 	ret = kmb_dsi_host_bridge_init(get_device(&dsi_pdev->dev));
 
 	if (ret == -EPROBE_DEFER) {
+		put_device(&dsi_pdev->dev);
 		return -EPROBE_DEFER;
 	} else if (ret) {
 		DRM_ERROR("probe failed to initialize DSI host bridge\n");
+		put_device(&dsi_pdev->dev);
 		return ret;
 	}
 
 	/* Create DRM device */
 	kmb = devm_drm_dev_alloc(dev, &kmb_driver,
 				 struct kmb_drm_private, drm);
-	if (IS_ERR(kmb))
+	if (IS_ERR(kmb)) {
+		put_device(&dsi_pdev->dev);
 		return PTR_ERR(kmb);
+	}
 
 	dev_set_drvdata(dev, &kmb->drm);
 
@@ -577,6 +581,7 @@ static int kmb_probe(struct platform_device *pdev)
  err_free1:
 	dev_set_drvdata(dev, NULL);
 	kmb_dsi_host_unregister(kmb->kmb_dsi);
+	put_device(&dsi_pdev->dev);
 
 	return ret;
 }
-- 
2.34.1

