Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70F9443E38;
	Tue, 15 Sep 2026 07:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789456004; cv=none; b=FtjjJPH5ebRE011fadTy1NLH5eT5U0cE36OgyxjVp8Pj+A3VLNuJZf2n++T4XuNYWuv8+mDnUM3+rD5euAIN8/fgfXbOEPwE2MBjCeoqozeZ7x3nIY9S38KGzpLNE7BfVMs1rQlRHsU9sWzU6GsesTiXo5qpkbALfRtejroJlHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789456004; c=relaxed/simple;
	bh=tibmV02uBmiJaqgHnPDf2fQUr4pDdn7jYtOSHPQtWPs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FUBJ7XvBgDdakwmbWvIBf637jS2KbPgdQZrt/jmPHJhded+8wqvsx7cQVT8PMnMLqNogVXu76Cb4NKfD8UPxeAnheyqjRemuEaSrxFHU0USHxlbKf9YDKkxzmhktPFUFGE5BdK74LwXCv0cbq1h66EhQOALEN4GHuLU/cK0cmt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAD3+Tfx7Khqrp7IBw--.45169S2;
	Tue, 15 Sep 2026 15:00:01 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: cassel@kernel.org
Cc: dlemoal@kernel.org,
	gregory.clement@bootlin.com,
	hansg@kernel.org,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tj@kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] ata: libahci_platform: Fix device reference leak in ahci_platform_get_resources()
Date: Tue, 15 Sep 2026 06:59:33 +0000
Message-Id: <20260915065933.1733061-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAD3+Tfx7Khqrp7IBw--.45169S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Gw45JFWUAr4DuryxAFyUAwb_yoWDZFc_C3
	W09ayUXw4rCF4qyw18tFnxuFWSkr9Igr97Xr4UKF9ag3y5Xry5uasxZrnxGa1UXa10v3s8
	Z3ZrGw43Cw1SgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	tVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUwFApDU
	UUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwILA2qowpCgFQAAso

of_find_device_by_node() takes a reference on the port platform device,
which is only used to look up its port regulator and is never released,
neither on success nor on the error paths. Drop the reference with
put_device() once the regulator has been obtained, which covers both the
success and error paths.

Fixes: c7d7ddee7e24 ("ata: libahci: Allow using multiple regulators")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/ata/libahci_platform.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index 6e072d681341..14a47e0bddd4 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -624,6 +624,7 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
 			if (port_dev) {
 				rc = ahci_platform_get_regulator(hpriv, port,
 								&port_dev->dev);
+				put_device(&port_dev->dev);
 				if (rc == -EPROBE_DEFER)
 					goto err_out;
 			}
-- 
2.34.1

