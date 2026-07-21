Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A5547143A
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 18:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784659725; cv=none; b=mGyOnE9SI9q2DazehJ9Chn98O/XaGX2iOJAb9vxGPWQVPJ9SZKqYLfR4y+Zt+ed9O08QuVqzCiEN1HIjSl9g911hk17pzWgnlPCmrZNIjybngXLqtkT4G/lh8ChlwEGu8XPkpPhvh91hs7uf8d5YK5hGT8vvOap1is3jCA+MzA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784659725; c=relaxed/simple;
	bh=o381dTyWtlo3tp0VlT5P1IdvLGd2YwAKnzUlEsEYxR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rGueBDjjV9UWhkUlgMXoi+qDJ6ZRkIlo+gniUqPtXH1VTsdN+Xp1m5jK6jC+H04Vt/SJlJJDByAE6N8e7ziqi5NoMyrtZcD9Iy+g8KtiZCKxn2vasai19Wsm4v2JLZ8IteSrghtgQ4ULsQpzg7BxIFEWjNwpl8iOBKQ+Sg5QM/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6tvkteR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6tvkteR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B55B21F000E9;
	Tue, 21 Jul 2026 18:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784659722;
	bh=eFeRa9HaE4qCgCxWb0oYp8IxTnQmVhyjZAs1nSTY6/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E6tvkteRmtgvRPhSUnrm4Q526q5/gAK7/Bg911vf0MAFJfNYW6DwOWJwSrvp3c08v
	 cH3LnZ8ab2w2Nf7aVkuvoQ4Yn/LxrhVUNl1SDYNXK3xr54H7fXWlm7wnFpEjrE8S48
	 ZUtW6LpF8ZVEgzNbo6sn7RAVC2DK5IMy0eDvoNx6gF8zOR/F8a27zt/CxRpR/q154o
	 tsXG8/8y8NlICmf5I2ByMRdHhVXQvOFgFvCET24M4mCnEngtrdheX9LNqyKwC4kf3S
	 bnkiZ02ahcw/vTtqiGgzasALHSsQs7uUVBAki7evRN9mb2X3P/1hvOK2asLqBRIxH1
	 X1luzCQbTNgQg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Matt Bobrowski <mattbobrowski@google.com>,
	oxsignal <awo@kakao.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Amery Hung <ameryhung@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] bpf: Reject BPF_MAP_TYPE_INODE_STORAGE creation if BPF LSM is uninitialized
Date: Tue, 21 Jul 2026 14:48:40 -0400
Message-ID: <20260721184840.382217-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071601-concerned-arousal-ac66@gregkh>
References: <2026071601-concerned-arousal-ac66@gregkh>
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
 include/linux/bpf_lsm.h        |  4 ++++
 kernel/bpf/bpf_inode_storage.c | 10 ++++++++++
 security/bpf/hooks.c           |  3 +++
 3 files changed, 17 insertions(+)

diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
index aaacb6aafc87e8..df992a81e31111 100644
--- a/include/linux/bpf_lsm.h
+++ b/include/linux/bpf_lsm.h
@@ -12,6 +12,8 @@
 
 #ifdef CONFIG_BPF_LSM
 
+extern bool bpf_lsm_initialized __ro_after_init;
+
 #define LSM_HOOK(RET, DEFAULT, NAME, ...) \
 	RET bpf_lsm_##NAME(__VA_ARGS__);
 #include <linux/lsm_hook_defs.h>
@@ -41,6 +43,8 @@ void bpf_inode_storage_free(struct inode *inode);
 
 #else /* !CONFIG_BPF_LSM */
 
+#define bpf_lsm_initialized false
+
 static inline int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
 				      const struct bpf_prog *prog)
 {
diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
index a4ac48c7dada12..4fd82425febaf1 100644
--- a/kernel/bpf/bpf_inode_storage.c
+++ b/kernel/bpf/bpf_inode_storage.c
@@ -223,6 +223,16 @@ static struct bpf_map *inode_storage_map_alloc(union bpf_attr *attr)
 {
 	struct bpf_local_storage_map *smap;
 
+	/*
+	 * Do not allow allocation of BPF_MAP_TYPE_INODE_STORAGE if the BPF LSM
+	 * was not initialized by the LSM framework at boot. Without proper
+	 * initialization, the BPF inode security blob offset remains unprepared,
+	 * causing bpf_inode() to calculate an invalid memory offset and corrupt
+	 * inode->i_security.
+	 */
+	if (!bpf_lsm_initialized)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	smap = bpf_local_storage_map_alloc(attr);
 	if (IS_ERR(smap))
 		return ERR_CAST(smap);
diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
index 788667d582ae57..18f6ceccbfba65 100644
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
@@ -17,6 +19,7 @@ static struct security_hook_list bpf_lsm_hooks[] __lsm_ro_after_init = {
 static int __init bpf_lsm_init(void)
 {
 	security_add_hooks(bpf_lsm_hooks, ARRAY_SIZE(bpf_lsm_hooks), "bpf");
+	bpf_lsm_initialized = true;
 	pr_info("LSM support for eBPF active\n");
 	return 0;
 }
-- 
2.53.0

