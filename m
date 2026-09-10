Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67D1384CDD;
	Thu, 10 Sep 2026 04:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789016065; cv=none; b=YDcGp1HcnZ0iCj3pUl7BTkaJn216yozWoTYYZSoWilJOK6QhKmk6SG1ECV2Bzarw+hhb2oNueWwynzH1wfgo9Rs2EvlEaMyk9371J4ho8It7Tlh9LYijLsNFjLjUNR1rfK47RfG5OVB/gM45aNOPKaYM1HcBm5ZvqW7byfgYrRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789016065; c=relaxed/simple;
	bh=Ug7qX+4vRsUXWFK8FGHW49zfSGDgtHiJD4+F9815LM0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mp6jj/ihpMZVGW91mVE85h3uSUxA+wf1kLuNgA8uQS6+E1tJW6if+XN8e6CYvMwZ0RXfVZJMaIUp80bKAj6+47XUS+4ugd1n/SFuA5et2+FMcwbmpn+s4NBkovG9k+l5stEqJienVW21DXLnbDeB2yNWy5wM/ZkWJao2tvM4V/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=l7QwzizM; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="l7QwzizM"
Received: from PC-202605011814.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4d3a5a3cc;
	Thu, 10 Sep 2026 12:54:11 +0800 (GMT+08:00)
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
Subject: [PATCH v3 2/3] nvmet: avoid recursive configfs open for file-backed namespaces
Date: Thu, 10 Sep 2026 12:53:59 +0800
Message-Id: <20260910045400.1201582-3-runyu.xiao@seu.edu.cn>
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
X-HM-Tid: 0aa089aa8dcf03a1kunm413fe85d18135f
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDShhCVhlITk0aGR8aSExJQ1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSU
	hOQ0NVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=l7QwzizMF6Qh78XoOPLh1sRc0qLZV3i91uLMhEcyX0d8TtDDnG3017L22U9hv3N0Wiq/hQXUKZtXxWjNcKKY3gOHEf07LPn6C05fcogHHjY3AueL0Vxwh5XSUkwkJHPqSyl+XF70/wkhnBhtOzEffSmnlqWg61sN6TUrDRMa3Sc=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=xh7JsIVIqlqNdpmS1/fMVr20nh1KQUtlcaOcE6VOBMI=;
	h=date:mime-version:subject:message-id:from;

nvmet_ns_enable_store() runs as a configfs store callback while configfs
holds the item's frag_sem. A file-backed namespace then opens the
configured device_path with filp_open(). If the path resolves into
configfs, the open path re-enters __configfs_open_file() and attempts to
acquire the same frag_sem again.

Resolve the configured path first, reject paths resolved on configfs, and
open the resolved path with file_open_root(). This preserves the standard
open-time permission checks without performing a second pathname walk. Use
the configfs helper for the filesystem type check so this caller shares the
classification with other configfs users.

Fixes: d5eff33ee6f8 ("nvmet: add simple file backed ns support")
Cc: stable@vger.kernel.org
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Assisted-by: LLM Codex
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/nvme/target/io-cmd-file.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 0b22d183f..fbe58aa4a 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -8,7 +8,9 @@
 #include <linux/uio.h>
 #include <linux/falloc.h>
 #include <linux/file.h>
+#include <linux/configfs.h>
 #include <linux/fs.h>
+#include <linux/namei.h>
 #include "nvmet.h"
 
 #define NVMET_MIN_MPOOL_OBJ		16
@@ -33,12 +35,28 @@ void nvmet_file_ns_disable(struct nvmet_ns *ns)
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
+	if (configfs_path_is_configfs(&path)) {
+		pr_err("configfs paths cannot back namespace %s\n",
+		       ns->device_path);
+		path_put(&path);
+		return -EINVAL;
+	}
+
+	ns->file = file_open_root(&path, "", flags, 0);
+	path_put(&path);
 	if (IS_ERR(ns->file)) {
 		ret = PTR_ERR(ns->file);
 		pr_err("failed to open file %s: (%d)\n",
-- 
2.34.1
