Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFAB175A6B;
	Mon, 17 Aug 2026 14:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786977763; cv=none; b=IjA4yK8iNPwr2Wt9/nB9jbycwBxrqxOebG1r1Isqunk+8NXXptXrXJFjZxgfIkbnz/JRISfqKYJSj3Y/UmAcNsa7BpC5+o9ZiXxED1P1R1lqF8FONOwGvezqVCKVSKrhFgs0Sd9wMmcie95NwHEyU/qqAmuXO6tqTiF5wkdnrbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786977763; c=relaxed/simple;
	bh=oL5S44imAAG2KlNoJmeXXjenVxbiHXB8mVj1bXbTvZg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OQtsZThcDbZs6RQ5VaLDeCZFaj3WyweLt+W4dAD+YvBmIISazQjw+ARDS6vO1Eurfcp9XJPxPhn9p3rBQsdIQYYGzE5k57GjE18pK2GBSR+Pqhxg6dMoWc4N8xwEngwJk+/HXhhoD7G20dbIzc8ZKQBJAEUZ01Q5uxzXXoGHlos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=PJincbCR; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="PJincbCR"
Received: from PC-202605011814.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4a47a6f37;
	Mon, 17 Aug 2026 22:37:26 +0800 (GMT+08:00)
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
Subject: [PATCH 2/2] nvmet: avoid recursive configfs open for passthru
Date: Mon, 17 Aug 2026 22:37:14 +0800
Message-Id: <20260817143714.1344255-3-runyu.xiao@seu.edu.cn>
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
X-HM-Tid: 0aa01027eafc03a1kunmc75580f1e640c
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaTkJPVhpMSR1JGEoZQk8dGlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=PJincbCRMNd6K0UNnic6L9wqQ4/9bbeX6LQFv6LQnhBWyV0ox06NcdMWRYkLHhG69RPm2h6IuHBH3r+qWK/fW2PhvcQU3JDmDLdvELQ0NzxRGwkDy6qR0zFiW40kA8VmOew+tNYm4gFgi/pywl4+Z6SPSJg6RH0hCK8epEjgHis=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=AfF+O6VMncuZ2JqyZIH2RZeP5KJgvfiBK7YXB9hk6FA=;
	h=date:mime-version:subject:message-id:from;

nvmet_passthru_enable_store() runs as a configfs store callback while
configfs holds the item's frag_sem. nvmet_passthru_ctrl_enable() then
uses filp_open() on the configured passthru_ctrl_path.

If passthru_ctrl_path points back into configfs, the open path
re-enters __configfs_open_file() and tries to take the same frag_sem
again.

Resolve the path with kern_path(), reject configfs paths, and open the
resolved path with dentry_open() instead of filp_open(). Configfs paths
are not valid passthru controller backends, so rejecting them avoids
the recursion without changing valid users.

Fixes: cae5b01a2afc ("nvmet: introduce the passthru configfs interface")
Cc: stable@vger.kernel.org

Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/nvme/target/passthru.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 0c361b1e3566..be302f70d0e2 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -8,6 +8,7 @@
  *
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#include <linux/namei.h>
 #include <linux/module.h>
 
 #include "../host/nvme.h"
@@ -578,6 +579,7 @@ int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys)
 {
 	struct nvme_ctrl *ctrl;
 	struct file *file;
+	struct path path;
 	int ret = -EINVAL;
 	void *old;
 
@@ -592,7 +594,20 @@ int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys)
 		goto out_unlock;
 	}
 
-	file = filp_open(subsys->passthru_ctrl_path, O_RDWR, 0);
+	ret = kern_path(subsys->passthru_ctrl_path, LOOKUP_FOLLOW, &path);
+	if (ret)
+		goto out_unlock;
+
+	if (!strcmp(path.dentry->d_sb->s_type->name, "configfs")) {
+		pr_err("configfs paths cannot back passthru controller %s\n",
+		       subsys->passthru_ctrl_path);
+		path_put(&path);
+		ret = -EINVAL;
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
