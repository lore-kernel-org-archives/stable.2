Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BF04A2A7C
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 14:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965551; cv=none; b=EFSjOadt0EfFruquTaQvcUMfN/vjf2FSBhc6JrugmbW9O9cV0gbXLlUDxy2Q8lXPSrQK9N33JOBYcwS1z/mUSgtDBxFPPNIu+1+YET15tt1rRugFi1s3+GtKCYUPTJse0HJ1h7w0FlIXiZga4kxmLLCa8HRLKMRpl4+B+iRxSw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965551; c=relaxed/simple;
	bh=buZdORPQ/We4AGwI52BBRoX+MeqEQod21qzmTEvRfCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cCtWAOMRdewcB3C5aCj25mRhpcJ4zpjYhBk9vWxyYP4EusqEmQAdBwQpsur655N8YtgAge3fKMwOxayC/JK73TLrAvm8XUZdUg0GFukHIqky7blPcRzr0DusbE6Mn8YFgj04g/5W1Q16Lmug1RcNS/+gXdzU7pACYtLx+402Fog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oCdodkNQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oCdodkNQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E98E21F00A3D;
	Wed,  9 Sep 2026 14:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788965549;
	bh=isFmswh7qKk2L/lZYpK0XAjBU4XBoJRI4xo5Kb8OQLc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oCdodkNQvsXF7SswitWRaVooxajrMNCrpTxPA5xmwE2HrYsWCkABFiBcz++I4ssAq
	 AIVib6j55VT66Pti39Spj5+i6p8PYIzE6iIUMEz2ge2QclD8o74HPbXgVbqt7v0F5B
	 kjfQ+NLLBdqA8/JTTAaq5IyXpceymfZps+pwaYYsc/VfLVvMVK0GpHuddDGljuj6G2
	 t9579k4007t7vU0qZHm9Q2aeLDM6cvlQknsEdJU+7VoXVQWh+LojGMnOE4lgBfcZh8
	 Htw/NL2Vzexs6RwoKCgAx8tb210QrjsqfL+WSXheg+2kjDqeSkKy2M46mP4MsVq5yA
	 BDVs7BnBMrQ1Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] platform/x86: think-lmi: improve check if BIOS account security enabled
Date: Wed,  9 Sep 2026 10:52:26 -0400
Message-ID: <20260909145227.2687665-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090326-stilt-refined-4e17@gregkh>
References: <2026090326-stilt-refined-4e17@gregkh>
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
Stable-dep-of: 4f3183f5ae9b ("platform/x86: think-lmi: Fix certificate thumbprint sysfs output")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/think-lmi.c | 26 +++++++++++++-------------
 drivers/platform/x86/think-lmi.h |  2 +-
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
index 6ad2af46248b9..f6f76418ecdea 100644
--- a/drivers/platform/x86/think-lmi.c
+++ b/drivers/platform/x86/think-lmi.c
@@ -390,7 +390,7 @@ static ssize_t is_enabled_show(struct kobject *kobj, struct kobj_attribute *attr
 {
 	struct tlmi_pwd_setting *setting = to_tlmi_pwd_setting(kobj);
 
-	return sysfs_emit(buf, "%d\n", setting->valid);
+	return sysfs_emit(buf, "%d\n", setting->pwd_enabled || setting->cert_installed);
 }
 
 static struct kobj_attribute auth_is_pass_set = __ATTR_RO(is_enabled);
@@ -468,7 +468,7 @@ static ssize_t new_password_store(struct kobject *kobj,
 		if (ret)
 			goto out;
 
-		if (tlmi_priv.pwd_admin->valid) {
+		if (tlmi_priv.pwd_admin->pwd_enabled) {
 			ret = tlmi_opcode_setting("WmiOpcodePasswordAdmin",
 					tlmi_priv.pwd_admin->password);
 			if (ret)
@@ -776,7 +776,7 @@ static ssize_t certificate_store(struct kobject *kobj,
 				new_cert, setting->signature);
 	} else {
 		/* This is a fresh install */
-		if (!setting->valid || !setting->password[0]) {
+		if (!setting->pwd_enabled || !setting->password[0]) {
 			kfree(new_cert);
 			return -EACCES;
 		}
@@ -1019,7 +1019,7 @@ static ssize_t current_value_store(struct kobject *kobj,
 		 * Workstation's require the opcode to be set before changing the
 		 * attribute.
 		 */
-		if (tlmi_priv.pwd_admin->valid && tlmi_priv.pwd_admin->password[0]) {
+		if (tlmi_priv.pwd_admin->pwd_enabled && tlmi_priv.pwd_admin->password[0]) {
 			ret = tlmi_opcode_setting("WmiOpcodePasswordAdmin",
 						  tlmi_priv.pwd_admin->password);
 			if (ret)
@@ -1042,7 +1042,7 @@ static ssize_t current_value_store(struct kobject *kobj,
 		else
 			ret = tlmi_save_bios_settings("");
 	} else { /* old non-opcode based authentication method (deprecated) */
-		if (tlmi_priv.pwd_admin->valid && tlmi_priv.pwd_admin->password[0]) {
+		if (tlmi_priv.pwd_admin->pwd_enabled && tlmi_priv.pwd_admin->password[0]) {
 			auth_str = kasprintf(GFP_KERNEL, "%s,%s,%s;",
 					tlmi_priv.pwd_admin->password,
 					encoding_options[tlmi_priv.pwd_admin->encoding],
@@ -1218,7 +1218,7 @@ static ssize_t save_settings_store(struct kobject *kobj, struct kobj_attribute *
 			if (ret)
 				goto out;
 		} else if (tlmi_priv.opcode_support) {
-			if (tlmi_priv.pwd_admin->valid && tlmi_priv.pwd_admin->password[0]) {
+			if (tlmi_priv.pwd_admin->pwd_enabled && tlmi_priv.pwd_admin->password[0]) {
 				ret = tlmi_opcode_setting("WmiOpcodePasswordAdmin",
 							  tlmi_priv.pwd_admin->password);
 				if (ret)
@@ -1226,7 +1226,7 @@ static ssize_t save_settings_store(struct kobject *kobj, struct kobj_attribute *
 			}
 			ret = tlmi_save_bios_settings("");
 		} else { /* old non-opcode based authentication method (deprecated) */
-			if (tlmi_priv.pwd_admin->valid && tlmi_priv.pwd_admin->password[0]) {
+			if (tlmi_priv.pwd_admin->pwd_enabled && tlmi_priv.pwd_admin->password[0]) {
 				auth_str = kasprintf(GFP_KERNEL, "%s,%s,%s;",
 						     tlmi_priv.pwd_admin->password,
 						     encoding_options[tlmi_priv.pwd_admin->encoding],
@@ -1276,7 +1276,7 @@ static ssize_t debug_cmd_store(struct kobject *kobj, struct kobj_attribute *attr
 	if (!new_setting)
 		return -ENOMEM;
 
-	if (tlmi_priv.pwd_admin->valid && tlmi_priv.pwd_admin->password[0]) {
+	if (tlmi_priv.pwd_admin->pwd_enabled && tlmi_priv.pwd_admin->password[0]) {
 		auth_str = kasprintf(GFP_KERNEL, "%s,%s,%s;",
 				tlmi_priv.pwd_admin->password,
 				encoding_options[tlmi_priv.pwd_admin->encoding],
@@ -1603,14 +1603,14 @@ static int tlmi_analyze(void)
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
@@ -1618,7 +1618,7 @@ static int tlmi_analyze(void)
 			goto fail_clear_attr;
 
 		if (tlmi_priv.pwdcfg.core.password_state & TLMI_SMP_PWD)
-			tlmi_priv.pwd_system->valid = true;
+			tlmi_priv.pwd_system->pwd_enabled = true;
 
 		tlmi_priv.pwd_hdd = tlmi_create_auth("hdd", "hdd");
 		if (!tlmi_priv.pwd_hdd)
@@ -1636,7 +1636,7 @@ static int tlmi_analyze(void)
 			/* Check if PWD is configured and set index to first drive found */
 			if (tlmi_priv.pwdcfg.ext.hdd_user_password ||
 					tlmi_priv.pwdcfg.ext.hdd_master_password) {
-				tlmi_priv.pwd_hdd->valid = true;
+				tlmi_priv.pwd_hdd->pwd_enabled = true;
 				if (tlmi_priv.pwdcfg.ext.hdd_master_password)
 					tlmi_priv.pwd_hdd->index =
 						ffs(tlmi_priv.pwdcfg.ext.hdd_master_password) - 1;
@@ -1646,7 +1646,7 @@ static int tlmi_analyze(void)
 			}
 			if (tlmi_priv.pwdcfg.ext.nvme_user_password ||
 					tlmi_priv.pwdcfg.ext.nvme_master_password) {
-				tlmi_priv.pwd_nvme->valid = true;
+				tlmi_priv.pwd_nvme->pwd_enabled = true;
 				if (tlmi_priv.pwdcfg.ext.nvme_master_password)
 					tlmi_priv.pwd_nvme->index =
 						ffs(tlmi_priv.pwdcfg.ext.nvme_master_password) - 1;
diff --git a/drivers/platform/x86/think-lmi.h b/drivers/platform/x86/think-lmi.h
index 7f9632a53736f..e46938c4d3d67 100644
--- a/drivers/platform/x86/think-lmi.h
+++ b/drivers/platform/x86/think-lmi.h
@@ -65,7 +65,7 @@ struct tlmi_pwdcfg {
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

