Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793932743;
	b=vTPqZ09eucC0gjZikPKT8V7HcjtDOaLCIiOk4/9wSqxCYvXtGd2wemNYMiqG3Ok+IpmI
	 OEHod1i9LHJwIBr0LzlMojbYlfJhML7lGs+6kOgHQ4uDZmVX89Eq9votttb0cNrMxEcEd
	 MOneppbaDiXpwguIgb0hgy5crYCGTERYW0aoErAIMV8Gx1hqE0vVbm/bW/yyl7a8Ot61e
	 oi65Vrs4qmEgdBKvOBHh3RkexiEOi1/12u2nKrZKOQBsxyftpVObhI91UzK+7HlT3ntQk
	 gbXm1dAJP6PWkgSPQjIIZenYxxl3+J+jecsZ9M2Ip1pOIzzW9YNCiXpN6Lvueqzu/6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793932743;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FGOM4LQIcCP/gqZ8sXbH9xbdLSjMxPbuCFPOM4kJ6U8=;
	b=GuPaYmsO8+pfXljaLSfBK3lY8uxVHFwsOtp1dJt/Ez3M5XZ83U06QUzIrRnAoMXU/fu8
	 NqPeHJCZX7I1QXfiwxZzhClrRLNbDbd9LNZsbiSkqe1kwof1IL+sxwyI6TvrKL+p7ARyA
	 wnrn9b4obczJdKl56Ts1x81ETcGqepvIgNz658SZvzPFGigfOFH8tJjxTv63XefaQtbbu
	 1RfUFfynof4SqXUfb/6k2+ADyn6jkB9zAKhiQebdwu6HDsrYr5bPndQMDUBnqJcxw+QCs
	 ulxduVKmV7YewV5Th31p4e7RbZwXWTUrYepiSxje173PwPTjGjmP+YPNQ7qVDUEtEFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IqaZt8y6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEE0606A33C
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 02:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IqaZt8y6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 066441F008A7;
	Fri,  6 Nov 2026 02:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793932742;
	bh=FGOM4LQIcCP/gqZ8sXbH9xbdLSjMxPbuCFPOM4kJ6U8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IqaZt8y66ZdajPhuNyzQs/1DezmCAYy8qEKnl5+YP7QvpvOC9EmskkMpPBOggLe0k
	 nWOEo1+sUeRRJwcVmitgC6qHHTI/uKPjF8YoMnlO0Rn7FQAbkzp344UZRpe8bpVmxS
	 7DspARm5QoVpCUMCWf810wc+b16hUVf68BFS5YDMf3HjteOvSX7IhnXlxJkC8Pb1M5
	 SMmJxMhqMWwGpk7y2eMojKJw9P6NwEUDO8s/6BMmMxN0NJxwWUVUR9vjoKIG4493R2
	 aVWGuAvo9P3dVsr/d6DXF4DpWvMH2A/1t4sEogtD2QoYKvsl1jt1eKjfGKqDU7BbiH
	 HmDyzjkm4H/xQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Chuck Lever <cel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/3] NFSD: stop registering with rpcbind after a failure in listener_set
Date: Thu,  5 Nov 2026 21:38:59 -0500
Message-ID: <20261106022847.3723642-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106022847.3723642-1-sashal@kernel.org>
References: <2026110424-scope-designed-5ca1@gregkh>
 <20261106022847.3723642-1-sashal@kernel.org>
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

[ Upstream commit bf0f3a37e6ccb78ae80cc6eb2edde4f033c7574c ]

nfsd_nl_listener_set_doit() calls svc_xprt_create_from_sa() once for each
requested listener and passes flags of 0, so every listener registers with
rpcbind on its own. A rpcbind that accepts the connection and never replies
therefore costs one timeout for each entry. With the cap of 1024 entries
the request can hold nfsd_mutex for about 34 minutes, which is roughly 17
times the hung-task threshold.

One failure is enough to know that the next call will not fare better.
Read svc_rpcb_failure_count() before the create loop, and pass
SVC_SOCK_ANONYMOUS for the rest of the request once the count moves.

Fixes: 16a471177496 ("NFSD: add listener-{set,get} netlink command")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Link: https://syzkaller.appspot.com/bug?extid=c7eae0eb80858a2dba0f
Suggested-by: Olga Kornievskaia <okorniev@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Link: https://patch.msgid.link/20260901-nfsd-nl-hang-v5-10-a540d86668b0@kernel.org
Signed-off-by: Chuck Lever <cel@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfsctl.c | 42 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 49cd0588deb39..9ffa72c15aed2 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -2029,7 +2029,10 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
 	const struct nlattr *bad_attr = NULL;
 	struct svc_xprt *xprt, *tmp;
 	const char *bad_xprt = NULL;
+	unsigned int rpcb_failures;
 	const struct nlattr *attr;
+	bool skipped_rpcb = false;
+	bool bad_rpcb = false;
 	struct svc_serv *serv;
 	LIST_HEAD(permsocks);
 	struct nfsd_net *nn;
@@ -2119,13 +2122,16 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
 	if (delete)
 		svc_xprt_destroy_all(serv, net, false);
 
+	rpcb_failures = svc_rpcb_failure_count(serv);
+
 	/* walk list of addrs again, open any that still don't exist */
 	nlmsg_for_each_attr_type(attr, NFSD_A_SERVER_SOCK_ADDR, info->nlhdr,
 				 GENL_HDRLEN, rem) {
 		struct nlattr *tb[NFSD_A_SOCK_MAX + 1];
 		const char *xcl_name;
 		struct sockaddr *sa;
-		int ret;
+		bool hit_rpcb;
+		int flags, ret;
 
 		/* validated up front in nfsd_nl_validate_listeners() */
 		if (nla_parse_nested(tb, NFSD_A_SOCK_MAX, attr,
@@ -2144,12 +2150,27 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
 			continue;
 		}
 
-		ret = svc_xprt_create_from_sa(serv, xcl_name, net, sa, 0,
+		flags = skipped_rpcb ? SVC_SOCK_ANONYMOUS : 0;
+		ret = svc_xprt_create_from_sa(serv, xcl_name, net, sa, flags,
 					      current_cred());
+
+		hit_rpcb = false;
+		if (!skipped_rpcb &&
+		    svc_rpcb_failure_count(serv) != rpcb_failures) {
+			skipped_rpcb = true;
+			hit_rpcb = true;
+			if (ret < 0)
+				ret = svc_xprt_create_from_sa(serv, xcl_name,
+							      net, sa,
+							      SVC_SOCK_ANONYMOUS,
+							      current_cred());
+		}
+
 		/* always save the latest error */
 		if (ret < 0) {
 			bad_attr = attr;
 			bad_xprt = xcl_name;
+			bad_rpcb = hit_rpcb;
 			err = ret;
 		}
 	}
@@ -2161,8 +2182,21 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
 	 */
 	if (err) {
 		NL_SET_BAD_ATTR(info->extack, bad_attr);
-		NL_SET_ERR_MSG_FMT(info->extack, "cannot create %s listener",
-				   bad_xprt);
+		if (bad_rpcb)
+			NL_SET_ERR_MSG_FMT(info->extack,
+					   "cannot create %s listener; rpcbind did not answer",
+					   bad_xprt);
+		else if (skipped_rpcb)
+			NL_SET_ERR_MSG_FMT(info->extack,
+					   "cannot create %s listener; rpcbind did not answer earlier, so some listeners are not registered",
+					   bad_xprt);
+		else
+			NL_SET_ERR_MSG_FMT(info->extack,
+					   "cannot create %s listener",
+					   bad_xprt);
+	} else if (skipped_rpcb) {
+		NL_SET_ERR_MSG(info->extack,
+			       "rpcbind did not answer, some listeners are not registered");
 	}
 
 	if (!serv->sv_nrthreads && list_empty(&nn->nfsd_serv->sv_permsocks))
-- 
2.53.0

