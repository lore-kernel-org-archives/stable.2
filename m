Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5179D39EF23;
	Tue, 28 Jul 2026 17:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785258755; cv=none; b=lrUA2+wWSFhWOSIOSKZDLoRlqCfsgh+OSM/cseqFiocPJbEFc1mZ0Sr8hBVgwJ+7ZpM7nQQ1lkW1qU+Baas2/Bn8WDcM3+D7XUFL73kGcrNoh0HuovyzWAz9cCS7lwCVUDAkD7E9FiadDm+bodH2tZ2i2QDhvgh/c5dHOhBiTD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785258755; c=relaxed/simple;
	bh=95laPrOyZSSO2MaKvtBXnM4BRisS7e05Qe6xBWMwGB4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ah+1ogJ0xlavJm1kmZNS8gfWfGBfh8iyTwyd3LCn6dXJXhxglw5v3Aw2F9R7UIjgBN8J2AU8MG8AAGTNnhIIl3DMse/wbHBlH9ksoUdsbTEvVnte88WEI0G3Y2j8gGK6IGRMkUnmXaeRl7Fd+FNjGa2oKC0qQ4KHGPxAHNDzUi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tl6x6V7U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tl6x6V7U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 447771F00A3E;
	Tue, 28 Jul 2026 17:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785258754;
	bh=u+AZSEUgWhE7D0opgqssDSdlP1ic8S4Y/lQMRdKfPpQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Tl6x6V7UlymHMlPBeGcqKgc5LuaccS90SYjsuDVR21vB9v3Cr1xlKcORHr/J2obSB
	 xsQBH8GopcsDsSmilveK04UfnviET3cN/0imp3c2lRgkdHtkvNThuQi1a7GpLT1M30
	 iWWSKnPbNg9Qz8R/inVIJ3JsiieIltDQf3hn4pOaXW9V9Be14F/kW8DKuSfaxCXWGv
	 10w13m4r6lIpbUtkKYziQDRNOfMQ4EQ2wPow9Fa3OA4/gebyKyi2XkngLXu2erl/Lc
	 muzfO+xFCi1NdNW3ILzDL9lLMY6A7IsomzdRRZWKKj1IPzsc/rnVCsj14B7R2kYcaC
	 H8y5sckhFRlgA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 28 Jul 2026 19:12:01 +0200
Subject: [PATCH net 5/5] mptcp: reclaim forward-allocated memory on RX path
 errors
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-net-mptcp-misc-fixes-7-2-rc6-v1-5-f7e2d229159d@kernel.org>
References: <20260728-net-mptcp-misc-fixes-7-2-rc6-v1-0-f7e2d229159d@kernel.org>
In-Reply-To: <20260728-net-mptcp-misc-fixes-7-2-rc6-v1-0-f7e2d229159d@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1239; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=9MruphuE0mDyM48vy8r+FyoIyzzsuXdFdAn+ZcRkOGE=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIyHr2/vyPl4MGgvJ7bgVX6h19ybnRJkMo6dWHt7f4dA
 V6fOL3TO0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACai3cPIcFgjriXW1muL9o9J
 Sznvdm9fPmfeJ4c/DE/te+rjV2e4rWFkuH+Xw+Hil4IjPzUrP15ve+HrHHC7cxXzSd9t+rNcfaY
 WMwAA
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
 net/mptcp/protocol.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ca644ec53eed..47eaf64a54ba 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -149,6 +149,13 @@ struct sock *__mptcp_nmpc_sk(struct mptcp_sock *msk)
 
 static void mptcp_drop(struct sock *sk, struct sk_buff *skb)
 {
+	/*
+	 * The skb forward memory was already transferred to sk by
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

