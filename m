Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327567;
	b=x7YJ9ecBRIU6FO5j3PqIN4yR+8N7rk4qYNQ52+JP7068F83ShFjjNHizdO1gItxh2mwN
	 8E24BAkme81nE1ikwl+vnJ7S/QXKs1pcxBT8X447aQD5o+UvJuQfzrBiET2vsHsMTljdl
	 +PT1B8rWkbdMqIVrVTS91ph5iy+JRbY6wtk2NUaNW2jMgqWEXSWbD/d8UpW+tXQFTH+R0
	 jdW3vu89W7NWqoB+GkfPe2tdwCS4wEPpIlEx9cwrM5hTVgqeAuzn1oiC29xab2AgrCNs0
	 vJfGNleBgQvAoRkbIEyqpWAInY2b4WAhkz5miPQkJGIvrQZz5KUZTIHflofPss3FESQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327567;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=PHaev0CtvsnJlVqxA20KMtwHs6gVXqxQ66OOsPQxT7s=;
	b=4SJ0UaYa4uQUIEdhJjBq2g4d+kZSXi9EUm7/5KM7W0EHlIZuX3hZody23lRybMreb6m/
	 TFenS4PkBbDj7+W+nfcaByG5+WDpo1Hogi7VZAhTSS96DAKodqJ/7tTIHls3Dmvh9MXSM
	 NcxKhUl3P3uC1luz8v7l064u1MjxmItxGjKM5Px6ShV6uSbkVYBxmsd24/e2st12Ouy8u
	 o73jC+f8X6O0d+iahr28ujaRVOMfagXaqcW9hxgTyS++IXkNaum+RnWH4JUQZmNoMLDxg
	 LmIa669N7wEbcoVozxxgEn2yRKsXBy/TONH1moAIwJy2w+z9S/iZmywIooQ2aO2UpzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JsqDTlSj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAAD60A260D
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 16:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JsqDTlSj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB9C1F008A5;
	Tue, 10 Nov 2026 16:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794327566;
	bh=PHaev0CtvsnJlVqxA20KMtwHs6gVXqxQ66OOsPQxT7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JsqDTlSjUNwWL9XbckuhIjYfDVDltNGjkoayOVlTJs/zi/mCnuPspEFTJt7wZRmna
	 VBd8+e6cI1oesJQ1d2RRJvpRIRkSh20OW3+mS586QYGhey3hnn7YhXlTqLp3AWHXQA
	 uOWuAefDCNUb3xzGjeMBJBpeaGMieIDq8go0sV5ZA819bPPFg+UWC6EVBpVZ4F8rIU
	 jhPh+2N//IZOfrSGet+7glsL1mN5fiCbi5yNvDpV2xcE9fZ6NbIRnEQ0aoStZ2W0QS
	 5z0rxVrflgvpergwmhUWvB0bCxKj7uawdTD7MpG8XdoQQjNfBnASbw5X8uA+gQ0+vv
	 yRc8Z2eNDKOOw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Marco Scardovi <scardracs@disroot.org>,
	Denis Benato <denis.benato@linux.dev>,
	Armin Wolf <W_Armin@gmx.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] platform/x86: asus-wmi: Serialize WMI method evaluations with a mutex
Date: Tue, 10 Nov 2026 11:19:24 -0500
Message-ID: <20261110161904.2486240-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052145-failed-6.12-b9428edaf410@kernel.org>
References: <20261107052145-failed-6.12-b9428edaf410@kernel.org>
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
[ sashal: adjusted patch context to match the existing include list and WMI section ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/asus-wmi.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 1465057b3e3d3..e71d2be12e78e 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -15,6 +15,7 @@
 
 #include <linux/acpi.h>
 #include <linux/backlight.h>
+#include <linux/cleanup.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/dmi.h>
@@ -27,6 +28,7 @@
 #include <linux/leds.h>
 #include <linux/minmax.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/pci.h>
 #include <linux/pci_hotplug.h>
 #include <linux/platform_data/x86/asus-wmi.h>
@@ -337,6 +339,20 @@ struct asus_wmi {
 
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
@@ -351,8 +367,7 @@ static int asus_wmi_evaluate_method3(u32 method_id,
 	union acpi_object *obj;
 	u32 tmp = 0;
 
-	status = wmi_evaluate_method(ASUS_WMI_MGMT_GUID, 0, method_id,
-				     &input, &output);
+	status = asus_wmi_evaluate_method_locked(method_id, &input, &output);
 
 	pr_debug("%s called (0x%08x) with args: 0x%08x, 0x%08x, 0x%08x\n",
 		__func__, method_id, arg0, arg1, arg2);
@@ -403,8 +418,7 @@ static int asus_wmi_evaluate_method5(u32 method_id,
 	union acpi_object *obj;
 	u32 tmp = 0;
 
-	status = wmi_evaluate_method(ASUS_WMI_MGMT_GUID, 0, method_id,
-				     &input, &output);
+	status = asus_wmi_evaluate_method_locked(method_id, &input, &output);
 
 	pr_debug("%s called (0x%08x) with args: 0x%08x, 0x%08x, 0x%08x, 0x%08x, 0x%08x\n",
 		__func__, method_id, arg0, arg1, arg2, arg3, arg4);
@@ -451,8 +465,7 @@ static int asus_wmi_evaluate_method_buf(u32 method_id,
 	union acpi_object *obj;
 	int err = 0;
 
-	status = wmi_evaluate_method(ASUS_WMI_MGMT_GUID, 0, method_id,
-				     &input, &output);
+	status = asus_wmi_evaluate_method_locked(method_id, &input, &output);
 
 	pr_debug("%s called (0x%08x) with args: 0x%08x, 0x%08x\n",
 		__func__, method_id, arg0, arg1);
@@ -4632,9 +4645,8 @@ static int show_call(struct seq_file *m, void *data)
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

