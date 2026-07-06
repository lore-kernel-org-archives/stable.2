Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDDE233926;
	Mon,  6 Jul 2026 17:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783360625; cv=none; b=ArkKiB5NWF1CeulNg6ZkEeLrp2gGE7USnT8EDX0aEDvfx6eUhBcszgHy2A6sSV2Npn0oW11ByBhz8Yh5F/1EVuDlGCbJ5Yt471uIUTDItObShcQj/c3f40T7UREb8vCRN8c+iGSmvJxiGgRzb9zN2MkxgKOcckVcAS1WyNYA0V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783360625; c=relaxed/simple;
	bh=9EtTQqtlKqor23TbochBY+WhtH4X0sWSJyZA6RPDVkY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Ns8fTCs7lcQU9XEdf/KVUstj31Kplgd8ui72N5NFGiA42meIJqqsxTqGJL3+llNAoWy3lk2kgvVd9racu4YM+EFpIpkQ+tUUemd80fE+QZhTHtVBngREle5uEJVs0XpPQOR4UQnloWAG51qXPh3Jq7u6tLNe2SuBc4lF40X7FP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uma6+97Y; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uma6+97Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783360624; x=1814896624;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=9EtTQqtlKqor23TbochBY+WhtH4X0sWSJyZA6RPDVkY=;
  b=Uma6+97YfHUdXxcE6IlvKbD2CbByfHJSWxexEJ3HF3a50wDdo7/9YC9w
   W+SkHtt8rxkCGMEuliJC0Jn1yFedvsTulA5X/M83mHImmIAOjotAZZ5zZ
   TH2iTAb6t2Q28vrZraT/C1XSVHgntH0IC0QjlpWBqeGYDFx+B6pfPVt05
   SONpev3E4ms/ttck0MHmeEpJtPNAMt+xInhrXEdrn/lcmqJ9ckS0NsyZy
   iSNgUzoZ6TX/dlQXdNZnWblwIl/zu7ei3QAPtdjDh7yHeanZo8cZNSu7C
   YHeLQsZvis4rLbiwsVKrYmzmd23/2hhF6YdcSSDyuxQbptFoK6YlDnKC9
   Q==;
X-CSE-ConnectionGUID: yOpDpqWuRSy2nmAR657gNA==
X-CSE-MsgGUID: ECwS0x7bQ7aEkOm3U+CcGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11839"; a="84028224"
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="84028224"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 10:57:03 -0700
X-CSE-ConnectionGUID: P6qyeEThT5aLi+vbNKdqOA==
X-CSE-MsgGUID: CJ3B++98Ss637+7urqK/vA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="258697478"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.95])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 10:56:58 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 6 Jul 2026 20:56:54 +0300 (EEST)
To: Muhammad Bilal <meatuni001@gmail.com>
cc: hdegoede@redhat.com, jorge.lopez2@hp.com, Thomas.Weissschuh@linutronix.de, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    stable@vger.kernel.org, Mario Limonciello <superm1@kernel.org>, 
    Armin Wolf <W_Armin@gmx.de>
Subject: Re: [PATCH v2 1/3] platform/x86: hp-bioscfg: pass validated element
 count to package parsers
In-Reply-To: <20260704160759.236249-2-meatuni001@gmail.com>
Message-ID: <66b8977e-edd1-242d-1715-d5fe7f11f244@linux.intel.com>
References: <20260704160759.236249-1-meatuni001@gmail.com> <20260704160759.236249-2-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 4 Jul 2026, Muhammad Bilal wrote:

> hp_init_bios_package_attribute() validates obj->package.count against
> min_elements and then hands off elements = obj->package.elements to

quoting elements = obj->package.elements statement in this context is 
confusing. I don't think it's usually necessary to copy code like this to 
changelog, here you can just state "elements" (which even happens to match 
the struct member's name even).

> one of the five per-type hp_populate_*_package_data() wrappers
> (string, integer, enumeration, ordered list, password). None of these
> wrappers receive that validated count. Instead each one re-derives it
> locally:
> 
>   hp_populate_integer_elements_from_package(integer_obj,
>                                             integer_obj->package.count,
>                                             instance_id);
> 
> integer_obj here is elements, i.e. a pointer to elements[0] (the NAME
> field, always ACPI_TYPE_STRING). Reading ->package.count off a string
> object aliases ->string.length in the underlying union acpi_object, so
> the "count" passed down is not the real package size at all.

Only at this point you're actually telling what the problem is.

My suggestion is to rewrite this so that you start by telling that wrong 
size (count) is read and passed on by these functions (sort of summary of 
the problem). Then explain what caused that.

> For string, integer, enumeration and password attributes,
> hp_populate_*_elements_from_package() bounds its iteration using the
> corresponding per-type ELEM_CNT constant (STR_ELEM_CNT,
> INT_ELEM_CNT, ENUM_ELEM_CNT and PSWD_ELEM_CNT). This relies on
> hp_init_bios_package_attribute() rejecting packages with fewer than
> ELEM_CNT elements before invoking the parsers.
> 
> Relaxing that check would allow shorter packages to reach these
> functions, making the fixed loop bounds unsafe.

??

You might be doing this in some later patch but then you should say 
that an upcoming patch is going to relax this check, otherwise it comes 
out of nowhere.

So I think you're trying to solve two cases here:

1) Passing wrong count.
2) Allowing count less than what those consts define (but this is only 
needed for some later patch?).

But it's so that fixing 1 ends up also solving 2? I think the changelog 
should mostly focus on 1 and then only state in the end that it also
prepares for an upcoming change that requires supporting 2.

> hp_populate_ordered_list_elements_from_package() doesn't even use the
> count for its main loop bound - it iterates unconditionally up to
> ORD_ELEM_CNT:
> 
>   for (elem = 1, eloc = 1; eloc < ORD_ELEM_CNT; elem++, eloc++)
> 
> which relies entirely on the same coincidence.
> 
> This is only safe as long as every caller is guaranteed to hand these
> functions a package with at least ELEM_CNT real elements. A following
> change relaxes that guarantee to allow shorter packages through, which
> would turn this into a real out-of-bounds heap read of the
> elements[] array once the real count drops below the fixed ELEM_CNT
> loop bound.
> 
> Fix this at the source: thread the real, already-validated
> obj->package.count down through each *_package_data() wrapper instead

"thread down" sounds odd to my (non-native) ear in this context.

each *_package_data() wrapper -> *_package_data() wrappers

> of letting the per-type code guess at it, and use it to also bound

"guess at it" sounds odd to my ear and is now even correct given your 
explanation of the problem.

> hp_populate_ordered_list_elements_from_package()'s main loop.

> This is a
> no-op for any package that already meets the existing ELEM_CNT
> minimums, and is a prerequisite for safely accepting shorter packages.
> 
> Fixes: a34fc329b189 ("platform/x86: hp-bioscfg: bioscfg")
> Cc: stable@vger.kernel.org
> Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
> ---
>  drivers/platform/x86/hp/hp-bioscfg/bioscfg.c               | 5 +++++
>  drivers/platform/x86/hp/hp-bioscfg/bioscfg.h               | 5 +++++
>  drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c       | 3 ++-
>  drivers/platform/x86/hp/hp-bioscfg/int-attributes.c        | 3 ++-
>  drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c | 7 ++++---
>  drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c  | 5 +++--
>  drivers/platform/x86/hp/hp-bioscfg/string-attributes.c     | 3 ++-
>  7 files changed, 23 insertions(+), 8 deletions(-)
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
> index f09489a085c86..a50d074125268 100644
> --- a/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
> +++ b/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
> @@ -145,7 +145,7 @@ static int hp_populate_ordered_list_elements_from_package(union acpi_object *ord
>  	if (!order_obj)
>  		return -EINVAL;
>  
> -	for (elem = 1, eloc = 1; eloc < ORD_ELEM_CNT; elem++, eloc++) {
> +	for (elem = 1, eloc = 1; eloc < ORD_ELEM_CNT && elem < order_obj_count; elem++, eloc++) {

This looks like a separate fix belonging to own patch. It allows you also 
to write more focused changelog text for each patch.

>  
>  		switch (order_obj[elem].type) {
>  		case ACPI_TYPE_STRING:
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

