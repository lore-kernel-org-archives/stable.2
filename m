Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D6B3F4827
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 20:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788812329; cv=none; b=TjLbTTSfyvT736/jdSh1Cly1FxNLLIw2vD1ZFht4h209IkPidlgGaw1Ei5oYrjz65KYRZciEFSsI9cUzEVwY4/OHDsjc+GZw3FYMh3Aovt9vDRMDzYlB7ZsVmQvUxB18p8vol1g6a6Sd8ETzF+6SPF0JXO5l0ybvxXaxgx+jfsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788812329; c=relaxed/simple;
	bh=O20JEm9hIeKP6jIAlmLwL6z6KIRoOZUZMztQpCSjt5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pcHs0KxTxlIJtmPJ5JA9lV70ZQziber13YxcgCLcU4Xj7d8nmMihHpVzH9MKS2PqSkc6NbjWP5fTqzYI5lPpQVNh3HW6tpFegmVwLpnQFR52enRVMKDyus9MXst/ekBjd20MHe/DHPoB8WmljXyCyJOXz9MVju3/mB9uKWY9Y0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7dXkefZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M7dXkefZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5D111F00AC4;
	Mon,  7 Sep 2026 20:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788812328;
	bh=GNAUyZDpPBzekX16pO+iKcGr142jRyXXvMzPk8Aa+2U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M7dXkefZcBQ+8TUFV63+D9sh/8NCCWMK4Jbke+Gq64QRu1pzeUjVRJsXg4dG1mYXD
	 Q/Ue/gZka+Ufr0bIn1nIupgm+wyax/01UqN1nEPBbokmoO1vG1awJcMJVN4JLX7+IK
	 4ya4JuSXPMX0MyW8ZtIafMDQxvd9C7ZcAYOuitZuFe8YwWEpnrNQYALdbfrlmTDS8T
	 Y4v0Mib0YdD11JmW3cPEpZjYL5OsfHEhT9O3xtcIe/2g462IsgAbz9KSGbm0B1hDcz
	 UFsEWYUyia0puTlbXj3Ltb/Yp9v50bjie9IphjzBKRgswa4PGK1EHOtLNpqUvi8RGF
	 irFTUi6W9eChQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>,
	NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 3/6] NFSD: Prevent client use-after-free during export state revocation
Date: Mon,  7 Sep 2026 16:18:41 -0400
Message-ID: <20260907201844.381343-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907201844.381343-1-sashal@kernel.org>
References: <2026090304-open-erasable-9a07@gregkh>
 <20260907201844.381343-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <cel@kernel.org>

[ Upstream commit 2108de53568a64936a0da3e04d85c35df98d3fb6 ]

nfsd4_revoke_export_states() has the same use-after-free as
nfsd4_revoke_states(): it drops nn->client_lock across
revoke_one_stid() and the following read of clp->cl_minorversion, but
the stateid reference it holds does not pin the client.  A teardown
racing the dropped lock can free the client while revoke_one_stid()
still dereferences it.

exportfs -u drives this path through NFSD_CMD_UNLOCK_EXPORT, so an
administrator removing an export can race a client expiry.

Skip a client that is already expiring and otherwise pin it with
cl_rpc_users under client_lock before dropping the lock, matching
nfsd4_revoke_states().

Fixes: 2eac189bb059 ("NFSD: Add NFSD_CMD_UNLOCK_EXPORT netlink command")
Reviewed-by: NeilBrown <neil@brown.name>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Link: https://patch.msgid.link/20260709-cel-v4-4-1d519d9be0cb@kernel.org
Signed-off-by: Chuck Lever <cel@kernel.org>
Stable-dep-of: 2330b788d732 ("NFSD: Prevent client use-after-free during close_lru reaping")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4state.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 8b0feceee5ac6..fd97042abbb2e 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1973,10 +1973,14 @@ void nfsd4_revoke_export_states(struct nfsd_net *nn, const struct path *path)
 		struct nfs4_client *clp;
 	retry:
 		list_for_each_entry(clp, head, cl_idhash) {
-			struct nfs4_stid *stid = find_one_export_stid(
-							clp, path,
-							sc_types);
+			struct nfs4_stid *stid;
+
+			/* Skip or pin clp as in nfsd4_revoke_states(). */
+			if (is_client_expired(clp))
+				continue;
+			stid = find_one_export_stid(clp, path, sc_types);
 			if (stid) {
+				atomic_inc(&clp->cl_rpc_users);
 				spin_unlock(&nn->client_lock);
 				revoke_one_stid(nn, clp, stid);
 				nfs4_put_stid(stid);
@@ -1984,6 +1988,9 @@ void nfsd4_revoke_export_states(struct nfsd_net *nn, const struct path *path)
 				if (clp->cl_minorversion == 0)
 					nn->nfs40_last_revoke =
 						ktime_get_boottime_seconds();
+				if (atomic_dec_and_test(&clp->cl_rpc_users) &&
+				    is_client_expired(clp))
+					wake_up_all(&expiry_wq);
 				goto retry;
 			}
 		}
-- 
2.53.0

