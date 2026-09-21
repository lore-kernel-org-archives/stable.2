Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D818A45041C;
	Mon, 21 Sep 2026 09:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789981612; cv=none; b=rT4/RCw3ZTV5Ea/kDf14hr+Fn1I/8/sdYd3ykeAX8tsMqDJp3jvQ7EIQ+uYDmbJ2kJ/pL2R9q3yvWp9xr7ukymyhG+vfa+mZmBE5CXm/nvJ56COrMiASEB/A0SiO7aVg1Zk8/hfPkDKDuQI395//91HodfgvZZ9oNjqPHaYZZs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789981612; c=relaxed/simple;
	bh=itRd7GtKOrHPOaG8Qi01tj/V/+p1/41tRd8I0FxtH40=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HcObIcuE9grvjZ3GhI8omUdX9TOj9Joe7LmiYzxESRviEseun0dNxj+3vHxywOKIHBBxphsrupdZJDsQ2168c1YS0IywcKIU5JwyZgTl1ECgXmPyHEmvbTvzDYbm84Kp1ufyp+rqWF9+HBirXqZXo+2iUZp4slKxxvXKVBspFhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=PliqQQXE; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="PliqQQXE"
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4e8e74662;
	Mon, 21 Sep 2026 17:06:44 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH v4 2/3] nvmet: avoid recursive configfs open for file-backed namespaces
Date: Mon, 21 Sep 2026 17:05:58 +0800
Message-Id: <20260921090559.41364-3-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260921090559.41364-1-runyu.xiao@seu.edu.cn>
References: <20260921090559.41364-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0c337bb2603a1kunm2bb71b5a4117b
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDGR0eVhoaHUkYHh9CGB5KSVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=PliqQQXEERXIZvW4UdVd0d8SiaE4qlJYWjTnJBp3/NlHEJKZRF5SZJsUJKh5WeVOS5VCa8RqDw1xPmlDcTQcfOjJq6dvrLzP168av1cGW90lfWu2tF39lGbnl8rZIEtrPl7bXSTBR+tlaqYkzxhh+5dyqgUT1hML6u5grdezJ1o=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=YtRF6Vta+5vZ+xMHLfaKypEUxsauMMO8lTqR07dKzD8=;
	h=date:mime-version:subject:message-id:from;

nvmet_ns_enable_store() runs as a configfs store callback while configfs
holds the item frag_sem. File-backed namespace enable used filp_open() on
the configured device_path, so a path into configfs could re-enter
__configfs_open_file() and try to acquire the same semaphore again.

Use configfs_file_open() so the path is resolved before opening,
configfs-backed paths are rejected, and the resolved path is opened with
file_open_root() while retaining the normal open-time permission and
security checks.

Fixes: d5eff33ee6f8 ("nvmet: add simple file backed ns support")
Cc: stable@vger.kernel.org
Assisted-by: LLM Codex
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/nvme/target/io-cmd-file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 0b22d183f9279..2a4f25de94ba1 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -8,6 +8,7 @@
 #include <linux/uio.h>
 #include <linux/falloc.h>
 #include <linux/file.h>
+#include <linux/configfs.h>
 #include <linux/fs.h>
 #include "nvmet.h"
 
@@ -38,7 +39,7 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
 	if (!ns->buffered_io)
 		flags |= O_DIRECT;
 
-	ns->file = filp_open(ns->device_path, flags, 0);
+	ns->file = configfs_file_open(ns->device_path, flags, 0);
 	if (IS_ERR(ns->file)) {
 		ret = PTR_ERR(ns->file);
 		pr_err("failed to open file %s: (%d)\n",
-- 
2.34.1

