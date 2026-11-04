Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793819250;
	b=ebyt1AWXb5z42ZzPunrftuCj/Sh2fa84WWaIOtfDwzoqiVK8VsQzViwnoR/K35IteaiX
	 8f471I4K1lspK6puCzFof0T1kUcdp2A/ePEmbIB8x+0wEmONa64vhhT76UQshRhftiazQ
	 5lz+E0/ZeKuZMQL1bZcFURtnOUNo7UKeLbLRU8UZD82v4wpfGGWuLnnvIDPRpkUytWCkm
	 76Ot943ZJYZ1ODcZn3Lu+SjzfOZ+1aWJZxU8ZTW9je1j3+Q15KzkMNizBnxI48dTnWyjG
	 s1BgSCz705lm8De7iXbeEQ4rpIYLjSEXXSs7WxWJDMFdxZ8oKHO74/LjavuZ7zrDnZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793819250;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=pNUheKC3tfNo/pXQ+n4el1EjNUek3VEY5ttn2kWBzbs=;
	b=SbN3Yx7kI+FKRX7KFPhOyPXgVizglo/55DaAWVpyI0rO4q9cyAdV2BVvynxysJaj0gkx
	 B3eg+AOT6ZtdxnjgsfNs6TbbJ6S/yQvWV+W2KVxWingHx+LcuvMVK/EzD+jNVBEwtAOsn
	 G1mZUdKS2IeLZJggcZNJ4HMbpL8S08VpcCKMv6By/0W+AOrl6dJByVSka4AJhoyKuhAKT
	 /WIewURxr3a9sQ3NwZqA86KFqKBuMu4SuBMsbchYkWh4VK+R8yOzf2TIdjb5mAISz6bGG
	 V8fGEP+5WCrX5w4N31ZFtgl8YZ4plckoWZlv5xryGm+ri2idspR/GO94VDoVrU4J0pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="s7zAZ/GD";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C275606A32C
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 19:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=s7zAZ/GD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA7E1F000C1;
	Wed,  4 Nov 2026 19:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793819250;
	bh=pNUheKC3tfNo/pXQ+n4el1EjNUek3VEY5ttn2kWBzbs=;
	h=Subject:To:Cc:From:Date;
	b=s7zAZ/GDmPZE0znewLjS43D/BVglBUfNo8GinIGO+BuIxXuaN8SnSAc3Uxh5GYN9y
	 nQnBSr6iuURS3F8wEuFa0Z5OWJBMRdidKTFCJFhwyiZzgJ3KLHlqz/arLItYrbqKXO
	 R7kYPy3SNZhE6mhpf9u9nOKIhGpkG7VXN7YOUswk=
Subject: FAILED: patch "[PATCH] SUNRPC: fix oversized GSS proxy token copy" failed to apply to 5.15-stable tree
To: Jeremy.Jean@oss.cyber.gouv.fr,cel@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 14:06:00 -0500
Message-ID: <2026110400-mop-submersed-f16f@gregkh>
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 62319c2534b603b416fa2aa2f3ef18c311f75010
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110400-mop-submersed-f16f@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

