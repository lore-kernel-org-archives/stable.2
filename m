Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F0C22D7A9
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 05:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784178554; cv=none; b=iqivyKv3AV6RL1Wc7X5IIbfms0gtTeaHQkS5Fpx28laHFKbgUFHnrzhEpdFY5vBaHjRZ18qY/UUr4MFj+mazAKtBat1Ei7/39HR2p7AaRuk59nURB/UXy0mT5edZQ2J6aa7ZXzPN9QyZRjgGrqGwJUfSY7y41Uqtr1gn0yWN7JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784178554; c=relaxed/simple;
	bh=V5AmDrijMVctHQcyyFaoUyHcZ5hC7kDZSvKEAm5cQkk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XnOooANWvBsIdQAnOrFdbzGJVdjJ9LtOe+9uLnetXjcP2CFf42e7mhjQtYLrw8L0Qlh6a/Eg0+GG1r43D8VmHDyYZeU2VDnb5WAiXyZg8Pz0o1ORH6uSYuWlo/PbWA/ArV2YU5hAHivs8iHYKGTgr37g5n8jF5sgxNTovd6PeHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HPzj7QI0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HPzj7QI0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B24C91F000E9;
	Thu, 16 Jul 2026 05:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784178553;
	bh=pa6fG26lkoyURD6a3YFmgsz76N9jWkRmwHALi/5+g4c=;
	h=Subject:To:Cc:From:Date;
	b=HPzj7QI0xORG3ucEGQXKW7UrnDFOo+9HmUwEoc9skvdwG48mbjyv+OU83kwHN77ze
	 tb4fF165Batz36Oc1SXQy+DU8s664zDoHtGErEzbxHqgPSzLg0YtMxfv/IeCjEo767
	 OUEjQ4FyojOOY0k3HzSeGKYz8rMtqruve8E4S4ZI=
Subject: FAILED: patch "[PATCH] bpf: Reject BPF_MAP_TYPE_INODE_STORAGE creation if BPF LSM is" failed to apply to 5.15-stable tree
To: mattbobrowski@google.com,ameryhung@gmail.com,awo@kakao.com,daniel@iogearbox.net,emil@etsalapatis.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Jul 2026 07:09:00 +0200
Message-ID: <2026071600-jogging-both-cf4d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x a6f0643e4f63cfaa0d5d4a69de4f132eac4b8fe4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071600-jogging-both-cf4d@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a6f0643e4f63cfaa0d5d4a69de4f132eac4b8fe4 Mon Sep 17 00:00:00 2001
From: Matt Bobrowski <mattbobrowski@google.com>
Date: Sun, 28 Jun 2026 20:11:03 +0000
Subject: [PATCH] bpf: Reject BPF_MAP_TYPE_INODE_STORAGE creation if BPF LSM is
 uninitialized

When CONFIG_BPF_LSM=y is set, BPF inode storage maps
(BPF_MAP_TYPE_INODE_STORAGE) are compiled into the kernel. However,
if the BPF LSM is not explicitly enabled at boot time (e.g. omitted
from the "lsm=" boot parameter), lsm_prepare() is never executed for
the BPF LSM.

Consequently, the BPF inode security blob offset
(bpf_lsm_blob_sizes.lbs_inode) is never initialized and remains at
its default compiled size of 8 bytes instead of being updated to a
valid offset past the reserved struct rcu_head (typically 16 bytes
or more).

When a privileged user creates and updates a BPF_MAP_TYPE_INODE_STORAGE
map, bpf_inode() evaluates inode->i_security + 8. This erroneously
aliases the struct rcu_head.func callback pointer at the beginning
of the inode->i_security blob. During subsequent map element cleanup
or inode destruction, writing NULL to owner_storage clears the queued
RCU callback pointer. When rcu_do_batch() later executes the queued
callback, it attempts an instruction fetch at address 0x0, triggering
an immediate kernel panic.

Fix this by introducing a global bpf_lsm_initialized boolean flag
marked with __ro_after_init. Set this flag to true inside bpf_lsm_init()
when the LSM framework successfully registers the BPF LSM. Gate map
allocation in inode_storage_map_alloc() on this flag, returning
-EOPNOTSUPP if the BPF LSM is in turn uninitialized.

This fail-fast approach prevents userspace from allocating inode
storage maps when the supporting BPF LSM infrastructure is absent,
avoiding zombie map states.

Fixes: 8ea636848aca ("bpf: Implement bpf_local_storage for inodes")
Reported-by: oxsignal <awo@kakao.com>
Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Reviewed-by: Amery Hung <ameryhung@gmail.com>
Link: https://lore.kernel.org/bpf/20260628201103.3624525-1-mattbobrowski@google.com

diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
index 143775a27a2a..dda272d78f01 100644
--- a/include/linux/bpf_lsm.h
+++ b/include/linux/bpf_lsm.h
@@ -14,6 +14,8 @@
 
 #ifdef CONFIG_BPF_LSM
 
+extern bool bpf_lsm_initialized __ro_after_init;
+
 #define LSM_HOOK(RET, DEFAULT, NAME, ...) \
 	RET bpf_lsm_##NAME(__VA_ARGS__);
 #include <linux/lsm_hook_defs.h>
@@ -56,6 +58,8 @@ bool bpf_lsm_hook_returns_errno(u32 btf_id);
 
 #else /* !CONFIG_BPF_LSM */
 
+#define bpf_lsm_initialized false
+
 static inline bool bpf_lsm_is_sleepable_hook(u32 btf_id)
 {
 	return false;
diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
index 0da8d923e39d..f9e81060c1f4 100644
--- a/kernel/bpf/bpf_inode_storage.c
+++ b/kernel/bpf/bpf_inode_storage.c
@@ -178,6 +178,15 @@ static int notsupp_get_next_key(struct bpf_map *map, void *key,
 
 static struct bpf_map *inode_storage_map_alloc(union bpf_attr *attr)
 {
+	/*
+	 * Do not allow allocation of BPF_MAP_TYPE_INODE_STORAGE if the BPF LSM
+	 * was not initialized by the LSM framework at boot. Without proper
+	 * initialization, the BPF inode security blob offset remains unprepared,
+	 * causing bpf_inode() to calculate an invalid memory offset and corrupt
+	 * inode->i_security.
+	 */
+	if (!bpf_lsm_initialized)
+		return ERR_PTR(-EOPNOTSUPP);
 	return bpf_local_storage_map_alloc(attr, &inode_cache);
 }
 
diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
index 40efde233f3a..7b98f5d1e2be 100644
--- a/security/bpf/hooks.c
+++ b/security/bpf/hooks.c
@@ -7,6 +7,8 @@
 #include <linux/bpf_lsm.h>
 #include <uapi/linux/lsm.h>
 
+bool bpf_lsm_initialized __ro_after_init;
+
 static struct security_hook_list bpf_lsm_hooks[] __ro_after_init = {
 	#define LSM_HOOK(RET, DEFAULT, NAME, ...) \
 	LSM_HOOK_INIT(NAME, bpf_lsm_##NAME),
@@ -24,6 +26,7 @@ static int __init bpf_lsm_init(void)
 {
 	security_add_hooks(bpf_lsm_hooks, ARRAY_SIZE(bpf_lsm_hooks),
 			   &bpf_lsmid);
+	bpf_lsm_initialized = true;
 	pr_info("LSM support for eBPF active\n");
 	return 0;
 }

