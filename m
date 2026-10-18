Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B02470E85;
	Sun, 18 Oct 2026 12:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792326157; cv=none; b=g+EDXsdGQ1B3tWEwDwSzG/v3lrhqchYzH+dFWK9zk2G0IFBJjodJVrdmgjtSv6srLiwtOINO85In7BlM0qxzot1psIf5f9sWXCjSeVfqXRwMrR5hO0x9xldHXfG46Va8/r7FDF5N3Prr4dmuaz+1fqvGnZ3jf3y4oEaPQObKNP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792326157; c=relaxed/simple;
	bh=CMaThmWfnpj/MwA2ZEDlOLJGrmCmh7iE0IvIv/qfMzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E+mebDvs9GbuuZhqBbdwDPRLR7ufm8EEShDdCIvXEuNIsHSrLvTSjEqWWdH89L8QBRcPI1K7Mi6+GM9nuuWv/m/jP7gYkn7C01cUUO1PLs8sLbNUJq7tLnCfL1kMr8st+CXxo4Qe7JSnX4Kv47lDGYzAYczK9710slAOVkdybpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=AgCeubKA; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="AgCeubKA"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 3A88080E1D;
	Sun, 18 Oct 2026 14:22:34 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J-TCYOe5m764; Sun, 18 Oct 2026 14:22:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1792326153; bh=CMaThmWfnpj/MwA2ZEDlOLJGrmCmh7iE0IvIv/qfMzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AgCeubKAZsqqknLwlcrptT/yKOuGf7eTKEp8Cr6Yri13CiQkyB1G7CWy9F9inVLH8
	 X8c6GuVyeUEwzFtxu1vTUh8m+eAZ6Oooyk4p2BKg4El54GBgF//1uG9bjJ8FmPUQXX
	 zl2Ro5jFIVRwWJGgDOuEB9BFG3ED+NsGEff8cyWuSgUTDvPRYtU6dORAPZGp50S4sh
	 7Cu4mQ00bfReu4cTJLejapy0u4NWyIGJQB5xg/MBVbPJdXqJgZwbwPFwOw8qsbdg7g
	 2wyrykfoCM+6eCtNkxiPP0w17p3E5Nq+KsD7FzmSHEJQU2iv0e2Ds7ox5a9poQdb2e
	 rsjrVSHdAFNGw==
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
Subject: [PATCH v3 2/4] ACPI: battery: Evaluate battery methods exclusively
Date: Sun, 18 Oct 2026 15:22:18 +0300
Message-ID: <20261018122220.678822-3-aliamemis@disroot.org>
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

