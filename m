Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01D43B7753;
	Mon, 17 Aug 2026 06:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786949563; cv=none; b=UsMTN7joStdsj0w4H82vjD1XoBOfzuC3hTnUtecmqVmvjivNRzy0uUMYoMjHJjQT/lLc1FTMcyAHmqlSN9rG1DGGSTSnLNBY1bADe1yRVIJnNIG2BGUuHzxyBtd/8rA8lckYc7FCMHHU0GvmsindYK3mVkuUPcZGuuBDW8cGdv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786949563; c=relaxed/simple;
	bh=E/h1hz0wiIQIh9FrugF+dw7I292LKsqzlweQ9JZsHas=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=BU9Zb91UXKr6v4gpfk8/TeerY2PmuTpahuNfkc5PMPGRq2husXJXbddpGK1v9uZXA/ZEMP4+5PY5u93dl1StOykMKJnz+d4Su+fus0AJyLXIjuK3wBMcq4Q1HDAhBapSn+Sz5jhCOX2vc8uwZb1hJ9QYTKOOfIpk+Nomc6WSzys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=R7TPo0Wg; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="R7TPo0Wg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1786949561; x=1818485561;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=E/h1hz0wiIQIh9FrugF+dw7I292LKsqzlweQ9JZsHas=;
  b=R7TPo0Wg8ALM6EAhEPweWsvueVsCUjjEQyyJ+Wcz5x/27YsIg2zjh9gD
   WIX34ep78xOlNv9+oui10wiftfUqh64G77YTGFoY09cYly7qzWRRXlJJm
   HDDzdBr6ZxExuRBX6BW3I3iBpXtCKhqtqrQcQe0DbtYOtWfkfKS6xyHeT
   /Ycdx9wgW2MX/z2Kf23r039DkO+VXSvw5IkooLGszozd3Jd/sUsiLN+1f
   07+P8ig8hlaTphDBvswTnwick4Dhh4kDzth0SO5eLCUmJQWpmFbtKeJ6c
   0r/vEf3YwJJ8LTVjrwVf4t6AClL+1K4gQB8usHPXBtt3zLkSK+vawVc/+
   Q==;
X-CSE-ConnectionGUID: 473NZGg9TB2fyUjPFTh3XQ==
X-CSE-MsgGUID: jfBp422dTL+mNVZvuxzhyw==
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="71930905"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Aug 2026 23:52:41 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Sun, 16 Aug 2026 23:52:40 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Sun, 16 Aug 2026 23:52:36 -0700
From: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Date: Mon, 17 Aug 2026 12:22:05 +0530
Subject: [PATCH v5 08/10] media: microchip-isc: fix PM runtime leak in AWB
 work handler
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260817-balki-isc-prefix-fixes-v1-v5-8-2514df336c5e@microchip.com>
References: <20260817-balki-isc-prefix-fixes-v1-v5-0-2514df336c5e@microchip.com>
In-Reply-To: <20260817-balki-isc-prefix-fixes-v1-v5-0-2514df336c5e@microchip.com>
To: Eugen Hristev <ehristev@kernel.org>, Mauro Carvalho Chehab
	<mchehab@kernel.org>
CC: Hans Verkuil <hverkuil@kernel.org>, Sakari Ailus
	<sakari.ailus@linux.intel.com>, <linux-media@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Balakrishnan Sambath
	<balakrishnan.s@microchip.com>, <stable@vger.kernel.org>
X-Mailer: b4 0.14.3

Early return when streaming stops skips pm_runtime_put_sync(),
leaking the reference and preventing runtime suspend.

Fixes: 314c96e5203d ("media: atmel: atmel-isc-base: use mutex to lock awb workq from streaming")
Cc: stable@vger.kernel.org
Signed-off-by: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Reviewed-by: Eugen Hristev <ehristev@kernel.org>
---
 drivers/media/platform/microchip/microchip-isc-base.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/microchip/microchip-isc-base.c b/drivers/media/platform/microchip/microchip-isc-base.c
index fe5a1fb88b21..e5ecf6ffd24a 100644
--- a/drivers/media/platform/microchip/microchip-isc-base.c
+++ b/drivers/media/platform/microchip/microchip-isc-base.c
@@ -1434,7 +1434,7 @@ static void isc_awb_work(struct work_struct *w)
 	/* streaming is not active anymore */
 	if (isc->stop) {
 		mutex_unlock(&isc->awb_mutex);
-		return;
+		goto out_pm_put;
 	}
 
 	isc_update_profile(isc);
@@ -1445,6 +1445,7 @@ static void isc_awb_work(struct work_struct *w)
 	if (ctrls->awb)
 		regmap_write(regmap, ISC_CTRLEN, ISC_CTRL_HISREQ);
 
+out_pm_put:
 	pm_runtime_put_sync(isc->dev);
 }
 

-- 
2.34.1

