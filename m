Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD465360EC2;
	Thu, 25 Jun 2026 14:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782397134; cv=none; b=iiNoh5vtTf3kMHTWGaepRrHT9RP7fy/eIzc1SO00facfO8YLclOmYMtYB9XqL4xyG76tjN2qJqqQH3CmXxR3N1VPdgxjGd/N5AQoQV6apnNKnPTvGj5eQaFvaOMAEjv5AY3RrrgwYZNbrXxKEBmJ6UZTrgVFND1oqdXJbKQlmbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782397134; c=relaxed/simple;
	bh=cGNurHkTbMskyOvcC7f27Q5DSLBdcjIy9dmgq0HMWDE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dmSZCEIhRoWushaz/TvDNu+sBDY9C6qPgmIVuLACambHZLizpPBnkav1XPt3NBZ8OKl7RfcfJj9ZWQu1M8wZPeHtW5z/gl0RRwE6KXtXoa09A6h16H6uCSWcnGkOryaS3ZrtYYcFRD40CS4S4AWEQg0lu4/xl8nyCt8SMvjkksU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-01 (Coremail) with SMTP id qwCowABnB9DAOD1qQJo6Aw--.53034S2;
	Thu, 25 Jun 2026 22:18:42 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: dlemoal@kernel.org,
	cassel@kernel.org
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] ata: pata_pxa: Fix DMA channel leak on probe error
Date: Thu, 25 Jun 2026 22:18:37 +0800
Message-Id: <20260625141837.62362-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowABnB9DAOD1qQJo6Aw--.53034S2
X-Coremail-Antispam: 1UD129KBjvdXoWrurW8Jw48JFy5Zry8JFW3Awb_yoWDWrcEkF
	WjgFn3Wr1qkayDCw1xKF1fCF93Kas5WFnIg34DtFW3J3y7Xa17XryYqws5Xrs7Ww48KF9I
	y34DArW3Ar43WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbcAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
	ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_
	Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUehL0UUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgwJA2o9JdIzUQAAsC

When dmaengine_slave_config() fails, the DMA channel acquired by
dma_request_chan() is not released before returning the error,
leaking the channel reference.

Fix by adding dma_release_channel() in the error path.

The ata_host_activate() error path already correctly releases the
DMA channel.

Cc: stable@vger.kernel.org
Fixes: 88622d80af82 ("ata: pata_pxa: dmaengine conversion")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/ata/pata_pxa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/pata_pxa.c b/drivers/ata/pata_pxa.c
index 03dbaf4a13a7..9f63bdfb8576 100644
--- a/drivers/ata/pata_pxa.c
+++ b/drivers/ata/pata_pxa.c
@@ -286,6 +286,7 @@ static int pxa_ata_probe(struct platform_device *pdev)
 	ret = dmaengine_slave_config(data->dma_chan, &config);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "dma configuration failed: %d\n", ret);
+		dma_release_channel(data->dma_chan);
 		return ret;
 	}
 
-- 
2.39.5 (Apple Git-154)

