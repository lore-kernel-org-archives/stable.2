Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793932741;
	b=k4ctzb/h/MDuQiIxlsNN205gNeINz4I7yq/xex+Wo165hzrNSzDrzlPgTQO4QguOKx5f
	 Mv7yXMb7DwO/nB5bkBkOsxijn3J0hJuMoyyXCS0TFRQ4EjMZx5uY0m0IRs5tYrtBZvDG9
	 wDCTLOZgbac9gi1Wd5lOTZdJBtA/syrB2dZ65ZHBruNk4whrgi2vLRI4IiqTA7mc+zUAd
	 u+57wrGxqATdcVeR4JiPiKZl/9J6BiVbEPx64RZ87cnM0yDVqJQMn3tW2zKXL4WZaAIU/
	 c+7lvDouFdQLFUOc4oOvgGISM9foLGxR/0eC/wIHwxdSDjD1N55PFYn2mk/nMmE4hiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793932741;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=7IKeCrIXylKwPdCulK8MOAou8VdLzugRsPpel9b52aI=;
	b=hz4btwhMHQ5GkgI1CM6kiD0Ai0K61XC6LOTEwd7XQz74gZ1kr0xAJVhbE/Gn3LbdgTL0
	 ZFiuu0M5PNhGMHi62ESUlDfOIf1nk7eItupe7xn/H395yVdgWYhP1paiGFENKcc7AiPqf
	 Kw2G9lVO2tuReuRc3Z25XTTm2jDep5DABCf/oKM4i9Ph8bVyiP7L5zowvzaFTWYqfMNo2
	 X93EyzPfFBdxQP+/rPtvN8mP9HpAPJMDEWdSutbYIP8vHGqWjaVMxdnub/d0eaGDE93Sc
	 QR6pNL7nAXTGFiGwv1q5/7Rus1MZf7uHfoLe1oTvyBIir+MMXc9x9g/6r1de7PkBHFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=chhIaZoh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DD0606A328
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 02:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=chhIaZoh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B0CA1F008A1;
	Fri,  6 Nov 2026 02:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793932741;
	bh=7IKeCrIXylKwPdCulK8MOAou8VdLzugRsPpel9b52aI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=chhIaZoh6BHMCny0BPGm2N9dI7IS8eb9mctHBFPgAu6N6zsNXz6PgTzd5tH3cYHai
	 yc4Z2hfqwuWub6aWz4JzD/QZqDCBnbyTTFyePL1BOuHE/Vehd35IzzpUvCpHyFQnII
	 X7gEvVCWEJL1fV7V+R9eBdpGjeTiBrY01Oj5b/a/hHfDpIm3Y3sisSzspxiXTaRhWD
	 D6F366DA+kpVuWo830v/qvlmIaayO9/Wl7dKimjC7uum0MyBnmTV7OnmlCQ/fvQN1G
	 AwOZnbZIfeDj6MJ6KVjSJzBYgQmrKsWBf6AHe98rNol7J2yfmlDiCGu8QUSAHUFCkM
	 O982+QRKKMvRw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <cel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/3] NFSD: report listener creation failures through extack
Date: Thu,  5 Nov 2026 21:38:57 -0500
Message-ID: <20261106022847.3723642-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110424-scope-designed-5ca1@gregkh>
References: <2026110424-scope-designed-5ca1@gregkh>
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
index 967c5bf30d051..49cd0588deb39 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -2026,7 +2026,9 @@ static int nfsd_nl_validate_listeners(struct genl_info *info)
 int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct net *net = genl_info_net(info);
+	const struct nlattr *bad_attr = NULL;
 	struct svc_xprt *xprt, *tmp;
+	const char *bad_xprt = NULL;
 	const struct nlattr *attr;
 	struct svc_serv *serv;
 	LIST_HEAD(permsocks);
@@ -2145,8 +2147,22 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
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

