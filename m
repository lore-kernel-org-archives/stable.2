Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2274E49A3CF;
	Sun, 18 Oct 2026 12:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792326171; cv=none; b=OTvrC/vu7cpdgGYMWE7/YdZMW8O9P7/y2nXxGPZ8Rxrn2mgPwcpVFYfVWSTKQGSl0BuOlDxttdT02KPA1x+bYNTak6i0WLEGo2okZWm/wN97+nX+0L2c06r/PzCBLeQ3OXgXWivRC4R1Vh78UC4aLaqOLVcf6HgFNqa5frNak4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792326171; c=relaxed/simple;
	bh=PRHywdbP7dqEbq07ja7zg1qLti4n15HuEnR2MmqnSus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pOE2BSZNG3LRjYCYqfqtSucraSk1TWnPxdgLEB1wJoPLvuWg85gKRCcrd8TmDBHNC9UPoMTcQN7i2KR5SZGTGEJ95ZfCt/JyqM/8zCgGhCyifRCwE9eHHXpssCvlavFsz1LU1/voCNBHUZmT8ieem7aJbV95yF60aRjdsmoGotI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=anbVoMjS; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="anbVoMjS"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 92EE280B60;
	Sun, 18 Oct 2026 14:22:38 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3mYQffHhEH2i; Sun, 18 Oct 2026 14:22:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1792326157; bh=PRHywdbP7dqEbq07ja7zg1qLti4n15HuEnR2MmqnSus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=anbVoMjScvyQkjNnCrqgo4xz6Cp3iNJRF3JqRMdhfH2IV1wbSrrTi7zlLR308Yf9Y
	 JM9ueOxI4dc/5J+LaofNmkjE3Wxq+CSMqPdT7w+6Ofsvr4NrfZ8RvLXjKm7AYf0eMZ
	 /cSFzNWcYshcc3SW2YnrqDNaMfVdUy30IBeeOkiOeDwxtpYToZWEyV/AT/rTWlaMy0
	 MEeUVqz2PbTCnleHm/NQFVidlT+3uWFC/2pcwV2RzU7EAofrLMfMbtmNqiyji9J58p
	 L5phxQs+vv4b2PWf8R2c1QIbK/UNr0ANthZvrKFB0nPFOfOLsNMPzY//GcVsaaCmkU
	 F12aS13cMsOGw==
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
Subject: [PATCH v3 3/4] thermal: intel: int340x: Evaluate _TMP exclusively
Date: Sun, 18 Oct 2026 15:22:19 +0300
Message-ID: <20261018122220.678822-4-aliamemis@disroot.org>
In-Reply-To: <20261018122220.678822-1-aliamemis@disroot.org>
References: <20261018122220.678822-1-aliamemis@disroot.org>
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

Evaluate _TMP with acpi_evaluate_integer_exclusive(), also where int3403
and processor_thermal probe for it.

Fixes: d33e89d12295 ("thermal: core: Suspend thermal zones later and resume them earlier")
Reported-by: Charis Stratakis <c.stratakis@proton.me>
Closes: https://lore.kernel.org/all/37N_jFulf7n-Z55NfKfE71C_wVPxYvZ0xD_iRUg2fXu7TypDiF5PStQ6siSfVBih6fThg5WoPes8U5ZQpfVm_teMFcUGXFxz2DdMbfSWuws=@proton.me/
Cc: stable@vger.kernel.org
Signed-off-by: Ali Ahmet Memiş <aliamemis@disroot.org>
Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
Reviewed-by: Rong Zhang <i@rong.moe>
---
 drivers/thermal/intel/int340x_thermal/int3403_thermal.c     | 3 +--
 .../thermal/intel/int340x_thermal/int340x_thermal_zone.c    | 6 +++++-
 .../intel/int340x_thermal/processor_thermal_device.c        | 2 +-
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/int3403_thermal.c b/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
index 264c9bc8e645..2262de1e14d9 100644
--- a/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
@@ -217,8 +217,7 @@ static int int3403_add(struct platform_device *pdev)
 	}
 
 
-	status = acpi_evaluate_integer(priv->adev->handle, "_TMP",
-				       NULL, &tmp);
+	status = acpi_evaluate_integer_exclusive(priv->adev->handle, "_TMP", NULL, &tmp);
 	if (ACPI_FAILURE(status)) {
 		status = acpi_evaluate_integer(priv->adev->handle, "PTYP",
 				       NULL, &priv->type);
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
 
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
index f80dbe2ca7e4..0ece3d131588 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
@@ -283,7 +283,7 @@ int proc_thermal_add(struct device *dev, struct proc_thermal_device *proc_priv)
 	if (ret)
 		return ret;
 
-	status = acpi_evaluate_integer(adev->handle, "_TMP", NULL, &tmp);
+	status = acpi_evaluate_integer_exclusive(adev->handle, "_TMP", NULL, &tmp);
 	if (ACPI_FAILURE(status)) {
 		/* there is no _TMP method, add local method */
 		if (intel_tcc_get_tjmax(-1) > 0)
-- 
2.55.0

