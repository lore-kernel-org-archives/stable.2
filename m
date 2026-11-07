Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047806;
	b=VQdRVDW0g9NdCNCJjqaU/PGxohmfeEHy1gpafKKI0gmcEDFRTrpp1wrjnB9HAJXvnZ5F
	 KNS3+h96KC8krkXPlWjHAQ2htqDIe0JQjmvjbBtFYCGmMkp3hBMvLEzkq+BJc0dGFkpvM
	 MhE2FVn90mVLxcX9X3L1HYilcUU+aycS8gxoFgKhsfFBYJGUYhmqhCrCPfhHtp7U+ZrEI
	 gpniT1tTqFICjCFnhXaiiatVKuBr6qvBQT8ynvCD+PHXRVANyLs2gkz7wIBRK1XwlAUHp
	 9/2do+YmVeNORDDhpfOpZiGO5Heo8HrcsKgZ8BLK+3LO+SUhNtI/BmmlRHRH/Nzs8Rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047806;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=8LY5HEdHXw17N0QE1mMGIgtZqBP16j/rVfZss87pMqQ=;
	b=JRKcLVL4sO4HHhLfYPy48NHfAHgusLAZx0/B2Z3aTxhPxJ04QmHl3y3MLD+/UV2yo+Q7
	 epveVcijx/cOIN89lygBetwDCow+XXWyf5SQBoSMTapRUeq4iFsE94Qzn+0mviwdua6Ac
	 oAJDp4u24NkVrjsb7jfFcxerIdn8z11HYiaB2AuZFT/mvI4hVddTlX5r1mdjF+8KFQpz+
	 g2X+hGcqsSGqi+/AOHqWrTyfZ7ny9fQBe7EUTwYV0o9uCWQ4uESGz11CJMGN2u791Jv9H
	 oH9tWINtIypiYskdMWxr8xRqu3nHD75G+Sqi1xjdiEyDHJmou3jgs4uCsSR69DsvyAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="WWG/Z8xh";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F836606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WWG/Z8xh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE9291F0089F;
	Sat,  7 Nov 2026 10:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047806;
	bh=8LY5HEdHXw17N0QE1mMGIgtZqBP16j/rVfZss87pMqQ=;
	h=From:To:Cc:Subject:Date;
	b=WWG/Z8xhtGbKzY/rU6imzqFNpC9v8ZPZzI9k844idOzoZpC62g0z7MExRkQor9S5H
	 lIOfJBKy4oI2aGy7QXrHYCAx8TMdmLsnP9hPfJfiJJic1Jf32/zMYh3W28iUG0PSbc
	 27LrxOSRv5hX6ddaRB9cdonw0KbaWNnCVE4PNPPvD4dKsFP/otx/o4sWtIIrvSQPiW
	 kZ/OLvBxRlyWA1J9ovckFlA3iJ7oeHbCHliacX/ygWtX90GDa5hiwx2CdwXgJyqein
	 LtuaqurfCHR3gYZve9BjHZwgU089qvbvmJvdDZYTqRoAulIZmcFSuuL0r6xamnhOmv
	 +Emx3pHo7OKNg==
From: Sasha Levin <sashal@kernel.org>
To: gourry@gourry.net,
	alexandre.belloni@bootlin.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] rtc: cmos: Honor explicit use_acpi_alarm parameter value" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:36:44 -0500
Message-ID: <20261107053644-failed-6.6-3c7acb209e1d@kernel.org>
X-Mailer: git-send-email 2.53.0
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 3c7acb209e1d630b734a2ec72bd988f5da2ac55c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053644-failed-6.6-3c7acb209e1d@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 3c7acb209e1d630b734a2ec72bd988f5da2ac55c Mon Sep 17 00:00:00 2001
From: Gregory Price <gourry@gourry.net>
Date: Thu, 15 Oct 2026 13:30:29 -0400
Subject: [PATCH] rtc: cmos: Honor explicit use_acpi_alarm parameter value

An explicit rtc_cmos.use_acpi_alarm=0 command-line argument is ignored
on systems where use_acpi_alarm_quirks() enables ACPI RTC alarms. The
argument appears in /proc/cmdline, but the read-only parameter reports Y.

The boolean parameter defaults to false, so the driver cannot distinguish
an omitted argument from an explicit false value. Use a custom setter to
record whether parsing occurred and skip automatic selection when it did.
Preserve the bool parameter type metadata. Automatic selection remains
unchanged when the parameter is omitted.

On the affected system, the explicit false value reports N after this
change. The HPET-emulated path completed 100 test runs without a failure
while the ACPI RTC event counter remained at zero.

Fixes: 36d91a4d401c ("rtc: cmos: introduce quirks to enable use_acpi_alarm mode")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
Link: https://patch.msgid.link/20261015173029.3091872-3-gourry@gourry.net
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-cmos.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index fe514b1aa3433..209aa4ec732c8 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -57,7 +57,28 @@
  */
 
 static bool use_acpi_alarm;
-module_param(use_acpi_alarm, bool, 0444);
+static bool use_acpi_alarm_explicit;
+
+static int set_use_acpi_alarm(const char *val, const struct kernel_param *kp)
+{
+	int ret;
+
+	ret = param_set_bool(val, kp);
+	if (!ret)
+		use_acpi_alarm_explicit = true;
+
+	return ret;
+}
+
+static const struct kernel_param_ops use_acpi_alarm_ops = {
+	.flags = KERNEL_PARAM_OPS_FL_NOARG,
+	.set = set_use_acpi_alarm,
+	.get = param_get_bool,
+};
+
+param_check_bool(use_acpi_alarm, &use_acpi_alarm);
+module_param_cb(use_acpi_alarm, &use_acpi_alarm_ops, &use_acpi_alarm, 0444);
+__MODULE_PARM_TYPE(use_acpi_alarm, "bool");
 
 static inline int cmos_use_acpi_alarm(void)
 {
@@ -822,6 +843,9 @@ static void rtc_wake_off(struct device *dev)
 #ifdef CONFIG_X86
 static void use_acpi_alarm_quirks(void)
 {
+	if (use_acpi_alarm_explicit)
+		return;
+
 	if (acpi_gbl_FADT.flags & ACPI_FADT_FIXED_RTC)
 		return;
 
-- 
2.53.0




