Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C0B1FD4
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 13:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788701316; cv=none; b=sC15cvO4zFLE5cHDcrojA+iK1Roa9jhjaaicr87AhPhbLBtzQLWliWVkbht7o2wh2ZEobpnRFzwsudeh8HfIqNuYEv/rC7l22OiyA3K2ICkXGrjqJYXv4MFDyIDE3YV9zdcbmcy1QPsHC+rtlt7g6IOtW6W0RADECzBQEm4pO/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788701316; c=relaxed/simple;
	bh=l598SM+AxpiQfVqC3n9uJG1waNr6gdZlZ+8VsgPluSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c/88hoDbR/nA1b8dtLqSoWXnVudBs7k8//m6I4Oh7Oqsoz2AMHfdEr2AebtRI8lju40fFrUaBPmw50W+fUEiFArJytK/kFyTbUJMAyj67LX7uYJVpNV0dYMFaHOekCZvN/SDdH9kfxoLU4oVX9QYE2HqzFwCLFJnhD/22JGxk94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eDMJGYjs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eDMJGYjs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDB731F00A3A;
	Sun,  6 Sep 2026 13:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788701314;
	bh=3xjPZwbGiJ/Cel77mvIhqiW4iRewFh5Djy59Umr4QJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eDMJGYjs2nLdNc06eezh9OywEXQ3V09xHSKlCTMn2Lgsh4kcfGElPszR+ienzU1LV
	 FjUi56vUlcDtE4jAPH5wd96cns/3yiBpMiJwg2CT6kFohsXnw1JnSfhcOTbbgflz6B
	 2e7YSoS1sun7cBqwslYoyScPN7tGpFT4p0W9AmHB7B+UZZg4FydRi8jsDn18O/iOQi
	 D1uNl8TYnmyK0HeVuQtWgyeESmAtcUHJA5yopfBS5a/5DgAtBo0el5sY+MoYMnq97g
	 /oVlEXfRphdsLk7aZymCgVtrYBEnBTWy5ThcxXkMSacNiuag8mNgak/go07myghxDZ
	 0IGCphyfUPROw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/7] nfsd: prepare nfsd4_cb_sequence_done() for error handling rework
Date: Sun,  6 Sep 2026 09:28:25 -0400
Message-ID: <20260906132831.874344-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090304-heroism-outclass-581e@gregkh>
References: <2026090304-heroism-outclass-581e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit 1c2d0957dc66620338eba63e0267122b6e2175cc ]

There is only one case where we want to proceed with processing the rest
of the CB_COMPOUND, and that's when the cb_seq_status is 0. Make the
default return value be false, and only set it to true in that case.

Rename the "need_restart" label to "requeue", to better indicate that
it's being requeued to the workqueue.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Stable-dep-of: 01c5d5f58a5d ("nfsd: RCU-protect cl_cb_session to fix use-after-free on session teardown")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4callback.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 272d3facfff9d..8f296543880f6 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1157,11 +1157,12 @@ static void nfsd4_cb_prepare(struct rpc_task *task, void *calldata)
 	rpc_call_start(task);
 }
 
+/* Returns true if CB_COMPOUND processing should continue */
 static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback *cb)
 {
 	struct nfs4_client *clp = cb->cb_clp;
 	struct nfsd4_session *session = clp->cl_cb_session;
-	bool ret = true;
+	bool ret = false;
 
 	if (!clp->cl_minorversion) {
 		/*
@@ -1174,13 +1175,13 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 		 * handle that case here.
 		 */
 		if (RPC_SIGNALLED(task))
-			goto need_restart;
+			goto requeue;
 
 		return true;
 	}
 
 	if (!cb->cb_holds_slot)
-		goto need_restart;
+		goto requeue;
 
 	switch (cb->cb_seq_status) {
 	case 0:
@@ -1192,20 +1193,20 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 		 * (sequence ID, cached reply) MUST NOT change.
 		 */
 		++session->se_cb_seq_nr;
+		ret = true;
 		break;
 	case -ESERVERFAULT:
 		++session->se_cb_seq_nr;
-		fallthrough;
+		nfsd4_mark_cb_fault(cb->cb_clp, cb->cb_seq_status);
+		break;
 	case 1:
 	case -NFS4ERR_BADSESSION:
 		nfsd4_mark_cb_fault(cb->cb_clp, cb->cb_seq_status);
-		ret = false;
-		break;
+		goto requeue;
 	case -NFS4ERR_DELAY:
 		cb->cb_seq_status = 1;
 		if (!rpc_restart_call(task))
 			goto out;
-
 		rpc_delay(task, 2 * HZ);
 		return false;
 	case -NFS4ERR_BADSLOT:
@@ -1227,14 +1228,13 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 		clp->cl_cb_session->se_cb_seq_nr);
 
 	if (RPC_SIGNALLED(task))
-		goto need_restart;
+		goto requeue;
 out:
 	return ret;
 retry_nowait:
-	if (rpc_restart_call_prepare(task))
-		ret = false;
+	rpc_restart_call_prepare(task);
 	goto out;
-need_restart:
+requeue:
 	if (!test_bit(NFSD4_CLIENT_CB_KILL, &clp->cl_flags)) {
 		task->tk_status = 0;
 		cb->cb_need_restart = true;
-- 
2.53.0

