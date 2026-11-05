Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793889323;
	b=3HK8wF7oL3JQO57VK00BCWHFic8v7Wv2X8n0jbLrXR2YiOTGXS4ntv4L57+aYcWO0M4K
	 UEjP6nPfYR0PsdCfjOjPS/D4/eIHhTbjTHWcrfuJh2QQtbH+lfnWRH6g6hCq8Om3xLLwV
	 uYzsZdBuEHS8MVQfbPYO8MjGL/Wn23bOftj66WArKqBqKv41s7aBjefhpA6E2ScmH4NRS
	 2U06bnZsRihuvWKgmJSdT/eZaWBZYfRV2QL6P6Q/E6a1COi+vyCCu4UvGS/njGtWxPEBl
	 L+ZrDzp3nurYbqhhTbBWXXhgHfkT0BHddyN7qLFpM5NnvoBSXwTou2MGsYS0GLd1raw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793889323;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To:
	 Content-Transfer-Encoding;
	bh=3K+RhTssrQEI4YZo9lHsW+NPw4QK2kM7MG++s72az/g=;
	b=lMJPqpy4bh4/eh9FUmYwucO2VUX9VwRdIwacyqluPVEWLVkrkpSJ9TcdxTWksnXsf5rl
	 OC06JhsQuleDpvh+p8m6h9AgHgxaslCqpzLxn7n8Hn/NDXpPLOgD9OGmlioyTiPw/6T6+
	 qYmdPXkwG6/N7WjzAnGYcyTUPb/Uphl0/eHLvIeY7b4a78NPv9ryJVlfNuFlJYoPDbrhm
	 gjkTZo0gyhWwp1c64cgErt/xmZIaGwC1O3JsiRVdISCNX0jyLPXBSAdM+7Jk5U6ExOMmQ
	 pw4k4tuaoMj7RfQCA8aRQCr/2UDqA9efi6B3+Oy0MzudrcA7uOjMUYHiSFFSWJH7lPA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z77aPEYc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A423606A328;
	Thu,  5 Nov 2026 14:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z77aPEYc
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793889323;
	b=YwJKNiLSvKRJtzEUAFkF91Wl0+3WB8C4kGJ1W9uBXz1vs5Z19UWRzWxRfGeciFRj9tmD
	 L1TAl14ZDFAKIVTkVV+0/3OGmgCAqP/N5oD9eItMsPmJmD4KHL/FOeB+ewPyejxJKG39p
	 BV2TWPXv5gdxep4SsRG5pvoopinzHnS9GT/5WGkB3iI3u7T6OEsqUUmvhlAWdg764MkAM
	 EAxkn5HqA+D9Hdf4gQpWCae1AGXYgygRY5rZrgbttioIfHo8hHQ7TKjWPjIqM4K48nhIL
	 DmUn4EpGcCt7/u83Clxt7k1vEC5tF9VDEacYJ6aoraXjU7Rq8WDnnAqh0bnzT7V0vag==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793889323;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To:
	 Content-Transfer-Encoding;
	bh=3K+RhTssrQEI4YZo9lHsW+NPw4QK2kM7MG++s72az/g=;
	b=OIk112hfWgWQfcWUiG4vmrpbPwzPEpRC96Wr+cssCKIpHeOoGLWRXzMGvY9h640JBG8n
	 gv7uHkQ1q3JELrhoXQBghrcJ88bKju4m60aXf+iRA4jFkOrGTrL8UKEd/s7KiT5G+b+4P
	 9NUL4Mj2abEBQBfBFyV0jBQOxeixl1FUsYH+B1bEa/BqiatiKS/gYc/+DYcMARG8RqMPX
	 I6In4PzII+dSvTCMVZMhLlRoElhvsiYxFR3n9ZaVupX141Lhm1K9z7Ql3vr1iJtdTQ0Pv
	 +6yAhDbLXtV1UAlgu1X+rnVAEfXcvgTGxZZcwN/JFhhasBGXVOg/EBZVayevnzUVWYQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E687F1F000C1;
	Thu,  5 Nov 2026 14:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793889323;
	bh=3K+RhTssrQEI4YZo9lHsW+NPw4QK2kM7MG++s72az/g=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=Z77aPEYcMWkAWsUqSnH9UzxatTvmBtjsljekMnAByVogK67hjKbDbOy/0sVLqNMYE
	 ddTRlmkRBGhQEL8mnqzNIqxEHrjoHTVxu6rT1jeV/4woYFcerXLX+8DsONEPHvSnNf
	 Srw9yJcR6c+Ft8fkpvFKUDlTVjpWxzM3h8Jixi49cmOMd/2aVZy3zNqn68JQIZcxtd
	 rXDQWeb8HXgu2G7yZqwkHuYF93IZZj1GPed4D/hglMd4sHX0RDKLgJDuPUFimTinzD
	 UZ1mw8RAoFcQgm8Z3NnctnrGI490bqKplvwysSQiHR12LpIGf72fcMIYx9NqzcuyoC
	 ZrfWpmT6lyC8g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 464C2472B5;
	Thu,  5 Nov 2026 14:35:22 +0000 (UTC)
From: Ben Grisdale via B4 Relay <devnull+bengris32.protonmail.ch@kernel.org>
Date: Thu, 05 Nov 2026 14:35:22 +0000
Subject: [PATCH RESEND] drm/mediatek: dsi: Fix handling of long packet
 reads
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
Message-Id: <20261105-mtk-dsi-long-read-v1-1-0b6d9b67c011@protonmail.ch>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 CK Hu <ck.hu@mediatek.com>, shaoming chen <shaoming.chen@mediatek.com>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 stable@vger.kernel.org, Ben Grisdale <bengris32@protonmail.ch>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793889321; l=1763;
 i=bengris32@protonmail.ch; s=20261018; h=from:subject:message-id;
 bh=VXV9DuiW9rx/vH2b4BfioyjlslOvRRPzghK8kVYZ1/0=;
 b=XjMPJTyBrxC8GcQXU4Xc888DUrmAcQ8CQFMmTuLs1KLt6phlxiKfEhGbE+pGWUgA6C+EVwIob
 yH8TFU7VXmwAcVXJ0pyd2yVg0U+p3LsAvEeE3lNBv338z8Tpq74YB/P
X-Developer-Key: i=bengris32@protonmail.ch; a=ed25519;
 pk=4ewFRC2yNph/tXokHVzIDlgOA9Hxecf1AlBuD4eOnaU=
X-Endpoint-Received: by B4 Relay for bengris32@protonmail.ch/20261018 with
 auth_id=1233
X-Original-From: Ben Grisdale <bengris32@protonmail.ch>
Reply-To: bengris32@protonmail.ch
Content-Transfer-Encoding: 7bit

From: Ben Grisdale <bengris32@protonmail.ch>

mtk_dsi_host_transfer() decides where the payload starts in the
received data based on the byte count returned by mtk_dsi_recv_cnt(),
treating anything longer than 2 bytes as a long packet.

This breaks long read responses with a 1 or 2 byte payload: they are
treated as short packets, so the word count from the packet header is
copied into rx_buf instead of the payload.

Fix this by checking the packet's data type instead of inferring it
from the length.

Fixes: 21898816831f ("drm/mediatek: add dsi transfer function")
Cc: stable@vger.kernel.org
Signed-off-by: Ben Grisdale <bengris32@protonmail.ch>
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index f82506e10fd5..de4414b51abb 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -165,6 +165,10 @@
 	(type == MIPI_DSI_GENERIC_READ_REQUEST_2_PARAM) || \
 	(type == MIPI_DSI_DCS_READ))
 
+#define MTK_DSI_IS_LONG_RESP(type) \
+	(((type) == MIPI_DSI_RX_GENERIC_LONG_READ_RESPONSE) || \
+	((type) == MIPI_DSI_RX_DCS_LONG_READ_RESPONSE))
+
 struct mtk_phy_timing {
 	u32 lpx;
 	u32 da_hs_prepare;
@@ -1171,7 +1175,7 @@ static ssize_t mtk_dsi_host_transfer(struct mipi_dsi_host *host,
 
 	recv_cnt = mtk_dsi_recv_cnt(read_data[0], read_data);
 
-	if (recv_cnt > 2)
+	if (MTK_DSI_IS_LONG_RESP(read_data[0]))
 		src_addr = &read_data[4];
 	else
 		src_addr = &read_data[1];

---
base-commit: 2efb7a11f1aa4d2dc285fe2680cca22cb9f72f64
change-id: 20261019-mtk-dsi-long-read-45bc8e49d08b

Best regards,
--
Ben Grisdale <bengris32@protonmail.ch>
-- 
Ben Grisdale <bengris32@protonmail.ch>


