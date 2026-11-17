Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794940020;
	b=E56vdQUxbpGI8O3Sfe08IAS06/0+xw1fuFZpICHXAHgRFL7kBSTlCRNV+gE9QUYo96Mg
	 cBLsePLw21sABQ4zwcaLyT+62jOo9uFOIiaLdn4TucQpYrCEMxHF3ZGepMJn0mpOyNiGx
	 xqLx73dKf4LmB3Y8ryzo8cmRLC7Jtbj2nE/pzohaHDp7j6hf1E0bdcRa3Jtq4t7nTv9Qq
	 26Rn7slAsXKbzkRDSwmXnIoQO8/tAZ1CjynR7O0f3DjjsIGsgoM2koFW6ayxxhBp+a2KX
	 9QzwXUTmwjswpe038AfLGfb7KCcQVbC71+3tLfSiGBoDGxfPqJ6NW96cLTu95ZTgV7g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794940020;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=LYF4CVJ8Ghw+qIezDl/HP0zE+7oi4oU+1Q0nPJmIKVI=;
	b=bAWEqaOwQrdkH616HQft79FYbRgKT7ON5a95mD5DzZeon8J7UfZ4028+MzZ0mKw6QGsQ
	 /PcaA9NgeHSz6RydCQzzZy7dK+OWndvLdwAH4mwgjpW5w2AnBgrAB/9VcSCjZkRoKSvEh
	 O9xl7B0SIa0osRZ+sUls9dULJWQjKjtMBklAFM3gMsRN3QMLBiQfYu1jOPH6L+QqlY7R2
	 E5LkiKBYzsn4xnWQUhCt1+iy59tCLrOYLls3EtEbJTthyoSHHWJlWHhLaRoPWY972ZhM7
	 okOH1GUvEnLQEgskJ0eWsPEvF6aCJUDivuyeiaP3ETDUdmxbHsQq+KG+r2NSSutz9ug==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g7HJbh0k;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFCB606A32C;
	Tue, 17 Nov 2026 18:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g7HJbh0k
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794940019;
	b=eG+oD5KYzurahi/cOjG0ZlUuBQsUDEqGr1mvthB+bEMSSWXicrUnM/o/kBMuvDyyVdWo
	 vySkJz+5FHPQv3QZ6obbH+8N81nUeRIjk7g0+9bq2IM1+e5oOV8tkZYbTIWElCKMaRcp4
	 RFZasi0UKh6PKBfKnLvkARsOpIZxVzLHdFrNBG+HuAueVb61aNJtNtXMUnhUFiaNRWaSM
	 bMQUPqgPNIX+fXi3qKKIhTTG1S5Nvv5u/pGWDqNHK7AiOBK87VE6GaX2Nv9lPlL+Z8P1F
	 TC8Z2QbRm1AcadOp6NHfzC0exfK+Zuxh9h13ysVd5kxDfkkvNsfMBVCm/gkUgroRdDA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794940019;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=LYF4CVJ8Ghw+qIezDl/HP0zE+7oi4oU+1Q0nPJmIKVI=;
	b=lBfaYejngNCGQGxwwXtjHGqfXvmmRm5JHV0VYrq1/P7O9eRWo+csStf4PysMl4CP74wj
	 89MECEJpYqVFOCAUKdXqtIAU8YTIVrBXUR9cC/kpG+6GQEht8K6YN1b9G5cCWKLfR47oK
	 1A5vKamUP3HLTGHmh3ar7fvcjc0WUSuHdWpdJD7DE602VqsvtGfeVK5MT19+fpGYvwD46
	 jgKtXmJUk5GOjzd3wsKM+3t5Mq6TwG4ZHfhGxRnQOErDAgWDLonq9z8YCQnRzw7SfvQrJ
	 mqZIShvQke3epArtgdwlbXLgegBe0bm8wgbALpViuI+B3mwIKsHvpl6pjSa8U6/XtVQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 612B31F000C6;
	Tue, 17 Nov 2026 18:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794940019;
	bh=LYF4CVJ8Ghw+qIezDl/HP0zE+7oi4oU+1Q0nPJmIKVI=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=g7HJbh0kJ1bbXjsJNG3sCw7etceijrEgdVZSC2Kq8xlw/FtXk3zQNSy/zxmDYL90Q
	 D+9RzEyl5/Fzh6uWWGg6u6zwCFFdTpBcw+XjAdwiQveWTja17FrxniyAapUMFX1+71
	 oL0m2J3TvSOk3biEEFmhjujOxe0k7F5a9AdxJTkUAe+yBG+mK+WMm4fIOnZEivNvp1
	 PYUNCIihea0jJg2FUrWDYqn0TPL0exmmMlJkescJdD55TNZTSw12U6VFrM0SPMyfyb
	 F515IaYXaQowewNmWb6m4zfpx1kK0JuscXRGs2mZQAxrBjzGZdytRK/CrNnrH80tio
	 uyqZlQb/2ZY+w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id BAF8B4AA16;
	Tue, 17 Nov 2026 18:26:58 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Date: Tue, 17 Nov 2026 20:26:26 +0200
Subject: [PATCH v2] drm/mediatek: mtk_dsi: do not enable HS clock in
 pre-enable for LPM panels
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
Message-Id: <20261117-6768-dsi-fix-v2-1-6654a072884e@protonmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNwQ6CMBBEf4Xs2TW0ShFO/ofh0JZF1gglLRIN6
 b9b8OzxTWberBDIMwWosxU8LRzYjQnkIQPb6/FOyG1ikLlUIhcVqlJdsA2MHb+x6nIrrZZGVx2
 kyeQpxbvu1vw4vMyD7Lw5tkbPYXb+s/8tYuv9US8CBZ6oUEKZc6FVeZ28m904aH4erRugiTF+A
 cIkbcS/AAAA
X-Change-ID: 20261019-6768-dsi-fix-9f0c2ca2ba9f
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 CK Hu <ck.hu@mediatek.com>, Gary Bisson <bisson.gary@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 stable@vger.kernel.org, Roman Vivchar <rva333@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794940017; l=2543;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=Lmo+5kbfdhXSBeVl18KCMC7yQm1ZpbbeRqyQNhndmfM=;
 b=4cctPZqiPYOTFYm5f9KbX1qIbmrwgUMDZn5C/SCuCPWiGSIZMBOn7/6+BS55Ty8Nx2qdytxty
 JuVKDlt1HbEC3rtQF+GQg2mYKfyvj0w8F68zYms8tni4BT2lDZtX7Hz
X-Developer-Key: i=rva333@protonmail.com; a=ed25519;
 pk=zww/nWjBGoQ4POXCG0BV6fx2iuXK6jx77rsKPA5YK5Y=
X-Endpoint-Received: by B4 Relay for rva333@protonmail.com/20260510 with
 auth_id=777
X-Original-From: Roman Vivchar <rva333@protonmail.com>
Reply-To: rva333@protonmail.com
Content-Transfer-Encoding: 7bit

From: Roman Vivchar <rva333@protonmail.com>

Commit 76255024cadb ("drm/mediatek: mtk_dsi: enable hs clock during
pre-enable") moved HS clock enablement from mtk_output_dsi_enable()
to mtk_dsi_poweron(). Later, the commit 3e191eddbdcb ("drm/mediatek:
mtk_dsi: Enable HS clock only at pre-enable") moved the call to the
mtk_dsi_bridge_atomic_pre_enable().

However, mtk_dsi_lane_ready() explicitly sets mtk_dsi_clk_hs_mode(dsi, 0)
so that DSI panels with MIPI_DSI_MODE_LPM can transmit initialization
commands in Low-Power mode during their prepare() callback. Enabling the
HS clock unconditionally in mtk_dsi_bridge_atomic_pre_enable() overrides
this before panel prepare() runs, causing command transmission to fail.

Only enable the HS clock in mtk_dsi_bridge_atomic_pre_enable(), when
MIPI_DSI_MODE_LPM is not set, and restore mtk_dsi_clk_hs_mode(dsi, 1) in
mtk_output_dsi_enable(). This is a no-op for non-LPM bridges.

Fixes: 76255024cadb ("drm/mediatek: mtk_dsi: enable hs clock during pre-enable")
Fixes: 3e191eddbdcb ("drm/mediatek: mtk_dsi: Enable HS clock only at pre-enable")
Cc: stable@vger.kernel.org
Signed-off-by: Roman Vivchar <rva333@protonmail.com>
---
This fix was tested with the Tianma NT36672A panel on the mt6768 platform.
---
Changes in v2:
- Call mtk_dsi_clk_hs_mode in mtk_output_dsi_enable only for LPM bridges (CK Hu)
- Minor commit message grammar fixes
- Link to v1: https://patch.msgid.link/20261019-6768-dsi-fix-v1-1-3e5616b45a67@protonmail.com
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index 7961139333ad..2108b2eeadd0 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -794,6 +794,8 @@ static void mtk_output_dsi_enable(struct mtk_dsi *dsi)
 		return;
 
 	mtk_dsi_set_mode(dsi);
+	if (dsi->mode_flags & MIPI_DSI_MODE_LPM)
+		mtk_dsi_clk_hs_mode(dsi, 1);
 	mtk_dsi_start(dsi);
 
 	dsi->enabled = true;
@@ -858,7 +860,8 @@ static void mtk_dsi_bridge_atomic_pre_enable(struct drm_bridge *bridge,
 		drm_err(drm, "failed to power on dsi\n");
 
 	mtk_dsi_lane_ready(dsi);
-	mtk_dsi_clk_hs_mode(dsi, 1);
+	if (!(dsi->mode_flags & MIPI_DSI_MODE_LPM))
+		mtk_dsi_clk_hs_mode(dsi, 1);
 }
 
 static void mtk_dsi_bridge_atomic_post_disable(struct drm_bridge *bridge,

---
base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
change-id: 20261019-6768-dsi-fix-9f0c2ca2ba9f

Best regards,
--  
rva3 <rva333@protonmail.com>


