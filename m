Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AE437EFFB
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 02:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785292214; cv=none; b=h+TAiQUc/WLeQTXDOvav2k85IXsfAjUPGFh0nhT1bPKtMClGtFWn+mdXwv4op0hb+kMDk3o5ylGAQrqw+ao2DLg1YVUyRkjwvUjjPuynw1R8I6j2taj63we/PIDlTpHrPPnAoGNxPR/XGdEMngpqIc/tGlwdVDmWku9TXI7vlpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785292214; c=relaxed/simple;
	bh=RIh1bRGPVnpheIztXqEmNU0dJPpaYsGX329j5X0Q4HM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kN6P8Kbtu4pYyrBJfHSe6AYdq54an/a0icKYNoFVKbA6IFARt7yvkG121FZMSxVC0EcaYIkakirmfyB2Qztia952WaubD/lURNyo28BdQ5W4DP5pkaLF8n5qysfhHdq0AN51o30Jre0rUbxPlDPd5hmE9wuP4dx091MlmC02JQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=magvJZlY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="magvJZlY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47BE11F00A3A;
	Wed, 29 Jul 2026 02:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785292212;
	bh=lbXziBzLEdFqRG3WZ1aop9MvPfVchff39dMRiIWuWGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=magvJZlYHUt2trwXJ7G/uz04nagWPKl8XZdy1kRs+AZK3NMKHW/bbcMJlKoJ4Lk3k
	 Krk8PmfQ+QKJsEfcciJyWMMblc58XgW7sPt/ravy8mlYMPu435GDfZdeFrf3hQpOJw
	 38GMpqEt72buGPAhpYpLP3SfNrb7AToGAoOfs+JDLg7AuUa07nPPTsRjod0+Z83cUv
	 9SN7fK3FmljAXk9mIivubni0jzSucL2Gbp4/7bnMnxm0vz8JfHqhuVtnrB/tb+5CGF
	 fHA3+8ZFdoo1LOidrb5I3Y62Y/n/2C1GUdQ/B83cLNOxNdBdaiHZJHuY0K31pTOeAa
	 8LLk/4QBXhDJA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Aaron Esau <aaron1esau@gmail.com>,
	Yiming Qian <yimingqian591@gmail.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] espintcp: use sk_msg_free_partial to fix partial send
Date: Tue, 28 Jul 2026 22:30:10 -0400
Message-ID: <20260729023010.1113752-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072138-zap-unified-4af3@gregkh>
References: <2026072138-zap-unified-4af3@gregkh>
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
index 2ee078156ded7f..6fb89a83d36348 100644
--- a/net/xfrm/espintcp.c
+++ b/net/xfrm/espintcp.c
@@ -208,41 +208,21 @@ static int espintcp_sendskmsg_locked(struct sock *sk,
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

