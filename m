Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.210
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793350319;
	b=XoHbBwvSSCHnrzbzm+IuhJ092BNs5BtMRdf8iXwXvzYRRo8WtTHN0MER43s5ZhhJHIg5
	 tiIZCVtuUyJAusIQVeW59cA/FTWHL5Rh8bTqX7SKI6Ap0XzlrQV0sxUu4J42u6Y1t7c1i
	 fq3bAOFW04Q3I3/J/u8LGYZYElk3tBjH+r1IMWlEaYozJzyBPEwEZ0kcZGJvclckmdX7H
	 FyjLBssf7jVu2mRzFbYQ96eeddIe8RzvACesiF22vthl9A7WIBfDEZPAlj1fBWXUkOO0h
	 75wtXhLsW5NqH9dhhX28zY/C5UPES7AiqAwigjt58afzdtZyrn/uWYfTEJ+HjeC89gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793350319;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vwouWkv3VLbBPbIBA6ZZnoD9+7JPCAt0ykZeDQJi10g=;
	b=1ETqIhGyY58/jWWNJ7z+H8VapwctEi0sN195Tb3UKY98XJSsmw7o4fdtSQTN6uu+/rOc
	 NF25odhLy2RGTnLI34eYcrJqbcmzVlqh4w0VmsJDthDedOLlIITXdVMLxrl3gkKah3Oca
	 YcsGNjwhP02IMM2vZJifEHL0nSjCDfeHVWvZqIqKmu8eJLp1nNfGekLQGGYs5GDUB30Yh
	 qCvrBRyPSAdjLONaH9c/QlHot9RO7TvOvvdbiHBJcXMatSqzOSCaW2W/H+9W9/iY5MlgO
	 e29vHHRHd8Q/zQqYp7yEutglwolbY/j415axHh4wC1iyAn7JspxffTufkHGY7Q4uGvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foxmail.com;
	spf=pass smtp.mailfrom=foxmail.com;
	dkim=pass header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=V1fFESAp;
	arc=none smtp.remote-ip=162.62.57.210
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E20E606A31A;
	Fri, 30 Oct 2026 08:51:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E20E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=V1fFESAp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1793350314;
	bh=vwouWkv3VLbBPbIBA6ZZnoD9+7JPCAt0ykZeDQJi10g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V1fFESApdsKNwkEvJn/doqs+wWN3Rre6X+UEdIEmLCqR2FEnqAxIIMPTcmMy3jlA3
	 gJ4r1i6b/y+7Ucu8ET9VVvUi8sRGtl++hSsnouA67O1TvSg6poTvFiwYIhRvRGrYil
	 qS7maowRHkFEsbvBdi0R3+Luvx3sqDoZkBQ9trIA=
Received: from HAPYCAO-MC1.tencent.com ([101.226.143.246])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id CF33741D; Fri, 30 Oct 2026 16:51:51 +0800
X-QQ-mid: xmsmtpt1793350312tajiepric
Message-ID: <tencent_E9BD7808AB6A2DA5FA326D547F57D65D270A@qq.com>
X-QQ-XMAILINFO: My42RIdQCQv03VnaoAltB9SsDGRzbVxQFpRheNmDxhGB9jmnIkzHosZqwsyLH7
	 rCENZp44crTgFstD5X5na0GCsqqdh4QLZ1Zw37mOkXMqMXgHKxrhjgQdE4pzkLzThcDqaa0kDsAw
	 Cjlu6EGvUU/GX3jR4DDbA7Lt3ukKGnU3cS15iYKNCXqM2I3dt7JywZ/Z7VFUNVC2c8AvFoV/y7qz
	 kYvchlzFBBjAxsjyg0NlUAGtFwfVX0P3orTk+C2AXybwEGOO1dbHAX1KSR2sTbZHeHQ5bH23GsZw
	 VqIKx5Owpz8aRZEffAXMejH/EO53Hhkx3PM4L+xS0+QePpuU1cSaig7c/FxaZwkPznub4FGaECGS
	 966r4n1Qry3DA606MfmM/VyHqBuklAW5cudUTcO2C6uxfefF3uKTD/uPg3Iu5/bHFBU2f9vuC9OS
	 Y80DTe4H9lb77S3BqrvON5j1NyP7fCA85v/k3FcsxxpMHjC0GDpQrz5J62tej6wec5Rd4119n0S2
	 wlSaTRO1HSJrknAT+GaqG8fDa+xIBb6tNm4wjhvN8YdzQGnL2xSRbt2sxc7ImEPoo+DJKxS90Bha
	 vryV+zbNwiQhNUT8nEIEnExyc+2/zrPVyOGMYa/PeeRQQ4ZNCCrgvsXzQGWdojiWVCkGaTFtp8g5
	 EoAYONaXrFyYW8Vh9yEkvWjs6SNwEi7X4ox9FsTQ7n3pQRJy8phzkOa3CbBy903Cs9QiZADNJe5N
	 oOBpxOzIW/FAK9NofF7ULEyLhX5/k1vdg3L6mEDs1kXZIiSSe6V+K8Fan5oMO3UtL+dhh4OXGzck
	 /eYN9OegDDuvnyTXYpnB+4z2TG9XBmI0tDBjlwxTT4JEoEKcLdFQyNY7kNO8a+dFORUFl7IvEKaP
	 mS1F28IbjXNG8sc0iVwzQBTewsZchg+GtbQwOw2TTmAvdSEikUaObpinIsEKl/PpDtDLTBwjUeVB
	 nQJVlp6eJx7mjmbkq/HYygTYX3Iq48wOj/pPTDWRndm7VTWHFh2Zp9N3cDRojW79IRPThRhu7LCH
	 nQF4zXSC1LwJrlnr2Lx7ZvDVcDyU7boxH/LfgFHx1VucFMpsGMEzjbBVEpK8280B5Q03S2JBxy9j
	 UsxDSUuRKjm1gAJpVlh2064PcbUbsZoohxH9BJ6YKREFWSj2W9NyUXrlAjR4QvxwRrllRvLMpIjY
	 abg8FJd5OxHE9uqw==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: bo cao <treebacker@foxmail.com>
To: srini@kernel.org
Cc: linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] misc: fastrpc: pin invoke context at glink response lookup
Date: Fri, 30 Oct 2026 16:51:49 +0800
X-OQ-MSGID: <20261030085150.75870-2-treebacker@foxmail.com>
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

fastrpc_rpmsg_callback() looks up the invoke context under cctx->lock
but then uses it after dropping the lock, including the ctxid read in
the sequence validation itself, ctx->retval, complete() and
schedule_work().

The final kref_put() happens outside the lock (in the invoking
thread's bail path or in the put_work worker) and
fastrpc_context_free() removes the context from ctx_idr only after
releasing its maps and DMA buffer, so a context found in the IDR may
already have a zero refcount with free in progress:

    callback                          freeing thread
    --------                          --------------
    lock; idr_find() -> ctx; unlock
                                      (refcount already 0; free is
                                       releasing maps and buf)
                                      lock; idr_remove(); unlock
                                      kfree(ctx)
    read ctx->ctxid for the seq
    check -- use after free

Take a reference on the context inside the same critical section as
the idr_find() lookup and run the sequence validation there too;
drop the reference after scheduling the worker (or when the response
is dropped).  kref_get_unless_zero() is required because the IDR may
still hold a context whose refcount has already reached zero while
fastrpc_context_free() is running.

Fixes: c68cfb718c8f ("misc: fastrpc: Add support for context Invoke method")
Cc: stable@vger.kernel.org
Signed-off-by: bo cao <treebacker@foxmail.com>
---
 drivers/misc/fastrpc.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index af18ff1992ee..c77048076aee 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -2724,6 +2724,7 @@ static int fastrpc_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
 	struct fastrpc_invoke_ctx *ctx;
 	unsigned long flags;
 	unsigned long ctxid;
+	bool stale = false;
 
 	if (len < sizeof(*rsp))
 		return -EINVAL;
@@ -2743,6 +2744,13 @@ static int fastrpc_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
 
 	spin_lock_irqsave(&cctx->lock, flags);
 	ctx = idr_find(&cctx->ctx_idr, ctxid);
+	if (ctx && !kref_get_unless_zero(&ctx->refcount)) {
+		/* Context is being torn down */
+		ctx = NULL;
+	}
+	if (ctx && FIELD_GET(FASTRPC_CTXID_SEQ_MASK, rsp->ctx) !=
+		   FIELD_GET(FASTRPC_CTXID_SEQ_MASK, ctx->ctxid))
+		stale = true;
 	spin_unlock_irqrestore(&cctx->lock, flags);
 
 	if (!ctx) {
@@ -2751,19 +2759,17 @@ static int fastrpc_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
 	}
 
 	/*
-	 * Validate the sequence number embedded in the upper bits of the
-	 * context ID.  Under high concurrency the IDR slot can be recycled
-	 * for a new request before a late (or duplicate) glink COMPLETE
-	 * response for the previous request arrives.  Without this check the
-	 * driver would call complete() on the wrong context, waking a thread
-	 * whose buffers are still being accessed by the DSP.
+	 * The IDR slot can be recycled for a new request before a late
+	 * (or duplicate) glink COMPLETE response for the previous request
+	 * arrives, so the sequence number was validated above, under
+	 * cctx->lock.
 	 */
-	if (FIELD_GET(FASTRPC_CTXID_SEQ_MASK, rsp->ctx) !=
-	    FIELD_GET(FASTRPC_CTXID_SEQ_MASK, ctx->ctxid)) {
+	if (stale) {
 		dev_dbg(&rpdev->dev,
 			"Stale glink response ctx 0x%llx (expected seq 0x%llx), dropping\n",
 			rsp->ctx,
 			FIELD_GET(FASTRPC_CTXID_SEQ_MASK, ctx->ctxid));
+		fastrpc_context_put(ctx);
 		return 0;
 	}
 
@@ -2778,6 +2784,8 @@ static int fastrpc_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
 	 */
 	schedule_work(&ctx->put_work);
 
+	fastrpc_context_put(ctx);
+
 	return 0;
 }
 
-- 
2.39.5 (Apple Git-154)

