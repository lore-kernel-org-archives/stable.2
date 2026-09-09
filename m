Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379D232A3D7
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 16:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788971239; cv=none; b=Zno9kH4LbaJLfSsZVX8QxmTWrCi1lTOiIMlAeLKwGUI47Vf8brDRZlKGBN40n7uQbyQlccJwdd6wRu21SDVXntbJEEXNLvfdzjZ/QpY8YvGU+HoBNgq7kKJotEH69Rc1xsD6JR9RpDsKIZ7snL1cl7OM+Ii3LosT4L4sSQU2A9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788971239; c=relaxed/simple;
	bh=xufoTfKYBtSzs8A4mzWJchdLIZRPG8JtfG6Q4jyPnhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UsTV5EFHLQPA3Bj3gg5wBZ3mUA5qz2GK9+PTu6SwAGJJ71fFHpIZBHDCVhe/k35ucWNF5p7sE8Ta4O9qCQhdQsYiVNiC/unVnztciGzoP0Q9f1Ip+/0ncLTVmy3JfbaSp838XnfNta8Tez3gGfkb6D23VyYC22HPwVGSpFE57RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SkTXXuk9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SkTXXuk9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44AFD1F00893;
	Wed,  9 Sep 2026 16:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788971237;
	bh=8cGroi/mkcLwAu/lTYkXTGyUQlFqyKlBXf4tUZRrYSA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SkTXXuk9Nzu13O2MvMCBchnsgG8iZOKGwmt9Pr81bTJC+QdQJKq5nfuzo8DVKwZk9
	 +czrn/NGdCdRiKnxia3vVQ1Jt07YSUl4P3xMHnnkTv/4cIA8YKjL/twdlcgtxuP4GF
	 1urDyLb0SB3EDwSDix2wRzugv5aDxL5fTyoGb7cWfdpEt/Xdd1wCuZ+CNDZldC9za/
	 KbYvv2nZmS2xn2Usa1Z6nVPM2jv2S9cFJqftp/2A/fbhYxHO/CTRSfWIJWzl8wMdk4
	 V+j/67/mXpeU1c6fuD8WqT5OYIiw9cJF+lLkKIc3vJNgvYlar3UMU6zlX9u2aDkpIi
	 5iB1/REGTmXcA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/4] platform/x86: think-lmi: Replace kstrdup() + strreplace() with kstrdup_and_replace()
Date: Wed,  9 Sep 2026 12:27:12 -0400
Message-ID: <20260909162714.2984324-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909162714.2984324-1-sashal@kernel.org>
References: <2026090342-duct-salutary-5524@gregkh>
 <20260909162714.2984324-1-sashal@kernel.org>
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

Adapt the current_value_store() conversion to the 6.1 tree, which lacks
bulk-save support. Keep the existing permission and save behavior instead
of introducing references to absent save_mode and reboot_required fields.

Also replace the remaining strip_cr() call in current_password_store()
with strreplace() and remove the now-unused helper. This supplies the
context expected by 54745d563114 ("platform/x86: think-lmi: Fix current
password length check") without adding functions or changing the password
length checks in this dependency.

The earlier kstrdup_and_replace() dependency also assumes the upstream
strreplace() return-value change from d01a77afd6be. In this stable tree,
strreplace() still returns the string's end, so explicitly return dst from
kstrdup_and_replace() after performing the replacement. This preserves the
allocation pointer for the newly converted callers and their frees.

Stable-dep-of: 54745d563114 ("platform/x86: think-lmi: Fix current password length check")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/think-lmi.c | 53 ++++++++++----------------------
 lib/string_helpers.c             |  3 +-
 2 files changed, 18 insertions(+), 38 deletions(-)

diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
index e7605bc97f2b0..58c070198e59f 100644
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
@@ -198,14 +198,6 @@ static struct think_lmi tlmi_priv;
 static struct class *fw_attr_class;
 static DEFINE_MUTEX(tlmi_mutex);
 
-/* ------ Utility functions ------------*/
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
@@ -411,7 +403,7 @@ static ssize_t current_password_store(struct kobject *kobj,
 
 	strscpy(setting->password, buf, setting->maxlen);
 	/* Strip out CR if one is present, setting password won't work if it is present */
-	strip_cr(setting->password);
+	strreplace(setting->password, '\n', '\0');
 	return count;
 }
 
@@ -432,13 +424,11 @@ static ssize_t new_password_store(struct kobject *kobj,
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
 
@@ -709,13 +699,11 @@ static ssize_t cert_to_password_store(struct kobject *kobj,
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
@@ -765,11 +753,10 @@ static ssize_t certificate_store(struct kobject *kobj,
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
@@ -817,13 +804,11 @@ static ssize_t signature_store(struct kobject *kobj,
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
@@ -846,13 +831,11 @@ static ssize_t save_signature_store(struct kobject *kobj,
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
@@ -981,13 +964,11 @@ static ssize_t current_value_store(struct kobject *kobj,
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
 
@@ -1160,13 +1141,11 @@ static ssize_t debug_cmd_store(struct kobject *kobj, struct kobj_attribute *attr
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
diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index 2f975395b49e5..9be6a3cfaed4a 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -730,7 +730,8 @@ char *kstrdup_and_replace(const char *src, char old, char new, gfp_t gfp)
 	if (!dst)
 		return NULL;
 
-	return strreplace(dst, old, new);
+	strreplace(dst, old, new);
+	return dst;
 }
 EXPORT_SYMBOL_GPL(kstrdup_and_replace);
 
-- 
2.53.0

