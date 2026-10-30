Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793375424;
	b=lMMSd4fNOJhOqFGW2OtyelOMSc6mO6HW4Xhh+J55b1jPTVHWF+bbNXtF4BtWUxlrQdsm
	 g/PG8CN6lZAZX3WOV91AAkdvvys15cviVGMXV4nSiuaYpaWjt7Cc7EC5/bWZMBEYKjvw/
	 cBzxa0aZnhTTeUZ9Patopvhy+36mSadZriTOj6KDKZZiKE2XO9X+Pi6hQpidEc+wWg0HI
	 7goObSE1yliIkLbH3mvEuMeUT398Yynor/do610XBCkCpsHFD2BL6gxLfvPS2AOa7HOwa
	 ZtmJnHUmLrTaFjMTQRt2oGNKGkxnPPWLD7V/ZD1hJBqR+V7pE6hRdDEoDuWja2kk/fQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793375424;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=6zs7KIdtqObt3G5F3sKpbT+49YyGEZ76NLVtZ95Ea20=;
	b=xwuF7EBf7kKRRmyWP4PeOQHynVkRZlGZ+IfW0r9gQOryRZcHbgn8taWe6XcBa+xKBsCP
	 YfTnlF51wRcBj7n1zxjUPlMJOQ/kAwFi1ZhbOVciuuTyKBsoYFZ5HRnjyOzWFON77tzTb
	 m0/OWd/e3GTWa6bm12sMJJrnmyIvfmkkyQa9OEwsp29Cc/Keg9eMhGlj4vYkF4JYvAqZx
	 PeCOvongJ4TDTWilk92LOGS4UKCbQqSsWwNts4BWBneTp523705fBX07TiBMpcu8ksylm
	 /xAARm9flRFnlCKa46iqdeDda3UWbS1UVHJv6zN9uKQQKApTaxNaeZImus3zwGVBXcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Il8+Wfdf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6472C606A31C;
	Fri, 30 Oct 2026 15:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Il8+Wfdf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B12171F000C1;
	Fri, 30 Oct 2026 15:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793375424;
	bh=6zs7KIdtqObt3G5F3sKpbT+49YyGEZ76NLVtZ95Ea20=;
	h=From:Date:Subject:To:Cc;
	b=Il8+WfdfaPZAgRcR1lfjO5no/kPmT1KOA9nhDrRqXG2GUPhhA7WT5QNAni65luq11
	 F5aIvUSDBWUcEc/gM7vwlJebdqyhEwjOt88ErqE9/6SF4aRTjACQXhk8PJy5PG0hCG
	 W901Yn/YUJhvhyx2SQ1FvdWUg2cqxFUjWTxl/Ch1VOYJyeG5Q7wsj+VstbDbfs8Cqo
	 aeKqHtFyt2FjDW/MwmQ1mRdvh5gaUgNJHU5EZC0qHP391bhSsFkLvZHFZkfDejiTnP
	 xo6Nfk0JF1N9TciSHmq7hHMg706Va/6Uyzm8EfNkapo5c+Ut5vC/aYUN6SuvRUyLsq
	 tWDajir5fK+fg==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 30 Oct 2026 16:50:07 +0100
Subject: [PATCH] ns: don't add init_ipc_ns and init_net without namespace
 support
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-work-nsfs-init_ns_tree-v1-1-7ec0adb47c54@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQrCMBBFr1KydiSJ0oVXESlJOrGjMJWZWIXSu
 5vY5fv891ajKIRqLt1qBBdSmrmCO3QmTYHvCDRWNt763tmThc8sT2DNCsRUBtahCCKMCV1IeO4
 zelPll2Cm7z98ve2s7/jAVFqtPWJQhCiB09SmJetxN7btB81HGOKWAAAA
X-Change-ID: 20261030-work-nsfs-init_ns_tree-dce1ace46fe2
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 kernel test robot <yi1.lai@intel.com>, stable@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4035; i=brauner@kernel.org;
 h=from:subject:message-id; bh=CmeNgtalbAc+JOBUPeLqNAYbAsC85B0PiD2APD63NlM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ92bOn9dQzRX+ZN+5sS00EXsxYGJkTt2p3i67p+QVuF
 ozmC/R2d5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExkTjcjw68ivlQvqdPyO36c
 nfr+xxmXwo/n7tTvujW/LX668+egFUsZ/lmlKDxULRdbfPA9+/TlagV61vO4E08u7hX45VHAEuw
 szgcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

When CONFIG_IPC_NS or CONFIG_NET_NS are turned off we still add the
initial ipc and network namespace to the namespace trees. ipc_ns_init()
calls ns_tree_add(&init_ipc_ns) whenever CONFIG_SYSVIPC is set and
setup_net() calls ns_tree_add_raw() on init_net whenever CONFIG_NET is
set.

But without CONFIG_IPC_NS and CONFIG_NET_NS these aren't namespaces
userspace can do anything with. They don't have proc_ns_operations so
there's no /proc/<pid>/ns/{ipc,net} for them, nsfs_fh_to_dentry()
refuses them with -EOPNOTSUPP, and since ns->ops is NULL
__ns_tree_add_raw() doesn't add them to the owner list of init_user_ns
either. So they end up half registered. That's also not how we treat
any of the other namespace types. Without CONFIG_UTS_NS, CONFIG_PID_NS,
CONFIG_TIME_NS or CONFIG_USER_NS the initial namespace is never added
to the tree.

listns() walks the unified tree and calls is_current_namespace() for
every namespace it finds via may_list_ns(). But is_current_namespace()
only knows about CLONE_NEWIPC and CLONE_NEWNET if CONFIG_IPC_NS and
CONFIG_NET_NS are set. Otherwise we end up in the default case and its
VFS_WARN_ON_ONCE(). Any unprivileged caller can trigger that with a
plain listns() call:

  WARNING: CPU: 0 PID: 526 at fs/nsfs.c:508 is_current_namespace+0x12f/0x440
  Call Trace:
   legitimize_ns+0x25f/0x4c0
   do_listns+0x185/0x5c0
   __do_sys_listns+0x13b/0x300

Instead of teaching is_current_namespace() about namespaces that can't
be opened, only add the initial namespaces to the tree if their
namespace type is enabled. Move the registration of init_ipc_ns into
ipc/namespace.c which is only built with CONFIG_IPC_NS. That also fixes
CONFIG_SYSVIPC=n, CONFIG_POSIX_MQUEUE=y, CONFIG_IPC_NS=y where
ipc/shm.c isn't built and init_ipc_ns was never added at all. For the
network namespace only call ns_tree_add_raw() if CONFIG_NET_NS is set.
Without CONFIG_NET_NS cleanup_net() isn't built and init_net is never
removed so there's nothing to balance.

Fixes: 74b24a582e1f ("ipc: support ns lookup")
Fixes: 195f7422298d ("net: support ns lookup")
Reported-by: kernel test robot <yi1.lai@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202610260917.6248e316-lkp@intel.com
Cc: stable@vger.kernel.org # v6.18+
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 ipc/namespace.c          | 7 +++++++
 ipc/shm.c                | 2 --
 net/core/net_namespace.c | 4 +++-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/ipc/namespace.c b/ipc/namespace.c
index 75aa7b469348..b54d23fd83d7 100644
--- a/ipc/namespace.c
+++ b/ipc/namespace.c
@@ -255,3 +255,10 @@ const struct proc_ns_operations ipcns_operations = {
 	.install	= ipcns_install,
 	.owner		= ipcns_owner,
 };
+
+static int __init ipc_ns_tree_init(void)
+{
+	ns_tree_add(&init_ipc_ns);
+	return 0;
+}
+pure_initcall(ipc_ns_tree_init);
diff --git a/ipc/shm.c b/ipc/shm.c
index bb1a721a3e74..cbab3d16cf70 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -45,7 +45,6 @@
 #include <linux/mount.h>
 #include <linux/ipc_namespace.h>
 #include <linux/rhashtable.h>
-#include <linux/nstree.h>
 
 #include <linux/uaccess.h>
 
@@ -149,7 +148,6 @@ void shm_exit_ns(struct ipc_namespace *ns)
 static int __init ipc_ns_init(void)
 {
 	shm_init_ns(&init_ipc_ns);
-	ns_tree_add(&init_ipc_ns);
 	return 0;
 }
 
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index da5f881fbd3b..52c2bd44778a 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -447,7 +447,9 @@ static __net_init int setup_net(struct net *net)
 	down_write(&net_rwsem);
 	list_add_tail_rcu(&net->list, &net_namespace_list);
 	up_write(&net_rwsem);
-	ns_tree_add_raw(net);
+	/* Without CONFIG_NET_NS init_net isn't exposed as a namespace. */
+	if (IS_ENABLED(CONFIG_NET_NS))
+		ns_tree_add_raw(net);
 out:
 	return error;
 

---
base-commit: b44341e39d856e4cc6ad8ed94ebffd440f39846c
change-id: 20261030-work-nsfs-init_ns_tree-dce1ace46fe2

