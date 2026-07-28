Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67BC3B71C1
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 18:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785262059; cv=none; b=IWIRXGZIQhZ5pc1YCvYMvrWddrwJz35kMqlPWHA1nqpPqmH24HnGze8+N0CxvV3tqz4RPs9K8D/68iysJ9iHGuV5Pn7HavDbC80pV3NznXHcX8njgkdi01v/rINQ5CjTpJCKTNoS4d+3+TzizTwqJTlermuu97ZdVWOKw+8LiRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785262059; c=relaxed/simple;
	bh=3KfhASaePt7MA3rLgQDdHeZHQZxCrh9AOkNH3VvEKa8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mC0M19Ws7mTkUB1du/8jY9LXXU8vNj7Z6WxPywTvXqBqzCR6M9Mduq5opGtcEC6NUaYRiYn/wVl4B5fuWTeccTlXs0xGX+WNFXSvud9TpYm4XDJRpZSZMOqiwm5IoH1MY1bqD0UpVezsStr6SjY6tWZpBhmnim9mC5RfppLUMjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZY6xYpT7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZY6xYpT7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE80E1F00A3A;
	Tue, 28 Jul 2026 18:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785262057;
	bh=xfQDX/nv4wm6JHTC7nF4ASXlZXtXBxKeKJ8UR9OBYnc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZY6xYpT7kUHfJHlV9p5NTQ6qPf7fk5/zCvSnpOV57gYGaJkyHvSnkcWJ4/qEd/zi6
	 s9xN0e2FQYmBPE4GqmilWYXUbCEadZwX13Ym4gRHWFtiqmyzbObV8MdqZlEZUsLcMb
	 3XWggPKeXW6WS6DG/+gt0O8DMNti8X2Hta5TQBE1BspHKUjJe0pWlY0QJI+7t6/oAF
	 uwaMb4iW6tOIkzs1uUp4Z64xEtF7lrZ2FVes4/bbquyZimt5YR0176BGjJHgMPgXPn
	 GaoEpSXCyKDZhv148mtl4OZNMg1LpaB7BKfXlRf/GGbxlH6xuYROvV5aonvIBk9l7G
	 7mDm/sNGjVFdQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	David Ahern <dsahern@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Matthew Wilcox <willy@infradead.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/5] espintcp: Inline do_tcp_sendpages()
Date: Tue, 28 Jul 2026 14:07:30 -0400
Message-ID: <20260728180733.291798-2-sashal@kernel.org>
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

[ Upstream commit 7f8816ab4bae9dd42c5720fdad4b102532d4e43a ]

do_tcp_sendpages() is now just a small wrapper around tcp_sendmsg_locked(),
so inline it, allowing do_tcp_sendpages() to be removed.  This is part of
replacing ->sendpage() with a call to sendmsg() with MSG_SPLICE_PAGES set.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steffen Klassert <steffen.klassert@secunet.com>
cc: Herbert Xu <herbert@gondor.apana.org.au>
cc: David Ahern <dsahern@kernel.org>
cc: Jens Axboe <axboe@kernel.dk>
cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 007800408002 ("espintcp: use sk_msg_free_partial to fix partial send")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xfrm/espintcp.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/xfrm/espintcp.c b/net/xfrm/espintcp.c
index 02c967075690de..acb612bf829a5f 100644
--- a/net/xfrm/espintcp.c
+++ b/net/xfrm/espintcp.c
@@ -206,14 +206,16 @@ static int espintcp_sendskb_locked(struct sock *sk, struct espintcp_msg *emsg,
 static int espintcp_sendskmsg_locked(struct sock *sk,
 				     struct espintcp_msg *emsg, int flags)
 {
+	struct msghdr msghdr = { .msg_flags = flags | MSG_SPLICE_PAGES, };
 	struct sk_msg *skmsg = &emsg->skmsg;
 	struct scatterlist *sg;
 	int done = 0;
 	int ret;
 
-	flags |= MSG_SENDPAGE_NOTLAST;
+	msghdr.msg_flags |= MSG_SENDPAGE_NOTLAST;
 	sg = &skmsg->sg.data[skmsg->sg.start];
 	do {
+		struct bio_vec bvec;
 		size_t size = sg->length - emsg->offset;
 		int offset = sg->offset + emsg->offset;
 		struct page *p;
@@ -221,11 +223,13 @@ static int espintcp_sendskmsg_locked(struct sock *sk,
 		emsg->offset = 0;
 
 		if (sg_is_last(sg))
-			flags &= ~MSG_SENDPAGE_NOTLAST;
+			msghdr.msg_flags &= ~MSG_SENDPAGE_NOTLAST;
 
 		p = sg_page(sg);
 retry:
-		ret = do_tcp_sendpages(sk, p, offset, size, flags);
+		bvec_set_page(&bvec, p, size, offset);
+		iov_iter_bvec(&msghdr.msg_iter, ITER_SOURCE, &bvec, 1, size);
+		ret = tcp_sendmsg_locked(sk, &msghdr, size);
 		if (ret < 0) {
 			emsg->offset = offset - sg->offset;
 			skmsg->sg.start += done;
-- 
2.53.0

