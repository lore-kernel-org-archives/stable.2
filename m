Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62BA34D911
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 15:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784387612; cv=none; b=XwBSVCc7cPmuNGRC8zDarIPZ4QxzbvEPbqdE9CE5cL2YY9KFi+fER69PEx2kXaojdi8EaqZEE37HDJlG5E6a1SL0NPVQwT8pVoIgf4mFskzXuq8Udu5Gqh2w4QwflMMn2sklAIsyBQHq7xSHhiUPh9bRn6PeE6tyHWMVFMGsGKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784387612; c=relaxed/simple;
	bh=85P8vyqQJGtyaWVMfvv5Arwyk6of9ovWXc4r4W060Lk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZCcyKsP63849hsM2eKP1GzNetHuUhyHIRvcrMesnzapPf9d2QFPscfTzl4u7BrQZQzXibUUjRx/q+96PfX7+TFPm2j9s2VZMaHREp+rzzT36I68a1NdIxiB2VrXQUKASuil3lI6yQRjQt6W79OtsdAqLlCXmNaGxEXmdHV83PFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cqp42fD/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cqp42fD/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0F6B1F000E9;
	Sat, 18 Jul 2026 15:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784387611;
	bh=CWBojM2pmya8WysBbM2uNFdAQ1Tl4aZ8amal+pMT6/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Cqp42fD/TCZRtuXT9/PORP1V/DjviQ+lOG8pgyns55Cs1T9EAIdLt9SXK0AtUJMbA
	 Evp+djSrKIvTQ3Z8kZgsFJRU+09r/WZfBqyJIli9vJRO+It2GckjR0620NR2FTwyIn
	 0fvtRGVoxboFln3SFxyPh31fQiWDdFcPXhSFMHhfMuWcXD93cMa3uXpOyt2h+Z3pT2
	 ZqzRLlh539jJtNsTNcO2AKMtZre76pALsBxL5M1brt6fPBRcPfN6/In0rPShX+xlPS
	 DYb77j6F/CeifhVmHJTVV27vyk7fzePjYXRQAJj3TSzmwnTu6w++kqEgN4+DFk/O+8
	 RqShV8QQZ82mA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/4] bpf: Convert lpm_trie.c to rqspinlock
Date: Sat, 18 Jul 2026 11:13:26 -0400
Message-ID: <20260718151329.3271163-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071449-absurd-charm-2576@gregkh>
References: <2026071449-absurd-charm-2576@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kumar Kartikeya Dwivedi <memxor@gmail.com>

[ Upstream commit 47979314c0fe245ed54306e2f91b3f819c7c0f9f ]

Convert all LPM trie usage of raw_spinlock to rqspinlock.

Note that rcu_dereference_protected in trie_delete_elem is switched over
to plain rcu_dereference, the RCU read lock should be held from BPF
program side or eBPF syscall path, and the trie->lock is just acquired
before the dereference. It is not clear the reason the protected variant
was used from the commit history, but the above reasoning makes sense so
switch over.

Closes: https://lore.kernel.org/lkml/000000000000adb08b061413919e@google.com
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Link: https://lore.kernel.org/r/20250316040541.108729-22-memxor@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Stable-dep-of: 2f884d371faf ("bpf: Allow LPM map access from sleepable BPF programs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/lpm_trie.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index 010e91ac978e62..fd8983d542af76 100644
--- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -15,6 +15,7 @@
 #include <net/ipv6.h>
 #include <uapi/linux/btf.h>
 #include <linux/btf_ids.h>
+#include <linux/bpf_local_storage.h>
 
 /* Intermediate node */
 #define LPM_TREE_NODE_FLAG_IM BIT(0)
@@ -361,8 +362,7 @@ static long trie_update_elem(struct bpf_map *map,
 	 */
 	slot = &trie->root;
 
-	while ((node = rcu_dereference_protected(*slot,
-					lockdep_is_held(&trie->lock)))) {
+	while ((node = rcu_dereference(*slot))) {
 		matchlen = longest_prefix_match(trie, node, key);
 
 		if (node->prefixlen != matchlen ||
@@ -483,8 +483,7 @@ static long trie_delete_elem(struct bpf_map *map, void *_key)
 	trim = &trie->root;
 	trim2 = trim;
 	parent = NULL;
-	while ((node = rcu_dereference_protected(
-		       *trim, lockdep_is_held(&trie->lock)))) {
+	while ((node = rcu_dereference(*trim))) {
 		matchlen = longest_prefix_match(trie, node, key);
 
 		if (node->prefixlen != matchlen ||
-- 
2.53.0

