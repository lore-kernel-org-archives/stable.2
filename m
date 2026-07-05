Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5830E2253EE
	for <stable@vger.kernel.org>; Sun,  5 Jul 2026 03:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783221115; cv=none; b=LX8JtQMB/qaXd9SLxCmIPd63ivyOLnDCC8G9aLkQYtHQJ5boPUiUVXR+lIsOo/4dmhCeetn50u8EOolAeVE5oMXbGaZgKp/HKoqPWN0vXMZN9L5tSUdlHgl7dwhkOpcu5FfL8Brl6GIzARULMFsZq3K41X5get+Kj9rLBeLurwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783221115; c=relaxed/simple;
	bh=GdYQXTOdShH6AZM432oJcg+t5jQDtK/xqzKogBI6M7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xb924Vn3aRMQwbzBoMeIcn/974GNF1apjSMtMn04YZKZ1zrINmzB+XjdaJckHzFPfWZc0Yz+fw6G4F+4I2ZbXPXr+EP0Qe4lVhsNaYg5B15qs5ZngdAtngzJmIunaknHzY/5xmHI3iaIUxok5/li4knrmTekvWfYf2t6UYCY2yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SzZD2Dok; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SzZD2Dok"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 633501F00A3A;
	Sun,  5 Jul 2026 03:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783221114;
	bh=KRFQcRs1uUkdZIQpBLBiFtoemzWddSiLqvW7Gsb8BUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SzZD2DokgVlwnODvz13xPFSFmp9lAALTDjN9ZKLMh5aEjT/qkEzSHijuGwb/rrLaI
	 DlIL7f8NH423YwZV8SB00U8ZcxlVNXmtpL4tLAeW8RgLSdWOv7WLbrhcWv/WGPq348
	 BqhTmvhjlY6bQCm1C5KHO+7GhHCOQcjdc0v9filqL0T828ZWJuAjbjURkaq9lL7wow
	 0N6hAyd1AeoZXDyCAU1ShP33RffgktliEKXjths5Y1zy6T7oZVDzaOKUEUNXqt0TGY
	 aA1i7mRoNtMsRkbQS+oHqTMB2XKSa7M7IWwxmO1STLdGUGC5rPutrDu8s8cdDojIFy
	 58py7z7ppxZ3Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mike Snitzer <snitzer@kernel.org>,
	NeilBrown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/5] nfs_common: rename functions that invalidate LOCALIO nfs_clients
Date: Sat,  4 Jul 2026 23:11:47 -0400
Message-ID: <20260705031150.1600970-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260705031150.1600970-1-sashal@kernel.org>
References: <2026070242-poker-barricade-3a69@gregkh>
 <20260705031150.1600970-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mike Snitzer <snitzer@kernel.org>

[ Upstream commit b49f049a22227df701bfbca083d6cc859496e615 ]

Rename nfs_uuid_invalidate_one_client to nfs_localio_disable_client.
Rename nfs_uuid_invalidate_clients to nfs_localio_invalidate_clients.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Reviewed-by: NeilBrown <neilb@suse.de>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
Stable-dep-of: 2c6bb3c40bc2 ("NFSv4/flexfiles: reject zero filehandle version count")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/localio.c           | 2 +-
 fs/nfs_common/nfslocalio.c | 8 ++++----
 fs/nfsd/nfsctl.c           | 4 ++--
 include/linux/nfslocalio.h | 5 +++--
 4 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 84fe3ef21b6da9..c59f205b513081 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -141,7 +141,7 @@ void nfs_local_disable(struct nfs_client *clp)
 	spin_lock(&clp->cl_localio_lock);
 	if (test_and_clear_bit(NFS_CS_LOCAL_IO, &clp->cl_flags)) {
 		trace_nfs_local_disable(clp);
-		nfs_uuid_invalidate_one_client(&clp->cl_uuid);
+		nfs_localio_disable_client(&clp->cl_uuid);
 	}
 	spin_unlock(&clp->cl_localio_lock);
 }
diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
index e6fbc45ec4f149..ae07ec16550218 100644
--- a/fs/nfs_common/nfslocalio.c
+++ b/fs/nfs_common/nfslocalio.c
@@ -107,7 +107,7 @@ static void nfs_uuid_put_locked(nfs_uuid_t *nfs_uuid)
 	list_del_init(&nfs_uuid->list);
 }
 
-void nfs_uuid_invalidate_clients(struct list_head *list)
+void nfs_localio_invalidate_clients(struct list_head *list)
 {
 	nfs_uuid_t *nfs_uuid, *tmp;
 
@@ -116,9 +116,9 @@ void nfs_uuid_invalidate_clients(struct list_head *list)
 		nfs_uuid_put_locked(nfs_uuid);
 	spin_unlock(&nfs_uuid_lock);
 }
-EXPORT_SYMBOL_GPL(nfs_uuid_invalidate_clients);
+EXPORT_SYMBOL_GPL(nfs_localio_invalidate_clients);
 
-void nfs_uuid_invalidate_one_client(nfs_uuid_t *nfs_uuid)
+void nfs_localio_disable_client(nfs_uuid_t *nfs_uuid)
 {
 	if (nfs_uuid->net) {
 		spin_lock(&nfs_uuid_lock);
@@ -126,7 +126,7 @@ void nfs_uuid_invalidate_one_client(nfs_uuid_t *nfs_uuid)
 		spin_unlock(&nfs_uuid_lock);
 	}
 }
-EXPORT_SYMBOL_GPL(nfs_uuid_invalidate_one_client);
+EXPORT_SYMBOL_GPL(nfs_localio_disable_client);
 
 /*
  * Caller is responsible for calling nfsd_net_put and
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 6b37d939a6ceb1..7b0a6beee96ed8 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -2296,14 +2296,14 @@ static __net_init int nfsd_net_init(struct net *net)
  * nfsd_net_pre_exit - Disconnect localio clients from net namespace
  * @net: a network namespace that is about to be destroyed
  *
- * This invalidated ->net pointers held by localio clients
+ * This invalidates ->net pointers held by localio clients
  * while they can still safely access nn->counter.
  */
 static __net_exit void nfsd_net_pre_exit(struct net *net)
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
-	nfs_uuid_invalidate_clients(&nn->local_clients);
+	nfs_localio_invalidate_clients(&nn->local_clients);
 }
 #endif
 
diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
index 7b2a86213d9e9f..6d87b7a78680a5 100644
--- a/include/linux/nfslocalio.h
+++ b/include/linux/nfslocalio.h
@@ -37,8 +37,9 @@ bool nfs_uuid_begin(nfs_uuid_t *);
 void nfs_uuid_end(nfs_uuid_t *);
 void nfs_uuid_is_local(const uuid_t *, struct list_head *,
 		       struct net *, struct auth_domain *, struct module *);
-void nfs_uuid_invalidate_clients(struct list_head *list);
-void nfs_uuid_invalidate_one_client(nfs_uuid_t *nfs_uuid);
+
+void nfs_localio_disable_client(nfs_uuid_t *nfs_uuid);
+void nfs_localio_invalidate_clients(struct list_head *list);
 
 /* localio needs to map filehandle -> struct nfsd_file */
 extern struct nfsd_file *
-- 
2.53.0

