Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CB93D7D69;
	Wed, 10 Jun 2026 11:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781091684; cv=none; b=CxwXwmqv0w82N4Bu/dUuzUd6ACLQWaLplUidyKJtjsB7F+D7Qc6zBhUZVmZb2o0/zOmu6taAesxaApxrAe6DW1uy3epItngZ6dR5GiqodKhFvq7Pkg2v2ju2DcyEiAVqqvAp2RMnBVt+KahP0t6q1yfnJE1pzZk0w4nk9Z16XtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781091684; c=relaxed/simple;
	bh=YUZnH9iXq0Pl87kTiU9IWLwmwffmNGTynFm+HmKTlRY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ewYu4nzZ8OrnQ4Middet11vhuaUCtzOuqO/FGi4e9j4gu/ce/y6vKqSDWhKSGn1EedKfKBytXl+QI7afMGXTCT09sBb80cpYo8H116mU7jSETns/uQx6RgBj1XgrONEBTuOOVoXkOvz+dvnteZEgbOyDcJbKE6mMyX61pdLjRr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ClyjEuJp; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ClyjEuJp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781091682; x=1812627682;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=YUZnH9iXq0Pl87kTiU9IWLwmwffmNGTynFm+HmKTlRY=;
  b=ClyjEuJp/Ev0Re15EII0IUVgl0zxiMjsB0mis/1eLZaYAW7v9FHxGCPB
   hgsI/xHB1WyaWwTsdoPTps21tXD9XK4ngTF+NcGqjtIGzZz5yOTnNhvE6
   ROVJ+eOQKhWi+AxwQCXIFMfW4AlTNCTvEdVRC9SxPugsFY6CuBT+OsKBE
   FLVK4Q7mlJcFv5zG4Zv1rVs4FhoasX0Vbp/U8IbM7cwUhUMA3+8RDKDRl
   sYiPHfpBtbufBee69HSCu8SLkyHemi02Nb1SIU4/7g8W+IhHHmqAJoVhu
   2pktP3zF5Y5nWLKIS6kr52OpxV7Ze5VdTrCCj10jfHNaqv6mQgcwIXj2c
   A==;
X-CSE-ConnectionGUID: 8OqtE/hRRU6oWSUk1nkYVw==
X-CSE-MsgGUID: 1Zz2fNHYT2+nhPdcb+4AZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="81924275"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="81924275"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 04:41:21 -0700
X-CSE-ConnectionGUID: tFJiYj0STv+g0NQhxFUyQQ==
X-CSE-MsgGUID: 3omx3dyUTwGLa0smXA1bPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="243685061"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.18])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 04:41:18 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 10 Jun 2026 14:41:14 +0300 (EEST)
To: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
cc: mjg59@srcf.ucam.org, pali@kernel.org, Hans de Goede <hansg@kernel.org>, 
    dvhart@infradead.org, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2] platform/x86: dell-laptop: fix missing cleanups in
 init error path
In-Reply-To: <20260609081419.1995169-1-lihaoxiang@isrc.iscas.ac.cn>
Message-ID: <adce8429-e437-48a1-6520-2b95973411eb@linux.intel.com>
References: <20260609081419.1995169-1-lihaoxiang@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 9 Jun 2026, Haoxiang Li wrote:

> dell_init() initializes several resources after dell_setup_rfkill(),
> including the optional touchpad LED, keyboard backlight LED, battery
> hook, debugfs directory and dell-laptop notifier.
> 
> If a later LED or backlight registration fails, the error path only
> tears down the battery hook and rfkill resources. This leaves the
> notifier, debugfs directory, keyboard backlight LED and optional
> touchpad LED registered after dell_init() returns an error.
> 
> Add the missing cleanup calls before tearing down rfkill.
> 
> Fixes: 9c656b07997f ("platform/x86: dell-*: Call new led hw_changed API on kbd brightness change")

I've included also these:

Fixes: 037accfa14b2 ("dell-laptop: Add debugfs support")
Fixes: 2d8b90be4f1c ("dell-laptop: support Synaptics/Alps touchpad led")
Fixes: 6cff8d60aa0a ("platform: x86: dell-laptop: Add support for keyboard backlight")

Applied this change to my local the review-ilpo-next branch (it will 
eventually appear in the public one if there are no problems).

--
 i.

> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
> ---
> Changes in v2:
>  - Fix all missing cleanups in dell_init()'s error path.
>  - Add Fixes tags.
>  - Modify the commit title and message.
> ---
>  drivers/platform/x86/dell/dell-laptop.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/platform/x86/dell/dell-laptop.c b/drivers/platform/x86/dell/dell-laptop.c
> index 57748c3ea24f..053f40572bf6 100644
> --- a/drivers/platform/x86/dell/dell-laptop.c
> +++ b/drivers/platform/x86/dell/dell-laptop.c
> @@ -2551,7 +2551,12 @@ static int __init dell_init(void)
>  	if (mute_led_registered)
>  		led_classdev_unregister(&mute_led_cdev);
>  fail_led:
> +	dell_laptop_unregister_notifier(&dell_laptop_notifier);
> +	debugfs_remove_recursive(dell_laptop_dir);
>  	dell_battery_exit();
> +	kbd_led_exit();
> +	if (quirks && quirks->touchpad_led)
> +		touchpad_led_exit();
>  	dell_cleanup_rfkill();
>  fail_rfkill:
>  	platform_device_del(platform_device);
> 
