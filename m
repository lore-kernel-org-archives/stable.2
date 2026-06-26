Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2932637FF4E;
	Fri, 26 Jun 2026 15:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782488453; cv=none; b=X5UHqUPGI41CaLjGx2qXak81UOD3r9ofJIVId/XsWq9NWVL7FP6GLaGHTG3hm5yw14BOvRrOreDVx946vqlrGcu3A3Nh4N8uxjfrCTta7qsSq+x1WfbvrHNfo6oB+wAiWtTC3zO9jed93c65CrWkpYIzwnioJTI7DO40lLJr4LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782488453; c=relaxed/simple;
	bh=NwM5g76m9h/THPGUh3ReD1BhmyXdcOKWfGS3kqoIsHk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KlFkbj41gwLQjNWvIK61PzMrdWZdPtkVZB3yl8y3B0aJ9IL4aNdyLiyo1NQC/pMgW4hQxSL28mgHDCI/WB1c2jAZY9a3wyZuGK1MPB8jBqeDDv0w+zYBd7VABqbJxaKMxXz+3o4Q3OchpP6bCztvBXOdSM8lYDH6itGoexgdyEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-01 (Coremail) with SMTP id qwCowAAHrNR7nT5qtqRsAw--.10415S2;
	Fri, 26 Jun 2026 23:40:44 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>
Subject: [PATCH] fix: nvmet: nvmet_sq_create: fix ctrl reference leak on nvmet_check_sqid   failure
Date: Fri, 26 Jun 2026 23:40:43 +0800
Message-Id: <20260626154043.53241-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAAHrNR7nT5qtqRsAw--.10415S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtrWrWFyxArWUuFyUtr1DKFg_yoWkAFcEk3
	48GrnrWa48ua1qkrW7Wr9xZr97KrnYqw1I9w4ktay3tr9YgFy3Gw1vyrnxJryxuw4rXry7
	CFnrGr4rArWakjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4AFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWxJVW8
	Jr1lIxAIcVC2z280aVCY1x0267AKxVWxJr0_GcJvcSsGvfC2KfnxnUUI43ZEXa7VU11SoJ
	UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgUKA2o+h0E80AABs1

After kref_get_unless_zero successfully acquires a ctrl reference, the
  nvmet_check_sqid failure path returns the status directly without calling
  nvmet_ctrl_put, leaving the ctrl reference permanently leaked.

Add nvmet_ctrl_put before returning on the nvmet_check_sqid error path to
  properly release the acquired reference.

Cc: stable@vger.kernel.org
Fixes: a07b4970f464 ("nvmet: add a generic NVMe target")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 drivers/nvme/target/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 62dd59b9aa4f..52fc2dade4ea 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -943,8 +943,10 @@ u16 nvmet_sq_create(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq,
 		return NVME_SC_INTERNAL | NVME_STATUS_DNR;
 
 	status = nvmet_check_sqid(ctrl, sqid, true);
-	if (status != NVME_SC_SUCCESS)
+	if (status != NVME_SC_SUCCESS) {
+		nvmet_ctrl_put(ctrl);
 		return status;
+	}
 
 	ret = nvmet_sq_init(sq, cq);
 	if (ret) {
-- 
2.39.5 (Apple Git-154)

