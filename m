Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327986;
	b=2PNWiF0HMqmi6S9k520eeB7hWyjPn6AEsoog+WtV3iVCIXdPCnB6fWlA4qzAClzVOTB7
	 7KntDoe6rHL/vowE/LlN8jwED9fRYvycVKs2esD+l9k6iQ3E6ifQGGDs/OtzS6bA/t0U+
	 OUVNHHvb3+iWqPCVivTTormSnHxRXciGY10dVj1HRGJb36qPhsgy4qLJe2pmzAN0LJv1j
	 VFDdJVsMJhfpEMzfNFonSojx50pcg9HGTVOZRv+/nlrHAzCRx7O46fBywxBtGHjmw79LM
	 XYP9cxM9nkXYfWNjY4Z4DbWeSpBLFFNJP0GTwnIDK8cY1/wZpOzKvj0eUkJcDA3FJhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327986;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ErRvENinNZpBxDiY5OGV/AHxWO3QrFvLrqAD7FVahkk=;
	b=C1aVXk51KN9Q+WUw6wDH1Xx2ixmOGKDO1yG3Apm7g7pcsSxa+CDDt9jCtJALwhnIYwzI
	 kV8f8rk1auryDWGJqQs1bb35BquUoTNO2SnB8jtpfIIv/FQFEmucy2dDzu8bLKmZCcZO2
	 PZn8H9pDJXATLqV0mYj6B05EnXEmUU9RQLF5bWq4+aR0XpRzT3Yahu3IbMbHIH7Zp9dvd
	 H88nlF8ZW4xcW9kfkKLy2GLzRoplzCilwdDLCZwFkGrA3eqbHoQpvLEgDTtLWGzkgobYq
	 rUEanKy3dt2zreKKM3u5xVON7JebkSbDPz8qIBf6B9VCfHBYUlsDfulScBPkHbEgjSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ia7bvp1w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53043606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 16:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ia7bvp1w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CDEE1F0089F;
	Tue, 10 Nov 2026 16:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794327986;
	bh=ErRvENinNZpBxDiY5OGV/AHxWO3QrFvLrqAD7FVahkk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ia7bvp1wy4ZH1BMc1JW/vFqwu4KvfgPGjgBT/MVCDqXr1YvAed90ZxmLLpnAqF8/v
	 HD2wWN1v5SgymH+7pC7xrZ1bMZTr31flIvUKPrJJj1plEWNozz79Akx1EqNSmXe7dT
	 v5935s15QkjnygVf7YFjJu97p14lK6vEmf72WlJtyATA98u78KO+pr5vHtIYnKWEAh
	 LTy5Jefk/HVPyLo8MKRctu86x+kOPtuWk6jqZ6hSqH0/OW7dMsyjh/3J1NJkRxoVMx
	 N/f57+wTfKz0EIQjJpYU0yT4fCY6y69PTMis0QF7Yf2ABci9kHo30MjMOHJpxqBK6F
	 uvNxIGUc9nTdQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Marco Scardovi <scardracs@disroot.org>,
	Denis Benato <denis.benato@linux.dev>,
	Armin Wolf <W_Armin@gmx.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] platform/x86: asus-wmi: Serialize WMI method evaluations with a mutex
Date: Tue, 10 Nov 2026 11:26:23 -0500
Message-ID: <20261110162422.2501304-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053411-failed-6.6-b9428edaf410@kernel.org>
References: <20261107053411-failed-6.6-b9428edaf410@kernel.org>
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
[ sashal: adjusted patch context for missing debug logging and different header includes ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/asus-wmi.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index a76d43ca647d4..d83d3f4a56aab 100644
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
 #include <linux/kernel.h>
 #include <linux/leds.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/pci.h>
 #include <linux/pci_hotplug.h>
 #include <linux/platform_data/x86/asus-wmi.h>
@@ -316,6 +318,20 @@ struct asus_wmi {
 
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
@@ -330,8 +346,7 @@ static int asus_wmi_evaluate_method3(u32 method_id,
 	union acpi_object *obj;
 	u32 tmp = 0;
 
-	status = wmi_evaluate_method(ASUS_WMI_MGMT_GUID, 0, method_id,
-				     &input, &output);
+	status = asus_wmi_evaluate_method_locked(method_id, &input, &output);
 
 	if (ACPI_FAILURE(status))
 		return -EIO;
@@ -373,8 +388,7 @@ static int asus_wmi_evaluate_method5(u32 method_id,
 	union acpi_object *obj;
 	u32 tmp = 0;
 
-	status = wmi_evaluate_method(ASUS_WMI_MGMT_GUID, 0, method_id,
-				     &input, &output);
+	status = asus_wmi_evaluate_method_locked(method_id, &input, &output);
 
 	if (ACPI_FAILURE(status))
 		return -EIO;
@@ -412,8 +426,7 @@ static int asus_wmi_evaluate_method_buf(u32 method_id,
 	union acpi_object *obj;
 	int err = 0;
 
-	status = wmi_evaluate_method(ASUS_WMI_MGMT_GUID, 0, method_id,
-				     &input, &output);
+	status = asus_wmi_evaluate_method_locked(method_id, &input, &output);
 
 	if (ACPI_FAILURE(status))
 		return -EIO;
@@ -4260,9 +4273,8 @@ static int show_call(struct seq_file *m, void *data)
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

