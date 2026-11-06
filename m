Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793968641;
	b=NobYR0yB/VvxAlbS31jU1ho2lrjYHfwEFBQSLBCSe7TF30FWGz74oV0itm8EJqHw75Mo
	 W0+1JDFESR9QCrs9dJxcWIPIJi7Gfr1MxOM2spxOX1H7TVkRdTLVnnWeHexqVpOu4K/pO
	 kiUZckhHBzY05t5WiJmCWB+lozvr1BVj5YCRttnymMyOA7IMQBG34Pa3Eupstft7BXaRO
	 w03JdGjfwreGLfqXfwkl3Nh6hx4vg2cmLp61OB9WwfdGxG+7545huhN900pWLeU4IFSaw
	 +5A818ujIvp1H6bhizNLOvPxmr56hqFGmsKBS33AnC6RbcEt5WPikNz0WC8FompQxPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793968641;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=2dGGlSXNBorbkOQQarsxYiA2O+ffHRuNYcrzHDoLJFI=;
	b=D1GIxt5lCvPzVjV7S56oWJVWO9Mp59AeDqlbnhfpR/QKisH5Uso2ekj3w/yH2+apXKpp
	 3O4ZC19gvE+9Li+d+kZBnvARz7Y+/9EmsEpBYODtpf77Lv9KXLXLNzDa0zP9wrpaPuce7
	 HHT72IChsgyF7G7C0vwmCOfN0p7VOirjTNbh6zzzD4p8sLkvSRNZxatp0cCRODaGNjIV4
	 HdwYzzEI49iKU7y/STKfSs/qo97bvtTpjeLD3fZmqruHDXYb2PrTxtIgY2GplABuaFlRZ
	 feG/y22Gp7Sm2ABN4YJ2JEcdLvQT5p2X+JUTiHeKpgAPJaf3C7lSc4RhXi8cvvULByQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bJh+7Awc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488FD606A329
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 12:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bJh+7Awc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3ABD1F0089F;
	Fri,  6 Nov 2026 12:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793968641;
	bh=2dGGlSXNBorbkOQQarsxYiA2O+ffHRuNYcrzHDoLJFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bJh+7AwcgcpKB6vP18bZUPgTKc5cfKSSqmWHryiFeCbTUN91CzxsPFqLdXVoLyEhO
	 +poIqm3beNEy2PArl/1GhrBqI6wQp7v6qnsgulRkQV67LiW3qB/focumNeuHvfmen3
	 2a7MKbh/CpPQvch3cRlGSHYf0hSauQg5W0cKwutMKrbPqxIQyUGL32BasSo2zeJh0E
	 +yPFdNCXv5fF1zYOp0FHKKM/0w59woi4Yt288IqjiBcs2bYMlAj9X+beEvwcBO+CKP
	 WklI4hM5OD6xbYDF9qgdpQjF2ZntRamY5AFRLTe4XdVp9djuvTKramw4vdiP0LJH7n
	 pQ3Yh3v/NQgqA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
	Chuck Lever <cel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] SUNRPC: fix oversized GSS proxy token copy
Date: Fri,  6 Nov 2026 07:37:19 -0500
Message-ID: <20261106123637.3943891-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110459-ammonia-provoking-6551@gregkh>
References: <2026110459-ammonia-provoking-6551@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>

[ Upstream commit 62319c2534b603b416fa2aa2f3ef18c311f75010 ]

gss_read_proxy_verf() allocates one page per token chunk, but it copies the
entire linear head of an RPC request into in_token->pages[0]. A UDP datagram
can leave more than PAGE_SIZE bytes in the linear head, so a large
RPCSEC_GSS INIT token overwrites following pages.

Copy the linear head in page-sized chunks before switching to the request
page array. The linear head itself can span multiple pages.

Fixes: 5866efa8cbfb ("SUNRPC: Fix svcauth_gss_proxy_init()")
Cc: stable@vger.kernel.org
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Assisted-by: Codex:gpt-5
Link: https://patch.msgid.link/20260910125120.3798995-1-Jeremy.Jean@oss.cyber.gouv.fr
Signed-off-by: Chuck Lever <cel@kernel.org>
[ sashal: adapted XDR stream cursor access to the existing argv->iov_base and argv->iov_len fields. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/auth_gss/svcauth_gss.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index 01b49960915b4..5ae15e3b40094 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -1185,10 +1185,11 @@ static int gss_read_proxy_verf(struct svc_rqst *rqstp,
 	}
 
 	length = min_t(unsigned int, inlen, argv->iov_len);
-	if (length)
-		memcpy(page_address(in_token->pages[0]), argv->iov_base, length);
+	for (to_offs = 0; to_offs < length; to_offs += PAGE_SIZE)
+		memcpy(page_address(in_token->pages[to_offs >> PAGE_SHIFT]),
+		       (char *)argv->iov_base + to_offs,
+		       min_t(unsigned int, length - to_offs, PAGE_SIZE));
 	inlen -= length;
-
 	to_offs = length;
 	from_offs = rqstp->rq_arg.page_base;
 	while (inlen) {
-- 
2.53.0

