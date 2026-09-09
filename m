Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C3D57ED96
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 14:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965436; cv=none; b=fn5FEsUclxVek7R8UgEwHgMqEavKFWX0mY8Z73ltHlqcJ+qw5otZSuELB9nMtacjnea4kq5mnNMkKE0vBWP4Y2dq45tNPE1rwmKArva8nVTdv6sMyZuWjNizE+5qWWOHkeH8WcSBuuKZW8868ivs0XLIMlL0q6lLNYawpxVX1Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965436; c=relaxed/simple;
	bh=sT5TsU169p7be6ktit5hYOtwBV17qt4/xA0cjUiMGsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fYHEZX4XId15glVIFhmSdUt2JR1NYptGLqsv1UIw8yn72mHRArQaABIdFMy/gvMcJASAY0o2FlhHH9cz+tIW0vVVnHvAJP282jWabq826w0zXCKWFi0SsFVnf6DBawpPS4V5HoWmtWiuSPmwkyDY2eO1fq1VCNo6P0rWs8lnboo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RD57b2RI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RD57b2RI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C5761F00AC4;
	Wed,  9 Sep 2026 14:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788965434;
	bh=gwwg3zeV6NfWNNHPGol5KArR/pVLcdmVwWS/ZiKMbzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RD57b2RIYBK7D3mjYAvK/4zkMa4XXe5ql2iJXbBE/E0OZVB3aTlPNOgsLjn/04nAk
	 3Cq3+na+aKEeBymNxnkBQoBJ5wDQIs9Y3qHI1A8SoSdoPwZTLZPdW+MaNvIQ6BjHKW
	 973lJ2HA28lWRw3U3QZ6JWl7Z58R73THbB0QlyAfdavEr3Ft7Id+Pg0lnA8gF0Xsgm
	 zifwFkZhq8t+E0Q1+rBlBejgZBnpqrlJ0E1RURoOVwHAOQV+KkEgcZmIp9cWKAWvlL
	 Kghe2rQVqYMxI5dMVaPAlJC/c51BGHKF+0tetmCbUPO38rsKPG3IPcOTTNzalvGCok
	 FJcqmAn+6YltQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] platform/x86: intel_sar: Check ACPI_HANDLE() against NULL
Date: Wed,  9 Sep 2026 10:50:31 -0400
Message-ID: <20260909145032.2673759-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090357-antennae-prong-732d@gregkh>
References: <2026090357-antennae-prong-732d@gregkh>
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
index e526841aff603..849f7b415c1e5 100644
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

