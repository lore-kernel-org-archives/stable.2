Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794453160;
	b=ZfFkBzepz9Bitzaphfgypz5DrBNv/7YDNHQCqdy8shR8FqU1U2FWIvj/QhzeK+Crc7F7
	 sgkmbk2NOMaj/XEzheUpCu6LOwp9VQUc5iHqK9riT2ExVKOGMGvYSUeVw3DLt8X3kFA1w
	 Cc2lp3WQDGvPG1rrRsfSA/AccwXlELslpFxMHKKYu7snLjc0RwuMxO12vfZVNqj7CqoNr
	 H8fR6hsJdxra0Id8Q6Id6Qo9472HuDXozvSktyw/3HONA0TD46ovLUgwEChu1s8mOVbcz
	 FRyvBnMh/ljMOCGkAs4fUqgqfAcW5Gy24v0+cthqWd1jIUmqUloUcBNOWLZ0f5H4IjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794453160;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=hfEjGfo2rY0mSbC08Mx/p7COgxtfGBib/UQx6eRSdYk=;
	b=5WPvHrac1Ly3H6nkyEA9vR9tZDLsmwJJFm7aieexWE8d8te9YagBt79y/SqjJdGZCEk5
	 SOTAkNl/xERuOrkYA6B0FB36XqfVQ9mjXPQofhFr1IRbRW3gZOA2NECU362mvIa3cFcQi
	 5zTZf3wuYpAdAiufjNfADjO+O8mBxPUK1Zgs+2t7T1Vwyp2f9kuXoKb6PwenaqJRVlE3p
	 Xxu7HlLQLCqoB/J0J720jnL/pSatBG7WYFXBrHIu2duckJlCSXNKvpJvfrIfuK74YPurb
	 fmHO3KOdt6Cmo+h2ITaHmkIVfN1fASh/hV6DqNXAZPNnDgFt32FyTVKP9Ao59sfgHHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fNanq22c;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13BB606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 03:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fNanq22c
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E177D1F00A05;
	Thu, 12 Nov 2026 03:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794453160;
	bh=hfEjGfo2rY0mSbC08Mx/p7COgxtfGBib/UQx6eRSdYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fNanq22cxA9T4CEpDoN/AuKR5+kI1ATMT2b5NbXrRlNCwpZtowEyRXrsgeA1xWKLR
	 7KdjV3ERBGJFDTtd8KTLdrWXWPrkRvfw/WJIei8gZjonTDtWWXdgHqAQ3lT0eqRYj/
	 iewAdHe1bWyzpR8L5wxbYrNKlhTFJoWE5KNN+GB3twPqvQqfQSE2KvLLGshsD4xefM
	 bLJF4jcewPlZ7BENIRNC64wBwTHb6T6XiqWJyjEv42KtsGDTMZFURdnjkXi48b5Kh8
	 kRnFzMWBMYzLqqDT+XAWgqKT7zE0yFZnMK+OnVFdJMefu6Cpjif0DnYS4yj+FM6EqO
	 +T+GflmJxiWsQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/3] platform/x86: hp-wmi: Order DMI board name arrays
Date: Wed, 11 Nov 2026 22:12:35 -0500
Message-ID: <20261112031152.1461468-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112031152.1461468-1-sashal@kernel.org>
References: <20261107054735-failed-6.1-d35a1ea827a2@kernel.org>
 <20261112031152.1461468-1-sashal@kernel.org>
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

Include the prerequisite OMEN board entries and timed-profile table so
the subsequent 8A17 addition applies directly. Implement the timer quirk
in the existing profile setter: clear the EC countdown, enable NOTIMER
and TURBO for performance, and clear both for other profiles. Match the
upstream OMEN command's 0xff prefix.

Omit the Victus table changes because their profile support is absent.

Stable-dep-of: d35a1ea827a2 ("platform/x86: hp-wmi: Add OMEN board 8A17 thermal profile support")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/hp/hp-wmi.c | 62 +++++++++++++++++++++++++++-----
 1 file changed, 54 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index 2e24e528a744c..8829f8a435f0e 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -38,6 +38,8 @@ MODULE_ALIAS("wmi:5FB7F034-2C63-45E9-BE91-3D44E2C707E4");
 #define HPWMI_EVENT_GUID "95F24279-4D7B-4334-9387-ACCDC67EF61C"
 #define HPWMI_BIOS_GUID "5FB7F034-2C63-45E9-BE91-3D44E2C707E4"
 
+#define HP_OMEN_EC_THERMAL_PROFILE_FLAGS_OFFSET 0x62
+#define HP_OMEN_EC_THERMAL_PROFILE_TIMER_OFFSET 0x63
 #define HP_OMEN_EC_THERMAL_PROFILE_OFFSET 0x95
 
 #define zero_if_sup(tmp) (zero_insize_support?0:sizeof(tmp)) // use when zero insize is required
@@ -52,12 +54,18 @@ MODULE_ALIAS("wmi:5FB7F034-2C63-45E9-BE91-3D44E2C707E4");
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
+	"8C58",
+	"8E41",
 };
 
 /* DMI Board names of Omen laptops that are specifically set to be thermal
@@ -65,7 +73,17 @@ static const char * const omen_thermal_profile_boards[] = {
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
 
 enum hp_wmi_radio {
@@ -178,6 +196,11 @@ enum hp_thermal_profile_omen_v1 {
 	HP_OMEN_V1_THERMAL_PROFILE_COOL		= 0x50,
 };
 
+enum hp_thermal_profile_omen_flags {
+	HP_OMEN_EC_FLAGS_TURBO		= 0x04,
+	HP_OMEN_EC_FLAGS_NOTIMER		= 0x02,
+};
+
 enum hp_thermal_profile {
 	HP_THERMAL_PROFILE_PERFORMANCE	= 0x00,
 	HP_THERMAL_PROFILE_DEFAULT		= 0x01,
@@ -441,7 +464,11 @@ static int hp_wmi_get_tablet_mode(void)
 
 static int omen_thermal_profile_set(int mode)
 {
-	char buffer[2] = {0, mode};
+	/* The Omen Control Center actively sets the first byte of the buffer to
+	 * 255, so let's mimic this behaviour to be as close as possible to
+	 * the original software.
+	 */
+	char buffer[2] = {-1, mode};
 	int ret;
 
 	ret = hp_wmi_perform_query(HPWMI_SET_PERFORMANCE_MODE, HPWMI_GM,
@@ -1146,6 +1173,8 @@ static int platform_profile_omen_get(struct platform_profile_handler *pprof,
 static int platform_profile_omen_set(struct platform_profile_handler *pprof,
 				     enum platform_profile_option profile)
 {
+	const char *board_name = dmi_get_system_info(DMI_BOARD_NAME);
+	enum hp_thermal_profile_omen_flags flags = 0;
 	int err, tp, tp_version;
 
 	tp_version = omen_get_thermal_policy_version();
@@ -1180,6 +1209,23 @@ static int platform_profile_omen_set(struct platform_profile_handler *pprof,
 	if (err < 0)
 		return err;
 
+	if (board_name &&
+	    match_string(omen_timed_thermal_profile_boards,
+			 ARRAY_SIZE(omen_timed_thermal_profile_boards),
+			 board_name) >= 0) {
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

