Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794204613;
	b=5Tcw/ggUNV9TPBcn8PhKhpcNvtBI/gDYYLLlciUkgxnglJ1XyMQoZjsf8JjNLl7kRoi9
	 FT0Md1RtoFdWzd1MHpqk7mI4gvTI2zA7/kWzr93WB4IHqJc7JOzzhMRUk7Atbh0ucMMvJ
	 XoCyCYGLzPHkpVNA6oSJiTSne03PFtVy8A54Jhmia9+5kJJd1Su+ns4v7skqnCX/5FYXg
	 jTp4+BDUJWN2xJnTcdrsqm2f8zje5mznDhoW+JbpzB3GucPxFBq5VUhWDLHYTd95oJLjv
	 IIZOpYKHWNWURPwvqTAoBJYTxIcFSuj08Zn6qqRx9U2KCEhfXBKNDJnpjxLU7rWy8hQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794204613;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kHmCaYxfDHn8K47bQjI+v/3u5wpeXFxvlLdiSYaq980=;
	b=0JxwI9FVMA4LM22RLVPyaTolmNoi6DRc7FtU+ofaQ076TVUHhfDTfcrIccMWLOsF7IWj
	 5Mh/mKSa6sXZbVzvdIhsawMcI0dZnAIspmF4Yfz0iuLVMdZkuN35VonPOV9hNZN5o5nd0
	 VfcIYfmGLYOWWVBm03NCC1J6pL+z9gcZLoYnsSkuuiv02Y5eyXkBs3il9Bx9E4joUeWPe
	 gD9s9q4ytBmVsfw2HHLDtGre2OO75mILztKAPNckZ5hs9/PAsuhyfj0Jq2NYFldnyJCM9
	 Dzt1Se/1lQ5uH9LPLnv0rcfeRe0uWF2LQP0qHsy+zLct79gfqxRP3ljQ9tEo/E5bDRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b="xVBy4/HL";
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0055606A31C;
	Mon,  9 Nov 2026 06:10:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0055606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=xVBy4/HL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=xVBy4/HL0A9+2H31cSsWHvQHnP9gbSDrHiAM8fkJn46Knr2s+E3JXEyNiJ+R74/9Yncq8NkdHvvkH
	 FwT9/mxIchDiYyvh3AmiyN1wmzJJ01DI/omGOyFdbl/WHknMzBBRYjZdL33kB42Pp0libmrTH+qKRN
	 e3dUBGSkRC6l7c7I=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee96af163c07b6-c6a40;
	Mon, 09 Nov 2026 14:10:08 +0800 (CST)
X-RM-TRANSID:2ee96af163c07b6-c6a40
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from Z04181456177947 (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea6af163bfd18-8376f;
	Mon, 09 Nov 2026 14:10:08 +0800 (CST)
X-RM-TRANSID:2eea6af163bfd18-8376f
From: Zhao Feng <zhaofeng2@cmss.chinamobile.com>
To: Bin Liu <bin.liu@mediatek.com>,
	linux-media@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Zhao Feng <zhaofeng2@cmss.chinamobile.com>,
	stable@vger.kernel.org
Subject: [PATCH] media: mtk-jpeg: fix runtime PM leak in mtk_jpeg_dec_device_run()
Date: Mon,  9 Nov 2026 14:10:06 +0800
Message-ID: <20261109061006.1043-1-zhaofeng2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.55.0.windows.5
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

mtk_jpeg_dec_device_run() takes a runtime PM reference with
pm_runtime_resume_and_get() and releases it in mtk_jpeg_dec_irq()
after the hardware signals completion.  If mtk_jpeg_set_dec_dst()
fails, however, the function jumps to dec_end without ever starting
the hardware, so the interrupt never fires and the PM reference is
leaked, keeping the device runtime-resumed forever.

mtk_jpeg_set_dec_dst() returns -EINVAL when the component count or
the per-component plane sizes parsed from the JPEG header do not
match the destination buffer, so the leak is reachable from
userspace with a crafted bitstream.

Drop the reference before jumping to dec_end.

Fixes: 5827e4b14ee7 ("media: platform: Improve power on and power off flow")
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Feng <zhaofeng2@cmss.chinamobile.com>
---
Verified against current upstream master.  The multi-core decode
worker handles the same failure correctly (setdst_end/clk_end path
does pm_runtime_put()); only the single-core device_run misses it.
Not runtime-tested (no MediaTek JPEG hardware).

 drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
@@ -1011,6 +1011,8 @@ static void mtk_jpeg_dec_device_run(void *priv)
 
 	mtk_jpeg_set_dec_src(ctx, &src_buf->vb2_buf, &bs);
-	if (mtk_jpeg_set_dec_dst(ctx, &jpeg_src_buf->dec_param, &dst_buf->vb2_buf, &fb))
+	if (mtk_jpeg_set_dec_dst(ctx, &jpeg_src_buf->dec_param, &dst_buf->vb2_buf, &fb)) {
+		pm_runtime_put(jpeg->dev);
 		goto dec_end;
+	}
 
 	schedule_delayed_work(&jpeg->job_timeout_work,
-- 
2.39.2



