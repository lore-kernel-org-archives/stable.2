Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5E84503B
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 13:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788701331; cv=none; b=Lz6q5qWRdPcat5GisY+K/oizpcyF9VXdNJs+pLI2dKLzELGa3hdv0tFJPz1iFvkCoX+/KIn3eSH35LbXH8YV+HmtqgAUS/SI7P6NsG+Imq8B9uECwTHpndUU0/Z8/in6RMdqoq2Y+uwJVxBnAtkLME+B3E5QnCxXdKQNYQIy29w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788701331; c=relaxed/simple;
	bh=wJrTT7WMA8AjMRrqxpvOQPcD6nVsRQNYLJHpEr1n3fA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rPd4S61ev8PRccyCQpBJ8C0WZwBXMUNLNK3hg6GXmx2wkUFpofxOHJxBlqlUKf18qMXUUX0PaaPwDYbojlKPdIuXqA9aiKhrrDGTbawqMmHqxpC9PCGtN12NRNOOa4T5l/FQTQVrvHrtMdCW10gvbzalucGhlLMghwBb7yxyhvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFS1CCcF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFS1CCcF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E7451F00A3D;
	Sun,  6 Sep 2026 13:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788701330;
	bh=NdXx+QcSJoxWws904wveAFDOCYAl/7BLtFgCjHiuXYc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lFS1CCcFVp/Jensh4wbCV2zYh9cVYucl+p/lTAS0FhxLE+s5YOpz5P+0quu7x6M6+
	 THmAqMByQ1geBkb/XoNaNNwbvqDZHZeW0DzH5WdJKS/8o6vf/2QzyQhXiGkWrp7Ryo
	 izuoAUA6uTJu5RD51PjZoHxtcTj9EsSb7hIlLeTB818WNP2SdFUUIdSsRLDC+WVht3
	 Agxh6rnasv5KwNIm3V4r3qe90fqUpGTPbvfzLHMCvmVUCzuQ+AS0SixFoco+LvXY85
	 RJyMCs6j1E0n9DJ54kLqHCPHNqtWtkyEyHt+7SqdJ+7c0/ujmd8T8IGtyEuDpEdLG4
	 NNuM60zrElbmg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 3/4] NFSD: Annotate caller preconditions for the state-table walkers
Date: Sun,  6 Sep 2026 09:28:45 -0400
Message-ID: <20260906132846.875246-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260906132846.875246-1-sashal@kernel.org>
References: <2026090352-fading-liquefy-e98c@gregkh>
 <20260906132846.875246-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <cel@kernel.org>

[ Upstream commit 5f367f05481d56be90f8c13eee4cb421cd7af2d8 ]

The state-table walkers now assert nfsd_mutex with
lockdep_assert_held() and document the nfsd_mutex / nn->nfsd_serv
precondition in a Context: kdoc section, so the next caller added to
this path cannot silently reintroduce the same use-after-free.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Link: https://patch.msgid.link/20260613-unlock-filesystem-uaf-v1-3-462b9bec8c84@kernel.org
Signed-off-by: Chuck Lever <cel@kernel.org>
Stable-dep-of: 2f3e6638aebc ("NFSD: Guard admin state-revocation walks with NFSD_NET_UP")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4proc.c  |  6 ++++++
 fs/nfsd/nfs4state.c | 16 +++++++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 1391e08ee3bf4..10e76bafabf29 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1562,6 +1562,11 @@ static bool nfsd4_copy_on_sb(const struct nfsd4_copy *copy,
  * nfsd4_cancel_copy_by_sb - cancel async copy operations on @sb
  * @net: net namespace containing the copy operations
  * @sb: targeted superblock
+ *
+ * Context: Caller must hold nfsd_mutex with nn->nfsd_serv confirmed
+ *          non-NULL.  nfs4_state_destroy_net() frees conf_id_hashtbl
+ *          at server shutdown without clearing the pointer, so a
+ *          walk without these guarantees iterates freed slab memory.
  */
 void nfsd4_cancel_copy_by_sb(struct net *net, struct super_block *sb)
 {
@@ -1571,6 +1576,7 @@ void nfsd4_cancel_copy_by_sb(struct net *net, struct super_block *sb)
 	unsigned int idhashval;
 	LIST_HEAD(to_cancel);
 
+	lockdep_assert_held(&nfsd_mutex);
 	spin_lock(&nn->client_lock);
 	for (idhashval = 0; idhashval < CLIENT_HASH_SIZE; idhashval++) {
 		struct list_head *head = &nn->conf_id_hashtbl[idhashval];
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 900fa219ff1ad..efa234eb6a605 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1873,14 +1873,21 @@ static void revoke_one_stid(struct nfsd_net *nn, struct nfs4_client *clp,
  * being released.  Thus nfsd will no longer prevent the filesystem from being
  * unmounted.
  *
- * The clients which own the states will subsequently being notified that the
+ * The clients which own the states will subsequently be notified that the
  * states have been "admin-revoked".
+ *
+ * Context: Caller must hold nfsd_mutex with nn->nfsd_serv confirmed
+ *          non-NULL.  nfs4_state_destroy_net() frees conf_id_hashtbl
+ *          at server shutdown without clearing the pointer, so a
+ *          walk without these guarantees iterates freed slab memory.
  */
 void nfsd4_revoke_states(struct nfsd_net *nn, struct super_block *sb)
 {
 	unsigned int idhashval;
 	unsigned int sc_types;
 
+	lockdep_assert_held(&nfsd_mutex);
+
 	sc_types = SC_TYPE_OPEN | SC_TYPE_LOCK | SC_TYPE_DELEG | SC_TYPE_LAYOUT;
 
 	spin_lock(&nn->client_lock);
@@ -1946,12 +1953,19 @@ static struct nfs4_stid *find_one_export_stid(struct nfs4_client *clp,
  *
  * Userspace (exportfs -u) sends this after removing the last client
  * for a path, enabling the underlying filesystem to be unmounted.
+ *
+ * Context: Caller must hold nfsd_mutex with nn->nfsd_serv confirmed
+ *          non-NULL.  nfs4_state_destroy_net() frees conf_id_hashtbl
+ *          at server shutdown without clearing the pointer, so a
+ *          walk without these guarantees iterates freed slab memory.
  */
 void nfsd4_revoke_export_states(struct nfsd_net *nn, const struct path *path)
 {
 	unsigned int idhashval;
 	unsigned int sc_types;
 
+	lockdep_assert_held(&nfsd_mutex);
+
 	sc_types = SC_TYPE_OPEN | SC_TYPE_LOCK | SC_TYPE_DELEG | SC_TYPE_LAYOUT;
 
 	spin_lock(&nn->client_lock);
-- 
2.53.0

