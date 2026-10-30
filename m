Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793397839;
	b=2EO6Vq8CM0XAJeNg/H9ty7qbvfau2P01jzaCX68sMwCsMxi1BiqkPaQk5R7cvBzOM+4X
	 EoF+QIjHOdW3nitOvZerQ4LB+rp1TYJZ2vd8JTvCd+cmjdr30OYBPDqQeOjkoA9izfCvu
	 cvta1O5CYe9hoOgjeYUjWHREHoDWeFBvlkeKXzmbt7y9uMA64ZD8KJhW4PXgOas9U7dPm
	 BtyttocfagnVQ+jl3SG1CuhH+2jngbzmrIeBnfKsjYa/lZQJcSQ4VK/aGFMIxcGT4NzVC
	 R781A73MKa7inrZxg3SM6MrQX6Al6ez8bDxp2DMwW86UWLsrnAzZCLpWNJ7llz8x40A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793397839;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=PuVchuw0uEOKu1VDlIzRfKfIbdb/XBgPSE1fFCX+3tI=;
	b=Y6zQmBoT+6NuSuachhT4vUl5+qOILv8LKI0QWkf/rkpXwx5OmRLZt6Mq+XlTh6FsZcQo
	 AE86hic922pw33rSGDuBAjI9JDliuD+O1dcFMkhcgtTcaT+b0lLQvuww40cyFU5yF+fDq
	 pcPG+FkW0LvfCQO4LFr6ks2sIHRiWNmBWxS5vWyQBlbrJ17RmDYCGfWPwUuFiQQh0X3rS
	 JKCmi8DSWfb+hmFSWOTY5COIU+8D91xfS38+JWyhHwco7qDURbxdGfB0Mu2eo3d8dFcL6
	 dCzlbTf/gqY8wFN+o6GEU3xvGm5CIjJIXzXEDZapPyH8PxDQyGh1zivWW4zMIEpjulA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gMlW0voA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF55606A31A;
	Fri, 30 Oct 2026 22:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gMlW0voA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C50E1F000C1;
	Fri, 30 Oct 2026 22:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793397838;
	bh=PuVchuw0uEOKu1VDlIzRfKfIbdb/XBgPSE1fFCX+3tI=;
	h=From:Date:Subject:To:Cc;
	b=gMlW0voA1tDaLTuPhNCXCgpJC9MP/2e7x+L/c4CA4gtumn1g+3sYzN4/8e4MSzgbS
	 kNv3iLXq/Er8EYQ353kpCU9HYQiEy7kCEQmDbmGdwu4ZkfoG3t/73Y0K3Q8AH2F4dv
	 Hvpzj/c0frYxxhlov0RzOnplWYWVdi8tvTKuu98kHecO1z9OK5u91D+0sOQu+kGEAu
	 8mse6zezo6mPIcOUok19Q0hWOeb7JWaCZdUtKKi8vvplyfE3kMP1L6p8+6+qmHHf2H
	 YYzCU5Jg/CXkioB9xEbPyR41Fg+tQi0EIvDb/WNFi5//a2AEKgE8NVMZA8HuLRdsJe
	 o4EHZAOuPmv6A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 30 Oct 2026 23:03:51 +0100
Subject: [PATCH net v4] mptcp: do not use Fast Open on MP_JOIN subflows
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
Message-Id: <20261030-mptcp-tfo-mpj-v4-1-e6eff2027342@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/z2OwQ6CMBBEf4Xs2ZIttaCe/A/jActWlkhL2mpUw
 r9bNPE2M5l5mRkiBaYIh2KGQA+O7F02200Bpm/dlQR32UOFVS1RoRinZCaRrM9qEFpb6oySu70
 1kDdTIMvPL+8EjhKcf2G8XwYyaSWtNRv8KFIfqP3DcV8h1rLRulS60VgrIcWLb+ze64/j6L2Lv
 U9ly7AsH+UAfBO4AAAA
X-Change-ID: 20261030-mptcp-tfo-mpj-55fedc3189fc
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Christoph Paasch <cpaasch@openai.com>, 
 Chris Mason <mason@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Yilin Zhang <yilinzhang@moonshot.ai>, 
 stable@vger.kernel.org, Kimi Security Team <bug-report@moonshot.ai>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2961; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=HZWXbnMpkuoJXWdgZWlVEwG84W1F//W89aqlg7o6T7Q=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLKeinhx2HE2Fu2dYn1b1XdVYOeGuD1VjjWpXU+8Nba4L
 ODbsluno5SFQYyLQVZMkUW6LTJ/5vMq3hIvPwuYOaxMIEMYuDgFYCJxyowM2zii5/jps4fuVb74
 1c7KMWzr45V+imaBJe3Crye+b3A9yPA/fZXEnnwm1bSDi/OrE6w3HCnwjz3ZuP7H+a/9Tpre16Y
 yAQA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Yilin Zhang <yilinzhang@moonshot.ai>

tcp_fastopen_create_child() hands the SYN packet itself to
subflow_syn_recv_sock(). For an MP_JOIN request this takes the
fatal fallback: the cloned child is destroyed and handed back with
drop_req flagged, but tcp_fastopen_create_child() does not check
the flag and queues it, so accept() can expose the freed child.

MP_JOIN cannot use Fast Open: data on a subflow requires the
completed HMAC exchange (RFC 8684, sec. 3.2). Refuse it (only the
TFO path passes a SYN skb here) and let tcp_conn_request() fall
back to the regular MP_JOIN handshake; also strip the Fast Open
cookie from MP_JOIN SYN/ACKs.

Fixes: 90bf45134d55 ("mptcp: add new sock flag to deal with join subflows")
Cc: stable@vger.kernel.org
Reported-by: Kimi Security Team <bug-report@moonshot.ai>
Suggested-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Yilin Zhang <yilinzhang@moonshot.ai>
[ Moving code to avoid clearing TS and consolidating checks. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Note: I'm taking over this series because the v3 got lost a bit, the v4
      only contains minor modifications, no need to delay this fix any
      longer.
v4:
- Disable TFO without clearing tstamp_ok.
- Moving SYN check inside the existing MPJ section.
- Check for SYN only. (Paolo)
v3:
- https://lore.kernel.org/20260920061904.3575780-1-yilinzhang@moonshot.ai
v2:
- https://lore.kernel.org/20260903094010.4066892-1-yilinzhang@moonshot.ai
v1:
- https://lore.kernel.org/20260902121247.3248539-1-yilinzhang@moonshot.ai
---
 net/mptcp/subflow.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 78e886b20258..00677fb3efcd 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -379,6 +379,10 @@ static void subflow_prep_synack(const struct sock *sk, struct request_sock *req,
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 	struct inet_request_sock *ireq = inet_rsk(req);
 
+	/* MP_JOIN cannot use TFO, do not send a cookie in the SYN/ACK */
+	if (foc && mptcp_subflow_rsk(req)->mp_join)
+		foc->len = -1;
+
 	/* clear tstamp_ok, as needed depending on cookie */
 	if (foc && foc->len > -1)
 		ireq->tstamp_ok = 0;
@@ -887,6 +891,13 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 			fallback = true;
 
 	} else if (subflow_req->mp_join) {
+		/* a SYN skb here comes from TFO, which MP_JOIN cannot use: just
+		 * fall back to the regular path.
+		 */
+		if ((TCP_SKB_CB(skb)->tcp_flags & (TCPHDR_SYN | TCPHDR_ACK)) ==
+		    TCPHDR_SYN)
+			return NULL;
+
 		mptcp_get_options(skb, &mp_opt);
 		if (!(mp_opt.suboptions & OPTION_MPTCP_MPJ_ACK))
 			fallback = true;

---
base-commit: d8a4f4c59da52b7c31ae337243b8473a19a3f819
change-id: 20261030-mptcp-tfo-mpj-55fedc3189fc

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>

