Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D56C3859F9
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 14:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788618989; cv=none; b=jqTNWNbqGtcph602R9YIF0H49Xi/lr6FH5edN23wQYHgijI8XqjW78WQ55Rjz3w518JrMtZTF9WSvQvg/85kGJLZSUlVhRIYqAZDTXgzE5vjbCED6L3VSnAlb1+LEIc2KPKG8BHI6KI2fS7TDY8WKco2Jiwq/UmrIzlKbiEhzwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788618989; c=relaxed/simple;
	bh=eqK6MI/5vCnsN19HQ2y2ZSZ1tmNy18DtCsN+eJvawnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gILdeKqk1XejfmnleK2/XrfJt6z+uS7rhCG+nW31dGpFSMB3YJDnuNmr/lYuoxUP3TqMBcQJ02HXOp1TkkjiWBKNM55/hwyRGJ5BlV5XHlj0dbmUnaJmri56VZ9lY9lOIzDykvgduibet+CYWz3f3EOuYSYfm1mPMtKH+GXKUpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vg+jPvCl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vg+jPvCl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADD7F1F00A3E;
	Sat,  5 Sep 2026 14:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788618988;
	bh=6BSLpCNEr2wRvfGh1zpY3uJcxnTa1tHk0ozu8pDpAtk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vg+jPvClv0QES1D3FNkcss6GA9CRK0nY8mf4ovLO1+OZWpSTK4ccoVdW1t6Sx/L0E
	 NJU3mIk+EhmGMQskVXP13KYJ9GR0BXpomrAxZs7TqrM34gAtyVXnumSWW2ZSZDifs7
	 m4IIWR0p4QLcuctZHlDk6KbuJcESdwjOv8Lo26VLmJdTkbsMyCqoB1cZiVdBbdLxdF
	 Fi1S4uMyogeprmmSovdDMVW62Ia42UZDiRREnTuNulm46Fmqpa7D9dumHzATkKsMmq
	 1SrO70lrTI/fKHJelp1NwgXZrJuXVWTvbsdblmsTKMOHl9nve+Iqc9DPwXDxssDhj9
	 5wL5k/Ay2av9w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <cel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] nfsd: fix netlink dumpit error handling for rpc_status_get
Date: Sat,  5 Sep 2026 10:36:25 -0400
Message-ID: <20260905143625.237435-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260905143625.237435-1-sashal@kernel.org>
References: <2026090318-disbelief-saddling-d516@gregkh>
 <20260905143625.237435-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit e13d505af73a1e013aa81806652d4378b21cfca2 ]

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
[ preserved the 6.12-specific rq_saddr.sa_family access instead of upstream’s ss_family ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfsctl.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 9a3c0011b6674..a98ea46803ea1 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1512,7 +1512,7 @@ static int nfsd_genl_rpc_status_compose_msg(struct sk_buff *skb,
 	    nla_put_s64(skb, NFSD_A_RPC_STATUS_SERVICE_TIME,
 			ktime_to_us(genl_rqstp->rq_stime),
 			NFSD_A_RPC_STATUS_PAD))
-		return -ENOBUFS;
+		goto out_cancel;
 
 	switch (genl_rqstp->rq_saddr.sa_family) {
 	case AF_INET: {
@@ -1528,7 +1528,7 @@ static int nfsd_genl_rpc_status_compose_msg(struct sk_buff *skb,
 				 s_in->sin_port) ||
 		    nla_put_be16(skb, NFSD_A_RPC_STATUS_DPORT,
 				 d_in->sin_port))
-			return -ENOBUFS;
+			goto out_cancel;
 		break;
 	}
 	case AF_INET6: {
@@ -1544,7 +1544,7 @@ static int nfsd_genl_rpc_status_compose_msg(struct sk_buff *skb,
 				 s_in->sin6_port) ||
 		    nla_put_be16(skb, NFSD_A_RPC_STATUS_DPORT,
 				 d_in->sin6_port))
-			return -ENOBUFS;
+			goto out_cancel;
 		break;
 	}
 	}
@@ -1552,10 +1552,14 @@ static int nfsd_genl_rpc_status_compose_msg(struct sk_buff *skb,
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
@@ -1583,10 +1587,20 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
 
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
@@ -1594,7 +1608,7 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
 			struct nfsd_genl_rqstp genl_rqstp;
 			unsigned int status_counter;
 
-			if (rqstp_index++ < cb->args[1]) /* already consumed */
+			if (rqstp_index++ < thread_skip) /* already consumed */
 				continue;
 			/*
 			 * Acquire rq_status_counter before parsing the rqst
@@ -1644,8 +1658,14 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
 
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
 
-- 
2.53.0

