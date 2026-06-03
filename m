Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552AB4028C4;
	Wed,  3 Jun 2026 06:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780469960; cv=none; b=qeVVKea1S8Mx1yUzeXq3b6BGTAgEgXXLrNwoz2KDWpDD+aOmFWYNZSFQNgOWF/V3ABr7X4IRbyBFv3JCFMslW7S85VkB0jmXVJaN5s36l0fgOhYhvjFk65XgvWTeyuUz/cDQg5mdcX9/TlVmp6XMQ3vx1S/N1NV7vDVHHPaku80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780469960; c=relaxed/simple;
	bh=T+zVygOBokk79HhCYGyT4FwHbQ8HXxSoWftezh8efK0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=tj2dZT1CUMiWxn7eFjOJDKXkq1lHPffxldzM2gXH6sTZSFCIuTaUOt/vtZYh5zKbfDZ9zAwymUZTC5/yxlCDduLPmXggQThsQlPCYIttCOe6KhO52clSKMRld6RbP0FyOaALQUC9eFcss99pTrMYeJXgO4kck7iTP7HlKMpA2uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=bBVC98Gu; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="bBVC98Gu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1780469959; x=1812005959;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=T+zVygOBokk79HhCYGyT4FwHbQ8HXxSoWftezh8efK0=;
  b=bBVC98GuJaxiTqR1a0yuNtfQOSN5FZ9IByCHSDK0Xl3vteHvNgGeusXc
   8gizCYjO63nom62a2pade6s5MFfY6iYvqOvTuzqbQxwDkcT0gZQfIDFtp
   00BN3q56mmVRswFspRtBH7TbNDx+4M2lROoo6WXZ5rf5cUERmCFnnHb7I
   GkKYrb5caEU8ZuM8Xn+f32v6fsAsYPexh0/fECHHnXa+64vPPqka8stwZ
   BK6x/Olco655JxVS1a30uO6OiwarKLjhj2ervmRpP3pZviu+i7CR8Guyn
   GXlnMx0feM3hItz7k7FB8lIBrBXOIVoD5w5d0Fq/Cia+C3nS+eoHYdm+s
   g==;
X-CSE-ConnectionGUID: mo+764bxQUmSxHttWELU4g==
X-CSE-MsgGUID: y6isAe4dSlaLhzyySoaMyw==
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="57701334"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 23:59:18 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Tue, 2 Jun 2026 23:59:18 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 2 Jun 2026 23:59:14 -0700
From: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Date: Wed, 3 Jun 2026 12:28:49 +0530
Subject: [PATCH v6 06/12] media: microchip-isc: set SAM9X7 maximum
 resolution to 2560x1920
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260603-microchip-isc-fixes-v6-6-8c3d7474a768@microchip.com>
References: <20260603-microchip-isc-fixes-v6-0-8c3d7474a768@microchip.com>
In-Reply-To: <20260603-microchip-isc-fixes-v6-0-8c3d7474a768@microchip.com>
To: Eugen Hristev <ehristev@kernel.org>, Mauro Carvalho Chehab
	<mchehab@kernel.org>, Hans Verkuil <hverkuil@kernel.org>
CC: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Kieran Bingham
	<kieran.bingham@ideasonboard.com>, Sakari Ailus
	<sakari.ailus@linux.intel.com>, Balamanikandan Gunasundar
	<balamanikandan.gunasundar@microchip.com>, <stable@vger.kernel.org>,
	<linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Balakrishnan
 Sambath" <balakrishnan.s@microchip.com>
X-Mailer: b4 0.14.3

SAM9X7 XISC uses the same image processing pipeline as SAMA7G5 but has
a smaller internal line buffer. The reduced RAM constrains the maximum
horizontal resolution to 2560 pixels (compared to 3264 on SAMA7G5),
resulting in a maximum capture resolution of 2560x1920.

Co-developed-by: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
Signed-off-by: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
Signed-off-by: Balakrishnan Sambath <balakrishnan.s@microchip.com>
---
 drivers/media/platform/microchip/microchip-sama7g5-isc.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/microchip/microchip-sama7g5-isc.c b/drivers/media/platform/microchip/microchip-sama7g5-isc.c
index ca23e8adecbd..4119cfe12cdf 100644
--- a/drivers/media/platform/microchip/microchip-sama7g5-isc.c
+++ b/drivers/media/platform/microchip/microchip-sama7g5-isc.c
@@ -55,6 +55,9 @@
 #define ISC_SAMA7G5_MAX_SUPPORT_WIDTH   3264
 #define ISC_SAMA7G5_MAX_SUPPORT_HEIGHT  2464
 
+#define ISC_SAM9X7_MAX_SUPPORT_WIDTH    2560
+#define ISC_SAM9X7_MAX_SUPPORT_HEIGHT   1920
+
 #define ISC_SAMA7G5_PIPELINE \
 	(WB_ENABLE | CFA_ENABLE | CC_ENABLE | GAM_ENABLES | CSC_ENABLE | \
 	CBC_ENABLE | SUB422_ENABLE | SUB420_ENABLE)
@@ -432,8 +435,13 @@ static int microchip_xisc_probe(struct platform_device *pdev)
 	isc->gamma_table = isc_sama7g5_gamma_table;
 	isc->gamma_max = 0;
 
-	isc->max_width = ISC_SAMA7G5_MAX_SUPPORT_WIDTH;
-	isc->max_height = ISC_SAMA7G5_MAX_SUPPORT_HEIGHT;
+	if (of_machine_is_compatible("microchip,sam9x7")) {
+		isc->max_width = ISC_SAM9X7_MAX_SUPPORT_WIDTH;
+		isc->max_height = ISC_SAM9X7_MAX_SUPPORT_HEIGHT;
+	} else {
+		isc->max_width = ISC_SAMA7G5_MAX_SUPPORT_WIDTH;
+		isc->max_height = ISC_SAMA7G5_MAX_SUPPORT_HEIGHT;
+	}
 
 	isc->config_dpc = isc_sama7g5_config_dpc;
 	isc->config_csc = isc_sama7g5_config_csc;

-- 
2.34.1

