Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795609721;
	b=UG7BTLcHALd6Xe7c6iEbor7BzXRQUp0qzLsqUfPE4+NAiaCi/ujNe4/6OBc6pMWwNl+l
	 jHWqqElldFkab/Ax8MI1mfIALcEs9v5ef8qF3N6Ou0ea30XJ6PDtLW3+UwA80AGzw6WHp
	 VjRb0oSPbEdeCGAe/iNYqSgtdfAFhGuqdLqqXXcQpt2JqecLvDJkKZ9UATddqTil9OmpE
	 YE3LZ/tkTFc8vKzkX/JzyXHQGZkY9qhoTs478Y1KNPy11Lwrhc5YalqAcfOJfcAVU5qDZ
	 TeSaDi9f6cmH3Owz8Wy7svUxAM3JPPZWIsi/h6EdwsViriESpA717sJY+vXYyTlY1fA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795609721;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sND+NEh1U7ec3zRhuBVC2cOrGYzuk39FS8iFLI3SGKw=;
	b=Hug7qllE4iHfuJoWlh6pZHZJmBbwPK1TiiFjs5pKfTEpJSm4uSSIDwDqu3vBeQRhpuRQ
	 Wo08L5vQUe7wDTYgwWAWlxGwqRCYPsLjxfn63/580ttC4SUszd+APfqp2KwwhZN1ojN47
	 1GGSbvrbm5G68psmahMp6TgCokCVa4LHsNbLcrWZtVTNriZyoOEpGnG/40FN2Oljc7IsD
	 bDEhZS5xbx2OhxBQeFzz93NCjBsEuNbMZdaleeYkPmcB3LrTZoEW6P2S6c6we23y0pI51
	 9sRPH5B2cnCs4iho/hskFRcG2OtLMhh7oYLYhaLdL/NPohRVcXrjiMUFrYRl60fygZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=P69EQ0nQ;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1F5606A321;
	Wed, 25 Nov 2026 12:28:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A1F5606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=P69EQ0nQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795609712;
	bh=CS7dmwAJB+LPTlLHZFV68ZX+5emOwH579RTQInfKmB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P69EQ0nQBmIA7x6NDluOH5IoF5q2hRKXIny3Gwpkms/UBfGG9sMu+bUCho3OWe4pL
	 MfmSLqqIysoUIYAMlH7fOtIKVw7VK45aqnaw+1aoQ8adKg0pz3gN4p8qEDGJ75gBBu
	 arvY+B4cBeI3hiYQ8SGl4eR1/7fPGqah2q7CMNmKgwRiXVhX7b4zvKBic7J1kkzzY5
	 2t+9wezfxZ0Eotd5RuZw0LqwGPhJYVih7m1kgXO3SvGYjc1b1Y6890zf4JrOBEDLT8
	 1HaR+sT35v1sZn1nFYRecG+xGtNAXqEtzwljSZrVUr1b/9wPLXzUBDaTK3eOX3dxdm
	 qevsk5XPHYzqg==
Received: from benjamin-XPS-13-9310.home (unknown [100.64.1.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D245717E0883;
	Wed, 25 Nov 2026 13:28:31 +0100 (CET)
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
To: nicolas.dufresne@collabora.com,
	p.zabel@pengutronix.de,
	mchehab@kernel.org,
	heiko@sntech.de,
	hverkuil@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	stable@vger.kernel.org
Subject: [PATCH v9 3/4] media: verisilicon: AV1: Fix luma size
Date: Wed, 25 Nov 2026 13:28:24 +0100
Message-ID: <20261125122825.236422-4-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125122825.236422-1-benjamin.gaignard@collabora.com>
References: <20261125122825.236422-1-benjamin.gaignard@collabora.com>
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

Use the values computed by v4l2 helpers to get luma size.
Unlike before this will also take care of padding.

Fixes: 727a400686a2c ("media: verisilicon: Add Rockchip AV1 decoder")
Cc: stable@vger.kernel.org
Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
---
 drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c b/drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c
index 087a944b3394..5c2ce22c17a4 100644
--- a/drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c
+++ b/drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c
@@ -214,7 +214,7 @@ static void rockchip_vpu981_av1_dec_clean_refs(struct hantro_ctx *ctx)
 
 static size_t rockchip_vpu981_av1_dec_luma_size(struct hantro_ctx *ctx)
 {
-	return ctx->dst_fmt.width * ctx->dst_fmt.height * ctx->bit_depth / 8;
+	return ctx->ref_fmt.plane_fmt[0].bytesperline * ctx->ref_fmt.height;
 }
 
 static size_t rockchip_vpu981_av1_dec_chroma_size(struct hantro_ctx *ctx)
-- 
2.53.0

