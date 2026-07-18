Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AB734D911
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 15:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784387615; cv=none; b=pQOSGgtXu3nWjKWGb17cFruXJm9jmmXrEn/7MVd38LCOJKUbbSxizODiDf3tjLsAHgfwZJiCrabantVBWO7S4EQ3QjoV3PG/e6rJaTqaobDKJ6KCq7jK5/ivte5dn/3udiwAgaMfe1FPthtvmNcXAsmWAJB7cgMasiISSwEy7QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784387615; c=relaxed/simple;
	bh=GtFIM/4RE+RRYI3QJkaoheUfjRboma/VToevAo6gEMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TvR/XXTg/U8zUmpET4oelt0q55zY60jFyictAGzs42sFX3bsohCdqWohL5M2mtSB+VawM1/mo+B34oge9KYU4iThKIPifN8xRbf5qiPOEHe6jyFXIOFjek7u7OH7/RYsPVawLo9RLx+LvO4PfTgT11Izn0HmKnTZ9O43DZLnfDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m19vQFfe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m19vQFfe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC8B61F00A3F;
	Sat, 18 Jul 2026 15:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784387613;
	bh=ko91k9JVqWaPBvxB35AQ6HfEVzLJcgBuncVJzUBUXeU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m19vQFfeG3l+xRpT1rLDMGgbJGSw2MTJbOuxGmwjLlPWWV5iqWhkVmGmMaxkQr7/4
	 8zyMuH67tK4tcxYduiboHxFFDXYklbwwEPooVFxIIQcFvBQzkFNrYxBMUhtGOznzlv
	 kIqDQoXEW81Gnvcfr5XgeeAFAc18IEnQpDAMlnB1CeT3Pa9AKWV+7Uznkh/OKP80oj
	 h96FpYdCj0lnl3FzsNj/6c9Qa4RfspttWEwIOF4tRJ4J5wYc1ndgICW7aUADNaCg6T
	 BjvEoBE3PwUFMzKc+cGpimNh/C28Ax5oU4wv3kfQgfauuLwDo24n8f6VlAOmYghWiB
	 E8JSsOdQBw3zA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jiri Olsa <jolsa@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/4] bpf: Consistently use bpf_rcu_lock_held() everywhere
Date: Sat, 18 Jul 2026 11:13:28 -0400
Message-ID: <20260718151329.3271163-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260718151329.3271163-1-sashal@kernel.org>
References: <2026071449-absurd-charm-2576@gregkh>
 <20260718151329.3271163-1-sashal@kernel.org>
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
index c2d03364168f54..9e1731db76d86e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2219,6 +2219,9 @@ bpf_prog_run_array_uprobe(const struct bpf_prog_array *array,
 bool bpf_jit_bypass_spec_v1(void);
 bool bpf_jit_bypass_spec_v4(void);
 
+#define bpf_rcu_lock_held() \
+	(rcu_read_lock_held() || rcu_read_lock_trace_held() || rcu_read_lock_bh_held())
+
 #ifdef CONFIG_BPF_SYSCALL
 DECLARE_PER_CPU(int, bpf_prog_active);
 extern struct mutex bpf_stats_enabled_mutex;
diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index dcddb0aef7d8cb..87836e26ee0f5c 100644
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
index 9f9026a619d599..66eaf95f9dbeac 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -685,8 +685,7 @@ static void *__htab_map_lookup_elem(struct bpf_map *map, void *key)
 	struct htab_elem *l;
 	u32 hash, key_size;
 
-	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
-		     !rcu_read_lock_bh_held());
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
 
 	key_size = map->key_size;
 
@@ -1122,8 +1121,7 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 		/* unknown flags */
 		return -EINVAL;
 
-	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
-		     !rcu_read_lock_bh_held());
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
 
 	key_size = map->key_size;
 
@@ -1240,8 +1238,7 @@ static long htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value
 		/* unknown flags */
 		return -EINVAL;
 
-	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
-		     !rcu_read_lock_bh_held());
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
 
 	key_size = map->key_size;
 
@@ -1309,8 +1306,7 @@ static long __htab_percpu_map_update_elem(struct bpf_map *map, void *key,
 		/* unknown flags */
 		return -EINVAL;
 
-	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
-		     !rcu_read_lock_bh_held());
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
 
 	key_size = map->key_size;
 
@@ -1364,8 +1360,7 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
 		/* unknown flags */
 		return -EINVAL;
 
-	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
-		     !rcu_read_lock_bh_held());
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
 
 	key_size = map->key_size;
 
@@ -1442,8 +1437,7 @@ static long htab_map_delete_elem(struct bpf_map *map, void *key)
 	u32 hash, key_size;
 	int ret;
 
-	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
-		     !rcu_read_lock_bh_held());
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
 
 	key_size = map->key_size;
 
@@ -1478,8 +1472,7 @@ static long htab_lru_map_delete_elem(struct bpf_map *map, void *key)
 	u32 hash, key_size;
 	int ret;
 
-	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
-		     !rcu_read_lock_bh_held());
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
 
 	key_size = map->key_size;
 
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 8aa7ca9c34c749..3126ec5097f157 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -37,8 +37,7 @@
  */
 BPF_CALL_2(bpf_map_lookup_elem, struct bpf_map *, map, void *, key)
 {
-	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
-		     !rcu_read_lock_bh_held());
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
 	return (unsigned long) map->ops->map_lookup_elem(map, key);
 }
 
@@ -54,8 +53,7 @@ const struct bpf_func_proto bpf_map_lookup_elem_proto = {
 BPF_CALL_4(bpf_map_update_elem, struct bpf_map *, map, void *, key,
 	   void *, value, u64, flags)
 {
-	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
-		     !rcu_read_lock_bh_held());
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
 	return map->ops->map_update_elem(map, key, value, flags);
 }
 
@@ -72,8 +70,7 @@ const struct bpf_func_proto bpf_map_update_elem_proto = {
 
 BPF_CALL_2(bpf_map_delete_elem, struct bpf_map *, map, void *, key)
 {
-	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
-		     !rcu_read_lock_bh_held());
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
 	return map->ops->map_delete_elem(map, key);
 }
 
@@ -129,8 +126,7 @@ const struct bpf_func_proto bpf_map_peek_elem_proto = {
 
 BPF_CALL_3(bpf_map_lookup_percpu_elem, struct bpf_map *, map, void *, key, u32, cpu)
 {
-	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
-		     !rcu_read_lock_bh_held());
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
 	return (unsigned long) map->ops->map_lookup_percpu_elem(map, key, cpu);
 }
 
-- 
2.53.0

