Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794671793;
	b=x473R5XVy1FBRUCy1qKXre2jUNoSwigVFh2uvuWZTVOfsFxGOqMbhIsmPLAW5A9fzCG4
	 MlsuRJj+if2GfC+NRQZ/8O8cLCh715gS/LPQk7yTH+ulwGj00mqvIuBdmq8vZJiRzsR0U
	 ExuI3SrfEx8BGVbrpmbFR9OdjEKkgcXozrsnEOU2Kvh1jNLmpPeGotILwSFdKAQGnRI8k
	 AiAZ13V+DQoxj0di0GslkQr1097GfdzcbvWpUNz3qYubj6EKAzAOJYf9oZhEsfMljIIGj
	 AEOWLnB3GFyDRM6WBRY/ObiuirlqQGLfWPb3faXXv0YXeP3rt1LJM0S97U0Bono1j/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794671793;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9Z3YFFT+4SwUXIGi4O/XCXBAt5O0Gb1PjEAjwURDTF8=;
	b=1I+Gqdi64bO7eNeAxfS7QGO/CNi7BoCSo2zp/xmyIsSsAHR9k2iLeUcyUUHXURo0wY8C
	 wRzjNtoGfIajVKADEdiQtP8JakT420DMu6UKjWMy2MzZ+O9mLE8OZ7ZT4d7g3PdKBBYRY
	 kZWT+ixmtUhXO4YL2108gLnELCwJZQdTY7N23wa0h9JH9WHdQeMnFpapBVE3XQtewNTaY
	 Wnh6fh8gcU7D3Ul+U3B/W8WDP/VDXmluEpAfR3Wn5gd0Bx9Qlk4xTCdwso8sM2LA5TPaQ
	 nQl8ckI4MOqcmMDTOYmuKb58tFfi66cbXEfb2Icysn3Fv4YH/zjpraOjAkiO/kEEzTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Olh30kls;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B6D606A32E
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 15:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Olh30kls
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE54A1F000C6;
	Sat, 14 Nov 2026 15:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794671793;
	bh=9Z3YFFT+4SwUXIGi4O/XCXBAt5O0Gb1PjEAjwURDTF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Olh30klsUXfPZZ6XPBFKJpvs7FzGfSMGfCU9BI1JRBr26ujIJv/xvt8gu0/b8FNSC
	 XPdohrZUiNpwe//I6E8ca8/D/sB1L9f7fYYEGL5aDDpxau9Fh46ly1jVAiiDRwyHUT
	 1lAKIii1yRRQ8XKEpw9wm+rJQZGEGgF1JXk0kh6A2OysZX0WQHMdbWl0sR8jmYzLnS
	 q43SMofgteHCnvyw1LoZo5SLQxQRB4+faMp1H5IBX/9yrXM3GbJG3YgL0vfmqMfYnO
	 vWtZPQGn2b+Jx1RghfvGPE/RqzLwzWbUzXFVqRDvhgFPYf7OJslgeE5VPjqD46G8P/
	 QYtStYo6lGPOw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yingjie Wang <1075151112@qq.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] nvmet: reject keep-alive timeouts that would overflow
Date: Sat, 14 Nov 2026 10:56:31 -0500
Message-ID: <20261114154530.3477922-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202739-failed-5.10-96ae13f40ce5@kernel.org>
References: <20261109202739-failed-5.10-96ae13f40ce5@kernel.org>
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
[ sashal: Adapted controller allocation error handling to return status directly and set req->error_loc. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/admin-cmd.c | 7 ++++++-
 drivers/nvme/target/core.c      | 7 ++++++-
 drivers/nvme/target/nvmet.h     | 8 ++++++++
 include/linux/nvme.h            | 1 +
 4 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 835ff574f80b9..93efea9de3259 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -739,8 +739,13 @@ u16 nvmet_set_feat_kato(struct nvmet_req *req)
 {
 	u32 val32 = le32_to_cpu(req->cmd->common.cdw11);
 
+	if (val32 > NVMET_MAX_KATO * MSEC_PER_SEC) {
+		req->error_loc = offsetof(struct nvme_common_command, cdw11);
+		return NVME_SC_KA_TIMEOUT_INVALID | NVME_SC_DNR;
+	}
+
 	nvmet_stop_keep_alive_timer(req->sq->ctrl);
-	req->sq->ctrl->kato = DIV_ROUND_UP(val32, 1000);
+	req->sq->ctrl->kato = DIV_ROUND_UP_ULL(val32, MSEC_PER_SEC);
 	nvmet_start_keep_alive_timer(req->sq->ctrl);
 
 	nvmet_set_result(req, req->sq->ctrl->kato);
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 61e96097bfe9c..068e490098aa9 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1325,6 +1325,11 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 	int ret;
 	u16 status;
 
+	if (kato > NVMET_MAX_KATO * MSEC_PER_SEC) {
+		req->error_loc = offsetof(struct nvmf_connect_command, kato);
+		return NVME_SC_KA_TIMEOUT_INVALID | NVME_SC_DNR;
+	}
+
 	status = NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;
 	subsys = nvmet_find_get_subsys(req->port, subsysnqn);
 	if (!subsys) {
@@ -1401,7 +1406,7 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 		kato = NVMET_DISC_KATO_MS;
 
 	/* keep-alive timeout in seconds */
-	ctrl->kato = DIV_ROUND_UP(kato, 1000);
+	ctrl->kato = DIV_ROUND_UP_ULL(kato, MSEC_PER_SEC);
 
 	ctrl->err_counter = 0;
 	spin_lock_init(&ctrl->error_lock);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index ef162b64fabef..90bb5352c4cc8 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -7,6 +7,7 @@
 #define _NVMET_H
 
 #include <linux/dma-mapping.h>
+#include <linux/jiffies.h>
 #include <linux/types.h>
 #include <linux/device.h>
 #include <linux/kref.h>
@@ -503,6 +504,13 @@ void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
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
 
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 5727185ffe423..ff756283b9230 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -1485,6 +1485,7 @@ enum {
 	NVME_SC_SGL_INVALID_OFFSET	= 0x16,
 	NVME_SC_SGL_INVALID_SUBTYPE	= 0x17,
 
+	NVME_SC_KA_TIMEOUT_INVALID	= 0x1A,
 	NVME_SC_SANITIZE_FAILED		= 0x1C,
 	NVME_SC_SANITIZE_IN_PROGRESS	= 0x1D,
 
-- 
2.53.0

