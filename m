Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE57481FDF
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 11:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784635016; cv=none; b=Gn8wPf2rV1drJsC1LM229p8EqtEOZc30bJR5Txn4Azi2+Md3ZnKhNkbjoqNEd485klPDvPOQzX+eTSgQQFg/X9FcOAA6Z6RJmR+GYQiWkvvaH6sloW+JDzuBOEwXRnW1obeAebFD/cUW2V4UEMlfa6uMm8SZWy1IF2diWd38cmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784635016; c=relaxed/simple;
	bh=iCPg0l0fKWdRIcOsN9NvM+J5wYQ3XhLz4XoyDu0Ej4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KKfgeHTD5twcVMsSRDxDPrsLDXiwYGC4bd4DwO0gt1H3Ilvju7J5eO+qXo//n6s9ZtruqTOcCb/U2Kx0OWtV4KtxUP775Q/KpAVzx7pBCNoE77vqpszHVzdBY/rmc7NZnQ28f4eLj67YJYj4r6207AQWyEvfwfIeaK1M0uL3Pcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/jZqfIV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/jZqfIV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E0AF1F000E9;
	Tue, 21 Jul 2026 11:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784635014;
	bh=oTNAAoj2qEB1//9Xv4jky8QngvKgJKUF98Z9RF5UIXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U/jZqfIVH2miVxDO1jcIQy1/bPO8DJrLkWuhVqweFBNLtf+4UXkfR7VHtTClEzQiF
	 oLUJqfotQegoyrQ7XhIuo4YFUI/Wkjr6F4GRhv0ci8Z00dHtOtZ2m1ZdwS5nffcGr1
	 cgNNzUPlANvo6cHqgpPArrYhcK9iM38TE4jn5kBXg+mUpAK7XdiUX/UmF4bwwSzi+g
	 YmfHJzB4+rKTgOlZExk5+cc4Yk209YQE7SHX2aHNlhkDYLX2cKrh5RiPBksZKxkm6c
	 Z10gGLuUGmDo4vUfvRzUVFB+AKsj1jLu9dNDdbTsn0/uZEqy3TkTzM8+L7X1K2wwry
	 9fd65KeWzS14g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Matt Bobrowski <mattbobrowski@google.com>,
	oxsignal <awo@kakao.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Amery Hung <ameryhung@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] bpf: Reject BPF_MAP_TYPE_INODE_STORAGE creation if BPF LSM is uninitialized
Date: Tue, 21 Jul 2026 07:56:52 -0400
Message-ID: <20260721115652.3699691-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071658-connected-camisole-01ce@gregkh>
References: <2026071658-connected-camisole-01ce@gregkh>
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
index aefcd656425126..625f4926da534a 100644
--- a/include/linux/bpf_lsm.h
+++ b/include/linux/bpf_lsm.h
@@ -14,6 +14,8 @@
 
 #ifdef CONFIG_BPF_LSM
 
+extern bool bpf_lsm_initialized __ro_after_init;
+
 #define LSM_HOOK(RET, DEFAULT, NAME, ...) \
 	RET bpf_lsm_##NAME(__VA_ARGS__);
 #include <linux/lsm_hook_defs.h>
@@ -50,6 +52,8 @@ int bpf_lsm_get_retval_range(const struct bpf_prog *prog,
 			     struct bpf_retval_range *range);
 #else /* !CONFIG_BPF_LSM */
 
+#define bpf_lsm_initialized false
+
 static inline bool bpf_lsm_is_sleepable_hook(u32 btf_id)
 {
 	return false;
diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
index e16e79f8cd6dc3..564ba5f414f57c 100644
--- a/kernel/bpf/bpf_inode_storage.c
+++ b/kernel/bpf/bpf_inode_storage.c
@@ -182,6 +182,15 @@ static int notsupp_get_next_key(struct bpf_map *map, void *key,
 
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
 	return bpf_local_storage_map_alloc(attr, &inode_cache, false);
 }
 
diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
index 3663aec7bcbd21..aa1c7915ed2258 100644
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
@@ -25,6 +27,7 @@ static int __init bpf_lsm_init(void)
 {
 	security_add_hooks(bpf_lsm_hooks, ARRAY_SIZE(bpf_lsm_hooks),
 			   &bpf_lsmid);
+	bpf_lsm_initialized = true;
 	pr_info("LSM support for eBPF active\n");
 	return 0;
 }
-- 
2.53.0

