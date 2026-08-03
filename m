Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45395411FA3;
	Mon,  3 Aug 2026 16:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785773841; cv=none; b=m/mTwQVvc87kGAZa+vl+j1q+mEBu4/ub1StOoyPVBRcxUXSsDUFlf3d44stcPjmVPDm2fgqAX7sXqGo6tnbzJ+vZ13p+iwZPQtXPNZr5cUyWwPF9KvTmPoODMtZ3ggi22iH8ngDQEcGXnojjY5HTiBdlavNys6bSXq3zyiEKWaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785773841; c=relaxed/simple;
	bh=2LCtQYaFHMYShjE0L774cau909DKU6IxvzHD3daSzt8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BjeVjHgNKbQuGIvYls2TrHLXbkMdjNaawEmO9vxyrAm7T03dSu+Fn5JfQiCv2m/QNKqheA73e5pQJxFiWXJjQa9RBTT4pvRSk80P41nkXKC7UwMoypYsyjfvFJ7mo5R2/Nv2e0h6FjkkgggG/fSv+UjOHFtmQYBaXAk1rEoDlAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZXb5lbk3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZXb5lbk3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC3F31F000E9;
	Mon,  3 Aug 2026 16:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785773839;
	bh=CHz7hPGcuGQaXXaAvcxIgvtwBW6pE1qWtUMNAIp/Hpw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ZXb5lbk3U2Cm5cd/gEH44ystsRNdr1zre2oUmXbG8QEnqE77841Z857R3YWC3pDg7
	 B0tAEJeDTt5/7fBYcPRUdixNKbpkdYDPURnHy4di3jGnJFEUKn76O9+7TMWW4HEuZb
	 CIdAjNFxYNcRfshGef/LJhbDJYjGABYPxxyNYwRZ46hkUd6mmX0NumNP+ao8AfP1zB
	 m22e0F1SYV/dNPL9HBtAZjJSs/h82zlSJqvsNxs7iIEpZ+ivHNBUKxt38Q0EGPAyCr
	 LIyGuSxC04oEveYZQYSuGPLe9JWR9NWGvtzhc0DitPGwlvwuJRApcFoXHy3U+8AzCi
	 RmVVELdv/zbJw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 03 Aug 2026 18:16:40 +0200
Subject: [PATCH net v2 8/8] mptcp: reclaim forward-allocated memory on RX
 path errors
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-net-mptcp-misc-fixes-7-2-rc6-v2-8-b8f496d71664@kernel.org>
References: <20260803-net-mptcp-misc-fixes-7-2-rc6-v2-0-b8f496d71664@kernel.org>
In-Reply-To: <20260803-net-mptcp-misc-fixes-7-2-rc6-v2-0-b8f496d71664@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1341; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=13ycqCYB6Icqk3NK7EG0GaWaP44YW7kNbjVu5JUlTgc=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIK9n2RaFxZbX1qsdwdSfa7ps8W371q1Kye9mfeCt+mS
 1+299cs7yhlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZiI1WZGhm7LDVtfKlxxmz6x
 9lJHaMlmfjXmK4s5LMvtero0TnH/cGb4X7v3tuWJ640GO56uZIqtPfd0cvjh3ws3bpE/oraoYfb
 0r9wA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

After commit 9db5b3cec4ec ("mptcp: borrow forward memory from subflow"),
errors in the receive path prior to queueing skbs into the receive
queue do not trigger forward-allocated memory reclaiming.

Prevent forward memory from growing unboundedly in pathological drop
scenarios by explicitly reclaiming memory when skbs are dropped.

Fixes: 9db5b3cec4ec ("mptcp: borrow forward memory from subflow")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: Start comment on the same line as the opening /*, like in most
    places in the code. (Clashiko)
---
 net/mptcp/protocol.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ca644ec53eed..7c8180d8d5ef 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -149,6 +149,12 @@ struct sock *__mptcp_nmpc_sk(struct mptcp_sock *msk)
 
 static void mptcp_drop(struct sock *sk, struct sk_buff *skb)
 {
+	/* The skb forward memory was already transferred to sk by
+	 * mptcp_borrow_fwdmem(), even before setting the destructor.
+	 */
+	if (!skb->destructor)
+		sk_mem_reclaim(sk);
+
 	sk_drops_skbadd(sk, skb);
 	__kfree_skb(skb);
 }

-- 
2.53.0

