Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794866930;
	b=ZBTa2aOzENuvUDdo2y9YCANN1d3Zxw7hjclePo6hSLOWBydEadRZoHpDzZ2myiw2ghbc
	 abqaDeJwsJ48iJpb5HAOijQNwtRrfoPmB8OayqdKINy2e+lbuBJoQjxTFVsED45K6i2dc
	 rWFqKuvjgF3xR0/cQao2uZhuat4wrOPdyAj0J5Xh/dBF2ABlVU8CbSGPIGBcdDwRcWyNN
	 sIXqItxeNUABi2r6Hp0Mxu7iKW5IVpKDqcQmUHgKg/F316KLRV0mCDwZeVokoycKANkoV
	 iJwXEob9Qb/Q9C6kzGObFr04G98vYSDa4pMP0ZcowLGY02uKWAVp8Vkr1QujrJZw7qA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794866930;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=uMYq6JE8xuNZqyVh9m0VgbWr7vZYU9GSmfyKxFS5D+A=;
	b=1Bb74MJsS8T7VPi33zKfdUsTD4eeEe/cU3c5FfJZyXAppyywOD156cCfsvZOc8rPBy2U
	 VZNaTkV3X6HdGR25wb6bhp3ohFHB3+TaAN1awXcOdydWjQnPlZfosaTRVi/HGGcFxRrht
	 b97eLstj9zcTY4nk5Y+X/2c8kGLVanDJiDcaE7YgBC3EI24o9TxH7bslGQ4t+tezvZAYM
	 PoPSzdoZGvdtvGsIqKoP4fK0AGpD56Dpl9kV8HqxnIJtqFXZ9GTUTRcbA4pxXgRZMB9ZV
	 genZ30XYpQO8J0JDac9lhx20z0msp+RtGrFzhCp5l3IVL/FDXLTZwas56EZJaOOAYnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DLidWKMH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773A6606A330;
	Mon, 16 Nov 2026 22:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DLidWKMH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA7BA1F000C4;
	Mon, 16 Nov 2026 22:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794866930;
	bh=uMYq6JE8xuNZqyVh9m0VgbWr7vZYU9GSmfyKxFS5D+A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=DLidWKMHgkte+wcx8XviGctfDknmqXQhV6a00gH3EIHqU7Afe13izKrBMzLE+ahf6
	 SHtdWjtSQGVabAvD+hROIl3Z1XeYFgI8CZ/B2+ZIYcitEPqOIUJsdv5PgGY1Gek+OP
	 KzBi5m2FWAoHqC+q+Xg8PZIDQYRzyV4tSA8lwRAt3jfAcd20LZhq0XHAM4fs+EoiTt
	 mUFOrjYuMshD/iMSmvXxQtCMk/y4DCDWIy1oIu2FrWHpcu2W11ZYI+yeJ7Vf+JqzdE
	 t6jFyXF6WTGmDDqXQmwqHz67UIp/6BmkRUB5gDmIjuzRtlNaXTT2ZTlhE9acaRpSSe
	 wZ/q+ng1XXUdw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 16 Nov 2026 23:06:08 +0100
Subject: [PATCH net 1/7] mptcp: do not use a raised snd_wnd for the send
 window
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
Message-Id: <20261116-net-mptcp-misc-fixes-7-4-rc4-v1-1-bf7656de653e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3711; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=7zDQSYKcpnKhli3dcbyFsT9TAjx17AqSPorjk+qb/hU=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJ+1z2bodi3o0M+f3vSn0sBImwn/iz4FNWxe9NV0U2PP
 iQeZGiX7yhlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZjInY+MDCff+5y5OeHnv7yd
 x9JPXfq3/9bpx9eXbbEItUjeWN//79oXhv9ufTeVH62qmh948c+K8mPq8xym/kxg7HytLaUa5ls
 3/yc3AA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

ack_update_msk() sets the right edge of the MPTCP send window from the
DATA_ACK and tcp_sk(ssk)->snd_wnd, but this is not always what the peer
announced: mptcp_check_allowed_size() raises it to
window_end - data_seq, so that TCP lets through what the MPTCP-level
window allows.

That is fine for new data. For data sent again, data_seq can be below
snd_una, and snd_wnd ends up too large by the difference. TCP only
overwrites it when an ACK moves things forward on this subflow, see
tcp_may_update_window(). If a DATA_ACK moved by another subflow comes in
on this subflow before that, wnd_end goes past what the peer offered. It
only moves forward, so it stays there.

The sender then transmits data beyond the peer's window: the peer drops
it (MPTCP_MIB_NODSSWINDOW) after TCP acked it, and only an MPTCP-level
retransmission can recover it, which raises snd_wnd again. The
connection can then stay stuck at a low rate for several seconds, with
nothing in flight on any subflow.

This raise has been added by commit b713d0067574 ("mptcp: really share
subflow snd_wnd"), but snd_wnd could already be too large before: when
nothing moves at the TCP level, tcp_may_update_window() ignores a lower
non-zero window, while the peer can announce one with a DATA_ACK that
moved, keeping the same right edge.

Use the window announced in the packet carrying the DATA_ACK instead.

In my case with BBR, a small TCP rmem, and a second path with a much
higher latency, a lower throughput and some losses, this small change
can double the throughput in the worst cases.

The issue has been reproduced with a new Packetdrill test, on a single
subflow: the data is acked by TCP, then by MPTCP with a lower window,
keeping the same right edge. Without this patch, the 2000 bytes written
next were sent, instead of the 1280 bytes up to this right edge:

  dss_dack_window_server.pkt:23: error handling packet: live packet payload: expected 1280 bytes vs actual 2000 bytes

Fixes: 6f8a612a33e4 ("mptcp: keep track of advertised windows right edge")
Cc: stable@vger.kernel.org
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 02e785a14b8a..a1e65309171e 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1120,9 +1120,11 @@ static void rwin_update(struct mptcp_sock *msk, struct sock *ssk,
 
 static void ack_update_msk(struct mptcp_sock *msk,
 			   struct sock *ssk,
+			   const struct sk_buff *skb,
 			   struct mptcp_options_received *mp_opt)
 {
 	u64 new_wnd_end, new_snd_una, old_snd_una;
+	u32 win = ntohs(tcp_hdr(skb)->window);
 	struct sock *sk = (struct sock *)msk;
 	u64 snd_nxt;
 
@@ -1143,7 +1145,12 @@ static void ack_update_msk(struct mptcp_sock *msk,
 		     after64(new_snd_una, snd_nxt)))
 		new_snd_una = old_snd_una;
 
-	new_wnd_end = new_snd_una + tcp_sk(ssk)->snd_wnd;
+	/* What the peer announced: tcp_sk(ssk)->snd_wnd can be larger, see
+	 * mptcp_check_allowed_size(), and is not always updated.
+	 */
+	if (likely(!tcp_hdr(skb)->syn))
+		win <<= tcp_sk(ssk)->rx_opt.snd_wscale;
+	new_wnd_end = new_snd_una + win;
 
 	if (after64(new_wnd_end, msk->wnd_end))
 		WRITE_ONCE(msk->wnd_end, new_wnd_end);
@@ -1313,7 +1320,7 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 	 * monodirectional flows will stuck
 	 */
 	if (mp_opt.use_ack)
-		ack_update_msk(msk, sk, &mp_opt);
+		ack_update_msk(msk, sk, skb, &mp_opt);
 	rwin_update(msk, sk, skb);
 
 	/* Zero-data-length packets are dropped by the caller and not

-- 
2.55.0

