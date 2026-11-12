Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794451850;
	b=rIylOBAH7KTN5E2SeS+dCTVAL2ORWEKgk/GoSz+w0TbmJcBBqkhw40BYQX7nUWaSy1G9
	 FUKI0fEjkR0D1Itj2yzFKCszxmlkI3I45wz9IyseQBuHMaqmfrt3rSLS56Vxhk1Lt8Hcs
	 Y2RNS7wSp9C+/56nD20MX/afGivynPKHLLKmajsrrgxb+6qi6u4EmOZKDIrNuGx3wc10B
	 5UL68d5XQ7tJXRXibvLff2V+fjG9jOh1+4rggKqx+h4BxnASHpDVA72QyK960HKm8TlY7
	 cYjbb1TySq9MZYNsbavbm4HGhqd4iDWX1jh8pP+tKULuoa9L+26WgBB2MkeNBDYRWOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794451850;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=o2KWhkssJPUQAqj4QzAMm0ob40yte7EorO89+7I6uMQ=;
	b=nCmYu9Umadz+BYJqxv26m7C/U39u7vJq2/akimPB8onS+B/g5cksOLBsuP+0MFmgDHem
	 h804Ijru+PDy7fhN1CPMV5kMKo7Cy9rdFZI7FEpjp7J7aLtzLoT/lt0XELmvGw3M8+fZu
	 d34nvhtsTfElhzgrYO2+6sfi1emYbcmdavnvZYZJVM7/e2DjQf8d7MPuBJq+m/Fdg6THq
	 c+CE5E/wj74FI3FhCCdYv+k6p9kKn23QQLiao6c1Otdqpz7BrSZDUouQCyFc9Nb7+KYtY
	 V2xnCivXsvN1CThvXJJvpzkyUAi8kCBqX42fQs/1FvpmcJypGg2GYOxgQvH8uFC+4RA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SNKKO1Hs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B987C606A324
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 02:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SNKKO1Hs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3617E1F00A07;
	Thu, 12 Nov 2026 02:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794451850;
	bh=o2KWhkssJPUQAqj4QzAMm0ob40yte7EorO89+7I6uMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SNKKO1HsfcgdOzULnynIY/Pw8OOz6Qm1rFvFdWlz4ZTzwtBJPBge4euD52Cecrc19
	 of5oAZsnRLnJAn+8AeHDNVs9ktxH+011omU4Wtez3YlL3LN9mZUwxyOkmG1vWoePMh
	 WrjTOiOUacIXNI69q1ZpOmYUJo+I+iTr7gU21FC5OUwySJ5LU6bXZDlUYAX9l6YBEm
	 /IQ9AorQV2YegebD2HRDm3Gttz+VfWcxdhFUq9LK62x5jXxz2rQalhFOGHHeTxiEN2
	 mole2LEuTu86WYPzKrCuGWDWFIP8ujqEQ9Q5k/n5Hz599PjblxMaM1A9IIAtoUy8//
	 9wUatTmx5ZR8Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] platform/x86: hp-wmi: Order DMI board name arrays
Date: Wed, 11 Nov 2026 21:50:47 -0500
Message-ID: <20261112025039.1402391-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112025039.1402391-1-sashal@kernel.org>
References: <20261107053407-failed-6.6-d35a1ea827a2@kernel.org>
 <20261112025039.1402391-1-sashal@kernel.org>
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

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

[ Upstream commit 68779adbabdbb1891ba4d9b8c7d3be99ed5e0b3d ]

The hp-wmi driver has a number of arrays that are getting new entries
and all/most entries have been added to the end of the array. As a
result, the numerical order is mixed up in a few entries.

Reorder the array entries. Split lines for each two leading chars to
make the arrays easier to read.

Add also trailing commas.

Link: https://patch.msgid.link/20251128120215.4450-1-ilpo.jarvinen@linux.intel.com
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

[ sashal: Include the prerequisite OMEN board entries and timed-profile
support. Clear the EC timer and update the turbo/no-timer flags directly
in the existing profile setter, and use the firmware's expected command
buffer prefix. This prepares both board lists for the thermal-profile
update without adding helper functions. ]

Stable-dep-of: d35a1ea827a2 ("platform/x86: hp-wmi: Add OMEN board 8A17 thermal profile support")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/hp/hp-wmi.c | 58 +++++++++++++++++++++++++++-----
 1 file changed, 49 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index 81c61e58ec0c9..beb96d3851fb3 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -38,6 +38,8 @@ MODULE_ALIAS("wmi:5FB7F034-2C63-45E9-BE91-3D44E2C707E4");
 #define HPWMI_EVENT_GUID "95F24279-4D7B-4334-9387-ACCDC67EF61C"
 #define HPWMI_BIOS_GUID "5FB7F034-2C63-45E9-BE91-3D44E2C707E4"
 
+#define HP_OMEN_EC_THERMAL_PROFILE_FLAGS_OFFSET 0x62
+#define HP_OMEN_EC_THERMAL_PROFILE_TIMER_OFFSET 0x63
 #define HP_OMEN_EC_THERMAL_PROFILE_OFFSET 0x95
 
 #define zero_if_sup(tmp) (zero_insize_support?0:sizeof(tmp)) // use when zero insize is required
@@ -52,12 +54,16 @@ MODULE_ALIAS("wmi:5FB7F034-2C63-45E9-BE91-3D44E2C707E4");
  * contains "PerformanceControl".
  */
 static const char * const omen_thermal_profile_boards[] = {
-	"84DA", "84DB", "84DC", "8574", "8575", "860A", "87B5", "8572", "8573",
-	"8600", "8601", "8602", "8605", "8606", "8607", "8746", "8747", "8749",
-	"874A", "8603", "8604", "8748", "886B", "886C", "878A", "878B", "878C",
-	"88C8", "88CB", "8786", "8787", "8788", "88D1", "88D2", "88F4", "88FD",
-	"88F5", "88F6", "88F7", "88FE", "88FF", "8900", "8901", "8902", "8912",
-	"8917", "8918", "8949", "894A", "89EB"
+	"84DA", "84DB", "84DC",
+	"8572", "8573", "8574", "8575",
+	"8600", "8601", "8602", "8603", "8604", "8605", "8606", "8607", "860A",
+	"8746", "8747", "8748", "8749", "874A", "8786", "8787", "8788", "878A",
+	"878B", "878C", "87B5",
+	"886B", "886C", "88C8", "88CB", "88D1", "88D2", "88F4", "88F5", "88F6",
+	"88F7", "88FD", "88FE", "88FF",
+	"8900", "8901", "8902", "8912", "8917", "8918", "8949", "894A", "89EB",
+	"8A15", "8A18", "8A42", "8A43",
+	"8BAD",
 };
 
 /* DMI Board names of Omen laptops that are specifically set to be thermal
@@ -65,12 +71,22 @@ static const char * const omen_thermal_profile_boards[] = {
  * the get system design information WMI call returns
  */
 static const char * const omen_thermal_profile_force_v0_boards[] = {
-	"8607", "8746", "8747", "8749", "874A", "8748"
+	"8607",
+	"8746", "8747", "8748", "8749", "874A",
+};
+
+/* DMI board names of Omen laptops that have a thermal profile timer which will
+ * cause the embedded controller to set the thermal profile back to
+ * "balanced" when reaching zero.
+ */
+static const char * const omen_timed_thermal_profile_boards[] = {
+	"8A15", "8A42",
+	"8BAD",
 };
 
 /* DMI Board names of Victus laptops */
 static const char * const victus_thermal_profile_boards[] = {
-	"8A25"
+	"8A25",
 };
 
 enum hp_wmi_radio {
@@ -184,6 +200,12 @@ enum hp_thermal_profile_omen_v1 {
 	HP_OMEN_V1_THERMAL_PROFILE_COOL		= 0x50,
 };
 
+enum hp_thermal_profile_omen_flags {
+	HP_OMEN_EC_FLAGS_TURBO		= 0x04,
+	HP_OMEN_EC_FLAGS_NOTIMER	= 0x02,
+	HP_OMEN_EC_FLAGS_JUSTSET	= 0x01,
+};
+
 enum hp_thermal_profile_victus {
 	HP_VICTUS_THERMAL_PROFILE_DEFAULT		= 0x00,
 	HP_VICTUS_THERMAL_PROFILE_PERFORMANCE		= 0x01,
@@ -457,7 +479,7 @@ static int hp_wmi_get_tablet_mode(void)
 
 static int omen_thermal_profile_set(int mode)
 {
-	char buffer[2] = {0, mode};
+	char buffer[2] = {-1, mode};
 	int ret;
 
 	ret = hp_wmi_perform_query(HPWMI_SET_PERFORMANCE_MODE, HPWMI_GM,
@@ -1212,6 +1234,8 @@ static int platform_profile_omen_get(struct platform_profile_handler *pprof,
 static int platform_profile_omen_set(struct platform_profile_handler *pprof,
 				     enum platform_profile_option profile)
 {
+	const char *board_name = dmi_get_system_info(DMI_BOARD_NAME);
+	enum hp_thermal_profile_omen_flags flags = 0;
 	int err, tp, tp_version;
 
 	tp_version = omen_get_thermal_policy_version();
@@ -1246,6 +1270,22 @@ static int platform_profile_omen_set(struct platform_profile_handler *pprof,
 	if (err < 0)
 		return err;
 
+	if (board_name && match_string(omen_timed_thermal_profile_boards,
+				       ARRAY_SIZE(omen_timed_thermal_profile_boards),
+				       board_name) >= 0) {
+		err = ec_write(HP_OMEN_EC_THERMAL_PROFILE_TIMER_OFFSET, 0);
+		if (err < 0)
+			return err;
+
+		if (profile == PLATFORM_PROFILE_PERFORMANCE)
+			flags = HP_OMEN_EC_FLAGS_NOTIMER |
+				HP_OMEN_EC_FLAGS_TURBO;
+
+		err = ec_write(HP_OMEN_EC_THERMAL_PROFILE_FLAGS_OFFSET, flags);
+		if (err < 0)
+			return err;
+	}
+
 	return 0;
 }
 
-- 
2.53.0

