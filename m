Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793934102;
	b=biwVMaUTAJ1ORrBLw5Mc2v3hjxvA1rqioHSrzuL6gJLJiriFJk3f9ttICVT3cBrOISTs
	 nVUQRCt7WID+kGh9+iS/OBl7qiXr1FHiyfzV8r0JX/9+Y8oD/X5w/lU6lvZjRIoXdfeM4
	 npb4OlhMwv0rZWK/5umkjwddNx3G2Oqub+8nDpvyQ/O6j4OkC9pw7GUDf2BcU2L5A1vcW
	 yhfxXC8DG1gCYxFhjeH/jHam08+NtClmtTwCVS1+JZ95idYW+PhHLSoJjVZEO8hNsP8hn
	 WVT2q6AvRK6Bv1hUosifsPZlkSlTBc96IU83u9l9HaBBlpLPveEUWaVmLwb0mMJtyHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793934102;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=x6bSxjjCVTrFTFFc3tHAuAIoxHRvmRn6sVxMj2NcwAs=;
	b=oZvHDgxLPN1X2Dyvrk7w25zP0BC4oARNPXioGss3k8BGPpZNxUx+b0B0X/TZ0L/FVPgs
	 3HHwY4KmoUxaKxyDP+5yCUAJhK7Fv6myYp/E+z4jantDeFK54eXXY4yJIogMN130gM1t9
	 HBHEVVi9zU+SxTPDRN6GIlhz7Mh5KFR7BHMRb+QCoBMqDpX5t6r2IpGsBVTVcNptX6PG0
	 8gNvdGDy/REw4YjYAnJ2L/zczBD4hwus5o/OiRJ9xp/bskYatXPCuVTn5plSaD2C3yNgC
	 BI8nkw0r+3Ryy7knZRFfD99MTvMMWPmdoR/IxcJKTOIov+ZaUfmZRbAxCjiQCoHtyvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V9DvseOA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC24606A330
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 03:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V9DvseOA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4CD11F008A5;
	Fri,  6 Nov 2026 03:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793934102;
	bh=x6bSxjjCVTrFTFFc3tHAuAIoxHRvmRn6sVxMj2NcwAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V9DvseOAXrkzbPrPh+7KtkZkqcT5zlxAg/HDUm4zZGxjuqFJAYU0scx1+5AspRVj4
	 nnEH6WC2Uo4rsAcicHkkfBtqMVovaUMAKSRM7eNWNNad8yJFSTCgAEq0rrKhGO8Pjn
	 VoH39R303VzDhU4Vi/fyS9VXKStQHlifpRaiOBwFGvo69C2e6cfGCk1q7QeJt7TFiS
	 /D5DTDFYm+9eyhzvQTXUa/5rfGVQ4TIIHI69K0L3U8aN5schZjsDjsI//d7leWxEdT
	 lQGDmK9CEnvsvk2sPZo5TA5/5K0dSYLzgyPw/ETzVB1h4LK+7ckoOHidCropvr+kUE
	 V6oOri6MJJZbw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Chuck Lever <cel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] NFSD: stop registering with rpcbind after a failure in listener_set
Date: Thu,  5 Nov 2026 22:01:39 -0500
Message-ID: <20261106030133.3951618-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106030133.3951618-1-sashal@kernel.org>
References: <2026110424-grieving-monetary-d10b@gregkh>
 <20261106030133.3951618-1-sashal@kernel.org>
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
index ecfdd8e5fd3d3..6ca903922fe9b 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -2110,7 +2110,10 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
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
@@ -2200,13 +2203,16 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
 	if (delete)
 		svc_xprt_destroy_all(serv, net);
 
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
@@ -2225,12 +2231,27 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
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
@@ -2242,8 +2263,21 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
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

