Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794451850;
	b=GRz5koPprfOMdtAV2Q4RWMPGQKs4H1frnsMQvnEJGUjygmo/57znCHCunF7WViP93MFL
	 MsT022OH+UfFS1rzLlzWOsOtUvZyRu3no9vzI29mSOXgLJQ3veZ7BIIwnsM1OUjB9fz8e
	 vXj3r7JOFa3Jjr29uLPFZeYf+ic8z/BPHgQyghxgJUhUgsFmobOawCLJZI8xEliKlhe2t
	 VmxJ7CHGTYY2CtuSup13SbSsm7PUGx5m8N4Y3klHSgUEpTCTZKRkl4p+WIeKp1OwHSjIa
	 mZQl9Nb4jXI5tgGpUKQsG9IzC170vH9mz/lQEoXWW6j0FFYvBCMPYVAf+ZhLQ52IEJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794451850;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=BziyuS/V3AfxyF1gWbtldyUp6v/DHn2jhLKtElPdUVw=;
	b=TIYXxcxdRMHvSLqzTdTjeicR3hZkGmL0YJuZ4fRtUgBegl+CO0T0/+aZ0VSLftiQULvk
	 KjajkuuBosZPkMNbp4GZ0Dee2piYjpEOCnu5n6RO0dQFeqcLbR65wo26VmU15QIYcujpH
	 0Vw+Ur+KXN2L5FZRp+Jcny+IV/k9/sUpLcBil8teYHfgsmJkeQy5kXtSrNAHz6euCNlK4
	 nk2chcLrSrrEipZBRHbt8pIo0cgP/xE2y6V6MZU3rvlGMBBkzCDMzt/yB7h+G/hZZFfNq
	 1QUoFSQFenMCJIqw6Yv+gjHMIwojNsgKT9fknNrYB0E1z5iWq4yIJHCrKZ2o79S+kAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g1vZjeF4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0DB606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 02:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g1vZjeF4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 773D11F00A05;
	Thu, 12 Nov 2026 02:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794451850;
	bh=BziyuS/V3AfxyF1gWbtldyUp6v/DHn2jhLKtElPdUVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g1vZjeF45H/5m4/NIVqSYiy2/QO6+oVnFS45CtVJiyp2bc/jqV+ymkN9i1jg90Dk4
	 G4agMjyyLg6Ta86VRqnhSrds7acANJdIB4WgO2mj+UNVbWDEk1wngeuHEuiZyGr+q6
	 H5A6vL0m5IvdXc5TTvLXY0JjupyF5qX9S2UIridAdPp9lSLATP5Lnku6IfSMzy/2Jt
	 HAUD4uBSpKwI3TApcOYesqg/NjkNMTMqgkVxr2nAHG2HGRPMAJn6G3OU3hm8PX3Xdc
	 fOJM4lh9OIUIEpy9bFejay1/Wo9glOXjr6zXQZwpNeOeY7XN24cwvUYTiLtmi6Ojni
	 bG+6F3pGt6iXw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alexis Belmonte <alexbelm48@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] platform/x86: hp-wmi: Tidy up module source code
Date: Wed, 11 Nov 2026 21:50:46 -0500
Message-ID: <20261112025039.1402391-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053407-failed-6.6-d35a1ea827a2@kernel.org>
References: <20261107053407-failed-6.6-d35a1ea827a2@kernel.org>
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
index 869868802160e..81c61e58ec0c9 100644
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

