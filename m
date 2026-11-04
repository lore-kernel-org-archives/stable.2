Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793819253;
	b=hxPJMXJyl0Ogvpb00//S1Lqj/TOyA2RvX09vnBheQwPn76MSqjDBS8nzM1Lf5yiK0u8Y
	 vMMxGPFk10K6n15hBvl301sBiqlD1kz6oVKHs71hzPEqrvvAkTSz//aB64IwT7MdEuDFf
	 VuQ4aQ/bl/VS6ekP8RCzvqU0ugdxrRIFUXofWSGmUYgTQDKJK6qK6/sGJ5OcVx2iw2aWH
	 l1BW69epm+ahU2lmmFIm9RlrHu1kHVeVc6Ft/fUZ8Mc+guElNv7kkmmsfcIqJXkNOAz4D
	 W/bmf0Ig3x4zjbkvtbw/tm3+wz3OeUbOWjWB2ciz2jln+pNNuxyrDUhWNdKAKWtzV7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793819253;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Y57aBDo0Lcp/sD6sIeS397UHboxmL2eb3Nll/0RuwX4=;
	b=GHku8H6vMeukOQyTS+BJlyjjRgfCX/8xNC1g573IiAMDEqMjkxOcMKv/MpIbWi22RPKl
	 nXLeMvVFsnJd0qSZcKXnK9beb7gloEhvFnqEjb8ZDgJseqw0Tvt/BdQ/vsdBrSmkmS6Pv
	 q+bA42iPIKpNNRXUkNkX8OYaFI28Zc8U5CgQvrEOzd/afQ56H/lpj7m6BUMsnFdqJxHpE
	 26ehoJVmgN673A2GrIZ5VegXubfNxsArBzytdL21R0zoo10gjFBxkjJs+V2FLAxja2gUb
	 xLjyhA5AakrcGBOUB/460gjhDA6Gpv0TkzxdenK5XHN2IzRoYZD2ATqzDGAcosnuhHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=JrYUnRfv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2C2606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 19:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=JrYUnRfv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF7811F000C1;
	Wed,  4 Nov 2026 19:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793819253;
	bh=Y57aBDo0Lcp/sD6sIeS397UHboxmL2eb3Nll/0RuwX4=;
	h=Subject:To:Cc:From:Date;
	b=JrYUnRfv+O9nrevfgsymIFDaaGhCkIHRPZMjhwAYyC/FJ9XDJi9nLixyhGNglMqP1
	 QzllGjIs3q7WD6ZW7VhMNxRIhcoZuFkDVbxcZIHCIanSNJeiTuQyF1+iYN2pHq416R
	 x3sTrVlYzA1QcIbofkPv1KSh7y6W+uOMNlr45xCM=
Subject: FAILED: patch "[PATCH] SUNRPC: fix oversized GSS proxy token copy" failed to apply to 5.10-stable tree
To: Jeremy.Jean@oss.cyber.gouv.fr,cel@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 14:06:01 -0500
Message-ID: <2026110401-ranting-untimed-faa6@gregkh>
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


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 62319c2534b603b416fa2aa2f3ef18c311f75010
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110401-ranting-untimed-faa6@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

