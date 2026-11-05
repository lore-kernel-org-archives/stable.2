Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793840707;
	b=0VAQQgIAqFeoasgDHGYH7MS3ttPK7Bcc+Cz66gqDNxrRJWV6m2gW4UP0yK0P10G1UUfQ
	 iw5rlc9OXzYn3Y18aRsdtz/FGA/kIBW7Cm6ziMGRruYIWF8pfhwcPncC8meZJ3kEMH7lb
	 MMGNrkF7HxyPLohRPX/OfCNc29s7lQX64yHQIdrI428mZW9+5bHUNbp5YR1byimjFRMp+
	 EKaEg8dPgRlEzeDKNz5k/KN62tlqXim8J3hIQ6hviD0s97hmN5bGmmvwIsE0ADN+fyJW8
	 QLlCVjZkdSukFPQApVCtZhXTUnM4yl72kufpvfeno9nBbpAk12YYAi6cNrcfpwu4sXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793840707;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=MWlNlw6XmCbiquU6w32v77lpoINmQMjmlV7MJttFxSg=;
	b=MqxE8uzyd1yH62qdZxe0EAzukB5DHEjcO7Dr/KLmePv2l7tty/jtrEykZJWRRU0mlcP2
	 GHMjrZnlLI3Eb96MQx/Qr0Zi3YUvILNZHUxcL7Nb7vOGKWtT+Yb6gvyXwU57l2se9baUD
	 qZaTT3S+VRKAhjhOLhcQz1doR9ZVAk4hIeAHZyCW/siYmxZ7YcaP3W5vJjvP+rCUzgtSh
	 a57U70axtS6mNx2JnIakhe7Tog+XlfN+YU1iUE8zRZX6EU7SazTOYcKvBdbQ9B393Nz16
	 PHqpARikdlMLvXJ1T81sekxu5TKd3FI4ivsb8J25Ge6ltgbQRAlDODHoKmdc5mBpb7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="R1j/st+D";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEB4606A337
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 01:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R1j/st+D
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 552831F0093A;
	Thu,  5 Nov 2026 01:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793840707;
	bh=MWlNlw6XmCbiquU6w32v77lpoINmQMjmlV7MJttFxSg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R1j/st+DbdLCcY4cFe6YWoSCc9O3o0J9yqOA/wkZlSNEzF7nCdyat5KupEGfeKAP/
	 MJHcGIu/SMqBDsk0bjhq4JuTEQRYPZ0+RReGYuqMzET+nKYoI6+iJEmJtJFesTYh1e
	 yB0GODskzIfgUiDnlGQqIW2zKcudR6+y2T6v6uaEVTATm2GvP3DPSvxJTKwXw/lBSe
	 KMqLteekndde07u9vInUCI7Tdbp++kGi664TZBBia1p/smBtN53STsROKxCppI9qlU
	 6mxWH675P/p9vJVFnWa9aq2bsnxZr0h4rY/vbVrH0+AZMd8tXKokm3NrViDvmkYY3M
	 u71w4QCLRUQaA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Marco Crivellari <marco.crivellari@suse.com>,
	Tejun Heo <tj@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] nvmet: replace use of system_wq with system_percpu_wq
Date: Wed,  4 Nov 2026 20:05:04 -0500
Message-ID: <20261105010458.1097143-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110458-chariot-kinfolk-545d@gregkh>
References: <2026110458-chariot-kinfolk-545d@gregkh>
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
index c974beefa766b..32f01c00dc416 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -993,7 +993,7 @@ void nvmet_execute_keep_alive(struct nvmet_req *req)
 
 	pr_debug("ctrl %d update keep-alive timer for %d secs\n",
 		ctrl->cntlid, ctrl->kato);
-	mod_delayed_work(system_wq, &ctrl->ka_work, ctrl->kato * HZ);
+	mod_delayed_work(system_percpu_wq, &ctrl->ka_work, ctrl->kato * HZ);
 out:
 	nvmet_req_complete(req, status);
 }
diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index 25a3a927ae231..8d97ced8b1d19 100644
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

