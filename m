Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C3037C91B
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 03:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788578916; cv=none; b=S/X1PZqDvpnjA86xn/yxY5lG7tzR9FXelsF0708wWdL+T/abhugQWhir0SV6C4xBK5EpjxK/iftg4gj3AQMQ31A9+4e1ImXmnvDbnlv6dE/UdZcAR8Jw+BzOeW4TJraKtMljjpHXAEguECrHLFZKLZZZsm+ZkAq8mbP30z1eUqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788578916; c=relaxed/simple;
	bh=IMJmaL9WYnCx0MKoEFZ1ukWTRV+x8Kvlpt/MB5l+Z5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uuJ2JV2j/RB7yhAvxsHnm+BooBp4CT7lmXeQqI6HZvtQ/5GatvPf8m1UPmJoMAlSiyO2XE3cbS2SYfu2o22y+XdHJjaodS21wiRrUfxXzFzLoIocXFeA66sVvCJuWpQobnlrilnWMlYzJKTOV1Gtx5C25R0lAthx6//9ofh2+QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e50+PIMK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e50+PIMK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 662231F00A3E;
	Sat,  5 Sep 2026 03:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788578915;
	bh=A9A+NOyR5m/3bd51pN04Foxq/KBVTsZ0+CDQJg8FmbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e50+PIMKJzrHR5X1LCvtnkZj+TcrTfb51A4c7avNN3rs6wJbdbKK4RbyNVy1f0xMi
	 ca6feDhr691uNtYvSfLsLPziTmzLumEAYflK2B4yK3p/oLKQuEMKSCtLZ1/BF/0ndS
	 sAh/HLin2HeL1UPNYK5yHvvUT00zi+IVDa8GYL8lQfrogSUbHhzkjK7bKFMYubagld
	 3y7eGY6GCi5DIZEF7SeRL5h2+VZAD04yc+x08r8UpL1604YQiqy/WhPnxvQZRtydF9
	 CI/anrIdrCVwFlr5dXP4ZUqC34uOaF+tPSmoL5dxZDkjZFmOPwyVs+ydiqNnALskPI
	 uMKzlWGe6y24A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: NeilBrown <neilb@suse.de>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/7] nfsd: don't call functions with side-effecting inside WARN_ON()
Date: Fri,  4 Sep 2026 23:28:27 -0400
Message-ID: <20260905032830.1915148-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260905032830.1915148-1-sashal@kernel.org>
References: <2026090305-dowry-plaster-fff3@gregkh>
 <20260905032830.1915148-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neilb@suse.de>

[ Upstream commit c6540026dfe68b2cc6b6891404f8efa7c40e53e9 ]

Code like:

    WARN_ON(foo())

looks like an assertion and might not be expected to have any side
effects.
When testing if a function with side-effects fails a construct like

    if (foo())
       WARN_ON(1);

makes the intent more obvious.

nfsd has several WARN_ON calls where the test has side effects, so it
would be good to change them.  These cases don't really need the
WARN_ON.  They have never failed in 8 years of usage so let's just
remove the WARN_ON wrapper.

Suggested-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neilb@suse.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Stable-dep-of: ca94ba361720 ("nfsd: fix BUG_ON in nfsd4_alloc_layout_stateid on racing delegation revoke")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4state.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index f21878a7f3939..3def9f493e12b 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1605,7 +1605,7 @@ static void release_open_stateid_locks(struct nfs4_ol_stateid *open_stp,
 	while (!list_empty(&open_stp->st_locks)) {
 		stp = list_entry(open_stp->st_locks.next,
 				struct nfs4_ol_stateid, st_locks);
-		WARN_ON(!unhash_lock_stateid(stp));
+		unhash_lock_stateid(stp);
 		put_ol_stateid_locked(stp, reaplist);
 	}
 }
@@ -2244,7 +2244,7 @@ __destroy_client(struct nfs4_client *clp)
 	spin_lock(&state_lock);
 	while (!list_empty(&clp->cl_delegations)) {
 		dp = list_entry(clp->cl_delegations.next, struct nfs4_delegation, dl_perclnt);
-		WARN_ON(!unhash_delegation_locked(dp));
+		unhash_delegation_locked(dp);
 		list_add(&dp->dl_recall_lru, &reaplist);
 	}
 	spin_unlock(&state_lock);
@@ -6250,7 +6250,7 @@ nfs4_laundromat(struct nfsd_net *nn)
 		dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
 		if (!state_expired(&lt, dp->dl_time))
 			break;
-		WARN_ON(!unhash_delegation_locked(dp));
+		unhash_delegation_locked(dp);
 		list_add(&dp->dl_recall_lru, &reaplist);
 	}
 	spin_unlock(&state_lock);
@@ -8065,7 +8065,7 @@ nfsd4_release_lockowner(struct svc_rqst *rqstp,
 		stp = list_first_entry(&lo->lo_owner.so_stateids,
 				       struct nfs4_ol_stateid,
 				       st_perstateowner);
-		WARN_ON(!unhash_lock_stateid(stp));
+		unhash_lock_stateid(stp);
 		put_ol_stateid_locked(stp, &reaplist);
 	}
 	spin_unlock(&clp->cl_lock);
@@ -8380,7 +8380,7 @@ nfs4_state_shutdown_net(struct net *net)
 	spin_lock(&state_lock);
 	list_for_each_safe(pos, next, &nn->del_recall_lru) {
 		dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
-		WARN_ON(!unhash_delegation_locked(dp));
+		unhash_delegation_locked(dp);
 		list_add(&dp->dl_recall_lru, &reaplist);
 	}
 	spin_unlock(&state_lock);
-- 
2.53.0

