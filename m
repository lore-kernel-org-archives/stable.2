Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793929994;
	b=dXMgV87jPXew/3H7IiUEGdnmK5n8sfNpa602hzVYBlWijiM24MWB2QJahTko7hR6kSrN
	 9X0xv6wmCJWWF/EM+QXDjE4rqvMHxzyDVmcWTPu6KdPuefaJWRpyMkh9updsyrSHJbZXI
	 /a38IvNj9MMHn8ZEaSMCpsB4SC5Sn3uHFPLlF+Qase+H7OiPEhjoV51d8S+It8blG42Cw
	 TJfV2q22OTAMeYCHFVt31xEmT4Ap2h8vNjOrRK4x6R5CUhzmRSGykmRdrYyLcnZBNeksK
	 GCTF0XXtOu5OIgEEfmP/snrvMVWlVKJbBjpqvGCw57Pte19HZXCVwkTZIq7Tz2PGOOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793929994;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=shGtQ0Bi/n1BIHb+Z1JRRM3KA6pVM8CkVKAQIMnjw7w=;
	b=uu64TbqfOeVlkR44ELlD6oqZF+QddT+rp/31bhcffLJVUhvHFXEpJQ/nTlAKj2FfVoqw
	 Ms0NqUGkKHxmBpNEnBkGYuelxJItuKjFHFC0p2x83yI2i/7zHZdSqqAE57ZLFetNqmS97
	 7XyNNdxF7/I2fV8SC/icLcM89F6E61VfihvmaNg9B9LCZ0jsysxKCA1RaeQ3DDrJSBHu7
	 pIX1poMSbWB1HJ+LS/AINLUsquv1oasx39hHoQLeWEc8Fh/K7YkHYJ4RJpuZsgZEhaq+M
	 IfKlV8BFba2VjCh2ouwUfAayCVGg/GWaGMlsW9zBSAP79uVuPVb5Nwi/X+IGpG47YNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ANkbyfAW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E282606A333
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 01:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ANkbyfAW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB0491F008A5;
	Fri,  6 Nov 2026 01:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793929994;
	bh=shGtQ0Bi/n1BIHb+Z1JRRM3KA6pVM8CkVKAQIMnjw7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ANkbyfAWdYDsuvwEpkF3lrPqIqinqMFQJ5sdeazqMmhjt3uyyBGE13yogDehKIhxc
	 ha2R6FrIqevbmQ2r6CVK1EkMCTiBJpkmLVOwbCPVGGrBjpDvQjB3iGliJDhA1NHIU2
	 ZrF30tZFrMxQ8W6GSvvFVlD37BdS35Ogj3xfMyEDAgPkwezG96LCsZS8kT7ioQCRKt
	 BmoCJ5e6KBFg1H+0TbaelJEawxBFbLRr+L064cxlSvKKAZmz+R+QPdTeFgcCUReOTK
	 xMAzMkr4Eb3xYrjfgFX7/6uIJuk6581jC6F2WpQnGbmmCmrh7SrFrKgs9ddzrK2yWp
	 SE2QPOLJjohpg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Chuck Lever <cel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 3/3] NFSD: stop registering with rpcbind after a failure in listener_set
Date: Thu,  5 Nov 2026 20:53:10 -0500
Message-ID: <20261106015251.3618109-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106015251.3618109-1-sashal@kernel.org>
References: <2026110423-herself-payroll-200f@gregkh>
 <20261106015251.3618109-1-sashal@kernel.org>
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
index 714c73ddd9dc1..d5effeae4b792 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -2089,7 +2089,10 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
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
@@ -2179,13 +2182,16 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
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
@@ -2204,12 +2210,27 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
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
@@ -2221,8 +2242,21 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
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

