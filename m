Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF0421257E;
	Mon,  1 Jun 2026 03:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780283440; cv=none; b=Wtpn0v31YQtvo/iaBpUofFjksTSdphciPsQcFxiwdt1sFus7bUidapXl7w2aJiAlgrmcG/3180OJKSDQKh4/pfH2yvS6kiPziTELppBdnFHHWalxoPTBAUAp9MyBGBXp1TIzZnCvCBKlXL7w2rJBpbqCTrUDCRekqHUWCOb7tdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780283440; c=relaxed/simple;
	bh=89uQ3n/0Qw3xj0GP3YUOWBjrjD9h2PL6dSpP8OMpD5k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y+CH4VaYZDm2UgRlY4/1zHp8ZsOVpiNhuBcrtvXKNe/lB5+0m1fWPSM41h5KNVZ62pQPXQg54DqMl+3h/B1gZLit+aznQx0/YPiDJewZt2YZr1SlbA3wnQEC/0FfNsSvAhM5rcy8YHqDcFXBkauDmr9naFCR9IW2WfvZDvdDpBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kD7xk7zk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kD7xk7zk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D3251F00893;
	Mon,  1 Jun 2026 03:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780283439;
	bh=aaWaJPX46vtcjlCbR7WSB0JgKZ/Rcr2pe1adTWLv85w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=kD7xk7zkK4B5B4Wxj3E92b7dALSjrYMBI2va+o5Sa7KOR7Sj2WNXPpTp/KeNLrZqE
	 xSFnhKVyzcPKDNP/hScZ3pLoGkAtYS7xPbFtin3sCTA/6HwtkGXVO0ODhDp2g1NbxU
	 GFgCSX1AJg/daSKvIjNrOevBjG+Z5OnKYf7BtXoHm1A7/RZqcJGBA06CYNTryDhrxm
	 uebi488Kv350Lb54fGr3c6PHERpJTTLb8sAzdAfJLXZhKjLKSputhL4aatkTj0/V71
	 YTc3Rl4y+dsJUDR5wocyLpRtBqwvBNqnrvNEiTEuraSuXmdKpF386Gv3ZLNwD8KD1S
	 g116o9vwKpdNA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 01 Jun 2026 13:09:58 +1000
Subject: [PATCH net 02/10] mptcp: fix retransmission loop when csum is
 enabled
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-net-mptcp-misc-fixes-7-1-rc7-v1-2-a5ae7791754b@kernel.org>
References: <20260601-net-mptcp-misc-fixes-7-1-rc7-v1-0-a5ae7791754b@kernel.org>
In-Reply-To: <20260601-net-mptcp-misc-fixes-7-1-rc7-v1-0-a5ae7791754b@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1206; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=vBnH00lmV7eZlsPI2IZN0MrG2/KQqq2hWo2tFLKydHs=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqHPgeq9Ul1F3bQYDyghgYlUe+pEc54i9mnKG8+
 TW8ES49UwuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCahz4HgAKCRD2t4JPQmmg
 c2ZsEADSHXik29A48z3GfgJNiN/Yw+LyzUy7hwbNhr8UFSHRLQJWk+1xFMmnYV6Can+IQFc5IZ6
 65Wk0mJPe8Juk+GBwuz2ryUhRYK8rEZrFoQbD04OiAES7DeQmTydikgol5JO/WnNzatFug2qHj/
 CDHGixxEiE+M0a04skLtZ7Hjr3af+qSHctkE7ppQkznA3/m0u1fMO1mj+jxaikNFn/Qb0V2jnTT
 hBqWhn4MsCprOB2SdGuTmMGoFpJM3HR952R0hDyKqq27nKWI/feTDvILdY5Mkr/ufO9l63M6eCY
 yQpu+NRX9eBW6K7nT6OUeEw5FKeundsSFjf39fJu8GIt0QTAeNOJnkj6eAjC07cl0rXfSXeH/jR
 nTRFnzGE8XyHo41nB0bN7+fnYelT6WLJotITODRm1KLNFu/fRdfePYFhK/CFVcJgUgpCSgfczmp
 XlEu50layeiC5lBgNDCRYJ3RxXV4xEtpV9dBsJz6oHk07Vyf5XnDkqNNLMKWfYgVBBcO5B7h5ZY
 tLDBPHwd/aPupdneUjH2W56nszjrFrLX2vnq3/W8vG6w7rVHBx8OUESM66KQXEvLVjE4yvppILR
 Lkf2mzLVpS/vEQOrcuS0ETXqJMh/ocVZlXSfD3Rq4fIDlJa86OTHpHn8L+X/r1OR0WKXtgnGiGT
 Awj+9dnKjuRq9cQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

Sashiko noted that retransmission with csum enabled can actually
transmit new data, but currently the relevant code does not update
accordingly snd_nxt.

The may cause incoming ack drop and an endless retransmission loop.

Address the issue incrementing snd_nxt as needed.

Fixes: 4e14867d5e91 ("mptcp: tune re-injections for csum enabled mode")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 5a20ab2789ae..7fac5fac2097 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2869,6 +2869,10 @@ static void __mptcp_retrans(struct sock *sk)
 	msk->bytes_retrans += len;
 	dfrag->already_sent = max(dfrag->already_sent, len);
 
+	/* With csum enabled retransmission can send new data. */
+	if (after64(dfrag->already_sent + dfrag->data_seq, msk->snd_nxt))
+		WRITE_ONCE(msk->snd_nxt, dfrag->already_sent + dfrag->data_seq);
+
 reset_timer:
 	mptcp_check_and_set_pending(sk);
 

-- 
2.53.0

