Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C02437B02A
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 17:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780681826; cv=none; b=pkxNOTqzD8TUGlvlTqZWxxyL8TY1C4dQ0URBm8PDMKbrOPlne9ovwzXJlbiTdKK2x3Jl3vXcVI3AcT25IKJxGW/9KMnadCTQuUsEMmY8krXulDAUOPINknlMixcSb5Q2qGy5NZWXViDrM+vhCIsBljIpPYbEu22CYapkSAwgJnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780681826; c=relaxed/simple;
	bh=E9w6f0xrSSYtvlb3ya5JkD8VpRPp9n43dUx3ws1rFiU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OYXsP+xMdMHDZoPKhADrExiihCPOxAEE1HXcVt4iqyKzD2du/V8H+3TNSp+60YaaT/h2NH+jRXaMVJo48bO+zww0LQy5PZXQ9IHNdQEBqytHwuPWEWx0k98eM5lDQmz/Vpls4l1ayEbrrFurLhi9IRAqbwgrs+lPiXnWDsh0X/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gLlVXV6c; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLlVXV6c"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2c0c3315c5dso23600965ad.3
        for <stable@vger.kernel.org>; Fri, 05 Jun 2026 10:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780681823; x=1781286623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RU4D9IDGoqS0yzp32EWwU+AQX5TFq61qrIjDkY+Qek4=;
        b=gLlVXV6c95bOMrlsjbY7/5I3X4KkpLbBBz4n94WaZgTPXvQYjhWnrfmwFIa8ZRzTEI
         GnPAzXNNuR5e9q7h78XH4dIQwE12iuh2bMBCuyreYAk+IZGyTQ5pES88KI37aKfFEQFV
         BUDa8QMgqiSnoY7tcqWcNnWgbbCJxF5gYJFzmt0Um54WH3F7Pea96HfTDPlfAAJk0lra
         6d6oHfKTlX8X3gVNRPzrtgLopK/1iW7jQuqP5VrnVn3c/xwlWvoswyPiG8Q4N6qyjA2c
         OZDKJEtMRgUtcZxlHDq42QVbuua9/Rfe9NGxbWHJIZxX+UPOVmgC5FBhim56ZpyAY06A
         Ngjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780681823; x=1781286623;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RU4D9IDGoqS0yzp32EWwU+AQX5TFq61qrIjDkY+Qek4=;
        b=g/25Mb4SV3sl4nWQR4uzJBIAlFxUXvBJzVJBtKUSGv5rMn2XfNz5u/HXdvyByogcip
         WjXnD91rUpJDKZgzcj/JudtQdehnQIs1NZjm7uKAOxd8TeZALzsdtDYq6Mr07GdB47fa
         1HXmNj6FrTE4+vE2GwgiFuCWnYm9aX4CVi5v/skRz2oEM/0r4IMHSkwIx9bHiWnGHHJ5
         /A61pJy4HgDj1GSly8gNaD34VcF7Dkskmbua3O2KeHzgCJYAvB5gtf5V4VCgfURzXsuB
         1FHxhxDEanR4gekr8Vse7AAcHcvVopYBJl+JT6fqxDayhpHoopQ6V3yvYuqjncMQnMpd
         ibZQ==
X-Forwarded-Encrypted: i=1; AFNElJ+vEPZOAm3iq1l4nKbZxJ3APcLn7yrZ4rBTldhLs/hotK2lMJA4Cy0D2TCYaG2k3xDYFRZ8Jp4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpkGvQhde0jkG4pzzA2+jkVBNyD7F80OmM74wGrwTQyZBkArFt
	56dehZrbxL/cXRktniSLE4RxzaeuXM/tv/rwmXeWLNe5CFisMeEFqQqA
X-Gm-Gg: Acq92OGfd6o4IyCYj7J0UL1Pd20PE6KZlQPECpGxap4yl94mcjqtf0DRy/W+vw9MbaM
	35TsORlbIffFHlshUvCdPB0Cmf0fbhdGop6KFkPDQ2DtMXGpBfGeCp/0qzDQgi07ACBjoQKDKSW
	6HkSNkib02pjkfvgpwl7P1oJiq+Dse6Vz+UI14ZOToeEMMQ6eulVCI0kv9sSAFohY5ilKFckLZy
	A+kpCnCMtGzRDl+ajD+l0MLHEOcDjRnQHbLMNlsMLOK1dFOyggehx1ncTgtOOpwM9pLKmSbjSAs
	rGuzQ2VcM3BI7lenTrmSsEUESzl2XQ/sNWleHKrtJVJoMV5P5SkbgfP04IhSFw2zF7MhncVMvnU
	FDaqGYG2OLjgGlzOcqzdfAnUe8XD6fbzFpR3vXWlq6ojHAlq/PfwDWLJ/3lGni1qrIQlUW3NGAC
	NpT39kSlKQQlXPzRYZ3N68NPLRns/sShUAB9LuJQhCV5WBY8RVvgE3BD/EqUFZ2rPR/DJuqx0WT
	1SfrtVASr2K/wy2zqoK+CBQnBc=
X-Received: by 2002:a17:902:ef08:b0:2c1:5135:39f3 with SMTP id d9443c01a7336-2c1e810d9famr55650215ad.11.1780681822667;
        Fri, 05 Jun 2026 10:50:22 -0700 (PDT)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e636sm97882435ad.51.2026.06.05.10.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 10:50:22 -0700 (PDT)
From: HyeongJun An <sammiee5311@gmail.com>
To: Alex Hung <alexhung@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	HyeongJun An <sammiee5311@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] platform/x86: intel-hid: Protect ACPI notify handler against recursion
Date: Sat,  6 Jun 2026 02:49:05 +0900
Message-ID: <20260605174905.131095-1-sammiee5311@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit e2ffcda16290 ("ACPI: OSL: Allow Notify () handlers to run on
all CPUs") ACPI notify handlers like the intel-hid notify_handler() may
run on multiple CPU cores racing with themselves.

On convertibles and detachables (matched by DMI chassis-type 31 and 32 in
dmi_auto_add_switch[]) the SW_TABLET_MODE input device is registered
lazily from notify_handler() on the first tablet-mode event, via
intel_hid_switches_setup(). When two such events race on different CPUs
both can pass the !priv->switches check and register the priv->switches
input device twice, resulting in a duplicate sysfs entry and a subsequent
NULL pointer dereference.

This is the same class of bug fixed by commit e075c3b13a0a ("platform/x86:
intel-vbtn: Protect ACPI notify handler against recursion") for the
sibling intel-vbtn driver.

Protect intel-hid notify_handler() from racing with itself with a mutex
to fix this.

Fixes: e2ffcda16290 ("ACPI: OSL: Allow Notify () handlers to run on all CPUs")
Cc: stable@vger.kernel.org
Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
---
 drivers/platform/x86/intel/hid.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/platform/x86/intel/hid.c b/drivers/platform/x86/intel/hid.c
index 085093506dda..6b4bac5f7051 100644
--- a/drivers/platform/x86/intel/hid.c
+++ b/drivers/platform/x86/intel/hid.c
@@ -7,11 +7,13 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/cleanup.h>
 #include <linux/dmi.h>
 #include <linux/input.h>
 #include <linux/input/sparse-keymap.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/platform_device.h>
 #include <linux/string_choices.h>
 #include <linux/suspend.h>
@@ -230,6 +232,7 @@ static const struct dmi_system_id dmi_auto_add_switch[] = {
 };
 
 struct intel_hid_priv {
+	struct mutex mutex; /* Avoid notify_handler() racing with itself */
 	struct input_dev *input_dev;
 	struct input_dev *array;
 	struct input_dev *switches;
@@ -565,6 +568,8 @@ static void notify_handler(acpi_handle handle, u32 event, void *context)
 	struct key_entry *ke;
 	int err;
 
+	guard(mutex)(&priv->mutex);
+
 	/*
 	 * Some convertible have unreliable VGBS return which could cause incorrect
 	 * SW_TABLET_MODE report, in these cases we enable support when receiving
@@ -720,6 +725,10 @@ static int intel_hid_probe(struct platform_device *device)
 		return -ENOMEM;
 	dev_set_drvdata(&device->dev, priv);
 
+	err = devm_mutex_init(&device->dev, &priv->mutex);
+	if (err)
+		return err;
+
 	/* See dual_accel_detect.h for more info on the dual_accel check. */
 	if (enable_sw_tablet_mode == TABLET_SW_AUTO) {
 		if (dmi_check_system(dmi_vgbs_allow_list))
-- 
2.43.0

