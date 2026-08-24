Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5704713777E
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 03:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787542456; cv=none; b=fdfuOvAnI984Xrs2orp1EzuuBtFp+KahbSc+Xf0umkwsuI8y7Vu+LFfDuuk+qwIc7kgXm+CPxFG0Fkqc76HsFuupkRMfLiixiMiIwrtr31FuY4QdWYQ5RObOJUvtvo4anxde+2ZhYGGvIewp1wY0XYzy5uKiYYLUXpV5tNBqNC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787542456; c=relaxed/simple;
	bh=u3y54k+0lvhiUX1UbI9Aif7xvnSV+L7OHs/brlLc2gM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p9ZeOHQxoHDYoNHqDKwNL94LoQliJ8kwIqh9cdiBOci2GJkH1fQNFjNfSqc/dYUzLlUIAImisnkzexyjtJ8lPddfZZjmk4JiWhJHlwUrzw9Qm0vPa0Ei5EZJ+0fXRvhYFi9gNBe/x7o6BfeD3s8fIeS0QsGPRoCUOKqzzEIceM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QlKWiyL0; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QlKWiyL0"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so2417111a91.2
        for <stable@vger.kernel.org>; Sun, 23 Aug 2026 20:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787542455; x=1788147255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PXkKkJ4/pQ31f/Gro96CCtKQ7s8xDXf64Jn4C2P4P+U=;
        b=QlKWiyL0NyRb4RYjIX5UkaG/9hpll2qbBMlGJClSh08ERB8R/MeHbrb2MIADmDLEsj
         S7iMJAVpw99wGAB3atH2DuaMIJGY2W8S2KhsfjfjwzAzO19d6/JJOnuBiKxcWnlDl3je
         rO5WE4Kksdbwvlz1efFcvqwSS4kukt9FZtpIaYe+NdNYMRuVzqCefuV+WcMykjejNb1Y
         SNffqybGaLjFLdgG0hgSNyne9/js9IEeimAUCjwG9dVn1lCVJAj3r8mUzw08H92MIqs0
         F1KTTnPZVDMXfEInben/KCI87VOSWwrBHXOBrtFF7fY5OvjM4HSURrlDCdAtEhG1f/+c
         DYBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787542455; x=1788147255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PXkKkJ4/pQ31f/Gro96CCtKQ7s8xDXf64Jn4C2P4P+U=;
        b=OT6rv6e8JhHKkpgPOa3BQrTdduH4HuKL9v1N5CWPWGrQtrKMH/wqhFjw1rgY3nY7fe
         RskOaXgykLci99Sfz9xqgXLFxh1DZrZm1nO9HIgbfP29Gh3eLFSqrOnUqq0J7IS9DIo7
         VeTwjcgVo+ch7SbDBMwFvNEhmkvDdDJoQCKzJpMRTQ76bRpEJrpYagAVHqcuLtssbSkB
         BFBlkhqwb751GMBW2IYLFQsA2HSFTYYw1xwRitI4klwoR0wiN+wO3xGn9LfSB15EkAjk
         5O/M0y+9xt8F8IAtxQP96X+6XioAMLNmdkFuWmbtpbjmXjoU59RdIoNnJhWmcc3WolOK
         2wsw==
X-Forwarded-Encrypted: i=1; AHgh+RpqoD2zXPtm0l1FgJJYhKaAhgOr0vF9ef8MBpLY/bQ/cqh+fjBEv8Ayvh+J/lVeI4bxqf56JC4=@vger.kernel.org
X-Gm-Message-State: AFuF++mzrLX1Nmb2Ea3oPVd9I1zml5wwK/mcJPWuOwaN3Hh+VmFaCa6k
	1e4B0W295kcElUoEP+chdKcCb0ELbEvM8oykYQxrvfPc0f6FBnXtvj3S
X-Gm-Gg: AR+sD13ZArCzwlLFcbsnU1i/P8zm7bcv7XDu74P5NCDCJP3mZUcWnYgTGKNEkxY7Idf
	H387cjqstxS7A8fjaBf3h2vokMvUu09RTo+bpPE7HVPrqQYx45F430vWbLIK1Ye6EVIKDT0a0YT
	+iRFmb55K2fICh5magWo7oHvk6IlfsdalQiePBzV+aeXQlmKJxeym1B9yGHiS8b1YlL84Im0u0s
	vAKchc61wZYQIJEEhnvimp/GXGirk7ezQA+j4qk53lIxDW7GODneZGUCombq7q0cOWy/wJkD8Tw
	tXMjKDCxIbJJovh1b44CDAmhR0In6pWNe0NH/thCXjEPixkifuMFRzRDVi5yPaV+xTwKCCKS+wu
	peXYLjG9BeIDn4yo/D0BcFMY6PrkwG7csp4QUz0rLadV2HmFSNESZXzkoA1JALLzzVn53IDlTh3
	5cHNuDheoRy0OIHP8BlJ8ivDwPR3B0Xv0Y2I6vu5YnDEJQei8QpKLbUbF51bx8sSz/z+ISryhnc
	U1odE6YdNg=
X-Received: by 2002:a17:90b:4c49:b0:366:10f1:3d91 with SMTP id 98e67ed59e1d1-395c354d42dmr39650990a91.1.1787542454662;
        Sun, 23 Aug 2026 20:34:14 -0700 (PDT)
Received: from v4bel.. ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395c8fd34d9sm4227256a91.1.2026.08.23.20.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 20:34:14 -0700 (PDT)
From: Hyunwoo Kim <imv4bel@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ncardwell@google.com,
	dsahern@kernel.org,
	idosch@nvidia.com,
	kuniyu@google.com,
	horms@kernel.org,
	willemb@google.com,
	andrew+netdev@lunn.ch,
	kees@kernel.org,
	jiayuan.chen@linux.dev
Cc: kerneljasonxing@gmail.com,
	ij@kernel.org,
	martin.lau@kernel.org,
	shakeel.butt@linux.dev,
	matttbe@kernel.org,
	martineau@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imv4bel@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH net v2 1/8] tcp: fix use-after-free of the listener's ipv6_pinfo after IPV6_ADDRFORM
Date: Mon, 24 Aug 2026 12:32:45 +0900
Message-ID: <20260824033331.1084971-2-imv4bel@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824033331.1084971-1-imv4bel@gmail.com>
References: <20260824033331.1084971-1-imv4bel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IPV6_ADDRFORM switches an established AF_INET6 TCP socket to tcp_prot and
ipv4_specific. The socket is still a tcp6_sock, so ->pinet6 keeps pointing
at the ipv6_pinfo inside it, and sk_destruct is left alone because
commit d38afeec26ed ("tcp/udp: Call inet6_destroy_sock() in IPv6
sk->sk_destruct().") uses it to clean up the IPv6 resources.

After connect(AF_UNSPEC) the socket can listen() again. Its children are
then created by tcp_v4_syn_recv_sock() with opt_child_init NULL, and
sk_clone() allocates them from tcp_prot, so each one is a plain tcp_sock
that inherits ->pinet6 and sk_destruct from the listener.
tcp_v6_mapped_child_init(), added by commit 858d2a4f67ff ("tcp: fix
potential race in tcp_v6_syn_recv_sock()"), would overwrite ->pinet6, but
tcp_v6_syn_recv_sock() is the only caller that passes it and it is not
involved here.

A child can outlive the listener. INET_ECN_xmit() and INET_ECN_dontxmit()
test inet6_sk(sk) and not sk_family, so tcp_ecn_send() updates np->tclass
through the stale pointer, and the child's destructor runs
inet6_cleanup_sock() on the freed listener.

In short:

  socket(AF_INET6) -> bind -> listen
      // a client connects over IPv4
  accept()                              // the child is v4-mapped
  setsockopt(IPV6_ADDRFORM, PF_INET)    // it becomes an AF_INET socket
  connect(AF_UNSPEC) -> bind -> listen  // reuse it as an IPv4 server
      // a client connects again
  accept()
  close(the listener)
  close(the accepted socket)            // use-after-free

KASAN log:

  BUG: KASAN: slab-use-after-free in __tcp_transmit_skb+0x1070/0x2020
  Read of size 1 at addr ffff888016671af3 by task poc/111
  ...
  Call Trace:
   __tcp_transmit_skb+0x1070/0x2020
   tcp_write_xmit+0xace/0x3380
   __tcp_push_pending_frames+0x58/0x180
   __tcp_close+0x4b8/0x7d0
   tcp_close+0x23/0x90
   inet_release+0x93/0x100
   __sock_release+0x66/0x130
   sock_close+0x18/0x20
   __fput+0x1f0/0x4c0
   __x64_sys_close+0x55/0x90
  ...
  BUG: KASAN: slab-use-after-free in inet6_cleanup_sock+0x61/0x140
  Write of size 8 at addr ffff888016671b20 by task poc/111
  ...
  Call Trace:
   inet6_cleanup_sock+0x61/0x140
   inet6_sock_destruct+0x12/0x20
   __sk_destruct+0x4f/0x420
   inet_release+0x93/0x100
   __sock_release+0x66/0x130
   sock_close+0x18/0x20
   __fput+0x1f0/0x4c0
   __x64_sys_close+0x55/0x90
  ...
  Allocated by task 111:
   sk_prot_alloc+0x45/0x170
   sk_clone+0x49/0x970
   inet_csk_clone_lock+0x29/0x2c0
   tcp_create_openreq_child+0x2a/0x10a0
   tcp_v4_syn_recv_sock+0xd3/0x850
   tcp_v6_syn_recv_sock+0xc12/0xd80
   tcp_check_req+0x390/0x1080
   tcp_v4_rcv+0xc15/0x21c0
  ...
  Freed by task 14:
   slab_free_after_rcu_debug+0xd5/0x220
   rcu_core+0x4fe/0xe20
  ...
  The buggy address belongs to the object at ffff888016670e40
   which belongs to the cache TCPv6 of size 3328

Fix this by clearing ->pinet6 and ->ipv6_fl_list on the child, and by
returning early from inet6_cleanup_sock() when there is no ipv6_pinfo.
tcp_v6_mapped_child_init() sets both fields, so the v4-mapped path is not
affected. The converted listener keeps its own ipv6_pinfo, so there is
nothing to clear on the IPV6_ADDRFORM side.

Clearing ->pinet6 in tcp_disconnect() instead would keep this out of the
fast path, but it leaves the pointer NULL on a socket that still has a
file descriptor, and of the 120 inet6_sk() call sites only the two in
inet_ecn.h check it for NULL, so _all_ the others have to be found and
guarded first. At the point patched here the child is not in the ehash yet
and has no sk_socket. Once the two fields are cleared it is no different
from any other AF_INET child.

Fixes: d38afeec26ed ("tcp/udp: Call inet6_destroy_sock() in IPv6 sk->sk_destruct().")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
Changes in v2:
- Clear ->pinet6 and ->ipv6_fl_list right after the inet fields are set
instead of in an else arm of the opt_child_init test, so the child is
already consistent on the put_and_exit path and the existing test is left
untouched.
- Explain why this is not done in tcp_disconnect().
- Add the reproducer and the KASAN reports.
- v1: https://lore.kernel.org/all/antr7RCJAO578ZFW@v4bel/
---
 net/ipv4/tcp_ipv4.c | 8 ++++++++
 net/ipv6/af_inet6.c | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 190c7af4cf923a..302afe8ebcbcc3 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1714,6 +1714,14 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock *sk, struct sk_buff *skb,
 		inet_csk(newsk)->icsk_ext_hdr_len = inet_opt->opt.optlen;
 	atomic_set(&newinet->inet_id, get_random_u16());
 
+#if IS_ENABLED(CONFIG_IPV6)
+	/* Never inherit the listener's ipv6_pinfo; IPV6_ADDRFORM leaves it set
+	 * on an AF_INET socket.  tcp_v6_mapped_child_init() installs our own.
+	 */
+	newinet->pinet6 = NULL;
+	newinet->ipv6_fl_list = NULL;
+#endif
+
 	/* Set ToS of the new socket based upon the value of incoming SYN.
 	 * ECT bits are set later in tcp_init_transfer().
 	 */
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 282912a1199992..68b330f6941d04 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -479,6 +479,10 @@ void inet6_cleanup_sock(struct sock *sk)
 	struct sk_buff *skb;
 	struct ipv6_txoptions *opt;
 
+	/* AF_INET child of an IPV6_ADDRFORM'ed listener: nothing of its own. */
+	if (!np)
+		return;
+
 	/* Release rx options */
 
 	skb = xchg(&np->pktoptions, NULL);
-- 
2.43.0

