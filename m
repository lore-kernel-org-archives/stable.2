Received: from va-1-115.ptr.blmpb.com (va-1-115.ptr.blmpb.com [209.127.230.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A15F4594E
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 02:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791511555; cv=none; b=SL2+0PkYjYbSQmqVBCT0vEFkjEv1YesYK7jiUaX/zS5Czj/iXajTaxQ5HisX6Z/GPpo2jfisukuiIRwi7oNiI5OZu7SUMZVmaKowlTUJiaY/13B1Q7LdDmpiA+Ni1ulQ2qpw00eOXCqfwhgijmd46V1b5LAtjbYvYeOaw80D46o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791511555; c=relaxed/simple;
	bh=vM/219kW0GUnhl+QaWvYEue3Yn1LeK6T8AsxRcL6/H8=;
	h=Cc:Message-Id:Content-Type:To:Subject:From:Date:Mime-Version; b=BF0yRi65B78FS9k4ysvrw3JDj72Sly0FpKahNg+NoQJWBSGk2cWOxNqtPpiIWCOfEZ4ei6Mr34BF6WM4MNwlQQTEht+oDu2Aw0EUnosSkyjGENvHEKom/Xjpa60US3FhNemD3UFPRMBOxWbQf1NxUIFHRwxr/qoZSuV4saH/XcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Amlbo/sc; arc=none smtp.client-ip=209.127.230.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Amlbo/sc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1791511546; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=LKiQnCGHUZ2nk19TVt8SnmnQqa0mKzZoQnMjcrji8Q4=;
 b=Amlbo/scsOK0nIiS0hxaLIzYqWh47nrQKI5yE0ddMoT5fLqPH4m+Vb7If/EC4ALHOmZoPQ
 SpJOvBIDHEojqu1Z/BZf9gg9AVGIhoAlDeg70J57kCaVQVEbXJE5dJ3DyqlmRCRCEONRIh
 B22gDqE4Uv7RicgK+v/9g4GBcx1wfEEIELtE/UXmrICK8LowQe78zayI9IcJYfr7FGuREe
 onK0lARt5XKhFqkvYf8c3i8EweJmcMFrxIJtkaZwKYIBNpdqc8RkaWU9jWJsLpoYX5rRqr
 IVYDJHkggOIl1YV9hREsl1i6k3EtwYzYLZAzFyaJFKgivkIMj0bCPIGT/c9KfA==
Cc: "Guixiong Wei" <weiguixiong@bytedance.com>, 
	"Borislav Petkov" <bp@alien8.de>, "Tony Luck" <tony.luck@intel.com>, 
	"Muralidhara M K" <muralidhara.mk@amd.com>, <linux-edac@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
X-Mailer: git-send-email 2.55.0
Message-Id: <20261009020447.90758-2-weiguixiong@bytedance.com>
X-Original-From: Guixiong Wei <weiguixiong@bytedance.com>
Content-Transfer-Encoding: 7bit
X-Lms-Return-Path: <lba+26ac84bf9+ef8a6d+vger.kernel.org+weiguixiong@bytedance.com>
Content-Type: text/plain; charset=UTF-8
To: "Yazen Ghannam" <yazen.ghannam@amd.com>
Subject: [PATCH] EDAC/mce_amd: Add missing long names for SMCA bank types
From: "Guixiong Wei" <weiguixiong@bytedance.com>
Date: Fri,  9 Oct 2026 10:04:24 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0

Commit 47b744ea5e3c ("x86/MCE/AMD: Add new MA_LLC, USR_DP,
and USR_CP bank types") added three SMCA bank types after the bank long
names had been moved to the MCE decoder.

The new types were added to the enum, short-name table, and HWID/McaType
mapping, but not to smca_long_names[]. As a result, an error from any of
these banks is logged with "(null)" in place of the bank name.

Add the missing long names.

Fixes: 47b744ea5e3c ("x86/MCE/AMD: Add new MA_LLC, USR_DP, and USR_CP bank types")
Cc: stable@vger.kernel.org
Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
---
 drivers/edac/mce_amd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index 7aee57a25b689..34a44769d1d0f 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -702,6 +702,7 @@ static const char * const smca_long_names[] = {
 	[SMCA_L2_CACHE]			= "L2 Cache",
 	[SMCA_L3_CACHE]			= "L3 Cache",
 	[SMCA_LS ... SMCA_LS_V2]	= "Load Store Unit",
+	[SMCA_MA_LLC]			= "Memory Attached Last Level Cache",
 	[SMCA_MP5]			= "Microprocessor 5 Unit",
 	[SMCA_MPART]			= "MPART Unit",
 	[SMCA_MPASP ... SMCA_MPASP_V2]	= "MPASP Unit",
@@ -726,6 +727,8 @@ static const char * const smca_long_names[] = {
 	[SMCA_UMC]			= "Unified Memory Controller",
 	[SMCA_UMC_V2]			= "Unified Memory Controller v2",
 	[SMCA_USB]			= "USB Unit",
+	[SMCA_USR_CP]			= "Ultra Short Reach Control Plane Controller",
+	[SMCA_USR_DP]			= "Ultra Short Reach Data Plane Controller",
 	[SMCA_WAFL_PHY]			= "WAFL PHY Unit",
 	[SMCA_XGMI_PCS]			= "Ext Global Memory Interconnect PCS Unit",
 	[SMCA_XGMI_PHY]			= "Ext Global Memory Interconnect PHY Unit",
-- 
2.50.1 (Apple Git-155)
