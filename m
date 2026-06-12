Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDBA27281E;
	Fri, 12 Jun 2026 14:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781273507; cv=none; b=UQO/7UvBGud+HwGPbEFGHxC3AKRIbWcCML21MBKN7R4cOmjzzfXglB9CCEjHO8bf/f6JkN/OGlupjabtg1sohJvxVRLiPSpLK66D6N2IPpotl2gZwiIuPNe+fKp26K9nXiyI1oqMk4uRQ7GcSMDEvap2RRR0hD7C7doN8u72AKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781273507; c=relaxed/simple;
	bh=Df4fCoUdcVs0djnRvnPR6LDljKZzDQBUtAwHAx8rc+s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QSVQGXh+DmtV077rRMnIlBkVBbkJ2HRqzGw7jAwwLUnqRB7LC/1l3Rt0PdaKh5c6FRMO9ZFCxPSrgyvYuzp/QVFYCKudgqU0qUf25DQJUL12HLA7ySV8EopULPDFyfmzpqTB+MSceYNZOGMxcyDpdSQwiZ4MBRrwVP1LUYedgQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=ElouQG+G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WUr0fT8e; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="ElouQG+G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WUr0fT8e"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 31208EC01EA;
	Fri, 12 Jun 2026 10:11:43 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 12 Jun 2026 10:11:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1781273503; x=1781359903; bh=dEndtmW8Zt
	TMda7QIg6sF0vFVj4BGicCZFpkRK9VafY=; b=ElouQG+GIFDhOUBu3oBk3Px/MS
	V9EgwOfZSEplRumeb20VFnAJoSDjpWsC4kAdvc6+fpd07KlSYSnOERaUZ2N3VVqL
	YI/i703LM6fMTEcSBuI5zUd0ymGqf7kdYY9VSz9kWCnneGsg4hzWDb6/1Mt1fJyz
	P+mp6dev/slEH0s4yXTjfpeb30qvM5CmGiE04eHUKSldE2ZYYsUoVxTsj03zUfJ1
	xhDHKRCqXZtSbu7KH2a2B5KZTXXen6WeVxd8UGW70UuB4g+S8ikC3PkoFKGEoZvY
	Wii65cQnHN54GUfaC4HAiqUqadaQ+3flqdKN2NYP47VpnueBVtQIG36jmXxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781273503; x=1781359903; bh=dEndtmW8ZtTMda7QIg6sF0vFVj4BGicCZFp
	kRK9VafY=; b=WUr0fT8e5tgXVvapB9+/n1GD1CEwsxdkNBoNvscT3J3Tq0gdIYt
	Ww7tAKEMA1r7LFRxl6uPgAD1aLRUSaKpIUewTRGw4YGTA4QoCPCOJ2CEnNH8s7XI
	zvVHyzRqzIGRUtMjXB2SqXISCbbsBsrjieeaj9P2jtyOtEkfQhe5aY1GuGCTGULN
	gwayvtjnKCOITzXP0rtdeQtB1NgdlaYI45jYuei0jj8rkWKIdxjKDp+k+XPnNZYV
	7UXMfFMtNNnP2L9DMyDB7iVMGBgsFoh8KA7QbyDxsOIT8ogvXSn0DW8IxNG8859B
	xzJW3AnWDigbjBRnq8Kv+RNYlaRlgk3/4tg==
X-ME-Sender: <xms:nhMsamMNeYKrQzeUTQIWhDwgWG40H7gU0DagZwsvqAph6uKAmAH9pw>
    <xme:nhMsauQUw2RaZcKYOOwK4Or6IOMzFdXdTsNTJe5Jd9_1ibed_YGBXWHosevxntW7B
    U_fbBxSFf2XW0eES4L9_exf0CpEl5o3QnQvgs45sMQ6hO39uWO0cv0X>
X-ME-Received: <xmr:nhMsakiMeow-vYPlbmiqfVjM0ZI5IvYqMpSeL212ea59wrQfM_zp3ejEJfZaGJvpfC4P9oJCXyBiaogxGyj95HI>
X-ME-Proxy-Cause: dmFkZTFutu7fOSifSPdZiAkew9cmWxaMqNAh3g8o5NsOswDzwZRgs0NZ+oY17XNpHjSuA8
    RJeZpr7zwtEu1POda10jnW/hnR+L7fhsDtniyqd03iDU0sHf+Uh9sFXBw6CTQytn5u8LWt
    a+Jr7ZndpeMAAKvKoJVEkSAXMJtTow7qRyUvVBSv38AJQYAhqKRjz1tC73/yBzWDEgafZ9
    5c/I8rJqxwRX+ZMmmmkRyU89F55wFCwEQ2FSoy5MEq7VHOUxfUHALA63wlTSZroEQzBsAZ
    VyIITlsj4fT0/x95UjLmqzlGA0uJGihETw2m7XRu7XXo9LOjhXTN4qSXVe5L9Ji8X+mbQR
    MjWPl+MFxuyBdJkxBm8YP/YsywOqf80cXcqEWRCCAD3Cafh5GQtPQoDtM4/UaZLKc4HPUf
    TOJhMBmJg5iLSnboXSGbWPwGSzj8L0Zt3aLkOXZ6+SfO7XSVKf/1THfZkb0XqmDsh0Vz0N
    DgRuc5YtM9tSP/S1om2VHIMor9qRbR93e1U+iWOasyPG3uLIf9dG+Rk2D00kwTcakw7yxG
    /6OKiZZn6yJ+LAqbq3Eq9fDCvDj40X8EqfrMZRNU0ygjc8bCAK25epIwSlwEaD1geDSYMw
    sPckpfq1p6TdnflFWlpaKbKsFolTnsfGqZtlidV8SdJr5uYu9Lgp6i7GXB9g
X-ME-Proxy: <xmx:nhMsan-Jxjv9xc1-2RGi5ZFpKI-96cpA-1D_hz0sVXZGu6SPVFcvDw>
    <xmx:nhMsarEbLcRQ--gysMg3ccBj8vagembYgCo124xvqxxxKJet4-jlAA>
    <xmx:nhMsaqnUDxLeutwf4aWpIOVDZlwaDtj7GFr48plNuLMzNd_PcEdIxg>
    <xmx:nhMsavY93W7WbXBwpC-dOGHkoD0vUQoaZCOnA7mAdzRLLwfoWYHDMA>
    <xmx:nxMsatHStJf9Uvb0GBYccK0KpZnh9sOYhiG07CHxsJxM2nPyiZwazUY0>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jun 2026 10:11:42 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org,
	steffen.klassert@secunet.com
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	stable@vger.kernel.org,
	Aaron Esau <aaron1esau@gmail.com>,
	Yiming Qian <yimingqian591@gmail.com>
Subject: [PATCH ipsec] espintcp: use sk_msg_free_partial to fix partial send
Date: Fri, 12 Jun 2026 16:11:39 +0200
Message-ID: <68ef5bdae251f605b0743d2e51c2a5cb285e5772.1781270325.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sk_msg_free_partial() ensures consistency of the skmsg at every
iteration, without having to manually handle uncharges and offsets.
This simplifies the code, and fixes some bugs in skmsg accounting when
we don't send the full contents.

Cc: stable@vger.kernel.org
Fixes: e27cca96cd68 ("xfrm: add espintcp (RFC 8229)")
Reported-by: Aaron Esau <aaron1esau@gmail.com>
Reported-by: Yiming Qian <yimingqian591@gmail.com>
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/xfrm/espintcp.c | 34 +++++++---------------------------
 1 file changed, 7 insertions(+), 27 deletions(-)

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
2.54.0

