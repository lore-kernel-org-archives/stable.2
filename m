Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793094588;
	b=Lr0PFtugW3WCUyHEwjfPEjeqcoT68v7TQrdu2jQy/6QtcW4pjUiWYKLT5dJ9pVBmDw6H
	 MG8mXgCEwNA/JEufFDZnMRsEdAJMvXzz5KErkmZiqzdXgJAAI+xBvKnyL73TVT/aS/IDM
	 ugpph/pLANmxZjUnFkXPbmylRH8C10bNzFZuRcgsz71YQ+uXAlHI+H5/7axyTRJK0OQqV
	 RYXr30UIrelvE89JXD0v+oMtfMb6WOENeVN4xQNIyufZPxQuItuA4wjBCr/u1QdnmUGot
	 TpUrjoypa/zEHBS41mM7Es9AdQVZG1F2e2PZZr+8m1GMS8LNFDKoUCDQfwHXWKmdX9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793094588;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=bbhL5NLVy9Oz3kDCEpkXfrPMU8gaHJkfwTMkrmkXY+8=;
	b=sWMbf5tAn+0i2ZeL2uJE9UWyVaHJ24NKCMeX55VO4WyO0i4fz45W8GNrGdbr8o++Xy7e
	 cq0bHi3vucBIf/vYSq7GM2oPBl4HxUHFu+jw+d92NVkZaZBxQPoPTOMI1Xc1C/iotDGCA
	 xQt33xv/vSLbXhRhDf7ppaXjB2bvJEy/tqtM8GyICGvYuzgRCuXLILmJqlh0b4RDbGttt
	 Dtgc5ejDSLf5XTT6Wg3Dq0+bDRYMd3SjsozJBA7YvKyvSwr+kMeo1iUhMsZ6zDfo7vbPT
	 PQlRIUW9saD6UDWG0vPqP4YiAlQHsiueZJs8H9C1+0DlFRJxHya+j66ctesSai082tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=Ed37GiXq;
	arc=none smtp.remote-ip=111.22.67.135
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA1E606A31A;
	Tue, 27 Oct 2026 09:49:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1AA1E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=Ed37GiXq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=Ed37GiXqwNsqzNpJ5CXcuYDUd57ahg06bDk5s54HCenDaLHn3s4ms1Eiiz9yJcRGOx+mqh5BbQCct
	 z0mBce5/wqHPSx3rru5d17/YNOU0Pjk5sf8U+Ul7UqxRmA58yrk2a0Zum6OTC5MOC9jjj9moVnuQTJ
	 dPTGVutrj95ReGU4=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee36ae073b6f76-23d0d;
	Tue, 27 Oct 2026 17:49:44 +0800 (CST)
X-RM-TRANSID:2ee36ae073b6f76-23d0d
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from FHA-W6400298 (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee96ae073b5bb3-d716d;
	Tue, 27 Oct 2026 17:49:44 +0800 (CST)
X-RM-TRANSID:2ee96ae073b5bb3-d716d
From: Tang Bin <tangbin@cmss.chinamobile.com>
To: chunkuang.hu@kernel.org,
	p.zabel@pengutronix.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com
Cc: dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	tangbin@cmss.chinamobile.com,
	stable@vger.kernel.org
Subject: [PATCH] drm/mediatek: mtk_hdmi_v2: NULL check curr_conn in pre_enable
Date: Tue, 27 Oct 2026 17:49:41 +0800
Message-ID: <20261027094941.1862-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.52.0.windows.1
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

mtk_hdmi_v2_bridge_pre_enable() calls
drm_atomic_get_new_connector_state(state, hdmi->curr_conn) which
dereferences hdmi->curr_conn (via drm_connector_index) before the existing
WARN_ON(!conn_state) check. Add WARN_ON(!hdmi->curr_conn) first.

Fixes: 8d0f79886273 ("drm/mediatek: Introduce HDMI/DDC v2 for MT8195/MT8188")
Cc: stable@vger.kernel.org
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/gpu/drm/mediatek/mtk_hdmi_v2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_v2.c b/drivers/gpu/drm/mediatek/mtk_hdmi_v2.c
index f0277fcf3..c94d22042 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi_v2.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi_v2.c
@@ -1026,6 +1026,8 @@ static void mtk_hdmi_v2_bridge_pre_enable(struct drm_bridge *bridge,
 
 	/* Retrieve the connector through the atomic state */
 	hdmi->curr_conn = drm_atomic_get_new_connector_for_encoder(state, bridge->encoder);
+	if (WARN_ON(!hdmi->curr_conn))
+		return;
 
 	conn_state = drm_atomic_get_new_connector_state(state, hdmi->curr_conn);
 	if (WARN_ON(!conn_state))
-- 
2.52.0.windows.1



