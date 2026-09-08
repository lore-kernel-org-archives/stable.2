Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FDB560AC0
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 16:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788884042; cv=none; b=dbMYlzzjS6vkbt65bAMLfWquOKh350/CMMOvMlC31/8D4NEY1eRFo19400gpaKYpXIdKpoHpDstg2cso7mUIF0S0QS/Zod6A11yQf62Q4WvjaudqQKkX8gnZWlhszzNYlQmKGBn09h3X3U+rwrC6+Utc7omGt6nbp7VoqhHcxno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788884042; c=relaxed/simple;
	bh=JwDVA+wGmnWCXy+ogztDp4IH7cRai0KmXbi2xGfZUcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nitzLQH2+0NqHTfXWoLvtv2/G0x1tHel+aeq7FbO+58oyhqE2sh8CRpwPdOELNYPzKigfhy6k6NgQTyhxBbOxQ1V6MgEm+ktMA4Rh2LARl9gUNb+OQYNpS70gPZvXkgRyXrAICOrHX2X+4grx8EQyT8/Q2la9mUN7hCzw+gTRvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8GbxWlp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8GbxWlp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6764F1F00A3A;
	Tue,  8 Sep 2026 16:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788884037;
	bh=Ynk9eaDU6FP0oflZg7NXaM5jRLiVcw3tVQ/cMxkrjO8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q8GbxWlphnNUiBzBRvEU4ktOiIQg3ng5lECDUAwCgFkjDTIhwk4pXip65c1wx0ZnU
	 Sz05mUnlmohfhXU7ZMvwtByMSkn22ArpYXLphYv/AbLh97eTiTTAzo9HzMtKYifpqL
	 WAx4tDObCf+1GrMED5YHpr2eYv4Hbt/6SMQ/w8i+bbSzHhAZ/u+XDV3F12Vo1p9Oh5
	 NotAmkVCNKV5V+PxzS0xvlL6v07TAs2j7lUvG5cOQTFptKVaSJK4mbrfSN4sf020lC
	 l/3jWJ7zFHDpjI4TbNR0stBTEc3Of7NpNoJnv/+YjYq02BBeCWmpYlG5ivxaj8QISm
	 i6ehVd+684fHA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] ACPI: TAD: Rearrange RT data validation checking
Date: Tue,  8 Sep 2026 12:13:53 -0400
Message-ID: <20260908161355.2608022-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090332-kindling-purplish-35e9@gregkh>
References: <2026090332-kindling-purplish-35e9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit 3329a1416c3350449081ca5daaa94802a65b2992 ]

Move RT data validation checks from acpi_tad_set_real_time() to
a separate function called acpi_tad_rt_is_invalid() and use it
also in acpi_tad_get_real_time() to validate data coming from
the platform firmware.

Also make acpi_tad_set_real_time() return -EINVAL when the RT data
passed to it is invalid (instead of -ERANGE which is somewhat
confusing) and introduce ACPI_TAD_TZ_UNSPEC to represent the
"unspecified timezone" value.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://patch.msgid.link/3409319.aeNJFYEL58@rafael.j.wysocki
Stable-dep-of: a3df8bbe0a70 ("ACPI: TAD: Add locking around AML evaluations")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/acpi_tad.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpi_tad.c b/drivers/acpi/acpi_tad.c
index 8383d6329c645..664281d7f4259 100644
--- a/drivers/acpi/acpi_tad.c
+++ b/drivers/acpi/acpi_tad.c
@@ -48,6 +48,9 @@ MODULE_AUTHOR("Rafael J. Wysocki");
 /* Special value for disabled timer or expired timer wake policy. */
 #define ACPI_TAD_WAKE_DISABLED	(~(u32)0)
 
+/* ACPI TAD RTC */
+#define ACPI_TAD_TZ_UNSPEC	2047
+
 struct acpi_tad_driver_data {
 	u32 capabilities;
 };
@@ -66,6 +69,16 @@ struct acpi_tad_rt {
 	u8 padding[3]; /* must be 0 */
 } __packed;
 
+static bool acpi_tad_rt_is_invalid(struct acpi_tad_rt *rt)
+{
+	return rt->year < 1900 || rt->year > 9999 ||
+	    rt->month < 1 || rt->month > 12 ||
+	    rt->hour > 23 || rt->minute > 59 || rt->second > 59 ||
+	    rt->tz < -1440 ||
+	    (rt->tz > 1440 && rt->tz != ACPI_TAD_TZ_UNSPEC) ||
+	    rt->daylight > 3;
+}
+
 static int acpi_tad_set_real_time(struct device *dev, struct acpi_tad_rt *rt)
 {
 	acpi_handle handle = ACPI_HANDLE(dev);
@@ -79,12 +92,8 @@ static int acpi_tad_set_real_time(struct device *dev, struct acpi_tad_rt *rt)
 	unsigned long long retval;
 	acpi_status status;
 
-	if (rt->year < 1900 || rt->year > 9999 ||
-	    rt->month < 1 || rt->month > 12 ||
-	    rt->hour > 23 || rt->minute > 59 || rt->second > 59 ||
-	    rt->tz < -1440 || (rt->tz > 1440 && rt->tz != 2047) ||
-	    rt->daylight > 3)
-		return -ERANGE;
+	if (acpi_tad_rt_is_invalid(rt))
+		return -EINVAL;
 
 	args[0].buffer.pointer = (u8 *)rt;
 	args[0].buffer.length = sizeof(*rt);
@@ -131,6 +140,11 @@ static int acpi_tad_get_real_time(struct device *dev, struct acpi_tad_rt *rt)
 		goto out_free;
 
 	memcpy(rt, data, sizeof(*rt));
+	if (acpi_tad_rt_is_invalid(rt)) {
+		ret = -ENODATA;
+		goto out_free;
+	}
+
 	ret = 0;
 
 out_free:
-- 
2.53.0

