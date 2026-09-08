Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A8F58B6D4
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 22:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788907036; cv=none; b=d3lcQUoH6+4d8a9EbUnNuZAJnFPygDEvPInvQgpOAmASKT6zXCZ5o740K1MTfR7K/WGQjh0HY7VKyXJvw3YKsxIsptAjOl0BIbqP5iXAWet96ZvIOYvShiXwrtqGHDQ/zsam/l7ZDLcwZrKEccBqfHwSMwqb+NB6YghsTBZBVrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788907036; c=relaxed/simple;
	bh=0c9jl79FowH1eiwLrDXpgp6lY/YWlYCZ5NnuCFC2ghE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PIEpOFjjOXLVnjcKGNST1ewIoyl6fVlT4lz5krq3sIKTvIG9T//xL9n2MIpaOfxYI3ZKCkkUD2KV3yY/HguGJsW1C3ioegsl3SiQ39v7cTRjmmIFYCasouYcirl0E1qKNyHMiCvmhXA73IU9TO5u/jiodfDoU44W7Qpr6F2pjsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ae2fPcat; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ae2fPcat"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39D651F00A3A;
	Tue,  8 Sep 2026 22:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788907032;
	bh=BEsQjlA6ctJNh3+quMoPC/q4qfTP2SZZpm0GwPCCIP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ae2fPcatVRRzJe4ir9RCpYFI0ykkQBqaxa0JrbphsW7Alff5cfN4n5lP6NpVChF46
	 fSsW8iToGWEvcqKM4DnCemth3ysPux17iIU9Z3fa/WwwvDlMEq+qVStKuqRV/R3EQh
	 JoIoTRTMyFySePBqUQMzxn4mIN2+lSK1Qspj2kn9D+ORXFGhWoXdjdp2mVF2ROHCpb
	 scpVtXgRcPvBBc1P8DBPPTzkmCfrKFvi5lqELkHK/lMm/a+F14JRpQqBW6mhSVqfIn
	 QZvP4uOAHoAQS9PoIFyFkNc4gv/UrYbsWDr4MsC6RRlnCopoMdpNJDdkkIyJbaNRuW
	 DQRGRiJGFyPsA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: NeilBrown <neilb@suse.de>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/4] SUNRPC: move all of xprt handling into svc_xprt_handle()
Date: Tue,  8 Sep 2026 18:37:07 -0400
Message-ID: <20260908223710.506600-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090350-breeze-repugnant-70de@gregkh>
References: <2026090350-breeze-repugnant-70de@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neilb@suse.de>

[ Upstream commit e3274026e2ec69eec6ab51bc499e14bb548548d0 ]

svc_xprt_handle() does lots of things itself, but leaves some to the
caller - svc_recv().  This isn't elegant.

Move that code out of svc_recv() into svc_xprt_handle()

Move the calls to svc_xprt_release() from svc_send() and svc_drop()
(the two possible final steps in svc_process()) and from svc_recv() (in
the case where svc_process() wasn't called) into svc_xprt_handle().

Signed-off-by: NeilBrown <neilb@suse.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Stable-dep-of: c479bde671cb ("sunrpc: defer rq_argp and rq_resp free until after RCU grace period")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/svc_xprt.c | 53 ++++++++++++++++---------------------------
 1 file changed, 20 insertions(+), 33 deletions(-)

diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 5cfe5c7408b74..5440d6b50efa5 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -784,7 +784,7 @@ static void svc_add_new_temp_xprt(struct svc_serv *serv, struct svc_xprt *newxpt
 	svc_xprt_received(newxpt);
 }
 
-static int svc_handle_xprt(struct svc_rqst *rqstp, struct svc_xprt *xprt)
+static void svc_handle_xprt(struct svc_rqst *rqstp, struct svc_xprt *xprt)
 {
 	struct svc_serv *serv = rqstp->rq_server;
 	int len = 0;
@@ -825,11 +825,26 @@ static int svc_handle_xprt(struct svc_rqst *rqstp, struct svc_xprt *xprt)
 			len = xprt->xpt_ops->xpo_recvfrom(rqstp);
 		rqstp->rq_reserved = serv->sv_max_mesg;
 		atomic_add(rqstp->rq_reserved, &xprt->xpt_reserved);
+		if (len <= 0)
+			goto out;
+
+		trace_svc_xdr_recvfrom(&rqstp->rq_arg);
+
+		clear_bit(XPT_OLD, &xprt->xpt_flags);
+
+		rqstp->rq_chandle.defer = svc_defer;
+
+		if (serv->sv_stats)
+			serv->sv_stats->netcnt++;
+		percpu_counter_inc(&rqstp->rq_pool->sp_messages_arrived);
+		rqstp->rq_stime = ktime_get();
+		svc_process(rqstp);
 	} else
 		svc_xprt_received(xprt);
 
 out:
-	return len;
+	rqstp->rq_res.len = 0;
+	svc_xprt_release(rqstp);
 }
 
 /**
@@ -843,11 +858,9 @@ static int svc_handle_xprt(struct svc_rqst *rqstp, struct svc_xprt *xprt)
 void svc_recv(struct svc_rqst *rqstp)
 {
 	struct svc_xprt		*xprt = NULL;
-	struct svc_serv		*serv = rqstp->rq_server;
-	int			len;
 
 	if (!svc_alloc_arg(rqstp))
-		goto out;
+		return;
 
 	try_to_freeze();
 	cond_resched();
@@ -855,31 +868,9 @@ void svc_recv(struct svc_rqst *rqstp)
 		goto out;
 
 	xprt = svc_get_next_xprt(rqstp);
-	if (!xprt)
-		goto out;
-
-	len = svc_handle_xprt(rqstp, xprt);
-
-	/* No data, incomplete (TCP) read, or accept() */
-	if (len <= 0)
-		goto out_release;
-
-	trace_svc_xdr_recvfrom(&rqstp->rq_arg);
-
-	clear_bit(XPT_OLD, &xprt->xpt_flags);
-
-	rqstp->rq_chandle.defer = svc_defer;
-
-	if (serv->sv_stats)
-		serv->sv_stats->netcnt++;
-	percpu_counter_inc(&rqstp->rq_pool->sp_messages_arrived);
-	rqstp->rq_stime = ktime_get();
-	svc_process(rqstp);
+	if (xprt)
+		svc_handle_xprt(rqstp, xprt);
 out:
-	return;
-out_release:
-	rqstp->rq_res.len = 0;
-	svc_xprt_release(rqstp);
 }
 EXPORT_SYMBOL_GPL(svc_recv);
 
@@ -889,7 +880,6 @@ EXPORT_SYMBOL_GPL(svc_recv);
 void svc_drop(struct svc_rqst *rqstp)
 {
 	trace_svc_drop(rqstp);
-	svc_xprt_release(rqstp);
 }
 EXPORT_SYMBOL_GPL(svc_drop);
 
@@ -905,8 +895,6 @@ void svc_send(struct svc_rqst *rqstp)
 	int status;
 
 	xprt = rqstp->rq_xprt;
-	if (!xprt)
-		return;
 
 	/* calculate over-all length */
 	xb = &rqstp->rq_res;
@@ -919,7 +907,6 @@ void svc_send(struct svc_rqst *rqstp)
 	status = xprt->xpt_ops->xpo_sendto(rqstp);
 
 	trace_svc_send(rqstp, status);
-	svc_xprt_release(rqstp);
 }
 
 /*
-- 
2.53.0

