Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEB9360EC2
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 20:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783455714; cv=none; b=aq708sayFMQenc1f9kr/LN3MUX85dUuMyQjyhVztUVP6hXGaEpefvYYehLRqILlmjygn6F5jTPnxHax+qRfcyhrKTt3aN0+hnOXJB4/o1VmTd0rmy6sHdltTQMlQcpNwr84p8zHUP96ISZf2CwmIqCPwA78m7mSvAV43SBOBoIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783455714; c=relaxed/simple;
	bh=oW8ToYZANrszzjIkNIjdHiqYz76QjbkjwIqg8Hbboiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b6ndK5fTGq8/q1CE1W9JToiCCfCM0xI4PjP+lHT5O5csObuMEqX9KwMtG8jbb939E+UmEw7+E3toV08bXGj5Fkr2TnBXJGpbH91Xe3j+ZZaKFnJxRVn+SeMTocuDtP2UiXJayOU65A5oY7R0p8/d3ki7qu9L1OmwTZwwUPNrzUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZhSSXKsj; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZhSSXKsj"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-698ab9aae16so8115567a12.3
        for <stable@vger.kernel.org>; Tue, 07 Jul 2026 13:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783455711; x=1784060511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z+lTPpD0X72D2tCT1QIDelry0Ux3PBIOJz2GUvmGpW4=;
        b=ZhSSXKsjqvMpU0sFJ6zZ012U01EKFx+XOCLci/qpvzhROGC+S0QrXBircHYhlVBrXV
         5FRuMGjMxikGOMW+s74TqhhgZ2fyYUz1jqxxm7nvlFHI2/Pu6GyrvLg5UhchKLJ39k+b
         lP+ZBgH5zQ9roImng1QrJuqRjo3e3kk65V+nIxXDU8sw63cLsEMMn0KQsFAbkZpI8wLF
         FHJDq+t6mmyroKE7U2oPEW4IVFUjUWpYK+fykYDdTIoLDGvDfIASjADn+Sa1KNZU6vsK
         4eDp1wz/k+D9XhmJHKJ/MgRLpC7HgtXMajAb3gGh33+Xcr8sm394GkqEy8OH3+hAoJ68
         SAVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783455711; x=1784060511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=z+lTPpD0X72D2tCT1QIDelry0Ux3PBIOJz2GUvmGpW4=;
        b=UnDO2mcwy+qCsDSiE2fgK9Hg6iFQHPnJ1dAhgusMC65QqKI/uAOBK8anSIK/ntypQ1
         DWXQMMb2+hsnSRDxjzYGdiEEMpGLpoMhPDR5midoohPljGJAeffonnPqOFXWFBqbNkpf
         /yvXnKrhpfLSs+MV0HRHACaOa6nroMZOXCwjaXuKdTa3Meh9Vf79UnNTwsZOkeu2KEKs
         U3J0TAcrCX9kyrpa+IE8OAXi+KQAbRLPkaH+bX1nROxn+ip40VxKm999Sg4BZQ7RztAO
         i57BcLOQSCT5JqHmxk4gGk1zNwOZum7fx8IC/Po/9S0/3beVDvjBUNi/eCCKZtKQtVr9
         ZR8Q==
X-Forwarded-Encrypted: i=1; AHgh+RrbneT4VDKZUThIo2dNEk4gGZm7uWAGZV0E8tFyLwT57nOL7prf1b9q+VyS/iiPhldTpHlmjtg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMu00EtCQwvF5mSQzY9RuM6MCStc59LXgfXgVIImdfhSY8Y5V/
	0P4Jaz4Qs//sDnrEJHb7mDN8Dpi/WZKDDKBFiEEDmJTrncZB83YhBa3b
X-Gm-Gg: AfdE7ckIHAAwmJ2bOZU9pG/XLzAMX9sA4KvacAdaxq5/7JZbeW+BdwfRxrswRpc695j
	eFaaa0GXquzX8sFt0xIpcyn1B3VR6XnYHg6xlMBetfJAOLAYC5Y12GmhOIsO2JY8tHiXDHjWDg2
	ElypZPNzQcoscyh/bxcfU1AIYVTRVVXSRICp3czlJ0+WhnVxEoPA9WnD5yM9+Zrt0LPZ5g5dvpO
	eRIwTOZdQB048FP08JIjGlHnCSWP4Qa9CooHOy0INUPpGOg52bDB37l4U+4j2kDscvz5lqOSUJ0
	e8qz3ju7mEDeXJ0Yf0ViJ5B1YuLWouRxWcV8CIQcd616IoTQTULIsvtW7hCI3bggvAhIHkKDXxK
	sb/PnD8mgDR5aANrZJSXib8XUADN2/n63vzNFKkUaU6fmrwNwir32NfQrYB9j/kR07Nc/BMya5z
	wFveKFDh6AerXHpWElSqvnjVgwP28jhdcemtDlJ32XfeK7fPvtgrVjcUz/OdmFFHY=
X-Received: by 2002:a05:6402:a501:20b0:699:fa33:f395 with SMTP id 4fb4d7f45d1cf-69a856a7733mr2618472a12.3.1783455710388;
        Tue, 07 Jul 2026 13:21:50 -0700 (PDT)
Received: from node ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69aa6dba523sm637930a12.0.2026.07.07.13.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 13:21:49 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	hdegoede@redhat.com,
	jorge.lopez2@hp.com,
	Thomas.Weissschuh@linutronix.de,
	superm1@kernel.org,
	W_Armin@gmx.de,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH v3 1/4] platform/x86: hp-bioscfg: pass validated element count to package parsers
Date: Wed,  8 Jul 2026 01:21:08 +0500
Message-ID: <20260707202111.35414-2-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260707202111.35414-1-meatuni001@gmail.com>
References: <20260707202111.35414-1-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The per-type package parsers are handed the wrong element count.

hp_init_bios_package_attribute() validates obj->package.count and then
calls one of the five hp_populate_*_package_data() wrappers (string,
integer, enumeration, ordered list, password). Each wrapper forwards a
count to its hp_populate_*_elements_from_package() parser, but instead
of forwarding the validated obj->package.count it derives the count
from elements[0]. elements[0] is the NAME field and is always an
ACPI_TYPE_STRING, so reading ->package.count from it in fact reads
->string.length through the union acpi_object. The parsers thus bound
themselves against the length of the name string rather than against
the real number of elements in the package.

This is safe today because hp_init_bios_package_attribute() refuses any
package that has fewer than the type's element count, so a parser only
ever runs on a full package and never reads past it regardless of the
bogus bound.

A later patch relaxes that check to accept shorter packages. Once a
parser can receive fewer elements than its per-type count, a bound
taken from the name length no longer reflects the array size, and the
"elem < count" loop conditions and "elem + n >= count" sub-loop guards
read past the end of elements[] - an out-of-bounds heap read.

Forward the validated obj->package.count to every *_package_data()
wrapper so the parsers bound themselves against the real package size.
This does not change behaviour for the packages that enumerate
correctly today and is a prerequisite for accepting shorter packages
safely.

Fixes: a34fc329b189 ("platform/x86: hp-bioscfg: bioscfg")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c               | 5 +++++
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.h               | 5 +++++
 drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c       | 3 ++-
 drivers/platform/x86/hp/hp-bioscfg/int-attributes.c        | 3 ++-
 drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c | 5 +++--
 drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c  | 5 +++--
 drivers/platform/x86/hp/hp-bioscfg/string-attributes.c     | 3 ++-
 7 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
index 27fd6cd215290..768330d291da8 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
@@ -731,26 +731,31 @@ static int hp_init_bios_package_attribute(enum hp_wmi_data_type attr_type,
 	switch (attr_type) {
 	case HPWMI_STRING_TYPE:
 		ret = hp_populate_string_package_data(elements,
+						      obj->package.count,
 						      instance_id,
 						      attr_name_kobj);
 		break;
 	case HPWMI_INTEGER_TYPE:
 		ret = hp_populate_integer_package_data(elements,
+						       obj->package.count,
 						       instance_id,
 						       attr_name_kobj);
 		break;
 	case HPWMI_ENUMERATION_TYPE:
 		ret = hp_populate_enumeration_package_data(elements,
+							   obj->package.count,
 							   instance_id,
 							   attr_name_kobj);
 		break;
 	case HPWMI_ORDERED_LIST_TYPE:
 		ret = hp_populate_ordered_list_package_data(elements,
+							    obj->package.count,
 							    instance_id,
 							    attr_name_kobj);
 		break;
 	case HPWMI_PASSWORD_TYPE:
 		ret = hp_populate_password_package_data(elements,
+							obj->package.count,
 							instance_id,
 							attr_name_kobj);
 		break;
diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.h b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.h
index f1eec0e4ba075..416d7e7aaaae3 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.h
+++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.h
@@ -401,6 +401,7 @@ int hp_populate_string_buffer_data(u8 *buffer_ptr, u32 *buffer_size,
 int hp_alloc_string_data(void);
 void hp_exit_string_attributes(void);
 int hp_populate_string_package_data(union acpi_object *str_obj,
+				    int str_obj_count,
 				    int instance_id,
 				    struct kobject *attr_name_kobj);
 
@@ -411,6 +412,7 @@ int hp_populate_integer_buffer_data(u8 *buffer_ptr, u32 *buffer_size,
 int hp_alloc_integer_data(void);
 void hp_exit_integer_attributes(void);
 int hp_populate_integer_package_data(union acpi_object *integer_obj,
+				     int integer_obj_count,
 				     int instance_id,
 				     struct kobject *attr_name_kobj);
 
@@ -421,6 +423,7 @@ int hp_populate_enumeration_buffer_data(u8 *buffer_ptr, u32 *buffer_size,
 int hp_alloc_enumeration_data(void);
 void hp_exit_enumeration_attributes(void);
 int hp_populate_enumeration_package_data(union acpi_object *enum_obj,
+					 int enum_obj_count,
 					 int instance_id,
 					 struct kobject *attr_name_kobj);
 
@@ -432,6 +435,7 @@ int hp_populate_ordered_list_buffer_data(u8 *buffer_ptr,
 int hp_alloc_ordered_list_data(void);
 void hp_exit_ordered_list_attributes(void);
 int hp_populate_ordered_list_package_data(union acpi_object *order_obj,
+					  int order_obj_count,
 					  int instance_id,
 					  struct kobject *attr_name_kobj);
 
@@ -440,6 +444,7 @@ int hp_populate_password_buffer_data(u8 *buffer_ptr, u32 *buffer_size,
 				     int instance_id,
 				     struct kobject *attr_name_kobj);
 int hp_populate_password_package_data(union acpi_object *password_obj,
+				      int password_obj_count,
 				      int instance_id,
 				      struct kobject *attr_name_kobj);
 int hp_alloc_password_data(void);
diff --git a/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
index af4d1920d4880..3aa2c440e0528 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
@@ -304,6 +304,7 @@ static int hp_populate_enumeration_elements_from_package(union acpi_object *enum
  * @attr_name_kobj: The parent kernel object
  */
 int hp_populate_enumeration_package_data(union acpi_object *enum_obj,
+					 int enum_obj_count,
 					 int instance_id,
 					 struct kobject *attr_name_kobj)
 {
@@ -312,7 +313,7 @@ int hp_populate_enumeration_package_data(union acpi_object *enum_obj,
 	enum_data->attr_name_kobj = attr_name_kobj;
 
 	hp_populate_enumeration_elements_from_package(enum_obj,
-						      enum_obj->package.count,
+						      enum_obj_count,
 						      instance_id);
 	hp_update_attribute_permissions(enum_data->common.is_readonly,
 					&enumeration_current_val);
diff --git a/drivers/platform/x86/hp/hp-bioscfg/int-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/int-attributes.c
index d96e160953e39..107e4cf1efb8a 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/int-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/int-attributes.c
@@ -279,6 +279,7 @@ static int hp_populate_integer_elements_from_package(union acpi_object *integer_
  * @attr_name_kobj: The parent kernel object
  */
 int hp_populate_integer_package_data(union acpi_object *integer_obj,
+				     int integer_obj_count,
 				     int instance_id,
 				     struct kobject *attr_name_kobj)
 {
@@ -286,7 +287,7 @@ int hp_populate_integer_package_data(union acpi_object *integer_obj,
 
 	integer_data->attr_name_kobj = attr_name_kobj;
 	hp_populate_integer_elements_from_package(integer_obj,
-						  integer_obj->package.count,
+						  integer_obj_count,
 						  instance_id);
 	hp_update_attribute_permissions(integer_data->common.is_readonly,
 					&integer_current_val);
diff --git a/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
index f09489a085c86..83ddf99f93954 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
@@ -301,7 +301,8 @@ static int hp_populate_ordered_list_elements_from_package(union acpi_object *ord
  * @instance_id: The instance to enumerate
  * @attr_name_kobj: The parent kernel object
  */
-int hp_populate_ordered_list_package_data(union acpi_object *order_obj, int instance_id,
+int hp_populate_ordered_list_package_data(union acpi_object *order_obj, int order_obj_count,
+					  int instance_id,
 					  struct kobject *attr_name_kobj)
 {
 	struct ordered_list_data *ordered_list_data = &bioscfg_drv.ordered_list_data[instance_id];
@@ -309,7 +310,7 @@ int hp_populate_ordered_list_package_data(union acpi_object *order_obj, int inst
 	ordered_list_data->attr_name_kobj = attr_name_kobj;
 
 	hp_populate_ordered_list_elements_from_package(order_obj,
-						       order_obj->package.count,
+						       order_obj_count,
 						       instance_id);
 	hp_update_attribute_permissions(ordered_list_data->common.is_readonly,
 					&ordered_list_current_val);
diff --git a/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
index 4d79eb8056a5d..89316d90454d2 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
@@ -388,7 +388,8 @@ static int hp_populate_password_elements_from_package(union acpi_object *passwor
  * @instance_id: The instance to enumerate
  * @attr_name_kobj: The parent kernel object
  */
-int hp_populate_password_package_data(union acpi_object *password_obj, int instance_id,
+int hp_populate_password_package_data(union acpi_object *password_obj, int password_obj_count,
+				      int instance_id,
 				      struct kobject *attr_name_kobj)
 {
 	struct password_data *password_data = &bioscfg_drv.password_data[instance_id];
@@ -396,7 +397,7 @@ int hp_populate_password_package_data(union acpi_object *password_obj, int insta
 	password_data->attr_name_kobj = attr_name_kobj;
 
 	hp_populate_password_elements_from_package(password_obj,
-						   password_obj->package.count,
+						   password_obj_count,
 						   instance_id);
 
 	hp_friendly_user_name_update(password_data->common.path,
diff --git a/drivers/platform/x86/hp/hp-bioscfg/string-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/string-attributes.c
index fe5a9a3a4ef17..da5e81f1d188f 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/string-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/string-attributes.c
@@ -267,6 +267,7 @@ static int hp_populate_string_elements_from_package(union acpi_object *string_ob
  * @attr_name_kobj: The parent kernel object
  */
 int hp_populate_string_package_data(union acpi_object *string_obj,
+				    int string_obj_count,
 				    int instance_id,
 				    struct kobject *attr_name_kobj)
 {
@@ -275,7 +276,7 @@ int hp_populate_string_package_data(union acpi_object *string_obj,
 	string_data->attr_name_kobj = attr_name_kobj;
 
 	hp_populate_string_elements_from_package(string_obj,
-						 string_obj->package.count,
+						 string_obj_count,
 						 instance_id);
 
 	hp_update_attribute_permissions(string_data->common.is_readonly,
-- 
2.55.0

