Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC0637996C
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 11:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784634423; cv=none; b=HtVueNI9IUaamMu/reU/Ad8Pu/Z3sc9M/0uSQ+3w50G70sntvhhocb/0GaLHWMd/pbg/cwaWTiPJGaQf3eC75sslqhxiUfSA7SBIdmFmNxr5Xp/se6XM1tV7HulvLN3zjmz82hbZTUZOjCEpfgGQ+igCXYYnegHf4OB3vu5cF/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784634423; c=relaxed/simple;
	bh=p4UYlJfQsB1p8QWhZ0QA3bsMTEUUlcaWp82WgPIaygw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DIWmbyrLhdperznFUbSwxO+nIPI5nOb2hagafZ+sYFDyLOB9wv7R3pJeSHnfJn+pfiZ9hL5EfoFIM/nxcZaZuYI50zwnKxFmPi4c+fEAuhLS5rQdDW47sx0ssAzVOiV2IiV4duhzYGwz1vEEovk9qjo9+08onAkUC45JQmrJpFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g00UYkhJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g00UYkhJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5DE51F000E9;
	Tue, 21 Jul 2026 11:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784634422;
	bh=UjckwDbX46UIC+lePn7jY8cpY9W7Qxuew2mvY6AZgn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g00UYkhJJUR070JivKbawUha9MZfYFvuSNFrZQr52rJM3U90nXnNqYR4j/BFpfD7l
	 coR/FwIibFD9GPS4edhj085e/GdTbRBa0YVHR10xQPcRYdjmnpt1/KxCF9rsD1+fjl
	 b6mXrm+j5V+e+EgVFGF/R8aJd39DbmogGu97A4x/Q3uLFzR0NDR9aLcmW2jUJgCrdf
	 jh8igdYb8Lu/7cKHcoCvvm7vcphJwK0FOfQ/Qm5tqnRWF+49OJUNe+11AuRAK+tvur
	 4U2bNKdkhl8PPIGfUA48JSq0bN/SEYny6vEMdT1jJIvPGTX7BrX4dR5+jvUdQi7b3p
	 /ko6cRzOjvPmQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Matt Bobrowski <mattbobrowski@google.com>,
	oxsignal <awo@kakao.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Amery Hung <ameryhung@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] bpf: Reject BPF_MAP_TYPE_INODE_STORAGE creation if BPF LSM is uninitialized
Date: Tue, 21 Jul 2026 07:47:00 -0400
Message-ID: <20260721114700.3688104-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071658-valium-tidal-ddaa@gregkh>
References: <2026071658-valium-tidal-ddaa@gregkh>
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
index 643809cc78c33e..e4593b4a123824 100644
--- a/include/linux/bpf_lsm.h
+++ b/include/linux/bpf_lsm.h
@@ -14,6 +14,8 @@
 
 #ifdef CONFIG_BPF_LSM
 
+extern bool bpf_lsm_initialized __ro_after_init;
+
 #define LSM_HOOK(RET, DEFAULT, NAME, ...) \
 	RET bpf_lsm_##NAME(__VA_ARGS__);
 #include <linux/lsm_hook_defs.h>
@@ -55,6 +57,8 @@ bool bpf_lsm_has_d_inode_locked(const struct bpf_prog *prog);
 
 #else /* !CONFIG_BPF_LSM */
 
+#define bpf_lsm_initialized false
+
 static inline bool bpf_lsm_is_sleepable_hook(u32 btf_id)
 {
 	return false;
diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
index e54cce2b91754c..97c3e8f1a929a3 100644
--- a/kernel/bpf/bpf_inode_storage.c
+++ b/kernel/bpf/bpf_inode_storage.c
@@ -181,6 +181,15 @@ static int notsupp_get_next_key(struct bpf_map *map, void *key,
 
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
index db759025abe11f..9ea9eb9c5d25ee 100644
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
-- 
2.53.0

