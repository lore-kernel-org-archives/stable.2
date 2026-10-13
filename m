Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3533AF646
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 07:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791878174; cv=none; b=oj+5AhZExehbOZXt9FjIQw46ZOYpSyIl+ySgnsHUQvR+gIbJ+wIJeZevG36hXXKsk50pD00fZQLfajf5/RykHDV0unuUayX/jO/oFX2LcjWvOkunnO6ftDA4enAFoZGgSz/h701UU3S0XOXebgr7+vGNfSkfwMzj0fJ5QLWT9sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791878174; c=relaxed/simple;
	bh=MZHRxP8Hr8PDgpPoUtBeq2/VkbH3kDom19l78BFSIDs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=owNPxCS3mqIWxPwcyHmOoNQIW4Fkpj32fb1Cm48mGDiufh3Cz55YfpASpRE0fj0IP8C03NvkeSRbPrI7DppABfiF1H0ytZWBh2mafk4D5ndbX/cgUhmyxXnyoECI7j8QDURd+02yrW6u6pVz1l+bSFKgL8vYqKvvQvi3jIj/dOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YeS85jCe; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YeS85jCe"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-33c30fcf33fso350510eec.1
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 00:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791878171; x=1792482971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PKr9Fx+KFI5Ax2iGLx+RxplSdarPhpdP5e4xzwI6Vs0=;
        b=YeS85jCeRsiNkhmpDRySIFeCm88m5N+7H/KtwWZ9St2mH9KtFD5NM7dnAJRIh5IUte
         GDrQZsC2/wD+6xF2Hlws50B+g18zNZwRucTJktvOdKD2hOYofi6DJjkMjKJgoJ9t0Kma
         onFpTuGPKAAW9fT3Q8/2+OngOaew7aoK4p53EftW14pV2wl86+cTybGtvQX6EQMz81VR
         DfFnJ7DQ8anmEBd+/1uG2V/hYBicUiF2GyVxsXTsDYJfW+MyQ9JmtbZmR9ZlTXbutD61
         jkecqft/1pQXPeOjnMnQHqN0qMaNa4AIHzuyjgodNzIB7esCYYUKrqEEHkvxF9wjjmA+
         idYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791878171; x=1792482971;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PKr9Fx+KFI5Ax2iGLx+RxplSdarPhpdP5e4xzwI6Vs0=;
        b=D+j5xkb21TChvTkL0wZp8JJp04WdKG1VgN6K3eupntu8Jj6uh/iwvxyXB+z/Jj7Vvd
         zbKQAQ6akDnyZvE9lYAP2UnwA0xdAYzAnm0Hd3nYf4lVziUbs9PaEb76arCQUZJwe3gE
         eUS7ukmmwFrpIHNS+4noV94HMcv1Va+q/n6siPTZkiJohz/oVV+VUxuu1SqzOTOAfkMf
         vcauvslFwuU648o3/vbthsZdceTqMVA8cQxZTXpKb0xCGFClgRhc8BEum1sxAEsDXfEE
         wuDEF8pzWdRGJj1+2yXXzO11gZ3Uz2qXOFpO+twlc10i5lEwloKpgNCMOp0594jxfpwk
         KwXw==
X-Forwarded-Encrypted: i=1; AKwUvBxcb2BV5eAU+jgIfQ6N6hX6PuoobuTnDbvml/lnLwAiSm+MAajFbgsoO9pSuLuRhaMujSnyPik=@vger.kernel.org
X-Gm-Message-State: AFq9FYJtX2U1n3CadpH1bVtXGazEk/3XF0tbyJNfoBOIbMHwtZAX9cLB
	+R7f4Z9FVOfLAshYtZRyZkVsVIX64VShqVrUc6NJ27J1v1kGQnml95Vi
X-Gm-Gg: AYBFou1UAny2smpXWkFwppl6xcAu4PBNGVczB/wRo42V3J6BnK4kjZksC10LvUsqWHl
	AimPhekzeLjO6S/6XSyYcINZkDCSdg0Ju68tDE/xflVzPYAZoHq4rpfWKYTfeOLLLnpA3NLoY5D
	mqvM1Rzk0A63PIy9eyZzietCi/l5JTAZbB4TM1nxVgqT6B0LribL8MfM1vBr36/nuYutQLYeF+B
	w+ZDXVDDRh15DWkC8lsuiQCQTV8vBDyaDA1J2esC09VSrbQ1E/TPZGdLuBE33RjGEJpHpdlqqme
	tulq1oWIcqy1a/jx1L1K3OQN+3S6nA4D4RIT5m+m4qYsrDDdIRSOJ/mifWW5ZnE8n0r3gmyaCzF
	momSa2iieXuPYB3BE6mzNMZXQaryUV3z/1HEKKjLX1c1c37OvEqwOSm8lkWdrRNeXDUv34Yl+wO
	utvOigd8XNYUaEQMum5t+NYvrXMwkoELjkUsx3M0dOmhfEKNmBbA0/Q3VA6wPg1kdhUE+pbK59K
	xJPLu07pvjFeo5ScbxSLXrUKVHRyHb2yvDmyUmT+pF49hQlL1UxLUINIJ9iIAp/
X-Received: by 2002:a05:7300:d18a:b0:340:f698:fd56 with SMTP id 5a478bee46e88-3537e04365dmr25523882eec.2.1791878171246;
        Tue, 13 Oct 2026 00:56:11 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb2fd33sm40060908eec.28.2026.10.13.00.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 00:56:10 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: kuniyu@google.com,
	horms@kernel.org,
	fmancera@suse.de,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>
Subject: [PATCH net v5] net: pin protocol module before inet socket allocation
Date: Tue, 13 Oct 2026 15:56:04 +0800
Message-ID: <20261013075604.868273-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

inet_create() and inet6_create() look up the protocol under RCU, then drop
RCU before using the resulting proto. A concurrent module unload can
unregister the protosw, wait for the RCU readers, and destroy the proto's
slab before sk_alloc() uses it. sk_alloc() may sleep, so the RCU read-side
critical section cannot simply be extended across the allocation.

An LLM-based source scan identified this issue. It was reproduced with
l2tp_ip by racing socket(AF_INET, SOCK_DGRAM, IPPROTO_L2TP) against module
unload in a KASAN-enabled QEMU guest. The reproduction used a temporary
50 ms delay between reading prot->slab and calling kmem_cache_alloc().
proto_unregister() destroyed the cache before the allocation used it:

  Oops: general protection fault, probably for non-canonical address
        0xffff1108974182a0
  KASAN: maybe wild-memory-access in range
         [0xfff8a844ba0c1500-0xfff8a844ba0c1507]
  RIP: kmem_cache_alloc_noprof+0x63/0x370
  Call Trace:
   sk_prot_alloc+0x74/0x2c0
   sk_alloc+0x2b/0x6c0
   inet_create+0x2cd/0xd40
   __sock_create+0x1c3/0x430
   __sys_socket+0x116/0x1d0

Cache the proto and its owner under RCU and acquire a temporary module
reference before dropping RCU. This prevents normal module unload while
the proto is in use. sk_prot_alloc() takes the socket's own reference;
drop the temporary reference on every exit after allocation. Use the
cached proto for the IPv6 backlog callback as well.

A failed module initialization can unwind published protocols despite
module references. Reject userspace socket creation while the owner is
MODULE_STATE_COMING, before dropping RCU. Exempt kernel sockets from this
state check: SCTP creates its kernel control socket from pernet init
before module initialization completes. These sockets pass kern=true,
which avoids pinning the network namespace they belong to. Both kernel
and userspace sockets still acquire the temporary module reference with
try_module_get().

Fixes: a79af59efd20 ("[NET]: Fix module reference counts for loadable protocol modules")
Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
Cc: stable@vger.kernel.org
Assisted-by: GPT-6-Astra
Assisted-by: OpenAI Codex
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
Changes in v5:
- Reject MODULE_STATE_COMING only for userspace sockets (!kern), as
  suggested by Kuniyuki. Preserve SCTP kernel control socket creation
  during module initialization and keep the temporary module reference
  for both kernel and userspace sockets.
- Document how the bug was discovered and the test-only delay used in
  the original KASAN reproduction, as requested by the discovery bot
  and Jakub. Retain the original fault addresses.
- Keep the cached owner, balanced temporary reference and cached IPv6
  backlog callback from v4.
- Rebase onto net/main at 8e2fbe0e75d3.

Validation:
- W=1 build with modular SCTP and compilation of both changed objects
  with CONFIG_MODULES=n.
- SCTP module loading and 20 socket/netns cycles per boot on baseline
  and v5, with IPv6 enabled and disabled; module references returned
  to their initial count after namespace cleanup.

v4: https://lore.kernel.org/r/20261002173844.3537111-1-nicoyip.dev@gmail.com/
Review: https://lore.kernel.org/r/20261012200752.3771786-1-kuniyu@google.com/
v3: https://lore.kernel.org/r/20260904111514.584264-1-nicoyip.dev@gmail.com/
v3 review: https://lore.kernel.org/r/178887699602.219967.13594894510710999619@kernel.org/
v2: https://lore.kernel.org/r/20260825172349.232794-1-nicoyip.dev@gmail.com/
v1: https://lore.kernel.org/r/20260823171311.3857087-1-nicoyip.dev@gmail.com/

 net/ipv4/af_inet.c  | 15 ++++++++++++---
 net/ipv6/af_inet6.c | 17 +++++++++++++----
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 14ce01092fda6..5c02022c6c182 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -263,6 +263,7 @@ static int inet_create(struct net *net, struct socket *sock, int protocol,
 	struct inet_protosw *answer;
 	struct inet_sock *inet;
 	struct proto *answer_prot;
+	struct module *answer_owner;
 	unsigned char answer_flags;
 	int try_loading_module = 0;
 	int err;
@@ -322,9 +323,15 @@ static int inet_create(struct net *net, struct socket *sock, int protocol,
 	    !ns_capable(net->user_ns, CAP_NET_RAW))
 		goto out_rcu_unlock;
 
-	sock->ops = answer->ops;
 	answer_prot = answer->prot;
+	answer_owner = answer_prot->owner;
 	answer_flags = answer->flags;
+	if ((!kern && answer_owner && module_is_coming(answer_owner)) ||
+	    !try_module_get(answer_owner)) {
+		err = -EPROTONOSUPPORT;
+		goto out_rcu_unlock;
+	}
+	sock->ops = answer->ops;
 	rcu_read_unlock();
 
 	WARN_ON(!answer_prot->slab);
@@ -332,7 +339,7 @@ static int inet_create(struct net *net, struct socket *sock, int protocol,
 	err = -ENOMEM;
 	sk = sk_alloc(net, PF_INET, GFP_KERNEL, answer_prot, kern);
 	if (!sk)
-		goto out;
+		goto out_module_put;
 
 	err = 0;
 	if (INET_PROTOSW_REUSE & answer_flags)
@@ -398,6 +405,8 @@ static int inet_create(struct net *net, struct socket *sock, int protocol,
 		if (err)
 			goto out_sk_release;
 	}
+out_module_put:
+	module_put(answer_owner);
 out:
 	return err;
 out_rcu_unlock:
@@ -406,7 +415,7 @@ static int inet_create(struct net *net, struct socket *sock, int protocol,
 out_sk_release:
 	sk_common_release(sk);
 	sock->sk = NULL;
-	goto out;
+	goto out_module_put;
 }
 
 
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 282912a119999..99e57fd643322 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -110,6 +110,7 @@ static int inet6_create(struct net *net, struct socket *sock, int protocol,
 	struct sock *sk;
 	struct inet_protosw *answer;
 	struct proto *answer_prot;
+	struct module *answer_owner;
 	unsigned char answer_flags;
 	int try_loading_module = 0;
 	int err;
@@ -167,9 +168,15 @@ static int inet6_create(struct net *net, struct socket *sock, int protocol,
 	    !ns_capable(net->user_ns, CAP_NET_RAW))
 		goto out_rcu_unlock;
 
-	sock->ops = answer->ops;
 	answer_prot = answer->prot;
+	answer_owner = answer_prot->owner;
 	answer_flags = answer->flags;
+	if ((!kern && answer_owner && module_is_coming(answer_owner)) ||
+	    !try_module_get(answer_owner)) {
+		err = -EPROTONOSUPPORT;
+		goto out_rcu_unlock;
+	}
+	sock->ops = answer->ops;
 	rcu_read_unlock();
 
 	WARN_ON(!answer_prot->slab);
@@ -177,7 +184,7 @@ static int inet6_create(struct net *net, struct socket *sock, int protocol,
 	err = -ENOBUFS;
 	sk = sk_alloc(net, PF_INET6, GFP_KERNEL, answer_prot, kern);
 	if (!sk)
-		goto out;
+		goto out_module_put;
 
 	sock_init_data(sock, sk);
 
@@ -201,7 +208,7 @@ static int inet6_create(struct net *net, struct socket *sock, int protocol,
 	sk->sk_family		= PF_INET6;
 	sk->sk_protocol		= protocol;
 
-	sk->sk_backlog_rcv	= answer->prot->backlog_rcv;
+	sk->sk_backlog_rcv	= answer_prot->backlog_rcv;
 
 	inet_sk(sk)->pinet6 = np = inet6_sk_generic(sk);
 	np->hop_limit	= -1;
@@ -251,6 +258,8 @@ static int inet6_create(struct net *net, struct socket *sock, int protocol,
 		if (err)
 			goto out_sk_release;
 	}
+out_module_put:
+	module_put(answer_owner);
 out:
 	return err;
 out_rcu_unlock:
@@ -259,7 +268,7 @@ static int inet6_create(struct net *net, struct socket *sock, int protocol,
 out_sk_release:
 	sk_common_release(sk);
 	sock->sk = NULL;
-	goto out;
+	goto out_module_put;
 }
 
 int __inet6_bind(struct sock *sk, struct sockaddr_unsized *uaddr, int addr_len,

base-commit: 8e2fbe0e75d38690d551456658194c632933cb57
-- 
2.43.0

