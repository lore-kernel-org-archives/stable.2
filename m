Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795857277;
	b=juTRzG6QmNkcaDL4gAW4rZazaWV0zCdkJ9JkvgAio8+L2kGaTVqT3VdWt23U+No5MLAR
	 vtG/FHdxhbidOkJaHapsL0+RUqfCLSmROCoQsfNA/JpdHK4FOLm7o5omIVLlSS2fXsGGj
	 Va7JOg0Tr7giNlF76mHWLaVMYLdExpdZDDodTRt7qzORpr7RdVeSRMS/FseWxCwttwIAG
	 M0ZUA76pvFMFyZ8GFHOQSlgT2F1mqbGWczmEQR/p8ywFMN72QzlAChRd/VsfNUQiGQiHZ
	 E+xKk5qDWt7ZaYWJrCNWNDPIMI9aii8CHDn7m7V10tUgPnbOiw8vzBFoalqfoLg3geg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795857277;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=VsKb42s+5bHM1ZoiF6LkiA4s6kGoq5BsrJdery40LXw=;
	b=JU78TWgnaSDgrNApjwrS3Rj/CHgKDO/kUpxM5caS4yjROX7As9bpcg+WNO5QJwoMyJ2i
	 UTdbLDZ3kFWLSJveuSqySfgyzw96mnMWDTBaAqP7fz0/4MmWGdq/Qi2Dwdl502KBF60sT
	 6MVL87kjbo2Ubii2dOwbAs7/3wuBv+wN89Zob4VEA2W5IrqY/pY4B0atxldfhDwiz6ygh
	 LKQUxHcutYU+89bQGZAUpQiSFGD/XEhsl64Ij/bnCg5lLezyJr5fyReRvbMmiHE7M0SLR
	 ToStl9qo6ruR+3scegwJrKYboJ/9h/nZKnpsdWKrpw2uLDDl60tCqqGOTGMz+ALmE2w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Axay4iNP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53708606A31C
	for <stable@vger.kernel.org>; Sat, 28 Nov 2026 09:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Axay4iNP
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795857277;
	b=qaOXyFuJPZuXjaVYk/Uu+QkFbQxY8Q3n9yTQMW3yOw1ig0bMwwlPPK0srj59pcHd+Jfg
	 Yf84Q2sTUDmu4J5et0ChV9hKYVOCj4m9GbxE5742jxYCu0reua3aXIdf8e++olpy3Fey8
	 JgVFi0/QIw3MXTS1eHgbv0OIQCe13fxh8bDygGLngpiMvx3rdZj/1ElWb3HmRvZRym6+Y
	 d1ZtSEeGwJWCXJ53trKpN7zefZZ7h4ghABIFSzZSm12pOzo3+wHfCg4LXEK7Ey2iwuJOY
	 pldiCUm5xRIi2EQs4z8iPIqJQsqR7TUF77lEVa+iiIK2k+Qgun+dNPoRFvOqa5FflJg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795857277;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=VsKb42s+5bHM1ZoiF6LkiA4s6kGoq5BsrJdery40LXw=;
	b=G2TY0fJfx4hJbj+j7ejAWjNi+i5oJvbMHyS0JoLWZEesyXLX2C4E+Fx+bpFyFrYzwkSY
	 HNokMVXgbyOU/K+6VHIPKLBktRF3a71IckXpubuHgDaTWD2qq/DVwIoML5sP3ectNB7Xd
	 7zxoJ0wWPxBqLZEvi2iHM3muPXpgWb42m85zfC8pkhyat1EgS0cLof5TXowSStiVkBV21
	 pQpqpr1gKpMVl2D8yvmggZ6+DzAm8wtEiwdld3t8zi/CeW2q5dyq771QorqzLzzhSEt4C
	 d4dkDdFe7nOlOi+tufkTIXLfEEEv8MP4GX/IRujdsOpwuO0ims6C630HtJrxuAP3A/Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B55D41F00893;
	Sat, 28 Nov 2026 09:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795857277;
	bh=VsKb42s+5bHM1ZoiF6LkiA4s6kGoq5BsrJdery40LXw=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=Axay4iNPeNa7xU3OrkMFrTVQlSehKSYj7jNKxVjy/uyhb3UiHHEnLIPTp7QFIo3s0
	 3ryPMFUTk7JrItr4tkQdU3QbNjjQ5ULQO7x4u0Wh7BUeaK7DX1GovKxBf5OPl5DlJK
	 J6vV8FNMZxIkv49hRct56Yz8rBPuyba04+1E9pzOE308oih+9ggVEwVMlzxkMKtSsg
	 QmG3irvH9V4HryLjsCq6Ph4LyMyz4UYEjZ3Tlk2cEndNsGG16dyeAnh6+qCUOp3aio
	 LVhR3oHKNNJsLIuJUa4bOEZo2lTK4j8hAk8xdjRoeqEiWwHeTKAuHUX0Dch0l9WK7H
	 gJKWVxj8Ynwcg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4AA184E05B;
	Sat, 28 Nov 2026 09:14:36 +0000 (UTC)
From: Dickson Wu via B4 Relay <devnull+dickson.wu.certik.com@kernel.org>
Date: Sat, 28 Nov 2026 09:12:21 +0000
Subject: [PATCH 6.6.y] mm: list_lru: fix UAF for memory cgroup
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261128-listlru-66b-v1-1-38119b440740@certik.com>
X-B4-Tracking: v=1; b=H4sIAPSaCmsC/02NwQ7CIBBEf6XZs1uFCDH+ivEAdLEYAoalRtP03
 wW9eJyXmTcrMJVADOdhhULPwCGnFsRuADebdCMMU8sgD1ILIU8YA9dYFtTa4tEraaVSznmCtng
 U8uH1tV1Aj3p8w/WHebF3crWbetEaJrTFJDd3xJSmmnPEzvd/D7BtH2+euYmiAAAA
X-Change-ID: 20261128-listlru-66b-4f52b255ccfe
To: stable@vger.kernel.org
Cc: Muchun Song <muchun.song@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Vlastimil Babka <vbabka@suse.cz>, 
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795857140; l=3786;
 i=dickson.wu@certik.com; s=dickson-b4; h=from:subject:message-id;
 bh=POu2beyDobF+0phd+hiYwzwZCt9DRStto5gd3AQtySg=;
 b=mlGUL6TzOy4lzlVmeugaep9HuL/M5Krv56k/4wQTf+FCHY77yp8viURAqToN7Ofyk8c7+RRov
 gtF7vaL5er6CAsoxmGSYZAbH2VtVd/aWo8uOSXe6A5g6EJkzWLWiy4D
X-Developer-Key: i=dickson.wu@certik.com; a=ed25519;
 pk=fxH7FS4FdojeJSGLJzgKdfO51Rvr4EW30yinj2mc1vg=
X-Endpoint-Received: by B4 Relay for dickson.wu@certik.com/dickson-b4 with
 auth_id=1647
X-Original-From: Dickson Wu <dickson.wu@certik.com>
Reply-To: dickson.wu@certik.com

From: Muchun Song <songmuchun@bytedance.com>

commit 5161b48712dcd08ec427c450399d4d1483e21dea upstream.

The mem_cgroup_from_slab_obj() is supposed to be called under rcu lock or
cgroup_mutex or others which could prevent returned memcg from being
freed.  Fix it by adding missing rcu read lock.

Found by code inspection.

[songmuchun@bytedance.com: only grab rcu lock when necessary, per Vlastimil]
  Link: https://lkml.kernel.org/r/20240801024603.1865-1-songmuchun@bytedance.com
Link: https://lkml.kernel.org/r/20240718083607.42068-1-songmuchun@bytedance.com
Fixes: 0a97c01cd20b ("list_lru: allow explicit memcg and NUMA node selection")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Nhat Pham <nphamcs@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dickson Wu <dickson.wu@certik.com>
---
6.6.y picked up the code this fixes later than the other branches:
0a97c01cd20b came to 6.6.y as 32d7120a499d in 6.6.160, but this
follow-up didn't come with it, so 6.6 has the unprotected
mem_cgroup_from_slab_obj() calls in list_lru_add_obj() and
list_lru_del_obj(). It applies cleanly.

Tested on 6.6.163: allmodconfig W=1 build of mm/list_lru.o, base vs
patched, no new warnings. Both kernels booted under QEMU from an ext4
root and passed all six cgroup test_kmem selftests, including the
memcg deletion case. I didn't hit the race itself.

The backport and the test runs were prepared with AI coding tools
(OpenAI Codex agents, with review by Claude). I went over the result
before signing off.
---
 mm/list_lru.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index fcca67ac26ec..e362a956bf8f 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -116,6 +116,7 @@ list_lru_from_kmem(struct list_lru *lru, int nid, void *ptr,
 }
 #endif /* CONFIG_MEMCG_KMEM */
 
+/* The caller must ensure the memcg lifetime. */
 bool list_lru_add(struct list_lru *lru, struct list_head *item, int nid,
 		    struct mem_cgroup *memcg)
 {
@@ -140,14 +141,22 @@ EXPORT_SYMBOL_GPL(list_lru_add);
 
 bool list_lru_add_obj(struct list_lru *lru, struct list_head *item)
 {
+	bool ret;
 	int nid = page_to_nid(virt_to_page(item));
-	struct mem_cgroup *memcg = list_lru_memcg_aware(lru) ?
-		mem_cgroup_from_slab_obj(item) : NULL;
 
-	return list_lru_add(lru, item, nid, memcg);
+	if (list_lru_memcg_aware(lru)) {
+		rcu_read_lock();
+		ret = list_lru_add(lru, item, nid, mem_cgroup_from_slab_obj(item));
+		rcu_read_unlock();
+	} else {
+		ret = list_lru_add(lru, item, nid, NULL);
+	}
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(list_lru_add_obj);
 
+/* The caller must ensure the memcg lifetime. */
 bool list_lru_del(struct list_lru *lru, struct list_head *item, int nid,
 		    struct mem_cgroup *memcg)
 {
@@ -170,11 +179,18 @@ EXPORT_SYMBOL_GPL(list_lru_del);
 
 bool list_lru_del_obj(struct list_lru *lru, struct list_head *item)
 {
+	bool ret;
 	int nid = page_to_nid(virt_to_page(item));
-	struct mem_cgroup *memcg = list_lru_memcg_aware(lru) ?
-		mem_cgroup_from_slab_obj(item) : NULL;
 
-	return list_lru_del(lru, item, nid, memcg);
+	if (list_lru_memcg_aware(lru)) {
+		rcu_read_lock();
+		ret = list_lru_del(lru, item, nid, mem_cgroup_from_slab_obj(item));
+		rcu_read_unlock();
+	} else {
+		ret = list_lru_del(lru, item, nid, NULL);
+	}
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(list_lru_del_obj);
 

---
base-commit: e2bb30811e063ce0db964484357973b855b06572
change-id: 20261128-listlru-66b-4f52b255ccfe

Best regards,
--  
Dickson Wu <dickson.wu@certik.com>


