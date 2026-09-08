Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3145825EF87
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 01:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788829698; cv=none; b=MJIJhIF9TTVFsRk74gzk5vYOjYDuMI7J/v/SCfo4n6zSwmP8dadPPNwKL0Ag1uh4cTsrJ0qKUWJZWIQSQmOAPNcWy9Y1BU7EJ+DO1PDXaeAXQdL/u1xz0KVryjTBf+93tZ73PPd/s2nqeUQoOF6XEopMsMcYHMPEh9jMjj5S1VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788829698; c=relaxed/simple;
	bh=i2Ku+CuJv5NQ9YOPAjegHZGs34Ri8/fZ0M0AhV5XNDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UxgBqJNDsrwdUosb4Ekq2hDgPjTRV/U2OCwADGLpLLPLgCA64i4N9NssJulosOWd0UnUjn/q5An+cLEGXg3uspyNKUBm81mxEVrxRDT9kNkWzuifh23BJLS1vkcSnSJ47xNfRr/6Ap8mPXnBuyr6K8bL33g15PMqKckYsFQkndQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U0wwQfLv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U0wwQfLv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A9B51F00A3E;
	Tue,  8 Sep 2026 01:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788829697;
	bh=/TfTdfG+hWcHd0vg44OuiRNA5C6pQXembMC6hynBHtY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U0wwQfLvOWOtdLaPCqHmzwlkJN+3jUjzVpqFWtwgVsYO9bj94SajqVcCkDlBGDXPG
	 h7gA+2gCKqj5bIBa2ENl1GaCe0sWt+EDkLWSxeO10VPEYf3ANr/x4oAxuSOh40NrnI
	 b9zhQDyc9CAe1TqhwAKPoNYeb0BtRzpPVqkbDB5rZA+PZe9gaZi5m2wFHkd9iUFjUP
	 wZBnpGRDkc6W00V4PkiyZoiV2z2GO313JUtQnhYgLIcDOCoEUqSGVwPvK+n5jX2Quq
	 cFWXl8fPaVYuZM8lHRoaiS6VOdJRyq7hg1vcrXqyjAqV3ETJrKX4tSDBW/CGFlfHu0
	 HSNniBQNisgGQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/3] NFSD: Prevent client use-after-free during close_lru reaping
Date: Mon,  7 Sep 2026 21:08:13 -0400
Message-ID: <20260908010813.1681295-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908010813.1681295-1-sashal@kernel.org>
References: <2026090306-dazzler-deputy-dc16@gregkh>
 <20260908010813.1681295-1-sashal@kernel.org>
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
index 2026725344a12..af3e5e8822564 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6269,11 +6269,16 @@ nfs4_laundromat(struct nfsd_net *nn)
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

