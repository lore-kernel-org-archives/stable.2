Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57E0566C78
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 14:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965621; cv=none; b=o152FDkVQOH5k8u89harh3Z18m74wgwPbV/BKSjoDi1Ybty1zFTCRoDTc0Wb9xEGnkiEvhygp1XP92nRbQ1MtLPYtNs8ESAMg/FrBa9k5cRRD5J9FDKmM+WMtJi4OeFLrcEYsVsUoPZIE/M/ntWtmjaCZiHOREOK/7NAyKwGxrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965621; c=relaxed/simple;
	bh=Yd+PQNLzpo/9sZHy+UX4Q/az0qyQGXZhBTnGHqOL5uk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TkZ41fq7mk3HhYKE+n6kBZmN705mU6hKWBWYNOLUThfdqly4gScyz+YQebOBnzo9E/5J7YR6xmOXWUr75w9LujQ49qZyhp58LXwnQp6oD2yv8ONfbOZJkarq95w1npRo58d/VASdF1CLb747+6nGBpq1XNc7NVKxh33HnmeHnB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O0PmrhJS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O0PmrhJS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05C391F00A3E;
	Wed,  9 Sep 2026 14:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788965620;
	bh=la6LwFwRRuuZ71quaukeVEtif49aSnxGIpFJDV9bx/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O0PmrhJSUTBfCXuCy1Y9l751NAOpWDZc1Pt9zFkR8Ng9wOkEAXVWC+p1pPhA+8ky1
	 S+JAYFKYK8etEdwJ2bDEm0hPr8fIbfKxCeCG8HpryvkBfLebcey3Fv7C+2g5NYMN4E
	 4oF9GrRJZW5nlLVI5yrxUVm2tPoPMcTzAkTmQIrkwqn5lCNtHe/M+UogyNdmf4uUx1
	 IoKs6B6hiMe/c2y6Xvo3/q5xsxhfq1EqdmHtXbzFWt5FjfTVWRz7zsIdLNYhmOFxjB
	 6Goy2EdIS5RrS3LCdx7gkt5WpvbnSCnyDH/Iko9d/CeZDZlksk3qg7aL9/ZmVcy8rF
	 /qXiPJ1fyiqrQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] platform/x86: intel_sar: Check ACPI_HANDLE() against NULL
Date: Wed,  9 Sep 2026 10:53:37 -0400
Message-ID: <20260909145338.2698768-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090357-daylong-strangle-f0da@gregkh>
References: <2026090357-daylong-strangle-f0da@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit 2765f16c12af7c2533763e46b8113b727354012d ]

Every platform driver can be forced to match a device that doesn't match
its list of device IDs because of device_match_driver_override(), so
platform drivers that rely on the existence of a device's ACPI companion
object need to verify its presence.

Accordingly, add a requisite ACPI_HANDLE() check against NULL to the
platform/x86 intel_sar driver.

Fixes: dcfbd31ef4bc ("platform/x86: BIOS SAR driver for Intel M.2 Modem")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://patch.msgid.link/14023870.uLZWGnKmhe@rafael.j.wysocki
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

For this stable dependency, also convert the existing allocations in
parse_package() and sar_probe() to kmalloc_objs() and kzalloc_obj().
Both helpers are already available in this tree and retain the same
allocation sizes and GFP_KERNEL flags. This makes intel_sar.c match
the parent of 30c906cff490 ("platform/x86: int1092: Fix potential
memory leak in sar_probe()"), allowing that target to apply unchanged.
No new functions or allocation helpers are introduced.

Stable-dep-of: 30c906cff490 ("platform/x86: int1092: Fix potential memory leak in sar_probe()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/intel/int1092/intel_sar.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/intel/int1092/intel_sar.c b/drivers/platform/x86/intel/int1092/intel_sar.c
index 6246c066ade2b..af4c127d33f4d 100644
--- a/drivers/platform/x86/intel/int1092/intel_sar.c
+++ b/drivers/platform/x86/intel/int1092/intel_sar.c
@@ -91,8 +91,8 @@ static acpi_status parse_package(struct wwan_sar_context *context, union acpi_ob
 	    item->package.count <= data->total_dev_mode)
 		return AE_ERROR;
 
-	data->device_mode_info = kmalloc_array(data->total_dev_mode,
-					       sizeof(struct wwan_device_mode_info), GFP_KERNEL);
+	data->device_mode_info = kmalloc_objs(struct wwan_device_mode_info,
+					      data->total_dev_mode);
 	if (!data->device_mode_info)
 		return AE_ERROR;
 
@@ -245,15 +245,20 @@ static void sar_get_data(int reg, struct wwan_sar_context *context)
 static int sar_probe(struct platform_device *device)
 {
 	struct wwan_sar_context *context;
+	acpi_handle handle;
 	int reg;
 	int result;
 
-	context = kzalloc(sizeof(*context), GFP_KERNEL);
+	handle = ACPI_HANDLE(&device->dev);
+	if (!handle)
+		return -ENODEV;
+
+	context = kzalloc_obj(*context);
 	if (!context)
 		return -ENOMEM;
 
 	context->sar_device = device;
-	context->handle = ACPI_HANDLE(&device->dev);
+	context->handle = handle;
 	dev_set_drvdata(&device->dev, context);
 
 	result = guid_parse(SAR_DSM_UUID, &context->guid);
-- 
2.53.0

