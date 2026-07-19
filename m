Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832B517A2E8
	for <stable@vger.kernel.org>; Sun, 19 Jul 2026 12:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784465014; cv=none; b=UBuLBGu+g3TG/7hYX2X/FL/9l27qoKjHWWTJ85iRTGnhvArG8csdKHYn00RyP4IhkTNYazfSUznXNWY1+6u+R3XqY579uohcsP9xFE9oLulv0Z8kxcWSYPShBgJN9pxD5rpO1RcrF2SMWgo+aDDPd6KpxfgMhQI1SFn6H1a8JWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784465014; c=relaxed/simple;
	bh=YjO3V2EvIZfzeHXGBIzdG7gIVPuttlLt5J0iHu6t3ds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A4Lw0qKEZH94eE69NCFLmZhCnlS7E0fRYaS37anFERcHJnXk3yYQt//nm0hp2qbZ3Dsq8XaXyLkBiVnRi7v8b9FUZUR84eDrpfZZM+BSRetF+90QjEjJGgFipyWB6phjJ/2x3OfHDnUDdkVYhB7bkJPlTEUJpFEUjqv1gphdA0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KGF0r0Ko; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KGF0r0Ko"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D89F91F00A3D;
	Sun, 19 Jul 2026 12:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784465013;
	bh=oyjMGZMijrynXKKZkQbYwYkRP3lTRYZiV1WXzOIpom0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KGF0r0Ko+7TeWTTkQ+y61EomBLU1MigtQvI3Se4Ya5cI2z6cOZ9+cidQc7O6z3YLm
	 ZctP7/9z+zw8GtJy9utDU210wvh8fPUsRATG8NRu4XFMNQESHgwo+46aWml4PJZNT5
	 Vf1Hi4LmO8lH48em1Yr8+28w0VvwwRaDqlkfvtoMvozXdIAiFasMTQpVlzdwhKzFFF
	 gTo6Vk/80wrmaiPi7s8VqacoOkzmpCr5RE9ARqtVo261GR+xoZzT8jWzV6WxyjSW/3
	 yhpl1nMNHgTRlSIhs4jnkLb8kLTEHwptm3yGHWzUgeXhgg5BL2tkTKNpCyNKDYjN6B
	 TBFN5vS4BlZlA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jiri Olsa <jolsa@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/3] bpf: Consistently use bpf_rcu_lock_held() everywhere
Date: Sun, 19 Jul 2026 08:43:29 -0400
Message-ID: <20260719124330.3645834-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260719124330.3645834-1-sashal@kernel.org>
References: <2026071451-collision-embolism-f766@gregkh>
 <20260719124330.3645834-1-sashal@kernel.org>
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
 include/linux/bpf.h  |  4 ++++
 kernel/bpf/hashtab.c | 21 +++++++--------------
 kernel/bpf/helpers.c |  9 +++------
 3 files changed, 14 insertions(+), 20 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 1046f290b4b2b5..ed42bac04a790d 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -23,6 +23,7 @@
 #include <linux/slab.h>
 #include <linux/percpu-refcount.h>
 #include <linux/bpfptr.h>
+#include <linux/rcupdate_trace.h>
 
 struct bpf_verifier_env;
 struct bpf_verifier_log;
@@ -1482,6 +1483,9 @@ BPF_PROG_RUN_ARRAY(const struct bpf_prog_array __rcu *array_rcu,
 		_ret;					\
 	})
 
+#define bpf_rcu_lock_held() \
+	(rcu_read_lock_held() || rcu_read_lock_trace_held() || rcu_read_lock_bh_held())
+
 #ifdef CONFIG_BPF_SYSCALL
 DECLARE_PER_CPU(int, bpf_prog_active);
 extern struct mutex bpf_stats_enabled_mutex;
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 24258c54057d46..eccb2e47d93082 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -642,8 +642,7 @@ static void *__htab_map_lookup_elem(struct bpf_map *map, void *key)
 	struct htab_elem *l;
 	u32 hash, key_size;
 
-	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
-		     !rcu_read_lock_bh_held());
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
 
 	key_size = map->key_size;
 
@@ -1047,8 +1046,7 @@ static int htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 		/* unknown flags */
 		return -EINVAL;
 
-	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
-		     !rcu_read_lock_bh_held());
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
 
 	key_size = map->key_size;
 
@@ -1149,8 +1147,7 @@ static int htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value,
 		/* unknown flags */
 		return -EINVAL;
 
-	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
-		     !rcu_read_lock_bh_held());
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
 
 	key_size = map->key_size;
 
@@ -1218,8 +1215,7 @@ static int __htab_percpu_map_update_elem(struct bpf_map *map, void *key,
 		/* unknown flags */
 		return -EINVAL;
 
-	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
-		     !rcu_read_lock_bh_held());
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
 
 	key_size = map->key_size;
 
@@ -1273,8 +1269,7 @@ static int __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
 		/* unknown flags */
 		return -EINVAL;
 
-	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
-		     !rcu_read_lock_bh_held());
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
 
 	key_size = map->key_size;
 
@@ -1349,8 +1344,7 @@ static int htab_map_delete_elem(struct bpf_map *map, void *key)
 	u32 hash, key_size;
 	int ret;
 
-	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
-		     !rcu_read_lock_bh_held());
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
 
 	key_size = map->key_size;
 
@@ -1385,8 +1379,7 @@ static int htab_lru_map_delete_elem(struct bpf_map *map, void *key)
 	u32 hash, key_size;
 	int ret;
 
-	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
-		     !rcu_read_lock_bh_held());
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
 
 	key_size = map->key_size;
 
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index b40ca025d9a446..95c85f083d32bf 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -30,8 +30,7 @@
  */
 BPF_CALL_2(bpf_map_lookup_elem, struct bpf_map *, map, void *, key)
 {
-	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
-		     !rcu_read_lock_bh_held());
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
 	return (unsigned long) map->ops->map_lookup_elem(map, key);
 }
 
@@ -47,8 +46,7 @@ const struct bpf_func_proto bpf_map_lookup_elem_proto = {
 BPF_CALL_4(bpf_map_update_elem, struct bpf_map *, map, void *, key,
 	   void *, value, u64, flags)
 {
-	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
-		     !rcu_read_lock_bh_held());
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
 	return map->ops->map_update_elem(map, key, value, flags);
 }
 
@@ -65,8 +63,7 @@ const struct bpf_func_proto bpf_map_update_elem_proto = {
 
 BPF_CALL_2(bpf_map_delete_elem, struct bpf_map *, map, void *, key)
 {
-	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
-		     !rcu_read_lock_bh_held());
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
 	return map->ops->map_delete_elem(map, key);
 }
 
-- 
2.53.0

