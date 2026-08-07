Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FC33264C4
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 19:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786130249; cv=none; b=gw+oL8xwDKnNX5mrQZ96+uP+TxBee98Og89JrWaHToPjW82H5RRdFYr/VXj3ZwD0BI5V1zyhdnG2ii9KbYkycRln3Ox1rVePkCp4O5O0hnN2UKRH0RNPMa/bUoZu83O+duriaJbUchue9XYmu16cVigGvZvvgB8RF3xn0BYaAss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786130249; c=relaxed/simple;
	bh=k/gM0gQ4darECYweUFkYkbwB4WLtZAsMo05Kgjr9J2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jIKDZ2KyPTkSaEC9R1cvS9BQapa7XVV6zib0vbGkTs3C0q+0Z/Ji4oTiGduT01sZUXf6rHgOa0kafd8++XHj9aO4+RqKkHTHzNzF5AIcJxmCzG0aHmGS0ZmUa/ZFvkSD0DJ3X/QXksOvbCFWyrkWr//5NOQJCCfkoQrzCLi0R10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ixqWykI8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ixqWykI8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FD4E1F00A3D;
	Fri,  7 Aug 2026 19:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786130247;
	bh=w7xJY10ffDS/n3A0NXona8qk/IH7YZWRNwVDAbU1u4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ixqWykI8ZOP2JciTdK2QQ4QAJsPROyJdxq7s6EQu9OLmbyEAMz8ZUFK+rSvhrRsU7
	 D4ob1qTWHNGO+dtfezMzgkOj0Gwx1hulh7RN28H+ddGFj+9G/bg/95y17IrJyXtssf
	 VfZv/jGRZ7RdNzCCj8jyz9MFxPVB0WCctWgQgHx3RF//JbBF9uQkHejbnnzunU1YMT
	 HcnQ3dSexhrpnDdWicl8y1Yrs+xvqFNO4hSnBmJdRN1lAmGu8YommAR0XuInkol4x9
	 ruT7zcG23Y6mp7I7+wQCaIRd/hAyAnhnaiE8MQcADzYBRh5f6Nh97mC+OVJMD7VgN9
	 4JdgRiyNffUxg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] ceph: fix hanging __ceph_get_caps() with stale mds_wanted
Date: Fri,  7 Aug 2026 15:17:25 -0400
Message-ID: <20260807191725.3147286-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072908-niece-stuffed-f275@gregkh>
References: <2026072908-niece-stuffed-f275@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Max Kellermann <max.kellermann@ionos.com>

[ Upstream commit 50958bb928bad3bdba9e5d1b7ff4bbadcf6951e6 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/caps.c       | 17 +++++++++++++++--
 fs/ceph/file.c       |  9 +++++----
 fs/ceph/mds_client.h |  1 +
 3 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 52e02996d2eb6..b04465ae4ce86 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -3104,7 +3104,19 @@ int __ceph_get_caps(struct inode *inode, struct ceph_file_info *fi, int need,
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
@@ -3138,7 +3150,8 @@ int __ceph_get_caps(struct inode *inode, struct ceph_file_info *fi, int need,
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
index b21bd6b84c496..d86c1285fb020 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -295,7 +295,7 @@ static int ceph_init_file(struct inode *inode, struct file *file, int fmode)
 }
 
 /*
- * try renew caps after session gets killed.
+ * Retry cap acquisition after a stale session or a lost cap update.
  */
 int ceph_renew_caps(struct inode *inode, int fmode)
 {
@@ -303,14 +303,15 @@ int ceph_renew_caps(struct inode *inode, int fmode)
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
index 0a602080d8ef6..8987d0ff96252 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -74,6 +74,7 @@ struct ceph_fs_client;
 struct ceph_cap;
 
 #define MDS_AUTH_UID_ANY -1
+#define CEPH_GET_CAPS_WAIT_TIMEOUT (5 * HZ)
 
 struct ceph_mds_cap_match {
 	s64 uid;  /* default to MDS_AUTH_UID_ANY */
-- 
2.53.0

