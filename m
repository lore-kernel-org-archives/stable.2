Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A96B3BE162
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 08:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784623370; cv=none; b=Sy6xVSZRxFmygg18mfOwcwoSCiQxoq+rjvl9aW3FujHWoRyZ6hXYzqkz8X2xEw+iRjg4ubRya6tmVrbiBaGprVI6xJxtc+/p7eVk5xsCwRWZBb6XFaBHPpvV7rtWQkXG+ASuQgo843fH/dpIjIT4XcTXa9a/pGbr6aTu7iS2HPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784623370; c=relaxed/simple;
	bh=0DSiFUVqmO1mqFKufc7P2fPhFk8iQp+HbbTrXyntsBk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=raZUxS3H09ljKc3ZFr48IYWPUlgbysktvmk+HFTbYA7Cl8T8ctdSQ4Z08yI2eejHXpZKXu4XT1ozdND1GD3GSifyJdNvdrx49dd7BVr6hi0nEuNaiiqXVf9S526H4CAU+TT2lMUXikodSaJr6AMGu9sAnsm97n0eUjlhRLfqdCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lkgQoiIT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lkgQoiIT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82B7A1F00A3A;
	Tue, 21 Jul 2026 08:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784623367;
	bh=qXswNSYxXib5ydFZVWp0xc4X8n44ZzbAHCEbFuLjwgQ=;
	h=Subject:To:Cc:From:Date;
	b=lkgQoiITskTnymqZooBGBlf7bv9TcWF33eGbJxyZMrpbDfiff8Heu8zv6PX2TFh/4
	 XOqVKEOOE96ivIZfrNszgeX9Hz72M5gBg65Z1uV6udvCQeBWIMwBRf84tdvxfKmZ+O
	 uAZd16tpIH4TblNmtpg46OaSPJcI8TL+e6PVLS+k=
Subject: FAILED: patch "[PATCH] espintcp: use sk_msg_free_partial to fix partial send" failed to apply to 6.1-stable tree
To: sd@queasysnail.net,aaron1esau@gmail.com,steffen.klassert@secunet.com,yimingqian591@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 21 Jul 2026 10:42:37 +0200
Message-ID: <2026072137-hatred-autograph-0bbe@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 007800408002d871f5699bdb944f985896730b8f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072137-hatred-autograph-0bbe@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 007800408002d871f5699bdb944f985896730b8f Mon Sep 17 00:00:00 2001
From: Sabrina Dubroca <sd@queasysnail.net>
Date: Fri, 12 Jun 2026 16:11:39 +0200
Subject: [PATCH] espintcp: use sk_msg_free_partial to fix partial send

sk_msg_free_partial() ensures consistency of the skmsg at every
iteration, without having to manually handle uncharges and offsets.
This simplifies the code, and fixes some bugs in skmsg accounting when
we don't send the full contents.

Cc: stable@vger.kernel.org
Fixes: e27cca96cd68 ("xfrm: add espintcp (RFC 8229)")
Reported-by: Aaron Esau <aaron1esau@gmail.com>
Reported-by: Yiming Qian <yimingqian591@gmail.com>
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>

diff --git a/net/xfrm/espintcp.c b/net/xfrm/espintcp.c
index d9035546375e..374e1b964438 100644
--- a/net/xfrm/espintcp.c
+++ b/net/xfrm/espintcp.c
@@ -212,43 +212,23 @@ static int espintcp_sendskmsg_locked(struct sock *sk,
 	struct sk_msg *skmsg = &emsg->skmsg;
 	bool more = flags & MSG_MORE;
 	struct scatterlist *sg;
-	int done = 0;
 	int ret;
 
-	sg = &skmsg->sg.data[skmsg->sg.start];
 	do {
 		struct bio_vec bvec;
-		size_t size = sg->length - emsg->offset;
-		int offset = sg->offset + emsg->offset;
-		struct page *p;
-
-		emsg->offset = 0;
 
+		sg = &skmsg->sg.data[skmsg->sg.start];
 		if (sg_is_last(sg) && !more)
 			msghdr.msg_flags &= ~MSG_MORE;
 
-		p = sg_page(sg);
-retry:
-		bvec_set_page(&bvec, p, size, offset);
-		iov_iter_bvec(&msghdr.msg_iter, ITER_SOURCE, &bvec, 1, size);
-		ret = tcp_sendmsg_locked(sk, &msghdr, size);
-		if (ret < 0) {
-			emsg->offset = offset - sg->offset;
-			skmsg->sg.start += done;
+		bvec_set_page(&bvec, sg_page(sg), sg->length, sg->offset);
+		iov_iter_bvec(&msghdr.msg_iter, ITER_SOURCE, &bvec, 1, sg->length);
+		ret = tcp_sendmsg_locked(sk, &msghdr, sg->length);
+		if (ret < 0)
 			return ret;
-		}
 
-		if (ret != size) {
-			offset += ret;
-			size -= ret;
-			goto retry;
-		}
-
-		done++;
-		put_page(p);
-		sk_mem_uncharge(sk, sg->length);
-		sg = sg_next(sg);
-	} while (sg);
+		sk_msg_free_partial(sk, skmsg, ret);
+	} while (skmsg->sg.size);
 
 	memset(emsg, 0, sizeof(*emsg));
 

