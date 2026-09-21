Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6824ADD95
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 14:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790002520; cv=none; b=Ot7pEODC3r7sYCCKxVIpx65cnx6qLgexYYs+U8i1kWEOkgsBD7ykmSiXTDH8kFmQgcXxshBTwgD3mgAVYn/KoF/F1/wH4k3pyvnB6kFg8P5htx6XIiqqhDiBn0JN6VG2ZrEtv8QiUWsrub1d7CHonxwwR9p1jfqFqG3gKDPck10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790002520; c=relaxed/simple;
	bh=mZvnLvReuJ9V7HAi4krKvrTonXmTIxabYK80KTvvwz4=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=OdH5lOW+8/MeDsaTyNkCk4+S8BZyR9Lq+3eOjTbkdlNLUkJH8tWqgLTZCYvBppLlzMRip+UZ7AT+IL0vNw3KZX9GoxLE7EXCs8e8NkwL4ARs125wH6u3aEvjm1S1NAEhFkY3CSkE7yMcueSGiqRBbS9HfeOM6j0yaRRV1gGrKRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=cyluf9oG; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="cyluf9oG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1790002498;
	bh=rk0SiRQ4KTg/j0YXJktzCRmSXkJzTfPkIQhaW8Y0g+A=;
	h=From:To:Cc:Subject:Date;
	b=cyluf9oGSLaTKu23e6lYaDtE3j+oZJD0lSi8OY675E67BlB7+O+MzcRnXU5lhzVmo
	 MEZMM/3GRaqBvQyYuPJbEzWH8MJBOuhbYowfFB8uhlJZOk426hLMTww04oi9CchAQJ
	 VV9MStPbnU7//50giRF2hVzoxEnDx4xGU0VOiCGI=
Received: from foxmail.com ([101.67.132.195])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id CE421A7E; Mon, 21 Sep 2026 22:51:36 +0800
X-QQ-mid: xmsmtpt1790002296tirm5xmfp
Message-ID: <tencent_F07E51BA603F29CD6981927F4267CE50790A@qq.com>
X-QQ-XMAILINFO: MJf32pulH481CoGQpB+PVb15fwwgSltipnQy/FweKj6SVWmguAbY7DxsyHvMxd
	 fS0sERW+TvKXWnxCOGB35JOweGdfzWjeMhqUQ8v6oKFpdgUsCGI7gMvNjsRgKdvhxGjWf9Zmd5D9
	 pv3zsAB2sXPCmkrsqeEPSqLakEjQr6sTTD+IsNJjKA0bJzG6i3Phl050J5CWnAvV5WnTUMe6jfzP
	 WYItfrs9YNmWUPf8MFDTIPpKbfsQbEioGBG388HJthFdejRglnkF4Bta6qb9ZbcELQ+epMjqrIK/
	 Qe8I78/Mhgnz9T3XIZnrWkIccPOLWOD4wLAQcz1eg67QKryAiru9A6XMPKxPeGvvo2mUyq+z+4jC
	 YDvf15jwSk8anTohSivXlcuvOOAzLFuLw7GKonmjEyz7QQ+5GaptZclyonjKVQH6viXl3s1AL0bm
	 Po2zCD5AkRzCHEZDg5jrw8AkrXKEOVap7SNy5WVqv28eDZUNm0mOP81B2P0Gp5wYuwJxCQzgl9UT
	 I9qxti75DeG+6i0alNdFB0vyN6dzGpHy8B3aI4Kh9lhjKVOzsq2g00bd1KxtYpVBzJO2UGFBOAH/
	 fgQ/HtOylksDL6t7NlKXWDfa0b5FSUATv7nFqQC95KTuJs3lmxvigrus/x23tbLQJOKOSA3BlFMQ
	 aYDo4r50qb9z7m0szjrXomrYjjty3rSFOzKMedBCFaUqOCdLvhzmrMdU3IuTNNDjHSLq98dNJKQu
	 dZU4Wj98UYB5ChHzt/yMdZ8JI2+YxVmyVAeGLG4fbhJMIXiqPiEMbsw/3so+m18z9gOkg6LboR6I
	 4vgsE55o+I/CfgnMR6l5GEuv4UHSwnwWi+SiBRlL6WBBDqL2eMQjaZFW0vPnz+gC5YEjg5A/cH5q
	 +OsITEDgwlP+8Jxz1Nmv8tERyNU1E0RIy1za8A89XG4LmBBTLKVjX2ABLeGMxLOZC2/FtzSq/Vx6
	 T4Mpn0TEV+FxpYdbJ0otJ7g7w2Ptm3aAfab1NZt0TNJdUDAhTNn3jB4fCT5sLMyyANOUVJm2bcZa
	 xEV/y6aKJlBRTtlxdRsDstSb3oOm7bpqIpB9wADfZLeIaUs9HETJ54Snk7ZjrfDc4cpICLpH22ut
	 YLTbnDcZaJOzLOX3s=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: zhoumin <teczm@foxmail.com>
To: teczm@foxmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH] iommu/arm-smmu-v3: Avoid erasing unlinked stream nodes
Date: Mon, 21 Sep 2026 14:51:35 +0000
X-OQ-MSGID: <20260921145135.14191-1-teczm@foxmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A master's StreamID list may contain duplicates due to PCI DMA aliases.
arm_smmu_insert_master() skips duplicate IDs belonging to the same
master, leaving the corresponding rb_nodes unlinked.

Both arm_smmu_remove_master() and the insertion error path still pass
these nodes to rb_erase(). Erasing a zeroed, unlinked node clears the
tree root, losing SID-to-master mappings for other devices on the SMMU.

Mark the skipped nodes with RB_CLEAR_NODE() and skip them in both
removal paths. Set the marker after sorting the stream array, since
RB_CLEAR_NODE() stores the node's own address.

Fixes: b00d24997a11 ("iommu/arm-smmu-v3: Fix iommu_device_probe bug due to duplicated stream ids")
Cc: stable@vger.kernel.org
Signed-off-by: zhoumin <teczm@foxmail.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 5732f3ba0122..2627d496921e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4141,8 +4141,10 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 					->master;
 
 			/* Bridged PCI devices may end up with duplicated IDs */
-			if (existing_master == master)
+			if (existing_master == master) {
+				RB_CLEAR_NODE(&new_stream->node);
 				continue;
+			}
 
 			dev_warn(master->dev,
 				 "Aliasing StreamID 0x%x (from %s) unsupported, expect DMA to be broken\n",
@@ -4154,7 +4156,8 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 
 	if (ret) {
 		for (i--; i >= 0; i--)
-			rb_erase(&master->streams[i].node, &smmu->streams);
+			if (!RB_EMPTY_NODE(&master->streams[i].node))
+				rb_erase(&master->streams[i].node, &smmu->streams);
 		kfree(master->streams);
 		kfree(master->build_invs);
 	}
@@ -4174,7 +4177,8 @@ static void arm_smmu_remove_master(struct arm_smmu_master *master)
 
 	mutex_lock(&smmu->streams_mutex);
 	for (i = 0; i < fwspec->num_ids; i++)
-		rb_erase(&master->streams[i].node, &smmu->streams);
+		if (!RB_EMPTY_NODE(&master->streams[i].node))
+			rb_erase(&master->streams[i].node, &smmu->streams);
 	mutex_unlock(&smmu->streams_mutex);
 
 	kfree(master->streams);
-- 
2.43.0

