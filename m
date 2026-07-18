Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069523559F8
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 21:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784411431; cv=none; b=hNHrk58XnbAovHOQv2Nedcehgs75Ct6ZQ7JSql9Uzi8BveZX+j8CHdjZE7VQ3iYuPiFX6AJiZf/PT4AexLfBJHmv1tyAqzvXsNZX0U3HKgB2RZUSnHuu57OST0EymQ/0TAyCtCZ3NocjZkUMs6llKMnfsXII23K71MW0qXyqwTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784411431; c=relaxed/simple;
	bh=HsSRDJjj4N9+sN6sLtuF8xHjTogCSe8tp1NyZ/rGXxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uJDjEsA/04Pk6m3NoyZQAwZtXmvA6WhtAKEDAx9tG2gDA1TWNkSh1rX9rsUBbJglsVGp7s3ONNGEnfOtaewPlQCWedeZnwkBnhAxcSuwPWFTRJI34ZtX3wKs3ovKO/SpnaZ5RlWsY9ZEXL/HLGWlsTec/3kWsolhtAl3jdZ6KYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CRqWCeJE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CRqWCeJE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69E5B1F000E9;
	Sat, 18 Jul 2026 21:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784411429;
	bh=guf4e/toUzYgSJ8lqTlKKRBxzLcCMzEwIoltJw17Xxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CRqWCeJEojd4+UaajrAv4alAs7Syr8IDOkAVg+YWTAhMQ3rbkkXZDrdrRln+iWTU4
	 Ns2EXrAE5XbwiukICqT0zyABK3c0Op0UZTYL/QkpP3FZsGIqCSJ2BVg0bgk39bPuFh
	 sPfZa/56GX3/5hR19bArPbIwwNaZSA0kddgNm2Bsw+FmgAFRWctc2i0kBAABfimrpO
	 h7I331LdnRoC78okChI6Vw7e8PJEJEpu6eB9pEv9oJvwEPSNzhVbQsJWbAy6vz9iXO
	 e57CATRAumSmPazpGG1E52Qs402MCmd+LYLLE+8K+nHJQqRjdEEiLOXTVoWYjlLLiI
	 jL5+njVGp9tOA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] bpf: Convert lpm_trie.c to rqspinlock
Date: Sat, 18 Jul 2026 17:50:26 -0400
Message-ID: <20260718215027.3447522-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071450-landmine-pouring-a4f5@gregkh>
References: <2026071450-landmine-pouring-a4f5@gregkh>
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
index c4f1d465ae35c3..15c2525900fa31 100644
--- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -15,6 +15,7 @@
 #include <net/ipv6.h>
 #include <uapi/linux/btf.h>
 #include <linux/btf_ids.h>
+#include <linux/bpf_local_storage.h>
 
 /* Intermediate node */
 #define LPM_TREE_NODE_FLAG_IM BIT(0)
@@ -353,8 +354,7 @@ static long trie_update_elem(struct bpf_map *map,
 	 */
 	slot = &trie->root;
 
-	while ((node = rcu_dereference_protected(*slot,
-					lockdep_is_held(&trie->lock)))) {
+	while ((node = rcu_dereference(*slot))) {
 		matchlen = longest_prefix_match(trie, node, key);
 
 		if (node->prefixlen != matchlen ||
@@ -475,8 +475,7 @@ static long trie_delete_elem(struct bpf_map *map, void *_key)
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

