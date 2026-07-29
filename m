Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B5A1F418F
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 00:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785285042; cv=none; b=NLlFVnR3McKY9ExIJiZ9+glw+9mGuls0HFQExMpQp2+Sk2sCKcoiIgjAC++aEiMRrc2+yfCZXzV5opuSSm/ISBrhwYGyIcQmdLA7w+wpkUy6aT/bqxd0EaCLubfY02NQuzxq0W2uPdvAptX0QmJxnZQpeeFfYOm4yKiCqsGMIvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785285042; c=relaxed/simple;
	bh=rNMENhDssuTI+YLsG66fEo5eqgWIm4qhrBfWdZ8PBm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jyN1S+D+LkhcSUj7iyShc3FbCZzE6dPI60yZ0AVWtmRgII88qwEOk6rO7WqDOKmsURZaqTb2a2e/6yllSf+xviEMlAGCkr+83nQx1n6PWFTbdQcyuqFpD4ZQQeBAFKjMZJs3OrY84bJ5SwJ+rzAHeVUOT+9VfudKvXN88Ivzv6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=niiWdGaz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="niiWdGaz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE0BE1F000E9;
	Wed, 29 Jul 2026 00:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785285040;
	bh=ThKmO/5ZmKqJ7YPgr6/OPEMjEgBFXIDFQOBdlPA40sI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=niiWdGazy3bKFZ0EMcsnTv7cUjcAVtIgRJU3qQPAwbhCBiZ/wxez/xr2MZOlIjl8k
	 ex5RMDa/2vwbh5lDXN6YMcdoj4382cEcAX/s7zCT7h3H7W76cUA49MhNYeRhPNvlHn
	 14n+mRUYzV/AaO6XSf4E7mLHeIzigv4jEH01zp6aGSTaESOfczlPZJpamLSD7RPsnO
	 Yx7BIC7wvg5OvnRrG9DuhCm7GWbuCWFVMwmdS0I0bWGabZtvM6wmtAvOFLKiu965SY
	 pRbMkYhl/pTL0o39r3CN8QFDgwR4db703cx6Dao+C7DsOWej4v6Bv6ZLb5oTNYvxQ4
	 XX6tywu/PzY8g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Aaron Esau <aaron1esau@gmail.com>,
	Yiming Qian <yimingqian591@gmail.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] espintcp: use sk_msg_free_partial to fix partial send
Date: Tue, 28 Jul 2026 20:30:38 -0400
Message-ID: <20260729003038.888183-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072137-enhance-unrushed-b170@gregkh>
References: <2026072137-enhance-unrushed-b170@gregkh>
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
 net/xfrm/espintcp.c | 32 ++++++--------------------------
 1 file changed, 6 insertions(+), 26 deletions(-)

diff --git a/net/xfrm/espintcp.c b/net/xfrm/espintcp.c
index 8b41f865483239..59247f0bd4e7ec 100644
--- a/net/xfrm/espintcp.c
+++ b/net/xfrm/espintcp.c
@@ -210,41 +210,21 @@ static int espintcp_sendskmsg_locked(struct sock *sk,
 {
 	struct sk_msg *skmsg = &emsg->skmsg;
 	struct scatterlist *sg;
-	int done = 0;
 	int ret;
 
 	flags |= MSG_SENDPAGE_NOTLAST;
-	sg = &skmsg->sg.data[skmsg->sg.start];
 	do {
-		size_t size = sg->length - emsg->offset;
-		int offset = sg->offset + emsg->offset;
-		struct page *p;
-
-		emsg->offset = 0;
-
+		sg = &skmsg->sg.data[skmsg->sg.start];
 		if (sg_is_last(sg))
 			flags &= ~MSG_SENDPAGE_NOTLAST;
 
-		p = sg_page(sg);
-retry:
-		ret = do_tcp_sendpages(sk, p, offset, size, flags);
-		if (ret < 0) {
-			emsg->offset = offset - sg->offset;
-			skmsg->sg.start += done;
+		ret = do_tcp_sendpages(sk, sg_page(sg), sg->offset,
+				       sg->length, flags);
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

