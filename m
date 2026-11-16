Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794866933;
	b=VUsKr1+p6/Dmy/PPXUowfJRd4/deR4qgpVPUYnnrwUCKoTowaY7yFlAMoYiOA2iH7i0n
	 /X3l0oPs7ejOgsyUMI61+eRRIpI0kAKeEVGIdrY4Sn4lBBKbO8cmgVgauO2+1ZB0+pTBq
	 vmgurGoe53nfBLyihDnPmixTYKNky2Xq42Pm9BDkdD9lIcksJhH4k1kPHm1vI62SqN2zo
	 1l2L7QT0RakRHdRfaqy6lYDya1jXWgwhUWPay9r8vkvQDwe3K07HRSMmCbmbeKs9s1Yqg
	 h8kIsPXvYqbeC3RELFpTeg43I9luRiP8gInD8OB4ozA6fywTIKMY0tp7CDuMqCartiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794866933;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=fASJVZS6eae9LxRGOU8UXTUuLY6ysPWMoGJyRiEOZic=;
	b=NX1VddIGftNBF4CoDYo5Eusiq2XPmgHkeGjQPjHJZL/2RBYgbbtD18HPOBGdfZduUoRx
	 w55zOrZiJFU0Tb70w67i4s1nKMrbMxfo1aqrqTnUxMvMlOAKKRJe4YodGT5BlMQj+zaSy
	 wBICqG1FSjxyjIq+XjLHfbY33r6WFkGAfed5FUWlBhu4lyaouQ5+K8yyUsR3RsrRTageb
	 Kvy9CO5zIHXYrmdCvhCeMK7tYtovzAKitdtP7qu5GE7IVfaBXzW9c3gcQaQ4MR2H00QMH
	 nox8L5TOnzvH8DQR4QkZ5PShOjWswzxdNo1tzbq/prPGZ7FBV1JFE5wdUB+g9EaiVew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CdHzTetm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACB660A2611;
	Mon, 16 Nov 2026 22:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CdHzTetm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BCD61F000C5;
	Mon, 16 Nov 2026 22:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794866932;
	bh=fASJVZS6eae9LxRGOU8UXTUuLY6ysPWMoGJyRiEOZic=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=CdHzTetmXjvIW8qs4EVDVmVG1L1/YPkaKGG0pMK9+A71bd7ABaBGMD/70Kh1ZgcjF
	 0oyAFVHZoftAdWEZ4Y0SXyc732qSDx8TGxst2IYoK6yg5iGMth5G/E914nod2dL6U9
	 zM1HrXHnJ6dZktsvX68n9sTNlcLv9Q5ttOYVMTpiVkhjqXPc/zzbX092JSCl5BtlIS
	 CNOMeWAJBvRPNzpN5q5q5CU3Bd7QBTcMvHZnEGwzFnIhu9ve2zfwVhmM190kcU7NGL
	 /kuV78xrpGJOGvExGOFAPkCriPumEaQX2VSL7Ev9zeAYvxj4bGMWdYO9qV8o9lPkjg
	 riHAfybjO8HdA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 16 Nov 2026 23:06:09 +0100
Subject: [PATCH net 2/7] mptcp: push pending data after a sendmsg copy
 fault
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
Message-Id: <20261116-net-mptcp-misc-fixes-7-4-rc4-v1-2-bf7656de653e@kernel.org>
References: <20261116-net-mptcp-misc-fixes-7-4-rc4-v1-0-bf7656de653e@kernel.org>
In-Reply-To: <20261116-net-mptcp-misc-fixes-7-4-rc4-v1-0-bf7656de653e@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>, 
 Dmytro Shytyi <dmytro@shytyi.net>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Quanye Yang <quanyeyang@proton.me>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1670; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=306+4uW4TpE7s0K8Pmzi6N99z+xxvTfHEkxIyFliHBs=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJ+1z3TEZUzmZ025YbSqe9leQcnZbQ0iB5U2rnzSae44
 czvagHRHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABO5V8LIsKuF/adz9akHs4sl
 8y6lhj+Zrlp/Z4rF+ys1H/J37phq4MfI0Nx09Lk+d/b094a36usF9rmlsftN2Nz3Z2fE7e3XdD0
 3sQAA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Quanye Yang <quanyeyang@proton.me>

mptcp_sendmsg() copies into the msk write queue first, then
__mptcp_push_pending() on the success path. tcp_sendmsg_locked()
does the opposite: its do_error path jumps to out, and out
calls tcp_push() when copied > 0.

A later iovec fault (copy_from_iter / -EFAULT) after a successful
iteration therefore returns the partial byte count but leaves the
already-queued dfrag on rtx_queue. No subflow packet is sent, no
retransmission timer is armed, and DATA_FIN stays blocked on
first_pending.

Push in do_error when copied is already non-zero. Do not move
the push to out: copied is a size_t, and sk_stream_error()
stores a negative errno there.

The issue was spot by Sashiko, but easy to reproduce with Packetdrill:

  writev(4, [{..., 32728}, {NULL, 4096}], 2) = 32728

Fixes: 69800e516e96 ("mptcp: propagate fastclose error")
Cc: stable@vger.kernel.org
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/640
Signed-off-by: Quanye Yang <quanyeyang@proton.me>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 8968db58083e..b67096ee131b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2130,8 +2130,10 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	return copied;
 
 do_error:
-	if (copied)
+	if (copied) {
+		__mptcp_push_pending(sk, msg->msg_flags);
 		goto out;
+	}
 
 	copied = sk_stream_error(sk, msg->msg_flags, ret);
 	goto out;

-- 
2.55.0

