Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795617943;
	b=uMyAiDONZ0GEqNd2/u0V/RdQZXogu/AfjQv7WnxcJF2HdWQbZkDb3gbUuaP3CGtYE3XD
	 CWurO20o8SFyKbspiB6lp8PZ64ZVXUKQtsIT4H41PaVDYSKvUV54rg82UOq3jxUUY6KlQ
	 yHs4lhsURzO0tBLy689ZUGzoKwZAUiSAQOaALjx9pYsAHSUMhC7eifUJ49PxxR8JY+GoV
	 QaKsjuXKwGE4q3hOA5dsXXTw/9AjQ49ryARax45NBbWo5QjJo0LSMZIh0lkJByAv4Ns9Y
	 pdgSwXgwfn6fLOq+oQfPoweozD6tJJv3/CStyMiRryqT60I1Odk3uKc+D4PmrX6op9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795617943;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=16wXKuAkkPCdzCfTbwNdvYnC57p3Jqo55TMiWEFYH/c=;
	b=WOb4o+nTvi/JT6HBt0Yuz0csmK0UGJkfsDgGNUC/fX+XUZOTvm/eJd1FEnbnjntfvVaV
	 sUIOWK7BntWE9xnPfqQKYTlSjzcsuaDcjMkUC1inNL2730Ikhr5ArqSsG/TfnqwdmGsgL
	 dnAd4MOhjEYBzA3I15FQTKArWo7q68Q4XgushoMUA0AMNLX5845MSO5yVC6pUX6wq7NfK
	 g8DPK23q865N8TivQepsuNh57jl3LVlmq3q5vCiY+wuOqgKcDIPM8sLRNdjitrStbolPE
	 bQnfBkVqjvqBPEWrg36ZeF5AsdrRXT/dLlzzimzvFxaGmdyTk2hz2RH6MNWhTsp06Tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bWytcWaP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBC0606A323
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 14:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bWytcWaP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C07111F000C4;
	Wed, 25 Nov 2026 14:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795617942;
	bh=16wXKuAkkPCdzCfTbwNdvYnC57p3Jqo55TMiWEFYH/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bWytcWaPBpLt540os6e0Nis6/7cRsOTo87itzkPLyPs85SsBOyaLSixfHPCyonrQn
	 oTjTlYHGpAMJAOaagP9MTrePPhr0wY99nwEoZZASpcGwefHLSvjGBH96gITeFtQ1i8
	 I83xlDB+xNQZrNwl104BCsNiTI1deK4y/BqX+ESGzbnYKbxs8QBK+sNKxU1Bh9HmAc
	 oH3Afq39iCKs7YlRDrZlUculuP5wKhxyizKeYfvcSVKiN4PU3bMLtNoao2gkcYzlfA
	 MKYEhfgYqT35iv2zZOE8CiEHXuWCHmSd+jikriZn0q85/K6UXqUCQY/YghvR6CXSTp
	 dtCcZsAB3PqWA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeremy Harris <jgh@exim.org>,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] tcp: fastopen: note that a child socket was created
Date: Wed, 25 Nov 2026 09:45:39 -0500
Message-ID: <20261125144533.4173150-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112552-threefold-playset-c83a@gregkh>
References: <2026112552-threefold-playset-c83a@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeremy Harris <jgh@exim.org>

[ Upstream commit bc2550b4e195754fbb24aac1f012d3dd9e3b4edc ]

tcp: fastopen: note that a child socket was created

This uses up the last bit in a field of tcp_sock.

Signed-off-by: Jeremy Harris <jgh@exim.org>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Neal Cardwell <ncardwell@google.com>
Link: https://patch.msgid.link/20250423124334.4916-2-jgh@exim.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 62754aad50d0 ("tcp: fix request_sock use-after-free during Fast Open accept()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/tcp.h     | 3 ++-
 net/ipv4/tcp.c          | 1 +
 net/ipv4/tcp_fastopen.c | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 00ea96fec2273..ea54a107f307c 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -384,7 +384,8 @@ struct tcp_sock {
 		syn_fastopen:1,	/* SYN includes Fast Open option */
 		syn_fastopen_exp:1,/* SYN includes Fast Open exp. option */
 		syn_fastopen_ch:1, /* Active TFO re-enabling probe */
-		syn_data_acked:1;/* data in SYN is acked by SYN-ACK */
+		syn_data_acked:1,/* data in SYN is acked by SYN-ACK */
+		syn_fastopen_child:1; /* created TFO passive child socket */
 
 	u8	keepalive_probes; /* num of allowed keep alive probes	*/
 	u32	tcp_tx_delay;	/* delay (in usec) added to TX packets */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 69b4e194ba135..d1999b1cedaa1 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3400,6 +3400,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 	tp->rack.reo_wnd_persist = 0;
 	tp->rack.dsack_seen = 0;
 	tp->syn_data_acked = 0;
+	tp->syn_fastopen_child = 0;
 	tp->rx_opt.saw_tstamp = 0;
 	tp->rx_opt.dsack = 0;
 	tp->rx_opt.num_sacks = 0;
diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
index ac4fa51240290..6ccee7480232d 100644
--- a/net/ipv4/tcp_fastopen.c
+++ b/net/ipv4/tcp_fastopen.c
@@ -404,6 +404,7 @@ struct sock *tcp_try_fastopen(struct sock *sk, struct sk_buff *skb,
 				}
 				NET_INC_STATS(sock_net(sk),
 					      LINUX_MIB_TCPFASTOPENPASSIVE);
+				tcp_sk(child)->syn_fastopen_child = 1;
 				return child;
 			}
 			NET_INC_STATS(sock_net(sk),
-- 
2.53.0

