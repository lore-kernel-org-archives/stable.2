Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEBE401A21;
	Mon, 29 Jun 2026 11:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782731402; cv=none; b=FVEB0rUypPuDWpGERKnqAOWaFrcB2kZvPuowoobm59BaYdrHAuy3rD7N0dfA3N+ty7KallUNrtx+O7S3PMMI6krUQ8/qQ1+w14+sgTTLo0LmIK/RWtPAdB6j+94j1sh3DJANI2ubDJaXYJdIG82fItMCtxezZXrNXsPC0MuPpbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782731402; c=relaxed/simple;
	bh=qxWdVD0AsoiU45oXdsmwcyX0G+gw2bxgoYJjzFSHfZs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ICLI6T8GrBbSp1ul+hvYnxthnKvd50yTgykRlKz6qAveFr4KvxAI4ArikeV5t3VbQsr4EfvbcijGSmX9cnN5s9dXZZgpBh8PIpewod9M9/CZ6I6BNHnjrqKuwQvorUZLgMUWq5CJpbz8rGSqruUeHLQKT9k6mAQ0UA5S/6pEF/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=HKvbkZeu; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="HKvbkZeu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1782731400; x=1814267400;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=qxWdVD0AsoiU45oXdsmwcyX0G+gw2bxgoYJjzFSHfZs=;
  b=HKvbkZeuGHHr4rGahjl4HO7HO/r4fBBmbrLG6pVzKVIjwdYaEevy6pm3
   rIGARKe0kLGz9qCzJpf0HcGR156XnJjx/Ryu4nqPSlGVyk1wabJiubjR+
   u1F9JZIrCy22ABK9/o433i8KpLWV+Io/KhZgDASc7hEXRAWmhI+kMU7gM
   AZPOFGNaUsIpAmMseNj6EFPTXnDKIiSage9eYydfTLzeY7GsFhVJNcbEh
   Oi4IH0UUvH4EIR4uN446sTXYbeaNKF5d+VwjCd4X+j4gT6ijBFgewhdWr
   cO1ocVGb9ahA6ASgQuxYsrahTjFsn6V0fs4Zkl6aVNr7ZhPFeeCK+kcsp
   w==;
X-CSE-ConnectionGUID: c+kGyjGTTaGkbIwaGQznMQ==
X-CSE-MsgGUID: 2YjBCCn4SS+34Lo4ICUmGQ==
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600"; 
   d="scan'208";a="58973949"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 04:10:00 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.43; Mon, 29 Jun 2026 04:10:00 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 29 Jun 2026 04:09:56 -0700
From: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Date: Mon, 29 Jun 2026 16:39:33 +0530
Subject: [PATCH v2 08/10] media: microchip-isc: fix PM runtime leak in AWB
 work handler
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260629-balki-isc-prefix-fixes-v1-v2-8-3b120cc3742f@microchip.com>
References: <20260629-balki-isc-prefix-fixes-v1-v2-0-3b120cc3742f@microchip.com>
In-Reply-To: <20260629-balki-isc-prefix-fixes-v1-v2-0-3b120cc3742f@microchip.com>
To: Eugen Hristev <ehristev@kernel.org>, Mauro Carvalho Chehab
	<mchehab@kernel.org>
CC: Hans Verkuil <hverkuil@kernel.org>, Sakari Ailus
	<sakari.ailus@linux.intel.com>, <linux-media@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Balakrishnan Sambath
	<balakrishnan.s@microchip.com>, <stable@vger.kernel.org>
X-Mailer: b4 0.14.3

Early return when streaming stops skips pm_runtime_put_sync(),
leaking the reference and preventing runtime suspend.

Fixes: 91b4e487b0c6 ("media: microchip: add ISC driver as Microchip ISC")
Cc: stable@vger.kernel.org
Signed-off-by: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Reviewed-by: Eugen Hristev <ehristev@kernel.org>
---
 drivers/media/platform/microchip/microchip-isc-base.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/microchip/microchip-isc-base.c b/drivers/media/platform/microchip/microchip-isc-base.c
index 4e87e5f45ac4..1a9b97edfa32 100644
--- a/drivers/media/platform/microchip/microchip-isc-base.c
+++ b/drivers/media/platform/microchip/microchip-isc-base.c
@@ -1432,7 +1432,7 @@ static void isc_awb_work(struct work_struct *w)
 	/* streaming is not active anymore */
 	if (isc->stop) {
 		mutex_unlock(&isc->awb_mutex);
-		return;
+		goto out_pm_put;
 	}
 
 	isc_update_profile(isc);
@@ -1443,6 +1443,7 @@ static void isc_awb_work(struct work_struct *w)
 	if (ctrls->awb)
 		regmap_write(regmap, ISC_CTRLEN, ISC_CTRL_HISREQ);
 
+out_pm_put:
 	pm_runtime_put_sync(isc->dev);
 }
 

-- 
2.34.1

