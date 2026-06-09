Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E8042E006
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 13:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781013368; cv=none; b=oftIV4USn029tqGqyQ4N3bOaH2naCmYKEiDD0GUrTeY9u9bT0lMhyHXstIPFgPS6Ms0SN4x/AWCV7LGv9KQuZU7zjHgI7Pcl/Yz5Iw7BPB6zfeg758deQWgweKd2USsBQP+NdE44pNxgd5dbittGromPuKSlIErXGWh6jLKJ57g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781013368; c=relaxed/simple;
	bh=gaj2WvsU+CPIIU8/1kxABMamLpQxKo//cHQbkXB/pDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IFgVtbS3930EnVPB4Q/96uClXgGG7lydCTC1EvihrzAgMhiqZF122EEpjKXPiLGjpQOas0qc7C4M1ugqulCs7be8UUaaGICB67N2Xv1U8OCP9HSzrMwyl4pJ/oH3z811qVgpEXPyowoHQVazrmjDRkEkuapdA4zYoQgUDCaLkX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NeKiTK8A; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NeKiTK8A"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490b4a8e28bso46433335e9.1
        for <stable@vger.kernel.org>; Tue, 09 Jun 2026 06:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781013365; x=1781618165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TkopdShqq52E1sVeco8cvO6NJqDv29P/mWZiYCnJaeA=;
        b=NeKiTK8AawWfuv4x+jLTjCVs2stygwR7cpoU45BeBMU/0pCEH4xuzpRXkibqiL3blG
         YYFt14RwcuHDTe/ErCpOUqq1L1ATZPqASKLxgxptYrgVaDSbCxNLV7EdtD5+RuZAuFYr
         3Y94DKSynxmRTskTmyKMbs6h099qvmsY1MVrYjOa6LYTnBfnzgjRXnX4kaDLEsrjO7Mq
         aZPhmTRmy2NZY+bBkR56IVJNM86fol4YpuQzk/XReJm7bbvZZ2jNO1shSUC2hbu4bTG8
         QsEnJ1MLSxH9Z5ZQDx2wU397xg9dQqoPDHUJwcdheh66kyclKUWpbFW8Zw6nYxatNwWt
         eanw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781013365; x=1781618165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TkopdShqq52E1sVeco8cvO6NJqDv29P/mWZiYCnJaeA=;
        b=EzzWWmYCBD7eHo3DFbfzCLUZKAmfPmVU1au6DPhuEqvgmpfoIisrCpHUzFuRcrwnOX
         7cf+oEdHhuU/WJy0BwpOYUyHxgFbUTD6yFdUvKhyvhRWMOgjrrsnCzA3bJJuKZsE9rCg
         lN/++sN94wMQ1OfQXtm1bgVlsA6lyoA5vJ7Rnf+l5ML6EmaCuZxFLY4dNeRRN+ZB3z88
         jjcmef1O0JL4NXE+rdQDcW0vB/1GPUvJ6fsXY5elf+oCbqUTZTY02NY74Gj/LfEWZy+G
         KcH+iP/jtiqQARbr1Z29yCEjJ3aQ+rch9eKj796SKMQNGeYzjQX1upCDNa9E451Wuvc4
         UclA==
X-Forwarded-Encrypted: i=1; AFNElJ+ED0DWYMDBbSsUW7QoTZsJWl1qLO56u4rUTbQH74W7rp8N4mkdf+hDIr9GH2KWxp5gMTSNVPw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+QV/wGYloqLj503Vhx9eiSL2h5sqeXlUCiNrTMni1iEoH+OK4
	Vg77dDj5n7nU0mj2yQs3HeLdLI5euolIg/C9FaeTyho6L/5rlY0Cj8gp
X-Gm-Gg: Acq92OFP6wxOiIxg8gtQ9LzHVhZKdAfyP8aUxdrWhwTiemabUIE+EkudmrxjQUU8p+v
	fzv61uYldjicTlRjRT7c0Ui3scRhTOdcN350ysZOxPfJGlM0jcWCqJVwUjpQ079uHJwf/XG46u/
	wf/UPQgZS0qNE+9VQtK1iKSLJYiOVHXp3+LW6Nk5wPX1p14My3ZNrXWxnPzcJfqznrC0qQCbEqY
	PLDIF4BpNIrxoxpgssrYfgVU9rBof2kGVXznm4GbfZdXoD0IoOwnH7R7HdEAv/LFCSz84erkyYI
	18qjG67FfNUsHa1JohYfEAhThJOZViRy/d8FCXkraFx6Z2jfxvgWqql9dQ6khpWOEKLkJX29RIQ
	ml2SPqnKMbtAEP2MfQ/xmq3d3UDEL4FRPgUYzXdTGYyX3P/wkGS71ngAugpbBODPSiBUopWd6yP
	S1kmKCFEu68mZIzhOpaUX+zPhjOiWnYdfjfv9F3g==
X-Received: by 2002:a05:600c:1d27:b0:48f:d5b8:5b07 with SMTP id 5b1f17b1804b1-490c25e10f9mr346031765e9.20.1781013364723;
        Tue, 09 Jun 2026 06:56:04 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:71::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc39eb04sm488561035e9.6.2026.06.09.06.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 06:56:04 -0700 (PDT)
From: Vlad Poenaru <vlad.wing@gmail.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH bpf v2 1/2] bpf, lpm_trie: Allow access from sleepable BPF programs
Date: Tue,  9 Jun 2026 06:55:57 -0700
Message-ID: <20260609135558.193287-2-vlad.wing@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260609135558.193287-1-vlad.wing@gmail.com>
References: <20260529174233.2954240-1-vlad.wing@gmail.com>
 <20260609135558.193287-1-vlad.wing@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 kernel/bpf/lpm_trie.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

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
-- 
2.53.0-Meta

