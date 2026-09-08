Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD33C25785D
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 00:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788828896; cv=none; b=cJ07M9U4KfC3c7l+GABrzUBrJCfZsoPYs+q/Jt9ocQ+afsUp64cXIs5mGcu3bENH6IdlD/ffqgZ6Yi2GbLOnCf7eIZvITtO2Va6PZM8JCa0L+adw/pSTGxdfcLrLWvrEucuoXKjt0/s13X8YkL1WGgc5ruC9Vak+Z+gIiZWQnxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788828896; c=relaxed/simple;
	bh=IZKmI5xhfP2DmVO1wjrZ2HwAGApbnsEvSfzE32Upwq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EcpSTXI16AG9SwCZNowreOzwL/2WCDOVeFjwHB1+aFSDJLeDgo+xuoTU5tt0x+Nhtw8F8ZJwAlbJ+yac1TW5K1LuLICgw++95GB2cC4lqq2ckX9HFREWq+gTwRDRqKRoX7X7DuaNpU0DzAVQ6dhwbxORgy1Z0nKDqmJ/t4m0tFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bb+iO1PS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bb+iO1PS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 308741F00A3E;
	Tue,  8 Sep 2026 00:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788828894;
	bh=XRCEFK27g9HseS4oynuo861gu6Mwmk2Af6IvPQ5TunI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bb+iO1PSx3UsHV0aSHOJBwuNW3OZV6y15jencZG5naBffxPRtlON5cvYFXiDNcXwt
	 wf/MCYG4ga+CzVcshnGLE11OSVpdwIYnvXqwuVh/UtfOE3rx18QDNRlfwE7zfZe311
	 pkY1Hchpr5/zhYUXTDYAZKtuRHsH4UW+QAw9Bdgx3N8mxsAodqpcGW6xXZYhK1Uz+5
	 zHtFVyiTXuUG2U8sfPAs07dzSCIEYMDvVbPL5CpV1c04Sz8YGc6QXwynNXs68DE/Kl
	 cuntRTxfNSeOnDGmWjI6OLkQYFo6Wv9GtF/O+6sBWe0O/ul5i/EYsQ/0DKJnfjNXxK
	 9F6kVaUqA+71g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/3] NFSD: Prevent client use-after-free during close_lru reaping
Date: Mon,  7 Sep 2026 20:54:50 -0400
Message-ID: <20260908005450.1655525-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908005450.1655525-1-sashal@kernel.org>
References: <2026090306-arrival-oblong-578e@gregkh>
 <20260908005450.1655525-1-sashal@kernel.org>
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
index 7942e6e014272..4560f8559802f 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6268,11 +6268,16 @@ nfs4_laundromat(struct nfsd_net *nn)
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

