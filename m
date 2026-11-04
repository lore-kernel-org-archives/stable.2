Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793819252;
	b=mtTUIVwGRsRTuP+aBuv0NcZogwYHXcuk0gxYUAY52/vpJqLs5KgVW1kTK1/I86gp3XDS
	 H8RBlQ/NnDEWP9G4yeg8eUh7JUbOEaW0bzmBz9+WC2chq4NqN21NEy1L3GiWDb+cU0U6J
	 agFHLpcQ1fQObTilLSyJvIba5pw4YHtxc4FjQXYMcCaSpU+KY65tmOwNPNE6p+aorD0dw
	 xjR+IRgRVq+lz8At4Kxv3chd7SaI+8H2ZKjkzrFPUmcyvS3Q5SoKZjN1piP5s36fDek4y
	 6/yxp2qMPOnX1yyq9l2tSI6xqob3ZxGWckpTJBjE1fOZJiLq7VgdWi9K6XvMKZFylXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793819252;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=SY0CXH5xQDRXBxXhU6hHF34lNSoNbi3SnpQN2a3h8o8=;
	b=5IHf/HgISqTN/D1nBBegJdPSY+iCmM32NVNuUZfSGB+AC3agJNGWpXwe/yXTqFcB4aMj
	 HeQS4K8YnhBvqMWYorMw1pvafETlenGv1unOJTch+0P+9ki0tOhGB8pme/PDhl7XblPv9
	 Igyq1BR/oHrUnYxGV5uvjybpNyeMF3tSEWjZVmFzdIE9jwJ1ObRG6PNBPFjkxsFzYES8y
	 bg3YZkFcdmbdsEi1tQxhPTiBrM1yELqm03bKpGWI2jV5k5PGvZdjCjsYWdjda48R5PR3M
	 WSXdhqXT8hRk3seOa9hWjBP2dxiLX5ehiT02NBkNaf9cXgTlEYwh5Th/JqdLrwGWOzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=bVhqqXA2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9697606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 19:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=bVhqqXA2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 881FF1F000C1;
	Wed,  4 Nov 2026 19:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793819251;
	bh=SY0CXH5xQDRXBxXhU6hHF34lNSoNbi3SnpQN2a3h8o8=;
	h=Subject:To:Cc:From:Date;
	b=bVhqqXA2yv1MJlr1hBuWw9j0zAWP/i4aOJ2+2+CbhvWYPisxGrw2tb6hByadL7ZmS
	 HUPTAIkpxMh0Dfg7DD9XRPrHLJmsyZC9gWVk9EV5izav5jgEWGrJQTQvwXfV1JaCEa
	 JhRkSoMyvDvq3FE+763kdOMEYKm9ivApBhAOVSec=
Subject: FAILED: patch "[PATCH] SUNRPC: fix oversized GSS proxy token copy" failed to apply to 6.1-stable tree
To: Jeremy.Jean@oss.cyber.gouv.fr,cel@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 14:06:00 -0500
Message-ID: <2026110459-ammonia-provoking-6551@gregkh>
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


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 62319c2534b603b416fa2aa2f3ef18c311f75010
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110459-ammonia-provoking-6551@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 62319c2534b603b416fa2aa2f3ef18c311f75010 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
Date: Thu, 10 Sep 2026 12:51:20 +0000
Subject: [PATCH] SUNRPC: fix oversized GSS proxy token copy
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index 563576764ca1..b319c4423d78 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -1085,10 +1085,11 @@ static int gss_read_proxy_verf(struct svc_rqst *rqstp,
 	}
 
 	length = min_t(unsigned int, inlen, (char *)xdr->end - (char *)xdr->p);
-	if (length)
-		memcpy(page_address(in_token->pages[0]), xdr->p, length);
+	for (to_offs = 0; to_offs < length; to_offs += PAGE_SIZE)
+		memcpy(page_address(in_token->pages[to_offs >> PAGE_SHIFT]),
+		       (char *)xdr->p + to_offs,
+		       min_t(unsigned int, length - to_offs, PAGE_SIZE));
 	inlen -= length;
-
 	to_offs = length;
 	from_offs = rqstp->rq_arg.page_base;
 	while (inlen) {

