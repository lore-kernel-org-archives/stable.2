Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794329234;
	b=oPjt6+SUfYJydyv/HgwA3v3FaCGS1RnB5x2aZ8iH46YFFgcsYKJjowpgaUKHLhH3fjFX
	 2x53Z1RBU3S7MEV+hKzsPaLNRCJks23+mWgchOTTEonfX/dWyOIbuTntcC7vDzkoQzTYB
	 YfuO/tdRQZ4+33YaBlfsOodtDUZQMd47wflQYZ1GNlMr5CN5Y3cdHLC3TteEyQ6HJVmwI
	 5J12/DxOuVkNEg5UM4hgbKnywrSI4LFtrZVMKHOXA/7RYm9suRym5Wjw9WjFF27UNy0Y8
	 ykULQTyq8A88ALYtA9kR4GKGl/FTJBaPmPJup0sBJKDPwDv2dehHb7+UjghwxucTrDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329234;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=xjx+fLo1XtyPFwdmUemV53VY5oMXYLOTPbp8sSnaLDE=;
	b=DMrDx3xUqDqCvRyNuo0pgnTgBtttKI0squtEb6lU1KMgDHLHrLjPr19mZ3FxO4Nl/UxR
	 u93QWzp2wf9sViJrqF3vlH+4mDcpmHuFqfv//sf1dLnOQgJGY3dNeXrPJJueAHdXdq8PM
	 ipZzGezq+kFz4Xnf5o8HGwnOiFO8oQudENNOtJNJRVDOtIqU+HLe2SWCaM47VnwstNj2g
	 xYET7UdDM5SMybmUyzF0IgMgFlEaw6Ou45G/pl54X9QFGKzGTnkzx31w8JYf5zWNQE0D+
	 2BYeMFhPz05VUvtV+P5wbTRcFg5bbpcQhP4RM0WY9anKibbkyFTis+XAhHBHZwJ9V7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a6BPcIkN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A69C606A32D
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 16:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a6BPcIkN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 105D51F0089F;
	Tue, 10 Nov 2026 16:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794329233;
	bh=xjx+fLo1XtyPFwdmUemV53VY5oMXYLOTPbp8sSnaLDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a6BPcIkNQrWa4T99YEW+lqBhvB0TKUaAlWva5aBQPdAlsDZAPTPOnYxXoic8Jrpmr
	 oPh90hO2O7gStp0tx8MDMcHZURwwuGoHL0wQXH6rxs/RBQI85bF/kgGS5pBoiLbII/
	 U4zuShuI5hmVg1hqrMn5ZrrjaZgKp97p4ZqDixDaPMNtQ1ImLnftJikQ2H7tekUhEI
	 vL858wgM61W0bzi2kCyXDiEAPGssxVV89ANldqQv5FeTXYBnFoFHpVninTo2IfueoA
	 FGTxR4MervKEBKRGXfQMCD1zxPgLDyh6D80VgIcrShgvuCn1sOgX3qkoXKzofW975Y
	 nVkZo53G1qbIw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Marco Scardovi <scardracs@disroot.org>,
	Denis Benato <denis.benato@linux.dev>,
	Armin Wolf <W_Armin@gmx.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] platform/x86: asus-wmi: Serialize WMI method evaluations with a mutex
Date: Tue, 10 Nov 2026 11:47:11 -0500
Message-ID: <20261110164642.2537372-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060506-failed-5.15-b9428edaf410@kernel.org>
References: <20261107060506-failed-5.15-b9428edaf410@kernel.org>
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
[ sashal: Replaced the guard(mutex)-based helper with explicit mutex_lock()/mutex_unlock() calls at the two existing evaluation sites. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/asus-wmi.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 7714a8327021f..09b9d4679b617 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -15,6 +15,7 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/slab.h>
@@ -249,6 +250,12 @@ struct asus_wmi {
 
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
@@ -263,8 +270,10 @@ static int asus_wmi_evaluate_method3(u32 method_id,
 	union acpi_object *obj;
 	u32 tmp = 0;
 
+	mutex_lock(&asus_wmi_eval_lock);
 	status = wmi_evaluate_method(ASUS_WMI_MGMT_GUID, 0, method_id,
 				     &input, &output);
+	mutex_unlock(&asus_wmi_eval_lock);
 
 	if (ACPI_FAILURE(status))
 		return -EIO;
@@ -2906,9 +2915,11 @@ static int show_call(struct seq_file *m, void *data)
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

