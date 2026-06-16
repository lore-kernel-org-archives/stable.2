Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE1A3955D0
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 07:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781596622; cv=none; b=RUocQG4yCr5O5BkH9o2YLdQNJLlQFB5t67mmTSQEnOnemW1Sce9bnDWnxtKsW75hnYyEOZdu/RwhpA9ZGN/Im/vKcOHlD0jUMkuelfPvIM0VMdoPeZ26Q8YoWXw0IX2NViSPQorxDeo2vjV74K7NFNRxWIqiEBjIBlaC5y4o2+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781596622; c=relaxed/simple;
	bh=S+cQwh2yJbBgde+xZGNmhIizPfb/Q5tWp6DjLRWqx7U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=toTZ2eq3uM7JHCC20BU0aiIblOONo20KrPiCN4iFnH0PQCl3yncq6QPrEpwUig3scvOFlBGkvoHVy20ham7pS+F6xeV6DRHrXUBs68CB7XtpquIF3alnutTBQPdLiFh5WbFdbmdU6gQoopiOcZL+sAMIroV+1ie+MgyDSTO/ipA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=RtvsuO0Y; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="RtvsuO0Y"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-45fd45e596cso2358338f8f.1
        for <stable@vger.kernel.org>; Tue, 16 Jun 2026 00:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1781596618; x=1782201418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tvO6+MpilClcYNX4EokLZGsJsErKgA+iDUMEt0HQsM4=;
        b=RtvsuO0Yz1sXz6hRJG0RJMCiIV0cIJ161Rr6gPJwCq9LyV5hcTJ+rYI9veOjkLSTWr
         HKnsEeiUI8qoW570nUh2/aQAAwyGKQVI99xqcgC1Bu8oUbcrpsUiwemWzcF+DwVNHpr/
         uPlxtpf+Lrhclz6Bv64qrHbj66zL9qhfufJzBYXPvnY20HQ7/xGqt41M4VX02CtyIAFb
         f/ggkiMwPnFKYS3HnoEYqQOzn0Y+p9C0v+rpQ5qNAY0xI4VyT+qGKE0ub946guxHWpMV
         1XioTZvHs7Kw4k2Uja640LUOfaUnHhboBwPbJxLtPxnaDNveD1UCWDLi6558kZK56Wjn
         cFTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781596618; x=1782201418;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tvO6+MpilClcYNX4EokLZGsJsErKgA+iDUMEt0HQsM4=;
        b=ohjlOu2REHJQfRYKfnJc0FuF0jxoLAqa4WqfWd9asCrKlna98MWDQcXjJp1JB6/DRt
         rSJeJkaedTRStJwAHhWWDzyS8m4wxdjXF4+MTrT42+/qgP/E5i4PuDvjNey+QhntkNCE
         0WGMg2JWydqRXV4+D81YzUfpUnnUNmAADBm+xJ9LTtY8uj54pC6QTMDn9ozMr4QiObbF
         QccDyyiC3/dF3Xhe/bWBi2mnuhaThKltdwJUaWprIhrTb6FmrzVTcF9B76jpLNfLQ0C8
         cS8inel1E3NdJO3u1lCXu+rV3rYEvUxqwBh+0zLY/S1UytgjpZ+yWgdwkmYUcRdynXD+
         mPqg==
X-Forwarded-Encrypted: i=1; AFNElJ/mjVRO5Ykf0Eo0QzDs/EUKUS6aldVyPdMiW8deZjX6qqya5Jtme30zT+lhmu4g5xsweqF9VUA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5WuHcORIpo7BTLF8DmNK1nEV314yBcAYL2dhntshUqlDOmxnJ
	DQ5EbIGqguwdwLQPJsIU9LWk4Crk/6TwNvYr33lD3sZuj2GfPAryDILpcqRHjpjbtlDfMc48iZO
	G7iFoxHoNFjk=
X-Gm-Gg: Acq92OEKkaSeoESGuszkKRGGt2GASQpwUP7Hf9lvgPq63nYUY04aTukxJdEmyQGlACM
	2fLViAHl2/qXYgjKQV5u5jcdOS4D0zu0n4GBI17gpXy4ElP34yY0mvj3LVjbi52OhQN1brNQq9A
	pAjID/CO48VSFa+VI/gJWIHlAdSkXsKKQSHLAjDReQJWEGzy6v8jCm9VWeeRRab7bgcWIIJ6Cjx
	6GYGEIs/g8lUO35hB61DsdEJnmgkfuRHC+stKuxGSVHDrlK0tV9wrvXJWdrc7OhEfPGUeqNkt0O
	uGQJOAjnyw23xyN7PWJRd2tVfHB4UewYi1obDBoo1p7SFnMUfowHcIscb486bnyoP+HdC75NKv2
	tjEho7BOLaDM4VffZlngfOhUN03YS/2Nrb9UvySZv0Of6Ap2t7UK4NuRMKl+mrpHci9xc38FU1D
	701nfIF+K2BiFnh7iJ5HDQ3fFFbqbUTP87LCUp9VgukO4IhMb2boHtwsrcj0Ght5gTlVCKZuCcK
	BifHxrPOrTRbYLGuq7kyshms61E5SsR9YSinayx+gDt6A==
X-Received: by 2002:a05:6000:1862:b0:461:b44c:a7a6 with SMTP id ffacd0b85a97d-461b44ca88dmr403954f8f.34.1781596618356;
        Tue, 16 Jun 2026 00:56:58 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2b0c35sm43503294f8f.22.2026.06.16.00.56.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 16 Jun 2026 00:56:57 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: tiffany.lin@mediatek.com,
	andrew-ct.chen@mediatek.com,
	yunfei.dong@mediatek.com,
	mchehab@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com
Cc: hverkuil+cisco@kernel.org,
	linux-media@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Doruk Tan Ozturk <doruk@0sec.ai>,
	stable@vger.kernel.org
Subject: [PATCH] media: mediatek: vcodec: fix use-after-free in decoder release path
Date: Tue, 16 Jun 2026 09:56:55 +0200
Message-ID: <20260616075655.95711-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fops_vcodec_release() frees the decoder context with kfree(ctx) but
never cancels the per-context decode_work worker first. Although
v4l2_m2m_ctx_release() waits for any in-flight m2m job to finish, the
workqueue handler (mtk_vdec_worker) may still be running and accessing
the context after v4l2_m2m_job_finish() returns. Once kfree(ctx) runs,
that worker dereferences freed memory, resulting in a use-after-free.

Cancel the pending decode work with cancel_work_sync(&ctx->decode_work)
after the controls and m2m context are torn down and before kfree(ctx),
mirroring the fix already applied to the encoder release path in
commit 76e35091ffc7 ("media: mediatek: vcodec: fix use-after-free in
encoder release path").

decode_work is always initialised before release can run:
fops_vcodec_open() calls mtk_vcodec_dec_set_default_params() (its only
caller) unconditionally after a successful v4l2_m2m_ctx_init(), and that
function runs INIT_WORK(&ctx->decode_work, ...). A context can only reach
fops_vcodec_release() via an open() that returned 0, i.e. one that passed
that INIT_WORK. cancel_work_sync() on a properly initialised work_struct
is therefore always safe, even if the work was never queued. This is
unlike the 2023 msg_queue->core_work regression, where the work item
could be uninitialised at cancel time.

Fixes: 590577a4e525 ("[media] vcodec: mediatek: Add Mediatek V4L2 Video Decoder Driver")
Cc: stable@vger.kernel.org
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
v2: reword the commit message to stay within 75 columns (no functional
    change; checkpatch).
v1: https://lore.kernel.org/linux-media/20260615140526.52617-1-doruk@0sec.ai/

 .../mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c         | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c
index e936ed8dffbaf..30906b24c608a 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c
@@ -313,6 +313,15 @@ static int fops_vcodec_release(struct file *file)
 	v4l2_fh_exit(&ctx->fh);
 	v4l2_ctrl_handler_free(&ctx->ctrl_hdl);
 
+	/*
+	 * Cancel any pending decode work before freeing the context.
+	 * Although v4l2_m2m_ctx_release() waits for m2m job completion,
+	 * the workqueue handler (mtk_vdec_worker) may still be accessing
+	 * the context after v4l2_m2m_job_finish() returns. Without this,
+	 * a use-after-free occurs when the worker accesses ctx after kfree.
+	 */
+	cancel_work_sync(&ctx->decode_work);
+
 	mtk_vcodec_dbgfs_remove(dev, ctx->id);
 	spin_lock_irqsave(&dev->dev_ctx_lock, flags);
 	list_del_init(&ctx->list);
-- 
2.43.0

