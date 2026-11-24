Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795526306;
	b=1J9NZiNYS/Ibczi4geW5gQg+97MNqjh8cWUD0HVcZOrTp+YTtKDqyb2Km2Lg9cZH0ruq
	 Sk6eHuDqHvbHxv9QVvbI0w4BH25naFfDN1Ood/rUcVeeOqwiIjNseKpamzcp8HWsMOv82
	 BNTNgOw5H7TR4EeggE3LbJkcnpJYRPz2D7j2AONbonJiEqtLc5+oI2wNK3N4w76+hEAx5
	 kxond4/lXTJg4zGGyLO0i0xLOvXPuwq6tJtCXQoJeA/PVp+uW8IvK+KbjCcaYlbtJ7OYu
	 W73IXLI6YQlI3ZqTVD9NglsZutsea36GsI+5FvazF/e8YhjVi95lvCU89j4k6bYfGQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795526306;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=R7P13K/7gG3j7Sdw2/bXjTTm8YI1OdWUIdO2o+cc/x4=;
	b=S+P8xLuDQhMKnEtmWUhtyRoDWzejdzyoq3UFftxzxTElnFirj6YLU2h8lXGK2vNuUTx7
	 vnv/rbtdYwqkxn5I+WquRLuu3eocFjHISotMyOFat3KKn30Mzq7zZlc3Ua9n97klcDxjV
	 6QSuWJL1TdKdAOklxNtVauyuRvXBy3wfnpjWDZYX8wXnu4n6DwCTqg9tCIQcFo9TSNMiH
	 dF1ilFAqT5kI7Ej6mSJ65AwByNtQbbxCtydj6NrBJ8qYlN6m6upDjX+HxlXFxSwyvSYBo
	 lOPNfSH/83Q0utK6p4fzPvt4fRBJpkIMMg10ncE8sos8yYEAlvHRVoPnPuU64koj3kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b="NL9ibpX/";
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FC8606A322;
	Tue, 24 Nov 2026 13:18:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5FC8606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=NL9ibpX/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795526304;
	bh=GYr0Q0EwABsuRiokJjoVaEcIUoL1Wcs+cF91nQ3RLaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NL9ibpX/RiRTvzWOOboZox5WC3WHJaf4GouK+EUGnv+VOrFwTZifPzBjHynHqA46j
	 LRBqyLxPKWkEaaLY+WknPwS7x7GcCKOLlSW+tNh5jPzs2M80GyLvUOmMQUIHzY4e1L
	 9wYgFl/cQRATQwj9b6tAr+HU/o3MiqbVqRJtBuAFnjSJjwNKGhEHgVACa+fZryvxwh
	 AFlyMjO03pEpB9LV28EDCmruBXrOJA4nAjmNnrCwX11ZppF57FZLC8lMniDTQsqXT8
	 3LSxrJTcyWs8V9SX1dIK6G42pKtoxvnLDB/KbUfPd23a6dGUIhAOA3/UXhwIngygC/
	 0EHUrWe/ghPoA==
Received: from benjamin-XPS-13-9310.home (unknown [100.64.1.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1ECF217E0CA0;
	Tue, 24 Nov 2026 14:18:24 +0100 (CET)
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
Subject: [PATCH v8 2/3] media: verisilicon: AV1: Fix luma size
Date: Tue, 24 Nov 2026 14:18:15 +0100
Message-ID: <20261124131816.115131-3-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124131816.115131-1-benjamin.gaignard@collabora.com>
References: <20261124131816.115131-1-benjamin.gaignard@collabora.com>
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
changes in v8
- add Reviewed-by tag and CC stable kernel.

 drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c b/drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c
index bbfca34688eb..afa91a6c503c 100644
--- a/drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c
+++ b/drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c
@@ -215,7 +215,7 @@ static void rockchip_vpu981_av1_dec_clean_refs(struct hantro_ctx *ctx)
 
 static size_t rockchip_vpu981_av1_dec_luma_size(struct hantro_ctx *ctx)
 {
-	return ctx->dst_fmt.width * ctx->dst_fmt.height * ctx->bit_depth / 8;
+	return ctx->ref_fmt.plane_fmt[0].bytesperline * ctx->ref_fmt.height;
 }
 
 static size_t rockchip_vpu981_av1_dec_chroma_size(struct hantro_ctx *ctx)
-- 
2.53.0

