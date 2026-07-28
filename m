Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4F63B895F
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 18:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785262063; cv=none; b=Hp6UC7zOrgEV8sm1Cbc3Td6uhZkJZ8JqZBGF5PuUvuxnsOVIumSBNnskiOw9/hsirb9pe/mntX3xIzIVxrEa78XVXV6GALXP9INFi0lmbWOw5vynHLpjF2DnF2KTx7DWb82ZWRJQnJsCIaU8uy+hqIdcb/DBFWFgA+JEa/c0mK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785262063; c=relaxed/simple;
	bh=B/bHs2GLvReh3L0UmSEH2veyspCMM8a72z6pHpF74TY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UdQFslXbb1ew61JOgjHsmKHKStshzmOB3aGu9LZcELhVtWHsX1/iXi3A59BcC5V/l35FLsXf6haE1REcKJXMb+dGaxfTn0x4abHpUYFHUdmy47mfsasPRAiGGCMj1H9oI0A54o/FgDWdMoZFiMOOAyIRWa4xQ3xD/w0233a42Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WwYKqxiw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WwYKqxiw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E83E1F00A3E;
	Tue, 28 Jul 2026 18:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785262061;
	bh=6UXXcWzgAsa1Y/vadfKxLloDey0FhooT66Plw4FAZBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WwYKqxiwyvyrrltblEna87w2NLt0Oy3Tm+XKjsrH7FNqAKC9w6hLN4E0qy58EGL+t
	 XojDvFCP5Ef/JbMHX7B1iijzdXxN9p829zx746uEXdmDd6BVRhVPpD4nwE+dLUhQu/
	 7MdBaowFNFc714dbmd6c0/GNOxMRKiSukdsXUwNu8+YEqzfocvtM6BwXN5EpWKjYzN
	 c40v83E15L08RI59xYu3CvenHc6niNYZbrnz5kLVOCJcbMOh5HhIO6Kd0xIfPLllxH
	 qL00UQT07BWN1zz035gC/vRzChdD5KcRsucF1itUigsg6Eo0tzWauwJJXsu6qm5RVY
	 aCg5cM/gkOtFA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Bernard Metzler <bmt@zurich.ibm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	David Ahern <dsahern@kernel.org>,
	Karsten Graul <kgraul@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Jan Karcher <jaka@linux.ibm.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Boris Pismenny <borisp@nvidia.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 4/5] tcp_bpf, smc, tls, espintcp, siw: Reduce MSG_SENDPAGE_NOTLAST usage
Date: Tue, 28 Jul 2026 14:07:32 -0400
Message-ID: <20260728180733.291798-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728180733.291798-1-sashal@kernel.org>
References: <2026072137-hatred-autograph-0bbe@gregkh>
 <20260728180733.291798-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Howells <dhowells@redhat.com>

[ Upstream commit f8dd95b29d7ef08c19ec9720564acf72243ddcf6 ]

As MSG_SENDPAGE_NOTLAST is being phased out along with sendpage(), don't
use it further in than the sendpage methods, but rather translate it to
MSG_MORE and use that instead.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
cc: Bernard Metzler <bmt@zurich.ibm.com>
cc: Jason Gunthorpe <jgg@ziepe.ca>
cc: Leon Romanovsky <leon@kernel.org>
cc: John Fastabend <john.fastabend@gmail.com>
cc: Jakub Sitnicki <jakub@cloudflare.com>
cc: David Ahern <dsahern@kernel.org>
cc: Karsten Graul <kgraul@linux.ibm.com>
cc: Wenjia Zhang <wenjia@linux.ibm.com>
cc: Jan Karcher <jaka@linux.ibm.com>
cc: "D. Wythe" <alibuda@linux.alibaba.com>
cc: Tony Lu <tonylu@linux.alibaba.com>
cc: Wen Gu <guwen@linux.alibaba.com>
cc: Boris Pismenny <borisp@nvidia.com>
cc: Steffen Klassert <steffen.klassert@secunet.com>
cc: Herbert Xu <herbert@gondor.apana.org.au>
Link: https://lore.kernel.org/r/20230623225513.2732256-2-dhowells@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 007800408002 ("espintcp: use sk_msg_free_partial to fix partial send")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/sw/siw/siw_qp_tx.c |  5 ++---
 net/ipv4/tcp_bpf.c                    |  5 +++--
 net/smc/smc_tx.c                      |  6 ++++--
 net/tls/tls_device.c                  |  4 ++--
 net/xfrm/espintcp.c                   | 10 ++++++----
 5 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c b/drivers/infiniband/sw/siw/siw_qp_tx.c
index d24442ca879321..c6222d9252057b 100644
--- a/drivers/infiniband/sw/siw/siw_qp_tx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
@@ -326,8 +326,7 @@ static int siw_tcp_sendpages(struct socket *s, struct page **page, int offset,
 {
 	struct bio_vec bvec;
 	struct msghdr msg = {
-		.msg_flags = (MSG_MORE | MSG_DONTWAIT | MSG_SENDPAGE_NOTLAST |
-			      MSG_SPLICE_PAGES),
+		.msg_flags = (MSG_MORE | MSG_DONTWAIT | MSG_SPLICE_PAGES),
 	};
 	struct sock *sk = s->sk;
 	int i = 0, rv = 0, sent = 0;
@@ -336,7 +335,7 @@ static int siw_tcp_sendpages(struct socket *s, struct page **page, int offset,
 		size_t bytes = min_t(size_t, PAGE_SIZE - offset, size);
 
 		if (size + offset <= PAGE_SIZE)
-			msg.msg_flags &= ~MSG_SENDPAGE_NOTLAST;
+			msg.msg_flags &= ~MSG_MORE;
 
 		tcp_rate_check_app_limited(sk);
 		bvec_set_page(&bvec, page[i], bytes, offset);
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 73412e80548168..c1859e4d3c29c1 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -90,9 +90,9 @@ static int bpf_tcp_ingress(struct sock *sk, struct sk_psock *psock,
 static int tcp_bpf_push(struct sock *sk, struct sk_msg *msg, u32 apply_bytes,
 			int flags, bool uncharge)
 {
+	struct msghdr msghdr = {};
 	bool apply = apply_bytes;
 	struct scatterlist *sge;
-	struct msghdr msghdr = { .msg_flags = flags | MSG_SPLICE_PAGES, };
 	struct page *page;
 	int size, ret = 0;
 	u32 off;
@@ -109,11 +109,12 @@ static int tcp_bpf_push(struct sock *sk, struct sk_msg *msg, u32 apply_bytes,
 
 		tcp_rate_check_app_limited(sk);
 retry:
+		msghdr.msg_flags = flags | MSG_SPLICE_PAGES;
 		has_tx_ulp = tls_sw_has_ctx_tx(sk);
 		if (has_tx_ulp)
 			msghdr.msg_flags |= MSG_SENDPAGE_NOPOLICY;
 
-		if (flags & MSG_SENDPAGE_NOTLAST)
+		if (size < sge->length && msg->sg.start != msg->sg.end)
 			msghdr.msg_flags |= MSG_MORE;
 
 		bvec_set_page(&bvec, page, size, off);
diff --git a/net/smc/smc_tx.c b/net/smc/smc_tx.c
index 45128443f1f10f..9b9e0a19073475 100644
--- a/net/smc/smc_tx.c
+++ b/net/smc/smc_tx.c
@@ -168,8 +168,7 @@ static bool smc_tx_should_cork(struct smc_sock *smc, struct msghdr *msg)
 	 * should known how/when to uncork it.
 	 */
 	if ((msg->msg_flags & MSG_MORE ||
-	     smc_tx_is_corked(smc) ||
-	     msg->msg_flags & MSG_SENDPAGE_NOTLAST) &&
+	     smc_tx_is_corked(smc)) &&
 	    atomic_read(&conn->sndbuf_space))
 		return true;
 
@@ -306,6 +305,9 @@ int smc_tx_sendpage(struct smc_sock *smc, struct page *page, int offset,
 	struct kvec iov;
 	int rc;
 
+	if (flags & MSG_SENDPAGE_NOTLAST)
+		msg.msg_flags |= MSG_MORE;
+
 	iov.iov_base = kaddr + offset;
 	iov.iov_len = size;
 	iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, &iov, 1, size);
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index dd6def66bec614..2bfc95f7e46032 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -457,7 +457,7 @@ static int tls_push_data(struct sock *sk,
 		return -sk->sk_err;
 
 	flags |= MSG_SENDPAGE_DECRYPTED;
-	tls_push_record_flags = flags | MSG_SENDPAGE_NOTLAST;
+	tls_push_record_flags = flags | MSG_MORE;
 
 	timeo = sock_sndtimeo(sk, flags & MSG_DONTWAIT);
 	if (tls_is_partially_sent_record(tls_ctx)) {
@@ -526,7 +526,7 @@ static int tls_push_data(struct sock *sk,
 		if (!size) {
 last_record:
 			tls_push_record_flags = flags;
-			if (flags & (MSG_SENDPAGE_NOTLAST | MSG_MORE)) {
+			if (flags & MSG_MORE) {
 				more = true;
 				break;
 			}
diff --git a/net/xfrm/espintcp.c b/net/xfrm/espintcp.c
index acb612bf829a5f..c6b2f71f42c021 100644
--- a/net/xfrm/espintcp.c
+++ b/net/xfrm/espintcp.c
@@ -206,13 +206,15 @@ static int espintcp_sendskb_locked(struct sock *sk, struct espintcp_msg *emsg,
 static int espintcp_sendskmsg_locked(struct sock *sk,
 				     struct espintcp_msg *emsg, int flags)
 {
-	struct msghdr msghdr = { .msg_flags = flags | MSG_SPLICE_PAGES, };
+	struct msghdr msghdr = {
+		.msg_flags = flags | MSG_SPLICE_PAGES | MSG_MORE,
+	};
 	struct sk_msg *skmsg = &emsg->skmsg;
+	bool more = flags & MSG_MORE;
 	struct scatterlist *sg;
 	int done = 0;
 	int ret;
 
-	msghdr.msg_flags |= MSG_SENDPAGE_NOTLAST;
 	sg = &skmsg->sg.data[skmsg->sg.start];
 	do {
 		struct bio_vec bvec;
@@ -222,8 +224,8 @@ static int espintcp_sendskmsg_locked(struct sock *sk,
 
 		emsg->offset = 0;
 
-		if (sg_is_last(sg))
-			msghdr.msg_flags &= ~MSG_SENDPAGE_NOTLAST;
+		if (sg_is_last(sg) && !more)
+			msghdr.msg_flags &= ~MSG_MORE;
 
 		p = sg_page(sg);
 retry:
-- 
2.53.0

