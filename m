Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D383836654C;
	Mon, 12 Oct 2026 22:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791845517; cv=none; b=PkMki2XpPJlvs0xHgVdUesh3+LeRY+F/ouC3ODaOWTUclrQ/5uIwyNb1YCmJxTz5NFUjlFmxcsiJL8CQGHpyFq2gIIDjQrwMOmjHuiZaiYLO2/m8Wxsp42rERywUrfXvNPtRPxf9PXaOXhFEmqCDBdgOEHB+wBehrMKlINlhZCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791845517; c=relaxed/simple;
	bh=QNgm7YRCtg9UCfQ6U6AMDUC6DRY84cGS/wMi47wdjm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UwfDpizwht5eybZyot1Cn2oxdhH5G2n9UTNU935gmscADKe1KhEPy21WCl0yEI8HGZyDF0Ewc2gqn2JbKSNKMkkr2VB6PeihwtAsbX/c1gRZvaC2NaoAkAm/RX1/Us1GNiHCI73S5mIBE5cpUZ8kqwnx8GIgs8UeAtg87EMwNs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=Bu66h0lE; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="Bu66h0lE"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id E315C80B79;
	Tue, 13 Oct 2026 00:51:52 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ce-YODz7OvAK; Tue, 13 Oct 2026 00:51:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1791845511; bh=QNgm7YRCtg9UCfQ6U6AMDUC6DRY84cGS/wMi47wdjm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Bu66h0lEs93Df0+ytSVXdDJkOlzLttYod9x7Mr4nohwXykcmPAJtVSl77z9dMn5u3
	 68DvZD+UTGjMsizVSUN3yLHQf8BPDJsP4PKeySv4KT9D+3NJmBdRJFxLHl64FSFBLC
	 9wVRbSti7//SM5l4Xyeaoi8glySbWvFLvgHEc2WcQR/ySoGnHoqlm8PcqR80/FIxfp
	 AO7mIM1z2T5sScu2yNcfuPM4K4kA9H0JlMPZ9WOe0xMLBPoRmHQpO/+o0N3ubruplL
	 TyJEn2pFYViiY4PPSBJXTqX109AuBn0ln7D3lcWICMUA5tKwFHi44oQKPKOokk3Oeh
	 BY2GgJy/o7s8Q==
From: =?UTF-8?q?Ali=20Ahmet=20Memi=C5=9F?= <aliamemis@disroot.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	Armin Wolf <W_Armin@gmx.de>,
	Charis Stratakis <c.stratakis@proton.me>,
	linux-acpi@vger.kernel.org,
	linux-pm@vger.kernel.org,
	regressions@lists.linux.dev,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ACPI: battery: Re-read battery information in the complete callback
Date: Tue, 13 Oct 2026 01:46:57 +0300
Message-ID: <20261012225141.13683-1-aliamemis@disroot.org>
In-Reply-To: <37N_jFulf7n-Z55NfKfE71C_wVPxYvZ0xD_iRUg2fXu7TypDiF5PStQ6siSfVBih6fThg5WoPes8U5ZQpfVm_teMFcUGXFxz2DdMbfSWuws=@proton.me>
References: <37N_jFulf7n-Z55NfKfE71C_wVPxYvZ0xD_iRUg2fXu7TypDiF5PStQ6siSfVBih6fThg5WoPes8U5ZQpfVm_teMFcUGXFxz2DdMbfSWuws=@proton.me>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since commit d33e89d12295 ("thermal: core: Suspend thermal zones later
and resume them earlier"), thermal zones are resumed from dpm_complete(),
before the PM_POST_SUSPEND notifier that re-reads _BIX and _BST. On
ThinkPad P1 Gen2 and P53, INT3403 _TMP calls \GTST which switches the EC
page selector (HIID) without taking the BATM mutex used by the battery
methods. ACPICA releases the interpreter lock around EC accesses so the
two methods interleave and _BIX often returns temperature page data
after resume.

Evaluate _BIX and _BST in the complete callback, which runs before
dpm_complete() resumes thermal zones and leave only the sysfs
re-registration to the notifier.

Fixes: d33e89d12295 ("thermal: core: Suspend thermal zones later and resume them earlier")
Reported-by: Charis Stratakis <c.stratakis@proton.me>
Closes: https://lore.kernel.org/all/37N_jFulf7n-Z55NfKfE71C_wVPxYvZ0xD_iRUg2fXu7TypDiF5PStQ6siSfVBih6fThg5WoPes8U5ZQpfVm_teMFcUGXFxz2DdMbfSWuws=@proton.me/
Cc: stable@vger.kernel.org
Signed-off-by: Ali Ahmet Memiş <aliamemis@disroot.org>
---
Ran into this (report) while reading the EC firmware of my T490.
The P1 Gen2 EC has the same single page selector.

Tested on 7.3-rc7 with an SSDT that makes a thermal zone keep calling a
copy of the P1 Gen2 \GTST after resume.  _BIX was broken after 5 of 5
resumes without the patch and 0 of 5 with it.

Doing it in the resume callback also works but _BIX takes about 75 ms
there right after resume against about 35 ms here (and by the complete
callback all operation region providers have resumed too).

 drivers/acpi/battery.c | 62 ++++++++++++++++++++++++++++--------------
 1 file changed, 42 insertions(+), 20 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 670853ec3a4d..34f2e78c4314 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -107,6 +107,7 @@ struct acpi_battery {
 	struct notifier_block pm_nb;
 	struct list_head list;
 	unsigned long flags;
+	bool resume_reregister;
 
 	struct mutex property_lock; /* Protects properties below. */
 	unsigned long update_time;
@@ -1209,29 +1210,15 @@ static int battery_notify(struct notifier_block *nb,
 	if (mode == PM_POST_SUSPEND || mode == PM_POST_HIBERNATION) {
 		guard(mutex)(&battery->update_lock);
 
-		if (!acpi_battery_present(battery))
+		if (!battery->resume_reregister)
 			return 0;
 
-		if (battery->bat) {
-			acpi_battery_refresh(battery);
-		} else {
-			int result;
-
-			scoped_guard(mutex, &battery->property_lock) {
-				result = acpi_battery_get_info(battery);
-				if (result)
-					return result;
-			}
+		battery->resume_reregister = false;
 
-			result = sysfs_add_battery(battery);
-			if (result)
-				return result;
-		}
+		if (battery->bat)
+			sysfs_remove_battery(battery);
 
-		scoped_guard(mutex, &battery->property_lock) {
-			acpi_battery_init_alarm(battery);
-			acpi_battery_get_state(battery);
-		}
+		return sysfs_add_battery(battery);
 	}
 
 	return 0;
@@ -1450,7 +1437,42 @@ static int acpi_battery_resume(struct device *dev)
 	return 0;
 }
 
-static DEFINE_SIMPLE_DEV_PM_OPS(acpi_battery_pm, NULL, acpi_battery_resume);
+static void acpi_battery_complete(struct device *dev)
+{
+	struct acpi_battery *battery = dev_get_drvdata(dev);
+
+	if (!battery)
+		return;
+
+	guard(mutex)(&battery->update_lock);
+
+	if (!acpi_battery_present(battery))
+		return;
+
+	/*
+	 * Evaluate _BIX and _BST here before thermal zones are resumed, as
+	 * some firmware shares the EC window with _TMP without locking.
+	 */
+	guard(mutex)(&battery->property_lock);
+
+	if (battery->bat) {
+		int power_unit = battery->power_unit;
+
+		acpi_battery_get_info(battery);
+		if (power_unit != battery->power_unit)
+			battery->resume_reregister = true;
+	} else if (!acpi_battery_get_info(battery)) {
+		battery->resume_reregister = true;
+	}
+
+	acpi_battery_init_alarm(battery);
+	acpi_battery_get_state(battery);
+}
+
+static const struct dev_pm_ops acpi_battery_pm = {
+	SYSTEM_SLEEP_PM_OPS(NULL, acpi_battery_resume)
+	.complete = pm_sleep_ptr(acpi_battery_complete),
+};
 
 static struct platform_driver acpi_battery_driver = {
 	.probe = acpi_battery_probe,
-- 
2.55.0

