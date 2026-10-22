Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792696764;
	b=j+8Yxp1smNaZyDrCuZvYQ1yiDSBAiK0CVL5Q743b/1gFv9ETEKN50TpLS+NaQ8ZrFUK/
	 L8A9QjrDJFuiXiddSopmCPgSh9YSwaAw/N/xV2GFkWTowtR2A2GLPfyTA/MVAjM5GKHOc
	 czTL+2NNxZ1xL9wFmVRPJdfxfRhl3QMeaKVzMUpVMmyGpetU6fSI6K4yz07ak+PMfMXKI
	 zXy7aqGUqY3JkXkY8ZZMiUud/ITaD4P5jZtLypn98iN5n8JYJh1XMTQ0jyFiSAs6CzZ4b
	 njtyFqgtY+9vxbGWEHkpe7YG8wfSQbVfKEiTymFSuir2DcS6S1ss2sx+7rb6D1urCGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792696764;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=CLxxmfzvelJnvAOzDMgcXpzY1oWdcfPT8fxeYyLc6wI=;
	b=Z5MOIzpsX+GHZA6We8WaMdMYXv/WBe8gfioUCrn72/G8rXVbYoXEb4M9t7P8Is7gjjox
	 kpVI4G199fGBhB25N1haFfUHZ9t0nuvXpsGXaOr14GYgejJHMtVoep7x73purbMlWvw7E
	 LU73wRnlFkskc6sCz7mdpaxBIMVvhPELmQYL4N/prhyCNDX5H0ldgi4qHWLOqRMQWJVPX
	 BCTMmUeRiFYg5odAAO/4yC1Q/JKEYSfkmHjXIB/HI2UBY4l2iD9IKGrfhbP/ZB1tKOd40
	 jTiokJlE1cahYTBhDvIt/Jn9HvldEs4Cs8tvqY8papTGrA8i/D15CSuba7IPiHuuFaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FZIUjNOf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE468606A319
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 19:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FZIUjNOf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A7861F01825;
	Thu, 22 Oct 2026 19:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792696758;
	bh=CLxxmfzvelJnvAOzDMgcXpzY1oWdcfPT8fxeYyLc6wI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FZIUjNOfQiXqcqiLjeZYEjE1711aGX7K8FHE2L9ot0AA+ZEhnRE2YHN9eI9rZOtIZ
	 YL8ox9v27C+h70Ga+1u9wFII8Y1d471xbUnb7FtHtTWBEVNyPr8mD0EfTUayJ1X42p
	 tTk2GRjxgrHn2thZGANIe/3MMC+iosD5FJTQ0n5Of78LsSD36hUvHL0ErIlAMbXncN
	 VLJvc4M8DMk2sV67XDrBQXsoQlY98bAdcyJt9Ns95V+CS6qlsIgEpEKRJcKNQN4twX
	 oHairL02GoleU3Pzn+Y6lODiXRo3SLSj/5JyAgH3nQ+rbtpwLzjG4mYBraukIDwqs/
	 lm9KPDsjSf4hg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Cen Zhang (Microsoft Security FORGE Labs)" <blbllhy@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	"Xiang Mei (Microsoft)" <xmei5@asu.edu>,
	AutonomousCodeSecurity@microsoft.com,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] tcp: fix use-after-free in do_tcp_getsockopt(TCP_CONGESTION)
Date: Thu, 22 Oct 2026 15:19:15 -0400
Message-ID: <20261022190941.1760339-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102127-crept-debate-2807@gregkh>
References: <2026102127-crept-debate-2807@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Cen Zhang (Microsoft Security FORGE Labs)" <blbllhy@gmail.com>

[ Upstream commit 5271b79b7ad68dcb222e893773f92bdabf7750f3 ]

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
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Cen Zhang (Microsoft Security FORGE Labs) <blbllhy@gmail.com>
Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Reviewed-by: Breno Leitao <leitao@debian.org>
Link: https://patch.msgid.link/d3f97f1acbf0010898148be6e6406e4b8b4a5c84.1787870710.git.blbllhy@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ sashal: Replaced socket-pointer helpers with the existing get_user(), put_user(), and copy_to_user() APIs. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp.c           | 14 +++++++++++---
 net/ipv4/tcp_cong.c      |  4 ++--
 net/ipv4/tcp_dctcp.c     |  2 +-
 net/ipv4/tcp_minisocks.c |  2 +-
 net/ipv4/tcp_output.c    |  2 +-
 5 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 5e1c3ad6d1c5e..990afe964c9c2 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4070,16 +4070,24 @@ static int do_tcp_getsockopt(struct sock *sk, int level,
 		val = !inet_csk_in_pingpong_mode(sk);
 		break;
 
-	case TCP_CONGESTION:
+	case TCP_CONGESTION: {
+		char ca_name[TCP_CA_NAME_MAX] = {};
+
 		if (get_user(len, optlen))
 			return -EFAULT;
 		len = min_t(unsigned int, len, TCP_CA_NAME_MAX);
 		if (put_user(len, optlen))
 			return -EFAULT;
-		if (copy_to_user(optval, icsk->icsk_ca_ops->name, len))
+
+		rcu_read_lock();
+		memcpy(ca_name, READ_ONCE(icsk->icsk_ca_ops)->name,
+		       sizeof(ca_name));
+		rcu_read_unlock();
+
+		if (copy_to_user(optval, ca_name, len))
 			return -EFAULT;
 		return 0;
-
+	}
 	case TCP_ULP:
 		if (get_user(len, optlen))
 			return -EFAULT;
diff --git a/net/ipv4/tcp_cong.c b/net/ipv4/tcp_cong.c
index f43db30a7195d..3c3b6e1ab5424 100644
--- a/net/ipv4/tcp_cong.c
+++ b/net/ipv4/tcp_cong.c
@@ -164,7 +164,7 @@ void tcp_assign_congestion_control(struct sock *sk)
 	ca = rcu_dereference(net->ipv4.tcp_congestion_control);
 	if (unlikely(!bpf_try_module_get(ca, ca->owner)))
 		ca = &tcp_reno;
-	icsk->icsk_ca_ops = ca;
+	WRITE_ONCE(icsk->icsk_ca_ops, ca);
 	rcu_read_unlock();
 
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
@@ -194,7 +194,7 @@ static void tcp_reinit_congestion_control(struct sock *sk,
 	struct inet_connection_sock *icsk = inet_csk(sk);
 
 	tcp_cleanup_congestion_control(sk);
-	icsk->icsk_ca_ops = ca;
+	WRITE_ONCE(icsk->icsk_ca_ops, ca);
 	icsk->icsk_ca_setsockopt = 1;
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
 
diff --git a/net/ipv4/tcp_dctcp.c b/net/ipv4/tcp_dctcp.c
index ef7a8d810265f..654e502cf1b31 100644
--- a/net/ipv4/tcp_dctcp.c
+++ b/net/ipv4/tcp_dctcp.c
@@ -106,7 +106,7 @@ static void dctcp_init(struct sock *sk)
 	/* No ECN support? Fall back to Reno. Also need to clear
 	 * ECT from sk since it is set during 3WHS for DCTCP.
 	 */
-	inet_csk(sk)->icsk_ca_ops = &dctcp_reno;
+	WRITE_ONCE(inet_csk(sk)->icsk_ca_ops, &dctcp_reno);
 	INET_ECN_dontxmit(sk);
 }
 
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index be4fb0ce2574c..a2ec0bbac6a1a 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -416,7 +416,7 @@ void tcp_ca_openreq_child(struct sock *sk, const struct dst_entry *dst)
 		ca = tcp_ca_find_key(ca_key);
 		if (likely(ca && bpf_try_module_get(ca, ca->owner))) {
 			icsk->icsk_ca_dst_locked = tcp_ca_dst_locked(dst);
-			icsk->icsk_ca_ops = ca;
+			WRITE_ONCE(icsk->icsk_ca_ops, ca);
 			ca_got_dst = true;
 		}
 		rcu_read_unlock();
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 7ebd8c88d2ab3..c32a1bf2016ce 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3680,7 +3680,7 @@ static void tcp_ca_dst_init(struct sock *sk, const struct dst_entry *dst)
 	if (likely(ca && bpf_try_module_get(ca, ca->owner))) {
 		bpf_module_put(icsk->icsk_ca_ops, icsk->icsk_ca_ops->owner);
 		icsk->icsk_ca_dst_locked = tcp_ca_dst_locked(dst);
-		icsk->icsk_ca_ops = ca;
+		WRITE_ONCE(icsk->icsk_ca_ops, ca);
 	}
 	rcu_read_unlock();
 }
-- 
2.53.0

