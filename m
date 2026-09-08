Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FD94D8DA2
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 13:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788874663; cv=none; b=I3lksjHMDsi9zr3f8J0/KQhIVvicNuWg/S6NmVlaA8pZIO2kBRTfklslidQku4noYGNvVZBr/K0nav+crDkKnU+L1c3LeAwhLDeDqYpMYiTRdJ32gRw/V1kreeadFgcYLJn6sONGMEufwHklmdjS7z816s8XdGcHdvXKnghKF34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788874663; c=relaxed/simple;
	bh=M02Dav2WXkd5KgGgTUBV3vkQNJKEkIlNXgmxK3QHOeY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bWb5CRbIkCQ6jz/DlFEFji2lJ2NDYmhmZXgVa5NyBnNsswNqv7lYdvE3sYa+UlPKfCVyiypp8+SGUw8GYT6iWibp833yPy2eHKHpTwRufxKxrOfc1PE87jeYcm74ZTEfnhgEhIjOSeJXB4vWqu25ejY+tvvB1oK2C2odik8BdHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cqfnwpWx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cqfnwpWx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 534AD1F01558;
	Tue,  8 Sep 2026 13:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788874658;
	bh=KhgHQ4ih8SFD0V4ntLUq90pm0ryZQeB9z97/FQb25uA=;
	h=Subject:To:Cc:From:Date;
	b=cqfnwpWxHdW/tZGVmDpkd93KI3YbvjscErxE88MNSHe45ThB8kzbADTc3Chv5IVM/
	 yLIpt60aehb03VXs+iwA+qvNTiVzt0KWUkgxxKxsnS3G7dJuDrt7Pfvhh6Tc5/RtK2
	 dp3nm3z78rlBq8iMuTFsPxCAytVOptsMOfVpwfQg=
Subject: FAILED: patch "[PATCH] ksmbd: fix tree connection use-after-free in" failed to apply to 6.12-stable tree
To: cenzhang@linux.microsoft.com,linkinjeon@kernel.org,xmei5@asu.edu
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Sep 2026 15:33:03 +0200
Message-ID: <2026090803-rewash-avenge-bd82@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x b5ec6c462aab1062cf5d1e667ba7c6442f737055
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090803-rewash-avenge-bd82@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b5ec6c462aab1062cf5d1e667ba7c6442f737055 Mon Sep 17 00:00:00 2001
From: "Cen Zhang (Microsoft Security FORGE Labs)"
 <cenzhang@linux.microsoft.com>
Date: Tue, 1 Sep 2026 14:21:36 -0400
Subject: [PATCH] ksmbd: fix tree connection use-after-free in
 smb2_tree_connect()

ksmbd_tree_conn_connect() publishes a new tree connection in
sess->tree_conns with a single reference and returns its pointer to
smb2_tree_connect(). The handler continues to initialize the object and
build the response after publication. A concurrent session logoff can
erase the connection and drop that reference, freeing the object while
the handler still uses it.

BUG: KASAN: slab-use-after-free in smb2_tree_connect+0xe3d/0xf90
  smb2_tree_connect (fs/smb/server/smb2pdu.c:2872)
  handle_ksmbd_work
  process_one_work
  worker_thread
  kthread

After xa_store() succeeds, take a second reference before releasing
tree_conns_lock. The original reference belongs to the xarray entry and
the second belongs to the creating smb2_tree_connect() handler.

Keep the references balanced in every path:

- On normal exit or an error after publication, smb2_tree_connect()
  drops its creator reference. Error cleanup also calls
  ksmbd_tree_conn_disconnect(), which drops the xarray reference only if
  it removes the exact entry.
- SMB2 TREE_DISCONNECT uses the same helper to remove the entry and drop
  its xarray reference. The request's existing lookup reference remains
  owned by the request and is released by the existing cleanup.
- Session LOGOFF removes each entry and drops its xarray reference. If
  it wins the race, later cleanup sees that the entry is gone and does
  not drop that reference again.

To enforce this ownership, claim the disconnected state and erase the
exact entry atomically under tree_conns_lock. This guarantees one drop
for the xarray reference and one drop by each in-flight user, regardless
of which teardown path wins. If logoff removes the entry before
initialization completes, fail the connect instead of marking the
detached object TREE_CONNECTED.

Fixes: 33b235a6e6eb ("ksmbd: fix race condition between tree conn lookup and disconnect")
Reported-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
Cc: AutonomousCodeSecurity@microsoft.com
Cc: stable@vger.kernel.org
Signed-off-by: Cen Zhang (Microsoft Security FORGE Labs) <cenzhang@linux.microsoft.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>

diff --git a/fs/smb/server/mgmt/tree_connect.c b/fs/smb/server/mgmt/tree_connect.c
index 5f63e236267a..dd1db3554cae 100644
--- a/fs/smb/server/mgmt/tree_connect.c
+++ b/fs/smb/server/mgmt/tree_connect.c
@@ -82,6 +82,8 @@ ksmbd_tree_conn_connect(struct ksmbd_work *work, const char *share_name)
 	down_write(&sess->tree_conns_lock);
 	ret = xa_err(xa_store(&sess->tree_conns, tree_conn->id, tree_conn,
 			      KSMBD_DEFAULT_GFP));
+	if (!ret)
+		atomic_inc(&tree_conn->refcount);
 	up_write(&sess->tree_conns_lock);
 	if (ret) {
 		status.ret = -ENOMEM;
@@ -129,6 +131,12 @@ int ksmbd_tree_conn_disconnect(struct ksmbd_session *sess,
 			       struct ksmbd_tree_connect *tree_conn)
 {
 	down_write(&sess->tree_conns_lock);
+	if (tree_conn->t_state == TREE_DISCONNECTED ||
+	    xa_load(&sess->tree_conns, tree_conn->id) != tree_conn) {
+		up_write(&sess->tree_conns_lock);
+		return -ENOENT;
+	}
+	tree_conn->t_state = TREE_DISCONNECTED;
 	xa_erase(&sess->tree_conns, tree_conn->id);
 	up_write(&sess->tree_conns_lock);
 
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index d656832d82ef..0ecc52fde69c 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -2790,6 +2790,7 @@ int smb2_tree_connect(struct ksmbd_work *work)
 	struct ksmbd_session *sess = work->sess;
 	char *treename = NULL, *name = NULL;
 	struct ksmbd_tree_conn_status status;
+	struct ksmbd_tree_connect *tree_conn = NULL;
 	struct ksmbd_share_config *share = NULL;
 	int rc = -EINVAL;
 
@@ -2817,6 +2818,7 @@ int smb2_tree_connect(struct ksmbd_work *work)
 
 	status = ksmbd_tree_conn_connect(work, name);
 	if (status.ret == KSMBD_TREE_CONN_STATUS_OK) {
+		tree_conn = status.tree_conn;
 		rsp->hdr.Id.SyncId.TreeId = cpu_to_le32(status.tree_conn->id);
 		share = status.tree_conn->share_conf;
 
@@ -2860,8 +2862,15 @@ int smb2_tree_connect(struct ksmbd_work *work)
 		status.tree_conn->posix_extensions = true;
 
 	down_write(&sess->tree_conns_lock);
-	status.tree_conn->t_state = TREE_CONNECTED;
+	if (status.tree_conn->t_state == TREE_DISCONNECTED) {
+		status.ret = KSMBD_TREE_CONN_STATUS_ERROR;
+		share = NULL;
+	} else {
+		status.tree_conn->t_state = TREE_CONNECTED;
+	}
 	up_write(&sess->tree_conns_lock);
+	if (status.ret != KSMBD_TREE_CONN_STATUS_OK)
+		goto out_err1;
 	rsp->StructureSize = cpu_to_le16(16);
 out_err1:
 	/*
@@ -2888,9 +2897,6 @@ int smb2_tree_connect(struct ksmbd_work *work)
 	rc = ksmbd_iov_pin_rsp(work, rsp, sizeof(struct smb2_tree_connect_rsp));
 	if (rc) {
 		if (status.ret == KSMBD_TREE_CONN_STATUS_OK) {
-			down_write(&sess->tree_conns_lock);
-			status.tree_conn->t_state = TREE_DISCONNECTED;
-			up_write(&sess->tree_conns_lock);
 			ksmbd_tree_conn_disconnect(sess, status.tree_conn);
 			status.tree_conn = NULL;
 		}
@@ -2931,6 +2937,9 @@ int smb2_tree_connect(struct ksmbd_work *work)
 	if (status.ret != KSMBD_TREE_CONN_STATUS_OK)
 		smb2_set_err_rsp(work);
 
+	if (tree_conn)
+		ksmbd_tree_connect_put(tree_conn);
+
 	return rc;
 }
 
@@ -3034,17 +3043,6 @@ int smb2_tree_disconnect(struct ksmbd_work *work)
 
 	ksmbd_close_tree_conn_fds(work);
 
-	down_write(&sess->tree_conns_lock);
-	if (tcon->t_state == TREE_DISCONNECTED) {
-		up_write(&sess->tree_conns_lock);
-		rsp->hdr.Status = STATUS_NETWORK_NAME_DELETED;
-		err = -ENOENT;
-		goto err_out;
-	}
-
-	tcon->t_state = TREE_DISCONNECTED;
-	up_write(&sess->tree_conns_lock);
-
 	err = ksmbd_tree_conn_disconnect(sess, tcon);
 	if (err) {
 		rsp->hdr.Status = STATUS_NETWORK_NAME_DELETED;

