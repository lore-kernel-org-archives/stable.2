Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048679;
	b=JH8xAHDJc5wRjvOgGYda7x5JS2NsvJIwRKu2Dnn9ojqTEeImlNV4CcCedGqRFRH2Yrq0
	 b1Cb6aCuSsb5EwqAGnFDFLdUh6OhiY3OS9p8R8d5EGmkiTDlqF2FbKe9NI/GjeSXGyONQ
	 iukuOcSvAj68Ogoou5+cLpAUeYy14nh2ubzXqRxOdKijPRwlKH7PjkgGQtuFjJG/BMsyZ
	 2F/UGl281II3uHwrFklHefVvdgdwgEhJO4pt5iiUG4lzJGakOSoKkNNzRFmJJavbHM4An
	 0jWsUqimZfWzinXDGl/xOKQsgu0IqkyiXckctZMqe54qQjmQgSDeZQGXVMG6J/pYU+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048679;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=HvUIy5FtKLJa6z2rjb81QueTei37RzVc2gFdrLfn+LU=;
	b=bMsKQwTHrg93t4DLSkU90YqS8/LLaj7rX20YtKJbpnqVwEOnBauU/gGyhvykPHeZcb6s
	 1KYvU+60BFOpbRKa3tNIgpChuWSR2ZWlpiZA0RUJwEqwvZhRWKBnHFf7s/Ua4jlVhG2kH
	 MHoR/8fIMyDy6xpMcVf1W6E31DMyxMrbm9bKIzQv23FepSNlqZO8XgbISF5wfZda/Q6GJ
	 bK1lqOJPYid8OinoBgXGrcpVGilioA1DiqiSNkVipawokdboq2kRV0WguhkHU86UJt8d0
	 rXDI2W/CRmAfJ6wHNaUHJPuasdGL9wQJF+ZdVCR9HriGDW//lAJuWph9pPQgoOlcBqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C9L18my7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF89606EEA0
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C9L18my7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1009C1F0089F;
	Sat,  7 Nov 2026 10:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048679;
	bh=HvUIy5FtKLJa6z2rjb81QueTei37RzVc2gFdrLfn+LU=;
	h=From:To:Cc:Subject:Date;
	b=C9L18my7UuFneIknK158KwHVjFtqCNqZTG8kRRnV739pK9Jg2r7uSJpiz5URtVcVl
	 atvMXzTSyS9l+LnhQ95doZyszbp7XIEK9IM2LCNzaOSubD57nC8kE2omGB0kvITAmC
	 Qx0slktrhcfwm7RiaWXkyoqXWO4eeZyN9ub2ZLbFJEE2YAb3zAQMP63V8hZ2gnErLD
	 n22wigZKpfRu48Vlr5FCWHm7oSES1/KHVsBkNFlf8gZOMbzhnaMLtEJdyv+tVVGmMW
	 FQlzpztJwe2Yuhz+pGpZhvf/9/1aCBqMStbEhlI9bSaFzEhIe8lCSeHKoPywAuIEJL
	 EznC/ZaPaSHpQ==
From: Sasha Levin <sashal@kernel.org>
To: gourry@gourry.net,
	alexandre.belloni@bootlin.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] rtc: cmos: Honor explicit use_acpi_alarm parameter value" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:51:17 -0500
Message-ID: <20261107055117-failed-6.1-3c7acb209e1d@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 3c7acb209e1d630b734a2ec72bd988f5da2ac55c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055117-failed-6.1-3c7acb209e1d@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




