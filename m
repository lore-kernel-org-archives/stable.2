Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB463EB119;
	Fri, 26 Jun 2026 12:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782477477; cv=none; b=UIEUSS8DpEtLX5DDv8Gciiiiv237P/yg4X1pcfJfR6rs2r8Z0yTVXthRID/nc7fT0214zkldxWCNkNQYFq+ipI79iYcfmT1z4S3zJ0Jsy9OUpssTj5rtsxudCHJTp3AkSwwaOYBTuBkCD4YkNrFyGpFJ8hv7UxFPCQKilX81bh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782477477; c=relaxed/simple;
	bh=baDwnVCr1yiqYZEgtXNa9WdBdgvv8TM+A5NqRppfzYo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OFiVIXqQruTVfF9NAztgkhhqPC3TNAGBHoI3MyKrYeOIAP5CxA52OHn/sEno+NXn7Sd3VHtoGoQ/sPrHsgDBinDeZlXazW0FpjHGxn3yiy1Qy0n4q+qe9gxJ9vRHReB/4JC4LIT4i7CRQFRqS1XuHjieUucoiIxbbeQGIn32Ngk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-05 (Coremail) with SMTP id zQCowACX_uGZcj5quoJoFQ--.10920S2;
	Fri, 26 Jun 2026 20:37:46 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: o-takashi@sakamocchi.jp
Cc: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] fix: firewire: report_lost_node: unconditional fw_node_put after   conditional fw_node_event causes excess put
Date: Fri, 26 Jun 2026 20:37:43 +0800
Message-Id: <20260626123743.36388-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACX_uGZcj5quoJoFQ--.10920S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKr1xZr17KFWktFW8CF47CFg_yoWkCFc_KF
	4kZFZrWw1UuFWxWrs5Wr1fuwnFv34Uur1I9r4Yy34fG3y3tFyxZFs8Zr95ArWUGF4Dt390
	kF98Xr4Fvw1IqjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb48FF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
	ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_
	Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI
	42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUjIJmUUUUU
	U==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRAKA2o+TZNuiQAEs5

report_lost_node unconditionally calls fw_node_put after fw_node_event,
  but fw_node_event does not unconditionally acquire a reference. Since
  for_each_fw_node already holds a reference on the node during traversal,
  the extra fw_node_put over-decrements the refcount. The sibling callback
  report_found_node does not call fw_node_put, confirming the extra put is
  erroneous.

Cc: stable@vger.kernel.org
Fixes: 3038e353cfaf ("firewire: Add core firewire stack.")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 drivers/firewire/core-topology.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/firewire/core-topology.c b/drivers/firewire/core-topology.c
index bb2d2db30795..49820e4a34ff 100644
--- a/drivers/firewire/core-topology.c
+++ b/drivers/firewire/core-topology.c
@@ -298,7 +298,6 @@ static void report_lost_node(struct fw_card *card,
 			     struct fw_node *node, struct fw_node *parent)
 {
 	fw_node_event(card, node, FW_NODE_DESTROYED);
-	fw_node_put(node);
 
 	/* Topology has changed - reset bus manager retry counter */
 	card->bm_retries = 0;
-- 
2.39.5 (Apple Git-154)

