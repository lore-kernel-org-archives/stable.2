Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794453159;
	b=V9meVzPmtDXapjbGvhU1xQR0NjWlBz3WZncV6JTc4VwTeexngKWxosZHF6nByQbIAVST
	 oPw8BpNVEUdJkgc7hqvGb22ZMgWV8AKjhI9ab8ZCVv56mF5bTXxQN2SJkJ7t2GGCnr4pX
	 CFfdeL+EOW3Sgf//kuwE6Svm2f4hgc8YMxEj3UzySGlWKzoHc/Myj6Sul7gDYuPbc0XLc
	 DBL3zqiOeVydTvPzJSedzyXOZXwXXDivSYSYHIyWgwsQngpCH0R/a6Sv2+ZBiNIdCQBEN
	 S6vSJFcLaWvGKzlFOWN8KltmG5zlJRZA+KfGUAQUg8AnOXw0LDcErnx7SPhGm2Qq+kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794453159;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=DVHAjJCZlBRz14m9mRxsb5DfIEBEAik2Zi9Qv2WUfMM=;
	b=b3q2GSoT40N9sIm5IcKh5yArNOsky7gb41aVDFHCgMsZrOJvN3dbXltDIZQeUCx2RDa3
	 lWQFVpSIJk7SwIsjKiUJAaOx8v2vZSPipdZ67nqQhYF1AyDQk8WmTEmsNhrKVbFocCioX
	 NaB0HuTFXG1QvxUH9x9b0Hh59q6lfp83y2f+6Kebjotwtca2/rbuyb+6MpqQFYLTHrhJQ
	 GXiRSQiAc0Hep1tbeTMX+y6snFFDQxrwgDezZmFShpogKAaOVZcIMJ/Bc+EuLbQg3inkC
	 5viDe/dYnFUiwR7ySkONCuEJCC9/ekwXqgr1nCzBMegYW0rUigCkRzoHvl5oWkVMfoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PCrkvwaM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6D7606A323
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 03:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PCrkvwaM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 260FE1F00A05;
	Thu, 12 Nov 2026 03:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794453159;
	bh=DVHAjJCZlBRz14m9mRxsb5DfIEBEAik2Zi9Qv2WUfMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PCrkvwaMZsXILiiBD/xv6cqtiJFYsK2ThnE1D56WhPRYaiJiYNso0gVffJGUw6u52
	 Vsm+fQzOw9AS7SsLpTj2FGjT+2xbLjyTvVvLEkORlH+GdZLRvSU50GqmhW4BHEfmWZ
	 vmIn/+7/2/soYQ+WJWWkYraam7IesshZU8V471MNKCkVt9HcpzVg2dmnTGd+Q9Fwi0
	 lDOxIP51bliBsE0CKGhpeD8dMMUf8TLHEx/V9OE16JwgH8dMGQFWHNw3oJ5sHZolG3
	 uC/FmZzg8+xZe2pmn+qWXHLg6CKK3pcU2c/YuLd1sBldyFxTL+Dl7+dRQZheBWLor6
	 iQA3XNNnDkBXA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alexis Belmonte <alexbelm48@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] platform/x86: hp-wmi: Tidy up module source code
Date: Wed, 11 Nov 2026 22:12:34 -0500
Message-ID: <20261112031152.1461468-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054735-failed-6.1-d35a1ea827a2@kernel.org>
References: <20261107054735-failed-6.1-d35a1ea827a2@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Alexis Belmonte <alexbelm48@gmail.com>

[ Upstream commit 24b10e5f8e0d2bee1a10fc67011ea5d936c1a389 ]

This commit performs four things:

   - fix up the GUID string inconsistency (lower case 'e') from the
     WMI module alias declaration/macro definition

   - separate GUID macros from the embedded controller offset macros

   - rename the description of the module to better represent what it
     actually achieves as a whole

   - add a space right before the '*' pointer qualifier to match the
     other array declarations

This also prepares the terrain for integrating support work for boards
identified as '8BAD', which corresponds to HP's Omen 17 ck2xxx models.

Signed-off-by: Alexis Belmonte <alexbelm48@gmail.com>
Link: https://lore.kernel.org/r/ZbucrKh36sNxeyfX@alexis-pc
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Stable-dep-of: d35a1ea827a2 ("platform/x86: hp-wmi: Add OMEN board 8A17 thermal profile support")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/hp/hp-wmi.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index 305240c1917c4..2e24e528a744c 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -29,15 +29,17 @@
 #include <linux/dmi.h>
 
 MODULE_AUTHOR("Matthew Garrett <mjg59@srcf.ucam.org>");
-MODULE_DESCRIPTION("HP laptop WMI hotkeys driver");
+MODULE_DESCRIPTION("HP laptop WMI driver");
 MODULE_LICENSE("GPL");
 
 MODULE_ALIAS("wmi:95F24279-4D7B-4334-9387-ACCDC67EF61C");
-MODULE_ALIAS("wmi:5FB7F034-2C63-45e9-BE91-3D44E2C707E4");
+MODULE_ALIAS("wmi:5FB7F034-2C63-45E9-BE91-3D44E2C707E4");
 
 #define HPWMI_EVENT_GUID "95F24279-4D7B-4334-9387-ACCDC67EF61C"
-#define HPWMI_BIOS_GUID "5FB7F034-2C63-45e9-BE91-3D44E2C707E4"
+#define HPWMI_BIOS_GUID "5FB7F034-2C63-45E9-BE91-3D44E2C707E4"
+
 #define HP_OMEN_EC_THERMAL_PROFILE_OFFSET 0x95
+
 #define zero_if_sup(tmp) (zero_insize_support?0:sizeof(tmp)) // use when zero insize is required
 
 /* DMI board names of devices that should use the omen specific path for
@@ -62,7 +64,7 @@ static const char * const omen_thermal_profile_boards[] = {
  * profile version 0 by the Omen Command Center app, regardless of what
  * the get system design information WMI call returns
  */
-static const char *const omen_thermal_profile_force_v0_boards[] = {
+static const char * const omen_thermal_profile_force_v0_boards[] = {
 	"8607", "8746", "8747", "8749", "874A", "8748"
 };
 
-- 
2.53.0

