Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6933436826E
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 17:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788973946; cv=none; b=UWnEKS7WoCySPGeRPJssGtvfVVqpBEFC6MlBWUj/8bvGEmBmiGrSMmFhE8Iu8pnR0MXRPnpUF6QLDKO3vYB2C0DY+FDuBydtfkMN1uPu7INGmEI0dUsNcY01rs5Xsp0hJNcM19RDsxdw2k0+WoM1H18wKJZL6N2CtWjMsoXIzvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788973946; c=relaxed/simple;
	bh=vjDTJtWoU374jcB4MGJUE0+OPQ/hAlYyw//O091YwHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MYaN0VesCyC9TtQBzy9Ft2ERd+dKPdyLTmMEV5r8A2XSuQSkNt1jgqNXnOWuP4w8fueMiFZTgDd6QnOFpEPDbIQNzN9enkYxQoDGCNrDbm4yZra+HRNXuHKZTM8wUv+b+xTBHgzaViqfOVNIq2+jaEETukjaa0E2m9AQzvS4l6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MxDBzYXy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MxDBzYXy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51D741F000FF;
	Wed,  9 Sep 2026 17:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788973942;
	bh=wmdqaWwSr1dx4g+kVV7oXbJ1HpfOXOd6EumeBFxdRk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MxDBzYXy4cHGCPy21ooQ45YYxf/Yb55bfcE+R0OM/OkYCMUbDLDuEn4WWs9O/YgZG
	 WF4O/g1UemgA2UGfsm3hrzUdOQwq94Yo6AAduzvt59JoP6j5JbL2G/U+t/IREi0q0q
	 2DDcyq13nCQXimwO2UiN2Kw7P+1pmGad9B5MARQUXGoE972eIX2qEqOa4hXMD0svg9
	 Y5J5tmg0fZ6BFwAzxIIhB9J2Uw6VnVi10tHVbo6O/Nrg84OCHBNMZrmv6K3uqyanAQ
	 If9Shprjz+eZEn2jiYSxRriQbPPaFZnA4Zkm9D2jlaSR4qTqQRtEXtwpxrVgp+XTg1
	 yrjMkHfUkjUxA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] platform/x86: think-lmi: mutex protection around multiple WMI calls
Date: Wed,  9 Sep 2026 13:12:18 -0400
Message-ID: <20260909171219.3227568-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090343-sarcastic-pound-fa39@gregkh>
References: <2026090343-sarcastic-pound-fa39@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Mark Pearson <mpearson-lenovo@squebb.ca>

[ Upstream commit c41e0121a1221894a1a9c4666156db9e1def4d6c ]

When an attribute is being changed if the Admin account is enabled, or if
a password is being updated then multiple WMI calls are needed.
Add mutex protection to ensure no race conditions are introduced.

Fixes: b49f72e7f96d ("platform/x86: think-lmi: Certificate authentication support")
Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20230601200552.4396-1-mpearson-lenovo@squebb.ca
Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Backport notes for 5.15:
Keep the mutex around the existing password update and BIOS setting/save
paths. This tree has no certificate or opcode authentication, so retain
the legacy password authentication code at the conflicting lock site.
All error exits after locking still release the mutex.

Use the existing strreplace() helper in current_password_store() and drop
its unused temporary pointer. This preserves the visible password string
and prepares the exact context needed by 54745d563114 ("platform/x86:
think-lmi: Fix current password length check"), without adding functions
or importing the newer authentication interfaces.

Move only think-lmi.c and think-lmi.h into the upstream lenovo/ directory,
with the corresponding Kbuild, include and MAINTAINERS adjustments. Git
cannot detect the rename against the much newer target's parent; matching
the target path allows an ordinary cherry-pick without rename overrides.
The existing CONFIG_THINKPAD_LMI option and think-lmi module name are kept.

[ sashal: Reduced backport -- upstream c41e0121a1221 touches 1 file(s), this
  backport carries 5. Not backported here:
  drivers/platform/x86/think-lmi.c
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: 54745d563114 ("platform/x86: think-lmi: Fix current password length check")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 MAINTAINERS                                   |  2 +-
 drivers/platform/x86/Makefile                 |  2 +-
 drivers/platform/x86/lenovo/Makefile          |  3 +++
 drivers/platform/x86/{ => lenovo}/think-lmi.c | 16 ++++++++++++----
 drivers/platform/x86/{ => lenovo}/think-lmi.h |  0
 5 files changed, 17 insertions(+), 6 deletions(-)
 create mode 100644 drivers/platform/x86/lenovo/Makefile
 rename drivers/platform/x86/{ => lenovo}/think-lmi.c (98%)
 rename drivers/platform/x86/{ => lenovo}/think-lmi.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6635c3ba64036..47ba4501ce67e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18629,7 +18629,7 @@ M:	Mark Pearson <markpearson@lenovo.com>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-class-firmware-attributes
-F:	drivers/platform/x86/think-lmi.?
+F:	drivers/platform/x86/lenovo/think-lmi.?
 
 THUNDERBOLT DMA TRAFFIC TEST DRIVER
 M:	Isaac Hazan <isaac.hazan@intel.com>
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 5dba9fe23fb15..4d70f29622d63 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -62,7 +62,7 @@ obj-$(CONFIG_IBM_RTL)		+= ibm_rtl.o
 obj-$(CONFIG_IDEAPAD_LAPTOP)	+= ideapad-laptop.o
 obj-$(CONFIG_SENSORS_HDAPS)	+= hdaps.o
 obj-$(CONFIG_THINKPAD_ACPI)	+= thinkpad_acpi.o
-obj-$(CONFIG_THINKPAD_LMI)	+= think-lmi.o
+obj-y				+= lenovo/
 
 # Intel
 obj-y				+= intel/
diff --git a/drivers/platform/x86/lenovo/Makefile b/drivers/platform/x86/lenovo/Makefile
new file mode 100644
index 0000000000000..cdeb55cef7ce6
--- /dev/null
+++ b/drivers/platform/x86/lenovo/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_THINKPAD_LMI)	+= think-lmi.o
diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/lenovo/think-lmi.c
similarity index 98%
rename from drivers/platform/x86/think-lmi.c
rename to drivers/platform/x86/lenovo/think-lmi.c
index dde7bb7e28226..9548f96c6dad8 100644
--- a/drivers/platform/x86/think-lmi.c
+++ b/drivers/platform/x86/lenovo/think-lmi.c
@@ -14,10 +14,11 @@
 #include <linux/acpi.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
+#include <linux/mutex.h>
 #include <linux/string.h>
 #include <linux/types.h>
 #include <linux/wmi.h>
-#include "firmware_attributes_class.h"
+#include "../firmware_attributes_class.h"
 #include "think-lmi.h"
 
 static bool debug_support;
@@ -147,6 +148,7 @@ static const char * const encoding_options[] = {
 };
 static struct think_lmi tlmi_priv;
 static struct class *fw_attr_class;
+static DEFINE_MUTEX(tlmi_mutex);
 
 /* ------ Utility functions ------------*/
 /* Convert BIOS WMI error string to suitable error code */
@@ -324,7 +326,6 @@ static ssize_t current_password_store(struct kobject *kobj,
 {
 	struct tlmi_pwd_setting *setting = to_tlmi_pwd_setting(kobj);
 	size_t pwdlen;
-	char *p;
 
 	pwdlen = strlen(buf);
 	/* pwdlen == 0 is allowed to clear the password */
@@ -333,8 +334,7 @@ static ssize_t current_password_store(struct kobject *kobj,
 
 	strscpy(setting->password, buf, setting->maxlen);
 	/* Strip out CR if one is present, setting password won't work if it is present */
-	p = strchrnul(setting->password, '\n');
-	*p = '\0';
+	strreplace(setting->password, '\n', '\0');
 	return count;
 }
 
@@ -363,6 +363,9 @@ static ssize_t new_password_store(struct kobject *kobj,
 	p = strchrnul(new_pwd, '\n');
 	*p = '\0';
 
+	/* Use lock in case multiple WMI operations needed */
+	mutex_lock(&tlmi_mutex);
+
 	pwdlen = strlen(new_pwd);
 	/* pwdlen == 0 is allowed to clear the password */
 	if (pwdlen && ((pwdlen < setting->minlen) || (pwdlen > setting->maxlen))) {
@@ -381,6 +384,7 @@ static ssize_t new_password_store(struct kobject *kobj,
 	ret = tlmi_simple_call(LENOVO_SET_BIOS_PASSWORD_GUID, auth_str);
 	kfree(auth_str);
 out:
+	mutex_unlock(&tlmi_mutex);
 	kfree(new_pwd);
 	return ret ?: count;
 }
@@ -568,6 +572,9 @@ static ssize_t current_value_store(struct kobject *kobj,
 	p = strchrnul(new_setting, '\n');
 	*p = '\0';
 
+	/* Use lock in case multiple WMI operations needed */
+	mutex_lock(&tlmi_mutex);
+
 	if (tlmi_priv.pwd_admin->valid && tlmi_priv.pwd_admin->password[0]) {
 		auth_str = kasprintf(GFP_KERNEL, "%s,%s,%s;",
 				tlmi_priv.pwd_admin->password,
@@ -605,6 +612,7 @@ static ssize_t current_value_store(struct kobject *kobj,
 		kobject_uevent(&tlmi_priv.class_dev->kobj, KOBJ_CHANGE);
 	}
 out:
+	mutex_unlock(&tlmi_mutex);
 	kfree(auth_str);
 	kfree(set_str);
 	kfree(new_setting);
diff --git a/drivers/platform/x86/think-lmi.h b/drivers/platform/x86/lenovo/think-lmi.h
similarity index 100%
rename from drivers/platform/x86/think-lmi.h
rename to drivers/platform/x86/lenovo/think-lmi.h
-- 
2.53.0

