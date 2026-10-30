Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.210
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793350320;
	b=BVOnMsjXcv1RUXM1Tja2r4Jr5oqbFNqVfLADQZ77wqEtysxjXvStHiSd5C4IvO+8rLJu
	 PeDvy/IlFsNrIwJ+vlR/Y0KovS/puJfU1+05ReK4bLqYbJIv6irjpgZSCnURBKZq4qmlu
	 CQpjaaugpoFy0FobGYgAkg297jkxbFMu67+nkaXrL8hzzZbNGGDy4n29Y+xIz1YxOqejW
	 vGNHAlhfSpnKXZ3QL3Z2Us1rYZiOYMGlqbeKiWnX+3dPRR6fn00V0cuk6qxUR2Jsp3qOY
	 V99uIYaa0PLMem8S1ztGWEVUYggzXb46byKvSruWWLkXqKJVYWu/xCAQspptm4GGLUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793350320;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nCHeps+CijbslSPpm8J23zvNgLSPR1Nf4YTEZZ8kbIs=;
	b=wN9GnDG1DyaZfBhk0ui84L0Ebndc7KAuefTX1a3MFM2xxhj1Som3JOmv9dOVUUGbsHYe
	 CKxlEx2EsjtkU+941OzJ1K7xAU5OAomn1C4GugEZQiDb6O4G8F3kzK4qQFWqadzWez2CA
	 Sm5OZNuO7g9AylsFFsJoSwVEBUmuOyzqR7xa0kcVbaFDTIBnEaEP3nbU8oB9vO5zSV5VG
	 kC8lbRrZ/Xx5XKzXZAcRyeUvoqAYYBa6llho/iMU6/MJyIFhp2y54Af7mr+cB2FlKlpcM
	 eRf2xeWKFd+hDzXgMJxLGj1GDjrB5I8+CwT7O1/sUbmeL2Lw84BVW/tdEqNH82571YQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foxmail.com;
	spf=pass smtp.mailfrom=foxmail.com;
	dkim=pass header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=q8pk8Zy3;
	arc=none smtp.remote-ip=162.62.57.210
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61057606A31E;
	Fri, 30 Oct 2026 08:51:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61057606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=q8pk8Zy3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1793350314;
	bh=nCHeps+CijbslSPpm8J23zvNgLSPR1Nf4YTEZZ8kbIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=q8pk8Zy3btaCxqiO/rNuQ+zOYtA/WGwoJxh0+rph204o8ykcqXXJ4jX1IAzJrri0V
	 uSn5yKsYRVCtGX2ys78/aERVSsweIagmwbeE6Byf8V1RvzTcXf2w/noEtBUOxpirYa
	 uhFD7cWWYa2gwPolWI5UPNJBpOCBs6WeVwgZMiPc=
Received: from HAPYCAO-MC1.tencent.com ([101.226.143.246])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id CF33741D; Fri, 30 Oct 2026 16:51:51 +0800
X-QQ-mid: xmsmtpt1793350313t34vwgmvl
Message-ID: <tencent_C7D71E2F51C2195A0CA91A4C11D51B957708@qq.com>
X-QQ-XMAILINFO: MR/iVh5QLeieL5fH+OqodbSLncXccsG3WDp2VFBFPWIuralQWGlAdx6bukFVvp
	 Slmq6NHSl1HdI9M2bmBej3rhaAwimJqsdNZF3G2ylaXRdi3+szD7jrwJsKIcUS9IGUyJWswU6pon
	 L2RsGgHcxmn6diO7Vc4G+SdEMc1wWLEZJnnIg58I8xDAVkl4MdykC9HWDvpwurOC5kHupxsB8sAE
	 u3L91c3rWq/g5rVJWps9KIdfDZg51H7SJKZSpQ7JjbvD4Big1nGlnP6gbCE+ktZcbKbjLkpBAyhy
	 Ft9C6XPPJOC6QCnjtoqwXmC127SZlYLl9f/xS4JlCcCB01xJa7yqUE60ZN3J3U+hvmYqYAMG6yok
	 vqsR09SSkOnKOHNWWbV88EtJJjKIv8Zvy3mbPDrS6G6+ywvxswUVMwdKu9B17pzAdxASbCsWzj4q
	 8REjwHOVGSx2AmAlPqhhtrBP0REEG609aFxZMMA28ZvmCYMJbyg9BuhT8t09xKFWRGvxPrmP0CMq
	 Hv5G5MSQJyC73gYkVB22g5vs2Qc7neet+3qkKEErtyM2394bC9djFTCIjZo/Jn31M6KMA6Vbci40
	 rc+aXaOtd2TTxgXtdQ8TKOUvBM2meDZP1zEJMrPy1RrTpr64wp35rSmrQJ17RX/i34c7/d47Z20M
	 36Zr9CBlEg0yw+cW0PHaHlxPNOgIAdTRnPBTP4Z1E9/1fo2Zj1KQPOeRVdEHsIq5u2WCQpLBChZy
	 UUHY+KXncCmLG3StQkNCvgdJ9R7CuRzt1FAobSRQ7S3lAV8OS7/ss0mnwZB3hi9iAKxJ1tZ0uX9f
	 HiNJcBAIvVdhKS4zoHJ300pmJ9ZF4l5Mf1hWSr7HVtw3SwvAazGldG8kP/wEMy4vW/2J93dZbf8x
	 8LYakVZctcDgOTlmKSU519RbrIVzV2RGrE3BoDlC55ggQ3DuFc0wYP+PlBU2+MqHQiKkcGcOguB8
	 6dti/TspIvWIwTJkGpnE2wseT6qDBXeAQdlYItiDSw2SdU1wbAqda2T6YVgR8vsaYZqH6U/Prju1
	 Bg6B+xB9EqzN5hS2oVf7aJ1/b50ymewLgQtzt62yUZbZ9dlKna6vRNfrm16lce8mKeFdEhat+lsS
	 7+V9ELKtSMH4x5GDICTKbN5Wca2A==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: bo cao <treebacker@foxmail.com>
To: srini@kernel.org
Cc: linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] misc: fastrpc: consume in-flight reference exactly once
Date: Fri, 30 Oct 2026 16:51:50 +0800
X-OQ-MSGID: <20261030085150.75870-3-treebacker@foxmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261030085150.75870-1-treebacker@foxmail.com>
References: <20261030085150.75870-1-treebacker@foxmail.com>
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

