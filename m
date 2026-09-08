Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E22147604B
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 12:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788870012; cv=none; b=YuLOBi55e/g7kx9FKdNbCjc7RFrVy5GTtQm5tUkG9yZM4/ohbq+Tl7etqDRSIFApMtD4jNumQUxXBQgMhHKFUmTWx7f0pa2z1lbmfe1L8KNnZJ9lon2U3J+vYYAkrbH5dFglA8TusCfwXls6v9Bzr1tyANdhBMr/TdEmm6mdgec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788870012; c=relaxed/simple;
	bh=V3lCj1ipoM8bHkr4Dg8cp6rHYoh9vLKgpioMrjJ8HcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=arcH863yCWoyL855z6i2DLb+hRQmnL4UCVQJqbvCgygg6+Unxt9cR1JaWKP2MnJNHfNkm/KS47BDVDO88FdF8BEF5gImPuxd0b3JMumgJpdnwvPCvTkZgswIW6w55HbWEgoafv3LxWnhe5ZXM//HrOgvf4XMNaqPcAPqYVKNJaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MeO+1QPX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MeO+1QPX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63BB81F00A3D;
	Tue,  8 Sep 2026 12:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788870008;
	bh=OZifP0LH9bQTg+dnYaV3lTN2SZJ2GkQUL3QpqcGy+vI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MeO+1QPXDMSSIi29TwNu6WHA2D0yQr2M++pqu8M23CtaM8Tsi70/W+JTvgO875dXM
	 Ib0tKbTIhwShvFu9smx0VYZyticXfiDrcEiz9tkvGuqaDatnc6hSPBHwBRpL/6zm1m
	 g3dKO32o/iegvtuknu6cmOzs7cj3VjpFfcovQcmSH1KfW1Rn/QzIj8GPMZNQrvh+Cj
	 c3Pv2kHtupDRlUsW50xbnLq9T8EuEyH31a6dZW931gxBcURd96zJCAI0ksjsZoYLpr
	 ybppBGhyYMahI9r/lRujebhB4Xg6F2Ygxg+wh1LWR7yEGEDlmVVCj+bZxyIYvDhPRl
	 2udleyy/6Kcig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/4] ACPI: x86/rtc-cmos: Use platform device for driver binding
Date: Tue,  8 Sep 2026 08:20:02 -0400
Message-ID: <20260908122004.2049483-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908122004.2049483-1-sashal@kernel.org>
References: <2026090331-quartered-robe-d833@gregkh>
 <20260908122004.2049483-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit 2a78e42104444f948698f1225deaf515e9b7224d ]

Modify the rtc-cmos driver to bind to a platform device on systems with
ACPI via acpi_match_table and advertise the CMOST RTC ACPI device IDs
for driver auto-loading.  Note that adding the requisite device IDs to
it and exposing them via MODULE_DEVICE_TABLE() is sufficient for this
purpose.

Since the ACPI device IDs in question are the same as for the CMOS RTC
ACPI scan handler, put them into a common header file and use the
definition from there in both places.

Additionally, to prevent a PNP device from being created for the CMOS
RTC if a platform one is present already, make is_cmos_rtc_device()
check cmos_rtc_platform_device_present introduced previously.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Link: https://patch.msgid.link/13969123.uLZWGnKmhe@rafael.j.wysocki
Stable-dep-of: a3df8bbe0a70 ("ACPI: TAD: Add locking around AML evaluations")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/acpi_pnp.c     |  2 +-
 drivers/acpi/x86/cmos_rtc.c |  5 +----
 drivers/rtc/rtc-cmos.c      | 10 ++++++++++
 include/linux/acpi.h        |  6 ++++++
 4 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpi_pnp.c b/drivers/acpi/acpi_pnp.c
index 4ad88187dc7a0..7eb9561b95893 100644
--- a/drivers/acpi/acpi_pnp.c
+++ b/drivers/acpi/acpi_pnp.c
@@ -385,7 +385,7 @@ static int is_cmos_rtc_device(struct acpi_device *adev)
 		{ "PNP0B02" },
 		{""},
 	};
-	return !acpi_match_device_ids(adev, ids);
+	return !cmos_rtc_platform_device_present && !acpi_match_device_ids(adev, ids);
 }
 
 bool acpi_is_pnp_device(struct acpi_device *adev)
diff --git a/drivers/acpi/x86/cmos_rtc.c b/drivers/acpi/x86/cmos_rtc.c
index bdd66dfd4a441..a6df5b991c960 100644
--- a/drivers/acpi/x86/cmos_rtc.c
+++ b/drivers/acpi/x86/cmos_rtc.c
@@ -18,10 +18,7 @@
 #include "../internal.h"
 
 static const struct acpi_device_id acpi_cmos_rtc_ids[] = {
-	{ "PNP0B00" },
-	{ "PNP0B01" },
-	{ "PNP0B02" },
-	{}
+	ACPI_CMOS_RTC_IDS
 };
 
 bool cmos_rtc_platform_device_present;
diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index f8068c717fb85..7ac39c435f630 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -27,6 +27,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/acpi.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -1482,6 +1483,14 @@ static __init void cmos_of_init(struct platform_device *pdev)
 #else
 static inline void cmos_of_init(struct platform_device *pdev) {}
 #endif
+
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id acpi_cmos_rtc_ids[] = {
+	ACPI_CMOS_RTC_IDS
+};
+MODULE_DEVICE_TABLE(acpi, acpi_cmos_rtc_ids);
+#endif
+
 /*----------------------------------------------------------------*/
 
 /* Platform setup should have set up an RTC device, when PNP is
@@ -1536,6 +1545,7 @@ static struct platform_driver cmos_platform_driver = {
 		.name		= driver_name,
 		.pm		= &cmos_pm_ops,
 		.of_match_table = of_match_ptr(of_cmos_match),
+		.acpi_match_table = ACPI_PTR(acpi_cmos_rtc_ids),
 	}
 };
 
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 7d3a48f6425be..165ed21de842a 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -779,6 +779,12 @@ const char *acpi_get_subsystem_id(acpi_handle handle);
 int acpi_mrrm_max_mem_region(void);
 #endif
 
+#define ACPI_CMOS_RTC_IDS	\
+	{ "PNP0B00", },		\
+	{ "PNP0B01", },		\
+	{ "PNP0B02", },		\
+	{ "", }
+
 extern bool cmos_rtc_platform_device_present;
 
 #else	/* !CONFIG_ACPI */
-- 
2.53.0

