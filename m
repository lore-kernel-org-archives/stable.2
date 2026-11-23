Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795440361;
	b=rSRP94BpseKb4DtlE5wQgdLg9tf5VQEOvGjDd/DXup24Q1xBM9XMK8XkSfOTqPUSIQXI
	 dSRKaWcHiMADOzftdQSOra3o+X+a/QZBcLF5h0yrc6YqKDkxe4w584V7E89bL9AguY8dQ
	 n/3H4mZt9q29v40Kmuv3O26De8mMakYXx6AQFC2r/139uJ6K5TJ1nigtN/CDFVp57Xpbd
	 rhXEPVqRm6z5wEqKdkf77TVVlshT6o7GZXK5cpCbxbyH9ns844nXH8th4iZPCfJh4vKZ6
	 Y4nkqaQ1kiNIWFk31coOOusLsJ65x/poWxlsIT8/ddMRbcpzfcfMkm4pqTKOKthkskQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795440361;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=OM9cxLva7+iCHRXvRYtfcJWoubk8pCI/HEM5nYTnVxw=;
	b=0Tp/gDKgwM63+TVgVst1+qu6Avlvk9HTQMCN9Qf6p0+H80jsQIne1gmahFLntWSQsbkM
	 +v16I+zUy3aQxRKTFItsqHTT91a9ElIBpXaRfCgLR6qv2nnRYAO7V7r8OlnJGyG4gM76Q
	 PZbGNSjMBogpRMZxDTNS3tz+p1PI9pwrBUfJ3C3Ql7/swakDvCm1Pp3KkNkqaJFnqXFED
	 lqk7lL970up5gfhCC6QTPbjDnoKKZGmPahTnL7748rZGoZeWB6HeSEImGHArSyvLZqHJk
	 2pDcRhVtFqYficwVclLUoz0xWrq8jaga4AFvLhmKBAU89Rg0pELtVnasTEPs4atIfgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GMTalLWH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818E6606A338;
	Mon, 23 Nov 2026 13:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GMTalLWH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B55331F000EC;
	Mon, 23 Nov 2026 13:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795440360;
	bh=OM9cxLva7+iCHRXvRYtfcJWoubk8pCI/HEM5nYTnVxw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=GMTalLWHlpBbiC1qadH//eEXuGf0DLWVEuQthel5DItykAlkId33T10DP0z3BIFd7
	 dOBGttsQ/9iIJk/4Wt9paltLPCdSkrJbMt5hqVXr0OI83XqGuXDM9jChr/DL/M4xQj
	 4xlidmLE0BHc/AdFmPtg4d4/HEhC6kRZD/Qv62071pZTeMcjJtX7eow8I1P4vZzA4H
	 csrynoe8aq8MHbDFClGKdTIw0OX0pwth8HUepRqEqqnbj4vYmXOfh/ng/Lb//ARiwX
	 laNmLoUMm/9PqpQ9O9XQdHrEnCi/E3/noT9EY4+dufymPestfDeER+5HJr8BrJldKs
	 Sb9msHS+JorjQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 23 Nov 2026 14:24:58 +0100
Subject: [PATCH net 10/10] tcp: do not pass a BPF reqsk to an MPTCP
 listener
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
Message-Id: <20261123-net-mptcp-misc-fixes-7-4-rc5-v1-10-278042217e8d@kernel.org>
References: <20261123-net-mptcp-misc-fixes-7-4-rc5-v1-0-278042217e8d@kernel.org>
In-Reply-To: <20261123-net-mptcp-misc-fixes-7-4-rc5-v1-0-278042217e8d@kernel.org>
To: Eric Dumazet <edumazet@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
 Simon Horman <horms@kernel.org>, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, Christoph Paasch <cpaasch@openai.com>, 
 Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 Davide Caratti <dcaratti@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Chris Mason <mason@kernel.org>, stable@vger.kernel.org, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Martin KaFai Lau <kafai@fb.com>, Daniel Borkmann <daniel@iogearbox.net>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Martin KaFai Lau <martin.lau@kernel.org>, bpf@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3565; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=PbiCcpJTknsoj+MJd4lAx3wSs1KXnS473ThstyaOxCs=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJZ7PbfDpQX1lSq/mMTlvy24fkK1QOP/68N5z0yY7l7I
 e+e5JjfHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABOJFWH4HyMceTyJP+/y04ch
 GhrfLx7/esP49sSwLj53n1qlsGuHZjIyrE42P6aU8914mW9P5+85RlpMLZH1YhMe1H2d8aFIL/Y
 NPwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Chris Mason <mason@kernel.org>

A slab-out-of-bounds write and a panic can occur if a tc BPF program
that validates SYN cookies assigns an ACK to a TCP listener, and the ACK
then goes to an MPTCP listener of the same SO_REUSEPORT group.

bpf_sk_assign_tcp_reqsk() attaches a plain TCP request sock to the skb,
and returns -EINVAL if the program passes in an MPTCP listener. But
inet_steal_sock() and inet6_steal_sock() select a listener again from
the SO_REUSEPORT group of the listener that was passed in, and the
result can be an MPTCP listener. cookie_bpf_check() then passes the
request sock to mptcp_subflow_init_cookie_req(), which writes to members
of the larger struct mptcp_subflow_request_sock, so the writes can land
in the next object of the slab.

The fix used here is to drop the segment in cookie_bpf_check() if the
listener is an MPTCP listener. The connection then fails, instead of
corrupting the memory.

This issue has been found with the help of an LLM, and reproduced in a
VM, with the reproducer shared with the original version of this patch:
a tc BPF program validating SYN cookies -- the one from the BPF
selftests -- and an SO_REUSEPORT group with a TCP listener and an MPTCP
one, the latter being selected. With KASAN, the original version of this
patch reported:

  BUG: KASAN: slab-out-of-bounds in mptcp_subflow_init_cookie_req
  Write of size 1 at addr ... by task python3
   mptcp_subflow_init_cookie_req
   cookie_bpf_check
   cookie_v4_check
   tcp_v4_do_rcv
   tcp_v4_rcv

Without debug options, and with request sockets of half-open connections
next to the corrupted one, the kernel panicked a second later, when the
timer of a request socket fired:

  BUG: kernel NULL pointer dereference, address: 000000000000058f
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  Oops: Oops: 0000 [#1] SMP NOPTI
  CPU: 3 UID: 0 PID: 0 Comm: swapper/3 Not tainted 7.4.0-rc1+ #1 PREEMPT(lazy)
  RIP: 0010:tcp_syn_ack_timeout+0xd/0x30
  Call Trace:
   <IRQ>
   reqsk_timer_handler+0x22e/0x500
   call_timer_fn+0x2a/0x140
   __run_timers+0x1f7/0x280
   run_timer_softirq+0x49/0xf0
   handle_softirqs+0xfa/0x300
   __irq_exit_rcu+0xb5/0xf0
   sysvec_apic_timer_interrupt+0x73/0x80
   </IRQ>
  Kernel panic - not syncing: Fatal exception in interrupt

Fixes: e472f88891ab ("bpf: tcp: Support arbitrary SYN Cookie.")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
[ Shorter comment. Commit message: how the issue was found, its
  symptoms, and that the connection then fails. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Cc: Neal Cardwell <ncardwell@google.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Martin KaFai Lau <martin.lau@kernel.org>
Cc: bpf@vger.kernel.org
---
 net/ipv4/syncookies.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index 89169c82431c..f39600ee3f17 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -312,7 +312,8 @@ struct request_sock *cookie_bpf_check(struct sock *sk, struct sk_buff *skb)
 	skb->sk = NULL;
 	skb->destructor = NULL;
 
-	if (cookie_tcp_reqsk_init(sk, skb, req)) {
+	/* reuseport can pick an MPTCP listener: req is too small for it */
+	if (sk_is_mptcp(sk) || cookie_tcp_reqsk_init(sk, skb, req)) {
 		reqsk_free(req);
 		req = NULL;
 	}

-- 
2.55.0

