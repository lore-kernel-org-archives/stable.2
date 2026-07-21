Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD963471245
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 18:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784656916; cv=none; b=Dzllg3uZzwzkwpCCCadYbE2iQpjrYQV/xcXvNiBMkR4a7FkMlqSyTZTHp53Gg6/8PouMawJIRPuyIVxeW1h67zXebLY4hu5YjGdoRnekqAG6zgh3Y4wA0FZdgL7qEBwu2+S/SHkS8hB1ldKA7Lv1noQUT28jpzEZXRClfeuZKqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784656916; c=relaxed/simple;
	bh=rB0JbjcIwCMINPAF/hIc4E0kY39Tgu0ftFhOTGE8pp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZSII2t5SIjDFxjFgDaEefuxYrkIM2isHF57Oj72ZvqEtIsAoVT9pFxWQ7R0PnpXZlHkjrYFbUAn2N2XIGHgyIuYbPp/YZta/pMk6UzO24GdP6t39ZONZhLUjSG6GILTPh4BWrZKLMlEbuj+sUnFvgYkfbVtPdaWGOeNqmJEZLzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Klyvm6zt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Klyvm6zt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5E671F000E9;
	Tue, 21 Jul 2026 18:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784656915;
	bh=nSfHicOS6F3KG0jAHUMB1ZlFhytKYSIM4tUeUSHeyq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Klyvm6zt/9cmo4BiiLeFwme3FxOCSNmA3YcH8aZedo47WjRo3exlHk7kF1+ZqCpZU
	 fZV8fv01sYqUaImocj5H1eyySw7c9CvZj0yaQc+7mJR4bPPs/H6ttL6zt4s135E5iN
	 4l2fRvPZe3AOj7e3vvHUW4bw6Q0o/mwlGFNIVPvOIDysAxecFbz4SQoSAmJ0oVZy7d
	 t6IMYa/foi+FcuXUtyBrlfiqkukLi9ieX/lc6JODkHyTCEUzUifPHiUxcXJZDBdX3I
	 9nztcr5XNqIAMxJhFqOAnAcANBIFh4DvrCvPqhP9XSTkJNQSCrgYkA86QR7KkxqNkH
	 Kn8QrcVdyOW8w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Matt Bobrowski <mattbobrowski@google.com>,
	oxsignal <awo@kakao.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Amery Hung <ameryhung@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] bpf: Reject BPF_MAP_TYPE_INODE_STORAGE creation if BPF LSM is uninitialized
Date: Tue, 21 Jul 2026 14:01:53 -0400
Message-ID: <20260721180153.286603-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071600-jogging-both-cf4d@gregkh>
References: <2026071600-jogging-both-cf4d@gregkh>
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
index 479c101546ad1f..46fc668f2ef1cb 100644
--- a/include/linux/bpf_lsm.h
+++ b/include/linux/bpf_lsm.h
@@ -13,6 +13,8 @@
 
 #ifdef CONFIG_BPF_LSM
 
+extern bool bpf_lsm_initialized __ro_after_init;
+
 #define LSM_HOOK(RET, DEFAULT, NAME, ...) \
 	RET bpf_lsm_##NAME(__VA_ARGS__);
 #include <linux/lsm_hook_defs.h>
@@ -44,6 +46,8 @@ void bpf_inode_storage_free(struct inode *inode);
 
 #else /* !CONFIG_BPF_LSM */
 
+#define bpf_lsm_initialized false
+
 static inline bool bpf_lsm_is_sleepable_hook(u32 btf_id)
 {
 	return false;
diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
index 96ceed0e0fb57e..ab35f1b6600843 100644
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

