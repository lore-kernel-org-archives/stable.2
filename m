Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F914EFFA1;
	Thu, 17 Sep 2026 15:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789660124; cv=none; b=XTx91IcNFgDnZi5CA26TNyYN2+3HadwV4qzto/LKudgLCexj9o5IQppekOCqlkcvCzLbUKeNZ20dQ9wIg+GpcP9eR1dC4Qz01a2zlLf0HMDNsfSazSOXi+LikkaORjqVWd88fDmG5BcPDQ0FFuTl7BRIFguzKzp/3wyA/EIcX+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789660124; c=relaxed/simple;
	bh=juEdvFFejEpjtb9f+mNgNWOTen1oLaNthwpOc6c6CgQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JceXS3WsYkkLT/BYYJZDx5qqLfYBweCn1ujZ+a3OZNFY2JC3aNTb34Ai0uCvZSostgODX7x6+jkT4YilMlHSAB3NqTmAVanIRwWrJ1wMt4gE82QPoVjc+/wZ5SdnA/dYkpyQC4TkFMBErpzTtjkT6OaErXudMhP+ue5LuuXRiTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowACXATzKC6xqaNeDCA--.46541S2;
	Thu, 17 Sep 2026 23:48:26 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: broonie@kernel.org
Cc: hansg@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org,
	sbinding@opensource.cirrus.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] spi: fix controller reference leak in acpi_spi_device_alloc()
Date: Thu, 17 Sep 2026 15:48:26 +0000
Message-Id: <20260917154826.2160933-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACXATzKC6xqaNeDCA--.46541S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFWfCF1ruryUuF48Wr43Awb_yoW8KryxpF
	W7JFW3tF95JF45Ka1rtw4UCF13Wa1Ivw45G39rJr1fuw4S934rGFy7Gr1Fqry5AFZ7tF42
	vFW2qF18CF1UZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB0b7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6r4j6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWxJr0_GcWlOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq62Iq12xI8VA0II8E6IAqYI8I648v4I1lc7Cj
	xVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8GFyrJr
	1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4UJVWxJr1lIxAIcVC2z280aVCY1x
	0267AKxVW0oVCq3bIYCTnIWIevJa73UjIFyTuYvjxUDZ2-DUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwgNA2qr9tgxOwAAsk

acpi_spi_add_resource() stores the controller returned by
acpi_spi_find_controller_by_adev() in lookup->ctlr. That lookup takes a
reference via class_find_device(), which acpi_spi_device_alloc() never
releases, leaking it on the error paths and on the success path too,
where spi_alloc_device() takes its own reference. Drop the lookup
reference when the caller did not pass a controller.

Fixes: 87e59b36e5e2 ("spi: Support selection of the index of the ACPI Spi Resource before alloc")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/spi/spi.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 104279858f56..fb5e17d55801 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2979,9 +2979,12 @@ struct spi_device *acpi_spi_device_alloc(struct spi_controller *ctlr,
 				     acpi_spi_add_resource, &lookup);
 	acpi_dev_free_resource_list(&resource_list);
 
-	if (ret < 0)
+	if (ret < 0) {
 		/* Found SPI in _CRS but it points to another controller */
+		if (!ctlr)
+			spi_controller_put(lookup.ctlr);
 		return ERR_PTR(ret);
+	}
 
 	if (!lookup.max_speed_hz &&
 	    ACPI_SUCCESS(acpi_get_parent(adev->handle, &parent_handle)) &&
@@ -2990,13 +2993,18 @@ struct spi_device *acpi_spi_device_alloc(struct spi_controller *ctlr,
 		acpi_spi_parse_apple_properties(adev, &lookup);
 	}
 
-	if (!lookup.max_speed_hz)
+	if (!lookup.max_speed_hz) {
+		if (!ctlr)
+			spi_controller_put(lookup.ctlr);
 		return ERR_PTR(-ENODEV);
+	}
 
 	spi = spi_alloc_device(lookup.ctlr);
 	if (!spi) {
 		dev_err(&lookup.ctlr->dev, "failed to allocate SPI device for %s\n",
 			dev_name(&adev->dev));
+		if (!ctlr)
+			spi_controller_put(lookup.ctlr);
 		return ERR_PTR(-ENOMEM);
 	}
 
@@ -3013,6 +3021,14 @@ struct spi_device *acpi_spi_device_alloc(struct spi_controller *ctlr,
 	 */
 	spi->cs_index_mask	= BIT(0);
 
+	/*
+	 * If the controller was looked up from the ACPI resource, release the
+	 * reference taken by acpi_spi_find_controller_by_adev(). The new SPI
+	 * device holds the reference taken by spi_alloc_device() instead.
+	 */
+	if (!ctlr)
+		spi_controller_put(lookup.ctlr);
+
 	return spi;
 }
 EXPORT_SYMBOL_GPL(acpi_spi_device_alloc);
-- 
2.34.1

