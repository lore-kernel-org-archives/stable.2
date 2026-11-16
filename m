Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794866936;
	b=gAQjedInxhY7zLrzObvboUxavZ3ZB+TH9m2242KPX06aHe7kXAs2OH6YPpMsn8w5BaOt
	 WglmY1kzTHcYReoYC843hYHBcegPWjGOJBbjEhptDr9ZsjOxIl08F5TxVf4JZeHP7QS2q
	 cTBK9ngWShdR7PgzVjp/90ZpEUxXJ2vX+exrpvucGNMIgD/GhrK3VzeVRVsRGFyLJ7C4b
	 mQAbYYbIgLI2mYAmKYKb904VTB5+w3U+9gnjWu5/umN0Kn9t70r8XBXPreFXg9I/jj8zH
	 vcwTMl6/ltcJKcEXO9fnM2tM3OQ45btLIYm8G1BbxOa/mPsc2Dc0CaPiYFqcNdBfbrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794866936;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Tj2/cFIwMQiU0oTdy1lbkijRfjf34Z7e24OcuJwQONY=;
	b=xyaKL7uNFZ0Otwj0zdXSPQXmjkRtSlW03hDDcL2hpzvfoOLzHmn+8Bdcb+O1VsadjyiU
	 cEpw4+hRypdy+vuAeSAVi4smLqW8+xCpapAFHGTVEAaKzNgZAngUfNpi7aBY1/krunRdM
	 N1o3PMQydmiS3Zvyyx1PNFrgNhaRot2pLgHPef/UMrzQcq0Y3gggadNyX9SsG6SUOF6F9
	 apAxYf+UFJ6dl55xqIJHTMRI3NY+7dvyoBOJf7xIw6GopQ6Jf38qGRRYEmkJgvdTFTHNx
	 YclyQ1YfKG1FjJsLWF+dJOba8Qzas4hYO1Evq3beqa44896yx3OjwCWqo+Mnxu2cxBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S2QqxXbK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127D160A262C;
	Mon, 16 Nov 2026 22:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S2QqxXbK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 528D01F000C6;
	Mon, 16 Nov 2026 22:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794866935;
	bh=Tj2/cFIwMQiU0oTdy1lbkijRfjf34Z7e24OcuJwQONY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=S2QqxXbKe3sufn9poQhFXU+WJWVCh02pWq02vwmIQE05eLt1F4Vwr598L+IcJjXCU
	 S3G9NdVNUhFT5+hRNd4wuZ3/J59ExXMHRrgssn10qAvpSjCPocX+vg+ouvrMb+eE/p
	 WpqF8gMQF53r0CpFMdwAOZHGv3twWC116J+A+UBhDdV5EUr/7wnnCtXOW5XD3b4vgH
	 XhMmm+cRDu+LpEHUVM6ksGHxX3a+yA3vucCOKOQtySyrYDPSp6jItAuX56Cn8y31U7
	 nFzHxWsJYU1co4DTSmg+WrAoTxKZlgq/jmRqJEKBPDxMjzVsYWHC+DoVH684az4tUu
	 Y5UUa6gqQULsQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 16 Nov 2026 23:06:10 +0100
Subject: [PATCH net 3/7] mptcp: use sk instead of casting msk in
 check_fully_established()
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
Message-Id: <20261116-net-mptcp-misc-fixes-7-4-rc4-v1-3-bf7656de653e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1620; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=QwxgCSzbTvt4gHjKMplH154tKIyEr+lvY7q4aegDmF0=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJ+1z23fnLld3ls6skXL7+sFC46P///4rz3G2oOPHviz
 bKWd2bNkY5SFgYxLgZZMUUW6bbI/JnPq3hLvPwsYOawMoEMYeDiFICJLF7AyPDPRH6F46Y01aYF
 RzRnm5VtPMz1dtvUDfU+F/Xam6Rn39Nl+MU89d+MzgdM/0z7jn5e+3zB2buXnU7Nf1NetICF40V
 GQiMrAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The MPTCP socket is cast to a struct sock in check_fully_established(),
to take its data lock. The next commits need it more, to push the
pending data.

Add a local 'sk' variable instead of casting msk each time: no
functional change.

The 'Fixes' tag here below is the same as the one from the next
commits: this patch is needed to fix the issues introduced by this
commit ID.

Fixes: 36b122baf6a8 ("mptcp: add subflow_v(4,6)_send_synack()")
Cc: stable@vger.kernel.org
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index a1e65309171e..1c58468b985b 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -982,6 +982,8 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 				    struct sk_buff *skb,
 				    struct mptcp_options_received *mp_opt)
 {
+	struct sock *sk = (struct sock *)msk;
+
 	/* here we can process OoO, in-window pkts, only in-sequence 4th ack
 	 * will make the subflow fully established
 	 */
@@ -1043,9 +1045,9 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 	if (mp_opt->deny_join_id0)
 		WRITE_ONCE(msk->pm.remote_deny_join_id0, true);
 
-	mptcp_data_lock((struct sock *)msk);
+	mptcp_data_lock(sk);
 	__mptcp_subflow_fully_established(msk, subflow, mp_opt);
-	mptcp_data_unlock((struct sock *)msk);
+	mptcp_data_unlock(sk);
 
 check_notify:
 	/* if the subflow is not already linked into the conn_list, we can't

-- 
2.55.0

