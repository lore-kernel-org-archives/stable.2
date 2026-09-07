Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1ABF299959
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 23:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788822178; cv=none; b=QUWVYJYyvFm0MrBynKdg9GwnaZAuNkPJu7fi5w6bxTLE0Gi4HieQUtN28LpllMVoDi/ji4Ans/YhKxRKEn9YJXjwswoXiutjuKH/4i6Cz58Gv9LhdJxOK+39cmjWf97aZjxnQxw/3wa/KSw4MDO/7yvGvGZceJxq/6wrZOMAueM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788822178; c=relaxed/simple;
	bh=TbgiT1FT2F5daIqObjgX0hP5SpXZ9g+i80Kv14TVxhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ji3csFL8xQAoLF/duBI1lxe2GNDRvVYOewQJ39IC+Lzcf9BJ144l5NcP+rxzplyWvi+cGU0+4pBIEvHHFL3ItUjyLba0Gb0mQf0MD6josh+ovPJSxh3DDPw0HA4rVOycuS2GggjOEjHpvMFW+woacS5GkwLSbJ1UUj+On4+wUKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oO3vCM7/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oO3vCM7/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20EB01F00A3A;
	Mon,  7 Sep 2026 23:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788822177;
	bh=tAg8XWJICyAJoJuwDFJyXg8gyP1wpeyt40FR0ClSpVA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oO3vCM7/uQy3N6sj2MEEpiw5j2n0v7ebPEws0yPkNrgqT6c4qY4j7dfbL2dzxgLcU
	 AEFGnhhIANiDjAuPO2k+NhFiGvmVkeb0e+DRswWHJ4m0kkqwdrUl4nnGc09huWWbMo
	 3dVOFTofT3qpY6WLS9o+R2IT06p3mi04jqNqoD87URzt/8zIUirLAgwv9Ypj7xZCaG
	 qXgMuQBKjX97AQPscnDLqcyzLH6NnfUkIEpnHBjuyPUQa2CP/5dwjLo6+4V+E3XWnJ
	 8tRf74Vve/+53sa8EC1WiVxi2kk+IEFwjvuHjjxFOUd9s5iAHMaARbrWqkURFg/5s4
	 TDyxiwDfPoe7g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/4] NFSD: Prevent client use-after-free during close_lru reaping
Date: Mon,  7 Sep 2026 19:02:53 -0400
Message-ID: <20260907230253.720658-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907230253.720658-1-sashal@kernel.org>
References: <2026090305-unmasking-excuse-7fa0@gregkh>
 <20260907230253.720658-1-sashal@kernel.org>
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
index a20f4b72033ff..be4c01700bf15 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6847,11 +6847,16 @@ nfs4_laundromat(struct nfsd_net *nn)
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

