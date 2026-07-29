Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20832FC00D
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 13:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785332870; cv=none; b=ZrBiB2HGqkSr9IXwzXGAbNapbAFn+C4qeg0apzmrUl7Qo8yOeUim2umfhSTPry8sb37r/gbd2mArTsi+Y5dwTvQwc81RnrD2ZPs3UntmCU4hRwfIUN6+q8JbPJKQFGai8TJhCWebrzmBpcO1e8E4EHfCbo5/py4diURSomCLpXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785332870; c=relaxed/simple;
	bh=SukNXa3P+Cib9kjeXVdOLFU/6W+1Lxt3L2bLU0+TZOc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=KQS5CjK1M3as4ixgSDScSZ/YDVNR81A+KVRtLE76MambpCNQVjhQj28STb+j7XU85PmEFYeA0c8r5nOiJPcckwDz83hWWRSYY8qwVYdSIlGHiAoHoksF3UgK86au1A2ivvrXCuP4Qf4ev5RsrMsxM903Rab8o9qxVC/bT61Yv3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hct4cimF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hct4cimF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41DA61F000E9;
	Wed, 29 Jul 2026 13:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785332868;
	bh=BQ8AspxfrjBfXgGviY3mh3DgEOEAW0imJxRijeC0CXw=;
	h=Subject:To:Cc:From:Date;
	b=hct4cimFfRNv+SkWNPp4+QeWNZzZyaSy0EWHPbTAL8DTuTzG5jRvFXxRGBME4msEy
	 GSk0UGkkykmH83IjqLljAakC4UkV9VLTsKhw64kyX8sK612ifkc4ue0w+2aI9+tPDQ
	 NVLbCr59SVDU3hAwGCXkmRCslE+lZIuAhcfzdYrQ=
Subject: FAILED: patch "[PATCH] ceph: fix hanging __ceph_get_caps() with stale mds_wanted" failed to apply to 5.10-stable tree
To: max.kellermann@ionos.com,amarkuze@redhat.com,idryomov@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 15:47:12 +0200
Message-ID: <2026072912-florist-maimed-6d1b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 50958bb928bad3bdba9e5d1b7ff4bbadcf6951e6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072912-florist-maimed-6d1b@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 50958bb928bad3bdba9e5d1b7ff4bbadcf6951e6 Mon Sep 17 00:00:00 2001
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 6 Jul 2026 17:06:59 +0200
Subject: [PATCH] ceph: fix hanging __ceph_get_caps() with stale mds_wanted

A reader can hang forever in __ceph_get_caps() when the client no
longer holds `FILE_RD`, but local cap state still says that the
capability is already wanted (via `mds_wanted`).

One way to trigger this is through MDS cap revocation.  If another
client performs a conflicting operation, the MDS can revoke `FILE_RD`
from the reader; the next read then has to reacquire `FILE_RD`.  If
the cap update that should request `FILE_RD` never reaches the MDS
after `cap->mds_wanted` was raised, the reader is left holding only
non-file caps while local `mds_wanted` still includes the file read
caps.

In that state, try_get_cap_refs() sees `need <= mds_wanted` and
returns 0, so __ceph_get_caps() just waits on `i_cap_wq`.  If the cap
update that was supposed to request `FILE_RD never reaches the MDS
after `cap->mds_wanted was` raised, no further request is sent and the
waiter can sleep indefinitely until unrelated cap traffic happens to
wake it up.

The ordering issue is that `cap->mds_wanted` is updated in
__prep_cap() before the `CEPH_MSG_CLIENT_CAPS message` is actually
queued for send.  That makes one field serve two different meanings at
once: what this client wants, and what the client believes the MDS
already knows it wants.

A proper fix would be to split those states and track whether a cap
update is actually in flight or has been observed by the MDS.
However, simply moving the `cap->mds_wanted assignment` later would
not be sufficient: queueing the message in the messenger does not
guarantee that the MDS processed that specific wanted set, and
reconnect or message loss can still invalidate that assumption.
Fixing that properly would require a larger rework of the cap state
machine.

To allow simpler backports to stable kernels, this patch implements a
simpler workaround:

- stop waiting forever in __ceph_get_caps(); after a bounded wait,
  fall back to the renew path

- make ceph_renew_caps() issue a synchronous `OPEN` request whenever
  the inode still does not actually hold the wanted caps, instead of
  only calling ceph_check_caps()

The extra issued-vs-wanted check in ceph_renew_caps() is necessary
because the previous test only checked whether the inode still had any
real caps at all.  That is not enough after revocation: the client can
still hold something like `pLs` and yet be missing `FILE_RD`
completely.  In that case, falling back to ceph_check_caps() is not
sufficient, because it still trusts `cap->mds_wanted` and may resend
nothing.  By requiring `(issued & wanted) == wanted` before taking the
asynchronous path, the code only uses ceph_check_caps() when the
`wanted caps` are already actually issued.  Otherwise, it sends the
synchronous `OPEN` renew.

This preserves the existing asynchronous fast path when the wanted
caps are already issued, avoids changing cap-state semantics, and
fixes the hang by guaranteeing that a stalled waiter eventually
retries through a path that does not rely on the stale `mds_wanted`
state.

[ idryomov: move CEPH_GET_CAPS_WAIT_TIMEOUT from libceph.h to
  mds_client.h, formatting ]

Cc: stable@vger.kernel.org
Fixes: 0a454bdd501a ("ceph: reorganize __send_cap for less spinlock abuse")
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Reviewed-by: Alex Markuze <amarkuze@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 77b23fe51425..d7283fb54cec 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -3094,7 +3094,19 @@ int __ceph_get_caps(struct inode *inode, struct ceph_file_info *fi, int need,
 					ret = -ERESTARTSYS;
 					break;
 				}
-				wait_woken(&wait, TASK_INTERRUPTIBLE, MAX_SCHEDULE_TIMEOUT);
+
+				/*
+				 * If a cap update is lost after
+				 * mds_wanted was raised, waiting
+				 * forever will never make progress.
+				 * Retry the renew path periodically
+				 * so we can resend synchronously.
+				 */
+				if (!wait_woken(&wait, TASK_INTERRUPTIBLE,
+						CEPH_GET_CAPS_WAIT_TIMEOUT)) {
+					ret = -EUCLEAN;
+					break;
+				}
 			}
 
 			remove_wait_queue(&ci->i_cap_wq, &wait);
@@ -3128,7 +3140,8 @@ int __ceph_get_caps(struct inode *inode, struct ceph_file_info *fi, int need,
 				continue;
 			}
 			if (ret == -EUCLEAN) {
-				/* session was killed, try renew caps */
+				/* session was killed or a waited cap
+				 * request needs a retry */
 				ret = ceph_renew_caps(inode, flags);
 				if (ret == 0)
 					continue;
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 71161f2b2151..a4a2a4b6a027 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -314,7 +314,7 @@ static int ceph_init_file(struct inode *inode, struct file *file, int fmode)
 }
 
 /*
- * try renew caps after session gets killed.
+ * Retry cap acquisition after a stale session or a lost cap update.
  */
 int ceph_renew_caps(struct inode *inode, int fmode)
 {
@@ -322,14 +322,15 @@ int ceph_renew_caps(struct inode *inode, int fmode)
 	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_mds_request *req;
-	int err, flags, wanted;
+	int err, flags, wanted, issued;
 
 	spin_lock(&ci->i_ceph_lock);
 	__ceph_touch_fmode(ci, mdsc, fmode);
 	wanted = __ceph_caps_file_wanted(ci);
+	issued = __ceph_caps_issued(ci, NULL);
 	if (__ceph_is_any_real_caps(ci) &&
-	    (!(wanted & CEPH_CAP_ANY_WR) || ci->i_auth_cap)) {
-		int issued = __ceph_caps_issued(ci, NULL);
+	    (!(wanted & CEPH_CAP_ANY_WR) || ci->i_auth_cap) &&
+	    (issued & wanted) == wanted) {
 		spin_unlock(&ci->i_ceph_lock);
 		doutc(cl, "%p %llx.%llx want %s issued %s updating mds_wanted\n",
 		      inode, ceph_vinop(inode), ceph_cap_string(wanted),
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 731d6ad04956..0ece4c9e3529 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -77,6 +77,7 @@ struct ceph_fs_client;
 struct ceph_cap;
 
 #define MDS_AUTH_UID_ANY -1
+#define CEPH_GET_CAPS_WAIT_TIMEOUT (5 * HZ)
 #define CEPH_CAP_FLUSH_WAIT_TIMEOUT_SEC 60
 #define CEPH_CAP_FLUSH_MAX_DUMP_ENTRIES 5
 #define CEPH_CAP_FLUSH_MAX_DUMP_ITERS 5

