Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCCB3B52EF;
	Thu, 10 Sep 2026 04:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789016065; cv=none; b=c91hI0WOGtDO2qAiGoIH7HttZNGctpSBa0G3eynLu+L2KLYv26TwFMiRmoT2B3iM/vAso9RGgPhXw6Kv4zV7nJX8INhMmc2nP+iv8HzIc0Z1Q2SmpLD0/eVIopV4HNm39nbIa1+KBG2Z+dXGR7ywfri6bikqfQT5up/2V7Hf1J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789016065; c=relaxed/simple;
	bh=agw5GRV8zJ0ivu0/kYq8UcseI+WEQ+kU4Nt10keaXUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WDVXQbiGW4MYKP+CixUluDQKdj1lzUsuq7ah2LSf247Wy0D51kvTWs/I9ZuRufl+WxmMvLeRk1O/82AQwMwpac+qpjLm8btaM3GUfSxlf88K3WRiRz2wqt7/TUGerMtkRD+z+jeejVR0PIY67DhgbxCCCD+Zno1ZZrC5C4CAw2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=VHpAZOtP; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="VHpAZOtP"
Received: from PC-202605011814.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4d3a5a3ce;
	Thu, 10 Sep 2026 12:54:12 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH v3 3/3] nvmet: avoid recursive configfs open for passthru
Date: Thu, 10 Sep 2026 12:54:00 +0800
Message-Id: <20260910045400.1201582-4-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260910045400.1201582-1-runyu.xiao@seu.edu.cn>
References: <20260902103202.GB8095@lst.de>
 <20260910045400.1201582-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa089aa943003a1kunm413fe85d181362
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZHhlKVhkdSRpPS0hDTU9MTVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSU
	hOQ0NVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=VHpAZOtPlL/oqxx6NnJst7DEVqW4wFH1X3/fNiAwrbUptRyGG7E9+Cq/fuSkrkeeOWwLhNKrSQvNd+Vm2kRO8BgzKQ5FYK2ID95DZQXEKNbF4WVhkuVIa448msJyYUQXmA4sNIZWU/jIZPNm3I81lWOFaBQdG+7PVhBMjr+6kO0=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=wPPMTFM/RlLKVmOG8oGw1kTaF1eOnMkGUDWNx0SoHbM=;
	h=date:mime-version:subject:message-id:from;

nvmet_passthru_enable_store() runs as a configfs store callback while
configfs holds the item's frag_sem. Enabling passthru then opens the
configured passthru_ctrl_path with filp_open(). If that path resolves
into configfs, the open path re-enters __configfs_open_file() and attempts
to acquire the same frag_sem again.

Resolve the configured path first, reject paths resolved on configfs, and
open the resolved path with file_open_root(). This preserves the standard
open-time permission checks without performing a second pathname walk. Use
the configfs helper for the filesystem type check so this caller shares the
classification with other configfs users.

Fixes: cae5b01a2afc ("nvmet: introduce the passthru configfs interface")
Cc: stable@vger.kernel.org
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Assisted-by: LLM Codex
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/nvme/target/passthru.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index fa6527c53..aa1778c9e 100644
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
@@ -588,6 +590,7 @@ int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys)
 {
 	struct nvme_ctrl *ctrl;
 	struct file *file;
+	struct path path;
 	int ret = -EINVAL;
 	void *old;
 
@@ -602,7 +605,19 @@ int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys)
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
+	file = file_open_root(&path, "", O_RDWR, 0);
+	path_put(&path);
 	if (IS_ERR(file)) {
 		ret = PTR_ERR(file);
 		goto out_unlock;
-- 
2.34.1
