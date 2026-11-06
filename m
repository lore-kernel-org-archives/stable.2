Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793971437;
	b=gNw5KOx1Ehnw73IniwnJlOu06BUPVwvAjqhGDmUbRdDDs1wZrpTa1a7x2KTc/Ykx7eIc
	 5bGWkTXTmonseuTYyv/lqHF+dAva89OGKuQ5iGtk9pAJWtPMDN4SwswnTiecWsMTEIJ71
	 0QGzDK178LJLS3w8IaX5cZHZVrq+Hi2KhLim2WWpxj+qNGMFRNKEjeQnP3IYqoMsZguJj
	 fpr/X9R3BVWm+lZKlm9gMnK1bNF9xaVsVaFSw10ybn20tRrSBI9XVirdUNicVayDKxCnS
	 grvIIojPEDurKLHz2TxCRAAtPk+Cmpg/ldwq7FR5R4yplcRD1p9d5mO/HQE1t+OS/0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793971437;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=yT1MMikX41hpCPzVOrm6lII/X4LsjhWGt6txQHra6u4=;
	b=WseTAcHpY7KY6tIPEvkyorEKEsGL4K8csrjQQUkC+y11AfiQR/qOMHQUNv/hgqVmQodV
	 2TEGa9Lj/k0G7IqXaD5CKDHXPVzo2YitDwNBFoHHNuoNysdqCCSkCwAqu+iHcwNOn7egA
	 Q3NNb0qtOrKyasN1wgsGp0HBmPOaH67TkyP98IxJxbtxCrQpoY/AYlvl5kiWk5xMST0R5
	 xZDXHumo/wX3HWTYGxILaIdoOBQsR0R4DSa2xBfbMjmwQTb7GiSLI4TMlrnulxuVqQ598
	 9+pL/49qmcKDvgt53w5FIgKR3crfqjNOoClXAW3SS75EnT7Bfz+yMu/Tvf4gaEIx76Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CWtVLB6G;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E76D606A331
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 13:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CWtVLB6G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59CA81F008A6;
	Fri,  6 Nov 2026 13:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793971436;
	bh=yT1MMikX41hpCPzVOrm6lII/X4LsjhWGt6txQHra6u4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CWtVLB6GVA5rYU4excEXjtqR3qkAThErMr65JqifMcIWFgqfTje2+LswWN/kgAgJw
	 mBbTc2VObxpIwqQfKuSgXxBHRCuldj2DT4DoQtgyY2Ypdj0zg58ZE0kpihJhdaZ3Tk
	 MNxv5WI5kBotxuqzZLbcCrppAo1kKNLeL4hBFypp37T43UEB7C3SMnAcmqiPmPL/0O
	 AgypNfyGDwI4ZuiJcGUYuAei3ftf4O9gBKGzi+lUo/Ia0rA7BzGO9ig1HvNoaaUeiR
	 VTOuHAdy8V9VFrOg2XVPlCTeaQxhy/LQq0YmYxGPTJ6Rt4p4jOVWL3ZtEYm/TCv1AA
	 f4sJyjabnwXUw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
	Chuck Lever <cel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] SUNRPC: fix oversized GSS proxy token copy
Date: Fri,  6 Nov 2026 08:23:55 -0500
Message-ID: <20261106132301.15748-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110400-mop-submersed-f16f@gregkh>
References: <2026110400-mop-submersed-f16f@gregkh>
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
[ sashal: adapted xdr stream pointer and length access to argv->iov_base and argv->iov_len ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/auth_gss/svcauth_gss.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index 8beca18863907..0468b9f0163fb 100644
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

