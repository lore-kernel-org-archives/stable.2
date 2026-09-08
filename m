Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8BD245005
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 01:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788830053; cv=none; b=NW/OjLJn8CjBTjIVnZaTKeYoHGHZR4bMREGePXz1Se1urUshIBF+MWlDCpfL/K9VD/xCp/hidU3BMs46Rz7dHDcjGcXRjvBGCetMBdMGrjl9iCSENmxuJRPibh1qMpAxWzE0V09J6UPbgtVnuN95UM7wiYEwqfJqt4NFCLxNA4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788830053; c=relaxed/simple;
	bh=C/n59qmLVLvF5UcYUG+jdRQ2WRCcc0HCxK08qTGpW10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mr5MPUNr6VbDSHZmNjRFH6jlw3e0TyFkv6BPiVT6+dL9fPqR2tFoL3hW7WPQGP6HFXJFsr90xA/jJdEOtx4/F2P37nZmytZsrCULyt3Tmp0j/OrY4aLEUUusd8RZESxUOPupNt9VFjLOj5a060oKDQHxssjrKsgwq/IIthedNTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQedY5dL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQedY5dL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07B511F00A3F;
	Tue,  8 Sep 2026 01:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788830052;
	bh=aoPsSCYIai4poUNeUQ5bVyi9puJujKZECOrmRV4QQ4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aQedY5dLKXdy1f95nTuPFNlcWOyoX5DrFtCNgILzN3A+egGqXeEIJ8lmozwbdFGV3
	 wNWTrZAXpbqTDFznRWSNAHzR6xtkZUEIMxOMpkwAoi3On4Yo9EEQDnShsyKNQ+uXLt
	 T6M/nwlBmeQc90nxY/cZKE6XbHPNCmMFQ4ZDcZwFWuojJ34JDwjmhKAqddHbSQBwsd
	 MyDhTqjqdTtuuf0C0wvJ9VHgeagKq8fDGDDmcXe0geSO4d3VQPCSxBTsjLKl/Rt7ab
	 nIymOd5EsH9Jh9tE+929UvqWlfkMrpwWp35KSR5m9QyT3nobMF+UUxcvmaSBEq3aq8
	 H3hv7kmf3JBUA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/3] NFSD: Prevent client use-after-free during close_lru reaping
Date: Mon,  7 Sep 2026 21:14:08 -0400
Message-ID: <20260908011408.1695604-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908011408.1695604-1-sashal@kernel.org>
References: <2026090306-unwieldy-turtle-e4a5@gregkh>
 <20260908011408.1695604-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <cel@kernel.org>

[ Upstream commit 2330b788d732f43668b965b3105b37ceb276dfea ]

An nfs4_openowner left on nn->close_lru after its final CLOSE keeps
its last closed stateid in oo_last_closed_stid, holding only a raw
pointer to its nfs4_client. The laundromat reaps timed-out entries,
drops nn->client_lock, and calls nfs4_put_stid(), which dereferences
the client through cl_lock. Nothing pins the client across that
window, so a concurrent force_expire_client() can free it and
nfs4_put_stid() reads freed memory. __destroy_client() hits the same
race, walking clp->cl_openowners without cl_lock.

Pin the client with cl_rpc_users before dropping client_lock, and
skip clients already expiring. __destroy_client() then cleans up its
own close_lru entries through release_last_closed_stateid(), so
teardown no longer races the laundromat.

Fixes: 217526e7ecc9 ("nfsd: protect the close_lru list and oo_last_closed_stid with client_lock")
Cc: stable@vger.kernel.org
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Link: https://patch.msgid.link/20260709-cel-v4-8-1d519d9be0cb@kernel.org
Signed-off-by: Chuck Lever <cel@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4state.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 44d5c2077fabe..749e15929dc25 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6265,11 +6265,16 @@ nfs4_laundromat(struct nfsd_net *nn)
 		if (!state_expired(&lt, oo->oo_time))
 			break;
 		list_del_init(&oo->oo_close_lru);
+		clp = oo->oo_owner.so_client;
+		if (is_client_expired(clp))
+			continue;
 		stp = oo->oo_last_closed_stid;
 		oo->oo_last_closed_stid = NULL;
+		atomic_inc(&clp->cl_rpc_users);
 		spin_unlock(&nn->client_lock);
 		nfs4_put_stid(&stp->st_stid);
 		spin_lock(&nn->client_lock);
+		put_client_no_renew_locked(clp);
 	}
 	spin_unlock(&nn->client_lock);
 
-- 
2.53.0

