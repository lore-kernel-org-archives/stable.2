Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D684C377EB8
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 21:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784411427; cv=none; b=uQpIpol1Ir2dhkpUjUKrfghWuN3uzsEoz5+cBXPYu2BmHSS7vDtpqng5x5JaT+iIpFeYBHk0E6LTs0Ja3MD7axhW2Y8fok/9yipnA2GZYeWZQUvxxfx99H/LI8Ug8JrPutZG7/yRKw7cc5WC9DB/bKGDf1LROGqWagRvu5jdYEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784411427; c=relaxed/simple;
	bh=rV+rQTUn0BEgcq5f2/8Wv3JA4t0VZ0E+PkmBQ3esCgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C35Uk0oPLU8cn8ALkPXLL8o05o2npCNmmPbisSPWrtBgT+CVSnMzeP2sjAPbAq8KUhobh75lJQg7jbTjMGRuq/qf7VQX04cMGFzkLGuhB6jvf0BlepheUP4bAqu5j+LWFJ55bj8EJ/6JMvx3u1m4IY+oL95I9gIgdrF1D7gKCCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDX/GbiL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDX/GbiL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E5F41F00AC4;
	Sat, 18 Jul 2026 21:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784411425;
	bh=H95V9KI8+vsCWzkOFDoi/gd0j9vcbcP0oOSeX2UDuqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IDX/GbiL5uffnltjMvNQ6cjaTwWNI63jOvq06g9vDo/JQuoDLehSh8nO98N5nIkuL
	 /CVWO2/iZmruGWvVcU0PtHlh3maF70XNDoamoxy+bjsTuw3Ka1L0eDm2DKeOZNJuCf
	 7KTfGCrjYTDltww0E8/N4ji3B6l8Xnd3uzm2rqYIZWCSgyssypS8OlCqMMeL4KXy0z
	 ugzlROUUnV2TFx91iJVPY+GuDgYxFh+hZ05AS7Sn31EUhAXui0x9sOM/de+gs6AlEr
	 936Qsf2IKPiy/0vyVu5axRg2a27bSxkuQSaoMKtffr3/n44/JXp6G/brjdGaIxzMaE
	 W6SWn9YPY0mkA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vlad Poenaru <vlad.wing@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/3] bpf: Allow LPM map access from sleepable BPF programs
Date: Sat, 18 Jul 2026 17:50:21 -0400
Message-ID: <20260718215021.3447372-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260718215021.3447372-1-sashal@kernel.org>
References: <2026071451-collision-embolism-f766@gregkh>
 <20260718215021.3447372-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vlad Poenaru <vlad.wing@gmail.com>

[ Upstream commit 2f884d371fafea137afea504d49ee4a7c8d7985b ]

trie_lookup_elem() annotates its rcu_dereference_check() walks with
only rcu_read_lock_bh_held().  Because rcu_dereference_check(p, c)
resolves to "c || rcu_read_lock_held()", this passes for XDP/NAPI and
classic RCU readers but fails for sleepable BPF programs, which enter
via __bpf_prog_enter_sleepable() and hold only rcu_read_lock_trace().

trie_update_elem() and trie_delete_elem() have the same problem in a
different form: they walk the trie with plain rcu_dereference(), which
asserts rcu_read_lock_held() unconditionally.  Both are reachable from
sleepable BPF programs via the bpf_map_update_elem / bpf_map_delete_elem
helpers, and from the syscall path under classic rcu_read_lock().  In
the writer paths the trie is actually protected by trie->lock (an
rqspinlock taken across the walk); we never relied on the RCU read-side
lock to keep nodes alive there.

A sleepable LSM hook that ends up touching an LPM trie therefore
triggers lockdep on debug kernels:

  =============================
  WARNING: suspicious RCU usage
  7.1.0-... Tainted: G            E
  -----------------------------
  kernel/bpf/lpm_trie.c:249 suspicious rcu_dereference_check() usage!
  1 lock held by net_tests/540:
   #0: (rcu_tasks_trace_srcu_struct){....}-{0:0},
       at: __bpf_prog_enter_sleepable+0x26/0x280
  Call Trace:
   dump_stack_lvl
   lockdep_rcu_suspicious
   trie_lookup_elem
   bpf_prog_..._enforce_security_socket_connect
   bpf_trampoline_...
   security_socket_connect
   __sys_connect
   do_syscall_64

This is lockdep-only -- no UAF, since Tasks Trace RCU does serialize
against the trie's reclaim path -- but it spams the console once per
distinct callsite on every debug kernel running a sleepable BPF LSM
that touches an LPM trie, which is increasingly common.

For the lookup path, switch the rcu_dereference_check() annotation
from rcu_read_lock_bh_held() to bpf_rcu_lock_held(), which accepts all
three contexts (classic, BH, Tasks Trace).  Other map types already
follow this convention.

For trie_update_elem() and trie_delete_elem(), annotate the walks as
rcu_dereference_protected(*p, 1) -- matching trie_free() in the same
file -- since trie->lock is held across the walk.  rqspinlock has no
lockdep_map, so the predicate degenerates to '1' rather than
lockdep_is_held(&trie->lock); the protection is real but not
machine-verifiable.  trie_get_next_key() also uses bare
rcu_dereference() but is reachable only from the BPF syscall, which
holds classic rcu_read_lock() before dispatching, so it is left
untouched.

Fixes: 694cea395fde ("bpf: Allow RCU-protected lookups to happen from bh context")
Cc: stable@vger.kernel.org
Signed-off-by: Vlad Poenaru <vlad.wing@gmail.com>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Link: https://lore.kernel.org/r/20260609135558.193287-2-vlad.wing@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/lpm_trie.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index cdfa10b0c56b78..22b7183621398a 100644
--- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -235,7 +235,7 @@ static void *trie_lookup_elem(struct bpf_map *map, void *_key)
 
 	/* Start walking the trie from the root node ... */
 
-	for (node = rcu_dereference_check(trie->root, rcu_read_lock_bh_held());
+	for (node = rcu_dereference_check(trie->root, bpf_rcu_lock_held());
 	     node;) {
 		unsigned int next_bit;
 		size_t matchlen;
@@ -269,7 +269,7 @@ static void *trie_lookup_elem(struct bpf_map *map, void *_key)
 		 */
 		next_bit = extract_bit(key->data, node->prefixlen);
 		node = rcu_dereference_check(node->child[next_bit],
-					     rcu_read_lock_bh_held());
+					     bpf_rcu_lock_held());
 	}
 
 	if (!found)
@@ -349,7 +349,7 @@ static int trie_update_elem(struct bpf_map *map,
 	 */
 	slot = &trie->root;
 
-	while ((node = rcu_dereference(*slot))) {
+	while ((node = rcu_dereference_protected(*slot, 1))) {
 		matchlen = longest_prefix_match(trie, node, key);
 
 		if (node->prefixlen != matchlen ||
@@ -474,7 +474,7 @@ static int trie_delete_elem(struct bpf_map *map, void *_key)
 	trim = &trie->root;
 	trim2 = trim;
 	parent = NULL;
-	while ((node = rcu_dereference(*trim))) {
+	while ((node = rcu_dereference_protected(*trim, 1))) {
 		matchlen = longest_prefix_match(trie, node, key);
 
 		if (node->prefixlen != matchlen ||
-- 
2.53.0

