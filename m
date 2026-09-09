Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C7B339365
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 15:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788966761; cv=none; b=LyzpfW6lxAqTaRv8Kyz7v5J/uGkECPgrQVj/XwA08X0yt2wiWM0/+CGHS69Ek0TIg6JSSjSCdv0RXPROxdVaL2P5MrQSGbUX4hmfm9yDQekvU8TkcGfmPGSJA8qOSTKkP192LDZkcSLEVPD0mNNlUQaswRzRgIopbbZ85sWJuRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788966761; c=relaxed/simple;
	bh=OcYZ4yafQFBlHmjnQII9/yvOGWiAine+/8qd6ETd6Co=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E4fglFcUoNt3NVHumlsyBbZTK2PDiiI23nsDaKhj+YSgQ9J7WHHSnLzfzD4MQNGFnO6NzzZd7mgiAbgDpN3Uc3jNVjZbMwfdpecSyKAwscNTPhb519i0XZqoQaIYQy5barG7oS4lv48NTFZJ8UOPzaZJbL+SjQVbKbNGZFSOHvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WT8ogjsh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WT8ogjsh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D18A61F00A3A;
	Wed,  9 Sep 2026 15:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788966759;
	bh=xnBMGQFKOC/2K6IhXRnL1SXA3Th1TOHz+CBYnUc4YCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WT8ogjshFEUynROZaHsoe3kVrZ3ZNcBRX7Z63iamv2sGm6PRbsahvahf2OOEtVFEY
	 T20p6EkhejoM3Ez7LQjhLE9zcIOgGAEr1JgdZkVwfmlIjRxrXx3X1bgn5yBqVGhewp
	 YKI/P6O5rQaPaFcGsbUh+2egyFyxjKY+m++6eGR9sM2brRnt6xwpPTKBMS3bYwGXn0
	 Uv4sewYpRGWH6f6I57MksNGexCU9rzH2XPHMqGTt2Q+qRPR6yHv5lFDD6y/cfhlXkD
	 i5V+zHHnM0/VMYKr7V28EKYNKxnNkB/qOvhqaR84RXWnVgnXRqSooDhTUyQz93Q0lJ
	 mtPZGYVbwJJrA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] platform/x86: think-lmi: improve check if BIOS account security enabled
Date: Wed,  9 Sep 2026 11:12:36 -0400
Message-ID: <20260909151237.2839173-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090326-unmixable-concur-5982@gregkh>
References: <2026090326-unmixable-concur-5982@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Mark Pearson <mpearson-lenovo@squebb.ca>

[ Upstream commit b39e8ece931a4b4f64cdf9e75fffd6e82828e471 ]

Improve determination of whether authentication account is enabled by
checking if either password or certificate is enabled.

Renamed valid to pwd_enabled for better readability.

Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Link: https://lore.kernel.org/r/20241024195536.6992-1-mpearson-lenovo@squebb.ca
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Backport to 6.6: omit the password-field updates in save_settings_store(),
because this tree has no bulk-save interface. Preserve the existing
strip_cr() handling in debug_cmd_store().

Prepare for commit 4f3183f5ae9b ("platform/x86: think-lmi: Fix certificate
thumbprint sysfs output") by carrying over only the thumbprint iteration
from commit 5dcb5ef125907 ("platform/x86: think-lmi: Multi-certificate
support"), along with its array-size include and password-mode constant.
Keep the existing single-certificate command format for older firmware and
use the upstream certificate selector for multi-certificate firmware.
Leave the count and error-handling correction to the target commit. No
functions are added.

Stable-dep-of: 4f3183f5ae9b ("platform/x86: think-lmi: Fix certificate thumbprint sysfs output")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/think-lmi.c | 46 ++++++++++++++++++++++----------
 drivers/platform/x86/think-lmi.h |  4 ++-
 2 files changed, 35 insertions(+), 15 deletions(-)

diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
index d5319b4637e18..9b048ca18d006 100644
--- a/drivers/platform/x86/think-lmi.c
+++ b/drivers/platform/x86/think-lmi.c
@@ -12,6 +12,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/acpi.h>
+#include <linux/array_size.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
 #include <linux/mutex.h>
@@ -391,7 +392,7 @@ static ssize_t is_enabled_show(struct kobject *kobj, struct kobj_attribute *attr
 {
 	struct tlmi_pwd_setting *setting = to_tlmi_pwd_setting(kobj);
 
-	return sysfs_emit(buf, "%d\n", setting->valid);
+	return sysfs_emit(buf, "%d\n", setting->pwd_enabled || setting->cert_installed);
 }
 
 static struct kobj_attribute auth_is_pass_set = __ATTR_RO(is_enabled);
@@ -471,7 +472,7 @@ static ssize_t new_password_store(struct kobject *kobj,
 		if (ret)
 			goto out;
 
-		if (tlmi_priv.pwd_admin->valid) {
+		if (tlmi_priv.pwd_admin->pwd_enabled) {
 			ret = tlmi_opcode_setting("WmiOpcodePasswordAdmin",
 					tlmi_priv.pwd_admin->password);
 			if (ret)
@@ -671,18 +672,35 @@ static ssize_t cert_thumbprint(char *buf, const char *arg, int count)
 	return count;
 }
 
+static const char * const thumbtypes[] = { "Md5", "Sha1", "Sha256" };
+
 static ssize_t certificate_thumbprint_show(struct kobject *kobj, struct kobj_attribute *attr,
 			 char *buf)
 {
 	struct tlmi_pwd_setting *setting = to_tlmi_pwd_setting(kobj);
+	unsigned int i;
 	int count = 0;
+	char *wmistr;
 
 	if (!tlmi_priv.certificate_support || !setting->cert_installed)
 		return -EOPNOTSUPP;
 
-	count += cert_thumbprint(buf, "Md5", count);
-	count += cert_thumbprint(buf, "Sha1", count);
-	count += cert_thumbprint(buf, "Sha256", count);
+	for (i = 0; i < ARRAY_SIZE(thumbtypes); i++) {
+		if (tlmi_priv.pwdcfg.core.password_mode >= TLMI_PWDCFG_MODE_MULTICERT) {
+			/* Format: 'SVC | SMC, Thumbtype' */
+			wmistr = kasprintf(GFP_KERNEL, "%s,%s",
+					   setting == tlmi_priv.pwd_admin ? "SVC" : "SMC",
+					   thumbtypes[i]);
+		} else {
+			/* Format: 'Thumbtype' */
+			wmistr = kasprintf(GFP_KERNEL, "%s", thumbtypes[i]);
+		}
+		if (!wmistr)
+			return -ENOMEM;
+		count += cert_thumbprint(buf, wmistr, count);
+		kfree(wmistr);
+	}
+
 	return count;
 }
 
@@ -782,7 +800,7 @@ static ssize_t certificate_store(struct kobject *kobj,
 				new_cert, setting->signature);
 	} else {
 		/* This is a fresh install */
-		if (!setting->valid || !setting->password[0]) {
+		if (!setting->pwd_enabled || !setting->password[0]) {
 			kfree(new_cert);
 			return -EACCES;
 		}
@@ -1024,7 +1042,7 @@ static ssize_t current_value_store(struct kobject *kobj,
 		 * Workstation's require the opcode to be set before changing the
 		 * attribute.
 		 */
-		if (tlmi_priv.pwd_admin->valid && tlmi_priv.pwd_admin->password[0]) {
+		if (tlmi_priv.pwd_admin->pwd_enabled && tlmi_priv.pwd_admin->password[0]) {
 			ret = tlmi_opcode_setting("WmiOpcodePasswordAdmin",
 						  tlmi_priv.pwd_admin->password);
 			if (ret)
@@ -1044,7 +1062,7 @@ static ssize_t current_value_store(struct kobject *kobj,
 
 		ret = tlmi_save_bios_settings("");
 	} else { /* old non-opcode based authentication method (deprecated) */
-		if (tlmi_priv.pwd_admin->valid && tlmi_priv.pwd_admin->password[0]) {
+		if (tlmi_priv.pwd_admin->pwd_enabled && tlmi_priv.pwd_admin->password[0]) {
 			auth_str = kasprintf(GFP_KERNEL, "%s,%s,%s;",
 					tlmi_priv.pwd_admin->password,
 					encoding_options[tlmi_priv.pwd_admin->encoding],
@@ -1175,7 +1193,7 @@ static ssize_t debug_cmd_store(struct kobject *kobj, struct kobj_attribute *attr
 	/* Strip out CR if one is present */
 	strip_cr(new_setting);
 
-	if (tlmi_priv.pwd_admin->valid && tlmi_priv.pwd_admin->password[0]) {
+	if (tlmi_priv.pwd_admin->pwd_enabled && tlmi_priv.pwd_admin->password[0]) {
 		auth_str = kasprintf(GFP_KERNEL, "%s,%s,%s;",
 				tlmi_priv.pwd_admin->password,
 				encoding_options[tlmi_priv.pwd_admin->encoding],
@@ -1496,14 +1514,14 @@ static int tlmi_analyze(void)
 		goto fail_clear_attr;
 
 	if (tlmi_priv.pwdcfg.core.password_state & TLMI_PAP_PWD)
-		tlmi_priv.pwd_admin->valid = true;
+		tlmi_priv.pwd_admin->pwd_enabled = true;
 
 	tlmi_priv.pwd_power = tlmi_create_auth("pop", "power-on");
 	if (!tlmi_priv.pwd_power)
 		goto fail_clear_attr;
 
 	if (tlmi_priv.pwdcfg.core.password_state & TLMI_POP_PWD)
-		tlmi_priv.pwd_power->valid = true;
+		tlmi_priv.pwd_power->pwd_enabled = true;
 
 	if (tlmi_priv.opcode_support) {
 		tlmi_priv.pwd_system = tlmi_create_auth("smp", "system");
@@ -1511,7 +1529,7 @@ static int tlmi_analyze(void)
 			goto fail_clear_attr;
 
 		if (tlmi_priv.pwdcfg.core.password_state & TLMI_SMP_PWD)
-			tlmi_priv.pwd_system->valid = true;
+			tlmi_priv.pwd_system->pwd_enabled = true;
 
 		tlmi_priv.pwd_hdd = tlmi_create_auth("hdd", "hdd");
 		if (!tlmi_priv.pwd_hdd)
@@ -1529,7 +1547,7 @@ static int tlmi_analyze(void)
 			/* Check if PWD is configured and set index to first drive found */
 			if (tlmi_priv.pwdcfg.ext.hdd_user_password ||
 					tlmi_priv.pwdcfg.ext.hdd_master_password) {
-				tlmi_priv.pwd_hdd->valid = true;
+				tlmi_priv.pwd_hdd->pwd_enabled = true;
 				if (tlmi_priv.pwdcfg.ext.hdd_master_password)
 					tlmi_priv.pwd_hdd->index =
 						ffs(tlmi_priv.pwdcfg.ext.hdd_master_password) - 1;
@@ -1539,7 +1557,7 @@ static int tlmi_analyze(void)
 			}
 			if (tlmi_priv.pwdcfg.ext.nvme_user_password ||
 					tlmi_priv.pwdcfg.ext.nvme_master_password) {
-				tlmi_priv.pwd_nvme->valid = true;
+				tlmi_priv.pwd_nvme->pwd_enabled = true;
 				if (tlmi_priv.pwdcfg.ext.nvme_master_password)
 					tlmi_priv.pwd_nvme->index =
 						ffs(tlmi_priv.pwdcfg.ext.nvme_master_password) - 1;
diff --git a/drivers/platform/x86/think-lmi.h b/drivers/platform/x86/think-lmi.h
index 4daba6151cd67..69e8a9bcdb710 100644
--- a/drivers/platform/x86/think-lmi.h
+++ b/drivers/platform/x86/think-lmi.h
@@ -28,6 +28,8 @@ enum level_option {
 };
 
 /* password configuration details */
+#define TLMI_PWDCFG_MODE_MULTICERT 3
+
 struct tlmi_pwdcfg_core {
 	uint32_t password_mode;
 	uint32_t password_state;
@@ -52,7 +54,7 @@ struct tlmi_pwdcfg {
 /* password setting details */
 struct tlmi_pwd_setting {
 	struct kobject kobj;
-	bool valid;
+	bool pwd_enabled;
 	char password[TLMI_PWD_BUFSIZE];
 	const char *pwd_type;
 	const char *role;
-- 
2.53.0

