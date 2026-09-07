Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F79C23F40D
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 22:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788821168; cv=none; b=XC7Q7aP6ZFSdiSA5Fb5fRMZZwo+ntM2kf0bfU/EYhKQ7vi9467NUNph/EEyQZQm3G7v8I7dPAo091oXBqyUL9diuRz/s6Ock4VmlnC6/zBvpLRyiDxEwDlIyGvCv55lP2FaBVsIKTkAl3+D6BSdbuLbTlOW/03oUC7Az8Cz5V0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788821168; c=relaxed/simple;
	bh=vV79W0FUgvOa9t3wGhjgwiygmJC6fdzS+b+uWI9XmxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RqFODOe4f75jwcGkLp8n0ScBfX3KWXSxBJtqau/iueqATPsnmhU0lskp2cRky6AglA7SmXVkIerS3WsXn1RMPs90A7bP4y5MLMmoUvD4E4ef50/2gtMwC+j4dLrni9IHlXUuYvsGEruCJiY2mmiZn98mpDriRNNIsy6gyx0Jcmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jrpk3gkk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jrpk3gkk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E2591F00A3D;
	Mon,  7 Sep 2026 22:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788821165;
	bh=QMX3ras6w5Qbjeg65nrE63jYrHNaJ5C7iC/YHik/LHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jrpk3gkkj/m1FIw+iDPYHGOMDUtPqDvCVaw41T9T71jLUpFUysZ4b95G0OFxd9wdh
	 AgAVgMUFdGaqNQZSnlLJ6TcJLYgpoG57V2Y6+HNoX+21qxpI38gxqb8sfkXxbSh8yD
	 R2NKCZRTfEJ2E0C22I+LqUwaovIEgllsLBP8UO/Tf0JFsPj83raCG65VyMtQbW5keo
	 zhZUoXjITnnnaFBoL/RAzoCQ4y6ZGtcAnNNhoIPjR+mIsngEgum+rokQrQO41uD2+h
	 13Crfb3oCk2L2aHPpZdEp9UrY+/FuODc3imrqa7V2RRC8P8sEj1h4M7oCWE8zU8EAG
	 YwO3Zl/vfE5oQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>,
	NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/4] NFSD: Prevent client use-after-free during delegation revoke
Date: Mon,  7 Sep 2026 18:46:00 -0400
Message-ID: <20260907224603.689417-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090331-qualm-umbilical-2cdb@gregkh>
References: <2026090331-qualm-umbilical-2cdb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <cel@kernel.org>

[ Upstream commit 4683ca76b3b7e5808338491c6eb3c20e6b4894d5 ]

A delegation stateid holds only a bare pointer to its owning
nfs4_client and does not keep it alive.  The client survives its
stateids only because __destroy_client() drains cl_delegations and
cl_revoked before free_client() runs.

nfs4_laundromat() breaks that invariant: it unhashes an
expired delegation from cl_delegations, drops deleg_lock, then
revoke_delegation() relinks it onto cl_revoked under cl_lock.  In that
window the delegation is on neither list, so client_has_state() can
report no remaining state.

Every teardown path first requires cl_rpc_users to be zero, but
the laundromat holds no such reference.  A client whose recalled
delegation has just timed out can therefore reach free_client()
while revoke_delegation() is still about to dereference cl_lock,
a use-after-free.

Pin the client with cl_rpc_users across the revoke so teardown blocks
until it completes, then reap the delegation from cl_revoked.  A client
already expiring reaps its own, so skip it and leave the delegation on
del_recall_lru.

Fixes: 3bd64a5ba171 ("nfsd4: implement SEQ4_STATUS_RECALLABLE_STATE_REVOKED")
Cc: stable@vger.kernel.org
Reviewed-by: NeilBrown <neil@brown.name>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Link: https://patch.msgid.link/20260709-cel-v4-2-1d519d9be0cb@kernel.org
Signed-off-by: Chuck Lever <cel@kernel.org>

[ sashal: Reduced backport -- upstream 4683ca76b3b7e touches 2 file(s), this
  backport carries 1. Not backported here:
  fs/nfsd/netns.h
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: 9026932ac8be ("NFSD: Prevent client use-after-free during blocked-lock reaping")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4state.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 48715a55df8fa..b24fc96b72fa0 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7052,6 +7052,7 @@ nfs4_laundromat(struct nfsd_net *nn)
 		.new_timeo = nn->nfsd4_lease
 	};
 	struct nfs4_cpntf_state *cps;
+	struct nfs4_client *clp;
 	copy_stateid_t *cps_t;
 	int i;
 
@@ -7080,6 +7081,18 @@ nfs4_laundromat(struct nfsd_net *nn)
 		dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
 		if (!state_expired(&lt, dp->dl_time))
 			break;
+		clp = dp->dl_stid.sc_client;
+		spin_lock(&nn->client_lock);
+		if (is_client_expired(clp)) {
+			spin_unlock(&nn->client_lock);
+			continue;
+		}
+		/*
+		 * Pin without reviving: get_client_locked() would
+		 * flip a courtesy client back to NFSD4_ACTIVE.
+		 */
+		atomic_inc(&clp->cl_rpc_users);
+		spin_unlock(&nn->client_lock);
 		refcount_inc(&dp->dl_stid.sc_count);
 		unhash_delegation_locked(dp, SC_STATUS_REVOKED);
 		list_add(&dp->dl_recall_lru, &reaplist);
@@ -7088,8 +7101,18 @@ nfs4_laundromat(struct nfsd_net *nn)
 	while (!list_empty(&reaplist)) {
 		dp = list_first_entry(&reaplist, struct nfs4_delegation,
 					dl_recall_lru);
+		clp = dp->dl_stid.sc_client;
 		list_del_init(&dp->dl_recall_lru);
 		revoke_delegation(dp);
+		/*
+		 * Unpin without renewing: put_client_renew() would
+		 * renew the reaped client's lease.
+		 */
+		if (atomic_dec_and_lock(&clp->cl_rpc_users, &nn->client_lock)) {
+			if (is_client_expired(clp))
+				wake_up_all(&expiry_wq);
+			spin_unlock(&nn->client_lock);
+		}
 	}
 
 	spin_lock(&nn->client_lock);
-- 
2.53.0

