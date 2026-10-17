Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8120336881;
	Sat, 17 Oct 2026 13:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792242441; cv=none; b=CGDI1qfY2vQBFUwwwiPhcW6pWaeJtcBQyQrUmGVfVSqCJKwbk2FNqTYwK4mFResN5/oKutxmzOqaM4DKQobC47A4p8ZR2laEdZ3fHR2vjLvHMMneHYP/Sod5zPvSag3ptuXhtorbhv1XM9pLqG36FbmZ6D950Je26h1uQzVpioM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792242441; c=relaxed/simple;
	bh=SqtrgbIiAd+6BUIuHUasrx3pKdiGGT77q7IizZmSZkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jji0mTYCRX2Tw60U6YV9EtW23g5hdNCQIhbfCxB+hAzSBNQSWX7TWiU+rvzLUn/u7nepryr1HWxLnIFCAwSwVmVPp4PHn7UvocBrF1ybRN3wSU/IQRVZkb7RjEJWuSi30J97H8V5oDckzmxM1egRpV9FuaWo6axiuvBRuRoORbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=aY9zMjb1; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="aY9zMjb1"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 702D880B80;
	Sat, 17 Oct 2026 15:07:12 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R1LMfnlzWBDN; Sat, 17 Oct 2026 15:07:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1792242431; bh=SqtrgbIiAd+6BUIuHUasrx3pKdiGGT77q7IizZmSZkM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aY9zMjb1hout5+ASPBYEbOqAPo2zGL9+8Lt8chkTP5gaJwDVmjv+lV6cFhkMOV4QL
	 h8ES6I8MAWV1fzspeOfSSpxPDkOqoW3C+E96SG8ZsddB1WZCTguXZW+t8LB334oFHB
	 o+h36ql96QDfLyTOMq21T/gRo0gxVFQwM0XQ9FJMkje0w9IpPlJCHRxkDAcZAKNLJr
	 0yCCMazJsjmxYzouYc7kJtzJkHi65j6/p804wnWex31zaxt17+7CXtja/0GVcMBLYl
	 xY1TAgBgPqJmRRGGOyWYt9v6DoSSu5kEG2ruichtclhEQLLmbDm93k1ZIbYgeiUBKM
	 t+gY+JQjFXWUw==
From: =?UTF-8?q?Ali=20Ahmet=20Memi=C5=9F?= <aliamemis@disroot.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
	Rong Zhang <i@rong.moe>,
	Len Brown <lenb@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Ike Panhc <ikepanhc@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Armin Wolf <W_Armin@gmx.de>,
	Charis Stratakis <c.stratakis@proton.me>,
	Avraham Hollander <anhollander516@gmail.com>,
	=?UTF-8?q?Jeffrey=20W=C3=A4lti?= <jeffrey@waelti.dev>,
	Rick <rickk1166@gmail.com>,
	linux-acpi@vger.kernel.org,
	linux-pm@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 3/4] thermal: intel: int340x: Evaluate _TMP exclusively
Date: Sat, 17 Oct 2026 16:06:36 +0300
Message-ID: <20261017130652.318778-4-aliamemis@disroot.org>
In-Reply-To: <20261017130652.318778-1-aliamemis@disroot.org>
References: <20261017130652.318778-1-aliamemis@disroot.org>
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
Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
Reviewed-by: Rong Zhang <i@rong.moe>
---
 .../thermal/intel/int340x_thermal/int340x_thermal_zone.c    | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
index 965700ee6962..9451fea1f65c 100644
--- a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
+++ b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
@@ -18,7 +18,11 @@ static int int340x_thermal_get_zone_temp(struct thermal_zone_device *zone,
 	unsigned long long tmp;
 	acpi_status status;
 
-	status = acpi_evaluate_integer(d->adev->handle, "_TMP", NULL, &tmp);
+	/*
+	 * On some ThinkPads _TMP switches the EC page selector without
+	 * taking the mutex the battery methods use.
+	 */
+	status = acpi_evaluate_integer_exclusive(d->adev->handle, "_TMP", NULL, &tmp);
 	if (ACPI_FAILURE(status))
 		return -EIO;
 
-- 
2.55.0

