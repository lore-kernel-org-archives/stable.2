Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0F9451988;
	Tue, 18 Aug 2026 11:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787052539; cv=none; b=KPSEu6lhgyyovCLFpFFjPG2c+W6Wr70smnpFqN9ms0DTo0tbClT5UkyghEdr2/bgsQpdngdkU68lmZTkvNCtX9XCjnjaX2KfvEwKEDYS2HdlWFOUfHjHd0D/VW0pvsn3+x+0s42ZAKN0fZHL+8l4lH8b/z7kHkmBXCfId4Tixxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787052539; c=relaxed/simple;
	bh=6mMGVYsJXpLKwTZA6X09wqiPlrAoEFFH3gh4Yyir/q4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Zpo5VOZlS0TXwBSNWrQPqQTS8LjwHMlyBhhHWtW4u+kDQioOENfHCT3n+CGI6g+HotekDr/TL4xUWE5XsxpPZ7kNM76dr4lPW3fxTLes8/DhuUNJzvyY2KevR0Q/wtLARQm4w5/tBVDuCMVFrP1+vRjvx4PoI7nFfFYvgIzNC9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mwRqegez; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mwRqegez"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787052538; x=1818588538;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=6mMGVYsJXpLKwTZA6X09wqiPlrAoEFFH3gh4Yyir/q4=;
  b=mwRqegezx/JH+6WKoCm0VNUDrMro5BX2Cj+wCRCsmhhzS+SZRJUj6k4e
   Ss03+42Z5vZMHQw2d8x99EDAKaPwKaowRw/q1fnRB8i9tEV9VXpwaAofI
   QQ3ngWwqElrle1Gk3RhqigBaZcADCaZWXWfagSBI5LrxoII9e+8qyzL41
   RidileVxKGlCZif+9D57/jYAz45eAhVHQxQadA1qQdi4lI5j8KzXmddAc
   mMffZYNDd5gpLb5V7eiZSEj7PYXuF6jy7+IS91eFlF5vFdVZlhx6T8jFV
   ApqdMNWI9laJLS0pBFA1uATD8UebSxE0KhyJMOMHJMn8OmUGknpwSwTnN
   g==;
X-CSE-ConnectionGUID: ZtiLg1EVQdqwrAsF2uJXMA==
X-CSE-MsgGUID: vOOhVVDaQQayOojfokptdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="87608966"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="87608966"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 04:28:57 -0700
X-CSE-ConnectionGUID: iv2/0hjhRZG6PZFL/s283A==
X-CSE-MsgGUID: FJqinRumQtCX13hLsqrvTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="259002624"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.38])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 04:28:54 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 18 Aug 2026 14:28:50 +0300 (EEST)
To: Thorsten Blum <thorsten.blum@linux.dev>
cc: Mark Pearson <mpearson-lenovo@squebb.ca>, 
    "Derek J. Clark" <derekjohn.clark@gmail.com>, 
    Hans de Goede <hansg@kernel.org>, stable@vger.kernel.org, 
    Mark Pearson <markpearson@lenovo.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] platform/x86: think-lmi: Fix current password length
 check
In-Reply-To: <20260813082049.41209-2-thorsten.blum@linux.dev>
Message-ID: <daeefbce-83f6-f161-71f5-38730fe9c9d5@linux.intel.com>
References: <20260813082049.41209-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 13 Aug 2026, Thorsten Blum wrote:

> current_password_store() checks the password length before removing the
> trailing newline, which can reject valid passwords that are exactly
> ->maxlen bytes long.
> 
> It also passes ->maxlen to strscpy(), which truncates passwords without
> a newline.
> 
> Use strchrnul() to measure the password length up to the newline, then
> copy that many bytes and add a trailing NUL terminator.
> 
> Fixes: a40cd7ef22fb ("platform/x86: think-lmi: Add WMI interface support on Lenovo platforms")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
> Changes in v2:
> - Keep and reword the newline comment
> - v1: https://lore.kernel.org/r/20260810132018.156868-3-thorsten.blum@linux.dev/
> ---
>  drivers/platform/x86/lenovo/think-lmi.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/x86/lenovo/think-lmi.c b/drivers/platform/x86/lenovo/think-lmi.c
> index e215e86e3db7..d0ceb6aaa69e 100644
> --- a/drivers/platform/x86/lenovo/think-lmi.c
> +++ b/drivers/platform/x86/lenovo/think-lmi.c
> @@ -438,14 +438,14 @@ static ssize_t current_password_store(struct kobject *kobj,
>  	struct tlmi_pwd_setting *setting = to_tlmi_pwd_setting(kobj);
>  	size_t pwdlen;
>  
> -	pwdlen = strlen(buf);
> +	/* Strip newline; setting password won't work if one is present. */
> +	pwdlen = strchrnul(buf, '\n') - buf;
>  	/* pwdlen == 0 is allowed to clear the password */
>  	if (pwdlen && ((pwdlen < setting->minlen) || (pwdlen > setting->maxlen)))
>  		return -EINVAL;
>  
> -	strscpy(setting->password, buf, setting->maxlen);
> -	/* Strip out CR if one is present, setting password won't work if it is present */
> -	strreplace(setting->password, '\n', '\0');
> +	memcpy(setting->password, buf, pwdlen);
> +	setting->password[pwdlen] = '\0';

Hi,

I don't understand why is this strscpy() -> memcpy() conversion required? 

Wouldn't it work with:

	strscpy(..., pwdlen);

?

strscpy() forces NUL termination and there shouldn't be any NULs or 
newlines before pwdlen.

-- 
 i.

