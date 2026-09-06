Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF513CCA19
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 13:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788701332; cv=none; b=iFa/5iBkORlFMYR/DUGUPwZ/Mb2o7QUQvysGD1FrukVKhCz3NrsQnZvs7F24fkRJ9+OX5V7QluODbOE2MgECfmd36SwRipSa1H21UcyiJPNQagcnpVlvfvOvNAWSWTB1UZ8pfYRr4AnqiuLVCTGDQ3cXUQmqz1Ut0vzDd3zlRYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788701332; c=relaxed/simple;
	bh=LoGuMQOqxtd01aHm1vb6X10F3TqQyGikkMQEBrAjh+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KQlIQtnG3F5CoU7kGl5wnYMmvDyZHKEGPYANXiJFImUi+VfxW42wdauRxNIjN3m/KxUpmsK+M4nsCZJMIY2ZyZt4TVF4dOTr4xGhl9fFDwNvBhknmZhtJrzseRgCCdGIoWnPLgOfSPHUdhEUDyCS+fui+HYiDHEAPIOAmuYYgfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxdjAilj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxdjAilj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BDE21F00ACF;
	Sun,  6 Sep 2026 13:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788701330;
	bh=IZQ1/AwxGdn34wWCU8S9sePnhO2ofIgLfyM8xWjUYQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mxdjAilj1K8aFXC7nepzdhLvXY/XCEpU438WnbZIWqc23+vvER7T6W+E5MyNncbrT
	 T1Y3+tqaKJWjJrR7ZZicdXZD9pFsdRuK/Z+2sEoMz9bdi6U8gMqAAfF3mMXQ3omDWD
	 DHiH8UDYkTgyw8CrYUw5gg5+ocdplAyqdv7lqQZe0uLZko1EsFLRNY/doGWeDfWZOB
	 cW0nMGLhuM6qpjpA+u6E26HnV5jFLcdG5uDO+FmaIO80jbwO0Sgmk+zmiGUv4tK0Y9
	 ENHC7HZqDl8MRQ/ADqdGu6DDmUz+AzmiIj9d9mF6PFuz7u9CDSTNLT5KOUMzFyxrMi
	 LPRf2h1DDtk1g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>,
	XIAO WU <xiaowu.417@qq.com>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 4/4] NFSD: Guard admin state-revocation walks with NFSD_NET_UP
Date: Sun,  6 Sep 2026 09:28:46 -0400
Message-ID: <20260906132846.875246-4-sashal@kernel.org>
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

[ Upstream commit 2f3e6638aebc0ab8afb8b4e9816ea9a1cad85378 ]

Writing to /proc/fs/nfsd/unlock_filesystem, or sending the
NFSD_CMD_UNLOCK_FILESYSTEM or NFSD_CMD_UNLOCK_EXPORT netlink command,
walks the NFSv4 client hash tables to revoke open state and cancel
async COPY operations.  All three handlers gate that walk on
nn->nfsd_serv, but a listener added via portlist or netlink
listener_set sets nn->nfsd_serv before any nfsd thread starts.
nfsd_startup_net() has not yet allocated nn->conf_id_hashtbl, so the
walkers dereference a NULL table.  A local administrator with
CAP_SYS_ADMIN can crash the kernel this way without ever starting the
server.

nn->nfsd_serv is set when the service is created, which precedes
table allocation.  NFSD_NET_UP instead brackets the window where the
tables are live: set at the end of nfsd_startup_net() and cleared in
nfsd_shutdown_net() after they are freed, both under nfsd_mutex.
Gating the three unlock paths on NFSD_NET_UP fixes the startup-time
NULL dereference while preserving the earlier post-shutdown
use-after-free fix.

Reported-by: XIAO WU <xiaowu.417@qq.com>
Fixes: 1ac3629bf012 ("nfsd: prepare for supporting admin-revocation of state")
Cc: stable@vger.kernel.org
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Link: https://patch.msgid.link/20260621162551.2469460-1-cel@kernel.org
Signed-off-by: Chuck Lever <cel@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4proc.c  |  7 +++----
 fs/nfsd/nfs4state.c | 14 ++++++--------
 fs/nfsd/nfsctl.c    |  6 +++---
 3 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 10e76bafabf29..290d0a5305c13 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1563,10 +1563,9 @@ static bool nfsd4_copy_on_sb(const struct nfsd4_copy *copy,
  * @net: net namespace containing the copy operations
  * @sb: targeted superblock
  *
- * Context: Caller must hold nfsd_mutex with nn->nfsd_serv confirmed
- *          non-NULL.  nfs4_state_destroy_net() frees conf_id_hashtbl
- *          at server shutdown without clearing the pointer, so a
- *          walk without these guarantees iterates freed slab memory.
+ * Context: Caller must hold nfsd_mutex with NFSD_NET_UP set.  Outside
+ *          that window nn->conf_id_hashtbl is unallocated or freed,
+ *          so the walk would dereference a NULL or dangling pointer.
  */
 void nfsd4_cancel_copy_by_sb(struct net *net, struct super_block *sb)
 {
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index efa234eb6a605..0ca816553a62b 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1876,10 +1876,9 @@ static void revoke_one_stid(struct nfsd_net *nn, struct nfs4_client *clp,
  * The clients which own the states will subsequently be notified that the
  * states have been "admin-revoked".
  *
- * Context: Caller must hold nfsd_mutex with nn->nfsd_serv confirmed
- *          non-NULL.  nfs4_state_destroy_net() frees conf_id_hashtbl
- *          at server shutdown without clearing the pointer, so a
- *          walk without these guarantees iterates freed slab memory.
+ * Context: Caller must hold nfsd_mutex with NFSD_NET_UP set.  Outside
+ *          that window nn->conf_id_hashtbl is unallocated or freed,
+ *          so the walk would dereference a NULL or dangling pointer.
  */
 void nfsd4_revoke_states(struct nfsd_net *nn, struct super_block *sb)
 {
@@ -1954,10 +1953,9 @@ static struct nfs4_stid *find_one_export_stid(struct nfs4_client *clp,
  * Userspace (exportfs -u) sends this after removing the last client
  * for a path, enabling the underlying filesystem to be unmounted.
  *
- * Context: Caller must hold nfsd_mutex with nn->nfsd_serv confirmed
- *          non-NULL.  nfs4_state_destroy_net() frees conf_id_hashtbl
- *          at server shutdown without clearing the pointer, so a
- *          walk without these guarantees iterates freed slab memory.
+ * Context: Caller must hold nfsd_mutex with NFSD_NET_UP set.  Outside
+ *          that window nn->conf_id_hashtbl is unallocated or freed,
+ *          so the walk would dereference a NULL or dangling pointer.
  */
 void nfsd4_revoke_export_states(struct nfsd_net *nn, const struct path *path)
 {
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 32106d223a23c..02abd499a4e9f 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -299,7 +299,7 @@ static ssize_t write_unlock_fs(struct file *file, char *buf, size_t size)
 	error = nlmsvc_unlock_all_by_sb(path.dentry->d_sb);
 	mutex_lock(&nfsd_mutex);
 	nn = net_generic(netns(file), nfsd_net_id);
-	if (nn->nfsd_serv) {
+	if (test_bit(NFSD_NET_UP, &nn->flags)) {
 		nfsd4_cancel_copy_by_sb(netns(file), path.dentry->d_sb);
 		nfsd4_revoke_states(nn, path.dentry->d_sb);
 	} else {
@@ -2344,7 +2344,7 @@ int nfsd_nl_unlock_filesystem_doit(struct sk_buff *skb,
 	error = nlmsvc_unlock_all_by_sb(path.dentry->d_sb);
 
 	mutex_lock(&nfsd_mutex);
-	if (nn->nfsd_serv) {
+	if (test_bit(NFSD_NET_UP, &nn->flags)) {
 		nfsd4_cancel_copy_by_sb(net, path.dentry->d_sb);
 		nfsd4_revoke_states(nn, path.dentry->d_sb);
 	} else {
@@ -2391,7 +2391,7 @@ int nfsd_nl_unlock_export_doit(struct sk_buff *skb, struct genl_info *info)
 		return error;
 
 	mutex_lock(&nfsd_mutex);
-	if (nn->nfsd_serv) {
+	if (test_bit(NFSD_NET_UP, &nn->flags)) {
 		nfsd_file_close_export(net, &path);
 		nfsd4_revoke_export_states(nn, &path);
 	} else
-- 
2.53.0

