Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128EE3B28D
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 00:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788828376; cv=none; b=eHw+P0t/YgUI5k01vvCa4k8Q1K0sTABoZ0vdNwNqWSNzpLvhEE46UyRWb25EH6XVglu4SMYlQzH9IVi0wBpvgHe6K0LL8H7wcozw0we4cc7Cq5zOkkETHI19saVkyz4mRuhyqcXgINnLBcOE5W1N0YXtdIAlo6lh8xBCRc1lw18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788828376; c=relaxed/simple;
	bh=p+hDeu1w2aJxETsA/5rORN6xaBv93S9rOok84T1junw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=doiyHpno2aBS44WEgPIWO2HH7oBh69cl3BIkyLLGSU51m7Cxqnwghsl0hohYfUbnm4oV7/oLnCs202e0OxLgKRj76CfOiz+zLK36SObEB7HOsxuXpxvrTVjnKPYE7X9fQwKCDMsAkDysRoCFnYTq88lxDuCYb7qJYclicFZOFWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hW1CLNqP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hW1CLNqP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 373411F00A3E;
	Tue,  8 Sep 2026 00:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788828374;
	bh=9ak35JRNyFr5j+VP5FAeQf3v8AVGi7SMcR/kytNdX3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hW1CLNqP1WIAhzdTrtqD2RcYlebu5fEuVnu6pw7bbnZehKb/afktf2tyvs0k9XiMp
	 jubi8iLUAIBUQ8v477h2X5p3SZamLY1TjY8QL1bvPl1cUlffUhmV+fEw6VgOkeyuA+
	 nhFe92mUxKNO3dCQGiQpvRpWjhEvIOdzLlST65Iw5kBnicHloMPe1CiQaIhMiWkkPK
	 GXWoB86owXoV1PqHmqgKhn8ws/5WzT6nlqUT0kgBNNfGV23iJRIl+2/eqOqH4lQZ7Y
	 78EmyuduB7e3bJHKOyWZfWod7I8YvEo87bJfFc6fEd0PzI5ZZY5drspcnwtkq7FmJZ
	 s4xRGtmY6LUjg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/3] NFSD: Prevent client use-after-free during close_lru reaping
Date: Mon,  7 Sep 2026 20:46:10 -0400
Message-ID: <20260908004610.1630138-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908004610.1630138-1-sashal@kernel.org>
References: <2026090305-identical-flame-bc6a@gregkh>
 <20260908004610.1630138-1-sashal@kernel.org>
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
index 1592a9b36a344..fdd032f53f2ab 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6310,11 +6310,16 @@ nfs4_laundromat(struct nfsd_net *nn)
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

