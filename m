Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795637785;
	b=NZrXCJqaSSlpf/V3KmjISexZLv/IEFZ2cYRaVhk7ZLmir8FuAYyAHiXyWI98NubcG6vH
	 G+2NoJFknh1CJZH6LwxmvEuWu83VublSPP0VmcR6G1fm77UxP0LNl8Oh51pKL0xLGAG6m
	 Ia3C9XUDxwNpDJeaoK0g2UKeWDtZO72KRqPCK5yz8FWPDSl/fBS4tbE61E3P5p923988s
	 tUPNzAr1UBhEk3Knc0zoiEfv2viSn8Z71LD3ngsuYZp/wqiFH98buG74yfR+H9E1q3hN9
	 zKf7MTX8zK48m10MrZOM+XEkg4mgZDgwC5NOANpXP4LcJrBVzJPDUX0WSEAxgvSKimg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795637785;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=0Gf2EAUcJRVl7OuOkX2Dws1/ZTM9OuXnITDMSmBlcuo=;
	b=LG5AI+v7WVj8O/hnLbHptGYbxu9N46Du3+JxBekW9kg0ObPiNjOYQcRtAoGLwYxaFlM7
	 9JIYDI/SlEcmXB4XBvalt18wz3cjiUxF9oMoMAZbrPIHZYlDP6xguNjH67yb3jTfChQNy
	 n+NFFitCnpUEy3L61DbKRhMJZuLF8yf3hJIJlfA1ZzLDKgkhXcGXrVNztx227T5KqDHQG
	 UVGD8FVUXuqLbmPXUoOnanPj1PDBGWx2LE3qmDkMwzY/5noMKOfXK0c1o2j3oRh1mLBx0
	 +zhOWmnLCCdUtej9Cy9E0LsD0ad5h9ubSSBBuDi7vMhsoEPlPdv7AzKLsybQ8IibwjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j4k3tAT5;
	arc=none smtp.remote-ip=74.125.231.135
Received: from mail-oo2-f7.google.com (mail-oo2-f7.google.com [74.125.231.135])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F03A606A6A5
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 20:16:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F03A606A6A5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j4k3tAT5
Received: by mail-oo2-f7.google.com with SMTP id 006d021491bc7-71abadc4460so1916254eaf.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795637784; x=1796242584; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0Gf2EAUcJRVl7OuOkX2Dws1/ZTM9OuXnITDMSmBlcuo=;
        b=j4k3tAT5dAXjGSz03eKpD38liuL+zlc7E0yRO2ftyKb37sTKoTpgmylqgz0too95Mx
         FXWIDtx67QHOR9ZMGnAk5URfhxPUgt1sC9Q7cG9dAKAJDmym8qM08b7eYsUyaOAIHKwx
         Z5TWdU6lqmS0L/GZzDMZBLF7i4h6kuq5E2leywsthFSs1oSKaVt6JKv7n0WSO/PhnbQm
         lI6RRlkI/j2QW8ZtdcZzKRp3YFMpCgNRsoNtfdmxqS8O9JEcWhg82BPbZxbTHe1hH5b4
         QqcWMEV/U7Fw2efUZ03YOhxZqdpNDht/YRhzSBlMwV8iuWIJ0KJgVY+H3C5x2UJZ77em
         NSXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795637784; x=1796242584;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0Gf2EAUcJRVl7OuOkX2Dws1/ZTM9OuXnITDMSmBlcuo=;
        b=2ZCtd8VSDwLWsqh2i9ZjUaoMu3XL5phvq17USXHGZJkBG8eTt48lRfvPtoOWS9IbiZ
         a03g7KuNFx1EY2gtjEw9Wf/40Iw2TOkrXonx5w84bLa4YCQPw4FMgHbnxibc9pXw21Im
         yDcLnlNcuYVHYHxw+BedGJBrAvZ5GBfhauXu6bCQHwIYeYcSBMgkOkpg4r6P2t+ndUiJ
         gpgNgotBQRuKalvDa52MTWwhNVEqtLgPX2O4+dPs7jZN1Prkae6nAKFGpgSTonRe7SnZ
         ICvzWr8/4q6wXXRUmRopS9fCrk2736fer1qgEuSl8gVVjKbXbDcneJpRb8Bx3s1xB9pz
         w83A==
X-Forwarded-Encrypted: i=1; AL+hErFVS6AVd04gX5Hse/PPTMLDTPjBQPIxs/P7qt9js9UJxrtTAzXo/nlgQsQYfo+80bVgvvNCm4I=@vger.kernel.org
X-Gm-Message-State: APuU4Z+XjJmWysKdIRmvO6lHbDUKI3M5+BnsCWTtFT4L28OJrkb4cNBP
	0CvB6mVGSPinpy3FKjxEf5Il6kt9WzQw1KJDbx1pL7HqLb7Zs1nhAiFa
X-Gm-Gg: AZFdTZcdir/Q97qfH4P0LqeTV3r9oGcxs4FkTmtocKDMzuf+UAbAr8VIUFOM1LyEtFx
	0KTGgM652eRqZUwTyt1MFi3LqdyfDsFn9emfBE/HzfDhJSy5Z0W2KXhgurB17c96AoqEvH9qXp+
	3Wtzd22xYMHfBJBvckJFK+lHZntjOKSoEMGTndf2I2Ph2vvYSVnkWqvHIvmEmmE/481FuzXc0Gd
	n8cRDBa70uCG+54OLRND6XtcpuDoHxz6aVfUT8C4p74DunYvv3XBZSIU4tOuoqIsmyY7P1Pa+pp
	vNYryq0sfzqPoGXcYv0/2mxLbu2ExjiwWNi2ujONJwWL4uNtYVRtsc+5HoRgKlAmIcMb1VyPRmg
	cEPQmuRvYNwqqPB2CLalRjj8pQKKXwjDwfT9n2RtKgtqzE9rdrOdcRG4jwQ2MJPHUnoutLpMTKa
	0tWR2wdtn0k1s/DzW1gDph1gvGiE/w2lq2R8pAIFe7mv5pDd+7gQDhVBmybcj3iXivE6Gqnd2Jm
	kp16m3IJrF+JgixRqCabwsfKqYgasJOrrqnElYF39j0vMfWTX0sZ2Qqa0kVmuxOamDZE2DowNNE
	U9L0YupE3a52BPdxtFd5AV6GxynpjeMI/KU=
X-Received: by 2002:a05:6820:1387:b0:716:df3b:e940 with SMTP id 006d021491bc7-71b3944022emr18067391eaf.16.1795637784658;
        Wed, 25 Nov 2026 12:16:24 -0800 (PST)
Received: from [192.168.0.98] ([50.26.120.197])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b380b6f82sm11341859eaf.10.2026.11.25.12.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 12:16:24 -0800 (PST)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Date: Wed, 25 Nov 2026 14:16:11 -0600
Subject: [PATCH v2 8/9] media: mediatek: vcodec: Refuse a format change
 once buffers are allocated
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
Message-Id: <20261125-rbrue-suez-upstreaming-mtk-vcodec-mdp-fixes-v2-8-fdc047cf75a5@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795637766; l=1978;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=z9CNO4bCWGYjNQTDYVvQNuOaV1YRFSzVKYh+7SCdusA=;
 b=GzF6pMC0GCPOHve0CXuogF6oQG8hAnVLXT0K2N9Woit8cMr6jKke65a0sorZ6u3wiUe6HkT/F
 jNzOTZp9VN8A/BhNIpxCSQBMnSCT8Z7NjqdpvTXjWKfxIN/UV3Apuw0
X-Developer-Key: i=ryanbrue.dev@gmail.com; a=ed25519;
 pk=KsUvVaP//v/2q+ZBuacc7cLbsyEYn+AD71Sn28oZWKo=

VIDIOC_S_FMT on a queue whose buffers are allocated sets the result to
-EBUSY, then goes on to store the new format and returns 0, so the
client is told the change worked, and buffers allocated for the old
format are used with the new one.

Return -EBUSY there, as the checks intended, and log it at debug level,
since any client can trigger it. The CAPTURE check applies to the
stateless decoders too, which now also refuse S_FMT on a busy CAPTURE
queue, as vidioc-g-fmt.rst asks.

Fixes: 590577a4e525 ("[media] vcodec: mediatek: Add Mediatek V4L2 Video Decoder Driver")
Cc: stable@vger.kernel.org
Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
---
 drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c
index 1223738ece4e..71db692ed848 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c
@@ -493,8 +493,8 @@ static int vidioc_vdec_s_fmt(struct file *file, void *priv,
 	if (!dec_pdata->uses_stateless_api &&
 	    f->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE &&
 	    vb2_is_busy(&ctx->m2m_ctx->out_q_ctx.q)) {
-		mtk_v4l2_vdec_err(ctx, "out_q_ctx buffers already requested");
-		ret = -EBUSY;
+		mtk_v4l2_vdec_dbg(1, ctx, "out_q_ctx buffers already requested");
+		return -EBUSY;
 	}
 
 	/*
@@ -503,8 +503,8 @@ static int vidioc_vdec_s_fmt(struct file *file, void *priv,
 	 */
 	if ((f->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) &&
 	    vb2_is_busy(&ctx->m2m_ctx->cap_q_ctx.q)) {
-		mtk_v4l2_vdec_err(ctx, "cap_q_ctx buffers already requested");
-		ret = -EBUSY;
+		mtk_v4l2_vdec_dbg(1, ctx, "cap_q_ctx buffers already requested");
+		return -EBUSY;
 	}
 
 	fmt = mtk_vdec_find_format(f, dec_pdata);

-- 
2.56.1

