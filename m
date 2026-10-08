Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE5C448BAC;
	Thu,  8 Oct 2026 12:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791462158; cv=none; b=fYgD9AvOvlUlr6ci6xOe7Y0c8wjd7i1eReUwRTp+4sU3aNiqMph6RQ6MfAktNBBbMUBkYk7lFWKPFOLM7IHYPHHdx3kqe2KfYPsSFKNPAKcmFxC2DV5SOIuCE3dJ4n7eGWF3FkZy20rZR1p482dkKN4d8y7+CxXHpFDzoV6j4P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791462158; c=relaxed/simple;
	bh=dvlWwHCm/4ja7KPmp7PB6HF8tJSJAziBERiHZoCInYo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=fnsoxSh/3ke4otIWRtBqfQNRdBEfWlPE/3wFpcsOBumXAr8sWITjgoji0sq045vo+GV9X6RM7Gen8AXJ6M86hW7ULr7XvBbbNlkOi5B3acdGKAoUxjJTYx3J/ssAc81ML8QsdKDgs+QlA5uha4X8DGFoUpoRUj+7BFyRm9m3LUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EbN5RxH6; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EbN5RxH6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791462156; x=1822998156;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=dvlWwHCm/4ja7KPmp7PB6HF8tJSJAziBERiHZoCInYo=;
  b=EbN5RxH6HfBDjiTb5ImnoSZmCx/+3h0WyOyXQkLS1eFsgn3lDeaqR6xi
   /k6TqO6A0LzFJIO2Ryi86jtLJz61AgO2t3c01gbj1FN20/f5j2NiBlDHl
   jC5OrxOGabsQJgXDFBI15+vL3fxM+Z+Gd5NWLdMKYg0COwajhVlfT7I8e
   7ACqX049SfuGFuMTWe+2ZqKkmdr9IrX/LQrVhah/aLRvxd3KzVtuG5Tgp
   aDSHo7mIUIZdOP1HSmD+lhEwzt/JfrtzsWkCrV6JEswJf4EswRj7Zz1Td
   BzZWJYfJjUSZWRkmHYVUdEt2SfeiIlPWDSZvmg7jGTZ/dJJRqRVm42Oje
   Q==;
X-CSE-ConnectionGUID: JjQrTkG+RcqFrnvVhpNiyg==
X-CSE-MsgGUID: DUe7r3PXRGqYLDUAl3sE4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="141189"
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="141189"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 05:22:35 -0700
X-CSE-ConnectionGUID: rT6aSBc0T/ynEgQ1xZpcZg==
X-CSE-MsgGUID: pMIukLpsRw6DlTATjlqZUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="348614"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.140])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 05:22:33 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 8 Oct 2026 15:22:29 +0300 (EEST)
To: Bartu Alev <bartualev@gmail.com>
cc: platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    Hans de Goede <hansg@kernel.org>, "Luke D . Jones" <luke@ljones.dev>, 
    Denis Benato <benato.denis96@gmail.com>, stable@vger.kernel.org, 
    Denis Benato <denis.benato@linux.dev>
Subject: Re: [PATCH v2 1/2] platform/x86: asus-wmi: fix TUF keyboard power
 state shutdown naming
In-Reply-To: <20260926005625.171560-2-bartualev@gmail.com>
Message-ID: <3d7a74f7-a092-3ffe-ca6a-6daaba3accfd@linux.intel.com>
References: <20260925200744.129714-1-bartualev@gmail.com> <20260926005625.171560-1-bartualev@gmail.com> <20260926005625.171560-2-bartualev@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 26 Sep 2026, Bartu Alev wrote:

> The fourth state flag of kbd_rgb_state_index is currently named
> "keyboard" and was historically assumed to have no effect. In hardware,
> this bit (BIT(7) in the WMI DEVS payload) gates whether the keyboard
> backlight remains illuminated during the ACPI S5 power-off sequence.
> 
> Hardware A/B testing on ASUS TUF Gaming A15 (FA507NV) confirms that
> setting this bit causes the keyboard to light up white upon power-off,
> while clearing it ensures a dark, clean shutdown.
> 
> Relabel this field from "keyboard" to "shutdown" to accurately describe
> its hardware function and align it with userspace tooling (asusctl,
> g-helper).
> 
> Fixes: 61f64515299e ("platform/x86: asus-wmi: Implement TUF laptop keyboard power states")
> Cc: stable@vger.kernel.org
> Suggested-by: Denis Benato <denis.benato@linux.dev>
> Signed-off-by: Bartu Alev <bartualev@gmail.com>
> ---
>  drivers/platform/x86/asus-wmi.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index a65090429ca7..db6ee1974838 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -1119,10 +1119,10 @@ static ssize_t kbd_rgb_state_store(struct device *dev,
>  				 struct device_attribute *attr,
>  				 const char *buf, size_t count)
>  {
> -	u32 flags, cmd, boot, awake, sleep, keyboard;
> +	u32 flags, cmd, boot, awake, sleep, shutdown;
>  	int err;
>  
> -	if (sscanf(buf, "%d %d %d %d %d", &cmd, &boot, &awake, &sleep, &keyboard) != 5)
> +	if (sscanf(buf, "%d %d %d %d %d", &cmd, &boot, &awake, &sleep, &shutdown) != 5)
>  		return -EINVAL;
>  
>  	if (cmd)
> @@ -1135,7 +1135,7 @@ static ssize_t kbd_rgb_state_store(struct device *dev,
>  		flags |= BIT(3);
>  	if (sleep)
>  		flags |= BIT(5);
> -	if (keyboard)
> +	if (shutdown)
>  		flags |= BIT(7);
>  
>  	/* 0xbd is the required default arg0 for the method. Nothing happens otherwise */
> @@ -1149,7 +1149,7 @@ static ssize_t kbd_rgb_state_store(struct device *dev,
>  static DEVICE_ATTR_WO(kbd_rgb_state);
>  
>  static DEVICE_STRING_ATTR_RO(kbd_rgb_state_index, 0444,
> -			     "cmd boot awake sleep keyboard");
> +			     "cmd boot awake sleep shutdown");
>  
>  static struct attribute *kbd_rgb_state_attrs[] = {
>  	&dev_attr_kbd_rgb_state.attr,
> 

Hi,

It seems we're missing Documentation for this interface... It would be 
nice to add that as well (in a separate patch).

-- 
 i.

