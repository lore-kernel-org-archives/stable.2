Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273189;
	b=CKfwbxqbz1AVvnfvEUqEPPVwk2HnlLR1eoUjXnLoFz8orjO9Fi2fxRPRrkM41alfB2ll
	 HGD2jp9XqPPKgPZEIf8rLXAt6X9dTLLdJu7fN3Xa+NV1ayG1cYErBZmVkkZ4XTaX8oufA
	 exn6VTTDu3+CLYkdAzUXgfJc+Uq2V4JiPdaF0Yu2j9sSbGXf97BZMEBp1hwAs4odRSH0Z
	 zWpNsZv/GEiQy4MQ8+nLaZsnMTIcQiwM8grnSGSpSyw9DIwieYhyOrTexkxaTKnm39gWE
	 T3YGfDKn9nUpKLbrE87A0OGGqT1BJH6ZC7uK2VLRRKhKRvFKsU5Z6FB1TNrdds9u/MQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273189;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=yMz+datHVpnvHkKrj1eejA3oDUf/TGnfXNq3d3u2Ztw=;
	b=YpV7Hl5drkHwpqKT7BXn2Dgh4BjNhOIztjWo+7m8N79CLVx4bWcgYi8lpc7mN0G/eBeU
	 p5X8iu1ovjkJ9tNw9CN+qXOV/8EUbwPp1lLkCIxHWNdWB85wBwuW/OV1DbboogY6AXyEm
	 YJyFaW5iOJZxzJeqJZg/dWc0fEJTkR454I1soEZEBRpLcIasv4dJSjv4B/sQLNtWo3iqY
	 8Ij7dUG/wQuGHUghpeCwkoZF59YCaAi2IZlYddFUmENk9k/wiUMFttUajtTFd/k+j6jJp
	 +GPqgBwPRnN+Di0PpSZOQCM7TLsSXE4clcDrgpX1+ZfjdTj17QUhb+nlVGJZBVxJdVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fLbE15gW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9862606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fLbE15gW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 365151F0089F;
	Tue, 10 Nov 2026 01:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273188;
	bh=yMz+datHVpnvHkKrj1eejA3oDUf/TGnfXNq3d3u2Ztw=;
	h=From:To:Cc:Subject:Date;
	b=fLbE15gWaW5KpLWdjQGuRj6vAENJKvR/C3DlnR2Kjok+JwD7Mulfvcv4htZOXryim
	 Td9OAB1OkMu6NGJSMfi2dNESN2+H5ttgjL/y2jy7aeYjna0K7n6CPiy1OhRF/cVHc/
	 cxm0a/IVhgziEUGE+90o9y5JdwMrEw13285FUIU2uA7qSCApBp9EmTMwmFKlWuKcXT
	 z2XuYW541T+YPRuZnYOHdgeYDd6frcEiRW5d4PWNQgDz7dtpMJeOWoswcJh3Cd7lV6
	 1lnTCPGETegL3NfWhz0LjsQLTAJCeS34FeQQoYT0hMeChE9JAPLBrJlvd2sU2YuuPW
	 5fxBzYCbJdFNQ==
From: Sasha Levin <sashal@kernel.org>
To: 1075151112@qq.com,
	hch@lst.de,
	kbusch@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] nvmet: reject keep-alive timeouts that would overflow" failed to apply to 6.6-stable tree
Date: Mon,  9 Nov 2026 20:13:07 -0500
Message-ID: <20261109201307-failed-6.6-96ae13f40ce5@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 96ae13f40ce5930cd58c43128e385131476f2a66
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201307-failed-6.6-96ae13f40ce5@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 96ae13f40ce5930cd58c43128e385131476f2a66 Mon Sep 17 00:00:00 2001
From: Yingjie Wang <1075151112@qq.com>
Date: Fri, 30 Oct 2026 16:46:22 +0800
Subject: [PATCH] nvmet: reject keep-alive timeouts that would overflow

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
---
 drivers/nvme/target/admin-cmd.c | 7 ++++++-
 drivers/nvme/target/core.c      | 8 +++++++-
 drivers/nvme/target/nvmet.h     | 8 ++++++++
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 26028be8fe4d8..a06cff8304db0 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -1227,8 +1227,13 @@ u16 nvmet_set_feat_kato(struct nvmet_req *req)
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
index a8171b88035c5..1dede04c204a6 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1620,6 +1620,12 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
 	u8 dhchap_status;
 	int ret;
 
+	if (kato > NVMET_MAX_KATO * MSEC_PER_SEC) {
+		args->status = NVME_SC_KA_TIMEOUT_INVALID | NVME_STATUS_DNR;
+		args->error_loc = offsetof(struct nvmf_connect_command, kato);
+		return NULL;
+	}
+
 	args->status = NVME_SC_CONNECT_INVALID_PARAM | NVME_STATUS_DNR;
 	subsys = nvmet_find_get_subsys(args->port, args->subsysnqn);
 	if (!subsys) {
@@ -1694,7 +1700,7 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
 		kato = NVMET_DISC_KATO_MS;
 
 	/* keep-alive timeout in seconds */
-	ctrl->kato = DIV_ROUND_UP(kato, 1000);
+	ctrl->kato = DIV_ROUND_UP_ULL(kato, MSEC_PER_SEC);
 
 	ctrl->err_counter = 0;
 	spin_lock_init(&ctrl->error_lock);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index d7804bf91aaa8..3cd58e813aa7f 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -7,6 +7,7 @@
 #define _NVMET_H
 
 #include <linux/dma-mapping.h>
+#include <linux/jiffies.h>
 #include <linux/types.h>
 #include <linux/device.h>
 #include <linux/kref.h>
@@ -714,6 +715,13 @@ void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
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




