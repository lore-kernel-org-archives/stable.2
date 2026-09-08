Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB46153A8AC
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 12:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788870013; cv=none; b=JLFSijjvntZ5tpWDyEESKbkCOch6xTHrFscQyyHeJ5G/tlmqsYDOJ309thm4KK0tKLvqXCWRwISqgAgUjq5NPsabVk7iD4Ig9lJj+H7ZdFcKaqY+xvEmlJTI43vsUK/YIDIPqG9MkAL3CdFOhdImtPtu3BB6PWMJ7BM/Rr3Bdpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788870013; c=relaxed/simple;
	bh=sakJK3vwvTOIZwVSxqO05+Z7ILn5WCwggNK3qApicsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VQRbr9dCuTXHdoEAHSquzeqAJugo9hAmD4P8Jb1BwyqEjywxhr/0E0y/v5de21DMxrWpm+0/FedO1X3+EwrCFYMic19Lijb442wEn1Bsec0uJWMnnt2SJxzP7WQTSYGC/N3YMCi6gxHACAAfw922u/ZkOdqQ7d6x7/4xZ8b1s80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UpccBqyK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UpccBqyK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A420D1F00A3A;
	Tue,  8 Sep 2026 12:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788870008;
	bh=nrIJQ7BBGzk7SyqwI07ugN61x0ctoqoTxJjLJCR6wyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UpccBqyK08Hrw+J4Xq6vOBKgBzjLA2nbyFOZ3mJqLMlZZWixmuiI9QI/8bSbGj1nv
	 PjTOcLR+a9JqRYG17fNUeh41RAVbZ15wtL57MaMD1VdEnXuBGW6IeuQ/w6SkWXyEwr
	 wIiFWT8auBs/16FCYmiXI9H24uH1LG3MIY2PV9qyo9AneYsz6BpHv43HmJKb2xoQSm
	 1zGcJt1ZYu1nYycxbhaulwkyCa9s62vT5/wWg6QvfGGm0Py4qyYEQvSmPDeDMESvAF
	 5e7hEv5khW2QKk4/ZedZba4Q1GC8t5rrWgmKZElX3vCVkNtXuC22XOZiVWpuMMoREQ
	 UB8nlcZgD3BuQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/4] ACPI: x86: cmos_rtc: Create a CMOS RTC platform device
Date: Tue,  8 Sep 2026 08:20:01 -0400
Message-ID: <20260908122004.2049483-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090331-quartered-robe-d833@gregkh>
References: <2026090331-quartered-robe-d833@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit 1ae2f435350ec05224a39995c3a680aa6fdae5a5 ]

Make the CMOS RTC ACPI scan handler create a platform device that will
be used subsequently by rtc-cmos for driver binding on x86 systems with
ACPI and update add_rtc_cmos() to skip registering a fallback platform
device for the CMOS RTC when the above one has been registered.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com> # x86
Link: https://patch.msgid.link/1962427.tdWV9SEqCh@rafael.j.wysocki
Stable-dep-of: a3df8bbe0a70 ("ACPI: TAD: Add locking around AML evaluations")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/rtc.c       | 4 ++++
 drivers/acpi/x86/cmos_rtc.c | 8 ++++++++
 include/linux/acpi.h        | 4 ++++
 3 files changed, 16 insertions(+)

diff --git a/arch/x86/kernel/rtc.c b/arch/x86/kernel/rtc.c
index 51a849a79c985..b112178e81850 100644
--- a/arch/x86/kernel/rtc.c
+++ b/arch/x86/kernel/rtc.c
@@ -2,6 +2,7 @@
 /*
  * RTC related functions
  */
+#include <linux/acpi.h>
 #include <linux/platform_device.h>
 #include <linux/mc146818rtc.h>
 #include <linux/export.h>
@@ -146,6 +147,9 @@ static __init int add_rtc_cmos(void)
 		}
 	}
 #endif
+	if (cmos_rtc_platform_device_present)
+		return 0;
+
 	if (!x86_platform.legacy.rtc)
 		return -ENODEV;
 
diff --git a/drivers/acpi/x86/cmos_rtc.c b/drivers/acpi/x86/cmos_rtc.c
index 45db7e51cbe60..bdd66dfd4a441 100644
--- a/drivers/acpi/x86/cmos_rtc.c
+++ b/drivers/acpi/x86/cmos_rtc.c
@@ -24,6 +24,8 @@ static const struct acpi_device_id acpi_cmos_rtc_ids[] = {
 	{}
 };
 
+bool cmos_rtc_platform_device_present;
+
 static bool cmos_rtc_space_handler_present __read_mostly;
 
 static acpi_status acpi_cmos_rtc_space_handler(u32 function,
@@ -103,6 +105,12 @@ static int acpi_cmos_rtc_attach(struct acpi_device *adev,
 	if (ret < 0)
 		return ret;
 
+	if (IS_ERR_OR_NULL(acpi_create_platform_device(adev, NULL))) {
+		pr_err("Failed to create CMOS-RTC platform device\n");
+		return 0;
+	} else {
+		cmos_rtc_platform_device_present = true;
+	}
 	return 1;
 }
 
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 5ff5d99f6ead5..7d3a48f6425be 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -779,6 +779,8 @@ const char *acpi_get_subsystem_id(acpi_handle handle);
 int acpi_mrrm_max_mem_region(void);
 #endif
 
+extern bool cmos_rtc_platform_device_present;
+
 #else	/* !CONFIG_ACPI */
 
 #define acpi_disabled 1
@@ -1104,6 +1106,8 @@ static inline int acpi_mrrm_max_mem_region(void)
 	return 1;
 }
 
+#define cmos_rtc_platform_device_present	false
+
 #endif	/* !CONFIG_ACPI */
 
 #ifdef CONFIG_ACPI_HMAT
-- 
2.53.0

