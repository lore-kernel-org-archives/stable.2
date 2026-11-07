Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046565;
	b=JvCkNCmHmNc6lB6OYIBVKAOXbuellXjlgBMaBArFlHUMavSsq55pexdS1nV5DS5QYwaG
	 6trTLwPmmBoV6QzYvxWmq8ZL4BsfLVg3ficcl/01YKNSeXVdZcxDuISYUjInFHMW2L0sY
	 4K+Cu/or/rV5PujQg0BSuoKcApYlsSbs2vv2qQD82GuMRYV4/Nl0P5XJBdMzAaYwf00xs
	 EAF4ATaqW6RrbPuXXkE8BiWzi7p0wLW+tM1y7MPXYTkzL/HlWt74nReKKJvWkT5X/9GA6
	 nOBpd53fOCl3pVBmcKKiMLBFaa/BfIV75xbL8r1i8blgRG7uNwnltsLiDpY7YuYnq4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046565;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=bHrAuYfO9evY3XqOQE8n6WXXDGMIvXwvCH4MXSZnkYs=;
	b=thyx1dYaQJPJGxvxdpvW3a135GENpPlx1ro1mhkDsLVXsL1W+Q/qS3bWOBTHAaqhoUW6
	 ETpBR6+E6rO2sgv1a2C6KdHxkc/R9vIbmgkdnpAKIpCI85DJCo6bzRVGnLxwMnH9SWawC
	 OUL8r6C0y3zEzb2u/v2EPaTZbgTIPIkzQDAkFRKmJ2dRdw6AXUJQ5EwJTCagbleaMP3wz
	 RFDEto1VDWTKm4Vi/3LxT0O6y52yymFTnENHIXlN/5CCaDzmu6wM+TGZGahcwUptWaAEt
	 gNKdGFhvBZv/A/ZFZ5xyxCOtq+8YrtuMgWPdUPjlbYB/rcfRaV0RyM5VPUUyaPW0OIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Llfi803d;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8E6606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Llfi803d
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13F3E1F008A1;
	Sat,  7 Nov 2026 10:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046565;
	bh=bHrAuYfO9evY3XqOQE8n6WXXDGMIvXwvCH4MXSZnkYs=;
	h=From:To:Cc:Subject:Date;
	b=Llfi803dfrZHqRrDc+DrwhXSsT4ngCj00i5Fk1Zl9qCLdLHK/i5eDLcEWdGzvOhb3
	 7xa1J/rPbJGr0OaKS90QhIfDEu70M3UkNqd8JLcdg5//fhov53CbjhXBvEQIWBAcNu
	 xgwvIFmguRlD4odXZcPzAM7GnJMHALVBUYrUiQq/vRtz1wkU96oEgq9aPARP9wqprd
	 V5WMH3/CzybbFJixvEIvnI6qumP+RLOFhYpjYFqbpFaDZisdktheCS5c4Cu5pqucp0
	 4KiDijJ1BhdtD9YUftmhGsNAzH+urfiiBSIqaqlW9f5AyXrMUXIpmALfMAtHwdXIY2
	 bRzlsa37gatCg==
From: Sasha Levin <sashal@kernel.org>
To: brauner@kernel.org,
	yi1.lai@intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ns: don't add init_ipc_ns and init_net without namespace support" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:16:03 -0500
Message-ID: <20261107051603-failed-6.18-82f1c815aaef@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 82f1c815aaef1905c5c6c386c8a0d74f6ff70a54
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051603-failed-6.18-82f1c815aaef@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 82f1c815aaef1905c5c6c386c8a0d74f6ff70a54 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 30 Oct 2026 16:50:07 +0100
Subject: [PATCH] ns: don't add init_ipc_ns and init_net without namespace
 support

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
Link: https://patch.msgid.link/20261030-work-nsfs-init_ns_tree-v1-1-7ec0adb47c54@kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 ipc/namespace.c          | 7 +++++++
 ipc/shm.c                | 2 --
 net/core/net_namespace.c | 4 +++-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/ipc/namespace.c b/ipc/namespace.c
index 75aa7b4693484..b54d23fd83d70 100644
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
index bb1a721a3e746..cbab3d16cf70b 100644
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
index da5f881fbd3b9..52c2bd44778a8 100644
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
 
-- 
2.53.0




