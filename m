Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903563806D0;
	Thu, 25 Jun 2026 09:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782380196; cv=none; b=lMwKL0O14bjSo7AAs9ClKIkoNKcZ1wY5DE1TiQlK9azhhAFIdkWLC36phQUMwiADrvpXLZHy4ByKnjDf7ojoyZl+Vkn11vgvZtWULIOBPei/sf+dYxgMpKthmtt0BXWxNa5so0D2zBl5Zy2Y7xxJbs1hppuX6UBdtcsx+uHBRBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782380196; c=relaxed/simple;
	bh=r75Y193apzjEpbDsuC3Hz8LTWSRwFRebQwv5lOBl9Mo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dke99j9vakxv2Eo7ADKhlVeS7WpfWmnSpwdlQ5zLpfv37yVwTV9MwIWWr9u4egLmOKDSKzTePl2bN4pD9gq2k7/3YaPtHh5iaVFEgoVAQUhwjgLiApSuvdrrzFaiYEex/DJsEwsJAAmgmoc6QXuIJlzAuot2CBvY+lzjX5fwxQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-03 (Coremail) with SMTP id rQCowACXjbSY9jxqRVDNFQ--.7735S2;
	Thu, 25 Jun 2026 17:36:26 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: axboe@kernel.dk
Cc: kees@kernel.org,
	objecting@objecting.org,
	vulab@iscas.ac.cn,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] block/partitions/of: Fix of_node reference leak in of_partition()
Date: Thu, 25 Jun 2026 17:36:22 +0800
Message-Id: <20260625093622.48308-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowACXjbSY9jxqRVDNFQ--.7735S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uw13Jr48ur4DXF43KF45Wrg_yoW8CFykpr
	sxK3yYyrWUGr1fC348XF1xuw4Ygan7JrWDtr17t34Syr1DXwsrtFWj93yjvws0qFZ5G3y7
	Za4jgFykX3W7Z37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUBVbkUUU
	UU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAUJA2o83vNmrwAAsx

of_partition() calls of_node_get(ddev->of_node) at entry to take a
reference on the device node, but only releases it on the validation
error path. On three other exit paths the reference is leaked:

  - When the device node is not compatible with "fixed-partitions",
    the function returns 0 without calling of_node_put().
  - On normal success (return 1), partitions_np is never released.
  - When the partition slot limit is reached in the second child
    loop (break followed by return 1), partitions_np is also leaked.

Fix by splitting the NULL check from the compatible check so that
of_node_put() can be called before the early return on incompatibility,
and add of_node_put(partitions_np) before the final return 1 to cover
both the normal and the break paths.

The NULL case is safe because of_node_get(NULL) is a no-op.

Cc: stable@vger.kernel.org
Fixes: 2e3a191e89f9 ("block: add support for partition table defined in OF")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 block/partitions/of.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/block/partitions/of.c b/block/partitions/of.c
index c22b60661098..afaaae5e72a1 100644
--- a/block/partitions/of.c
+++ b/block/partitions/of.c
@@ -73,9 +73,12 @@ int of_partition(struct parsed_partitions *state)
 
 	struct device_node *partitions_np = of_node_get(ddev->of_node);
 
-	if (!partitions_np ||
-	    !of_device_is_compatible(partitions_np, "fixed-partitions"))
+	if (!partitions_np)
 		return 0;
+	if (!of_device_is_compatible(partitions_np, "fixed-partitions")) {
+		of_node_put(partitions_np);
+		return 0;
+	}
 
 	slot = 1;
 	/* Validate parition offset and size */
@@ -104,5 +107,7 @@ int of_partition(struct parsed_partitions *state)
 
 	seq_buf_puts(&state->pp_buf, "\n");
 
+	of_node_put(partitions_np);
+
 	return 1;
 }
-- 
2.39.5 (Apple Git-154)

