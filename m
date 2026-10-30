Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.87
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793348405;
	b=b0RadW3Fl/GLDLMWpLjHxm+1BNV5WjXOUX3O90e67AxOYSBINSeugvMhVPpgH49+CaPh
	 Xrs/uSDWkGL6TK72PiFVsmfwqXgiqq1+Dhc1pixZakKu8nkevXOFtkADildjk+WX8+957
	 HPorv4darqLj0xYg6Xy7MWINIDRmGjGET+1km8xo6qdc5AAYhtzUZulVwBKigOGOhcl6j
	 7jUX6is4tkjGdO+Zbvznc9qem4KD3SbkdBUnPPrMS9PKhZ/LXIAsqj4pS3uE7EifrfIoc
	 c/5CWQqmPe6l5m2332LHtUm30mrYmHnuiQgHq1NJx1gd20Mhy29LNHP5YXHfRkPL6/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793348405;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=vwouWkv3VLbBPbIBA6ZZnoD9+7JPCAt0ykZeDQJi10g=;
	b=Dvc7lRkdLzFScfKQ2BqBgplKU3hk+G8etxd71xkQcbP5HIS/EaS9K+NMTtmjlFFhGjSd
	 y8htyzbz4IDVcjQR0OEZToi+svB8jAxrxQka8Pm/E0+7OsuxsICmlS1PLpKc5Y7JlirTA
	 zxWMWN9HnRaDmgxYj7jNfgME93LaGVwcxq65fNWZ+4MTTg4Ge/mzI2AUkto4Jlg/mN5nG
	 5R/FI7FvPtn0rPllSdhfA4ZYug0FZdkTCVurP7cTv1RV27MwjvH017vCfabUuHOAHIG/F
	 RBYV7X/4Dv4gifhLz2eQuf7j+t3OBb+XxfXBne6XLJ3zaZDwDanWcZLtI9aUgxxzgnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foxmail.com;
	spf=pass smtp.mailfrom=foxmail.com;
	dkim=pass header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=yMg1LyWZ;
	arc=none smtp.remote-ip=162.62.57.87
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8C0606A31D;
	Fri, 30 Oct 2026 08:20:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB8C0606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=yMg1LyWZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1793348397;
	bh=vwouWkv3VLbBPbIBA6ZZnoD9+7JPCAt0ykZeDQJi10g=;
	h=From:To:Cc:Subject:Date;
	b=yMg1LyWZzQHUmbQaO8yFCp9NIEtFp7k35YOhy1RaVvhLEB2wUx1hIZKC4pGs2nKvG
	 4GaQTefexymMP0GulhVA2YKuhprE7IVmHuX+OgTkx0TpeamKZivc1jGEIP/ysGwKK7
	 8cQdJyxjSFHM0kjRd+G02R5RL7eNAcwwnOGDH6AA=
Received: from HAPYCAO-MC1.tencent.com ([101.226.143.246])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id 4F7AB0C9; Fri, 30 Oct 2026 16:19:55 +0800
X-QQ-mid: xmsmtpt1793348395td1iriaz7
Message-ID: <tencent_18454D1845AB2A759EA9AB3ABE52E67AE205@qq.com>
X-QQ-XMAILINFO: MDbayGdXPuoenP/Mh6MCkqyiDnVDgLhBJfOYHtI/F90m62xGXVhVMrr9yuuQ0/
	 QAOHPFu8XYwtjpYPmX8KAKYj3/jPqbXAkU0auKExHrkZcWL+U5lHQNn1Z2q5q37OLv01cVkbyssj
	 rnfQWGfGZCyvAvPYdOoOqsIBhAytBn/b+x/T1OqntZc2TcT8hDBNC9RIqS4R1si7usBRd4E9uBu3
	 EJuVyLS/L6huZuKBGjgLcJ30IlzHBIdYL3bjrsc9cWJ+xSIMuVHwxguf/qY/zPxS6dOipPFWlxIw
	 xY4gKS1ZIBDnf5i7rrkv8TiccJTKvcUoHbfpghaPqRfXeeHjzFYcRhVLzWzQUeRK4TPm+JC3hQXJ
	 z6aO8+D6cYvDkt8MWpciLROxPlo+x9wuVSs9WM93U9uPlHXDEn776eYAcxuWJXpb8Se9GtmUyBIj
	 96salvnNjMxQKDsGMZW1w35bm5C8iWf1NyZ3P1VlbuMoyDz4HF7jvEH6EQBxG8TDPxm81dXM4PSQ
	 b/5bfGy9qO+F5ATlLd34GVTMEehtKlhirLqVyVRWrsN8XkDxAxP4cEM/Qpo4sVwow1eRErOv8ErB
	 lneW0lqYT6GOdaabJ7TVt9NIeWrkPPUTSx/SArh3E+o6bLqi+JEo+3BRnboYaHCwWxkx94LYjkVS
	 gYGHf2CmMjJa8BPCQ7crwIodSNuuEbDPxpcF0YcjaoDAP8DahbaN5nRoz+3Z11p6pb5XaN8vtzkl
	 8VW2ixAzjk+H7OEhOurnrhsar2L5gZHy89NYe+aylXQJ26rvlE2kP9SISn6Ocf247Yg0LXmb/C+G
	 gRU9Oq9+WADvT998rZE6udKxuLjvhU8ZycVu+2MfvkDhCZhYT0asjPr6iVSlrOVXQrwFb2MIaH75
	 s46dB8WPzTsCcmwYSnHcVNJMrhPrRjbkdXppnfs47ohAuaMJfH6OWaz+97qCujmsCXAwPitsHx/v
	 7zmwozC3zeeGWNI/NZAyPzgWJAJ7+sW/gPXIWYyod+hLxUpnPT24fj+rYqnOevSEHtOlJhHbNLgT
	 GXznH8SfXg2aacPZxL8Lrahd5kqv5opYDLR3RIVsJwp2Uz1ict6FQ5Mhke/So1JEZVOyVkYg==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: bo cao <treebacker@foxmail.com>
To: srini@kernel.org
Cc: linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] misc: fastrpc: pin invoke context at glink response lookup
Date: Fri, 30 Oct 2026 16:19:55 +0800
X-OQ-MSGID: <20261030081955.33535-1-treebacker@foxmail.com>
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

