Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03794B0C9A
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 13:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788443189; cv=none; b=MxEIPr9GfE0YWI+H6zXvrJh8mEThF9dBUFhFbREDj2qwCC7b68novtk9jF4eaU4jtaSxWfT5Okjb2TOCVIfXeZHT6xbZlCFO522go0TktCI5p9Khd9ErXJn8S578AdXo2q+RU3/xS/rvx2iFk7ClzCQLInO1cA/mSfpbWTGtWOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788443189; c=relaxed/simple;
	bh=KE8dz1Ej5FJwUZx95MLmNvLpYudcUswbMaOuZou/iO8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=n9KLDgcTfrnzw3f0djRnb7sBXrEAK98uNGkNWS15C32BE3dFd2azVzqgSCJo+5Zjco7uY9H3ArhORiQQmyDgX0TcgqSsRwyfJSaap9n1+iDPsmig/jUR3301+XW0LmKxnIFF2g9RqOO0C7XR2/9ZBFDVV3artR/UEcZO3ZeQUao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XARYHAgh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XARYHAgh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEA7C1F00A3F;
	Thu,  3 Sep 2026 13:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788443163;
	bh=DiRqb1xsF6cBhrcmzgb+kiGKwCvlwpZYOczW4iuv6ao=;
	h=Subject:To:Cc:From:Date;
	b=XARYHAghFRu0BJq16+c3MQW8WzUVDmXvP4JxhDKp5FCQBczT5pzoI6/FHo5GNECfW
	 X2RMoQBUuh7SQJPqu4WKRuLVucPyJe7cq/Ga4XS3P7EpHC5LEel+HPEfDFxk8nGr7e
	 pgqYYclcnC98mfb7Ys4vXxPsrHKhLKgEd/P8ZRHg=
Subject: FAILED: patch "[PATCH] NFSD: Guard admin state-revocation walks with NFSD_NET_UP" failed to apply to 6.18-stable tree
To: cel@kernel.org,jlayton@kernel.org,xiaowu.417@qq.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:20:52 +0200
Message-ID: <2026090352-parting-overeater-9374@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 2f3e6638aebc0ab8afb8b4e9816ea9a1cad85378
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090352-parting-overeater-9374@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2f3e6638aebc0ab8afb8b4e9816ea9a1cad85378 Mon Sep 17 00:00:00 2001
From: Chuck Lever <cel@kernel.org>
Date: Sun, 21 Jun 2026 12:25:51 -0400
Subject: [PATCH] NFSD: Guard admin state-revocation walks with NFSD_NET_UP

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

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index c413ed0810b9..8351ccaae59c 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1588,10 +1588,9 @@ static bool nfsd4_copy_on_sb(const struct nfsd4_copy *copy,
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
index 4ae5d65c056a..a4398dc861a5 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1946,10 +1946,9 @@ static void revoke_one_stid(struct nfsd_net *nn, struct nfs4_client *clp,
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
@@ -2024,10 +2023,9 @@ static struct nfs4_stid *find_one_export_stid(struct nfs4_client *clp,
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
index caf59421f8f4..bc16fc7ca24f 100644
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
@@ -2424,7 +2424,7 @@ int nfsd_nl_unlock_filesystem_doit(struct sk_buff *skb,
 	error = nlmsvc_unlock_all_by_sb(path.dentry->d_sb);
 
 	mutex_lock(&nfsd_mutex);
-	if (nn->nfsd_serv) {
+	if (test_bit(NFSD_NET_UP, &nn->flags)) {
 		nfsd4_cancel_copy_by_sb(net, path.dentry->d_sb);
 		nfsd4_revoke_states(nn, path.dentry->d_sb);
 	} else {
@@ -2471,7 +2471,7 @@ int nfsd_nl_unlock_export_doit(struct sk_buff *skb, struct genl_info *info)
 		return error;
 
 	mutex_lock(&nfsd_mutex);
-	if (nn->nfsd_serv) {
+	if (test_bit(NFSD_NET_UP, &nn->flags)) {
 		nfsd_file_close_export(net, &path);
 		nfsd4_revoke_export_states(nn, &path);
 	} else

