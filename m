Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818471;
	b=iogT+7paB3mDMicTuiFEEj56163eYJrS03s+MdIbZrTR4cCc0uRQnXt3vL7EFIIFwFkz
	 KrKaYB9+u/PlQI/PkcKk85DGfiMevezsNrc3Vngodng+dgPGKXfVySQzPzrzudVzEv5xE
	 rJpFTubi1kBN7WgZfJhQ8JNFwyBU+rVg72FA5QAuC3dopp6yiLrcf/eJeFYEs8zHQfdr6
	 bPUNMK7NjWeFT2J6VWNNJYppeuKsm7pQ5x2G6OU5AkCrAX4DLxa5rAguktoIznQ3qxQxO
	 g9hmDzHkmGb0jW33DU4alRtR5fbrVwF2q/XqFqyrdsL52K7oo+tMtssMSBQhzZyRdEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818471;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=N/JOldBUjDJuFY1X+uV7b2Rx2DrfpedS0OcnuxKOvII=;
	b=zgHWm1JBLnKstcdijSUmOdxlI7LL16TGq3OvaFhDnfaqnvZP6m4amd4QNRQH8Bh8ZzD2
	 JiqN96iXDByScJpIHJOJbQLxGQgA+ojJTl4Qau5Z1ttF0JHvB+bRFeOXqaYHxOkcqjmu9
	 jBhk4JOLKP9Q3YPHud0J82n9D2Kvc5io7mLbEp5M4rFZykZO/ORHYGmKvau+MS7aF90Nd
	 16c3cHwI7RdZk8Cnewzdc+wuYJ5Z6qCJRr0AB3w04oPiXChWiK9pu5v+viCBzdtXpWe9i
	 JwnSoArcsgls71UV9Nc3WPwVWXIjAjEEB5XctE5pWcNDkomnwdTqkq6AIlltqHWzA3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=lMsGLiZH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21156083630
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=lMsGLiZH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 731CF1F00A1C;
	Wed,  4 Nov 2026 18:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793818470;
	bh=N/JOldBUjDJuFY1X+uV7b2Rx2DrfpedS0OcnuxKOvII=;
	h=Subject:To:Cc:From:Date;
	b=lMsGLiZHmduAtFYkC+MOSDDIGhVpV4QospaCT71Lqn0ShOUOrZWSUWw/UgKOm8Y3q
	 vkHa7DCNT+REp/M/UH8lz98KK5c6Tr/Q5dIXspRYnIBbxxo5bMieOCSNFg0bplbvyO
	 dt9TUZdQTiuRPAeUQBFh8nSeYTRMA0yywfcRP/dc=
Subject: FAILED: patch "[PATCH] NFSD: stop registering with rpcbind after a failure in" failed to apply to 6.12-stable tree
To: jlayton@kernel.org,cel@kernel.org,okorniev@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 13:54:24 -0500
Message-ID: <2026110424-grieving-monetary-d10b@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x bf0f3a37e6ccb78ae80cc6eb2edde4f033c7574c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110424-grieving-monetary-d10b@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bf0f3a37e6ccb78ae80cc6eb2edde4f033c7574c Mon Sep 17 00:00:00 2001
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 1 Sep 2026 09:39:48 -0400
Subject: [PATCH] NFSD: stop registering with rpcbind after a failure in
 listener_set

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

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 779fd244c771..967c21ff7199 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -2092,7 +2092,10 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
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
@@ -2182,13 +2185,16 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
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
@@ -2207,12 +2213,27 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
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
@@ -2224,8 +2245,21 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
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

