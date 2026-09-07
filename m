Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75D643DA38
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 22:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788821973; cv=none; b=sKpZh+8IpuDS+b5X8MFxFfCoJ+ycuTFc9iLqXPmjByaIcxMZhbAVm1sbLOfTxgVhpLJE9DE2zVoWrtl/LX5M0WFYLyQjN1+ndHx1Io+V2nH4DxVYL1OVvzqnSWP+rbKR2Lws8vkMhuBWYkpt20FYyznqgwW4T5f+QZ7+N2TL/ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788821973; c=relaxed/simple;
	bh=vHEEnrnZj24hlT9PJ/d72YqWgZ+j0fWPy7HybQ+3MiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JDsxbQY8eLs5zwK/HSQuo1n6pOPzWy+cIEvbi70DsGHOyOpzoWPcNvtGqFIfYXQfOPY1kb0oygsX97BhM4Lxhj3hhfdYnUPibVltCyrNhK9NosLAI04URobNcO14ZaWmq+zu+uD8ogUIa7lKzul5HKoscl/+fZ0oaA3rCEeSp+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cF7jT0ji; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cF7jT0ji"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A21D1F00A3F;
	Mon,  7 Sep 2026 22:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788821971;
	bh=HoRvicOoZHwrArEaqntn3hNnMbMFYcRF9eeR3KVp1HM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cF7jT0jim8NE5q4UiatBzq6fjcAFZOv5ZG1VKgTqDcNPzpYLH4u8PQgXaO0Apcg5Q
	 YvZA8LczPsjphNDP8R2yjeUnLnlBbyFRKNzLnL6HGOhbPv3r+Rw7KRjMLDk+3IE1Mm
	 YoQgbhcKQVzozHWw/+QfE+5LDaLD8+kWnXlU3+3gTldJYlm5h/CSwRTAFJVU1sFg4a
	 6L1buoyLtQHfxUxr52JzXhSquP5AslRzCOeYBJ+3cCB1tsKAHFn+UI2xicWhjbLxts
	 xEvJSmkMCrwG4bmvHuu40sXDFSdSVr4b4f3WAqqb1xbnjSeP0yii5osWrhjJ/uoDmk
	 DUXpiWQAqmm/Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 4/4] NFSD: Prevent client use-after-free during close_lru reaping
Date: Mon,  7 Sep 2026 18:59:27 -0400
Message-ID: <20260907225927.712336-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907225927.712336-1-sashal@kernel.org>
References: <2026090304-waking-garnish-23bc@gregkh>
 <20260907225927.712336-1-sashal@kernel.org>
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
index 07da5353644e1..d8c44eddf38ed 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7155,11 +7155,16 @@ nfs4_laundromat(struct nfsd_net *nn)
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

