Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794329714;
	b=bQ45Qa0wk2Y8thZTS87qHG91Wc0QCg0b1W9RvbylyYWIicP8XJeWH7RBfNeV3Pd1zzjo
	 b2AY0VigBg7EVivxXxOYjUxD1Q1NT4C6rDHexXcHvQ0Jh7W1jOhEvhoOiWwvFnf5k36ra
	 zdWa2pmrb8IU5uPXHGN+LdDtFTS7RXqKGI3T1vAiCVKfCUqwAt9bdJqGpFcgBcQyISX2o
	 TFpbs93vqtaT6gT4cLgKpWAn4t9TEy3oCR1x5za85WCrQUkMRtHTGEvTOMkWylKwxezul
	 o3jVn9JPkuIOh5lpXxSE7Bkol/QWZPJJHjx/womQGBWN1iFugMxlt15q1EfCEwEsJ7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329714;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=z1HQZ/FoTJmCxr6FCSgk274gFHrW27eRMMvJoWuY/u8=;
	b=AvqAvIOl8+8i/1DJG8j0CZqjTDNY5yg5iYoeAm+O+ARVIW/OGQIz1gRSiVinDa2lCzFP
	 tSh7cBR5thO3kwNaMGacDvgiHnZTEC/yY5pr9nCrWV4+WnDHA0KtXo6Vnnl7Jqiievc4K
	 /0bC6TMIZ0rEibckuBQBnkq1B0hAHxCMxDOw2JO+xGDCeRY9Jgh+FRaMGYIw+MFy9ww2J
	 ykrv3LiMCaraBEyZZ4o9eUeZ0JI2OijsZwsn5Ub9sixgiD55d9CecO9ygD0crEILTKvPM
	 rnPp/1s4bmRLQUQM9ZS4B3SGxyjTp2hxmFBTRX4t+XWMBWDZQ657xV8dTUbc5vkIW/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="m/ByGogr";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC31660A6F5B
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 16:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m/ByGogr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B98491F008A1;
	Tue, 10 Nov 2026 16:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794329713;
	bh=z1HQZ/FoTJmCxr6FCSgk274gFHrW27eRMMvJoWuY/u8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m/ByGogrK35Qwa/z5xSMPfhTSTbWqVSIiNEWPcQb9KidtYWqalkgPHYnnfoFi0Rl+
	 Z8yn509BuTGAMGUjXUP+hTLoSgiORpyNWbnjL+geQFfweuiWRTdIbksoOBsHWezthC
	 Xk696RQFkyaRCoDVrlbgiybObh0UigYmzWxClq2Q0XLPWNioMVt5szKDTHp9r5nHEA
	 1ZD+yPjY5UqPtyTp1xz5/D8KzNAFr7ULx+XM7PUgZy5Mwx33Pi0+0Wh8j/DftycL/v
	 VP0FFitciBeEHlokzidlhsiMC10fylYv2/ez5e7IiTgNoM0yoA3r8/r3nBpot7cgSm
	 PrZGsvzRgxpxg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Marco Scardovi <scardracs@disroot.org>,
	Denis Benato <denis.benato@linux.dev>,
	Armin Wolf <W_Armin@gmx.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] platform/x86: asus-wmi: Serialize WMI method evaluations with a mutex
Date: Tue, 10 Nov 2026 11:55:11 -0500
Message-ID: <20261110165447.2611303-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062150-failed-5.10-b9428edaf410@kernel.org>
References: <20261107062150-failed-5.10-b9428edaf410@kernel.org>
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
[ sashal: replaced the guard(mutex) wrapper with explicit mutex_lock() and mutex_unlock() calls at existing call sites ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/asus-wmi.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 4f56f853b756b..9256d6edca5b4 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -15,6 +15,7 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/slab.h>
@@ -236,6 +237,12 @@ struct asus_wmi {
 
 /* WMI ************************************************************************/
 
+/*
+ * Concurrent evaluations of ASUS WMI methods can re-enter firmware
+ * SMI/EC mailbox handling and corrupt the mailbox.
+ */
+static DEFINE_MUTEX(asus_wmi_eval_lock);
+
 static int asus_wmi_evaluate_method3(u32 method_id,
 		u32 arg0, u32 arg1, u32 arg2, u32 *retval)
 {
@@ -250,8 +257,10 @@ static int asus_wmi_evaluate_method3(u32 method_id,
 	union acpi_object *obj;
 	u32 tmp = 0;
 
+	mutex_lock(&asus_wmi_eval_lock);
 	status = wmi_evaluate_method(ASUS_WMI_MGMT_GUID, 0, method_id,
 				     &input, &output);
+	mutex_unlock(&asus_wmi_eval_lock);
 
 	if (ACPI_FAILURE(status))
 		return -EIO;
@@ -2605,9 +2614,11 @@ static int show_call(struct seq_file *m, void *data)
 	union acpi_object *obj;
 	acpi_status status;
 
+	mutex_lock(&asus_wmi_eval_lock);
 	status = wmi_evaluate_method(ASUS_WMI_MGMT_GUID,
 				     0, asus->debug.method_id,
 				     &input, &output);
+	mutex_unlock(&asus_wmi_eval_lock);
 
 	if (ACPI_FAILURE(status))
 		return -EIO;
-- 
2.53.0

