Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E95A4AE11F
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 13:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788441508; cv=none; b=YaImZxYULG4TFrwbg95IyJeZjo6sDed6Nc12UK5X08iDbZRrRQ/0iiyNieGViH0xATyvMoTXOitG9JmvjuJBR9BMlgSQpyY3rXvhIl0YeOGSE3yaq57KAjeqc+eX/r3MBZfZUn7BlHFAHOTZiJuWTCgu5cIRKtUP4pli/hgt0zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788441508; c=relaxed/simple;
	bh=nlWi1CGQLyk48f4znfss/RXeHHQopjS7+N4w8zXPLGM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=KSw++x7nQlYLhvd2JBwbU1nXLi0xH9Td6xWf2jU70zGA21AvT0FYonix01RqxQKbAsSYB+Adwz81g2EKbA7/nxIXmy/u09SU4etwZNV1mCtYM2jCcHUbXu9hK/rZ5/iLCFK701Y0N2ZXd4FcKvTU0ewrHUz9teuCKzV+Tz/Nf2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RzArinyQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RzArinyQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0052E1F00AC4;
	Thu,  3 Sep 2026 13:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788441500;
	bh=yvRS8tVxbdeDMdq5ZRWx7VO82IuRqK0ZBxZmqoaJyxY=;
	h=Subject:To:Cc:From:Date;
	b=RzArinyQMCFyhEo2llPZtBWWa6bw2/0jp6iqQag7EECY3R46mFPPYKFG7+Dx1gq9k
	 XSGg1aNLMgFAu7u+6Vb+59+cJ9kJH16fP/W8pjbHK6Yz2AUHiWWmbfpLfT/1s6Hfk2
	 jhhnwfbAYrh7Dj1hNK5QgD46kzGVc9BVcnyCwcfc=
Subject: FAILED: patch "[PATCH] nfsd: restore rq_status_counter to even on all" failed to apply to 6.12-stable tree
To: jlayton@kernel.org,cel@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:07:45 +0200
Message-ID: <2026090345-unbuckled-ocean-57cb@gregkh>
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
git cherry-pick -x f6045886fe3f14f269f683d64021b004a50d0efa
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090345-unbuckled-ocean-57cb@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f6045886fe3f14f269f683d64021b004a50d0efa Mon Sep 17 00:00:00 2001
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 11 Jun 2026 16:01:02 -0400
Subject: [PATCH] nfsd: restore rq_status_counter to even on all
 nfsd_dispatch() exit paths

nfsd_dispatch() sets rq_status_counter to an odd value once a request has
been decoded, and back to an even value once it has been fully processed,
forming a seq-lock like protocol with the lockless reader in
nfsd_nl_rpc_status_get_dumpit().

Only the fully successful path restored the counter to even. The cache-hit
(RC_REPLY), drop (RC_DROPIT / RQ_DROPME) and encode-error paths all return
after the odd-valued store without ever bringing the counter back to even.
Once one of those paths is taken, rq_status_counter is left odd: the next
request's decode ORs in 1 (still odd) and only a subsequent successful
encode restores even. While stuck odd, the dumpit reader treats the rqstp
fields as stable and its retry check compares against the same unchanging
odd value, so it never detects concurrent mutation. This exposes actively
mutating fields (e.g. args->ops / args->opcnt during compound decode and
release) to the lockless reader, which can read past the end of the
8-element inline ops array.

Add a helper that advances the counter to the next even value and call it
on every return path that follows the odd-valued store. The decode-error
path is left untouched as it is reached before the counter is set odd.

Fixes: bd9d6a3efa97 ("NFSD: add rpc_status netlink support")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Link: https://patch.msgid.link/20260611-nfsd-testing-v2-19-5b90e276f2d9@kernel.org
Signed-off-by: Chuck Lever <cel@kernel.org>

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index b8e8d80e984c..a8ea4dbfa56b 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -966,6 +966,20 @@ nfsd(void *vrqstp)
 	return 0;
 }
 
+/*
+ * Set rq_status_counter back to an even value, indicating that the rqstp
+ * fields are no longer meaningful to a lockless reader. This pairs with the
+ * odd-valued store made once the request has been decoded, and must run on
+ * every return path that follows it so that the seq-lock like protocol used
+ * by nfsd_nl_rpc_status_get_dumpit() is not left permanently odd. The store
+ * also advances the counter so a concurrent reader detects the transition.
+ */
+static void nfsd_status_counter_set_idle(struct svc_rqst *rqstp)
+{
+	smp_store_release(&rqstp->rq_status_counter,
+			  (rqstp->rq_status_counter | 1) + 1);
+}
+
 /**
  * nfsd_dispatch - Process an NFS or NFSACL or LOCALIO Request
  * @rqstp: incoming request
@@ -1028,14 +1042,9 @@ int nfsd_dispatch(struct svc_rqst *rqstp)
 	if (!proc->pc_encode(rqstp, &rqstp->rq_res_stream))
 		goto out_encode_err;
 
-	/*
-	 * Release rq_status_counter setting it to an even value after the rpc
-	 * request has been properly processed.
-	 */
-	smp_store_release(&rqstp->rq_status_counter, rqstp->rq_status_counter + 1);
-
 	nfsd_cache_update(rqstp, rp, ntli->ntli_cachetype, nfs_reply);
 out_cached_reply:
+	nfsd_status_counter_set_idle(rqstp);
 	return 1;
 
 out_decode_err:
@@ -1046,12 +1055,14 @@ int nfsd_dispatch(struct svc_rqst *rqstp)
 out_update_drop:
 	nfsd_cache_update(rqstp, rp, RC_NOCACHE, NULL);
 out_dropit:
+	nfsd_status_counter_set_idle(rqstp);
 	return 0;
 
 out_encode_err:
 	trace_nfsd_cant_encode_err(rqstp);
 	nfsd_cache_update(rqstp, rp, RC_NOCACHE, NULL);
 	*statp = rpc_system_err;
+	nfsd_status_counter_set_idle(rqstp);
 	return 1;
 }
 

