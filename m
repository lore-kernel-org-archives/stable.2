Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794328223;
	b=NENKH2y0IYtvL6JyRuOyxR0hnpbpNxLxkv8aMc/kIsAYv/PvgrIXmVyIn5iXI55rVgC1
	 X4BQo02iOx2fG+bV8nR3rJ8ddG4RxS0kYIB81+Vi4u65UXL1WAHFHYf/zplLtmxwdFUdr
	 u4ANrvE2ysqqQM2ekIbw1ugQWro4y1jqS/zvZHIUiRQ34Euu/TDOXQKxZvf/T3tsZ4DGT
	 gsqZjWUghp2bJM39mAH3sLnLzRdxyxIHhjYPYKMAvtrMEtdx10S6FNBgtXbkaI+GLID2O
	 S9CdG4h8kb8QMsQcCow3a85/mLzcMc6f71g2jHUwAinPo7KBTavnHjvrmSoVWs4NiKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328223;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=/eduJXkppkmH8yKYi1DMimzisp+huoe1ACMmT/3W+Ak=;
	b=Bg4XVY6YhAQUaWP3ubkd+akpJlqDLt2n3n7WPlZs09wQ5/8U5OPPlCTmRGkiCylqYIyO
	 vFfEIoI05MRJydrvPIEaIzf1QGCMRvnBX/X5+E2GCSoZTMQS37FpHCpc1bVowyJWuj9fb
	 U6aUViPkt6QhHRdPQvIu1qN7Gz2jNW/u+69GERZl9DLi0OFJk1AfhR3AJQjzjZSYNvLhS
	 SAYsBeOQ+g0t6EKTRqcew9hqRRQqIt0H6jl4TL0mZ65/4UzXocvN/H7uAPRHImKCUAJQr
	 YgAFVET3w5jGQMfb5zWEf82kuwB4xD7WkgmRozreDQXyuKdhsJA8lpqNV7+APP7YeTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="PBGOUhU/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144E5606A33E
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 16:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PBGOUhU/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01B081F008A6;
	Tue, 10 Nov 2026 16:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794328222;
	bh=/eduJXkppkmH8yKYi1DMimzisp+huoe1ACMmT/3W+Ak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PBGOUhU/N3GWijBeZ2LJjwRFULh1m5KM/sD13MsxGUbHAhCF9X+4sdjB1mr3+MZXB
	 waFA/9Ij8amKwYO9CvyTCpFbPhADO9bpL90a5p7f2i+b2Pixbu7WEREpGNsSyavejm
	 IPTW21ZwcCl82lgrestHPnUxm7ChSMqhkgrzUjdRQQObzLnmD8lSpPV8zDRbsmWFa+
	 YFFzZ5mZN3AFIZzAnlyuEtrlBKw0ucujeo3TDSX5Dqd1ZYXTfpozzXH/VS8/oDJUxp
	 KlqWm3YFEtZ+xI9+GlAO0Y9qj0NbM63ryWozynIMaDg+RWkOtv+sIy7//6kpDnUNJt
	 fs46oSOfEcpEw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Marco Scardovi <scardracs@disroot.org>,
	Denis Benato <denis.benato@linux.dev>,
	Armin Wolf <W_Armin@gmx.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] platform/x86: asus-wmi: Serialize WMI method evaluations with a mutex
Date: Tue, 10 Nov 2026 11:30:20 -0500
Message-ID: <20261110162954.2515007-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054741-failed-6.1-b9428edaf410@kernel.org>
References: <20261107054741-failed-6.1-b9428edaf410@kernel.org>
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

From: Marco Scardovi <scardracs@disroot.org>

[ Upstream commit b9428edaf4109e86a97254228d831767d0acc1f8 ]

Concurrent evaluations of ASUS WMI management methods (from ACPI notify,
HID, userspace daemons, and debugfs) enter the BIOS ACPI/SMM interface
simultaneously, triggering re-entrant SMIs or EC mailbox buffer corruption.

Fix this at the root by introducing a centralized evaluation helper
(asus_wmi_evaluate_method_locked()) protected by a global mutex
(asus_wmi_eval_lock) using guard(mutex). Route all evaluations of
ASUS_WMI_MGMT_GUID (method3, method5, method_buf, and show_call) through
this helper.

A static mutex is required because asus_wmi_evaluate_method() is an
exported symbol used by external modules (such as hid-asus and
asus-armoury) that lack access to struct asus_wmi drvdata, and the
underlying ASUS ACPI/EC management method is a single physical platform
resource.

The mutex is non-recursive: nested ACPI/WMI notify handlers must not call
back into evaluate on the same task (defer via workqueue, as
asus_rfkill_notify already does).

The sysfs-versus-notify race predates the later export of
asus_wmi_evaluate_method(), so Fixes points at the original shared
evaluate helper rather than that export.

Link: https://github.com/OpenGamingCollective/asusctl/issues/328
Fixes: d33da3b68669 ("asus-wmi: factorise wmi_evaluate_method call")
Cc: stable@vger.kernel.org
Signed-off-by: Marco Scardovi <scardracs@disroot.org>
Reviewed-by: Denis Benato <denis.benato@linux.dev>
Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Link: https://patch.msgid.link/b6a1981777e63f0c28bd719d8203ebbda57d6957.1789722252.git.scardracs@disroot.org
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
[ sashal: adjusted context for differing includes and WMI evaluation helpers without debug logging ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/asus-wmi.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 8814b258caa55..e1ea260046c3c 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -15,6 +15,7 @@
 
 #include <linux/acpi.h>
 #include <linux/backlight.h>
+#include <linux/cleanup.h>
 #include <linux/debugfs.h>
 #include <linux/dmi.h>
 #include <linux/fb.h>
@@ -26,6 +27,7 @@
 #include <linux/kernel.h>
 #include <linux/leds.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/pci.h>
 #include <linux/pci_hotplug.h>
 #include <linux/platform_data/x86/asus-wmi.h>
@@ -274,6 +276,20 @@ struct asus_wmi {
 
 /* WMI ************************************************************************/
 
+/*
+ * Concurrent evaluations of ASUS WMI methods can re-enter firmware
+ * SMI/EC mailbox handling and corrupt the mailbox.
+ */
+static DEFINE_MUTEX(asus_wmi_eval_lock);
+
+static acpi_status asus_wmi_evaluate_method_locked(u32 method_id,
+						   struct acpi_buffer *input,
+						   struct acpi_buffer *output)
+{
+	guard(mutex)(&asus_wmi_eval_lock);
+	return wmi_evaluate_method(ASUS_WMI_MGMT_GUID, 0, method_id, input, output);
+}
+
 static int asus_wmi_evaluate_method3(u32 method_id,
 		u32 arg0, u32 arg1, u32 arg2, u32 *retval)
 {
@@ -288,8 +304,7 @@ static int asus_wmi_evaluate_method3(u32 method_id,
 	union acpi_object *obj;
 	u32 tmp = 0;
 
-	status = wmi_evaluate_method(ASUS_WMI_MGMT_GUID, 0, method_id,
-				     &input, &output);
+	status = asus_wmi_evaluate_method_locked(method_id, &input, &output);
 
 	if (ACPI_FAILURE(status))
 		return -EIO;
@@ -331,8 +346,7 @@ static int asus_wmi_evaluate_method5(u32 method_id,
 	union acpi_object *obj;
 	u32 tmp = 0;
 
-	status = wmi_evaluate_method(ASUS_WMI_MGMT_GUID, 0, method_id,
-				     &input, &output);
+	status = asus_wmi_evaluate_method_locked(method_id, &input, &output);
 
 	if (ACPI_FAILURE(status))
 		return -EIO;
@@ -370,8 +384,7 @@ static int asus_wmi_evaluate_method_buf(u32 method_id,
 	union acpi_object *obj;
 	int err = 0;
 
-	status = wmi_evaluate_method(ASUS_WMI_MGMT_GUID, 0, method_id,
-				     &input, &output);
+	status = asus_wmi_evaluate_method_locked(method_id, &input, &output);
 
 	if (ACPI_FAILURE(status))
 		return -EIO;
@@ -3660,9 +3673,8 @@ static int show_call(struct seq_file *m, void *data)
 	union acpi_object *obj;
 	acpi_status status;
 
-	status = wmi_evaluate_method(ASUS_WMI_MGMT_GUID,
-				     0, asus->debug.method_id,
-				     &input, &output);
+	status = asus_wmi_evaluate_method_locked(asus->debug.method_id,
+						 &input, &output);
 
 	if (ACPI_FAILURE(status))
 		return -EIO;
-- 
2.53.0

