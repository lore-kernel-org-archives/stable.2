Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793348422;
	b=DBfs9Qi+eIvdHwIrwW5E/ASLqVf3Ih1PfKwhK6QEpiCMTbSmL/BfP8t8+jpnxS7CZC9v
	 l5ezbV3v3lzkG5luJdqTCJLNWkwNFB4jNSahrWxuQsUIpZGArE15WFtgHqfrXctIS3aKf
	 jqTi/mFafJejIxYyC+cLxaJ6QhrKybB1iW8OM1LSEPRBMdjlTMYIDVxl7nDBzzhpkpFeK
	 prgHZ9IwaHAubp/iS4hZuoEODGxxl3DDyspJX/Khrs8+L9CQXy2nIDQszkTIH47YvXgB3
	 ioPamX80JTfU9wo08Noc2chxjiLO6n68UhJ8xErWCIrH58nxaNScOD/cahKOHl3meAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793348422;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=nCHeps+CijbslSPpm8J23zvNgLSPR1Nf4YTEZZ8kbIs=;
	b=tQo8IzATaHaPiwVFj8neWkRQe/JWtslxaJe2BDLMj6v15rXd3DMupMXKEbb2DSZ2GyBQ
	 uxDzU9xP72kAkQEIUgCJsPQLp9GvbMh16wpSKFZ9T5AMiUEb86OUfE+IqX0wu3042eK3Y
	 eQq3rFYeCcV9rXJ3meS0mVLmraEhdpD9is+eeSlyr3EYbj2XDJiFaQtFcduzJt1gbvcUe
	 VqgP5nCH0RjZZbHVvyI/ifrAgYHlwdPMl+IxpkNaz4kEJpJSCK9gQxJQcVmxvMBhp8g6I
	 0bqIvfRmVglIMwXk8aVayCs7U9FjKrzRsIJzu6cFGWXlYfNGUugC7O0FrvKEUS/WNrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foxmail.com;
	spf=pass smtp.mailfrom=foxmail.com;
	dkim=pass header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=kh3Ak2fO;
	arc=none smtp.remote-ip=162.62.57.137
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84410606A31A;
	Fri, 30 Oct 2026 08:20:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84410606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=kh3Ak2fO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1793348416;
	bh=nCHeps+CijbslSPpm8J23zvNgLSPR1Nf4YTEZZ8kbIs=;
	h=From:To:Cc:Subject:Date;
	b=kh3Ak2fOT47MvdLkrRSzVj2sEnVZgRYVlhLpC4sxwdFMHih003w+S5S6jGEoeW9Vh
	 BXzGyqAvgCXmySV+JJp0i1Ia9PFCkJj55iv+M2dSI6AYgYrDIumXJzRKsm93belAln
	 odBmrmF1mr9jH4Qqr1Mcjk3Wqqe4j0WY9u7JM0x8=
Received: from HAPYCAO-MC1.tencent.com ([101.226.143.246])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id 50EAD0B3; Fri, 30 Oct 2026 16:20:14 +0800
X-QQ-mid: xmsmtpt1793348414taayzalkl
Message-ID: <tencent_BA84E1B456527B98F8AB612A15AE6F5FA409@qq.com>
X-QQ-XMAILINFO: MRMtjO3A6C9Xk/01pfTpsZ3Pes5tlgIwrpb4NA4GBHeStZVL8aOjr6TmFuHgMo
	 iWO8CZnsbudzFvZ7K27WgxBUBWdz6gvouXPK1hnEPR2l5TYK8s+eLWcB66au5HLn5wImWfkldFYS
	 3Y172rV/LsdvniJ83usHaP7h5bIdhv6cZS172s+8l97yy7rjlZ4CXQy4KqS+LYVl+fJ73ccbO2+w
	 UFgtAxr463IZEJ7Jx1Wjb2xT3e6mNdCOp1sdtp3loFCNPB57Cqo4rA3KGf6zxYJLpGHi6tJKi2Yb
	 uqBSxWiFc1V9yrdjjXvIi0Ocu5Or18YVIZKnp6fjd7vD2YFQP8uNDJQd+4EhD5kAbQs8o2oNjNvF
	 ZTyQzFu3hAFLN43LW3TYzsw5BqywOCeJlWcsq1iLSwTzSmzLEuAvTu0RNryAf2wlz63PN+8OpyEt
	 cNrswotgaQxQxh+nEzUS07bbtFQf4H7bDOLDpYIR5nnFfG7hPigzst0rRRbUGFJHCHYIlUcfccu5
	 S2qMFY2aCTVW5JqXHtkTvWzTBBTzSspkMQYwThzwyQNmaVKlRs+YgsHLIpOC+zaBamdwepKeSSZh
	 jwHT7Zsu/j43RxJRN4bOkVGi/ssQ1xfphATWuQKFAnazG4SZQS1u5v1jHUKd0bXowy7DVOSC1WWK
	 Dty4lfiCOAOBUEcyFJQjy/rFDHKAsmsf7l5wCNZ9shrlefEZqS9sERb/SxDmpGUe2asGFYGkYHIK
	 QiVcUXqBtTTvXFbmrvgGc/h4tqvtB7yASOB7D24DeaLqRgot+HGwv9FTJuGsZvjeE4JIyWySHYtZ
	 c5PgpIldP6fNiSh7xqNQ96/E01Jzy1wkyk207W+W56PZahuuXCOl7OWgs/Kyq6Ox8huV4S1JBRbv
	 8TW9FWFkqar1LsO7oZNRSTxp0xVbw1c6iw28OkI3h3C8MFAz3YCVaPI+fO3WLp+XkmuvIPxCy6EY
	 KogkyH9p3p9G+RL4CVgZb2eVWE4qmsqEOoJRS97cKW2lfTpB4Uss3aMoXnxHN0ylaLPrHbDpYv6G
	 ydpgp9J4rP0UkLJoU631tq8TnVh3FBw/hK8zs1km0ul4AMFsET8PUwQBE/YynsIFDKVHlGIw==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: bo cao <treebacker@foxmail.com>
To: srini@kernel.org
Cc: linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] misc: fastrpc: consume in-flight reference exactly once
Date: Fri, 30 Oct 2026 16:20:14 +0800
X-OQ-MSGID: <20261030082014.34249-1-treebacker@foxmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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

The response path is supposed to drop the in-flight reference taken
by fastrpc_invoke_send() exactly once: fastrpc_rpmsg_callback() calls
complete() and schedules fastrpc_context_put_wq(), whose worker drops
the reference.  Nothing enforces this: a second delivery of the same
COMPLETE response (identical ctxid and sequence, so it passes the
sequence validation) re-queues put_work after the first worker has
run and drops the in-flight reference a second time.  The context is
then freed while the invoking thread is still processing the first
completion, and the second fastrpc_context_free() also drops the
fastrpc_user and channel context references a second time.

Track the first delivery with a plain bool checked under cctx->lock,
together with the sequence validation, and drop duplicates.

Fixes: c68cfb718c8f ("misc: fastrpc: Add support for context Invoke method")
Cc: stable@vger.kernel.org
Signed-off-by: bo cao <treebacker@foxmail.com>
---
 drivers/misc/fastrpc.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index c77048076aee..f56ba5e44e1f 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -271,6 +271,8 @@ struct fastrpc_invoke_ctx {
 	bool is_work_done;
 	/* process updates poll memory instead of glink response */
 	bool is_polled;
+	/* first response already consumed the in-flight reference */
+	bool responded;
 	struct kref refcount;
 	struct list_head node; /* list of ctxs */
 	struct completion work;
@@ -2725,6 +2727,7 @@ static int fastrpc_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
 	unsigned long flags;
 	unsigned long ctxid;
 	bool stale = false;
+	bool dup = false;
 
 	if (len < sizeof(*rsp))
 		return -EINVAL;
@@ -2749,8 +2752,13 @@ static int fastrpc_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
 		ctx = NULL;
 	}
 	if (ctx && FIELD_GET(FASTRPC_CTXID_SEQ_MASK, rsp->ctx) !=
-		   FIELD_GET(FASTRPC_CTXID_SEQ_MASK, ctx->ctxid))
+		   FIELD_GET(FASTRPC_CTXID_SEQ_MASK, ctx->ctxid)) {
 		stale = true;
+	} else if (ctx && ctx->responded) {
+		dup = true;
+	} else if (ctx) {
+		ctx->responded = true;
+	}
 	spin_unlock_irqrestore(&cctx->lock, flags);
 
 	if (!ctx) {
@@ -2773,6 +2781,14 @@ static int fastrpc_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
 		return 0;
 	}
 
+	if (dup) {
+		dev_dbg(&rpdev->dev,
+			"Duplicate glink response ctx 0x%llx, dropping\n",
+			rsp->ctx);
+		fastrpc_context_put(ctx);
+		return 0;
+	}
+
 	ctx->retval = rsp->retval;
 	ctx->is_work_done = true;
 	complete(&ctx->work);
-- 
2.39.5 (Apple Git-154)

