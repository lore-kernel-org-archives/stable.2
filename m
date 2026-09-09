Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F87045D916
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 22:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788994322; cv=none; b=KyHakpBPfWDOcpqJFPB3oKjv+u/O8YK6zGXsMpj+LfwY96d9c7qproxGKWytF7NMMV3cJmfIcSotKKVvNGC+QfUJAK6zv3gCKNNDFYlODEWt2AR97V1dcSwzKNbtsDvUz3wMaOUOCVw2F9Jx+PcODcD6nOcVHuqsmLxbl4A6LeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788994322; c=relaxed/simple;
	bh=aZ9zAg2uTuv7/FU+ETarYrAHc8sT3sPRPWW8umE51eE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tpzTOCCntlWx0KFKzSWPT6i5kZ7UB1+2qs+yhtVExnHseIoUvbPPO5lj8Ckc7ycoMavLA6hGHzOHXFucaRGRE4s0+jyFJOaj9xhZ9LEfVRjOtDScN7UJ4RCVt38l7f975KhXGHP0W7VVVR6ZGGvbS0cUpgKkXQsFyKwmg5dmY3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=uqy8A0Db; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="uqy8A0Db"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-910707254efso14958526d6.3
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 15:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1788994314; x=1789599114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l2wLUzaidHv+rgjS9Vme7RZj9pjhzoFdoBFIa4TcM6o=;
        b=uqy8A0DbftwZBrWJiYGzrATABjjiIKlS6aSJD9aiT6NbesX+TXF8ZujUA8vpxNqPio
         kMyg7Yr1NjXJNAIgYl+6aq0Zz0GtX28fdYt0hTpNnBekb7scQyXYMdrfEmWUd5nmbSpt
         9kO2oR1F+L9522L+zOMwWrVBM4QFbYehSXuLXGPu5gZhlCzUwjzrIj69j66hhvtHXAF9
         a+JZtcCPv639D6YMDqwjAK556wd+/f0l0nR//J8Q/QeLJrxnFj8urFuGRqJaZQoVW2T7
         B5J5Ra3RcIgcbAGoJwZ6UoyJU+H5cbFDIllh8JGhU/bPjf3JWqwoVVl3P6A3bGNydXRT
         VM5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788994314; x=1789599114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=l2wLUzaidHv+rgjS9Vme7RZj9pjhzoFdoBFIa4TcM6o=;
        b=g/xIbb+B39YbsTT/fspTWSzhiunRh/lRxHNyk5UtWj+Uw8vOTWkDxs+KFTGEmj9xNK
         OJLisqtfw8RgYg6d04/WB1X7mP49siT2QQ9O68zlMN/wVCIXgjiHvbZ3geNGxKK48g9Q
         C0zseX0cYWkm+jjA+YniSUzkeX7Pzb4FcDDqmpwjpgHLN8plGskIPwbdOIcx/EzPuXPD
         pmZTcCwa5/AlbHBtxzdDyINzXS7HmUJXf+9lNY8aQmQMa9g/Y4y+VKSoJp+aaUI3s7Fs
         LAVMm0jJQm1oWut6GP7OEA+XrrKDN2z5zIb7sohdTE9IHOWuIABVWH8EMiuQtcoJX/Rp
         oXpQ==
X-Forwarded-Encrypted: i=1; AKwUvBz9cIpIyByLN66XtUW8B4RskGDbVbIOEQz2vXLjjfsE516XzSdUGgLfbM9hwAfa5q0jML6dDAY=@vger.kernel.org
X-Gm-Message-State: AFuF++mC9d/9sufP+TlhDOXECxjpQlzEHf4UAnM0UVhJ0yqZyo1akWQo
	mP+JjXa1QrDurFxQCrLnXAgdd4cWMngpjiuHSI3aszxcODTG+k5MZ2dzHBhgLXMf1NE=
X-Gm-Gg: AYBFou2h9ptNh93al0lj/MvGfwJtD8m6bd23lBFoI87qKbhZbFpdaisOh913GYv2+tp
	cORVBlHrI6Eej5o2MPnDju0mExfzisX88sAwSb8NDDQ7hv1/J/j4Kja7Lb3YWkTYX5H5AIuEo7U
	AZKbMyCTGFBwKTvO5YbFHY+GfhQ8hBBD9GGvO9vceIKYFRmGimmd+hb4F0vM8KYJROoOsxOld/Q
	hYgkFSn+3jjr+4GjUkKEEDf2FbxaY0izqubhmlybFai4zHOt6IytYr9IJI8/Koq0V6ZpOdM9lbd
	vHjESNZsX2cZl86Z1xHjaLlu78Gk/D69AdqIKgVRe8k/DrWbr++K0qJhBiNXLZvMWxtZ9YvBJZ9
	XMzswrmDE8vG+NiJzSUqcx/eQA2niw4SKT+GSrzle9tcoOCPhpUrbdRwGo+d/JrKinWJycE+vcS
	nM6a3qNWDxiCI9UnlgGc7wXDYOuW0W0CT8jOxKOxfB+wXUc4Ny0C0UAuhl8ZuDKZB3m3H6HFVWT
	WsL7erkWP807U+t0epBWaKU9TiCcG1KIYn3lBsyxIOeqbBRuS2glcJIVsgM
X-Received: by 2002:a05:6214:daa:b0:910:4b24:a936 with SMTP id 6a1803df08f44-9104b24aa14mr352805826d6.6.1788994313808;
        Wed, 09 Sep 2026 15:51:53 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9106412e038sm59976696d6.20.2026.09.09.15.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 15:51:52 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	alexandre.belloni@bootlin.com,
	rui.zhang@intel.com,
	stable@vger.kernel.org,
	"Gregory Price (Meta)" <gourry@gourry.net>
Subject: [PATCH 2/2] rtc: cmos: Honor explicit use_acpi_alarm parameter value
Date: Wed,  9 Sep 2026 18:51:32 -0400
Message-ID: <20260909225132.1392883-3-gourry@gourry.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909225132.1392883-1-gourry@gourry.net>
References: <20260909225132.1392883-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Assisted-by: LLM
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 drivers/rtc/rtc-cmos.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index 462799667aa18..536bdcb79ea1c 100644
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
2.53.0-Meta

