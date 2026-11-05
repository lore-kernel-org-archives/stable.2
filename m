Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793840043;
	b=r+CQoUGBc+NTj8VN7QbUH7rLWF7KQWVOjA4UXsRxEBhlEvhHGq7TgjQsbaklJH/4RIWB
	 GHcGvGScCaPtUlxIOy1wnUp76r6Kk7uv42xYXa7cUWC2+cqsJ0fqlksGBcBPYK/ZincwN
	 EKFwVZ4WspwzqNE92hrDFqZsvsiL5ldZXVt87aEOb4CfhcDMh7HLRyRzXCpvb33frnSKI
	 aGI46i+NvAytU0+XWqadA6uegTzH3de2Cb4cSWhR0LSFlQH2Q34T/z/7zLneerQgoS1SX
	 LWvQSBTluAZnZLx41flV2ktzDsuWB9x/BplnPzZfCKMm7O5xR7tozIM7ywFSTxql1nA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793840043;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=wViPhOjq/8wN8w2mhof4f2V3TSt9iqpVFRTzuF4Em7E=;
	b=w7glP+DNeIa2PKKqSjzcF4H3DnNMSbrJw4IwAdQKbPSwC6+mJCa4gJPRajAOYEcEIMbG
	 V/Z8d+RQ/yeZQxfwHeCMOFnMM6DucWe+OL2r6DfIZzWoKpdvfjJ8D2dBquqz93fdGFT6a
	 S4XlUTthIGR58O+vdjU+CX5Vn0f5qkeDK+NdLRrrxa20HJQaI7MZYdGA9kwg34zjS2YBg
	 gOA7x23BO4jHDBipV2ZZMhwFY+nIqjPUmkM4F/f5Rl3ktzcr8K+HwHEJZcF9cDkPAmhvm
	 c9WOUhrfDZhctIwuagSQPS6rV6qfUpRxIjzJq0PZihGDZY1HjR63Q6dqJUbwcRzidnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="V3t/5urG";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F2C60A2616
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 00:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V3t/5urG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 460401F000C1;
	Thu,  5 Nov 2026 00:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793840043;
	bh=wViPhOjq/8wN8w2mhof4f2V3TSt9iqpVFRTzuF4Em7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V3t/5urGzjpC4oLCcKKhmgJg7hHoq3KB2ybJr+51GF+tF+M/3ruvUJ4XmSaXqSLb0
	 3wE50cZCHN3DoHl1w8lzeRbhNDUGUSTzzsg1v5I6CvW2hG4mgNUJ3jkF3BpCpBK4bS
	 wXM/jKUIFsiiJLiv8t/GtEWErqDn62ZrqFE5fvW3UQqqs2jJuxmuPht24Z+r/XmG6y
	 f6CKCEN9ox7y3yLH46eQaWvYna7mAxsOlC5bom5Z0zrRiond3NdQ3WRwRQ1ef6Z7Zt
	 OQ9aigva5Tr/wVuuv2PBKfCJfyZu69hLValjbfttrP0NLpVGZo8FiBJXy/3SPVCLCo
	 HkelHLwpd+IIQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Marco Crivellari <marco.crivellari@suse.com>,
	Tejun Heo <tj@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] nvmet: replace use of system_wq with system_percpu_wq
Date: Wed,  4 Nov 2026 19:53:59 -0500
Message-ID: <20261105005352.1068956-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110454-fasting-overlaid-def6@gregkh>
References: <2026110454-fasting-overlaid-def6@gregkh>
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

From: Marco Crivellari <marco.crivellari@suse.com>

[ Upstream commit 3d553be6d295b6cca8fd35cb673fd13934ac4cbc ]

This patch continues the effort to refactor workqueue APIs, which has begun
with the changes introducing new workqueues and a new alloc_workqueue flag:

   commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
   commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

The point of the refactoring is to eventually alter the default behavior of
workqueues to become unbound by default so that their workload placement is
optimized by the scheduler.

Before that to happen, workqueue users must be converted to the better named
new workqueues with no intended behaviour changes:

   system_wq -> system_percpu_wq
   system_unbound_wq -> system_dfl_wq

This way the old obsolete workqueues (system_wq, system_unbound_wq) can be
removed in the future.

Link: https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/
Suggested-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Stable-dep-of: 53f6efe00cea ("nvmet-auth: serialize access to DH-HMAC-CHAP state to fix UAF")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/admin-cmd.c        | 2 +-
 drivers/nvme/target/fabrics-cmd-auth.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index fa9920787a8ff..623b5303de2aa 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -1606,7 +1606,7 @@ void nvmet_execute_keep_alive(struct nvmet_req *req)
 
 	pr_debug("ctrl %d update keep-alive timer for %d secs\n",
 		ctrl->cntlid, ctrl->kato);
-	mod_delayed_work(system_wq, &ctrl->ka_work, ctrl->kato * HZ);
+	mod_delayed_work(system_percpu_wq, &ctrl->ka_work, ctrl->kato * HZ);
 out:
 	nvmet_req_complete(req, status);
 }
diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index 5b010318286e4..af712c6624b36 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -410,7 +410,7 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 	    req->sq->dhchap_step != NVME_AUTH_DHCHAP_MESSAGE_FAILURE2) {
 		unsigned long auth_expire_secs = ctrl->kato ? ctrl->kato : 120;
 
-		mod_delayed_work(system_wq, &req->sq->auth_expired_work,
+		mod_delayed_work(system_percpu_wq, &req->sq->auth_expired_work,
 				 auth_expire_secs * HZ);
 		goto complete;
 	}
-- 
2.53.0

