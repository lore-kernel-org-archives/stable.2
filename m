Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49C247F774;
	Wed, 19 Aug 2026 15:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787154780; cv=none; b=hjcuoQF+K+lewVPIEF2WFbYSm3myW5v6t3iVcx4WjKqQie14pUSYJ6eDO0RHlhmp0o63fFGFMLcfukPgzxvXGeLOcXF8pT5YgAVTduRNrMe69lHjy7CDdJPk8wUiLOQxGKmxz90B60r5qLSKWDubsr1Sb5BH2w5U74oO0nUSj0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787154780; c=relaxed/simple;
	bh=pDKk4+GUwUyyh1k3sTrw/lc/j9k9uzdFhvH1nfTjD6E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pERivCCETyzWwISSPc1W8P22d7X/oYnHspA9aVsbBu3hzM5+U4H1lQ1Kk7oA44ZlVuCFI878UCed/jv/OHxOCmT4CGRUgDnpvqZ0mHri4J26YIfGta+FQV9jYl5OPtvBeP80VxJzxfArZmUtrKuG51FE0r05z13a3dDqT7MXNRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=mpKv67VH; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="mpKv67VH"
Received: from PC-202605011814.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4a95ff6df;
	Wed, 19 Aug 2026 23:52:43 +0800 (GMT+08:00)
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
Subject: [PATCH v2 2/3] nvmet: avoid recursive configfs open for file-backed namespaces
Date: Wed, 19 Aug 2026 23:52:27 +0800
Message-Id: <20260819155228.84938-3-runyu.xiao@seu.edu.cn>
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
X-HM-Tid: 0aa01ab98f8203a1kunm38a93da01445bd
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaHUxCVh5KSUkaTxhJH09JTVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=mpKv67VHtJPQgFBgJxZRmLRJC0FADyvLmsSLm0dZy/Iub6qfGqshWoE2P1/tX3+shlprVcekw8XoOWIHTc98Cb9jBIJTZ4hKJ4lVgBoZLBn8DPQzA2oYKdFnIUjCRsCa1ENJ00gmDAoL9idyyys/Vx5EpupWGH0G0Nj16rVES4Y=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=jZ8LIQ9IsX5SI4Y97L1IUaZXjjXymwc4snkScUx/aks=;
	h=date:mime-version:subject:message-id:from;

nvmet_ns_enable_store() runs under configfs frag_sem. If a file-backed
namespace path resolves into configfs, filp_open() can re-enter configfs
and recurse on the same semaphore.

Reject configfs-backed paths after kern_path() and open the resolved path
with dentry_open() instead.

Fixes: d5eff33ee6f8 ("nvmet: add simple file backed ns support")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/nvme/target/io-cmd-file.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 2d068439b129..4ba3ebb82e6a 100644
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
+	ns->file = dentry_open(&path, flags, current_cred());
+	path_put(&path);
 	if (IS_ERR(ns->file)) {
 		ret = PTR_ERR(ns->file);
 		pr_err("failed to open file %s: (%d)\n",
-- 
2.34.1
