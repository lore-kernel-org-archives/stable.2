Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050512;
	b=z0D/VA/Xo9lziVECkOCtAb4yGuwxV2kW4ONkh1qycE9wecLV2dyXNwOiuahDrtH3jhAG
	 w99Lr9ZEojkUsRh4F0HMluxSvlc+tii53zHf75Qwljb5kNFYJXNOOxsHr9Z/XBxeomNGt
	 v2BUnszH0WWaMB3hZt/Zj40kRhao6CDa+J8I60oPIGlCQZoUdz9uUfjnFR94y+g9RRXeQ
	 V5+Up+GWeO40TYI/IYyYnhr7mRCFrEOc/9RXgS1twAcAyV/nCOiWgwVF8Kws/TAjXz2zf
	 1VhtdwqwnbetM0coaXDLevrFCAGKUFoBp/hgBWvCX8fn1WH1vIViSKjA0dKFbiWIYhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050512;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Hxbu/KlBlku7h83a+mKDGhPOJmbyb3pVPfikCE2CMZU=;
	b=I3nhU8LUGqScM1DTv15zKpnLCKZlt6tthbuU8droDt4ErQynG881TNcjh3MS6s78nKTy
	 zNpMXzvMc9yoMLDugLxN0twDAcHwel97W1aOOKwJulu35bh/W4+5ODYvNXNpw19FyNk/3
	 LZyW/QM21bwUqmSEyaswopIhXE1MFyF/nM6GT3njATt0EHOw13YDtP60lK6yyxTzFgLsu
	 WAtRYx2UWir70LN1Kq2hpWubvdF9B75HlWwxZPWu5Mg2nz7MjRrIBq4vMbzSWJ+NiIMzs
	 K0Pltkc9Z0nYP1IXW7jUCJXlyBYAG5GCZjzZLs62tis3DPj9U73cjxaEqpJk3+apqvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aEbBD8sM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B932606A32D
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aEbBD8sM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 619991F0089F;
	Sat,  7 Nov 2026 11:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050512;
	bh=Hxbu/KlBlku7h83a+mKDGhPOJmbyb3pVPfikCE2CMZU=;
	h=From:To:Cc:Subject:Date;
	b=aEbBD8sMGzqMQur4mhYpU1bBbk5IrLi0uElxU29sTNf6UIri/s/puFBV4EjQFskEU
	 ktwW16ySxqGiBV4M9JFZQ8ZrBN9OpTTayZNKyInjmy7cpHdnf4QBx9qKoi1j+h60jz
	 7zFSL8PNqOOzpMavB9i/kR0vGvDdH/TuHIkGarX3oGuoQLxx1pW6PzL1eQIaV9ZY0b
	 SYkx342ogkHkbEIiUV/mailEGVw66dV1+u0P5qffog1qg7hB4OR7Wo7MLYq8YwqlDy
	 qIz607ekx7SfTfof3eGH3zv/DHo6iZaqJRsgvmltOOySS+19ZaXbE4jllk02IZUnoV
	 x911D+0lzvdJA==
From: Sasha Levin <sashal@kernel.org>
To: scardracs@disroot.org,
	denis.benato@linux.dev,
	w_armin@gmx.de,
	ilpo.jarvinen@linux.intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] platform/x86: asus-wmi: Serialize WMI method evaluations with a mutex" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:21:50 -0500
Message-ID: <20261107062150-failed-5.10-b9428edaf410@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x b9428edaf4109e86a97254228d831767d0acc1f8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062150-failed-5.10-b9428edaf410@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From b9428edaf4109e86a97254228d831767d0acc1f8 Mon Sep 17 00:00:00 2001
From: Marco Scardovi <scardracs@disroot.org>
Date: Fri, 18 Sep 2026 11:14:59 +0200
Subject: [PATCH] platform/x86: asus-wmi: Serialize WMI method evaluations with
 a mutex
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
---
 drivers/platform/x86/asus-wmi.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index a2e552b207fba..60fbe13e100fe 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -16,6 +16,7 @@
 #include <linux/acpi.h>
 #include <linux/backlight.h>
 #include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/dmi.h>
@@ -28,6 +29,7 @@
 #include <linux/leds.h>
 #include <linux/minmax.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/pci.h>
 #include <linux/pci_hotplug.h>
 #include <linux/platform_data/x86/asus-wmi.h>
@@ -353,6 +355,20 @@ static void asus_wmi_show_deprecated(void)
 
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
@@ -367,8 +383,7 @@ static int asus_wmi_evaluate_method3(u32 method_id,
 	union acpi_object *obj;
 	u32 tmp = 0;
 
-	status = wmi_evaluate_method(ASUS_WMI_MGMT_GUID, 0, method_id,
-				     &input, &output);
+	status = asus_wmi_evaluate_method_locked(method_id, &input, &output);
 
 	pr_debug("%s called (0x%08x) with args: 0x%08x, 0x%08x, 0x%08x\n",
 		__func__, method_id, arg0, arg1, arg2);
@@ -419,8 +434,7 @@ static int asus_wmi_evaluate_method5(u32 method_id,
 	union acpi_object *obj;
 	u32 tmp = 0;
 
-	status = wmi_evaluate_method(ASUS_WMI_MGMT_GUID, 0, method_id,
-				     &input, &output);
+	status = asus_wmi_evaluate_method_locked(method_id, &input, &output);
 
 	pr_debug("%s called (0x%08x) with args: 0x%08x, 0x%08x, 0x%08x, 0x%08x, 0x%08x\n",
 		__func__, method_id, arg0, arg1, arg2, arg3, arg4);
@@ -467,8 +481,7 @@ static int asus_wmi_evaluate_method_buf(u32 method_id,
 	union acpi_object *obj;
 	int err = 0;
 
-	status = wmi_evaluate_method(ASUS_WMI_MGMT_GUID, 0, method_id,
-				     &input, &output);
+	status = asus_wmi_evaluate_method_locked(method_id, &input, &output);
 
 	pr_debug("%s called (0x%08x) with args: 0x%08x, 0x%08x\n",
 		__func__, method_id, arg0, arg1);
@@ -5092,9 +5105,8 @@ static int show_call(struct seq_file *m, void *data)
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




