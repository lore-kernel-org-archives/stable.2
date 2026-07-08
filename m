Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EA0409266
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 15:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783525737; cv=none; b=a81Kb7jsswiLdj/wYLzKP7uaI31cPM7XUtiz1VNP4ySN651UoG8RVPVgcUO2adt+LL3vTJk1XYUbpdShPmLZ7cUOlI0hUuQ3+TdO59yP1JhZkfImNRjzXKwtUlBGg8L97BqJxMsOfsyhbgQaNADkxLlj2yu/YMsp83Sqyo/xNC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783525737; c=relaxed/simple;
	bh=uvwChTlpVZgmp2VBtDJWKXkefk6EFCfg7e+Nt53HS8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CNYk1ID+ezR3gJf0jmF2Nv6dOzH5PBz6JomqT5Tvdv19mqvroa03c8Ex6KSEouolPOdWGB7nxOwP/U8MVTFhG4n2bVptPradw5b9KznWMSWZMtUze6JKlO43MXryAWnoNBxZ2BX6g3qxsCtbG+SmJ66x4K9Jd/xRyWoWeVQqCGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/Kn2k8f; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/Kn2k8f"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6974a6e54dbso1383309a12.2
        for <stable@vger.kernel.org>; Wed, 08 Jul 2026 08:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783525734; x=1784130534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6TK4yrvOlGIeZ2P4todUYjrSWgXjYBLmh88a3Xdkwsc=;
        b=E/Kn2k8f7nJYKh3/4L/vTyyG9rbzu3yIF9IERPxBJBJJmBV4s2UzkJBkFItFEpC86A
         MiQiG20W5DGYz1cvvUEXAxr2pr+dFaC7AloXplIRSkzfOGasLR9ZSZlwkafFlV4PUBW3
         XPpkhVAKXyUSZuJmiLVffL7puXgrd8ewvEsMyti6LC1YfhOQFO4fcOSUGn+w4Ma05nlF
         zg+RG1j9uHiTvSrXVfD6aSGXEQ6jQXUmPLuAcZe9r3iJCAnnEHCzRoThWn92B86/3VrT
         kuEiW0Gn1GEXZT0nGHEDMMbZgNPI/AkS1E4y0fY7x63MEgFhbvC416MKqFz0gf9Ulqa1
         HciQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783525734; x=1784130534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6TK4yrvOlGIeZ2P4todUYjrSWgXjYBLmh88a3Xdkwsc=;
        b=i7PTvDWS+eB9FCAiLbV2jl+NTA8Cb9/10mKxQ+XJuV7DYSxR/sTVom5uxjM6xMscme
         M0S1xcaBkCD5izTMeBdl0wE7sTN64tteYeX5RMRqbfk8LFohGzo7S1QZvwr70pzA9jGp
         xCEgR0xtGBNIGGV12suYj+ErTOKf2qrTr+F4ugeI5ehGczqDDxC8bAKCvXlTPyeG9Qd5
         nnfktmldgyF7lR2ks0s0GFwn2QmC5Wzd5WNzWUy5Rqt/yBuLHSg94/blINxExn9cwNcd
         H7O2RW8ECGP8GSf8E3CoRBKKNGvGGL0b+mncQ1ik1thyT27jFYjyJvR+Q3BGMNUyCwoR
         E64A==
X-Gm-Message-State: AOJu0YzQyXDHkSEQqmj9+RuG/kfUOSE2Bennym6KtLo5BzGJCNS60wJA
	ivODhfb6bl1GxBYEaKWEdm/+qRQGsiqgI45xF7nP8x4B2jeypqMhILj3
X-Gm-Gg: AfdE7cnjrv1dENvVvXmhV0gfHsOHjIzwaBauvn3GoUGCoYGulMYIEhvJQhhxwngBl2Q
	5XsDrwa0Ob9j1kgaTaKIXcf/yrJ/fXGVy4tySDDX2vP9TjgJk3v5hwL+gZSUdlbmLtVHs3fuATx
	bgL4COjf9YiSeuISdLCmfl8WlCLiBEm+Wjr3av51/UQflAc9LWQz561pBRSkJWkWPH1kTf8IcES
	UI3dVh2dKF+X2f652ALDOEBVswKH1sl7VdrGr+Y9xWQ2PS0JcPWKQpNW66VMkv3EGhMVvjYisbw
	oxZdWYslHJ5EBmjlMVKKZ0AJfbBEd6g3kv5Pj09nB4MlxQ3ElDOUTltaMiy4t3AjexUjJD4y2be
	fNNczWftf5RD5QN09p1NlKJ3GJ3AfkX7VQLyHoXtCbcAGArZxIo4mwyyh9ilvWHjuwx7sbPC8A8
	fKTI8Jv7PYUAGHBWmEKUu+p3GwA1jJRmac51WOtnrQ4acEfj96uTTevyb496yDedY=
X-Received: by 2002:a05:6402:e85:b0:687:7fa4:faa0 with SMTP id 4fb4d7f45d1cf-69ab449f3bdmr1242683a12.23.1783525733893;
        Wed, 08 Jul 2026 08:48:53 -0700 (PDT)
Received: from node ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69ac41d7ceesm945125a12.23.2026.07.08.08.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 08:48:53 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	jorge.lopez2@hp.com,
	linux@weissschuh.net,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Mario Limonciello <superm1@kernel.org>,
	Armin Wolf <W_Armin@gmx.de>,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH v4 1/4] platform/x86: hp-bioscfg: pass validated element count to package parsers
Date: Wed,  8 Jul 2026 20:48:42 +0500
Message-ID: <20260708154846.12356-2-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260708154846.12356-1-meatuni001@gmail.com>
References: <20260708154846.12356-1-meatuni001@gmail.com>
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

An upcoming change relaxes that check to accept shorter packages. Once
a parser can receive fewer elements than its per-type count, a bound
taken from the name length no longer reflects the array size, and the
"elem < count" loop conditions and "elem + n >= count" sub-loop guards
read past the end of elements[] - an out-of-bounds heap read.

Forward the validated obj->package.count to every *_package_data()
wrapper so the parsers bound themselves against the real package size.
This does not change behaviour for the packages that enumerate
correctly today and is a prerequisite for accepting shorter packages
safely.

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

