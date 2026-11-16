Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794866941;
	b=K6kVO5PHTuF/7iIjNwlkeu9Sngp4kqbjND7gkPHp4WJKxiUeOPVLO2Uy+W42vxWMMGJ9
	 SMVZeD4KyDOXf+AYh13FxxzscZDoBj5T+ga6t14YsIRUTyYjTWImPdjqYuAJ4HBgiB2PY
	 9v1h/jrgvnU8pYk1Uj30bVivtK2uMnz0A9x6B8Kp2TUMazfEwtjuoAO7st7l9zc9hCqyz
	 woHPf5jsYoHFY7YRPVs6fS8kwOuTt2JVgfNItUHciWNQ/S7nhdXkOgL4VyqI+IaGG0Ccb
	 mQQ1lMKtHoFCC2Mu99pWsbAkpz+PeYt3KJSVFyiKcm9WJB3CbqLYbF0mb4wtetBOXHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794866941;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=XeFi5cCNjQ75ncJcr9kVqUiYUHdBVb+5baL45/OqCQM=;
	b=KejOOaa/s6nzTQZPsNMQ74X3UHLWMrnZkWrVJLtn0px5hKxL1O5KyJuQyILZMQhE6Gde
	 GTY8i6ar+0oQ9shrgnljok8QzAijEAwnCIsq/1Aw7m4Kw6Hg/H3TXUDA4GGMN7m7QhY4R
	 9rhNb41P2BURujzzu54FUDQHGxQAmf34+sykg+Ree36O/70fL0XxHIdeVcWrr31ygT0sI
	 44eDAN1cPKN55wO0C7vsLpqtpykVSZEaOjAG1xOMpyFFUMU2EJRqpzjTjedkSqDGc4I7D
	 drVQc1+KAD/AYaJ8kLz7XspRshSdGyvcNzgO9CfC3ehhoRy6gFSta0A5hIf12G2uOZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="LFaGbaB/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A74606A332;
	Mon, 16 Nov 2026 22:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LFaGbaB/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F791F000D2;
	Mon, 16 Nov 2026 22:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794866941;
	bh=XeFi5cCNjQ75ncJcr9kVqUiYUHdBVb+5baL45/OqCQM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=LFaGbaB/5yuL0F57HTHlahpbnmd2QMFDWhqRTJfYgGxgvbV+DbF54DHK1mTz1as5R
	 FQvdzBsSUTl+Ejd89z+9PqUtWsOx20Hpn03fYpqMH4oi06vz5u3z7bqcKOxlBLZbVt
	 lqYuLujbOYTy29hK3hsMePSTBFOA+Ab6LqBJM5O8+6MLpmYBaXW5jpplVwF/cooH+F
	 LwdMgvAgaUsKLaktxhIyUnpwJQrftB1Lwv4sngaxVXKleb7MyMNyom/MpYzFoMv09I
	 6Vvc+Xb35PZbmAspXQ61s2lDwa9FjdNKlBDAd9w3Yq3atrykcKFbMSzZOqyA17IpyQ
	 12XSf3mhNTz9A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 16 Nov 2026 23:06:12 +0100
Subject: [PATCH net 5/7] mptcp: push queued data on subflows falling back
 at the handshake
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
Message-Id: <20261116-net-mptcp-misc-fixes-7-4-rc4-v1-5-bf7656de653e@kernel.org>
References: <20261116-net-mptcp-misc-fixes-7-4-rc4-v1-0-bf7656de653e@kernel.org>
In-Reply-To: <20261116-net-mptcp-misc-fixes-7-4-rc4-v1-0-bf7656de653e@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>, 
 Dmytro Shytyi <dmytro@shytyi.net>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3208; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=bBQ+7q7jKXtl+hia6u5vrQe80TFZSnB3h5CQQ2i9hd8=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJ+173Y/NbQ8TZHM5elrKuC+gSp7TUh7yYw8m2e6a5+f
 otog9WMjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIl8lGBk2FvmVnshfE/29W9c
 iVIbtf+xPg2fkSh0uGeB7pWGxZfNyhh+MVtveMYy+8Fn4c4LPgLX/r+3+f/M/2DT3LWFU3OObBI
 R5QEA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

With TCP Fast Open, the data written by an MPTCP server before the 3rd
ACK is not sent when this ACK arrives without MPTCP options, but only
when another event triggers a push, e.g. new data from the peer.

The previous commit pushes this data when the third ACK, with the
MP_CAPABLE option, makes a passive TFO subflow fully established. If
this ACK has no MPTCP options, e.g. because a middlebox removed them,
check_fully_established() falls back to TCP, and returns before this
push. The fallback case of mptcp_incoming_options(), which pushes the
pending data, is only reached with the next packets.

The fix used here is to push the pending data after this fallback too.
Not only for the passive TFO subflows: data can also be pending on the
client side, when the first ACK from the server has no MPTCP options,
e.g. if the window announced by the SYN+ACK was too small for it. Same
here, this data was then only sent when another event triggered a push.

This issue has been found by an AI code review agent (Clashiko), while
reviewing an earlier version of the previous commit. It has been
reproduced with a new Packetdrill test, where the MPTCP options are
removed from the third ACK. Without this patch, and before the earlier
commit "mptcp: arm the rtx timer if a push leaves data behind", this
data was not sent:

  server-tfo-fallback-write-before-3rd-ack.pkt:26: error handling packet: Timed out waiting for packet

Since this earlier commit, this data is sent, but only when the MPTCP
retransmission timer fires, here after one second, as the test increases
its interval:

  server-tfo-fallback-write-before-3rd-ack.pkt:26: error handling packet: timing error: expected outbound packet at 0.235869 sec but happened at 1.144189 sec; tolerance 0.100000 sec

The client side case has been reported by Sashiko, while reviewing an
earlier version of this commit, and confirmed with another new
Packetdrill test, where the client writes more data than the window of
the SYN+ACK, before an ACK without MPTCP options. Without this patch:

  v1_connect_fallback_pending_data.pkt:30: error handling packet: timing error: expected outbound packet at 0.251394 sec but happened at 1.195904 sec; tolerance 0.100000 sec

Two Fixes tags: the passive TFO case comes from the first commit, and
the client side one from the second one.

Fixes: 36b122baf6a8 ("mptcp: add subflow_v(4,6)_send_synack()")
Fixes: 6f8a612a33e4 ("mptcp: keep track of advertised windows right edge")
Cc: stable@vger.kernel.org
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index bcf3440d1901..617358ff7f99 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1035,6 +1035,10 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 			MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_FALLBACKFAILED);
 			goto reset;
 		}
+		/* this ACK will not reach the fallback path: push from here */
+		mptcp_data_lock(sk);
+		__mptcp_check_push(sk, ssk);
+		mptcp_data_unlock(sk);
 		return false;
 	}
 

-- 
2.55.0

