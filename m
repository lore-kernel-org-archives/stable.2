Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0D4426D0E;
	Wed,  8 Jul 2026 10:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783508095; cv=none; b=ZONx7vduuForDyX1kh72CgjldCC2UJQx41Pd4DlsQxcNNe1HLYm5xiKlXu0jxuccGoAlCjoLONMA5zeWE+OiyKT58zFVPNOIUusU6YU5je/QcEzdcE2Vg8k/ECuLNZ8++XZnojvmJuCUuu6LzQ+NAR1ZWXkEKJIzjGYBqaRCZkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783508095; c=relaxed/simple;
	bh=o9qbMTOJovTkmlO49HgJ0zWOjloIdSUzeHDdq6PoHz4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=no7aOkqzngfzwluCVRqWgM1kUYuUUT4C3+1GegREc50WNy73sZdYYFlI3WckCImI74cB4uYj2wty/9DWLN6q445U+mrrfpXOPvgw8KunRSK0LuRoa/ruPVxtjihL3ygVmx+T7lz1UuokyD6cgikbxrpXWusT3KwdnvWd4oxu/ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WvxI76E/; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WvxI76E/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783508090; x=1815044090;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=o9qbMTOJovTkmlO49HgJ0zWOjloIdSUzeHDdq6PoHz4=;
  b=WvxI76E/tCUmaFCKGnr2kHx/gZh5R1moq21dNkhExgNHmqOknzLobMfX
   eOMv63+W1LueOc3QdC90mh9acmHJZbSjY0SMNq26MKLMIyCcBrYu8hzoD
   JsvgBVjHjGBaskXB6sl+yfoOz5hApF+C8x/kvcN/AIuBYo9kEw98IPpUf
   rphD5HWCMTEheDL9Y6xDeO4UMHwHK7enEUZjFXX8A94fck65iGjyNotiC
   cXOo3e1lNL6UHJKyy5rWUnXErjm6r9Zi1S+uxNs838MbqKVqX8CmttUWI
   vY3BI+niwKvOsKFgl9JLjHniWhHdJyrnHmXFQFdETuP+2bjIT6fu/wTNH
   A==;
X-CSE-ConnectionGUID: 7GAzyJSvQ32AVK+EkRn+mg==
X-CSE-MsgGUID: f6XfBeHGT5SK++sBndT4cw==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="84041230"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="84041230"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 03:54:40 -0700
X-CSE-ConnectionGUID: q6gHeQYfSVy11zqX79z7qw==
X-CSE-MsgGUID: hvQ7NmLtS3WMPQc8f2Trnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="284368889"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.169])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 03:54:35 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 8 Jul 2026 13:54:12 +0300 (EEST)
To: Muhammad Bilal <meatuni001@gmail.com>
cc: platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    hdegoede@redhat.com, jorge.lopez2@hp.com, Thomas.Weissschuh@linutronix.de, 
    superm1@kernel.org, W_Armin@gmx.de, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/4] platform/x86: hp-bioscfg: pass validated element
 count to package parsers
In-Reply-To: <20260707202111.35414-2-meatuni001@gmail.com>
Message-ID: <ab5eab16-8156-d3b1-06e4-072cf5807422@linux.intel.com>
References: <20260707202111.35414-1-meatuni001@gmail.com> <20260707202111.35414-2-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 8 Jul 2026, Muhammad Bilal wrote:

> The per-type package parsers are handed the wrong element count.
> 
> hp_init_bios_package_attribute() validates obj->package.count and then
> calls one of the five hp_populate_*_package_data() wrappers (string,
> integer, enumeration, ordered list, password). Each wrapper forwards a
> count to its hp_populate_*_elements_from_package() parser, but instead
> of forwarding the validated obj->package.count it derives the count
> from elements[0]. elements[0] is the NAME field and is always an
> ACPI_TYPE_STRING, so reading ->package.count from it in fact reads
> ->string.length through the union acpi_object. The parsers thus bound
> themselves against the length of the name string rather than against
> the real number of elements in the package.
> 
> This is safe today because hp_init_bios_package_attribute() refuses any
> package that has fewer than the type's element count, so a parser only
> ever runs on a full package and never reads past it regardless of the
> bogus bound.
> 
> A later patch relaxes that check to accept shorter packages. Once a

A later patch -> An upcoming change

This is because once a patch is accepted, it becomes "commit" or "change", 
it no longer is patch. 

I probably explained it already once (but there have been multiple 
submitters with this same wrong phrasing recently so I might confuse 
people, I'm sorry about that if I did).

> parser can receive fewer elements than its per-type count, a bound
> taken from the name length no longer reflects the array size, and the
> "elem < count" loop conditions and "elem + n >= count" sub-loop guards
> read past the end of elements[] - an out-of-bounds heap read.
> 
> Forward the validated obj->package.count to every *_package_data()
> wrapper so the parsers bound themselves against the real package size.
> This does not change behaviour for the packages that enumerate
> correctly today and is a prerequisite for accepting shorter packages
> safely.
> 
> Fixes: a34fc329b189 ("platform/x86: hp-bioscfg: bioscfg")

Technically, this doesn't yet fix anything and stable people know to take 
dependencies from the same series as long as you've the Cc stable in 
place. So this Fixes tag can be dropped.

> Cc: stable@vger.kernel.org
> Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
> ---
>  drivers/platform/x86/hp/hp-bioscfg/bioscfg.c               | 5 +++++
>  drivers/platform/x86/hp/hp-bioscfg/bioscfg.h               | 5 +++++
>  drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c       | 3 ++-
>  drivers/platform/x86/hp/hp-bioscfg/int-attributes.c        | 3 ++-
>  drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c | 5 +++--
>  drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c  | 5 +++--
>  drivers/platform/x86/hp/hp-bioscfg/string-attributes.c     | 3 ++-
>  7 files changed, 22 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
> index 27fd6cd215290..768330d291da8 100644
> --- a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
> +++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
> @@ -731,26 +731,31 @@ static int hp_init_bios_package_attribute(enum hp_wmi_data_type attr_type,
>  	switch (attr_type) {
>  	case HPWMI_STRING_TYPE:
>  		ret = hp_populate_string_package_data(elements,
> +						      obj->package.count,
>  						      instance_id,
>  						      attr_name_kobj);
>  		break;
>  	case HPWMI_INTEGER_TYPE:
>  		ret = hp_populate_integer_package_data(elements,
> +						       obj->package.count,
>  						       instance_id,
>  						       attr_name_kobj);
>  		break;
>  	case HPWMI_ENUMERATION_TYPE:
>  		ret = hp_populate_enumeration_package_data(elements,
> +							   obj->package.count,
>  							   instance_id,
>  							   attr_name_kobj);
>  		break;
>  	case HPWMI_ORDERED_LIST_TYPE:
>  		ret = hp_populate_ordered_list_package_data(elements,
> +							    obj->package.count,
>  							    instance_id,
>  							    attr_name_kobj);
>  		break;
>  	case HPWMI_PASSWORD_TYPE:
>  		ret = hp_populate_password_package_data(elements,
> +							obj->package.count,
>  							instance_id,
>  							attr_name_kobj);
>  		break;
> diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.h b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.h
> index f1eec0e4ba075..416d7e7aaaae3 100644
> --- a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.h
> +++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.h
> @@ -401,6 +401,7 @@ int hp_populate_string_buffer_data(u8 *buffer_ptr, u32 *buffer_size,
>  int hp_alloc_string_data(void);
>  void hp_exit_string_attributes(void);
>  int hp_populate_string_package_data(union acpi_object *str_obj,
> +				    int str_obj_count,
>  				    int instance_id,
>  				    struct kobject *attr_name_kobj);
>  
> @@ -411,6 +412,7 @@ int hp_populate_integer_buffer_data(u8 *buffer_ptr, u32 *buffer_size,
>  int hp_alloc_integer_data(void);
>  void hp_exit_integer_attributes(void);
>  int hp_populate_integer_package_data(union acpi_object *integer_obj,
> +				     int integer_obj_count,
>  				     int instance_id,
>  				     struct kobject *attr_name_kobj);
>  
> @@ -421,6 +423,7 @@ int hp_populate_enumeration_buffer_data(u8 *buffer_ptr, u32 *buffer_size,
>  int hp_alloc_enumeration_data(void);
>  void hp_exit_enumeration_attributes(void);
>  int hp_populate_enumeration_package_data(union acpi_object *enum_obj,
> +					 int enum_obj_count,
>  					 int instance_id,
>  					 struct kobject *attr_name_kobj);
>  
> @@ -432,6 +435,7 @@ int hp_populate_ordered_list_buffer_data(u8 *buffer_ptr,
>  int hp_alloc_ordered_list_data(void);
>  void hp_exit_ordered_list_attributes(void);
>  int hp_populate_ordered_list_package_data(union acpi_object *order_obj,
> +					  int order_obj_count,
>  					  int instance_id,
>  					  struct kobject *attr_name_kobj);
>  
> @@ -440,6 +444,7 @@ int hp_populate_password_buffer_data(u8 *buffer_ptr, u32 *buffer_size,
>  				     int instance_id,
>  				     struct kobject *attr_name_kobj);
>  int hp_populate_password_package_data(union acpi_object *password_obj,
> +				      int password_obj_count,
>  				      int instance_id,
>  				      struct kobject *attr_name_kobj);
>  int hp_alloc_password_data(void);
> diff --git a/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
> index af4d1920d4880..3aa2c440e0528 100644
> --- a/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
> +++ b/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
> @@ -304,6 +304,7 @@ static int hp_populate_enumeration_elements_from_package(union acpi_object *enum
>   * @attr_name_kobj: The parent kernel object
>   */
>  int hp_populate_enumeration_package_data(union acpi_object *enum_obj,
> +					 int enum_obj_count,
>  					 int instance_id,
>  					 struct kobject *attr_name_kobj)
>  {
> @@ -312,7 +313,7 @@ int hp_populate_enumeration_package_data(union acpi_object *enum_obj,
>  	enum_data->attr_name_kobj = attr_name_kobj;
>  
>  	hp_populate_enumeration_elements_from_package(enum_obj,
> -						      enum_obj->package.count,
> +						      enum_obj_count,
>  						      instance_id);
>  	hp_update_attribute_permissions(enum_data->common.is_readonly,
>  					&enumeration_current_val);
> diff --git a/drivers/platform/x86/hp/hp-bioscfg/int-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/int-attributes.c
> index d96e160953e39..107e4cf1efb8a 100644
> --- a/drivers/platform/x86/hp/hp-bioscfg/int-attributes.c
> +++ b/drivers/platform/x86/hp/hp-bioscfg/int-attributes.c
> @@ -279,6 +279,7 @@ static int hp_populate_integer_elements_from_package(union acpi_object *integer_
>   * @attr_name_kobj: The parent kernel object
>   */
>  int hp_populate_integer_package_data(union acpi_object *integer_obj,
> +				     int integer_obj_count,
>  				     int instance_id,
>  				     struct kobject *attr_name_kobj)
>  {
> @@ -286,7 +287,7 @@ int hp_populate_integer_package_data(union acpi_object *integer_obj,
>  
>  	integer_data->attr_name_kobj = attr_name_kobj;
>  	hp_populate_integer_elements_from_package(integer_obj,
> -						  integer_obj->package.count,
> +						  integer_obj_count,
>  						  instance_id);
>  	hp_update_attribute_permissions(integer_data->common.is_readonly,
>  					&integer_current_val);
> diff --git a/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
> index f09489a085c86..83ddf99f93954 100644
> --- a/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
> +++ b/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
> @@ -301,7 +301,8 @@ static int hp_populate_ordered_list_elements_from_package(union acpi_object *ord
>   * @instance_id: The instance to enumerate
>   * @attr_name_kobj: The parent kernel object
>   */
> -int hp_populate_ordered_list_package_data(union acpi_object *order_obj, int instance_id,
> +int hp_populate_ordered_list_package_data(union acpi_object *order_obj, int order_obj_count,
> +					  int instance_id,
>  					  struct kobject *attr_name_kobj)
>  {
>  	struct ordered_list_data *ordered_list_data = &bioscfg_drv.ordered_list_data[instance_id];
> @@ -309,7 +310,7 @@ int hp_populate_ordered_list_package_data(union acpi_object *order_obj, int inst
>  	ordered_list_data->attr_name_kobj = attr_name_kobj;
>  
>  	hp_populate_ordered_list_elements_from_package(order_obj,
> -						       order_obj->package.count,
> +						       order_obj_count,
>  						       instance_id);
>  	hp_update_attribute_permissions(ordered_list_data->common.is_readonly,
>  					&ordered_list_current_val);
> diff --git a/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
> index 4d79eb8056a5d..89316d90454d2 100644
> --- a/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
> +++ b/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
> @@ -388,7 +388,8 @@ static int hp_populate_password_elements_from_package(union acpi_object *passwor
>   * @instance_id: The instance to enumerate
>   * @attr_name_kobj: The parent kernel object
>   */
> -int hp_populate_password_package_data(union acpi_object *password_obj, int instance_id,
> +int hp_populate_password_package_data(union acpi_object *password_obj, int password_obj_count,
> +				      int instance_id,
>  				      struct kobject *attr_name_kobj)
>  {
>  	struct password_data *password_data = &bioscfg_drv.password_data[instance_id];
> @@ -396,7 +397,7 @@ int hp_populate_password_package_data(union acpi_object *password_obj, int insta
>  	password_data->attr_name_kobj = attr_name_kobj;
>  
>  	hp_populate_password_elements_from_package(password_obj,
> -						   password_obj->package.count,
> +						   password_obj_count,
>  						   instance_id);
>  
>  	hp_friendly_user_name_update(password_data->common.path,
> diff --git a/drivers/platform/x86/hp/hp-bioscfg/string-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/string-attributes.c
> index fe5a9a3a4ef17..da5e81f1d188f 100644
> --- a/drivers/platform/x86/hp/hp-bioscfg/string-attributes.c
> +++ b/drivers/platform/x86/hp/hp-bioscfg/string-attributes.c
> @@ -267,6 +267,7 @@ static int hp_populate_string_elements_from_package(union acpi_object *string_ob
>   * @attr_name_kobj: The parent kernel object
>   */
>  int hp_populate_string_package_data(union acpi_object *string_obj,
> +				    int string_obj_count,
>  				    int instance_id,
>  				    struct kobject *attr_name_kobj)
>  {
> @@ -275,7 +276,7 @@ int hp_populate_string_package_data(union acpi_object *string_obj,
>  	string_data->attr_name_kobj = attr_name_kobj;
>  
>  	hp_populate_string_elements_from_package(string_obj,
> -						 string_obj->package.count,
> +						 string_obj_count,
>  						 instance_id);
>  
>  	hp_update_attribute_permissions(string_data->common.is_readonly,
> 

-- 
 i.

