Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D9F43F0A1
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 16:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784392769; cv=none; b=BD/ram4HH/cJ9c8tfMImbSjRpiurRim/X3V7pwiGhUHqIgMP/7HaYdrvvnCKoPgh99vAtDYJ0pSs53BtXQqDj9+ogmOthf58YSkIGYGUtPGQJ8fbqT/XyERcc+ONVlBwsjvTFmOK7FJ5RB3Tan6q7XYq0m3WYStkqYHg/pz67p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784392769; c=relaxed/simple;
	bh=8EKeciGHkYFOuwFx0YoaNIm53a+eXeNrq7amHrzxGDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XEnXedildZPzAAyyTV8uZt+B6KjD49C1PtAuFjwc+Wn5miwpWhRb+FyDCarfS7VYu4n1CdX9+vWCqrWwRaF1SchZsrxwEzxau+dn7pnHMQYW4qu4ASWHf1uuIDjF9JJl62X2JMaYkuXDiAw0qzL7C+vd7xcKDK1vm/yYJ13hORE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l1WI6wOu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l1WI6wOu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 441511F000E9;
	Sat, 18 Jul 2026 16:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784392767;
	bh=puopkEFUW38EfvI3gkhIuijDpfxqFJFMfSXilqnNeEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l1WI6wOubi2KA33GLClRlrSOUK/64VGUCm+T32Mffs057RiDzN0pwRL9da0kTJTjK
	 Gebp9Sf/0ypFJfUUvnqK8pMbLl30pKX/ecF311w9fLhcRm0snMlxfEiTlWSh1PSDRm
	 68rC+jZgAwXFmXtrUOTc6f22xsHh14TMOafw7ROVQ6okWHcu2TfV4b1PEd4KLevz9a
	 KgxeHmznUkro7c4ThZF0sfFkQm3h4RFA7pfxH/XgIg9x2E3abnaBSaBGir6dZIIiPS
	 xd8M63TLLWNP/hZ0EFive3GxoWg6M5q8A+SBEZo94Hi+0TgubfMZzaYieoqVAYQMjE
	 UiTqjpyOXTTiQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jiri Olsa <jolsa@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] bpf: Consistently use bpf_rcu_lock_held() everywhere
Date: Sat, 18 Jul 2026 12:39:24 -0400
Message-ID: <20260718163925.3343620-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071450-emerald-washer-7a87@gregkh>
References: <2026071450-emerald-washer-7a87@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andrii Nakryiko <andrii@kernel.org>

[ Upstream commit 48a97ffc6c826640907d13b199e29008f4fe2c15 ]

We have many places which open-code what's now is bpf_rcu_lock_held()
macro, so replace all those places with a clean and short macro invocation.
For that, move bpf_rcu_lock_held() macro into include/linux/bpf.h.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: https://lore.kernel.org/bpf/20251014201403.4104511-1-andrii@kernel.org
Stable-dep-of: 2f884d371faf ("bpf: Allow LPM map access from sleepable BPF programs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/bpf.h               |  3 +++
 include/linux/bpf_local_storage.h |  3 ---
 kernel/bpf/hashtab.c              | 21 +++++++--------------
 kernel/bpf/helpers.c              | 12 ++++--------
 kernel/bpf/lpm_trie.c             |  6 ++----
 5 files changed, 16 insertions(+), 29 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 3045de8e3f6602..436d862682916b 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1722,6 +1722,9 @@ bpf_prog_run_array_sleepable(const struct bpf_prog_array __rcu *array_rcu,
 	return ret;
 }
 
+#define bpf_rcu_lock_held() \
+	(rcu_read_lock_held() || rcu_read_lock_trace_held() || rcu_read_lock_bh_held())
+
 #ifdef CONFIG_BPF_SYSCALL
 DECLARE_PER_CPU(int, bpf_prog_active);
 extern struct mutex bpf_stats_enabled_mutex;
diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index 6d37a40cd90e8d..bcc6919f2ce414 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -17,9 +17,6 @@
 
 #define BPF_LOCAL_STORAGE_CACHE_SIZE	16
 
-#define bpf_rcu_lock_held()                                                    \
-	(rcu_read_lock_held() || rcu_read_lock_trace_held() ||                 \
-	 rcu_read_lock_bh_held())
 struct bpf_local_storage_map_bucket {
 	struct hlist_head list;
 	raw_spinlock_t lock;
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 06bc7f26be06f1..b2f207a5dd4fd9 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -670,8 +670,7 @@ static void *__htab_map_lookup_elem(struct bpf_map *map, void *key)
 	struct htab_elem *l;
 	u32 hash, key_size;
 
-	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
-		     !rcu_read_lock_bh_held());
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
 
 	key_size = map->key_size;
 
@@ -1088,8 +1087,7 @@ static int htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 		/* unknown flags */
 		return -EINVAL;
 
-	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
-		     !rcu_read_lock_bh_held());
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
 
 	key_size = map->key_size;
 
@@ -1190,8 +1188,7 @@ static int htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value,
 		/* unknown flags */
 		return -EINVAL;
 
-	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
-		     !rcu_read_lock_bh_held());
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
 
 	key_size = map->key_size;
 
@@ -1259,8 +1256,7 @@ static int __htab_percpu_map_update_elem(struct bpf_map *map, void *key,
 		/* unknown flags */
 		return -EINVAL;
 
-	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
-		     !rcu_read_lock_bh_held());
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
 
 	key_size = map->key_size;
 
@@ -1314,8 +1310,7 @@ static int __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
 		/* unknown flags */
 		return -EINVAL;
 
-	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
-		     !rcu_read_lock_bh_held());
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
 
 	key_size = map->key_size;
 
@@ -1390,8 +1385,7 @@ static int htab_map_delete_elem(struct bpf_map *map, void *key)
 	u32 hash, key_size;
 	int ret;
 
-	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
-		     !rcu_read_lock_bh_held());
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
 
 	key_size = map->key_size;
 
@@ -1426,8 +1420,7 @@ static int htab_lru_map_delete_elem(struct bpf_map *map, void *key)
 	u32 hash, key_size;
 	int ret;
 
-	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
-		     !rcu_read_lock_bh_held());
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
 
 	key_size = map->key_size;
 
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index a19524c672012e..cf422c80b30b30 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -33,8 +33,7 @@
  */
 BPF_CALL_2(bpf_map_lookup_elem, struct bpf_map *, map, void *, key)
 {
-	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
-		     !rcu_read_lock_bh_held());
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
 	return (unsigned long) map->ops->map_lookup_elem(map, key);
 }
 
@@ -50,8 +49,7 @@ const struct bpf_func_proto bpf_map_lookup_elem_proto = {
 BPF_CALL_4(bpf_map_update_elem, struct bpf_map *, map, void *, key,
 	   void *, value, u64, flags)
 {
-	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
-		     !rcu_read_lock_bh_held());
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
 	return map->ops->map_update_elem(map, key, value, flags);
 }
 
@@ -68,8 +66,7 @@ const struct bpf_func_proto bpf_map_update_elem_proto = {
 
 BPF_CALL_2(bpf_map_delete_elem, struct bpf_map *, map, void *, key)
 {
-	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
-		     !rcu_read_lock_bh_held());
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
 	return map->ops->map_delete_elem(map, key);
 }
 
@@ -125,8 +122,7 @@ const struct bpf_func_proto bpf_map_peek_elem_proto = {
 
 BPF_CALL_3(bpf_map_lookup_percpu_elem, struct bpf_map *, map, void *, key, u32, cpu)
 {
-	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
-		     !rcu_read_lock_bh_held());
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
 	return (unsigned long) map->ops->map_lookup_percpu_elem(map, key, cpu);
 }
 
diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index fd6e31e7229080..c88b3d24537ee0 100644
--- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -353,8 +353,7 @@ static int trie_update_elem(struct bpf_map *map,
 	 */
 	slot = &trie->root;
 
-	while ((node = rcu_dereference_protected(*slot,
-					lockdep_is_held(&trie->lock)))) {
+	while ((node = rcu_dereference_protected(*slot, 1))) {
 		matchlen = longest_prefix_match(trie, node, key);
 
 		if (node->prefixlen != matchlen ||
@@ -475,8 +474,7 @@ static int trie_delete_elem(struct bpf_map *map, void *_key)
 	trim = &trie->root;
 	trim2 = trim;
 	parent = NULL;
-	while ((node = rcu_dereference_protected(
-		       *trim, lockdep_is_held(&trie->lock)))) {
+	while ((node = rcu_dereference_protected(*trim, 1))) {
 		matchlen = longest_prefix_match(trie, node, key);
 
 		if (node->prefixlen != matchlen ||
-- 
2.53.0

