Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794633873;
	b=NLBUkB8SAs94CvTxEAbCyAhvk4h+/H1l5JZTybW8SzP0cXvZt9iyjPLOU4i9TQ4QDOnd
	 ZisYVN7ObQnFQzYXSIpzn77CIXfeKl5GmiadorgoxWPgcaz5AcXDmvpjTclmUk+sMdouC
	 m7AMzIkaGx0RdfB0iFT5+zKnnjh0PcIiNdFSRXFFar/d2awaOHlIhTDOCklp7GqykiOoa
	 HGXJ+E3ESmho9S4OmFAgpdw4YCEILcPCPsHUEqQ6HMH+7bZIZuDX6QwPd6vYnGiI2O3M3
	 AeRT2mdKlfmK65m6b7OPYD4Z2w/b+91b4usYi3kaWIpeztEKzoSZtjyglKg+YeJyP5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794633873;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=BVB7ix7F4VBYSAJD9n4i202XmjW/NzQ8C90iGjtdjgU=;
	b=VBw9GIO3FodDVeX+Kxg529LNnyOdesY2+uRVjgHdy3VGSBQze4ROC0L+6ljEM1KVvSh+
	 wKI83gd+hQrQIyf7cnu5+qlpBMjHq3MhY2HpCrUD8DNhU2nb1ubJwy9avrcFdmqblZmhU
	 eyBStC0hkaW6yTRBuP3Yc4P12BVmT8/VTSw6oXp1P/qLTIzCIJ2R7g+qTX9Q4qWFA69dc
	 3lFvMnp2dDg9cyuGr8Wa55VV6XVdr0Du/KfL4Bh9wB2qs7oZ+NCjbVZo3E2842RIShlEE
	 kULnWQUxwn0HR0hHty4tAWVS+iVJVKPuLKnh31c9PX6xiCSMTZLOh1gOi7KGQoHerCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="g+YW/3k4";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9370606A323
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 05:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g+YW/3k4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 288281F000C4;
	Sat, 14 Nov 2026 05:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794633872;
	bh=BVB7ix7F4VBYSAJD9n4i202XmjW/NzQ8C90iGjtdjgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g+YW/3k4wHmoLgDYh51tE2jZKS6byAlMGUh2SOS86/GnOWWBcYwMXDP7VEKu7jHK5
	 CBMBd7C0EWGpy2YIxN9MhEicpMkUaFzHzukz70W5HJUQS1cK5oXrXMTs4xhM5K0ErP
	 Wo05Z0hG9UjjzGElCh6rqr4ch3JPJpcIche65qVBgJugebNh3q4AGvWN39zNPRwAx7
	 ts1Zo3q7x5J7VlTZeZ/D9LgJM7UdRPaujv6wevhPvlRieDLzwgC4HgGjioGfiU1mhZ
	 oqgLvHy1t/jgWTbQbPGW6xBLa7TRaRzLI34HoaVDk0syAUwrOljn9Likv0gWDToFv7
	 qrt36UNH52y3A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yingjie Wang <1075151112@qq.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] nvmet: reject keep-alive timeouts that would overflow
Date: Sat, 14 Nov 2026 00:24:30 -0500
Message-ID: <20261114052405.3045068-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201307-failed-6.6-96ae13f40ce5@kernel.org>
References: <20261109201307-failed-6.6-96ae13f40ce5@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yingjie Wang <1075151112@qq.com>

[ Upstream commit 96ae13f40ce5930cd58c43128e385131476f2a66 ]

nvmet_set_feat_kato() and nvmet_alloc_ctrl() convert the 32-bit
millisecond KATO from the host to seconds with DIV_ROUND_UP(kato, 1000).
The addition in DIV_ROUND_UP() is done in 32 bits, so any KATO above
4294966296 ms wraps around and rounds to 0 seconds. A Set Features
command with KATO 0xffffffff then succeeds but disables the keep-alive
timer: Get Features returns 0 and Keep Alive fails with Keep Alive
Timeout Invalid. A Connect command with such a KATO creates a controller
without a keep-alive timer.

The converted value has more consumers that can overflow. Get Features
multiplies it by 1000, and the timer paths multiply it by HZ in 32 bits
and arm a delay that must not exceed MAX_JIFFY_OFFSET.

Reject a KATO whose rounded value does not fit all of these. Return Keep
Alive Timeout Invalid from both Set Features and Connect. Validate Set
Features before stopping the current timer so a failed update leaves its
timeout unchanged. Round in 64 bits. A KATO of 0 keeps its current
meaning.

Fixes: a07b4970f464 ("nvmet: add a generic NVMe target")
Cc: stable@vger.kernel.org
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Yingjie Wang <1075151112@qq.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
[ sashal: adapted nvmet_alloc_ctrl() error handling to return status directly and set req->error_loc instead of using args ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/admin-cmd.c | 7 ++++++-
 drivers/nvme/target/core.c      | 7 ++++++-
 drivers/nvme/target/nvmet.h     | 8 ++++++++
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index a033d8dce5aab..18987d9cf94a6 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -801,8 +801,13 @@ u16 nvmet_set_feat_kato(struct nvmet_req *req)
 {
 	u32 val32 = le32_to_cpu(req->cmd->common.cdw11);
 
+	if (val32 > NVMET_MAX_KATO * MSEC_PER_SEC) {
+		req->error_loc = offsetof(struct nvme_common_command, cdw11);
+		return NVME_SC_KA_TIMEOUT_INVALID | NVME_STATUS_DNR;
+	}
+
 	nvmet_stop_keep_alive_timer(req->sq->ctrl);
-	req->sq->ctrl->kato = DIV_ROUND_UP(val32, 1000);
+	req->sq->ctrl->kato = DIV_ROUND_UP_ULL(val32, MSEC_PER_SEC);
 	nvmet_start_keep_alive_timer(req->sq->ctrl);
 
 	nvmet_set_result(req, req->sq->ctrl->kato);
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 8e0da771fc1cb..e3dd453025751 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1415,6 +1415,11 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 	int ret;
 	u16 status;
 
+	if (kato > NVMET_MAX_KATO * MSEC_PER_SEC) {
+		req->error_loc = offsetof(struct nvmf_connect_command, kato);
+		return NVME_SC_KA_TIMEOUT_INVALID | NVME_STATUS_DNR;
+	}
+
 	status = NVME_SC_CONNECT_INVALID_PARAM | NVME_STATUS_DNR;
 	subsys = nvmet_find_get_subsys(req->port, subsysnqn);
 	if (!subsys) {
@@ -1479,7 +1484,7 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 		kato = NVMET_DISC_KATO_MS;
 
 	/* keep-alive timeout in seconds */
-	ctrl->kato = DIV_ROUND_UP(kato, 1000);
+	ctrl->kato = DIV_ROUND_UP_ULL(kato, MSEC_PER_SEC);
 
 	ctrl->err_counter = 0;
 	spin_lock_init(&ctrl->error_lock);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 56b9bbe8c6026..b62f9300c0e64 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -7,6 +7,7 @@
 #define _NVMET_H
 
 #include <linux/dma-mapping.h>
+#include <linux/jiffies.h>
 #include <linux/types.h>
 #include <linux/device.h>
 #include <linux/kref.h>
@@ -564,6 +565,13 @@ bool nvmet_subsys_nsid_exists(struct nvmet_subsys *subsys, u32 nsid);
 #define NVMET_KAS		10
 #define NVMET_DISC_KATO_MS		120000
 
+/*
+ * Largest keep-alive timeout in seconds that can be reported back in
+ * milliseconds and converted to jiffies without overflowing.
+ */
+#define NVMET_MAX_KATO	\
+	min3(U32_MAX / MSEC_PER_SEC, U32_MAX / HZ, MAX_JIFFY_OFFSET / HZ)
+
 int __init nvmet_init_configfs(void);
 void __exit nvmet_exit_configfs(void);
 
-- 
2.53.0

