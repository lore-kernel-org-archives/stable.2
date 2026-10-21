Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792605761;
	b=1IecARK7K025BKCZwAXY4aobjgt9Lwn8P+glzL+TOaEIo3toN0EdF4nTSa2LJb52D9TJ
	 6eiKPj6uqfUqP8dbZOTCMiq/zb5vduUNx3UDLyFDsoz3jXo2TXDV0G+7q00YXWyLOMVDZ
	 RXuU4hiiPtqgGsnSrbVAQ+P1IXHUidi6N77tS45y/+InrQ02H4kgsLU4VLI8GEosfmgWP
	 LCFimn4rwAYN8bFP9/KuOv58ZkvIouhzKFiq77gXR6FLrVgQPOcQZ0GLYJDPbfdftTnI3
	 lIAcYPGrYAtMY7kS7yLMp4VqZOYOwLmtuJ/LtT+DahoeUVCHf6bLhx0NP0yfOR1xtZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792605761;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=e2alJIXSYK3LZK91rZBSjOS8qrL9zNkTpWnd8/jXosg=;
	b=hZMYx+cpqsqCK6Yx6IiEn3whqTMSeC5e2aCntGzOuzIraMJ3aSTtEV5kl+DcO6sDFEug
	 qvN0rHDWW+gIxRao7QQwgqJS+2HR+qKs3acURO3d+ZR7kncbNGorxgNw7rbKYklKbFfKw
	 qzzWH3jO+dbNVwSBemcAeky4vI3dQAquf98I/Ay0ldUWCTaBFC4Pn89MQHn2vDUlXREHh
	 U+ZPPlTSw931R0LOSx7kNen5At7El3WebxcU/gIJh4xo1Ka21qCJ9cHWRo8k0a+DNic4J
	 7SCbN0Bv+zkkYepE3WEolT2As1JcYxyGXJgDmUZrL7v5hZEtVruGBmpAHXSgdKOm48Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="LO64XtB/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F78606A319
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 18:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=LO64XtB/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BCF31F000C1;
	Wed, 21 Oct 2026 18:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792605761;
	bh=e2alJIXSYK3LZK91rZBSjOS8qrL9zNkTpWnd8/jXosg=;
	h=Subject:To:Cc:From:Date;
	b=LO64XtB/PC7twcKpszKEf7AUTfVdf369cBO6Q9HZmLIjg8guXdp4//Ush3L1pONli
	 zJhHth8Yc15DHgbXthSttXrynFIaemZpDE6JtnPNk3G6GuNFAWtiL0p3yL1m1j/G7b
	 5gIM36gzI8614FesA60ihBtJFjWAMTNxtOjoRSsw=
Subject: FAILED: patch "[PATCH] tcp: fix use-after-free in do_tcp_getsockopt(TCP_CONGESTION)" failed to apply to 5.15-stable tree
To: blbllhy@gmail.com,edumazet@google.com,jiayuan.chen@linux.dev,kuba@kernel.org,leitao@debian.org,matttbe@kernel.org,xmei5@asu.edu
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 21 Oct 2026 19:57:27 +0200
Message-ID: <2026102127-crept-debate-2807@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 5271b79b7ad68dcb222e893773f92bdabf7750f3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102127-crept-debate-2807@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5271b79b7ad68dcb222e893773f92bdabf7750f3 Mon Sep 17 00:00:00 2001
From: "Cen Zhang (Microsoft Security FORGE Labs)" <blbllhy@gmail.com>
Date: Thu, 27 Aug 2026 19:55:10 -0400
Subject: [PATCH] tcp: fix use-after-free in do_tcp_getsockopt(TCP_CONGESTION)

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

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 93d723d8c109..740999c9efff 100644
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
index e9f6c77e0631..8e83ef81fc18 100644
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
index 274e628e7cf8..99f68c2992d0 100644
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
index f3fa0b18eda0..0ddfd5af6e58 100644
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
index c5ffffee4349..d960e3de7d50 100644
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

