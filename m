Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39FA36197A
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 02:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788660807; cv=none; b=EJUQ2AKuq9JY7YGfhY7PdOCx7BFDkDNuFOUnTntOPvywxVzvvmu+igYBwDCswjb+kiVFFxw/bVLqLUqNXLlE2vcWMXiF428WJK9ACnYUKxXkYZAJKLePIEd2UT9BK+sSRIMT1YY2wavLqG6dKk5/4h4O10UI786NhPykCeu9yiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788660807; c=relaxed/simple;
	bh=jpGmqIREWGtEOt3eGEVqqdVgtxHgPJhrAKmN0O3cV/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jQVZaYp0pfl+jSeQRC1Nut/YualkUgK3MrtrlAD7lWpWPLHYwhAWK8eGYxsJymA6rGZu1J2Cpg4D5o4i0q1zx1Tt+YSGN6snK8i6ihDECVG17XGRAVSXUJvppbpzxfvcT7IXiJjUenjYkC3A2K+1KaUcROTZNjhKFpJF4g+GqIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gTHWySbN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gTHWySbN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3A511F00A3D;
	Sun,  6 Sep 2026 02:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788660803;
	bh=Cfx0U+c9BmLaw9jjovuAxfg8nj7upIQicKl4FSNPkx0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gTHWySbNYtoG1Wzp8McMTM7V+H2wnVFJAGK3Pjb7b3K6cwsR4bje48Mkr33nE9mwE
	 MWqjb0MeYYFf5r2XcTU46ZRWeqLuAF93cDe2ObVxYbqwrb3WwzTKXBS8GgCrQtTDvm
	 HvjM+mhxVxDKf6zmdrbyR/VGIXQJiAOQwft0SrTkHc04D/xOu3W9ootfuQAbwdmxSN
	 IvxEPYUxNrVly/IF2DV5pyk8FKDGQMlmXK9TWwlwwcXPNZHJAlx073PSdhePLpkxEV
	 pDU8n1AFopnQOe0AuKV86NxAHulzHT2cI25XW+tP1T8CZCiG+JDj9lrSCMrI+8/hjG
	 s37M17WvvJ6fA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/7] nfsd: prepare nfsd4_cb_sequence_done() for error handling rework
Date: Sat,  5 Sep 2026 22:13:15 -0400
Message-ID: <20260906021321.760525-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090303-scrap-parkway-2bf7@gregkh>
References: <2026090303-scrap-parkway-2bf7@gregkh>
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
 fs/nfsd/nfs4callback.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 272d3facfff9d..f9c28ba1d986b 100644
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
@@ -1192,6 +1193,7 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 		 * (sequence ID, cached reply) MUST NOT change.
 		 */
 		++session->se_cb_seq_nr;
+		ret = true;
 		break;
 	case -ESERVERFAULT:
 		++session->se_cb_seq_nr;
@@ -1199,13 +1201,11 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 	case 1:
 	case -NFS4ERR_BADSESSION:
 		nfsd4_mark_cb_fault(cb->cb_clp, cb->cb_seq_status);
-		ret = false;
 		break;
 	case -NFS4ERR_DELAY:
 		cb->cb_seq_status = 1;
 		if (!rpc_restart_call(task))
 			goto out;
-
 		rpc_delay(task, 2 * HZ);
 		return false;
 	case -NFS4ERR_BADSLOT:
@@ -1227,14 +1227,13 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
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

