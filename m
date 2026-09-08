Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E088335BB4
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 16:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788883720; cv=none; b=pgCI+qKR4d0SOKFpJ+enTht86nTiP3m8iKW07liviSeeYOLZboEPb5Alky0R3h0dWGpa/h0b1VdylBiGuhwcaqF5MenbCsWLziD4lyNcpKqmzpuUZ6LKwkvTh4gAGG+bIq8WBWqyie2/Ybhoh04r64vEZUfyBNlr0Tfcise1wcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788883720; c=relaxed/simple;
	bh=mVPgHgfeXaaSfCfxMGiU/j/FCkJeL8wQb9r1EmzdPNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y0iC4zDOWxaQdHE7frh7nBbZhEd7eS2RgM0+MzSC8i4r8unElmml0UudQuuLBmz2FPgslX+mNAgIgfjDfPoPfQhA9l+an5o6I2TeqE0RzrUkaOxxEUnctVW/3F0Q7Id7ubGbfMXOkJaY9lB0Om6tq/vUPw0O7WxGMvQdTwwN4PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QpTBwOeN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QpTBwOeN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5119A1F00A3A;
	Tue,  8 Sep 2026 16:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788883716;
	bh=XgEH6EaguUXJ6iIUDWrrDzKVM3jfV4jOH+Xt+MEsLyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QpTBwOeNJlOZuskCnafG1/xNZ2x07NF3DN8cavSvpsCabOjzjpT7be2Up17FJ8w0/
	 9ukqRYkKQKbPIFYYLWPfLKtJbfV6C8P3yejVV32is1c3LpkAu6xIkeyuFFUXiyEi4h
	 HSUMAEhSQFEbJWyUwbALoSEKHQmChhbumSicSPUDzGwsscYBxVv6s4Z++xlppx8Yu6
	 kepD2IQz+SRrooE6BrhXjBM9sfz0NQIdQfJZueOR7IKLRwCBjhd4y/ThSEbCdVcDMS
	 ILKipKhAH3FDa7EoAmbs8mnE13b3FT9vhLoz03ARlJ1DKcICFTy6oj/dd6ERp5grJO
	 Hcyv90NteUdxw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] ACPI: TAD: Rearrange RT data validation checking
Date: Tue,  8 Sep 2026 12:08:31 -0400
Message-ID: <20260908160833.2575733-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090332-delighted-felt-tip-2059@gregkh>
References: <2026090332-delighted-felt-tip-2059@gregkh>
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
index 542e16c3ab9f6..7af8e6b833533 100644
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

