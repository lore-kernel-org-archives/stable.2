Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256513DA5DA
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 23:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787874919; cv=none; b=fokXOaLcDeHHCx20DXPfiojRSKtstSFZTIzwylCEGVBLhkCJRgiJHh8CnllLNw6bH5LD5SQU3Rcc7TkFLt1fVXYnQl7o9Vxg0bPNy253zbjH5GYZ0bR5OpZqKN8bAh45v8t3dcR5wLBD+lwLZ7WCyl31Bf7Hc4XvNpkJpOHinpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787874919; c=relaxed/simple;
	bh=17DL7rhafk1dsgIeYoK4mS2o50WhRjWyO2dEKqAEpdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HTpc6jKizhoP7kdVLwAx85kDZvucZvyxQbIveIXTM5KfBR2Wj29yey5YJ8YU6oJ8FkuX/DZGaHTDb/jdh+rbt6u1ZqQan35KE8Kc9U4LotOJkRZCAYlGJKOw+fTEl0K2OlsWkDY95g9kqw3qBO3qZoukcZ2To3Xxb7pLn/VwZlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sC3pQT9w; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sC3pQT9w"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-66d116f0de8so770766d50.0
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 16:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787874916; x=1788479716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jvm7J3YSk1/1T92COXCSTc907ZSd3vJ2D2ODqJKXqh8=;
        b=sC3pQT9w16X8e1FpEkMG6skdnkz3y6W25eGE49xth0hbRGOZG8r9cJy7vO7hb7XVh1
         HccgqlnWExlRcyHVA8kceftioB0FQVFphc9IDS195xgzYP6AdHXVkUfpGbWT2yqo1urv
         6HBqjCNaTGuSz77ZNtDQGSOx6fyE/fMRl+6uU/D8huih79l4QcFg46gXATGclQf62NgP
         Y2ZJf4iXR9gBQ/jYy3yLN29KXKpBGaB6z/tjF57XDBRTtCpIQ85QvGI7s0HbQaTlcqIJ
         Iaqie7fqQL88FJFqsTiUDmu9ACHXSAxX8NijAIw/70hC2TxHMVlarBQ0yCN/sbVC9wsD
         QKWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787874916; x=1788479716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jvm7J3YSk1/1T92COXCSTc907ZSd3vJ2D2ODqJKXqh8=;
        b=rkJngLFTRWEKc+Wy5hX95hFicsyNBh0lzxTB70YbisI6McuzygBd7cUjv4DA4EznSb
         sMRRO93WLF7HGqKBilLCPYPVORSGV/HYLXg0dpsNUH6SSsRJAF3D/aR8IzpYjZlb6+70
         QECZZOvN7F4yCf2rvyI1KzyggY2RXP8pc7ccBt7UKU0zLRShcZTedEhevvRRd342cJ4d
         iSgUOiA2zRK73gdDCbUYHJwh2zUYQ+3IGgG/eif/auXrh2LwmkAcKM73+QR+YRv5qM5R
         4imzIvgC6zn234Gj7891b1UBev+rB24dfMdLyf2/wYXMe5/M+p1GZ5zTFS68RnzMPUFn
         BgFA==
X-Forwarded-Encrypted: i=1; AHgh+RqWdYgGACymD/Uw0U/CsoRpF1X92z0NpLbpBo/wPnN0QFyTbFEtWwNoZt1SZ2EJWb/JDblXoHQ=@vger.kernel.org
X-Gm-Message-State: AFuF++m+Qd/EYBI54e8xHkbFlpVfSgNdeWJmieo1996jUb8ANeWXf+Rn
	ms0r/vPw3BqGzFAdLRIe8Tl3npBPfFbs+L0vIpD8eIeK+rHlCunksVvW
X-Gm-Gg: AR+sD114NCfeon8Qq5934kGJWqWNlXsOytEbwnM6KgSqeJIZP4ajXlgLnjIP7c9TIWE
	qgJuGtRKR7u0RlRsj6HOAa7kSAoEdnvUA3bMAWFgG5vpvJwMDchLODSz2tP/1ejaXe2SWI4MHU0
	yVxDZY0hK7OYcd0Jr4B4GN5bbeTBuYrTmkb1SwaTrr0ScRhkDk874EPdkGnjOks2Dub3XQWU3kS
	WwqLFHGTuAug0HVV3JimIwfxmYHu2XbSlTC3px7uGTyImuPKUJtfPjBXFRvWmTISnFcQ/t91CbI
	cDQ1ItuXi3WVXyAzynV55iBu/9H0Pn/CqK9fvzMB+6WLNLb1O+GGxy1auFgtpIPce41ms1eI1UP
	Xst9UzdCfd5y2u+QXYQgD9ADvQsIEYGPZ24sr3dvx12ihWZW9ITyt8RfikIDmv8oV/X2WBu0879
	CcP4cV+XYlxvfK2cRjfnZYVuG3F2/On2EnApphaCi+zvY4XrargDfefYF9UArys2Fkjo6q2CDJH
	4RdqQ==
X-Received: by 2002:a53:b812:0:b0:66d:2b87:67d2 with SMTP id 956f58d0204a3-66e4c6505demr643968d50.14.1787874914413;
        Thu, 27 Aug 2026 16:55:14 -0700 (PDT)
Received: from mac.lan ([136.55.173.105])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66e4eb3dcdbsm55704d50.4.2026.08.27.16.55.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 27 Aug 2026 16:55:14 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: edumazet@google.com,
	ncardwell@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: kuniyu@google.com,
	horms@kernel.org,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	yhs@fb.com,
	kafai@fb.com,
	andriin@fb.com,
	ast@kernel.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	xmei5@asu.edu,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	blbllhy@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH net v3 1/2] tcp: fix use-after-free in do_tcp_getsockopt(TCP_CONGESTION)
Date: Thu, 27 Aug 2026 19:55:10 -0400
Message-ID: <d3f97f1acbf0010898148be6e6406e4b8b4a5c84.1787870710.git.blbllhy@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1787870710.git.blbllhy@gmail.com>
References: <cover.1787870710.git.blbllhy@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Cen Zhang (Microsoft Security FORGE Labs)" <blbllhy@gmail.com>

do_tcp_getsockopt() reads icsk->icsk_ca_ops->name without holding
rcu_read_lock(). Since commit 0baf26b0fcd7 ("bpf: tcp: Support
tcp_congestion_ops in bpf"), icsk_ca_ops can point to dynamically
allocated BPF struct_ops memory that may be freed concurrently via
setsockopt(TCP_CONGESTION), leading to a use-after-free.

  BUG: KASAN: slab-use-after-free in _copy_to_user+0x37/0x60
  Read of size 16 at addr ffff888013505260 by task exploit/149
   _copy_to_user+0x37/0x60
   do_tcp_getsockopt+0x158a/0x2460 (net/ipv4/tcp.c:4585)
   tcp_getsockopt+0x91/0xf0
   __sys_getsockopt+0xf7/0x170

Fix this by holding rcu_read_lock() around the ca_ops->name access,
using READ_ONCE() to load icsk_ca_ops, and copying the name to a
stack buffer before releasing the lock. Also annotate the relevant
icsk_ca_ops stores with WRITE_ONCE() to fix the accompanying KCSAN
data-race issue.

Fixes: 0baf26b0fcd7 ("bpf: tcp: Support tcp_congestion_ops in bpf")
Suggested-by: Eric Dumazet <edumazet@google.com>
Reported-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
Link: https://lore.kernel.org/all/20260821182449.79785-2-blbllhy@gmail.com/
Cc: AutonomousCodeSecurity@microsoft.com
Cc: stable@vger.kernel.org
Assisted-by: GitHub-Copilot:claude-opus-4.6
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Cen Zhang (Microsoft Security FORGE Labs) <blbllhy@gmail.com>
---
Note: The adjacent TCP_ULP case has a similar read pattern on
icsk_ulp_ops->name, but icsk_ulp_ops always points to static
module data (no BPF struct_ops equivalent), so it is not affected.

Changes in v3:
- Fix the build failure by loading icsk_ca_ops inline.
- Drop the unrelated WRITE_ONCE() conversion in mptcp_ca_reset().

Changes in v2:
- Add READ_ONCE() for the icsk_ca_ops load.
- Add WRITE_ONCE() for every explicit icsk_ca_ops store.
---
 net/ipv4/tcp.c           | 14 +++++++++++---
 net/ipv4/tcp_cong.c      |  4 ++--
 net/ipv4/tcp_dctcp.c     |  2 +-
 net/ipv4/tcp_minisocks.c |  2 +-
 net/ipv4/tcp_output.c    |  2 +-
 5 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 455441f1b..55ca74f60 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4576,16 +4576,24 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 		val = !inet_csk_in_pingpong_mode(sk);
 		break;
 
-	case TCP_CONGESTION:
+	case TCP_CONGESTION: {
+		char ca_name[TCP_CA_NAME_MAX] = {};
+
 		if (copy_from_sockptr(&len, optlen, sizeof(int)))
 			return -EFAULT;
 		len = min_t(unsigned int, len, TCP_CA_NAME_MAX);
 		if (copy_to_sockptr(optlen, &len, sizeof(int)))
 			return -EFAULT;
-		if (copy_to_sockptr(optval, icsk->icsk_ca_ops->name, len))
+
+		rcu_read_lock();
+		memcpy(ca_name, READ_ONCE(icsk->icsk_ca_ops)->name,
+		       sizeof(ca_name));
+		rcu_read_unlock();
+
+		if (copy_to_sockptr(optval, ca_name, len))
 			return -EFAULT;
 		return 0;
-
+	}
 	case TCP_ULP:
 		if (copy_from_sockptr(&len, optlen, sizeof(int)))
 			return -EFAULT;
diff --git a/net/ipv4/tcp_cong.c b/net/ipv4/tcp_cong.c
index e9f6c77e0..8e83ef81f 100644
--- a/net/ipv4/tcp_cong.c
+++ b/net/ipv4/tcp_cong.c
@@ -223,7 +223,7 @@ void tcp_assign_congestion_control(struct sock *sk)
 	ca = rcu_dereference(net->ipv4.tcp_congestion_control);
 	if (unlikely(!bpf_try_module_get(ca, ca->owner)))
 		ca = &tcp_reno;
-	icsk->icsk_ca_ops = ca;
+	WRITE_ONCE(icsk->icsk_ca_ops, ca);
 	rcu_read_unlock();
 
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
@@ -253,7 +253,7 @@ static void tcp_reinit_congestion_control(struct sock *sk,
 	struct inet_connection_sock *icsk = inet_csk(sk);
 
 	tcp_cleanup_congestion_control(sk);
-	icsk->icsk_ca_ops = ca;
+	WRITE_ONCE(icsk->icsk_ca_ops, ca);
 	icsk->icsk_ca_setsockopt = 1;
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
 
diff --git a/net/ipv4/tcp_dctcp.c b/net/ipv4/tcp_dctcp.c
index 274e628e7..99f68c299 100644
--- a/net/ipv4/tcp_dctcp.c
+++ b/net/ipv4/tcp_dctcp.c
@@ -111,7 +111,7 @@ __bpf_kfunc static void dctcp_init(struct sock *sk)
 	/* No ECN support? Fall back to Reno. Also need to clear
 	 * ECT from sk since it is set during 3WHS for DCTCP.
 	 */
-	inet_csk(sk)->icsk_ca_ops = &dctcp_reno;
+	WRITE_ONCE(inet_csk(sk)->icsk_ca_ops, &dctcp_reno);
 	INET_ECN_dontxmit(sk);
 }
 
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 6ab3e3a0b..def3b25ab 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -507,7 +507,7 @@ void tcp_ca_openreq_child(struct sock *sk, const struct dst_entry *dst)
 		ca = tcp_ca_find_key(ca_key);
 		if (likely(ca && bpf_try_module_get(ca, ca->owner))) {
 			icsk->icsk_ca_dst_locked = tcp_ca_dst_locked(dst);
-			icsk->icsk_ca_ops = ca;
+			WRITE_ONCE(icsk->icsk_ca_ops, ca);
 			ca_got_dst = true;
 		}
 		rcu_read_unlock();
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index d7c1444b5..e72ebfe7b 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -4092,7 +4092,7 @@ static void tcp_ca_dst_init(struct sock *sk, const struct dst_entry *dst)
 	if (likely(ca && bpf_try_module_get(ca, ca->owner))) {
 		bpf_module_put(icsk->icsk_ca_ops, icsk->icsk_ca_ops->owner);
 		icsk->icsk_ca_dst_locked = tcp_ca_dst_locked(dst);
-		icsk->icsk_ca_ops = ca;
+		WRITE_ONCE(icsk->icsk_ca_ops, ca);
 	}
 	rcu_read_unlock();
 }
-- 
2.43.0
