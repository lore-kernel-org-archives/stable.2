Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFF03A8738
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 18:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785262057; cv=none; b=TLcME7s9L8Nmr56JbBupho7QMi5tE0a5JUAyx22Wz8nWDzRG9wVFzKm+1tBeHKvYZ953QIS88vTtN9Qq/EMhsewQ788WBeyeVqkCOG2ffKFAuJNPtklYJaKSqRJsHqFEDkjebZUJ28IKeTuPcFBzTBwpeLGGUvUrCBYgjL9pK3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785262057; c=relaxed/simple;
	bh=j+fc8PGuIfimykFX3QnkpjRx68MiJeswcEv3GC4DLxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=paijElTvG5V6H+iOaF20cZ6wFdaMutdiM7ZOc8RWRezqoXMwddKVtog5f2cKX0z7w29iQPBqgjHO+KClWQCAkwCmmgQ9GdJ0hpR36kHDy1d0/8T/IxlGGy5o9YjBfF8S05msNUqrRorTdNqF2IAlYQArZhdQ78ePxlNWo8qlA98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJT+IFVK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJT+IFVK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AAD91F000E9;
	Tue, 28 Jul 2026 18:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785262056;
	bh=7+cOsqRVXtuOqdjR3aLqwdVXMB32yNIK+EWpALAXZb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lJT+IFVK75WkNpfSZN3QNkrSCETBDH0X6lN3BQl+8TmHH2hqeTHNMYD0qGAb1qCKS
	 0MIjD7/ZSkxaLcfBjBTbEdnQAZbh5jlAL4xBBLfr3kPsCXYiBFrP/o+bLxXwSlFq4h
	 j6pQyt/6nqZ0qO1CPbCYeUmu5NA8YkS3IQNtqq7afsYgiW5idbCtIvkxj/hRs6QLM4
	 KsCj1beBMG198B0BMEOt4wtcdLZyuzhhGaQhf/tF3DasghdE6EZPwAOjkWOsVb+QCB
	 qECiZXm9avUgJtAGvr3t/rX3aMkanrhMgTVO/K3zGQlVtLtJksW5doq3vrriJKLSjK
	 l9ff6q8SHyUiQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	David Ahern <dsahern@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Matthew Wilcox <willy@infradead.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/5] tcp_bpf: Inline do_tcp_sendpages as it's now a wrapper around tcp_sendmsg
Date: Tue, 28 Jul 2026 14:07:29 -0400
Message-ID: <20260728180733.291798-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072137-hatred-autograph-0bbe@gregkh>
References: <2026072137-hatred-autograph-0bbe@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Howells <dhowells@redhat.com>

[ Upstream commit ebf2e8860eea66e2c4764316b80c6a5ee5f336ee ]

do_tcp_sendpages() is now just a small wrapper around tcp_sendmsg_locked(),
so inline it.  This is part of replacing ->sendpage() with a call to
sendmsg() with MSG_SPLICE_PAGES set.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: John Fastabend <john.fastabend@gmail.com>
cc: Jakub Sitnicki <jakub@cloudflare.com>
cc: David Ahern <dsahern@kernel.org>
cc: Jens Axboe <axboe@kernel.dk>
cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 007800408002 ("espintcp: use sk_msg_free_partial to fix partial send")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp_bpf.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 9af7595bf8c452..73412e80548168 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -92,11 +92,13 @@ static int tcp_bpf_push(struct sock *sk, struct sk_msg *msg, u32 apply_bytes,
 {
 	bool apply = apply_bytes;
 	struct scatterlist *sge;
+	struct msghdr msghdr = { .msg_flags = flags | MSG_SPLICE_PAGES, };
 	struct page *page;
 	int size, ret = 0;
 	u32 off;
 
 	while (1) {
+		struct bio_vec bvec;
 		bool has_tx_ulp;
 
 		sge = sk_msg_elem(msg, msg->sg.start);
@@ -108,16 +110,18 @@ static int tcp_bpf_push(struct sock *sk, struct sk_msg *msg, u32 apply_bytes,
 		tcp_rate_check_app_limited(sk);
 retry:
 		has_tx_ulp = tls_sw_has_ctx_tx(sk);
-		if (has_tx_ulp) {
-			flags |= MSG_SENDPAGE_NOPOLICY;
-			ret = kernel_sendpage_locked(sk,
-						     page, off, size, flags);
-		} else {
-			ret = do_tcp_sendpages(sk, page, off, size, flags);
-		}
+		if (has_tx_ulp)
+			msghdr.msg_flags |= MSG_SENDPAGE_NOPOLICY;
 
+		if (flags & MSG_SENDPAGE_NOTLAST)
+			msghdr.msg_flags |= MSG_MORE;
+
+		bvec_set_page(&bvec, page, size, off);
+		iov_iter_bvec(&msghdr.msg_iter, ITER_SOURCE, &bvec, 1, size);
+		ret = tcp_sendmsg_locked(sk, &msghdr, size);
 		if (ret <= 0)
 			return ret;
+
 		if (apply)
 			apply_bytes -= ret;
 		msg->sg.size -= ret;
@@ -499,7 +503,7 @@ static int tcp_bpf_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 	long timeo;
 	int flags;
 
-	/* Don't let internal do_tcp_sendpages() flags through */
+	/* Don't let internal sendpage flags through */
 	flags = (msg->msg_flags & ~MSG_SENDPAGE_DECRYPTED);
 	flags |= MSG_NO_SHARED_FRAGS;
 
-- 
2.53.0

