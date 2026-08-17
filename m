Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CE9346A02;
	Mon, 17 Aug 2026 14:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786977762; cv=none; b=AyzDwTi80cdHIdrUOHyBGQcL8cLZNqZNk/r2OYu3NnnVCNy//kp68SNukKZx0rZ3Vg/2AKH4GYA+Ey4ySGROuLCAzGatcfxrMfZSQxyjedb3ndOoMTWiPZiawng0MRNxygA/YAvND6JZg1p7Tn4MWej6YOUy9HVS3rMhOB4xAs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786977762; c=relaxed/simple;
	bh=TSVATs2YxfsTHzJWrRdBZiRZlJrpo+iziyQpm7ONi3c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aOnK18RYeF1/obfWZ7E4pbSSjDO3IERf3JyIm9DQFfn2Nzq32iMJBCLoNOmMNHB1Q7M6+weqR8xUmvZS24LlLGNp0+LZMe1lL7+ZvSYyexwwsC8O4/9x6Vm+mPEBoHONFzyr+d+twlH4Frnt36qz1S6Tp9wSIoJdxi71YiGRPsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=LgeYtZWL; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="LgeYtZWL"
Received: from PC-202605011814.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4a47a6f36;
	Mon, 17 Aug 2026 22:37:25 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH 1/2] nvmet: avoid recursive configfs open for file-backed namespaces
Date: Mon, 17 Aug 2026 22:37:13 +0800
Message-Id: <20260817143714.1344255-2-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260817143714.1344255-1-runyu.xiao@seu.edu.cn>
References: <20260817143714.1344255-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa01027e62803a1kunmc75580f1e640a
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZTxofVh1NTRkfQ0wYH09LT1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=LgeYtZWLOgXZPMA2OLi9ZOHOI3suX9ZA1HUdAJy78ztvSDubA/Af2L3PI6osdj0PrE19b43kq4NfSZUsA4z3SGqy06Naq73BXsQ55M0XrBhPRzFw9JpyxszAcu0NDuag4RZ6oDigX7n6and6R7w09szM8w74F20DL7CvBV61GDg=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=qRwCJQg2x/evUHFyGZ4aI8lEwVqyKAC79gs0OpN14IQ=;
	h=date:mime-version:subject:message-id:from;

nvmet_ns_enable_store() runs as a configfs store callback while configfs
holds the item's frag_sem. For file-backed namespaces, nvmet_ns_enable()
calls nvmet_file_ns_enable(), which uses filp_open() on the
user-supplied device_path.

If device_path points back into configfs, the open path re-enters
__configfs_open_file() and tries to take the same frag_sem again.

Resolve the path with kern_path(), reject configfs paths, and open the
resolved path with dentry_open() instead of filp_open(). This keeps
valid block-device and regular-file backends working without
re-entering configfs.

Fixes: d5eff33ee6f8 ("nvmet: add simple file backed ns support")
Cc: stable@vger.kernel.org

Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/nvme/target/io-cmd-file.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 2d068439b129..6d653519327a 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -9,6 +9,7 @@
 #include <linux/falloc.h>
 #include <linux/file.h>
 #include <linux/fs.h>
+#include <linux/namei.h>
 #include "nvmet.h"
 
 #define NVMET_MIN_MPOOL_OBJ		16
@@ -33,12 +34,28 @@ void nvmet_file_ns_disable(struct nvmet_ns *ns)
 int nvmet_file_ns_enable(struct nvmet_ns *ns)
 {
 	int flags = O_RDWR | O_LARGEFILE;
+	struct path path;
 	int ret = 0;
 
 	if (!ns->buffered_io)
 		flags |= O_DIRECT;
 
-	ns->file = filp_open(ns->device_path, flags, 0);
+	ret = kern_path(ns->device_path, LOOKUP_FOLLOW, &path);
+	if (ret) {
+		pr_err("failed to open file %s: (%d)\n",
+		       ns->device_path, ret);
+		return ret;
+	}
+
+	if (!strcmp(path.dentry->d_sb->s_type->name, "configfs")) {
+		pr_err("configfs paths cannot back namespace %s\n",
+		       ns->device_path);
+		path_put(&path);
+		return -EINVAL;
+	}
+
+	ns->file = dentry_open(&path, flags, current_cred());
+	path_put(&path);
 	if (IS_ERR(ns->file)) {
 		ret = PTR_ERR(ns->file);
 		pr_err("failed to open file %s: (%d)\n",
-- 
2.34.1
