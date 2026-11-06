Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793929993;
	b=Kvv16IgaXjxr7gRFcDJLyg0PussYiIMCCshLRcsT+qOPYAQyUTamLxrmgRBPimlPNzSE
	 6lpT23A0yYOukJg5WIRo0M8wh/yUSXXyvVGwVUvwN0KHObxSGRw5FnFAe5lacpFIjZcyn
	 6U1dkTmTO6DAvB7NGR5+EyPGqxUCksAvBmIw3X5TsO4gLctjMmCoehSCGnHNQqD2AVRt2
	 x2cDod1q+gR00euJDNQHjobW1vwQs7e6NUo77UIo8JXlyCUTRGgVs/NlHzGwyFlLrQkkB
	 vYdRFHgmGT/zsgH7Pel2v0MeXCsWRAIODbqDhVHCXZAB8kp5g31ygqCxapU7qCdxMlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793929993;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=wxeZpOXQhUo81pD2yA4Z/UMSnaX3ZiaL5SGqTHAt6ek=;
	b=wJXcuFeHGgonmSQfsnjrsneCVvtUfk2w7goTGWUDjrYKmIk3bPKoLqpPJTn2SEkj/gzm
	 V/nOxK0cg357Nnc+y4o4HiHc9pldQzUyxYjf4Dy1TtzW8KPU7L+vl5O1GB9wWXEdoKb38
	 Z1mfH/8rWw0czkF43nfv+PlbnD1ra+hSvP8I6JhsexrY39nNEk77yJOtvAIRiwa22x+vX
	 zKlDE4ondSuM5I52oiYmhdVYfSALYVVyDN1JMhpr2YV19N6UaTO525CDphTAeCw90QFy3
	 kjFablMP9y/iRNnaGWyVpYvB+2G4fyfv9ETPPif1Catm4YzQGdMhfIGIJV+8XNnQI7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gjQyctqD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16046606A32F
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 01:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gjQyctqD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA721F0089F;
	Fri,  6 Nov 2026 01:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793929992;
	bh=wxeZpOXQhUo81pD2yA4Z/UMSnaX3ZiaL5SGqTHAt6ek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gjQyctqDwFgqvjBg/J98NpU29YDRFvt1GmMha4IxIkqLhlrdzayx5y9Pg7X6ptIMN
	 D/n321qL+1t3O9L+aWRgxmdbUGDfbYBegoBq6CVoWZBsyWqJpFvhQ5vzxFns2qnPtd
	 5yw5aesdj7G8zYly/4eXYOXEIJOApiCCagFmbBGJH1rpvJOgSHjhrN4OIwX1IYGqwr
	 20JcPFjv/O2QLi9/2m+c6NzwjWvW2ppl1NXXQ5rbG9uN8IYe9wxoUdeG7v6jDPOhas
	 fH/x5/crrG3qv2oxUWrsqrB+gDCFgLfljFteGKADpTLu8xW6belTD9IX1DeP2EhvNO
	 ae4OePE6pxbvQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <cel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 1/3] NFSD: report listener creation failures through extack
Date: Thu,  5 Nov 2026 20:53:08 -0500
Message-ID: <20261106015251.3618109-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110423-herself-payroll-200f@gregkh>
References: <2026110423-herself-payroll-200f@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit 8e590a16853fedd2697a3b0c32b3cbf1a444f7b2 ]

nfsd_nl_listener_set_doit() returns the raw errno from
svc_xprt_create_from_sa() and sets no extack. A failed LISTENER_SET
therefore tells userland only "Address already in use", or whatever else
the transport returned. It never tells userland which entry failed.

Record the attribute and the transport name of the entry whose errno the
call returns, and report both after the loop. NL_SET_BAD_ATTR() names the
entry, which the message alone cannot do: a request can carry several
entries with the same transport name.

The rejections in nfsd_nl_validate_listeners() other than -E2BIG and the
unsupported transport name still carry no extack. This patch does not
change them.

Assisted-by: LLM
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Link: https://patch.msgid.link/20260901-nfsd-nl-hang-v5-5-a540d86668b0@kernel.org
Signed-off-by: Chuck Lever <cel@kernel.org>
Stable-dep-of: bf0f3a37e6cc ("NFSD: stop registering with rpcbind after a failure in listener_set")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfsctl.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 86aa8d202b4b1..714c73ddd9dc1 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -2086,7 +2086,9 @@ static int nfsd_nl_validate_listeners(struct genl_info *info)
 int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct net *net = genl_info_net(info);
+	const struct nlattr *bad_attr = NULL;
 	struct svc_xprt *xprt, *tmp;
+	const char *bad_xprt = NULL;
 	const struct nlattr *attr;
 	struct svc_serv *serv;
 	LIST_HEAD(permsocks);
@@ -2205,8 +2207,22 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
 		ret = svc_xprt_create_from_sa(serv, xcl_name, net, sa, 0,
 					      current_cred());
 		/* always save the latest error */
-		if (ret < 0)
+		if (ret < 0) {
+			bad_attr = attr;
+			bad_xprt = xcl_name;
 			err = ret;
+		}
+	}
+
+	/*
+	 * The ack carries the errno of the last entry that failed. Point at
+	 * that entry as well, since several entries can share a transport
+	 * name and the errno alone cannot tell them apart.
+	 */
+	if (err) {
+		NL_SET_BAD_ATTR(info->extack, bad_attr);
+		NL_SET_ERR_MSG_FMT(info->extack, "cannot create %s listener",
+				   bad_xprt);
 	}
 
 	if (!serv->sv_nrthreads && list_empty(&nn->nfsd_serv->sv_permsocks))
-- 
2.53.0

