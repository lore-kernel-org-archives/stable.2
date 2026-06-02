Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17F03E3140;
	Tue,  2 Jun 2026 12:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780402501; cv=none; b=rR+5zWAevaLfLOjrRX5/c8rWXT2/gxxYzxBN2ImsbgaqR6glIOa+BdIlJI2U1j42hCCqmvUE7PSopJwwpzxbCGaXoLAwbfQiFQW0zX5XVvpB2rYNxH4vvvDbgF94/HTfo1t92hXHbj+CkMFXs3sJxGc/PCyK3T6yC2QTxAX2APw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780402501; c=relaxed/simple;
	bh=tY/a57/TVSvpgNnIoyCRPnJyQg+HO8WVORGfo0db7mU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RufPfu/syBCeKBICGEwneh/pFmp3V2J1GdgN2PQ1IZ7Bt+JviAtKrJlGDCFk+LNV8Yt93FvSDTJ+AKvKqaxw5OAkCML06MfiR92ICjwRzmQQoCSKtAQrnPL3QykHjBtGnKPBqzVXH7W/cgqK2wVNydvXCAn4X4OCFDGkZcwu6Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bN/t8e4G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bN/t8e4G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ADB11F00893;
	Tue,  2 Jun 2026 12:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780402500;
	bh=Xa5SkSOu7iCqTLmCDdQrrU6/PcTgQV+a6wr23yqLyL0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=bN/t8e4GPN1ixO5zKW32iqbICLD5oNiKI4n11SMzdbZl/l1OTsb4yIOwwcjyHE+yR
	 yWpVUssEaM+81IDHZdQrYVRQPMLVpq111khHEUnoetjycTr6FXFx+wETDYl+YkNqDT
	 U65eVn1W45mooL+cb0vcRIQFnAGleywrOAugEHrrWcRA4/QMy1oNZv+XskWapYQWlD
	 Y9KpZkc1OMFADY+RfXPkJH2JKYL9sDnHBUa3NXB71Ay2ixm68UENxTjstcln4vcfh4
	 VreoWKiSZmwv3ehgWbfKg+Ml4VrmCICxgao64lHY//Y31mhKkxMvtb3FKFUkjjK5aP
	 p8c0hErig5Aqw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 02 Jun 2026 22:14:11 +1000
Subject: [PATCH net v2 04/11] mptcp: allow subflow rcv wnd to shrink
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-net-mptcp-misc-fixes-7-1-rc7-v2-4-856831229976@kernel.org>
References: <20260602-net-mptcp-misc-fixes-7-1-rc7-v2-0-856831229976@kernel.org>
In-Reply-To: <20260602-net-mptcp-misc-fixes-7-1-rc7-v2-0-856831229976@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2014; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ZxRWHdtL3tuj75xtqktzYg7JOxPwuV8ew2GHxY1a/ao=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqHsksqYVJJrvGMZJqDZMaYcZK9Tvt0Ie3hjsoj
 pawnoIpFrOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCah7JLAAKCRD2t4JPQmmg
 c5UED/9Bb3D/tC8nQpL9Rux+nrE2lxJqGwswXeBu1LKr6fmyvBcqU5XbzzsxK3RuU1h1elGrsev
 i8mO0ZpL9eAt8fXcuUGUtiQFdJWAraqNH5lPODFlnV1xHfAkYb/oWjEJfgNu1EBb4Cx7Of0LKCu
 nIB4NT6OGvP/g944Yho9Iq3vHvcu12Z5t9R2RT81FRv2CchtENx/AWFynUV4rkYnWpLQ7G2eGm8
 CVeL1hxtvTq2RtRiWESQWYzfU7RConhIqeGcXE11fTg/DfdRjQuPQkff6imxEw1JKtz2kK4pin4
 Ct4xR4d/duM479b6XS1kALIMD0EGL6YEgADG5igzkl77n8dRpeffNaF/6OjvNUJSBKWZZFNBzP8
 pQpXXYf4xbWP/AKRLt/Z7Wo7pNnLUG0Vf1R9mjiDp3bdaStLAHAEp7AlEpdiYT/wU5IMvKZJQC0
 ZydOofi9NIya7kerpsrmjI4BpjYzKbED5VlpSZdahMVzBKUWiP4t4JyY+DeWEbor62KUWmBXXxC
 bxYiQJjPTg+pP6k8AG2m9Er7GW7D/IvqKpQG52gYxvssHPFP8D8BS28eKxJZeuulJJf6tQmW8p3
 SDlxRAGZcq076QwSKC3IGpuztUbUWVx8cdttgHxfhTH7yJEBw/WEygohBYOo7Pp8cm77FQUkBa9
 o8IKnRu7wGLrd6g==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

In MPTCP connection, the `window` field in the TCP header refers to the
MPTCP-level rcv_nxt and it's right edge should not move backward. Such
constraint is enforced at DSS option generation time.

At the same time, the TCP stack ensures independently that the TCP-level
rcv wnd right's edge does not move backward. That in turn causes artificial
inflating of the MPTCP rcv window when the incoming data is acked at the
TCP level and is OoO in the MPTCP sequence space (or lands in the backlog).

As a consequence, the incoming traffic can exceed the receiver rcvbuf size
even when the sender is not misbehaving.

Prevent such scenario forcibly allowing the TCP subflow to shrink the
TCP-level rcv wnd regardless of the current netns setting.

Fixes: f3589be0c420 ("mptcp: never shrink offered window")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 2d25f319f328..51ca334678b4 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -566,6 +566,7 @@ static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
+	struct tcp_sock *tp = tcp_sk(sk);
 	unsigned int dss_size = 0;
 	struct mptcp_ext *mpext;
 	unsigned int ack_size;
@@ -614,6 +615,12 @@ static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
 	if (dss_size == 0)
 		ack_size += TCPOLEN_MPTCP_DSS_BASE;
 
+	/* The caller is __tcp_transmit_skb(), and will compute the new rcv
+	 * wnd soon: ensure that the window can shrink.
+	 */
+	if (skb)
+		tp->rcv_wnd = tp->rcv_nxt - tp->rcv_wup;
+
 	dss_size += ack_size;
 
 	*size = ALIGN(dss_size, 4);

-- 
2.53.0

