Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EDC48123E;
	Wed, 19 Aug 2026 15:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787154778; cv=none; b=SDQfbapvV+9/kQIJ2fNqQFuCj6jtUbiVZff/NFGXYvK3WVBQyL83TxUsCeovAw8JjtnWcznDquEqfNut/o/wX9ZrZCuZ5GsXPTMQtsQujxLafbdvZWB+aRQ9OEwbJr3DPN74LUuiyigG73VcstPAi0s2qeT02vNcdq2gdZRKoNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787154778; c=relaxed/simple;
	bh=qumvmFUxjqL7+H+Sf/xcg3B2pURzdDZt02BUC/vMl38=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MXMv1oBRATlORPR2QvtKH9xSKauPPP9KkuqF83w6GLVyBsSe3h8Wj5EhY9s+8KiRRVCbf8m2Z7ebgmwTy+Ki1YLTApI8gM/+bHkWqt7Fn0+NpIL6wULEXqejOa/S9JM1nNDDKMXWN6KQZFaZOVVq0uQjM7HYKva0vaTzZPKecZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=MjX3Td8f; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="MjX3Td8f"
Received: from PC-202605011814.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4a95ff6e1;
	Wed, 19 Aug 2026 23:52:45 +0800 (GMT+08:00)
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
Subject: [PATCH v2 3/3] nvmet: avoid recursive configfs open for passthru
Date: Wed, 19 Aug 2026 23:52:28 +0800
Message-Id: <20260819155228.84938-4-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260819155228.84938-1-runyu.xiao@seu.edu.cn>
References: <20260817143714.1344255-1-runyu.xiao@seu.edu.cn>
 <20260819155228.84938-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa01ab9958f03a1kunm38a93da01445c0
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaT0xJVkkaHh1JHxhCHk5NSVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=MjX3Td8fO9zdpAjI8ziB+YxXTGbtgmZGeDSj11H+VqU0HQGNSzpmnqi4jak2mLRyAlaZmb5bROCEOwLBFT+o25Amklx6ClrNEVtm509XW0RXDPRv9WOm++kD6vMM8b76f/W9UO//yULlJvx/E0MOBhjcxj36WJzTY1754aKy36k=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=ibe22cMUDWrdIKNBbA5Osf/dOdBYA7FGe74ypRustCg=;
	h=date:mime-version:subject:message-id:from;

nvmet_passthru_ctrl_enable() runs under configfs frag_sem. If the
configured passthru controller path resolves into configfs, filp_open()
can re-enter configfs and recurse on the same semaphore.

Reject configfs-backed paths after kern_path() and open the resolved path
with dentry_open() instead.

Fixes: cae5b01a2afc ("nvmet: introduce the passthru configfs interface")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/nvme/target/passthru.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 0c361b1e3566..b3c57bf033e1 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -9,6 +9,8 @@
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 #include <linux/module.h>
+#include <linux/configfs.h>
+#include <linux/namei.h>
 
 #include "../host/nvme.h"
 #include "nvmet.h"
@@ -578,6 +580,7 @@ int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys)
 {
 	struct nvme_ctrl *ctrl;
 	struct file *file;
+	struct path path;
 	int ret = -EINVAL;
 	void *old;
 
@@ -592,7 +595,19 @@ int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys)
 		goto out_unlock;
 	}
 
-	file = filp_open(subsys->passthru_ctrl_path, O_RDWR, 0);
+	ret = kern_path(subsys->passthru_ctrl_path, LOOKUP_FOLLOW, &path);
+	if (ret)
+		goto out_unlock;
+
+	if (configfs_path_is_configfs(&path)) {
+		pr_err("configfs paths cannot back passthru controller %s\n",
+		       subsys->passthru_ctrl_path);
+		path_put(&path);
+		goto out_unlock;
+	}
+
+	file = dentry_open(&path, O_RDWR, current_cred());
+	path_put(&path);
 	if (IS_ERR(file)) {
 		ret = PTR_ERR(file);
 		goto out_unlock;
-- 
2.34.1
