Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795637784;
	b=q0P+8fddl4NJTOeoM87LmBpU3LlTwYcwqPZkxe+yzzeDVzfpnZ8Ex1y7fJmL8JAeurdL
	 Gu7TexQL4sR8Rc3Tfb+PdGo1hPHR3rb8joHeRW0A7yiH1iv21TPj0SthL2Yv8U+cwp2ay
	 jh86wtP9m1WwqM72EH61BHiZO6NmEf+ux3DqfHxqrSXJ3Eyc07x0w80VWtCICYOkwGZfp
	 ixhuefSS76GA5eWejN7JmkZ5hZoWJLLYEwdT6iv6WIDMOHJPA2MUCND9tnYavXPBcoaVX
	 ZNP+Nn16E/RgNg7hM7dyNfB1PzJVxt6ZHBkgKrolh9XXu18a5x0A7JuTsndRdRX61Hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795637784;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=moswij1DxNlgtZ2psQp6vB5WbP0Zx8EDmr2Dk41oG4M=;
	b=jsm9ASw0D+DU7VL1rzr7nUqdpjiXrw8TNLwr82HV5WwC0QSYYLOOw7nwE5qONpH0e5fW
	 Wyd3GhI2a8YHmxW18zntucpzGotN5iOuZwRmMsQNCNQKkOUzpEbDYD/NDTVhUU0rm8h2c
	 /+I6KiOjKFRHXiuFOod5KJIEexFPDX7S7tvAsFZID07KaMOAxxLk0AhEMehoaqN+R8pKY
	 trhxtpBrXqR3euCLk/QM5H2MRcQwn6vL86AJSB2d5fhkSsMp+LEzI6GQIX/HRK3UPgv0t
	 MBnIeLM9iCVsL0ug+9H1T/ny6/mDtqpkidvgDKnCPkwWVmqP6vz8LAzdqEp1zfQw+tQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qi04bJaQ;
	arc=none smtp.remote-ip=74.125.231.133
Received: from mail-oo2-f5.google.com (mail-oo2-f5.google.com [74.125.231.133])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241F1606A6BF
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 20:16:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 241F1606A6BF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qi04bJaQ
Received: by mail-oo2-f5.google.com with SMTP id 006d021491bc7-7033e26cb19so1878168eaf.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795637783; x=1796242583; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=moswij1DxNlgtZ2psQp6vB5WbP0Zx8EDmr2Dk41oG4M=;
        b=Qi04bJaQ4HhiSJ//koZXkew6zDX/nHhlJInUxqfzQYe7eKa/6O8j71LniMHfnIzz6p
         M/UGrlWpRLDobK2L+3YOCH3Xxx7w36xy1nTSjgB/cWPAmYaXB1ntuZU7JH6oPEKWaYxv
         MrvH2+bnW0VfLTGfohB3OjgBEoL/sF0IfRcUrDpkCMILCwdkWUvmPu6TX9UDk2l9J2xm
         GKpWoHkF3U2r/5+iBIcbtcbbpO0NflYhrzN/KBrRypqfW15C3MmSF2R5eu3F5tehHTf4
         9C4y9RwBpu70nqwd03wpoT9Y+N+ZJJYlUNuiSjKHD4p9nbS0o1Cif4Cpe3kTcErFgR7z
         u0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795637783; x=1796242583;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=moswij1DxNlgtZ2psQp6vB5WbP0Zx8EDmr2Dk41oG4M=;
        b=biF4Qd9dk30XWnxZ7yxTO2NpM56lkfKowsx94ll7fs8k0vN4E4A18sWqFJH6kzoOas
         /Ny80BZkJt2iadoaq9W26Gx7CvOI4CIxvB153GFbOTK6jGiNAquiXYqWBZrxxpt2KxL2
         JgE20ZGFx2fu2hN1o19dy8EpPIFCmjAO3KBOQwxjN4FIiPK1G2XeamOiN0zmENcQ50sl
         ObrF62vbev077fKvSCyBIivFaYQjU3WRQnJPr/NReY+MSESzvWdnVp3z70JE5nBDpCx4
         tblmsha4YYjIliQzL4RRN5LWic3NvuP2LJFQQyHK9rNskuMkWrxKRlLKep694/SaGH4P
         9Xgg==
X-Forwarded-Encrypted: i=1; AL+hErGkyRnfS6FEmYJ/CrqIRRnsZB0hwXtDFIkDfirDqWoVDi8JagYhEje509KBs6lTXMnRCgToUbg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8wZhZjtPHD7uRnXjEoWQxFzdw5vEhicLfkcItIlvbEC2u9tAwF
	qQAZ7vdJVeY70WAAoJakwQbPINbUuZIxRzBAlYoJgBaVeEP3BP4x7Hta
X-Gm-Gg: AZFdTZfB8ZZXSDmJ7tE2RpliKQ0/phTcfK4j3gPkXCOBJU3SvrH9kPzmjs02bDC1gjS
	Kl4++9qNGd1LT4RWLZViIzMrQPNvptIwiwk8n26E7iuX2eCCCVFAgxYgw4toykfRw1RtoSozAyb
	DV6LGCOnWqk2dsbwn0As30ZqDnEp5CE1QuFXLXqlNiW4D7BEAFNZr0AUU5FXgqV5mbeYMwyp7ul
	U5MpFG7FVoOkmONni3AiocKq+YLTYrU2j7tyL3uAn75wiN5pmfwsNL590vhyGE/AKUpGNai1C8N
	RmBakOknJK6Te9YuYYjkTrX76P1kO0UoVgx2cUbCbtangB6IXU0PUZiwcEXAZeWZkR69Ni2qzV2
	L3EWfijSYYFA8ZRfTN+82JQkHTTptoV/9us0bWqDetKeR9FrEQh8fEwFK8mstW83FV9JRZrR7Ow
	JpPwzWFORHEkNy3gfnrdmTYjxnyymjyG9G69MaLfyfpqBVxAMZFQ6UIoZeFEDRVBvho4JHjkFxs
	CDs2xaqE/nUDlxnSya6WySlWw04Am5yUr7MIsaDgWFxaNkUeJgm9EIEh6GnaC2dBNrCkLxk3ft3
	eKJbJ6Wcyjm2ikqzTNchJbHFACbsWxdzQAJi90/PgQfijpZE5tZHsWF1
X-Received: by 2002:a05:6820:1c92:b0:71b:7929:cb54 with SMTP id 006d021491bc7-71b7929d44fmr3615961eaf.38.1795637783065;
        Wed, 25 Nov 2026 12:16:23 -0800 (PST)
Received: from [192.168.0.98] ([50.26.120.197])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b380b6f82sm11341859eaf.10.2026.11.25.12.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 12:16:22 -0800 (PST)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Date: Wed, 25 Nov 2026 14:16:10 -0600
Subject: [PATCH v2 7/9] media: mtk-mdp: Refuse a format change once buffers
 are allocated
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-rbrue-suez-upstreaming-mtk-vcodec-mdp-fixes-v2-7-fdc047cf75a5@gmail.com>
References: <20261125-rbrue-suez-upstreaming-mtk-vcodec-mdp-fixes-v2-0-fdc047cf75a5@gmail.com>
In-Reply-To: <20261125-rbrue-suez-upstreaming-mtk-vcodec-mdp-fixes-v2-0-fdc047cf75a5@gmail.com>
To: Tiffany Lin <tiffany.lin@mediatek.com>, 
 Andrew-CT Chen <andrew-ct.chen@mediatek.com>, 
 Yunfei Dong <yunfei.dong@mediatek.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Hans Verkuil <hverkuil@kernel.org>, 
 Minghsiu Tsai <minghsiu.tsai@mediatek.com>, 
 Houlong Wei <houlong.wei@mediatek.com>, 
 Enric Balletbo i Serra <eballetbo@kernel.org>, 
 Eizan Miyamoto <eizan@chromium.org>, 
 Francois Buergisser <fbuergisser@chromium.org>
Cc: Nicolas Dufresne <nicolas.dufresne@collabora.com>, 
 Youngjoon Lee <getfeus@gmail.com>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 Ryan Brue <ryanbrue.dev@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795637766; l=1974;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=ToIzGemh2HZYfPM+0fU+WVM5fBqJcWgALuaETYVwNso=;
 b=YyKMx+idzrYsHi5C/jJHDCr8A4+FV3/lteY93PlNVBFkvn2Yc532M5WpbprdE0h37qx239ObY
 NbKcfOxO94bBh6twJeOGkYBw44Fa9nxQDmOu8P83mq+1flUeTlwmTUz
X-Developer-Key: i=ryanbrue.dev@gmail.com; a=ed25519;
 pk=KsUvVaP//v/2q+ZBuacc7cLbsyEYn+AD71Sn28oZWKo=

VIDIOC_S_FMT stores the new format in the frame before it checks whether
the queue is streaming, so a refused change still takes effect: a client
switching a streaming CAPTURE queue from NV12M to YUV420M gets -EBUSY,
and the next frame is set up for three planes in buffers that have two.
And the check is for streaming only, so a format set after
VIDIOC_REQBUFS can need more than the buffers already allocated.

Check first, and refuse once the queue has buffers, as vb2_is_busy()
does for other drivers, logging it at debug level since any client can
trigger it.

Fixes: c8eb2d7e8202 ("[media] media: Add Mediatek MDP Driver")
Cc: stable@vger.kernel.org
Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
---
 drivers/media/platform/mediatek/mdp/mtk_mdp_m2m.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/mediatek/mdp/mtk_mdp_m2m.c b/drivers/media/platform/mediatek/mdp/mtk_mdp_m2m.c
index e0627127430b..1be0f44fe1b2 100644
--- a/drivers/media/platform/mediatek/mdp/mtk_mdp_m2m.c
+++ b/drivers/media/platform/mediatek/mdp/mtk_mdp_m2m.c
@@ -698,6 +698,12 @@ static int mtk_mdp_m2m_s_fmt_mplane(struct file *file, void *fh,
 
 	mtk_mdp_dbg(2, "[%d] type:%d", ctx->id, f->type);
 
+	vq = v4l2_m2m_get_vq(ctx->m2m_ctx, f->type);
+	if (vb2_is_busy(vq)) {
+		dev_dbg(&ctx->mdp_dev->pdev->dev, "queue %d busy\n", f->type);
+		return -EBUSY;
+	}
+
 	frame = mtk_mdp_ctx_get_frame(ctx, f->type);
 	fmt = mtk_mdp_try_fmt_mplane(ctx, f);
 	if (!fmt) {
@@ -706,12 +712,6 @@ static int mtk_mdp_m2m_s_fmt_mplane(struct file *file, void *fh,
 	}
 	frame->fmt = fmt;
 
-	vq = v4l2_m2m_get_vq(ctx->m2m_ctx, f->type);
-	if (vb2_is_streaming(vq)) {
-		dev_info(&ctx->mdp_dev->pdev->dev, "queue %d busy", f->type);
-		return -EBUSY;
-	}
-
 	pix_mp = &f->fmt.pix_mp;
 	for (i = 0; i < frame->fmt->num_planes; i++) {
 		frame->payload[i] = pix_mp->plane_fmt[i].sizeimage;

-- 
2.56.1

