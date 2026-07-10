Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB137438032
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 15:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783698435; cv=none; b=up5u3vwbYmVa1C/ZOpnU4Phto08FWGCPgjUAX5IiZVg2caVLwdMj0jHs7AeP3WO/CwmiAkZrxSa4F2WzhdNppwr8b7EbC+TXC0NqqsUvPdGEZOn/p0iwLMuu6acTtjCUBL515+kYZ2vNrj1INsZ4E8uKUf/KBi0Rzd0fHwTVBBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783698435; c=relaxed/simple;
	bh=NeBg2VvmXgixgYRuexqKOnA5X/542EqwWrWqFoofkmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rxpesDrcaKrVtLihtafYk2UPt5tuXPpT4Ov21ADFWrUiKPv22oSky1Ufa6YTFbOQTyfGLlUkKXC1eBzl4/S9ScLe1CSPnWZKl07SmUeJavV0jKyjRSez4CUk9UScOs2UmTW1jvhQZDGVDalaYebQmwCsGSla7CUyv8ceWMlkvYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nFT2+tWC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFT2+tWC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51B4F1F00A3A;
	Fri, 10 Jul 2026 15:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783698433;
	bh=qa4LELX69F4XtF93RPNd7sbtcTAq0uhF9aJUFjQZtc0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nFT2+tWCDGsHRSZqd4SK4EYrdm1CZjkul6IxuTrW0HrJ6XaSDLCqvdoGSO1zQPH4C
	 6qddawOTCYuaz8mTv2ryyKOStLc0l8qK7I/O64cOt/AQsriE2peONcQijCNOJv3k89
	 JlWLwmRmIKkYvJB8m/kQA0jf1TY3sXZtyA2KX9NjPfRtk7xt6d4WGBNNgNN5a/H0oQ
	 sv0W+MgRGabUYCbakjtidDqlQpNsFDPRrervX+AQjXNZQ7n3nM1V9zRd07C89Catn8
	 MADEM1wkY0vRlAHNBQtkJTu1DGeeJpTRdFOpbL8W9Ow214PsEVA7cejFDweOwJWIRt
	 nuV9fyYMz+E4Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/5] ACPI: NFIT: core: Use devm_acpi_install_notify_handler()
Date: Fri, 10 Jul 2026 11:47:08 -0400
Message-ID: <20260710154710.286956-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260710154710.286956-1-sashal@kernel.org>
References: <2026070931-earmuff-spirits-26aa@gregkh>
 <20260710154710.286956-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit 198541ad53c0d0d891fedea4098f9953a0f566c0 ]

Now that devm_acpi_install_notify_handler() is available, use it in
acpi_nfit_probe() instead of a custom devm action removing an ACPI
notify handler installed via acpi_dev_install_notify_handler().

Also drop the explicit ACPI_COMPANION() check against NULL that is
not necessary any more becuase devm_acpi_install_notify_handler()
carries out an equivalent check internally and use ACPI_HANDLE() to
retrieve the platform device's ACPI handle.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://patch.msgid.link/3048737.e9J7NaK4W3@rafael.j.wysocki
Stable-dep-of: 18a00ed0e718 ("ACPI: NFIT: core: Fix possible deadlock and missing notifications")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/nfit/core.c | 27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 3eb56b77cb6d93..c00cb8661b0b52 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -3283,19 +3283,11 @@ static void acpi_nfit_put_table(void *table)
 
 static void acpi_nfit_notify(acpi_handle handle, u32 event, void *data)
 {
-	struct acpi_device *adev = data;
-
-	device_lock(&adev->dev);
-	__acpi_nfit_notify(&adev->dev, handle, event);
-	device_unlock(&adev->dev);
-}
-
-static void acpi_nfit_remove_notify_handler(void *data)
-{
-	struct acpi_device *adev = data;
+	struct device *dev = data;
 
-	acpi_dev_remove_notify_handler(adev, ACPI_DEVICE_NOTIFY,
-				       acpi_nfit_notify);
+	device_lock(dev);
+	__acpi_nfit_notify(dev, handle, event);
+	device_unlock(dev);
 }
 
 void acpi_nfit_shutdown(void *data)
@@ -3338,13 +3330,8 @@ static int acpi_nfit_add(struct acpi_device *adev)
 	acpi_size sz;
 	int rc = 0;
 
-	rc = acpi_dev_install_notify_handler(adev, ACPI_DEVICE_NOTIFY,
-					     acpi_nfit_notify, adev);
-	if (rc)
-		return rc;
-
-	rc = devm_add_action_or_reset(dev, acpi_nfit_remove_notify_handler,
-					adev);
+	rc = devm_acpi_install_notify_handler(dev, ACPI_DEVICE_NOTIFY,
+					      acpi_nfit_notify, dev);
 	if (rc)
 		return rc;
 
@@ -3375,7 +3362,7 @@ static int acpi_nfit_add(struct acpi_device *adev)
 	acpi_desc->acpi_header = *tbl;
 
 	/* Evaluate _FIT and override with that if present */
-	status = acpi_evaluate_object(adev->handle, "_FIT", NULL, &buf);
+	status = acpi_evaluate_object(ACPI_HANDLE(dev), "_FIT", NULL, &buf);
 	if (ACPI_SUCCESS(status) && buf.length > 0) {
 		union acpi_object *obj = buf.pointer;
 
-- 
2.53.0

