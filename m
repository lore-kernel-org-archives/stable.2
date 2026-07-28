Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AA53BE16E
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 18:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785262063; cv=none; b=qPZn2KQDP5zr693Y/lolj/wyPFPuiakrsOgpZRE3dMvnGYHXom/p3DiIax2rvPbEWseZYZKDA6tB1DFvGNaCL7sGZIvIt5Xc+GYGepWgIqqgg0y3SjvtK6gLhcXV1pnFN2t54wMJ/pLRXm7JpfYGPcEHrDx6P5ln8xdDewWbaX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785262063; c=relaxed/simple;
	bh=F23HKpisv+AHrfs8iNxu2Z5k7tIVIrN+82/IUiOd7rQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z425ATykbFjnuUKUotKMpmu3NA+VSEwbrLZ8SBDp2ccfnKIJI4MEAofDmvWb8Ry+y2jJHx2gQSNb4C1xV2nQuGJ6sg2hqy22enMCqLf0YvFpjffqtJZainQJc2e5hQUDEzoU8sIobXR4rxLh+0pYY/9YwVeG7BSzTGOpUX61FQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EmvwbkLD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EmvwbkLD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD7F11F000E9;
	Tue, 28 Jul 2026 18:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785262062;
	bh=6nNre4QXTWpu7nxcpUtYhZWZr6HnFjFJCvdoYMjI1x4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EmvwbkLD9mlbhIQQdHQZkIM3ld3UHlKcS6LrGiQBHVtNn00VSBkYxataH8WpDtVF1
	 CfFFbAfZRIvIkQVOycjNmM/A+ixn6Jxd16qSJIZkL4OGou91V0cmEiiYxWBS9b6S3M
	 KdDOaFkiuJVKD9QDdejjhIdhEZ7HyhIlU4Dl0K0Z/fmMlfp9VvIrM2umjOE0Sl8zSQ
	 ueKz/OGaPez75ZODvuc/RTIgvaM3p21VPX9hYSXse+q+anY6AcT7fKF4q8uAGxYDW+
	 l82r7ozQSpkkEhN7ZAksTWTb0qScyUQwit40G8+F3OZLZt6CukEMPaXFVl6DWARdMy
	 CyLiiJO8WE6UA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Aaron Esau <aaron1esau@gmail.com>,
	Yiming Qian <yimingqian591@gmail.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 5/5] espintcp: use sk_msg_free_partial to fix partial send
Date: Tue, 28 Jul 2026 14:07:33 -0400
Message-ID: <20260728180733.291798-5-sashal@kernel.org>
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

From: Sabrina Dubroca <sd@queasysnail.net>

[ Upstream commit 007800408002d871f5699bdb944f985896730b8f ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xfrm/espintcp.c | 34 +++++++---------------------------
 1 file changed, 7 insertions(+), 27 deletions(-)

diff --git a/net/xfrm/espintcp.c b/net/xfrm/espintcp.c
index c6b2f71f42c021..39a78e5325476d 100644
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
-
-		if (ret != size) {
-			offset += ret;
-			size -= ret;
-			goto retry;
-		}
 
-		done++;
-		put_page(p);
-		sk_mem_uncharge(sk, sg->length);
-		sg = sg_next(sg);
-	} while (sg);
+		sk_msg_free_partial(sk, skmsg, ret);
+	} while (skmsg->sg.size);
 
 	memset(emsg, 0, sizeof(*emsg));
 
-- 
2.53.0

