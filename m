Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793974442;
	b=gPAlvXtKikxyDQkvJEM8pfERtHfogM4/QbapTqd4HRQ84nxT86LenX4joD7hDVkLQqNg
	 JFjumO5hOJnAy2rDKCBHNQUBh58oP9NS1tBNQjpuLUXSxgg04v6bxMbJjU97u8DDJ7flf
	 qfzSOI/jGvWJULVCHqFL89JHH5gBcpi2It/BfGAelyIP4SE9IBwnYx5MdKVBJbsjkJTK6
	 SBbBeNeGSyKZxedJy7C6Yt8PX8R5zErqbLe/tg4rpfQgzw0Oz0+KVRn35rkf1GRJFPREj
	 kdZ/4WZFd5di7yiNXLUA0XbavzCFykmvaGNZkcozl5qKZF/lhgsHH66lbtRPSaTsdXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793974442;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=44SsE/9iYJWI+80sT2EB2TsgJX0RhDrAshfrHbZKawg=;
	b=OHpxvxMnHVlesAT90vo0WVrYiVVo2ADY6kfPLsUD16x152HBF2/Au3SV3I1vpFHzfngc
	 sirmrzJjYArFP8JqCgJWWk1tNLKOqgK95DN+BQcZeecmvVuBQwdrONcLj2/1ZbbprFcCi
	 7EYA4DlI8QTn8wJSGWYCiYxTtvkNGnBk4DdMyLZO3hBQ5xZ+E1mOB6EWgK1nJmMlAzaZz
	 MZRyGdDxh47GAVtUaxTkQKnCqlZpu2523XzvkASILwf/+q5ySYTMXdp5yJU6H67wZMwYL
	 SCL+20OpBfii0qV/UyHRGVXznJDKzhpY4eriMFWgwtoG+wddgA40qKqJGmuvmro0fvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q+miJQyG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57149606A336
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 14:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q+miJQyG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 698801F008A1;
	Fri,  6 Nov 2026 14:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793974441;
	bh=44SsE/9iYJWI+80sT2EB2TsgJX0RhDrAshfrHbZKawg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q+miJQyGVFUMg2IxEQP+lt1D3O+JFeHfogyb0Ddidk67RBlMnMvThEQ1H/32x/KaB
	 jFOTEUJeQqNLsENu0mL7wWxyzGUzU/qjh3FGA6nBU6bRAyND0dWseUkbBJ2zMjd7LQ
	 ITnsndcxYkyfzq3CyWqLvxmppPCGhioa02kSCcDtRcZT9uU+cXkEPwdaIPLaPP/RaO
	 93uz8M9jPeHYFGfMnEP0fle7h8lgSeJlIBmpgL+KKEXWv9u0UB+xEv+jhaKOR2PX5T
	 6SZ6Af0SgMBFlGLGY3MzlKCGLD0qNqFDc+iLsE6oX2FKIiDMmco0jIYUMxwNiTqZ/y
	 hqkIpnFenwVWg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
	Chuck Lever <cel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] SUNRPC: fix oversized GSS proxy token copy
Date: Fri,  6 Nov 2026 09:14:00 -0500
Message-ID: <20261106141259.246945-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110401-ranting-untimed-faa6@gregkh>
References: <2026110401-ranting-untimed-faa6@gregkh>
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
[ sashal: adapted the copy source and length calculation to argv->iov_base and argv->iov_len instead of XDR stream pointers ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/auth_gss/svcauth_gss.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index ab99ffb464ffa..8ebebbdef911d 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -1183,10 +1183,11 @@ static int gss_read_proxy_verf(struct svc_rqst *rqstp,
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

