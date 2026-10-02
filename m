Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7574BEE41
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 17:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790962749; cv=none; b=g2HzKPDK1Cltib7+37c9D5Cuo6VVS5mps4XFt/S7cdAO8vliIvNi/kwFvX9PbFteD7mCHJk3AsO90jL+X3B0yOXSxyI8YIxWMKUHyJtoUoYSC/AcVu31K6Rze2tIieSkfCWt27kOVABjl+LE+ZR8IhTwiGMPN4YZ6qujlMzDDkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790962749; c=relaxed/simple;
	bh=lxYzkpriaDekB2b+vETaWpNqnj81kUfQDNd2Cv8ukZw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KM0WKa2fiNGnPdxrXmK2kth4ulu34srN1v3yx78awMHR625KBQl0f5Z8DD8BDgpVz5pqQltikeMQQ8mlqPjnkjO3OlUoOc+3Mc2Atb002GaYqcxpSxARihKPXYiXMAIbV/QlBQ3c9LaLf4xjI/dIUo8G6bYkjeg4YJGfXhDQk+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K7eLYoE8; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7eLYoE8"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-33bc6ff6cadso1198942eec.0
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 10:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790962732; x=1791567532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LrYrWMHbMhPiTpFi2/y0IXJsNMi1j3IUwWpiDmuGlWY=;
        b=K7eLYoE8vvpA2vqp2PmPHc05B7+DZxhovayfmdKbEy+ClmdktNEZ3ysg5bOPepPBGE
         X+VG8r8TKJexvPpjPoN7JewKeem1SXIV5ffZ1YCQRK8Lcppvdju1MwEw+OWZDcyDhkBU
         rKisABe/VUVAvHkXtlK7wCvPq4P8UgOrhkNIsX6cNKKGbcTWBozhwuEapG9isvfmVvrg
         Cv+nEYOH1LlDx63ifQUtoJ+zWQ9IhS92eXTSmvoGEr6wWHYHybRLSsoobDvBrZb+0l6o
         9jmjub8tVQUoYUBkv/e56l9cLhxDzeBwhVZdrZF+26rasVLs+MYx1uEwsJ959WatUT4s
         Q2AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790962732; x=1791567532;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LrYrWMHbMhPiTpFi2/y0IXJsNMi1j3IUwWpiDmuGlWY=;
        b=s7qS5myjZsv6rZw5cLXBj4g9aWlHeC8zLb3rzJCew+c1D+rFa2TUwZGftJjXytIVxR
         XdkzD4Gz+RSZ39AvwPZNu5wV/+fXHnMzHqq+fO72i7rfE0dez/5X7fgppQEJHIZRhrGw
         qjjX9G5DhoRXnkSNgcQ9eSpKFD9cyTndIkmOawu3b758VUwozPMPq3BjIN+CL5mdU30i
         w41ONqUmRmT3+NMvuus5cb8+pb2LtYkFmYbDcFIfU9/f8xs6sLFIRZYur7wG4A2n8duB
         rGImesEkT0D0Uhg2wUwAwqZZRd7U+8n4vw/zMJ030GMSMi8JRsrLGY1Q1d8j60v7z3qk
         R9dQ==
X-Forwarded-Encrypted: i=1; AKwUvBx14D6rRAEXX2wA9HtzoH02JVZMZsfK4OB00bQY03RnfH757VAzwJowivk0Wsx1v8yYkVd1yHM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKeTtrUl8kV9ke3q/k1G62RAgP9aBzv5tgF3OaBO3gAOb5CvgMH
	7ZB4p38YQa9sXV3+ZcSsPXPaquilnZpfJSBWokZicvQUV24UJ+KLXRgK
X-Gm-Gg: AYBFou2cv39jcgSo07wQEU1LD0iO73kV0S5IPy8cHJGd08108VNPMaxD4kpCUpeIY7/
	j2+eKxKbzfklL3oTG6bLQfzZP9Ht0cR+5VG82KZJ+k3i7WdclT7RMAMVQmra08vN6xsrMbOyUbz
	mYsszrPaOH4dGjh72CftS0uKWQa5G9QXu/20jyY381vo4QLjNBU/3AYVLfmYKlJoku6JVLXPJ6P
	w06d11I0NXzU+uvoH06Aw2pii6ELZEp9n0vSP+4JWYU41yD+fLai6TKmLjhFFM+hyo4tKEzWBw+
	2Rhb0lyYe02/x6v/ceSXLI1vlPriLIXGB+ttiNUmEvxVaG2ajv4tnZaoZB8Me9IapQbovBSq4Di
	34WTk5ZrZjwdDX5CcvOcf1VcGt9tPONrgiqPosKHirDss2DnsjhPfKBsSxKUm5nGWnm3t+pPQEJ
	k5vsJ/PkRKdxaGdwYvm/U3WmClN5x5jkRLF+qAIpHdXrODy0vFGxdM5jA1qmGbvsIxW7U5nytxk
	RIpU0fPrXubCMp1oxIZ/lIW2kcEjWvTT/i7sj4nCpCebg/+i862tmApVoZ9ue9dhnhvsw==
X-Received: by 2002:a05:693c:864b:10b0:33e:4e49:d08d with SMTP id 5a478bee46e88-3510d2815f3mr1841393eec.1.1790962732069;
        Fri, 02 Oct 2026 10:38:52 -0700 (PDT)
Received: from localhost.localdomain (95.169.12.199.16clouds.com. [95.169.12.199])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f14f2dfbbsm7844370eec.10.2026.10.02.10.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 10:38:51 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v4] net: pin protocol module before inet socket allocation
Date: Sat,  3 Oct 2026 01:38:44 +0800
Message-ID: <20261002173844.3537111-1-nicoyip.dev@gmail.com>
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

The reported failure occurred during concurrent L2TP socket creation and
module unload:

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

Use try_module_get() with its existing initialization semantics. SCTP
creates its kernel control socket during module initialization, so
rejecting MODULE_STATE_COMING would prevent modular SCTP from loading.
Failed module initialization can still unwind published protocols despite
module references; that separate publication/unwind lifetime issue is not
fixed here.

Fixes: a79af59efd20 ("[NET]: Fix module reference counts for loadable protocol modules")
Cc: stable@vger.kernel.org
Assisted-by: GPT-6-Astra
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
Changes in v4:
- Remove the MODULE_STATE_COMING rejection. SCTP creates its kernel control
  socket from module init and must be allowed to use the published protosw.
- Keep the owner cached under RCU and use the cached proto for IPv6 backlog
  setup, retaining those v3 changes.
- Scope the module-reference guarantee to normal module unload. The earlier
  review's initialization-failure unwind concern remains a separate issue;
  rejecting all initializing modules is not a compatible solution.
- Rebase onto net/main at a7bfaba4823e.

v3: https://lore.kernel.org/r/20260904111514.584264-1-nicoyip.dev@gmail.com/
Review: https://lore.kernel.org/r/178887699602.219967.13594894510710999619@kernel.org/
v2: https://lore.kernel.org/r/20260825172349.232794-1-nicoyip.dev@gmail.com/
v1: https://lore.kernel.org/r/20260823171311.3857087-1-nicoyip.dev@gmail.com/

 net/ipv4/af_inet.c  | 14 +++++++++++---
 net/ipv6/af_inet6.c | 16 ++++++++++++----
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 32d006c1a8ee..c956afa65ec4 100644
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
@@ -322,9 +323,14 @@ static int inet_create(struct net *net, struct socket *sock, int protocol,
 	    !ns_capable(net->user_ns, CAP_NET_RAW))
 		goto out_rcu_unlock;
 
-	sock->ops = answer->ops;
 	answer_prot = answer->prot;
+	answer_owner = answer_prot->owner;
 	answer_flags = answer->flags;
+	if (!try_module_get(answer_owner)) {
+		err = -EPROTONOSUPPORT;
+		goto out_rcu_unlock;
+	}
+	sock->ops = answer->ops;
 	rcu_read_unlock();
 
 	WARN_ON(!answer_prot->slab);
@@ -332,7 +338,7 @@ static int inet_create(struct net *net, struct socket *sock, int protocol,
 	err = -ENOMEM;
 	sk = sk_alloc(net, PF_INET, GFP_KERNEL, answer_prot, kern);
 	if (!sk)
-		goto out;
+		goto out_module_put;
 
 	err = 0;
 	if (INET_PROTOSW_REUSE & answer_flags)
@@ -398,6 +404,8 @@ static int inet_create(struct net *net, struct socket *sock, int protocol,
 		if (err)
 			goto out_sk_release;
 	}
+out_module_put:
+	module_put(answer_owner);
 out:
 	return err;
 out_rcu_unlock:
@@ -406,7 +414,7 @@ static int inet_create(struct net *net, struct socket *sock, int protocol,
 out_sk_release:
 	sk_common_release(sk);
 	sock->sk = NULL;
-	goto out;
+	goto out_module_put;
 }
 
 
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 282912a11999..9db60af6f38d 100644
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
@@ -167,9 +168,14 @@ static int inet6_create(struct net *net, struct socket *sock, int protocol,
 	    !ns_capable(net->user_ns, CAP_NET_RAW))
 		goto out_rcu_unlock;
 
-	sock->ops = answer->ops;
 	answer_prot = answer->prot;
+	answer_owner = answer_prot->owner;
 	answer_flags = answer->flags;
+	if (!try_module_get(answer_owner)) {
+		err = -EPROTONOSUPPORT;
+		goto out_rcu_unlock;
+	}
+	sock->ops = answer->ops;
 	rcu_read_unlock();
 
 	WARN_ON(!answer_prot->slab);
@@ -177,7 +183,7 @@ static int inet6_create(struct net *net, struct socket *sock, int protocol,
 	err = -ENOBUFS;
 	sk = sk_alloc(net, PF_INET6, GFP_KERNEL, answer_prot, kern);
 	if (!sk)
-		goto out;
+		goto out_module_put;
 
 	sock_init_data(sock, sk);
 
@@ -201,7 +207,7 @@ static int inet6_create(struct net *net, struct socket *sock, int protocol,
 	sk->sk_family		= PF_INET6;
 	sk->sk_protocol		= protocol;
 
-	sk->sk_backlog_rcv	= answer->prot->backlog_rcv;
+	sk->sk_backlog_rcv	= answer_prot->backlog_rcv;
 
 	inet_sk(sk)->pinet6 = np = inet6_sk_generic(sk);
 	np->hop_limit	= -1;
@@ -251,6 +257,8 @@ static int inet6_create(struct net *net, struct socket *sock, int protocol,
 		if (err)
 			goto out_sk_release;
 	}
+out_module_put:
+	module_put(answer_owner);
 out:
 	return err;
 out_rcu_unlock:
@@ -259,7 +267,7 @@ static int inet6_create(struct net *net, struct socket *sock, int protocol,
 out_sk_release:
 	sk_common_release(sk);
 	sock->sk = NULL;
-	goto out;
+	goto out_module_put;
 }
 
 int __inet6_bind(struct sock *sk, struct sockaddr_unsized *uaddr, int addr_len,

base-commit: a7bfaba4823e3c165bb2004c74eff7c096672bc7
-- 
2.43.0
