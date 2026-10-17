Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC1A3290D1;
	Sat, 17 Oct 2026 13:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792242440; cv=none; b=kGgIMjw74uXcaU8Fdj4LWPtq8SPShjZVcYNkX9oqzA1wjEbOmzhXxVSB3hk6SlrmXf3A8u7jRjPK2Mqr0KJQIZiZQ82yVSJUaQwyFr1xAtMeHjcJMxJ4NXJSSg9oa3Uzd7uHQXL19HDVX/xWDKWS/HX7ps5b8eqAc61M3g/HhYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792242440; c=relaxed/simple;
	bh=CMaThmWfnpj/MwA2ZEDlOLJGrmCmh7iE0IvIv/qfMzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tf12kFxgIufpRtMVThcqJgDimD73mQXGo1tAIvj+JXgtsxLV8NxjsaMntoH/tq4+/tbt3FBXnkIm2+Gn/ukfsdrxnbHxfXmiixvyuHirVvqDIa7fkdwBhgS0WN44pWb5bRstdSE8fHXZXdFuLJRu04W2aR+JGsgNPPNRLtMo5EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=eUfLGFwY; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="eUfLGFwY"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 019DB80A11;
	Sat, 17 Oct 2026 15:07:11 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JeIEbBuWO2j0; Sat, 17 Oct 2026 15:07:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1792242430; bh=CMaThmWfnpj/MwA2ZEDlOLJGrmCmh7iE0IvIv/qfMzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eUfLGFwYzQES0YA7ITz/UZZIHg86QTVUJzDHns7s4PwjFGAZBnBpG+XAyxwUgVL4O
	 cjYmFXZY6uKUDcI4+F9KAp8OXQ/W1xgRqIRmSK9qwRRm3Oa85nOgujqHhNXwdstTQS
	 rX26f6CwclRws7e8RkYqXL0WfZ0lK+QnsyYvHD7WQ+ziziUPmCEsjeQX08rV1x3KBy
	 xDipBOEXrOE4HWJWszYiFDTy8xXqTKhGlMMjLD/Uj4xl1/FhIN9r8clDj9fr3IX2ji
	 kzN9KoFg0U6l6NRnNXujpp6YHVuHYBWsL36/sb+/snYGuJWMRhLegauNmk/krT4L35
	 YfDILnqQPF8bg==
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
Subject: [PATCH v2 2/4] ACPI: battery: Evaluate battery methods exclusively
Date: Sat, 17 Oct 2026 16:06:35 +0300
Message-ID: <20261017130652.318778-3-aliamemis@disroot.org>
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
without taking the AML mutex the battery methods use, so _BIX and _BST
running at the same time can read the wrong page. Since commit d33e89d12295
("thermal: core: Suspend thermal zones later and resume them earlier")
this happens on most resumes.

Evaluate the battery methods with acpi_evaluate_object_exclusive().

Fixes: d33e89d12295 ("thermal: core: Suspend thermal zones later and resume them earlier")
Reported-by: Charis Stratakis <c.stratakis@proton.me>
Closes: https://lore.kernel.org/all/37N_jFulf7n-Z55NfKfE71C_wVPxYvZ0xD_iRUg2fXu7TypDiF5PStQ6siSfVBih6fThg5WoPes8U5ZQpfVm_teMFcUGXFxz2DdMbfSWuws=@proton.me/
Cc: stable@vger.kernel.org
Signed-off-by: Ali Ahmet Memiş <aliamemis@disroot.org>
Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
Reviewed-by: Rong Zhang <i@rong.moe>
---
 drivers/acpi/battery.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 670853ec3a4d..7169ac7e83f3 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -583,9 +583,8 @@ static int acpi_battery_get_info(struct acpi_battery *battery)
 		struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 		acpi_status status = AE_ERROR;
 
-		status = acpi_evaluate_object(battery->device->handle,
-					      use_bix ? "_BIX":"_BIF",
-					      NULL, &buffer);
+		status = acpi_evaluate_object_exclusive(battery->device->handle,
+							use_bix ? "_BIX" : "_BIF", NULL, &buffer);
 
 		if (ACPI_FAILURE(status)) {
 			acpi_handle_info(battery->device->handle,
@@ -624,8 +623,7 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
 			msecs_to_jiffies(cache_time)))
 		return 0;
 
-	status = acpi_evaluate_object(battery->device->handle, "_BST",
-				      NULL, &buffer);
+	status = acpi_evaluate_object_exclusive(battery->device->handle, "_BST", NULL, &buffer);
 	if (ACPI_FAILURE(status)) {
 		acpi_handle_info(battery->device->handle,
 				 "_BST evaluation failed: %s",
@@ -675,8 +673,8 @@ static int acpi_battery_set_alarm(struct acpi_battery *battery)
 	    !test_bit(ACPI_BATTERY_ALARM_PRESENT, &battery->flags))
 		return -ENODEV;
 
-	status = acpi_execute_simple_method(battery->device->handle, "_BTP",
-					    battery->alarm);
+	status = acpi_execute_simple_method_exclusive(battery->device->handle, "_BTP",
+						      battery->alarm);
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
-- 
2.55.0

