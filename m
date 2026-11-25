Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.128
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795637782;
	b=yyDXXT4kRGlGBHxV6Fm/FgZBPlDo8c2jt5lO7QglkbbcwvggNQJIqKPZD7neTOaseSBD
	 9r0xQgeyaluMeucvJT7u2IvaH2+KFtAExIE0YYwFrGZxFc/1r+xuUXkeagVcvOquTPYsw
	 40nNJBd6llztJ83Cm/n2PyFKza4wP2LbOR51YIvRjOHZXuIzIXVrcTYCFPrU4zkGVhIBr
	 si5S8her23tDwT3QMcrxrinyXillS8rYvoUFc2qH0BZN6mvNc0LQTWBNYyULjdgUhv+lw
	 2w/5dVDrFfYdObpBiFIlDye4PWINnwTjp5bDuHFDbGltsBmKVuZ/D/7vijufNeg5ang==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795637782;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=O3cn42cRp9ta80RYl78FVY9fV9o47ecym0lO2qR+MbY=;
	b=IrLyyN7kt1IZumMco8eImiVxnTbE492tUl6Naie35FELUiN6lRSBKlQsid2rKD4tVGxC
	 pA2DJmzI6emwH8b2Mmd5BwM7lt7YPC+3z1Gevp32w3je9McsGcpO6r3aQSOXHIBM83EGu
	 PaDPETeMYto3n1ajYF8TULDQ+cMd1VJus61KZstFBQOux7WywBYepBcXw10KUUuoObF6E
	 3dyqhl6w5qWDlBHcr0DtZAQrPcIJBlHhBiXkZ6dL7rtrF2ptDhCvjeI4974jgNLGvDP12
	 taq6YVzSp98OzWRrt+XKdPRN3b0vFNvpm1o5i0+u6wxhOc6HkyIqFyaIdYwLqdxSs0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nKAzz4ZO;
	arc=none smtp.remote-ip=74.125.231.128
Received: from mail-oo2-f0.google.com (mail-oo2-f0.google.com [74.125.231.128])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FB8606A69B
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 20:16:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2FB8606A69B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nKAzz4ZO
Received: by mail-oo2-f0.google.com with SMTP id 006d021491bc7-71b2862dbeeso1287190eaf.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795637780; x=1796242580; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O3cn42cRp9ta80RYl78FVY9fV9o47ecym0lO2qR+MbY=;
        b=nKAzz4ZOIyu2lk6/PfYMWGjZbp9w/OPXD53ga00wpC/vdxf98iATXlCBnfgMlXJqre
         E8pz8Cb4075PCb1MyfI6/WeSH5zbyBnTu+kYLAIufOm5bQoC6w7uKhA+8hs//dSTkMYj
         ETulmwYwu6sd63Q2IzYT57IJiFOGIAfnaM6qQE0IOzPDh797M1ATVhMiqOs8r4KOIkE8
         bffgcblNDmvs4LdaGh0xh6oOx9lgGACUsp6JtQggJgjoZYMZZt4rotKpcgjXHerAPdqx
         kT47vb+TIRTsgMsjNgLrgpoXuYu3zt2X2TxozqgSExghWZJFiEKHkw2jIQZgaWfaruWP
         mATw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795637780; x=1796242580;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O3cn42cRp9ta80RYl78FVY9fV9o47ecym0lO2qR+MbY=;
        b=D9tfqUwe19UsLlbWSxpBNZ+RrE11/cCc8bkPBYOz5serxo/afIFhBmZuxUAKSX3p2f
         NPUW9HBSvSrrqtzep6siCYaPQ+KXKqMzU1boPASmd6f4GotC8E792smp11G+THWqd4w1
         TXzneuN7ibM3U6yH0Fi1Td65GroMqbCBWrvuN4Y9wOWOvdMUfaodF5Cc/i7iYYrUL+zp
         q0A0uuzEmRVF4vb2zvW2ERCUKSglcKZ1Eu+ot4SUMQk7c/YngWu9TjqadRvU3sGClGDl
         3GDcs5mmNulSMOecH5YhmZ4cEWOdABJSLIuHHA7pQwtAIR7qHq1bnd9ezgLZDsOrndvY
         UHhg==
X-Forwarded-Encrypted: i=1; AL+hErG0J44NS5Q/t++YXtxpzIWWtUsQiPhpii6kLTroSFB+X1o5gYEQoYLH93GrsyrONUympatKloE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+n/IMlX/i47TGnCTKMzILo2Ys1qIMg5uEcjB29Dv9S8xHIK1bs
	cPQDqWYngCg5eJWtiTcg2+qDSdNu/2XAGy6MfnY7OdWnwqscvYOflzOm
X-Gm-Gg: AZFdTZfYib/iKmyjP7rw0pZSw3LfzXXs8V3dw26IuO1ymT69lsmWZdBgjmNlGWtkkRN
	uap1A0IpKL6ut8Hec/OO2Ourj3kN127FcdY9PXnW50Pk1sz/r+nbA5q0ESVIKYLA93zOJ73pV5H
	XNpc7LGAX4mlVRqve6SPnFgn4eyEWZTHHq3MmxHxZRBo0ic5ORsG5cTHd5e5Gv9I41RvIv8ZDQj
	4mH+oFevrEiU4slbSKUCIkehf/Nuuv4w2UmcozN2kE0G1Gl0rpKptLjMlQhx65ynF+Dym/0Kpgk
	alhyF7LZucM0/d0Ih4p/SmFZ0cOq9GOFq+t7P+EmImjAWz8O/MkjTqAedbCjdvnpEdSkHOsLzqI
	VXubNCwVY0cGCfrQ+BiJY+JT0Yto8FkdFfo1CxEKqV0zlq76Dnj23jT81vTQnUWUGvRSoykhC1B
	7vI50Onl+TBJZd5U8dUeaXbmsFEVsnDgtLBPpsJXrINwkRDz0Nsl43UuQiSTzFWKa4mJE1ZEC8n
	RaHvrCw0FDFVMIGL+hpgrsDWqiCq1kRujp3IuDi+t6Sp1GgATtnMahNK6C3WF4ovAznrWZOyAe/
	g48Ls6EfbsfD5Rd68Q8kr7kBC8lAV0gJzz0=
X-Received: by 2002:a05:6820:829:b0:71b:845a:3340 with SMTP id 006d021491bc7-71b845a3cacmr1304758eaf.67.1795637780542;
        Wed, 25 Nov 2026 12:16:20 -0800 (PST)
Received: from [192.168.0.98] ([50.26.120.197])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b380b6f82sm11341859eaf.10.2026.11.25.12.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 12:16:20 -0800 (PST)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Date: Wed, 25 Nov 2026 14:16:09 -0600
Subject: [PATCH v2 6/9] media: mtk-mdp: Check buffer plane sizes against
 the format
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
Message-Id: <20261125-rbrue-suez-upstreaming-mtk-vcodec-mdp-fixes-v2-6-fdc047cf75a5@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795637766; l=1943;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=cuEbWTB4pH0BRk1X8WiZhDbNCpoA3GtHpeZU0Znpd0c=;
 b=Fk4k0A+X9pfrp5/bZ/6fIHGtDbMlWMdQhCZTNBXGLqrrhv8Zz0b1rhsC2ajbotj6wJD+CmQrL
 vLFuz3wryijAdlRCk9T/dEZW1Z9zxE7eokb6NXV/ZzUIE3EVelyj1qk
X-Developer-Key: i=ryanbrue.dev@gmail.com; a=ed25519;
 pk=KsUvVaP//v/2q+ZBuacc7cLbsyEYn+AD71Sn28oZWKo=

queue_setup() ignores the number of planes and their sizes that come with
VIDIOC_CREATE_BUFS and always answers with the current format, so a
client can allocate buffers too small for it, which v4l2-compliance
reports:

  fail: v4l2-test-buffers.cpp(872): q.create_bufs(node, 1, &fmt) != EINVAL

Refuse a request with a different number of planes or a plane smaller
than the format needs, as vb2 expects of queue_setup(), and check each
buffer's planes in buf_prepare() as well.

Fixes: c8eb2d7e8202 ("[media] media: Add Mediatek MDP Driver")
Cc: stable@vger.kernel.org
Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
---
 drivers/media/platform/mediatek/mdp/mtk_mdp_m2m.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/media/platform/mediatek/mdp/mtk_mdp_m2m.c b/drivers/media/platform/mediatek/mdp/mtk_mdp_m2m.c
index a40bcf61b7ca..e0627127430b 100644
--- a/drivers/media/platform/mediatek/mdp/mtk_mdp_m2m.c
+++ b/drivers/media/platform/mediatek/mdp/mtk_mdp_m2m.c
@@ -546,6 +546,15 @@ static int mtk_mdp_m2m_queue_setup(struct vb2_queue *vq,
 	int i;
 
 	frame = mtk_mdp_ctx_get_frame(ctx, vq->type);
+	if (*num_planes) {
+		if (*num_planes != frame->fmt->num_planes)
+			return -EINVAL;
+		for (i = 0; i < frame->fmt->num_planes; i++)
+			if (sizes[i] < frame->payload[i])
+				return -EINVAL;
+		return 0;
+	}
+
 	*num_planes = frame->fmt->num_planes;
 	for (i = 0; i < frame->fmt->num_planes; i++)
 		sizes[i] = frame->payload[i];
@@ -563,6 +572,10 @@ static int mtk_mdp_m2m_buf_prepare(struct vb2_buffer *vb)
 
 	frame = mtk_mdp_ctx_get_frame(ctx, vb->vb2_queue->type);
 
+	for (i = 0; i < frame->fmt->num_planes; i++)
+		if (vb2_plane_size(vb, i) < frame->payload[i])
+			return -EINVAL;
+
 	if (!V4L2_TYPE_IS_OUTPUT(vb->vb2_queue->type)) {
 		for (i = 0; i < frame->fmt->num_planes; i++)
 			vb2_set_plane_payload(vb, i, frame->payload[i]);

-- 
2.56.1

