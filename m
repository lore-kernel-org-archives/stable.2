Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795440335;
	b=JswmGWWFnpg4AnE3DnigcSWA0nPHioLZ3Jqq+BffDdMwgI9e0Yg/6odZXZZQRG/fAQyL
	 r5fyzSGB6VO2bz8yP7/66ciJyCQ6Th1ADoO+6fPwLG/Gjt885r/DLDly3A6g0rc/h7l8V
	 C9rL1ZyybK+YjjKXT/wm/4BYEfb/NJNJKpnIV3K9EvGHdpXJKV6kWL+Y4qrCPcPe9ky6b
	 XeIaOyU+sLn7rQtrD6hrLPWSco0x0yFCwPPwYvR7XkH4MK0B8aQ7Ik12o545qHJTaeSrn
	 TUHMfxkYAl98NlEhthRt65UX2HjlYGeK1mcpCpXPSDxTo0RdTPozl6GPMjrjxIlwA9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795440335;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=j6NoxPUSnIuQNQok+UdtQrawTTFukTWkIuqhw/dxpKQ=;
	b=wBoyJIkpxAErpJGT5ddRHvkNg3u2yG8gLXStBZZMmCOaQ2LoR1DC+sicsZg6hO1Gm7Il
	 LU2qOo0OBq9ahly+ePDiGjS4kAysb/6MhR7I5qMZBM6ryBNcf91CFwwaqbGpNXijLQiMx
	 +BDmLJct4feX7yFrqQ9WLUvAZtWhpjUC0VkYVrxS05l5x1bNGXb2VucjeZld7nrJ5x4nI
	 MqcEnLArOaCjpCHvFRPDJNwT+dLxu5/YPGlrFKR7y8pXvggYyvuhfW8c4AkzsFa41qh/J
	 T63JFdIB5q+hlzikyhrD97QtdcIa9lJLQIhYV6fapns3Z/stdxHmZxRV7EhouZVf6/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jBb+bgSg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD01606A31F;
	Mon, 23 Nov 2026 13:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jBb+bgSg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB4F81F000D2;
	Mon, 23 Nov 2026 13:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795440334;
	bh=j6NoxPUSnIuQNQok+UdtQrawTTFukTWkIuqhw/dxpKQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jBb+bgSgMY2lc48tNZAdlsxl56nZrYBG7+DAqYWHLKpkgdbYTR1PH8+ajZCxEUFYK
	 MZ49Ht5t6ZojMkhMa0oPRA/44QpjjivN1G1+T3UTPERQTbroGBfVU+jRgt0H2OsK04
	 9YkXrX+R/exMIwSBLQaYvaDkql8+WTVQwRkZPm+QOPaemrTmylUUm+KkE3FUv0i9kv
	 lQE7uSfeAQxcfh10cJ1qsPAxmpi5p4nr4Xe+inHqkux9ILNrHwd00VTB73VQV803ph
	 ibzicA56I81zvR3bJjNr2OKaJfeDsaVAUMPo3RK3OSYhhR2sX5Z9SRqo4a3eGY/WgH
	 pxRgiWJM8Yh6g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 23 Nov 2026 14:24:51 +0100
Subject: [PATCH net 03/10] mptcp: clear inet_opt in the child of an IPv6
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
Message-Id: <20261123-net-mptcp-misc-fixes-7-4-rc5-v1-3-278042217e8d@kernel.org>
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
 Chris Mason <mason@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4207; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=xK7mk0IXLH6lvQit6O/NTnaAI29UyNNxOopnuSz9I3s=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJZ7HZdjnPY+ejGEsbJ7BbFmzfmdQZsk7sWJf3J4l7/0
 XMKO47c6ChlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZgI7y5Ghs77Uur37vyQDnfa
 OP2G8bu7yScSLu9MCbvOvjq79bTHR1lGhsYN2280l4jXzuK9tJabJclHR95pzyxZDX1HsTdFpxk
 U+QE=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Chris Mason <mason@kernel.org>

With SELinux, an IPv6 MPTCP listener and its children can cause a double
free of one CIPSO option, and then a use-after-free read of it, if
NetLabel uses CIPSO for IPv4 and selects the IPv6 labels by address.

mptcp_sk_clone_init() creates the child of a listener with
sk_clone_lock(), as a byte copy of the listener, so each pointer in the
copy that the socket destructor frees has to be replaced or cleared.
mptcp_copy_ip_options() duplicates inet_opt, the IPv4 options, for
AF_INET, and mptcp_copy_ip6_options() duplicates the IPv6 options for
AF_INET6. But an AF_INET6 socket has an inet_opt pointer too, and its
child keeps the listener's pointer.

MPTCP does not support setsockopt(IP_OPTIONS), so that pointer is
usually NULL. But if connect() gets a struct sockaddr_in,
netlbl_conn_setattr() does not look at the family of the socket, so the
connect() hook of SELinux can store a CIPSO option in inet_opt of an
AF_INET6 MPTCP listener. inet_sock_destruct() then passes that option to
kfree_rcu() for each child and again for the listener, and after a child
has freed it, another such connect() on the listener reads it in
cipso_v4_sock_setattr().

The fix used here is to clear inet_opt of the child in
mptcp_copy_ip6_options().

This issue has been found with the help of an LLM, and reproduced in a
VM, with the reproducer shared with the original version of this patch,
with SELinux, NetLabel -- CIPSO for some IPv4 addresses, and the
address-based selection used for IPv6 too -- and KASAN: an unprivileged
user calls connect() with an IPv4 address on an IPv6 MPTCP listener.
Without this patch, an object is freed twice:

  BUG: KASAN: double-free in rcu_free_sheaf+0x23/0x100
  Free of addr ffff888012c27a80 by task kworker/1:1/50
  CPU: 1 UID: 0 PID: 50 Comm: kworker/1:1 Not tainted 7.4.0-rc1+ #1 PREEMPT(full)
  Workqueue: events mptcp_worker
  Call Trace:
   <IRQ>
   kasan_report_invalid_free+0xd4/0x1b0
   check_slab_allocation+0xc2/0xf0
   __rcu_free_sheaf_prepare+0x102/0x2a0
   rcu_free_sheaf+0x23/0x100
   rcu_do_batch+0x29a/0xf80
   rcu_core+0x33c/0x830
   handle_softirqs+0x212/0x980
   do_softirq+0xb4/0xf0
   </IRQ>
   <TASK>
   __local_bh_enable_ip+0x11c/0x150
   mptcp_token_destroy+0x1c9/0x360
   mptcp_destroy_common+0x2d9/0x430
   mptcp_destroy+0x86/0x110
   __mptcp_destroy_sock+0x176/0x350
   mptcp_worker+0xbb5/0xf80
  [...]
  Allocated by task 176:
  [...]
   cipso_v4_sock_setattr+0x9b/0x3d0
   netlbl_conn_setattr+0x3ac/0x500
   selinux_netlbl_socket_connect_locked+0x102/0x210
   selinux_netlbl_socket_connect+0x23/0x40
   security_socket_connect+0x2e/0x60
   __sys_connect_file+0xcb/0x200
  [...]

In another case, the CIPSO option is used after having been freed:

  BUG: KASAN: slab-use-after-free in cipso_v4_sock_setattr+0x3c7/0x3d0
  Read of size 1 at addr ffff8880161c2f18 by task python3/177
  CPU: 1 UID: 65534 PID: 177 Comm: python3 Not tainted 7.4.0-rc1+ #1 PREEMPT(full)
  Call Trace:
   <TASK>
   kasan_report+0x101/0x140
   cipso_v4_sock_setattr+0x3c7/0x3d0
   netlbl_conn_setattr+0x3ac/0x500
   selinux_netlbl_socket_connect_locked+0x102/0x210
   selinux_netlbl_socket_connect+0x23/0x40
   security_socket_connect+0x2e/0x60
   __sys_connect_file+0xcb/0x200
   __sys_connect+0xfd/0x130
   __x64_sys_connect+0x72/0xd0
  [...]

Fixes: cf7da0d66cc1 ("mptcp: Create SUBFLOW socket for incoming connections")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
[ Commit message: how the issue was found, and its symptoms ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index fd88104f0631..50c294d925b0 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3677,6 +3677,9 @@ static void mptcp_copy_ip6_options(struct sock *newsk, const struct sock *sk)
 
 	newnp = inet6_sk(newsk);
 
+	/* The IPv4 options belong to the listener, which frees them */
+	RCU_INIT_POINTER(inet_sk(newsk)->inet_opt, NULL);
+
 	rcu_read_lock();
 	opt = rcu_dereference(np->opt);
 	if (opt) {

-- 
2.55.0

