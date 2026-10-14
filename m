Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A912352B1EF;
	Wed, 14 Oct 2026 13:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791984635; cv=none; b=up11UzPDNI5rAiI+bPuQjOOfhA+O7+sP3h0bgUgj004raHIAPd670C1EK9DTHQISkpJl0Jsza2FIgUM3eoszr/zn+FugqIkUII4PiYmUygFzhU1PBmphjj+vUHRhjdn8VjmQHGViBok0eFeiqzn07MpGGsVIF1w3HkIh4vxOX50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791984635; c=relaxed/simple;
	bh=pk93DJrKuwAPTFIDUZpXFgb8mguOBPL3TiSN94Q0ObA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ri42vSEjx/1zRkZSxyLJDWK2geXe8xm/TtXasWZSVxu5aWOnjdhRLRgo+e84fqqEJN5fp2S2zq5/a67Ya4OfRZchqfaMX9HVYkECbPp7Pm/FeE0NiaUQtC9HjPwdubZ427ukI8PbXWEadPZUb6jIuQgcw7mfiQvP01apOKz52W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=XwSSTloe; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="XwSSTloe"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id CFA7180E8E;
	Wed, 14 Oct 2026 15:30:26 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UdU6Es1a4Y0g; Wed, 14 Oct 2026 15:30:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1791984625; bh=pk93DJrKuwAPTFIDUZpXFgb8mguOBPL3TiSN94Q0ObA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XwSSTloeaXbwJyHRbTpkjsfbXZ5nhTlEottknwuuMALKtIZIdxMDnwP9Y3kO/Sqmr
	 uCyQw5ClQzSov/zIPaJC85rLPIFWezz0u6H9GGIxQVIL1cBiwExY6gbCFuDAgnGGKk
	 APY2JUKt8Ubh78qMkho0YoEivuIwwizerz6EgbdMiuVjsGkfohTSQ4ygOUdIoSF13Y
	 gAB4+pT4822/iJAIpoMp8AqdLZFRXo/aJRnUfNqsToITCZwvV9l2Y9S2BmUih+4f58
	 ilP529MQqwkbFOmp+d77nUE9x0M5BbJMA0LHlc3kXVDgj3m4wN60CyZVg21tIC2UCN
	 m1p1v8/uaD5rQ==
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
Subject: [PATCH 2/3] ACPI: battery: Evaluate battery methods exclusively
Date: Wed, 14 Oct 2026 16:30:09 +0300
Message-ID: <20261014133013.94097-2-aliamemis@disroot.org>
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
---
 drivers/acpi/battery.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 670853ec3a4d..61de3f5be51f 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -583,9 +583,9 @@ static int acpi_battery_get_info(struct acpi_battery *battery)
 		struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 		acpi_status status = AE_ERROR;
 
-		status = acpi_evaluate_object(battery->device->handle,
-					      use_bix ? "_BIX":"_BIF",
-					      NULL, &buffer);
+		status = acpi_evaluate_object_exclusive(battery->device->handle,
+							use_bix ? "_BIX":"_BIF",
+							NULL, &buffer);
 
 		if (ACPI_FAILURE(status)) {
 			acpi_handle_info(battery->device->handle,
@@ -624,8 +624,8 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
 			msecs_to_jiffies(cache_time)))
 		return 0;
 
-	status = acpi_evaluate_object(battery->device->handle, "_BST",
-				      NULL, &buffer);
+	status = acpi_evaluate_object_exclusive(battery->device->handle, "_BST",
+						NULL, &buffer);
 	if (ACPI_FAILURE(status)) {
 		acpi_handle_info(battery->device->handle,
 				 "_BST evaluation failed: %s",
@@ -667,6 +667,8 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
 
 static int acpi_battery_set_alarm(struct acpi_battery *battery)
 {
+	union acpi_object arg = { .type = ACPI_TYPE_INTEGER };
+	struct acpi_object_list args = { .count = 1, .pointer = &arg };
 	acpi_status status = 0;
 
 	lockdep_assert_held(&battery->property_lock);
@@ -675,8 +677,9 @@ static int acpi_battery_set_alarm(struct acpi_battery *battery)
 	    !test_bit(ACPI_BATTERY_ALARM_PRESENT, &battery->flags))
 		return -ENODEV;
 
-	status = acpi_execute_simple_method(battery->device->handle, "_BTP",
-					    battery->alarm);
+	arg.integer.value = battery->alarm;
+	status = acpi_evaluate_object_exclusive(battery->device->handle, "_BTP",
+						&args, NULL);
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
-- 
2.55.0

