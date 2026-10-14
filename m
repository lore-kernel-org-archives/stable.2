Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C329852BE3A;
	Wed, 14 Oct 2026 13:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791984636; cv=none; b=RfYRpkVXKNgse8VUXHWYsmekmw6WRVBRfujHNjVEoNLWfdjtlg3b/Lc2UklPeWONeIELlH6YNgHym+vrtNK08iMz9nTouwFS8VG226Ksbag7MVqIfrojyvX40KGxgxgreRlZNpkaRMnANNjAYgiKRu4/9sBv7DMH6iwq4SG48Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791984636; c=relaxed/simple;
	bh=D8m7/mmdSeX30qAgOy4tB3icruu7HHdVj5q066tZQJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HVCMvg0T912EZ2vhdWxoIZy+/TdATUqtstVyyS4uFCH50d9eWZgC3jtrGp83ztBSbAlMRPYGq1ft5v2+wirRDjLy1Q8IRqOEMGLzfwb1VnFJXsHT6kl1zLSVupi1TdjIo9chtCvxq7juZg/ZTepOSqzWLXh0EanEhK12q9BNth8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=Y7d9rfSR; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="Y7d9rfSR"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id C6AC380916;
	Wed, 14 Oct 2026 15:30:27 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yUkkGHMldMnf; Wed, 14 Oct 2026 15:30:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1791984626; bh=D8m7/mmdSeX30qAgOy4tB3icruu7HHdVj5q066tZQJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y7d9rfSRxFPle5Y9z3fgFX2FY2/wckp4x1iD1ERzPkZBVw1pBITJycTEneJwnIKWf
	 yCj4qeFu7Qix7HND4Vh9PUuvSQMZohqgg/ZMGAyosKHzjw9PcxA9tTR1coNyGRMABt
	 gy8GOb3pt9Jl/1e3dUKjFXe8mB5fasWr/W/UuLfqrV19JrhNXlainkl9OVmzOdpFT+
	 AAfocA3IohZApUvyk+R8vCF7z+wWW2VLF/MMKivbJ2VXfGPJCh0WJMzyIjdXMQ0oKL
	 apWptFhDKo55xBpc04hrmhNzeeoCDyAw1/ZQR/4Q7DkMmC9jTKKYhVum9kC8/qmEGi
	 2d7FF+loirEyA==
From: =?UTF-8?q?Ali=20Ahmet=20Memi=C5=9F?= <aliamemis@disroot.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Armin Wolf <W_Armin@gmx.de>,
	Hans de Goede <johannes.goede@oss.qualcomm.com>,
	Rong Zhang <i@rong.moe>,
	Charis Stratakis <c.stratakis@proton.me>,
	linux-acpi@vger.kernel.org,
	linux-pm@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 3/3] thermal: intel: int340x: Evaluate _TMP exclusively
Date: Wed, 14 Oct 2026 16:30:10 +0300
Message-ID: <20261014133013.94097-3-aliamemis@disroot.org>
In-Reply-To: <20261014132703.93355-1-aliamemis@disroot.org>
References: <20261014132703.93355-1-aliamemis@disroot.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On ThinkPad P1 Gen2 and P53, INT3403 _TMP switches the EC page selector
without taking the mutex the battery methods use, so it must not run
interleaved with them.

Evaluate _TMP with acpi_evaluate_integer_exclusive().

Fixes: d33e89d12295 ("thermal: core: Suspend thermal zones later and resume them earlier")
Reported-by: Charis Stratakis <c.stratakis@proton.me>
Closes: https://lore.kernel.org/all/37N_jFulf7n-Z55NfKfE71C_wVPxYvZ0xD_iRUg2fXu7TypDiF5PStQ6siSfVBih6fThg5WoPes8U5ZQpfVm_teMFcUGXFxz2DdMbfSWuws=@proton.me/
Cc: stable@vger.kernel.org
Signed-off-by: Ali Ahmet Memiş <aliamemis@disroot.org>
---
 .../thermal/intel/int340x_thermal/int340x_thermal_zone.c   | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
index 965700ee6962..de0a1fc7b817 100644
--- a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
+++ b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
@@ -18,7 +18,12 @@ static int int340x_thermal_get_zone_temp(struct thermal_zone_device *zone,
 	unsigned long long tmp;
 	acpi_status status;
 
-	status = acpi_evaluate_integer(d->adev->handle, "_TMP", NULL, &tmp);
+	/*
+	 * On some ThinkPads _TMP switches the EC page selector without
+	 * taking the mutex the battery methods use.
+	 */
+	status = acpi_evaluate_integer_exclusive(d->adev->handle, "_TMP", NULL,
+						 &tmp);
 	if (ACPI_FAILURE(status))
 		return -EIO;
 
-- 
2.55.0

