Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F59F3644D4
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 15:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784044437; cv=none; b=pqVXfrqIHgFQPZpEOdT1fBt2zT7KmpFctghiLuKveBFlXZwzsFF/H3HAKVusCu+zc37XyhAWopSDH5oinb0dK1C10rSzuvn80kTPlP+7I35u1Lb/x4MP62c2CFY4P+rrk7R8FMO45nevHpgi3FBM7LO87E/tDlpg9hLVWIDyrTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784044437; c=relaxed/simple;
	bh=Wkj/ZWB5KcH4DltQWUg5YnlWahMklsHHzIPu22CHork=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VYmpCWYnGLQQSk4byVfBlYB3bWs2Veqx29KmI8pl0B2pr1cbb3xikzBljQSktO4DA1q5rSpFpfIHm2GnXZeg7oaO8jZhD0NNWrT0+tBWsJ62phn2H8hKZMvN6uxKq+bwkIA4aB9txZIFDK9SLXNwQZ3L6ZAd0IO+XJ+rKGDeyWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uPDRGbeB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uPDRGbeB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F7E81F000E9;
	Tue, 14 Jul 2026 15:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784044435;
	bh=5tlHiS8bUZf7FJ5M32ZrDUKQMrBhTnea24RvelgNZTs=;
	h=Subject:To:Cc:From:Date;
	b=uPDRGbeBzyCqkJjp4+YcZb4fRpC2hANDxsAafTH6I5uojgbWcv2jAS1Ic+TlardA6
	 nbnXXmNY9szjKT2YPsHLy7Y8fpLyPIYi46CJk0WUKsRwGNcEImBy+0bejeFOCqTMaI
	 ewK69GE2YzK0wnqKjBRplxUj6rF4PXx2WnmhBJ7s=
Subject: FAILED: patch "[PATCH] bpf: Allow LPM map access from sleepable BPF programs" failed to apply to 6.12-stable tree
To: vlad.wing@gmail.com,ast@kernel.org,emil@etsalapatis.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 14 Jul 2026 17:53:49 +0200
Message-ID: <2026071449-absurd-charm-2576@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 2f884d371fafea137afea504d49ee4a7c8d7985b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071449-absurd-charm-2576@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2f884d371fafea137afea504d49ee4a7c8d7985b Mon Sep 17 00:00:00 2001
From: Vlad Poenaru <vlad.wing@gmail.com>
Date: Tue, 9 Jun 2026 06:55:57 -0700
Subject: [PATCH] bpf: Allow LPM map access from sleepable BPF programs

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

diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index 0f57608b385d..4d6f25db9ba1 100644
--- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -246,7 +246,7 @@ static void *trie_lookup_elem(struct bpf_map *map, void *_key)
 
 	/* Start walking the trie from the root node ... */
 
-	for (node = rcu_dereference_check(trie->root, rcu_read_lock_bh_held());
+	for (node = rcu_dereference_check(trie->root, bpf_rcu_lock_held());
 	     node;) {
 		unsigned int next_bit;
 		size_t matchlen;
@@ -280,7 +280,7 @@ static void *trie_lookup_elem(struct bpf_map *map, void *_key)
 		 */
 		next_bit = extract_bit(key->data, node->prefixlen);
 		node = rcu_dereference_check(node->child[next_bit],
-					     rcu_read_lock_bh_held());
+					     bpf_rcu_lock_held());
 	}
 
 	if (!found)
@@ -359,7 +359,7 @@ static long trie_update_elem(struct bpf_map *map,
 	 */
 	slot = &trie->root;
 
-	while ((node = rcu_dereference(*slot))) {
+	while ((node = rcu_dereference_protected(*slot, 1))) {
 		matchlen = longest_prefix_match(trie, node, key);
 
 		if (node->prefixlen != matchlen ||
@@ -482,7 +482,7 @@ static long trie_delete_elem(struct bpf_map *map, void *_key)
 	trim = &trie->root;
 	trim2 = trim;
 	parent = NULL;
-	while ((node = rcu_dereference(*trim))) {
+	while ((node = rcu_dereference_protected(*trim, 1))) {
 		matchlen = longest_prefix_match(trie, node, key);
 
 		if (node->prefixlen != matchlen ||

