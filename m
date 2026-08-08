Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C005141A56F
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 14:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786198177; cv=none; b=r2bs+wKq4Wu7QIB+Vk0qvMMkts1Y2eEBV323uD/Ek0XnLJL8y5MCt0mhXtxZXwlUgKmlUsFMz9hRKQpQP8NMMBCOrZTo9rOPNiv7Fc8bj6wnRS/XQrAa+g176vZMiZNArls4xOZay8v5/a4pp8fEfAJ+m/czz9CZc6jYO2BO2/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786198177; c=relaxed/simple;
	bh=JXNADUeIbYR81usvDlN7GWmHiazzk5X3FXXn4JJEw+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZFVAfFsNDKmmLn8Un2oXMTdpJlfpAzJ8aJ8/VOeGm3JD/Rmay4IpZ0nmipjZsRjaUXrq14tAKkpTZAoed+EWxP4QvEiiPTJbM1ggKGYRH6PNtvX46xUVDcWKt7Ec1K+33pYbmUuh+5tM8L85o5gzFyb7MFi0oJW582D+hBX3FHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Msri/iGs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Msri/iGs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9380B1F00A3A;
	Sat,  8 Aug 2026 14:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786198174;
	bh=ogL2+X7wvglUGK0VmKucvzFFj3m/n2ClLUpQEoI7xZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Msri/iGsEPDWHzf43ktUkkWtONcPciuGpQRiLSysy73PNxXLY22raKkhHZFkeEuKU
	 oFKM1H+x050/dIT6VdMIvds6GQsO19q/7Q6/l1PQajmz2RmlG6XSZ3Wn/6Xa6rZ9o3
	 Q8QlyVbHhWCAu4K1tsy8KvJ+ebb1wplG9BEwinu+BTmWXLRgjrAOEZUlByiBP07Fb0
	 WF9GMiZfjb9JY1BRijCxAcXK7xWQ/vwMYvheqMtHixKj/DsIyG0kb0HDlDJpYVINk/
	 HIEzqaTDqHeiCi0z7Jt1HfDPONcT01BbmcAusY+z0o0jbMaLVY/z7y3edYgfwq2LCZ
	 Tn2FqrmyEwlvg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/3] ceph: fix hanging __ceph_get_caps() with stale mds_wanted
Date: Sat,  8 Aug 2026 10:09:30 -0400
Message-ID: <20260808140930.339832-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260808140930.339832-1-sashal@kernel.org>
References: <2026072912-florist-maimed-6d1b@gregkh>
 <20260808140930.339832-1-sashal@kernel.org>
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
 fs/ceph/mds_client.h |  2 ++
 3 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 40a7fbdc325db..373c44711a477 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -2995,7 +2995,19 @@ int ceph_get_caps(struct file *filp, int need, int want,
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
+					ret = -ESTALE;
+					break;
+				}
 			}
 
 			remove_wait_queue(&ci->i_cap_wq, &wait);
@@ -3027,7 +3039,8 @@ int ceph_get_caps(struct file *filp, int need, int want,
 				continue;
 			}
 			if (ret == -ESTALE) {
-				/* session was killed, try renew caps */
+				/* session was killed or a waited cap
+				 * request needs a retry */
 				ret = ceph_renew_caps(inode, flags);
 				if (ret == 0)
 					continue;
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 21167384c560a..4d0bdda8d8f00 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -277,21 +277,22 @@ static int ceph_init_file(struct inode *inode, struct file *file, int fmode)
 }
 
 /*
- * try renew caps after session gets killed.
+ * Retry cap acquisition after a stale session or a lost cap update.
  */
 int ceph_renew_caps(struct inode *inode, int fmode)
 {
 	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(inode->i_sb);
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
 		dout("renew caps %p want %s issued %s updating mds_wanted\n",
 		     inode, ceph_cap_string(wanted), ceph_cap_string(issued));
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 1c958510f00f5..b1939f9162284 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -61,6 +61,8 @@ enum ceph_feature_type {
 struct ceph_fs_client;
 struct ceph_cap;
 
+#define CEPH_GET_CAPS_WAIT_TIMEOUT (5 * HZ)
+
 /*
  * parsed info about a single inode.  pointers are into the encoded
  * on-wire structures within the mds reply message payload.
-- 
2.53.0

