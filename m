Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.58.216
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794841122;
	b=IOPKoe8Iu2D1cKp2UC74/ypZVIDKrmmi9oms2lwGGqmLrnGayswY4PYY4OxD1B3OPdIK
	 swEKYZImVwpcGtERSxp3+mceKNZU8O+lC+z/9CJEI7XtofS+Oef9z10uT2AvnHNepAJ1w
	 CRTLAOte5sVq6mJcfhsLCBJxHMbDwjAUBAJwM5CX4Av9Y478vktep77eis6eL1EB8eaL9
	 YNqBNa4b33ion1UwEp8XPZRmY7Xl4d9VkPKSt+zQcU7kCIr/Yyk8E3dT9tFRNlxMx9Cap
	 eLKxHIZxgE7GYzdqx/zcWnXiOcfCWS4S+rvvxDphO6IcJ+KjZNj3OTr+KZZKKDv8lrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794841122;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yTztLTqw12rdN7/Uw5DEdcju+OrXmRfrHG3yaxKlPWM=;
	b=yWPZtXr+XBs2Q9RltOw1lnwT2P/J664Os0hDDs55UQwCShrpSv69t/gs++ZlXDvgnI/f
	 T6QnLBDadTAnSI1vZAx4LN8LmXGbfSIu28HtSUgrledMlsLY61pns1MJtKxqlrwq6qppn
	 lzOvIquOSocY1h3iBWTdTHMjYYVerTX01Y7tpCBUmZXzB+Z5ZgUA6Dt1hzikW7tFQSnsx
	 KOeOUFrrm3oxOiQ/eBkupdLoS124RXU8j1XXbXme28damTLfjwUOvoicPDPPuM3CvlDqP
	 TQnAxhVGvr+vIEQ5F6sqwVJyyaveh9jdnr7DewdcmsUl6H2hkMMWhyO+0YN9v5IBh9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=p9kUqx1Z;
	arc=none smtp.remote-ip=162.62.58.216
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197C2606A8A0;
	Mon, 16 Nov 2026 14:58:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 197C2606A8A0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=p9kUqx1Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794841117; bh=yTztLTqw12rdN7/Uw5DEdcju+OrXmRfrHG3yaxKlPWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=p9kUqx1Z74oZYRxSmas8LuGPouIbd6TWqq/9JoeqyOO4MEmpaREnebGBgg6UdYmPl
	 ACeHDHSQR7VJ6YIHYKONwwC2kDFJXYPAlGpSXKWECZ1Bn5QNRY8DgnADPAS3CaY/oV
	 wNVbIZB0A94sTDE4kP+luM9W5xtJxd1NYjH2gk/U=
Received: from localhost.localdomain ([2409:8d5c:8f0:65e5:2979:aa1c:9ec4:8698])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id E9E14C42; Mon, 16 Nov 2026 22:58:30 +0800
X-QQ-mid: xmsmtpt1794841113t3irz1kbi
Message-ID: <tencent_BB8DA72524E32FD374B8B2950B247B62E207@qq.com>
X-QQ-XMAILINFO: OVxySMlD7rjOL8+YtIK9fsh+oVaiI+dCF6GUP/dnaQQ7vBo5CRV2zYZPeF9eOs
	 RPl5c7yQlw65EY2Rurb+IrWYWRRuTQpHfusVNbIGHZGOIdVUiS1fLwuqzNycnKXXbCM1ccxL+pQP
	 7Sw9ko6eyToK1+CB+TjrI5QctnXaSJKrXPN1VUfRxbsOghafX1NF+b5MKr6zYXBfKDmZMrW5eY7S
	 eK0k52n52z391nQx7iD71ZCjTWa8aK6E8kqA6GapDsLwGsxs+ng4i/rZamgpNHWvLkU4S+7wav/7
	 Er3znyhisaJUvjKPnL+IGyZF7LJNWqiX1GjLNnkP8CkaKEkpIXzIWljF9y105D7WRmWNTqlBcqV/
	 FVzdGDAkiR9O7IVAMAxIyAEXC0zww29l0p1Kc3diwq4+uMQJUjjJQi6DOIihDbe0DwuM3gGfQhLj
	 gs6vwWJxkHWju6JajBS8tCA4rMHPzc+r2Yra7H4ShKcqSUla5l3pMICKGAgjIMhqsg33c519TaeJ
	 lJ9OctQJeZQJPyo5/fB5csldiB4l9VN1mlFtw4gASuLh8IqK94G/pfGXOn8dQr5cPe61LJblB2nm
	 o3Cic2kKIGN8fcdh/v5qLb/ngydTXJ6YY9up3Hz/7z7MYkC10w84yT6teqDqKKbMcvsmJFCSRzqF
	 IgJitsYo3EFd+Z0IZfwcN3NGyWYkMEs0+EQrGvUFOkS+q/0mRaprK1hZH6Q3IwYjdgGaa+RFnL9+
	 cns5v94KFufp86I8P+2Ey2FL8L4Ty+4GQBBR2KK2AqOG1IW/tY6blGUbcHMiYZBBV/jssSsUkoqR
	 EJv3jUVq7P/ajFE3DHTuT1ONxkxaxJGBM1cOVhxha2/gcAC9crMDnBGLIoz3thDjejk3qpNJ5Zcr
	 bzLcnSnLeKznsytUbhqUFphj96XfLm5JIxZ/IlRxzklQ2pjoq5z3jqIISzaYtB1V/zqSPQn657os
	 bJSOQzLJUlulL7/FKuSb4Z5A012GKW8zVvV7GQ83OxL3mlC0LfiMdJXPA2DtlBkxBWDTOZs353qh
	 Cgd71wl+PP+eKE7zvntbuXto9cI0McQm+NS6dUwWwdlpmUbI5y00nhE9GiBFc/ysaScvTFy4Wq7H
	 +bMp0herGSXZoq/ObMHgtUkXp/lAkMxpNhBK31QGFFZ+mUl7dyTjXWgZsWO/ckIxgY+ZEhCqMWGb
	 pSDVqvwAcZzMXT9Q==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Hang Nan <2122295973@qq.com>
To: netdev@vger.kernel.org
Cc: mptcp@lists.linux.dev,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kuniyu@google.com,
	willemb@google.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	2122295973@qq.com
Subject: [PATCH net v5 1/3] net: mptcp: take token lookup references with acquire ordering
Date: Mon, 16 Nov 2026 22:58:27 +0800
X-OQ-MSGID: <20261116145829.96849-2-2122295973@qq.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261116145829.96849-1-2122295973@qq.com>
References: <20261116145829.96849-1-2122295973@qq.com>
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

mptcp_token_get_sock() and mptcp_token_iter_next() take a reference on a
socket found on an RCU-protected hash chain and then re-read state to
decide whether that socket is the one they were looking for.  The
re-validation is only meaningful if it is ordered after the reference
acquisition.

The sockets come from mptcp_prot.slab, which is SLAB_TYPESAFE_BY_RCU, so
the memory a reader still points at can be freed and reallocated as a new
mptcp socket while the reader is between the chain walk and the
increment.  The new owner publishes itself in sock_init_data_uid() with

	smp_wmb();
	refcount_set(&sk->sk_refcnt, 1);

and initialises the rest of the socket only afterwards.  A reader whose
increment does not carry acquire ordering can have the re-read of
msk->token and sock_net(sk) satisfied before the increment, that is
against the old object's contents, while the increment itself succeeds on
the new one.  The lookup would then hand back a socket that belongs to a
different connection, or one that is not initialised yet.

refcount_inc_not_zero() has not provided that ordering since
commit fb041bb7c0a9 ("locking/refcount: Consolidate implementations of refcount_t"),
which removed the ordering the previous atomic_add_unless() based
implementation gave; refcount.h names this exact case as the reason the
acquire variants exist.

commit 5b5d8f351dd9 ("net: restore refcount ordering for lockless socket access")
restored the ordering for the IPv4/IPv6 established lookups,
inet_twsk_purge() and bpf_sk_assign().  These two mptcp sites have the
same shape and are converted as well.  There is no behaviour change on
strongly ordered CPUs.

Fixes: 2c5ebd001d4f ("mptcp: refactor token container")
Fixes: 96d890daad05 ("mptcp: add msk interations helper")
Cc: stable@vger.kernel.org
Signed-off-by: Hang Nan <2122295973@qq.com>
---
 net/mptcp/token.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index e0f2823f92ef..3429b43a9f7c 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -309,7 +309,7 @@ struct mptcp_sock *mptcp_token_get_sock(struct net *net, u32 token)
 		    !net_eq(sock_net(sk), net))
 			continue;
 
-		if (!refcount_inc_not_zero(&sk->sk_refcnt))
+		if (!refcount_inc_not_zero_acquire(&sk->sk_refcnt))
 			goto not_found;
 
 		if (READ_ONCE(msk->token) != token ||
@@ -370,7 +370,7 @@ struct mptcp_sock *mptcp_token_iter_next(const struct net *net, long *s_slot,
 			if (num <= *s_num)
 				continue;
 
-			if (!refcount_inc_not_zero(&sk->sk_refcnt))
+			if (!refcount_inc_not_zero_acquire(&sk->sk_refcnt))
 				continue;
 
 			if (!net_eq(sock_net(sk), net)) {
-- 
2.47.3

