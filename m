Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1D7468C2F
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 15:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788966625; cv=none; b=GOjt68/fyx1EFxobWEduTe1a3nsfzMvzoIAJcTmMEITbE/bySYHU8Yp6e3n4q9k2KvGGK31jp4+rW0bp2xEidUqJ8yGWX/uICRMGmFmjJJGNK8WvgZIZepSPpZzfKNfTSVXm0X5MfRxZ2T8L20qov8CDV8QdEfm3TP8Re0CqR2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788966625; c=relaxed/simple;
	bh=qV6O8hsetPsoUCkZs8CI1mKXH/5TMnS9p2aGRvDBPww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kEqgv+Y7mDLgFSPfJZwgAJPiXv1QMg+Pv65PHIN5xQuOSV1sZl2s+dtbKkamsUYsWHzBnOf3rYZP1oolylTbpXMvntTdx4Z7a6hUujZ0GUm0koIq0tD4bmqX2X8WYQfPTEcqTmQ2gvUUh2HgG9+PSB2yqhU9F/er1e/wloHObF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TINc47wa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TINc47wa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD4EF1F00A3D;
	Wed,  9 Sep 2026 15:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788966624;
	bh=037h1U1QAcBa822lRl022gNzrOF2ywPkUjMGN7VmheA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TINc47waj+0BZ2MTYpB3l8aEc3DS0szYlLP+12jR0s77C1nSdW2vc/Cn9ylJEL31o
	 XFZZFbpYeJ6sKL0GQzU56yOp3yu3il++Lwbyt4zGNYZB/7AF5Aret/Atx0nyG5rBGP
	 RA/+k8ZCGi11DMjplhHZT/frMJv5cMN3SxEHCtszBguoCcNPxWtDKl2Z/oBWxTUsUc
	 AUTrKhArs6uYQrvOgwVCoWrtO7zN+XM/8gNsvb2O5nYnwGYMqqblbzdjPk2M9UtE/T
	 uqWTIv53TmV2uaD6S+AhJ6soXx1wEhcJlvn9yRTJ9PjaxHZ34qBJFKFWUpDZ6htbqJ
	 bCYKGNxwFzYrg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] platform/x86: think-lmi: Replace kstrdup() + strreplace() with kstrdup_and_replace()
Date: Wed,  9 Sep 2026 11:10:20 -0400
Message-ID: <20260909151021.2821213-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090342-prepay-dwelling-6bbb@gregkh>
References: <2026090342-prepay-dwelling-6bbb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit e621198016e99cddc097d32cd3b56b15cee27d91 ]

Replace open coded functionalify of kstrdup_and_replace() with a call.

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20230918135116.1248560-1-andriy.shevchenko@linux.intel.com
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Stable dependency adaptation for 54745d563114b74f6fecebce68cd020d06c1772b:
Resolve current_value_store() against the existing immediate-save path;
the bulk-save feature and its reboot guard are absent from this tree.

Also replace the remaining strip_cr() call in current_password_store()
with strreplace(), and remove the now-unused strip_cr() helper. This is
the target-relevant portion of upstream 6cb9c8637c672, folded into this
dependency so the target has the expected context. Keep the target's
password-length fix for the target commit itself. No functions are added.

Stable-dep-of: 54745d563114 ("platform/x86: think-lmi: Fix current password length check")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/think-lmi.c | 52 ++++++++++----------------------
 1 file changed, 16 insertions(+), 36 deletions(-)

diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
index d5319b4637e18..3f26d9293027d 100644
--- a/drivers/platform/x86/think-lmi.c
+++ b/drivers/platform/x86/think-lmi.c
@@ -15,7 +15,7 @@
 #include <linux/errno.h>
 #include <linux/fs.h>
 #include <linux/mutex.h>
-#include <linux/string.h>
+#include <linux/string_helpers.h>
 #include <linux/types.h>
 #include <linux/dmi.h>
 #include <linux/wmi.h>
@@ -198,13 +198,6 @@ static struct think_lmi tlmi_priv;
 static DEFINE_MUTEX(tlmi_mutex);
 
 /* ------ Utility functions ------------*/
-/* Strip out CR if one is present */
-static void strip_cr(char *str)
-{
-	char *p = strchrnul(str, '\n');
-	*p = '\0';
-}
-
 /* Convert BIOS WMI error string to suitable error code */
 static int tlmi_errstr_to_err(const char *errstr)
 {
@@ -410,7 +403,7 @@ static ssize_t current_password_store(struct kobject *kobj,
 
 	strscpy(setting->password, buf, setting->maxlen);
 	/* Strip out CR if one is present, setting password won't work if it is present */
-	strip_cr(setting->password);
+	strreplace(setting->password, '\n', '\0');
 	return count;
 }
 
@@ -431,13 +424,11 @@ static ssize_t new_password_store(struct kobject *kobj,
 	if (!tlmi_priv.can_set_bios_password)
 		return -EOPNOTSUPP;
 
-	new_pwd = kstrdup(buf, GFP_KERNEL);
+	/* Strip out CR if one is present, setting password won't work if it is present */
+	new_pwd = kstrdup_and_replace(buf, '\n', '\0', GFP_KERNEL);
 	if (!new_pwd)
 		return -ENOMEM;
 
-	/* Strip out CR if one is present, setting password won't work if it is present */
-	strip_cr(new_pwd);
-
 	/* Use lock in case multiple WMI operations needed */
 	mutex_lock(&tlmi_mutex);
 
@@ -708,13 +699,11 @@ static ssize_t cert_to_password_store(struct kobject *kobj,
 	if (!setting->signature || !setting->signature[0])
 		return -EACCES;
 
-	passwd = kstrdup(buf, GFP_KERNEL);
+	/* Strip out CR if one is present */
+	passwd = kstrdup_and_replace(buf, '\n', '\0', GFP_KERNEL);
 	if (!passwd)
 		return -ENOMEM;
 
-	/* Strip out CR if one is present */
-	strip_cr(passwd);
-
 	/* Format: 'Password,Signature' */
 	auth_str = kasprintf(GFP_KERNEL, "%s,%s", passwd, setting->signature);
 	if (!auth_str) {
@@ -764,11 +753,10 @@ static ssize_t certificate_store(struct kobject *kobj,
 		return ret ?: count;
 	}
 
-	new_cert = kstrdup(buf, GFP_KERNEL);
+	/* Strip out CR if one is present */
+	new_cert = kstrdup_and_replace(buf, '\n', '\0', GFP_KERNEL);
 	if (!new_cert)
 		return -ENOMEM;
-	/* Strip out CR if one is present */
-	strip_cr(new_cert);
 
 	if (setting->cert_installed) {
 		/* Certificate is installed so this is an update */
@@ -816,13 +804,11 @@ static ssize_t signature_store(struct kobject *kobj,
 	if (!tlmi_priv.certificate_support)
 		return -EOPNOTSUPP;
 
-	new_signature = kstrdup(buf, GFP_KERNEL);
+	/* Strip out CR if one is present */
+	new_signature = kstrdup_and_replace(buf, '\n', '\0', GFP_KERNEL);
 	if (!new_signature)
 		return -ENOMEM;
 
-	/* Strip out CR if one is present */
-	strip_cr(new_signature);
-
 	/* Free any previous signature */
 	kfree(setting->signature);
 	setting->signature = new_signature;
@@ -845,13 +831,11 @@ static ssize_t save_signature_store(struct kobject *kobj,
 	if (!tlmi_priv.certificate_support)
 		return -EOPNOTSUPP;
 
-	new_signature = kstrdup(buf, GFP_KERNEL);
+	/* Strip out CR if one is present */
+	new_signature = kstrdup_and_replace(buf, '\n', '\0', GFP_KERNEL);
 	if (!new_signature)
 		return -ENOMEM;
 
-	/* Strip out CR if one is present */
-	strip_cr(new_signature);
-
 	/* Free any previous signature */
 	kfree(setting->save_signature);
 	setting->save_signature = new_signature;
@@ -985,13 +969,11 @@ static ssize_t current_value_store(struct kobject *kobj,
 	if (!tlmi_priv.can_set_bios_settings)
 		return -EOPNOTSUPP;
 
-	new_setting = kstrdup(buf, GFP_KERNEL);
+	/* Strip out CR if one is present */
+	new_setting = kstrdup_and_replace(buf, '\n', '\0', GFP_KERNEL);
 	if (!new_setting)
 		return -ENOMEM;
 
-	/* Strip out CR if one is present */
-	strip_cr(new_setting);
-
 	/* Use lock in case multiple WMI operations needed */
 	mutex_lock(&tlmi_mutex);
 
@@ -1168,13 +1150,11 @@ static ssize_t debug_cmd_store(struct kobject *kobj, struct kobj_attribute *attr
 	if (!tlmi_priv.can_debug_cmd)
 		return -EOPNOTSUPP;
 
-	new_setting = kstrdup(buf, GFP_KERNEL);
+	/* Strip out CR if one is present */
+	new_setting = kstrdup_and_replace(buf, '\n', '\0', GFP_KERNEL);
 	if (!new_setting)
 		return -ENOMEM;
 
-	/* Strip out CR if one is present */
-	strip_cr(new_setting);
-
 	if (tlmi_priv.pwd_admin->valid && tlmi_priv.pwd_admin->password[0]) {
 		auth_str = kasprintf(GFP_KERNEL, "%s,%s,%s;",
 				tlmi_priv.pwd_admin->password,
-- 
2.53.0

