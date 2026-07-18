Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2780F2771B
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 11:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784375085; cv=none; b=kT7zYqRMoxZZBrWtuXMWH4dC39euh5wmm5A5PDrvl+/5L56DC01ZTVnccVUAGfJFVynTbWt5JHwd47WKM/CbT6mvIfefpvnos3Qp4D9trL3d0F+yDcOGNy9TiILvuRte+FyVdpBRqK0VZSH+63ROgcqQIP3iqU09kFur+4zJ9m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784375085; c=relaxed/simple;
	bh=gSO0yHQvdyAczgTrkYFKLcslwicC6k5EtmlVV56/HFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DscvA0SDH5N+A6scQxHkHA/KQMocCVElEa1klk+MMMEM0jot5o7ETGj1GTDVR4O8KVxGUQb+wIaabmETdP1gTZzpDhT/mw6tp0bKc1s3l/hokEqw5qIUwf0dOGrw5BdnsgwB22xCjACOu8DnIIoYnDhus5luJYfBKeWcw+PSloQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQzW8Va3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQzW8Va3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39D8E1F000E9;
	Sat, 18 Jul 2026 11:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784375083;
	bh=J2WeXLShp0DrkQM2e1nYeYbjCSDBdtMn4nE6aA7PSP8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GQzW8Va3u4xXj85R2cK6UxzeT3+8zhn80DCclSEQcb6czbztzKSLyNkP+jZXXwOv7
	 XfFpseMUGWEF8R+61vYqSWcvOhoLEwY+28Ke4yBjDdeGaE7fa7uMlNaHms9H1RZ2j+
	 zBXL4qPaG5bpKU+ViWtRjnIo2BzGoF/Gm349Gq6f6WJ4dgYmqzaG6KRbjvuMzg9PV1
	 xNOXdVod6k+/pKaawWuDwqsREZEobOlkD4Fo4ObG048cE0vog3uXR/MWqvQ5uA54b1
	 7Xpwja8LyQUfE3xLazBvBhOz15NiQdbPfq+9cuv12Jxp2tL5ev5XfpFUrwEwMXGyon
	 cHYqBsCocISBw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jiri Olsa <jolsa@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] bpf: Consistently use bpf_rcu_lock_held() everywhere
Date: Sat, 18 Jul 2026 07:44:40 -0400
Message-ID: <20260718114441.3048017-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071429-contort-navy-4802@gregkh>
References: <2026071429-contort-navy-4802@gregkh>
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
 4 files changed, 14 insertions(+), 25 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index e2dd3a6d495afd..7ddc81cf77776a 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2374,6 +2374,9 @@ bpf_prog_run_array_uprobe(const struct bpf_prog_array *array,
 bool bpf_jit_bypass_spec_v1(void);
 bool bpf_jit_bypass_spec_v4(void);
 
+#define bpf_rcu_lock_held() \
+	(rcu_read_lock_held() || rcu_read_lock_trace_held() || rcu_read_lock_bh_held())
+
 #ifdef CONFIG_BPF_SYSCALL
 DECLARE_PER_CPU(int, bpf_prog_active);
 extern struct mutex bpf_stats_enabled_mutex;
diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index ab7244d8108f60..782f58feea3565 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -18,9 +18,6 @@
 
 #define BPF_LOCAL_STORAGE_CACHE_SIZE	16
 
-#define bpf_rcu_lock_held()                                                    \
-	(rcu_read_lock_held() || rcu_read_lock_trace_held() ||                 \
-	 rcu_read_lock_bh_held())
 struct bpf_local_storage_map_bucket {
 	struct hlist_head list;
 	raw_spinlock_t lock;
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 469bc48b25127b..7f8e029a6af8d7 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -669,8 +669,7 @@ static void *__htab_map_lookup_elem(struct bpf_map *map, void *key)
 	struct htab_elem *l;
 	u32 hash, key_size;
 
-	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
-		     !rcu_read_lock_bh_held());
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
 
 	key_size = map->key_size;
 
@@ -1104,8 +1103,7 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 		/* unknown flags */
 		return -EINVAL;
 
-	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
-		     !rcu_read_lock_bh_held());
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
 
 	key_size = map->key_size;
 
@@ -1212,8 +1210,7 @@ static long htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value
 		/* unknown flags */
 		return -EINVAL;
 
-	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
-		     !rcu_read_lock_bh_held());
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
 
 	key_size = map->key_size;
 
@@ -1281,8 +1278,7 @@ static long htab_map_update_elem_in_place(struct bpf_map *map, void *key,
 		/* unknown flags */
 		return -EINVAL;
 
-	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
-		     !rcu_read_lock_bh_held());
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
 
 	key_size = map->key_size;
 
@@ -1344,8 +1340,7 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
 		/* unknown flags */
 		return -EINVAL;
 
-	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
-		     !rcu_read_lock_bh_held());
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
 
 	key_size = map->key_size;
 
@@ -1422,8 +1417,7 @@ static long htab_map_delete_elem(struct bpf_map *map, void *key)
 	u32 hash, key_size;
 	int ret;
 
-	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
-		     !rcu_read_lock_bh_held());
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
 
 	key_size = map->key_size;
 
@@ -1458,8 +1452,7 @@ static long htab_lru_map_delete_elem(struct bpf_map *map, void *key)
 	u32 hash, key_size;
 	int ret;
 
-	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
-		     !rcu_read_lock_bh_held());
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
 
 	key_size = map->key_size;
 
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index b5964524244814..3ce07b250ae085 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -42,8 +42,7 @@
  */
 BPF_CALL_2(bpf_map_lookup_elem, struct bpf_map *, map, void *, key)
 {
-	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
-		     !rcu_read_lock_bh_held());
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
 	return (unsigned long) map->ops->map_lookup_elem(map, key);
 }
 
@@ -59,8 +58,7 @@ const struct bpf_func_proto bpf_map_lookup_elem_proto = {
 BPF_CALL_4(bpf_map_update_elem, struct bpf_map *, map, void *, key,
 	   void *, value, u64, flags)
 {
-	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
-		     !rcu_read_lock_bh_held());
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
 	return map->ops->map_update_elem(map, key, value, flags);
 }
 
@@ -77,8 +75,7 @@ const struct bpf_func_proto bpf_map_update_elem_proto = {
 
 BPF_CALL_2(bpf_map_delete_elem, struct bpf_map *, map, void *, key)
 {
-	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
-		     !rcu_read_lock_bh_held());
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
 	return map->ops->map_delete_elem(map, key);
 }
 
@@ -134,8 +131,7 @@ const struct bpf_func_proto bpf_map_peek_elem_proto = {
 
 BPF_CALL_3(bpf_map_lookup_percpu_elem, struct bpf_map *, map, void *, key, u32, cpu)
 {
-	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
-		     !rcu_read_lock_bh_held());
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
 	return (unsigned long) map->ops->map_lookup_percpu_elem(map, key, cpu);
 }
 
-- 
2.53.0

