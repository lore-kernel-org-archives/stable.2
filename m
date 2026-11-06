Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793934101;
	b=dclszlWd/PUBr8WQ8YWBqqPXundqGlKlCpOqr8gtgTcOjO/NztHcfQRyVZLkgLLo+fKB
	 sr60O20VQ1g2UO0O4tpfeZt/S5qRJP5hhJKwDEutQyDL2XMo5yoLkVeCBbWGadEX8ZI2C
	 2b+m2PKDHutzFH+JlCD1xrcPLzSjp9J4PADptWspOjReNJCzCmUr8uHh5GR57N5ylE7Z5
	 MLGrb4bdarDR1ukwGXkdhU2z5clGgaNgKw7ACLqZEgLC231zFcEJnWL3L2sEA6XtqrIcm
	 O8Gijhnu/T5o+qYRVEtRxWv7kB98cL4tmwxZHIUjUhdRn3XfumvQ/qxjB4GmU6tREUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793934101;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=g04zzIznkU0jrMyC0yXkeDH7URjFoJl/g+e8mjkAFCA=;
	b=CUxfvVLe9hqruPO6gWw9JDqkN+K7D2+2RCmIEzfVWIBKb+Ev8eomCHt/7pUrmU7n4vix
	 HK/0VTuMIQBmtvKl9IyeofUy5G6/UGu5o7eJWQw9qMk+6OPf8fihxNiIy6glIjPwxwv0J
	 osu0XnLC/U7FLzvFOIvt+TK4E96biVbhPjjA0pa0GTb87PoHvL1sxSJ/jUUcFSWdnwPEz
	 GUh0mKIxxnjPrkP+LPpwalWrM9rUrxmftNyzmX6rkzCOZM9mPAuzn2Abu/1XcrGCADLgY
	 1sIlaDqZ/YRvH1lsbnti7wLlFXg2DVKcbxNdoCmY9E1L5ppkmpC/98nEP0BqBsNIaEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GCvVQcFq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4AD606A32E
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 03:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GCvVQcFq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47DD81F008A4;
	Fri,  6 Nov 2026 03:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793934100;
	bh=g04zzIznkU0jrMyC0yXkeDH7URjFoJl/g+e8mjkAFCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GCvVQcFqfZfmAq3CsHHNPL1MLCJg2orQwC8mohqfLLUkSCOp4PR2C7VQqaltEVLJb
	 8ywQMMQcLt08/Q1rh1DD/mfK7OMz0h7UcLVBoGzyfMQMTWtCfceV2OnyXt8nStzvxA
	 VL0i68vUiYBRRB4bRAAv0K32C89hb36HTRbcd5oNyYAYR1pzacromPjIEdOlSrv7xg
	 z9vz5bYk6B4O3Wu7sZPJTFnhJi/ioiGLfUDQP+rrSqBtYECCGZ66JAaf1Mm5oDOZRp
	 vJyz2FaGKlbKdSTnifQK+7+2hOj4ovlKRI9OE5tPEnQ5nuRA8YFGPiPtuHXWS5Mg4C
	 fPEmikVnMxApw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <cel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] NFSD: report listener creation failures through extack
Date: Thu,  5 Nov 2026 22:01:37 -0500
Message-ID: <20261106030133.3951618-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110424-grieving-monetary-d10b@gregkh>
References: <2026110424-grieving-monetary-d10b@gregkh>
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
index 2a225756ef0d8..ecfdd8e5fd3d3 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -2107,7 +2107,9 @@ static int nfsd_nl_validate_listeners(struct genl_info *info)
 int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct net *net = genl_info_net(info);
+	const struct nlattr *bad_attr = NULL;
 	struct svc_xprt *xprt, *tmp;
+	const char *bad_xprt = NULL;
 	const struct nlattr *attr;
 	struct svc_serv *serv;
 	LIST_HEAD(permsocks);
@@ -2226,8 +2228,22 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
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

