Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B4A3ECBE5
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 20:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788812332; cv=none; b=ufpPFZMlWqzI6y1BYtn9EzswZmLYCoLSxQMFIIEVbQhkWZAybzefTjqBej5pU7M+V9iTzf4880FRpZnHpEpiAoH1eW8UHnEQ9cf6aqb0hxAUYCeES/9mOIk0BVKw+PYIPTfY90AnWxnO7E0hJwfcoa2NnT4lm1VfthdLtdsZlxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788812332; c=relaxed/simple;
	bh=TOmZQh4g94qIMt+Z6/LC9kE7BPv5LDid1FlUsllWemc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EqHLsINYGMwA81VQC/5DCh7+2eD8wyEGo81v1rzcJb5VnkwORT4PgpMrCv5Y8nDm9MWozEWIgvT3Cc48Umfy3LKLA8yFF1Iep7MmCBvZVblOE9t7bw9FjVykWOINGQPKSmODuvJ21gWen49icb58aF/Be1HZu94heeBM0ZQygNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G0F/T0ET; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G0F/T0ET"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BB181F00ACF;
	Mon,  7 Sep 2026 20:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788812330;
	bh=AUPCABW4ypUA2O4+XHGdn84CzIw8z9/QozZS4Ptyan8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G0F/T0ETXNy6mSVUWZuzN7yMD0GCd6zO/uDXE7t88obQsRoImqC/7P+uJy9+LKIpZ
	 qbVyxslhddwNRNMAilM4QkkFhb2ktRrSb4/HuM6DSLitmvN8qvjmmMH+ACPE2azKxE
	 5dcEFO1d6cQbnbnWLTsiR/+gpEOQdmJ3J+xxeSKH0+531L3RRFcKZAb8S11kwc3L+F
	 9X5g6ffUuFjlN1Wd/HtK3ofbtdWgy8WCb0cpEYbXwlnsNmz89mu4xG5leZWhkaaEE3
	 JfqzyM1ly/LH2oDjy1Z1isLFKVSJ/wkAmuF/V/2Q8gAXjXLzSNT2iyuo/+4Mv0vNq8
	 gjPPX8GAhPQrQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 6/6] NFSD: Prevent client use-after-free during close_lru reaping
Date: Mon,  7 Sep 2026 16:18:44 -0400
Message-ID: <20260907201844.381343-6-sashal@kernel.org>
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
index 9fde3505fac52..bf3a3c3df31da 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7176,11 +7176,16 @@ nfs4_laundromat(struct nfsd_net *nn)
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

