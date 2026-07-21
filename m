Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B9E38399A
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 17:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784653984; cv=none; b=EYi5xnWF10Ryvyun4TeAimR5Ayl81T/lmJ1FxBZcnkJUyGQ8BMLoK2WqfXm2NlsOo2KKqxE7knX7m3+gWcEdizmyS3cLztAo0xMUs+OpSBOBDgnoW1DIfxf3Mm77WkaS5ibTU2rI3sQNYQiMG+nymynBV9nfUiSil800wHDKY60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784653984; c=relaxed/simple;
	bh=wcUesLVBDTgvsa43F1yyid1Es9ht+Inazn5h0/eBPTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PG2NES0Pu3+XtbUAQ+t4Gvdy9eeFEV0zzuP7giUa33gB4zXSMuprEwesM45yHZTsM93BWVcryFgJisRFqhIi5LVNPFyVbibqkAKrbRwCMpR3mHu4Ec+eb0/jU/ItIZ9ZVDCICgNYrJQg99smPDXfIeCOCqQwL6IfMj6qsenOtTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BCEe3Pib; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCEe3Pib"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9F2E1F000E9;
	Tue, 21 Jul 2026 17:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784653983;
	bh=5dhKmCPfYZEFiYEEltmE8rxirDohCOluatkij9kQHk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BCEe3PibL0oPPxu7EnPmDtJCJp+ToNypVFCgeJnzxMWoFoWfJz46wY71ycxpVJ2rs
	 IxwJReiS3m5pxLh0rzyFezl/eHFE6poMjHpFchmRmWwQNCT51WBB6cL3R2326ZkkY1
	 m8z5apbI3O6E+An6zF/UVEreV/wDOs10ZeT24bQG2Y0WKaBJphyz93sQ5NTh/ZJSc2
	 cNT7UdHbCkBgXFnaVR3Hz8ecuc1n70bZgPXB1/aF3cDrFqOPJRS1eT022nxTZm0c0t
	 wHXkoCYS0FUDMtuqsvrWHNfMpJtLI49R9mN3Ut8FO8C3q4VTNLOXT9AJBqUc0b7b6o
	 EMmuEDGApDOMA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Matt Bobrowski <mattbobrowski@google.com>,
	oxsignal <awo@kakao.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Amery Hung <ameryhung@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] bpf: Reject BPF_MAP_TYPE_INODE_STORAGE creation if BPF LSM is uninitialized
Date: Tue, 21 Jul 2026 13:13:01 -0400
Message-ID: <20260721171301.107818-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071600-rerun-dynasty-3ff4@gregkh>
References: <2026071600-rerun-dynasty-3ff4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matt Bobrowski <mattbobrowski@google.com>

[ Upstream commit a6f0643e4f63cfaa0d5d4a69de4f132eac4b8fe4 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/bpf_lsm.h        | 4 ++++
 kernel/bpf/bpf_inode_storage.c | 9 +++++++++
 security/bpf/hooks.c           | 3 +++
 3 files changed, 16 insertions(+)

diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
index 4bcf76a9bb0664..e775990d66133e 100644
--- a/include/linux/bpf_lsm.h
+++ b/include/linux/bpf_lsm.h
@@ -13,6 +13,8 @@
 
 #ifdef CONFIG_BPF_LSM
 
+extern bool bpf_lsm_initialized __ro_after_init;
+
 #define LSM_HOOK(RET, DEFAULT, NAME, ...) \
 	RET bpf_lsm_##NAME(__VA_ARGS__);
 #include <linux/lsm_hook_defs.h>
@@ -46,6 +48,8 @@ void bpf_lsm_find_cgroup_shim(const struct bpf_prog *prog, bpf_func_t *bpf_func)
 
 #else /* !CONFIG_BPF_LSM */
 
+#define bpf_lsm_initialized false
+
 static inline bool bpf_lsm_is_sleepable_hook(u32 btf_id)
 {
 	return false;
diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
index 6a1d4d22816a35..e24cec2a4795bf 100644
--- a/kernel/bpf/bpf_inode_storage.c
+++ b/kernel/bpf/bpf_inode_storage.c
@@ -205,6 +205,15 @@ static int notsupp_get_next_key(struct bpf_map *map, void *key,
 
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
index d2925f43121616..f52ddcea0bd051 100644
--- a/security/bpf/hooks.c
+++ b/security/bpf/hooks.c
@@ -6,6 +6,8 @@
 #include <linux/lsm_hooks.h>
 #include <linux/bpf_lsm.h>
 
+bool bpf_lsm_initialized __ro_after_init;
+
 static struct security_hook_list bpf_lsm_hooks[] __lsm_ro_after_init = {
 	#define LSM_HOOK(RET, DEFAULT, NAME, ...) \
 	LSM_HOOK_INIT(NAME, bpf_lsm_##NAME),
@@ -18,6 +20,7 @@ static struct security_hook_list bpf_lsm_hooks[] __lsm_ro_after_init = {
 static int __init bpf_lsm_init(void)
 {
 	security_add_hooks(bpf_lsm_hooks, ARRAY_SIZE(bpf_lsm_hooks), "bpf");
+	bpf_lsm_initialized = true;
 	pr_info("LSM support for eBPF active\n");
 	return 0;
 }
-- 
2.53.0

