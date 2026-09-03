Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493E54AF689
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 13:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788442820; cv=none; b=K/zyk3anDCPwYT3AZi0wcrgkGtJ3rmeDdhk/gd5iDphG60CtLw1gWQSDEDTK4BY2bKp4z1sbF9m1EEVbb06x0N5xDoSUIpH0AVPvN9rZf/66/EmDrxWyxhCBteEXhCEcHl+CPbDEe/cZmQMT2LEcan9IpRycGPaTGgUxiy+DGC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788442820; c=relaxed/simple;
	bh=k5n6DhVgb4yYjfhOKLCAodmZO2RaBRFziRzu6SBOihw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Or6kpIKsTEYkuSfZvyXVwJo77SlEftUtcvEQjEhSgsQF9Lqs+SB6nXLYL882MexyuhNKTDJe/53j1rIv9uHERuiYxAgp00WFx05wOtIMarmPSGIOxQemk5q2cKwnkGKDV4M4j1LPK7Bbw/B3PzrYRAy29nmh0sSaxzShFUQVGWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dB0Ejbcw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dB0Ejbcw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40EB41F000E9;
	Thu,  3 Sep 2026 13:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788442816;
	bh=yKVfmqDN2CcoVJGzcYcNERiuv7n7338qCuZN+cdizE0=;
	h=Subject:To:Cc:From:Date;
	b=dB0EjbcwyXGuiAbajAEuYTFhORvDX+cddaL9ZwjJOC58YPJFB9gFl3rEw0D7Rqh5C
	 bNQaEnkVpwoTEvgxwps4KKceMbyWFnL7MYWvDuP4UcFa3+dgN8W4OF2pJM94bbxoni
	 PtBMEWb6Ro2DgI2bEAp8DvyqYHVZn28ox8EvputU=
Subject: FAILED: patch "[PATCH] nfsd: fix netlink dumpit error handling for rpc_status_get" failed to apply to 6.12-stable tree
To: jlayton@kernel.org,cel@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:14:19 +0200
Message-ID: <2026090318-disbelief-saddling-d516@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x e13d505af73a1e013aa81806652d4378b21cfca2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090318-disbelief-saddling-d516@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e13d505af73a1e013aa81806652d4378b21cfca2 Mon Sep 17 00:00:00 2001
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 11 Jun 2026 16:00:46 -0400
Subject: [PATCH] nfsd: fix netlink dumpit error handling for rpc_status_get

nfsd_genl_rpc_status_compose_msg() returns -ENOBUFS on nla_put failure
without calling genlmsg_cancel(), leaving a partial message in the skb.
The caller then propagates -ENOBUFS directly, which the netlink dump
infrastructure treats as a fatal error, aborting the entire dump.

The correct netlink dump convention is:
 - Cancel any partial message with genlmsg_cancel()
 - If prior messages were added to the skb (skb->len > 0), save the
   current iterator position and return skb->len to paginate
 - Only return a negative errno when no messages fit at all

Fix compose_msg to cancel the partial message on all nla_put failure
paths, and fix the caller to paginate when possible rather than
returning a fatal error.

A second defect surfaces once pagination actually works: cb->args[1]
records the resume index within the pool named by cb->args[0], but the
inner loop applied it to every pool from cb->args[0] onward. After a
mid-pool pause, a later dump call drains the resume pool and continues
into subsequent pools within the same call, where the stale cb->args[1]
caused the first N threads of each following pool to be skipped. On
per-CPU or per-node pool configurations this silently dropped active
requests from the dump. Apply the saved thread index only to the pool
matching cb->args[0], and start every subsequent pool from thread 0.

Fixes: bd9d6a3efa97 ("NFSD: add rpc_status netlink support")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Jeff Layton <jlayton@kernel.org>
[ cel: fold in 20/21 to avoid bisect hazard ]
Link: https://patch.msgid.link/20260611-nfsd-testing-v2-3-5b90e276f2d9@kernel.org
Signed-off-by: Chuck Lever <cel@kernel.org>

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 38c7468906a1..4814550880a3 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1452,7 +1452,7 @@ static int nfsd_genl_rpc_status_compose_msg(struct sk_buff *skb,
 	    nla_put_s64(skb, NFSD_A_RPC_STATUS_SERVICE_TIME,
 			ktime_to_us(genl_rqstp->rq_stime),
 			NFSD_A_RPC_STATUS_PAD))
-		return -ENOBUFS;
+		goto out_cancel;
 
 	switch (genl_rqstp->rq_saddr.ss_family) {
 	case AF_INET: {
@@ -1468,7 +1468,7 @@ static int nfsd_genl_rpc_status_compose_msg(struct sk_buff *skb,
 				 s_in->sin_port) ||
 		    nla_put_be16(skb, NFSD_A_RPC_STATUS_DPORT,
 				 d_in->sin_port))
-			return -ENOBUFS;
+			goto out_cancel;
 		break;
 	}
 	case AF_INET6: {
@@ -1484,7 +1484,7 @@ static int nfsd_genl_rpc_status_compose_msg(struct sk_buff *skb,
 				 s_in->sin6_port) ||
 		    nla_put_be16(skb, NFSD_A_RPC_STATUS_DPORT,
 				 d_in->sin6_port))
-			return -ENOBUFS;
+			goto out_cancel;
 		break;
 	}
 	}
@@ -1492,10 +1492,14 @@ static int nfsd_genl_rpc_status_compose_msg(struct sk_buff *skb,
 	for (i = 0; i < genl_rqstp->rq_opcnt; i++)
 		if (nla_put_u32(skb, NFSD_A_RPC_STATUS_COMPOUND_OPS,
 				genl_rqstp->rq_opnum[i]))
-			return -ENOBUFS;
+			goto out_cancel;
 
 	genlmsg_end(skb, hdr);
 	return 0;
+
+out_cancel:
+	genlmsg_cancel(skb, hdr);
+	return -ENOBUFS;
 }
 
 /**
@@ -1523,10 +1527,20 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
 
 	for (i = 0; i < nn->nfsd_serv->sv_nrpools; i++) {
 		struct svc_rqst *rqstp;
+		long thread_skip = 0;
 
 		if (i < cb->args[0]) /* already consumed */
 			continue;
 
+		/*
+		 * The saved thread index only applies to the pool the dump
+		 * was resumed in. Subsequent pools must start from thread 0,
+		 * otherwise their first cb->args[1] threads are silently
+		 * skipped.
+		 */
+		if (i == cb->args[0])
+			thread_skip = cb->args[1];
+
 		rqstp_index = 0;
 		list_for_each_entry_rcu(rqstp,
 				&nn->nfsd_serv->sv_pools[i].sp_all_threads,
@@ -1534,7 +1548,7 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
 			struct nfsd_genl_rqstp genl_rqstp = {};
 			unsigned int status_counter;
 
-			if (rqstp_index++ < cb->args[1]) /* already consumed */
+			if (rqstp_index++ < thread_skip) /* already consumed */
 				continue;
 			/*
 			 * Acquire rq_status_counter before parsing the rqst
@@ -1588,8 +1602,14 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
 
 			ret = nfsd_genl_rpc_status_compose_msg(skb, cb,
 							       &genl_rqstp);
-			if (ret)
+			if (ret) {
+				if (skb->len) {
+					cb->args[0] = i;
+					cb->args[1] = rqstp_index - 1;
+					ret = skb->len;
+				}
 				goto out;
+			}
 		}
 	}
 

