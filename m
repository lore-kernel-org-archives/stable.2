Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793840341;
	b=xDv695Jsabr2wTjzBZc28gEm2iQvbM48T8YCXTn0AKvzihJTUb8ndH8wlV570ho9eArN
	 AhsvdciOFPLJmIH4Q0BuhaXblgfO6ByRZ7UMbVkj2l5zGubqyeeMSA29GTu4x5lH/QOKO
	 bNEva+CJbxx4/ZUGUIdEEyfDZDlxtOq94JuleDb/wvPpZ8ye0lPC+LCVoXObYrfNu1htN
	 +f2/LBuEpxqpZTQ+pm4RtYLMd1tqqwr5RwRCkXHy10idiG9jpQ0gi3lIY8s+HgMVk//nc
	 y1AytHroawYPjaH9KfI/9p/ITYYsPs4+83XFDVML8tAMtuXXl1eDhYEmG4bAgOpvlUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793840341;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ketT6ZDmiKHVFAGhVkr2NeYUq3ygqUz1KT6Jlh9+2mg=;
	b=PpNf6UhCxepLIWXoIVa83nOuP0jneB3/DU48tnMATigutAHvkSBcBk4/6n6xWThqnNof
	 MPyDM/CpgZSS32Qz8lLMBjNnUREPpknZbODIhu6NP8PDw+DFsAvoRvftCSCugBOavf1+2
	 PW9RYbHJs+mrFaW+wC5JO3KzaqhMJK6JBdoqJifTY0I59kbA3zcnPtZ0hEldPi2yPguTz
	 WWHJd6ih+q6mS6TxWqQrVI8ojWSFys1XSw+ZqEhJmSPfdBrRWJ2tZtmcaDoRaqmSsCcfQ
	 Arr3yj4L+6pzcZefUW8FWe7IwUXs5AljJMrQAlkC7kmOGtl1xoj8CQLobW0ik+0E45g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="InYO/Mq7";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC253606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 00:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=InYO/Mq7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E811F000C1;
	Thu,  5 Nov 2026 00:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793840340;
	bh=ketT6ZDmiKHVFAGhVkr2NeYUq3ygqUz1KT6Jlh9+2mg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=InYO/Mq784uPSHHwYX88WV0nmEWD5hos1ArC3jiyRbL+HRSmnDSQsXQrciBz9i2Ii
	 aypCSJDSaphE7puvpIG22Za65G0FWcYbxSp8Se+5Kvn9xiLz4JwR+fr0gDA+HK7z33
	 RxEqG70FLGKYODfOKM4LU9YvzyijLsIeHWPm+9rABBAjLEx+CrW69hdcU6hoIUh31F
	 3M/JGsTM5DjeylSWXZBkC5Z/tY1TQ1X88aDiLrO2bTTrD8FG5QY8qyafQZEQCI57Tk
	 cWHXwxHADUvfeyZQGggHWsjeFikjRbfEK2kxjlfHjzESF9Y4ivopwHJIFRhZuRYpFU
	 0Bgh24IJwTrqw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Marco Crivellari <marco.crivellari@suse.com>,
	Tejun Heo <tj@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] nvmet: replace use of system_wq with system_percpu_wq
Date: Wed,  4 Nov 2026 19:58:57 -0500
Message-ID: <20261105005847.1079856-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110455-poet-brute-7114@gregkh>
References: <2026110455-poet-brute-7114@gregkh>
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
index 72a5de1f8252d..c8ff53faddbc3 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -1003,7 +1003,7 @@ void nvmet_execute_keep_alive(struct nvmet_req *req)
 
 	pr_debug("ctrl %d update keep-alive timer for %d secs\n",
 		ctrl->cntlid, ctrl->kato);
-	mod_delayed_work(system_wq, &ctrl->ka_work, ctrl->kato * HZ);
+	mod_delayed_work(system_percpu_wq, &ctrl->ka_work, ctrl->kato * HZ);
 out:
 	nvmet_req_complete(req, status);
 }
diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index 83571f5a50d99..92e75ebe7a173 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -360,7 +360,7 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 	    req->sq->dhchap_step != NVME_AUTH_DHCHAP_MESSAGE_FAILURE2) {
 		unsigned long auth_expire_secs = ctrl->kato ? ctrl->kato : 120;
 
-		mod_delayed_work(system_wq, &req->sq->auth_expired_work,
+		mod_delayed_work(system_percpu_wq, &req->sq->auth_expired_work,
 				 auth_expire_secs * HZ);
 		goto complete;
 	}
-- 
2.53.0

