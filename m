Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1BB38655E
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 17:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788976018; cv=none; b=H52C6WBD6FQmcFlZJdZHUkDAVeEfvRkiL6f71kQKMevUz0opTd43dK9yeXh3IVW2VKrC5wC7adJ35SEJT3bFR61CVHscjJAJfrabnW/CONornATlX0NXB3p8FYRlR3aV79Dy2p7RPFtNxlJ9fpwCBYqBtrIIka3RBaGhnzJypfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788976018; c=relaxed/simple;
	bh=JqJjT9JM/R2nc7zHsMaNX/u3ASP2BldtRs+EDCUGv4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GSuYSgxtxbWZofbyEJxaVxUHTDDWrhadhysT3IuecjK5jgxEZjWYsHKIg/LlguWioQzYrMCiIXcvcMjDJffof002i0NDvdQNXV/pf3tS/jmZTwHVHA0H27ifwTHsYmGA/U/HxtjeGDbfFPlO9ugH6Z7PGSR33tUpmc6jrZvhJvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WAhxiSZj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WAhxiSZj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD2491F000FF;
	Wed,  9 Sep 2026 17:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788976017;
	bh=KUlcujUfGinilSDqi/FaBFZMeAjsXZrPKNdkBInPqtk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WAhxiSZjkLm33JYPgv2y3LM8vYPSJ6r36EeWUnyO20VMwOjAHay9FdyyLe9WXuVQt
	 +j2fTgNUD3t1OTCvMpZlIR//TIketx/Idr4ryky21jErVyThRxJnLbFjTllBr3lK4t
	 T5S5bpSgUtcsLMolXCgRjYIfPZQKit5Q03wOT1zuCw7HJmqPxMkdhvdkGcAqRuexOz
	 xZb0lZ//CTULv9uV8tjaGLChSOrdrJh7Um/AmqrqPzcziER8b1btMRHT8YkOJZsntN
	 wHJxa6A6y6qIeOdAqkqCjNAF9mLuj9IvKe2jVH/em42a4/Spdh09QVSnwv00olQ5mv
	 2VqONSCjK7KNg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: James Chapman <jchapman@katalix.com>,
	Tom Parkin <tparkin@katalix.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/6] l2tp: don't set sk_user_data in tunnel socket
Date: Wed,  9 Sep 2026 13:46:50 -0400
Message-ID: <20260909174655.3345526-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090341-survival-shrill-fee9@gregkh>
References: <2026090341-survival-shrill-fee9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: James Chapman <jchapman@katalix.com>

[ Upstream commit 4a4cd70369f162f819b7855b0eabcb2db21f01f4 ]

l2tp no longer uses the tunnel socket's sk_user_data so drop the code
which sets it.

In l2tp_validate_socket use l2tp_sk_to_tunnel to check whether a given
socket is already attached to an l2tp tunnel since we can no longer
use non-null sk_user_data to indicate this.

Signed-off-by: James Chapman <jchapman@katalix.com>
Signed-off-by: Tom Parkin <tparkin@katalix.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: af20e269f745 ("net: l2tp: do not propagate multicast notification errors")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/l2tp/l2tp_core.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 3c701795fa100..0f48d7fece498 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -1166,7 +1166,6 @@ static void l2tp_tunnel_destruct(struct sock *sk)
 	/* Remove hooks into tunnel socket */
 	write_lock_bh(&sk->sk_callback_lock);
 	sk->sk_destruct = tunnel->old_sk_destruct;
-	sk->sk_user_data = NULL;
 	write_unlock_bh(&sk->sk_callback_lock);
 
 	/* Call the original destructor */
@@ -1448,6 +1447,8 @@ EXPORT_SYMBOL_GPL(l2tp_tunnel_create);
 static int l2tp_validate_socket(const struct sock *sk, const struct net *net,
 				enum l2tp_encap_type encap)
 {
+	struct l2tp_tunnel *tunnel;
+
 	if (!net_eq(sock_net(sk), net))
 		return -EINVAL;
 
@@ -1461,8 +1462,11 @@ static int l2tp_validate_socket(const struct sock *sk, const struct net *net,
 	    (encap == L2TP_ENCAPTYPE_IP && sk->sk_protocol != IPPROTO_L2TP))
 		return -EPROTONOSUPPORT;
 
-	if (sk->sk_user_data)
+	tunnel = l2tp_sk_to_tunnel(sk);
+	if (tunnel) {
+		l2tp_tunnel_dec_refcount(tunnel);
 		return -EBUSY;
+	}
 
 	return 0;
 }
@@ -1501,12 +1505,10 @@ int l2tp_tunnel_register(struct l2tp_tunnel *tunnel, struct net *net,
 	ret = l2tp_validate_socket(sk, net, tunnel->encap);
 	if (ret < 0)
 		goto err_inval_sock;
-	rcu_assign_sk_user_data(sk, tunnel);
 	write_unlock_bh(&sk->sk_callback_lock);
 
 	if (tunnel->encap == L2TP_ENCAPTYPE_UDP) {
 		struct udp_tunnel_sock_cfg udp_cfg = {
-			.sk_user_data = tunnel,
 			.encap_type = UDP_ENCAP_L2TPINUDP,
 			.encap_rcv = l2tp_udp_encap_recv,
 			.encap_destroy = l2tp_udp_encap_destroy,
-- 
2.53.0

