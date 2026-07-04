Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.229.168.213])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FC3330B09;
	Sat,  4 Jul 2026 08:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.229.168.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783154886; cv=none; b=MRzM9cyGUtgfmxXHo6NTcVKOats4jdH676JMrZkzqjLtXrr5QXYAPiIfRRgqGHS1hs1dnuVzfZceCCA0VmxuG+rUqbxpdP7FZ0YZBahIloNimdvXYg8MkQX/JQgu9o0FhhdlGfmmGvfJVNPBWHKlsTmttNQ906WcJZ8dHyZ3a4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783154886; c=relaxed/simple;
	bh=cKsqK66zOTaldupZ8S9p2xyBxnKruwoLuBKeXk09s2U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Dt0Rh9cS2r6/SgmpBC81xrK7X7MQd1LqKLCGg1oHnWTAUlXs23dzVxlIqDs9p+MmofacO6mGpUnETOdrJf02H5nrL/dw/8y/PT6iV8B87nWMkqfIOydObPq8tPPjBsKbKdJjCerE0G6WyLKz41EUbEUj4y6ACiIlWl0eAfdK9+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=52.229.168.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wBHTqq8yEhqFcUCAA--.3496S3;
	Sat, 04 Jul 2026 16:47:57 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app4 (Coremail) with SMTP id zi_KCgBXijG7yEhqPrkOAg--.40538S2;
	Sat, 04 Jul 2026 16:47:55 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: jacob-chen@iotwrt.com,
	ezequiel@vanguardiasur.com.ar
Cc: mchehab@kernel.org,
	heiko@sntech.de,
	linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>
Subject: [PATCH v2] media: rockchip: rga: quiesce IRQ before releasing m2m state
Date: Sat,  4 Jul 2026 08:46:59 +0000
Message-Id: <20260704084659.612221-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zi_KCgBXijG7yEhqPrkOAg--.40538S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?8dIS9gXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnXz+g1OQfMo27QHy5TwQyZxxR4dyJfMjBhJmuoB4BKvyivvXPfSYT6ewmdew0trf8DzY
	2h2Jw6RmlZgyqzWx+cGp9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoW7AFW3CFWrXF17ur48WF4DAwc_yoW8KFW5pa
	1DAFyIkFW8GrWqgw4DJw47uFZ5t3ZayayUGF43Ww17CF9xKFyqqw1UZF9Yvr9xJFyxAay2
	yw4Ut343AF4jvFcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Gb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
	JrUvcSsGvfC2KfnxnUUI43ZEXa7IU85l1PUUUUU==

rga_remove() releases the m2m state before the IRQ is freed. The IRQ is
devm-managed and is only released once rga_remove() returns, so rga_isr()
can still run while the m2m device state is being torn down.

Store the IRQ number in struct rockchip_rga, unregister the video device
first, and free the IRQ before releasing the m2m state so the handler
cannot run against the freed state.

Fixes: f7e7b48e6d79 ("[media] rockchip/rga: v4l2 m2m support")
Cc: stable@vger.kernel.org
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>

---
Changes in v2:
- Rebased onto media-committers/fixes (Linux 7.2-rc1) so the Media CI
  valid-ancestor check passes. The rga driver was rewritten upstream
  (rga3 support, external IOMMU, clk_bulk, cmdbuf moved to rga_ctx), so
  this is a re-port rather than a pure rebase: the resource freed during
  removal is now rga->m2m_dev.
---
 drivers/media/platform/rockchip/rga/rga.c | 4 +++-
 drivers/media/platform/rockchip/rga/rga.h | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/rockchip/rga/rga.c b/drivers/media/platform/rockchip/rga/rga.c
index b3cb6bf8eb86..fbc99462dce2 100644
--- a/drivers/media/platform/rockchip/rga/rga.c
+++ b/drivers/media/platform/rockchip/rga/rga.c
@@ -797,6 +797,7 @@ static int rga_probe(struct platform_device *pdev)
 		ret = irq;
 		goto err_put_clk;
 	}
+	rga->irq = irq;
 
 	ret = devm_request_irq(rga->dev, irq, rga_isr,
 			       rga_has_internal_iommu(rga) ? 0 : IRQF_SHARED,
@@ -876,8 +877,9 @@ static void rga_remove(struct platform_device *pdev)
 
 	v4l2_info(&rga->v4l2_dev, "Removing\n");
 
-	v4l2_m2m_release(rga->m2m_dev);
 	video_unregister_device(rga->vfd);
+	devm_free_irq(rga->dev, rga->irq, rga);
+	v4l2_m2m_release(rga->m2m_dev);
 	v4l2_device_unregister(&rga->v4l2_dev);
 
 	pm_runtime_disable(rga->dev);
diff --git a/drivers/media/platform/rockchip/rga/rga.h b/drivers/media/platform/rockchip/rga/rga.h
index bd431534d0d3..7bcdf36c11b4 100644
--- a/drivers/media/platform/rockchip/rga/rga.h
+++ b/drivers/media/platform/rockchip/rga/rga.h
@@ -73,6 +73,7 @@ struct rockchip_rga {
 	struct device *dev;
 	struct regmap *grf;
 	void __iomem *regs;
+	int irq;
 	struct clk_bulk_data *clks;
 	int num_clks;
 	struct rockchip_rga_version version;
-- 
2.34.1

