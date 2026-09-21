Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0765245D5D0;
	Mon, 21 Sep 2026 09:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789981617; cv=none; b=bx2+Wqwc9CE/JRQR3pfXDn9W1/FqIA6xhGOVwXVWv2q1YcB0v0ID1VQheqCZJ48k2rq2tXkP1Q37p+UsbHgBthv26dAuJusUV6As1+QrBps2mB0T9wy7RsuWzcxpJyFEe6cO1RTvzv5GI5h1r/CV3SrZ8B5kRmL/sbDajdC9FKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789981617; c=relaxed/simple;
	bh=OodoNLFg2xb6tTS7hEsElmY4bLlXqZ+aPssM8ZCmQDI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UjunhBPVp56d7fBvRhFfFWIY57btXu4s8YbsORFNgQP2X8vM32u65ylObMFt2BEwGbES+XUIi6IJrLseQFSt+jyleOjvBQV06y7onAf7XSYJ/NNWFTJRMoS7E9LiiIyiJueCJoENHLtFwaIu0Mq6mdoYT8l2gPjCF2h8WQ+APh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=cqt1IbQE; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="cqt1IbQE"
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4e8e74667;
	Mon, 21 Sep 2026 17:06:47 +0800 (GMT+08:00)
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
Subject: [PATCH v4 3/3] nvmet: avoid recursive configfs open for passthru
Date: Mon, 21 Sep 2026 17:05:59 +0800
Message-Id: <20260921090559.41364-4-runyu.xiao@seu.edu.cn>
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
X-HM-Tid: 0aa0c337c68503a1kunm2bb71b5a4118c
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCTktIVk1ITUNDHkwaGUwdSVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=cqt1IbQEYPOqcbALyJChXnIjSiaYdgh3M/ImKPVJj1KzjMfUD2eVrZrd0eAyY8fs//gMv6nhry/1cZYemB1L+5VvhxJ1jMe9BCTw+OW+10H+lhfynLfTlg0fQ9ZEj0oNE5iRDWSu60/SDpUhgaIVVFp+ZwPjkJGQ6+A/POfvJg8=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=PCqoKYBxp3/57YeeKIDVPJH+6QZu8Y/TZGIX+utFJO0=;
	h=date:mime-version:subject:message-id:from;

nvmet_passthru_enable_store() runs as a configfs store callback while
configfs holds the item frag_sem. Passthru enable used filp_open() on the
configured controller path, so a path into configfs could re-enter
__configfs_open_file() and try to acquire the same semaphore again.

Use configfs_file_open() so the path is resolved before opening,
configfs-backed paths are rejected, and the resolved path is opened with
file_open_root() while retaining the normal open-time permission and
security checks.

Fixes: cae5b01a2afc ("nvmet: introduce the passthru configfs interface")
Cc: stable@vger.kernel.org
Assisted-by: LLM Codex
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/nvme/target/passthru.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index fa6527c537e26..d60256004e6cf 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -9,6 +9,7 @@
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 #include <linux/module.h>
+#include <linux/configfs.h>
 
 #include "../host/nvme.h"
 #include "nvmet.h"
@@ -602,7 +603,7 @@ int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys)
 		goto out_unlock;
 	}
 
-	file = filp_open(subsys->passthru_ctrl_path, O_RDWR, 0);
+	file = configfs_file_open(subsys->passthru_ctrl_path, O_RDWR, 0);
 	if (IS_ERR(file)) {
 		ret = PTR_ERR(file);
 		goto out_unlock;
-- 
2.34.1

