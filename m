Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BCA3370E4
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 16:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784392272; cv=none; b=OfxPfcpTXJ8gz805msiiYGd0MjeDHjoNSOFAu9xTQv6nBFkE6NIcXw1EWmF001TbzBuNCeuZNkaWky4gnNhc5K/CI8vYmYu5iQocMVxWLyFMTT67tItM9rqCDrLjAtfhxVVfjfoO1ezYD5LmTbSREI35AJ85X2qGTHxuubEcq40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784392272; c=relaxed/simple;
	bh=aAFbPsNu1c+krYEDqLU9+wPto8VJVqErGx3GQz40Rfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sVt0upCLX30QQypnwi2AV5M3Y56qA+1Ec38Qt4EtK2C3hxzIR7Hgj8n9zNmt2zdFOTZKEOBmN8ee5w4MHum0fPnpJrdCTNCGuUpkvbqhIwItOppFpzcorU+gS+IJqgHqClpGiMFgTWEK07bT+Y8dz0n3IVXgGuS3IFkyg5rdQoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DaBJ2xVq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DaBJ2xVq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9684C1F00A3A;
	Sat, 18 Jul 2026 16:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784392270;
	bh=ITAjq4dR47MHyLi6a7UE9QnKLOHUeLzZ2jvgtQHeWsw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DaBJ2xVqj8TSw5xwAkCMYOj17ZfCqFfo7CZlRG9LHvL75so19+5Stu9+1zP8tYkp3
	 Acqw2Ms1mq4jpgZJMfHca4+FBKdIgu4QEhejOJsaViAqcibZtZxcjmdApEs3f55M4S
	 OYF2H7jQZCyU67n2Q7Q26EwmtYohW9QtY+4G8CMsc5iEDgMdiO1Nd09uMY4cefMu1j
	 5moxdEYUjsRBboxOgeKOzLFJNP5186yNtUCLw1/byhJm5PfwL4rfRMWIDf4HPoh6GM
	 HvFOE4DmebfKuWfn9mi8xNph30SkgrYq0gKX0ebpjio6bsq6lXeiwUG3mFGX9w66Eg
	 eI/pGtGz5Z43Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vlad Poenaru <vlad.wing@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] bpf: Allow LPM map access from sleepable BPF programs
Date: Sat, 18 Jul 2026 12:31:07 -0400
Message-ID: <20260718163107.3338970-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260718163107.3338970-1-sashal@kernel.org>
References: <2026071450-landmine-pouring-a4f5@gregkh>
 <20260718163107.3338970-1-sashal@kernel.org>
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
 kernel/bpf/lpm_trie.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index 484227a214822c..def44994c479fc 100644
--- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -236,7 +236,7 @@ static void *trie_lookup_elem(struct bpf_map *map, void *_key)
 
 	/* Start walking the trie from the root node ... */
 
-	for (node = rcu_dereference_check(trie->root, rcu_read_lock_bh_held());
+	for (node = rcu_dereference_check(trie->root, bpf_rcu_lock_held());
 	     node;) {
 		unsigned int next_bit;
 		size_t matchlen;
@@ -270,7 +270,7 @@ static void *trie_lookup_elem(struct bpf_map *map, void *_key)
 		 */
 		next_bit = extract_bit(key->data, node->prefixlen);
 		node = rcu_dereference_check(node->child[next_bit],
-					     rcu_read_lock_bh_held());
+					     bpf_rcu_lock_held());
 	}
 
 	if (!found)
-- 
2.53.0

