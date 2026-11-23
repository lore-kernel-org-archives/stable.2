Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795440349;
	b=ABQFW3kPN1nOOsbxH5UtTPksxcozHljBo5D8PMGgcLnRil3NdC7e7S2fGaakXElHgReq
	 KHR3JaHPGEACiNy03fQzSn0A4WEuzbOtrlOGpG1ZH9kInzz1YINxCCfCpP4W3ljdIyI42
	 UoJ26JjY9HJx3cLx9On0XOcMhCzI7CFQv1CJgRorqHRfWFjTm9pWX4ZwgIqshZ6A+Unhg
	 Rd3ivghm9xB05G2V85axkLs8dxDwg9QhqnaCPufKODN5JFQbh32niaRXGWeprwMDvEQdI
	 gJZ8qpJW+s1cFoCCGoPE3WegOeNELDHFQoTRpJxFbJb+I6Bcq1oFe3oSEX+M13XZytw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795440349;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=IrbQ8i8aTZJwqEFTPYxIAtIRVnnEMSD6z8Zy35LupKc=;
	b=osgD6juVLsgqh5Vp5Smf79cKjMiILKyG9z/mTFM23hxMOsNaGVot8lrambYftm3lmqqV
	 smjnETNMSnP+LG1pLy/e/lXGlMmMbx86fZ77GFIbxdu/9X1ncqp7LLNa38XGljIAeneGm
	 qwKgdsyZGt2fl5aPE21BPoJNwy3vzLk0OW/r0+mMY7aLvj4KbV+SuGFGGXZRuwlMaGHdI
	 xL6X1V58ylwcNTH221jMruG+eO4lGls64RklmxAIMjNKsMWmk1alQJSXQd9e2DkYhaakj
	 uSSV+BibBbngki41dcqZSCIRkv54WRKzDlFasDaogfdgSGMcXRuhrqb3lno5Oo63Q7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DTcQleDY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED6260A263E;
	Mon, 23 Nov 2026 13:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DTcQleDY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3305F1F00ADE;
	Mon, 23 Nov 2026 13:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795440348;
	bh=IrbQ8i8aTZJwqEFTPYxIAtIRVnnEMSD6z8Zy35LupKc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=DTcQleDYln9ObBCw3rHUS1Wq2J948b5I00ifgB0Q79jUfmuhT2/+T81TYUt7qS1P6
	 kGyn5p6hG6znjV3QvdG169TAjcghuzReZHRG3wbmPecWvoJYD8qAhq222dqQoqgjzl
	 2GiRbgGDTMpExkf005u1KYW93GxJRqDDNNuG+zJxt/oFBEnBqHl0wMtUQbqp988L2T
	 kI7UqK0ZnIAzkn98azH835LoHNsdoi/fexTYcMLJwQY8aos7XYrU7S8XqAUCU2BvWG
	 nQY+CCrAlrWjYw/ttbdl4bHwli04g6ZhY9a134n1gNoQ3sTkQe3D6qGUNBZxeSitnE
	 9X1KAhcGQqGBA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 23 Nov 2026 14:24:55 +0100
Subject: [PATCH net 07/10] net: add __sk_net_refcnt_upgrade() with a GFP
 mask
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
Message-Id: <20261123-net-mptcp-misc-fixes-7-4-rc5-v1-7-278042217e8d@kernel.org>
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
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2491; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=26GkYMliCyKie8HF17szUVNO9CI1DDDK2SXQg2Kmuhs=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJZ7Pa+k59y9beyz88XJwxu3l92WJ1nOfOsxnkB+96L7
 niu8kWxvqOUhUGMi0FWTJFFui0yf+bzKt4SLz8LmDmsTCBDGLg4BWAiWxkY/srPNDWrn/Nxf3Fh
 5bFnjSy/JvRNNDjjO+/gpL/lyW+u3Q5nZPguN8dmPp/Vniwe37JJX9okpfqdNLOkbnbcCz31d53
 GPDYA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

sk_net_refcnt_upgrade() gives a kernel socket a reference on its network
namespace, with a netns tracker allocated with GFP_KERNEL. The next
commit needs to do that for a socket created in atomic context: the
child of a kernel MPTCP listener, created when an MP_JOIN request is
accepted.

Add __sk_net_refcnt_upgrade(), taking the GFP mask to use, and make
sk_net_refcnt_upgrade() call it with GFP_KERNEL: no functional change
for the existing callers.

The 'Fixes' tag here below is the same as the one from the next commit:
this patch is needed to fix the issue introduced by this commit ID.

Fixes: 1729cf186d8a ("mptcp: create the listening socket for new port")
Cc: stable@vger.kernel.org
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Cc: Neal Cardwell <ncardwell@google.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/sock.h | 1 +
 net/core/sock.c    | 9 +++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 3144efad8c36..de23cdc89477 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1843,6 +1843,7 @@ static inline bool sock_allow_reclassification(const struct sock *csk)
 struct sock *sk_alloc(struct net *net, int family, gfp_t priority,
 		      struct proto *prot, int kern);
 void sk_free(struct sock *sk);
+void __sk_net_refcnt_upgrade(struct sock *sk, gfp_t gfp);
 void sk_net_refcnt_upgrade(struct sock *sk);
 void sk_destruct(struct sock *sk);
 struct sock *sk_clone(const struct sock *sk, const gfp_t priority, bool lock);
diff --git a/net/core/sock.c b/net/core/sock.c
index 5675053625e6..5ed63d2d8976 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2422,7 +2422,7 @@ static void __sk_destruct(struct rcu_head *head)
 	sk_prot_free(sk->sk_prot_creator, sk);
 }
 
-void sk_net_refcnt_upgrade(struct sock *sk)
+void __sk_net_refcnt_upgrade(struct sock *sk, gfp_t gfp)
 {
 	struct net *net = sock_net(sk);
 
@@ -2430,9 +2430,14 @@ void sk_net_refcnt_upgrade(struct sock *sk)
 	__netns_tracker_free(net, &sk->ns_tracker, false);
 	net_passive_dec(net);
 	sk->sk_net_refcnt = 1;
-	get_net_track(net, &sk->ns_tracker, GFP_KERNEL);
+	get_net_track(net, &sk->ns_tracker, gfp);
 	sock_inuse_add(net, 1);
 }
+
+void sk_net_refcnt_upgrade(struct sock *sk)
+{
+	__sk_net_refcnt_upgrade(sk, GFP_KERNEL);
+}
 EXPORT_SYMBOL_GPL(sk_net_refcnt_upgrade);
 
 void sk_destruct(struct sock *sk)

-- 
2.55.0

