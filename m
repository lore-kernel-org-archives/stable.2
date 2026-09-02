Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E2947D470;
	Wed,  2 Sep 2026 13:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788355932; cv=none; b=iNSMjVTcMesgBA/stzHAGiGtVI/M2xvRf3lwbqF/eL/6/ykR8NIcJyGC5NhsGv7miC2ON9ewJcx7yNVPH/be1Y+zhIsN/gLONwqYLItGca9aVMP1jhxcytK/8KFQeW1Yby0WRpjrvt0Yyp18rM4xNJl/KqWs6dG2Cw+X4obwOUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788355932; c=relaxed/simple;
	bh=2FVjUR2IHg8brsTGehbDXKcOcWo2hhF15CmBiXnTkTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mZubxNRu7HdZholWKvwD0vuFvKVQ2gOgDuoGc0oLw3DCZzxNAZ8byjMA8Zdk2FvQxEw4HOlaERft98no2Sqk6mXXSlxloe4pfRTAwV6YLlvCz3HhkLG3xFbI9ksJB+0aWkefaNctDwtJldQmyz1l6JvOnviCR2TxH6gudoNdi/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jyGOm/D3; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jyGOm/D3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788355930; x=1819891930;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2FVjUR2IHg8brsTGehbDXKcOcWo2hhF15CmBiXnTkTU=;
  b=jyGOm/D3nSV3qbyH2XayRak5DDGvazl8IjaZTMXS5u1NqY6HAlKGGIix
   n7Ysp9vFKF9lN1CWbTdb4k74/OuEeWdWburZ2VrTzgJsIGgUa2O9mJsaS
   ibHNZtl/pOl7vOCvlL3znjDEOq3TJsetYDIQWenFwUiNzVBENQa6mgrWs
   O2hP2HX2RhtHGkSN8b6SLYUVDG6YPPG6M1SoTg7KgK70X/QyW/38o5dIu
   fGeV7GiZ+NLi7yP1Wy8iuHHUWKmcgN6hk22nZXhOlgrFlach1CgrbgRp+
   lACgXNlH+6+dXxQ0jqu+Rs7EXaW2lc/EMCH7X70oKxN4b15a7z9rrggSJ
   w==;
X-CSE-ConnectionGUID: THuuyrKWTTysv55m4uexbA==
X-CSE-MsgGUID: XS6vM90QRmC9Kjx+d2kH1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="88662846"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="88662846"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 06:29:50 -0700
X-CSE-ConnectionGUID: eJgGfHOxT1iOIb//2TX6ug==
X-CSE-MsgGUID: c5EqoaCJT12ye2kIDQaCqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="265707859"
Received: from slindbla-desk.ger.corp.intel.com (HELO [10.245.245.217]) ([10.245.245.217])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 06:29:47 -0700
Message-ID: <9f8fae96-0865-4b0e-9650-00e92e324f9e@linux.intel.com>
Date: Wed, 2 Sep 2026 16:29:40 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 1/2] usb: hub: use shorter 120ms post resume hold for SS
 root hubs
To: Lovekesh Solanki <lovekeshsolanki00@gmail.com>, linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Michal Pecio <michal.pecio@gmail.com>,
 Mathieu Fluhr <mathieu.fluhr@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Thorsten Leemhuis <regressions@leemhuis.info>, regressions@lists.linux.dev,
 stable@vger.kernel.org
References: <20260831190349.29590-1-lovekeshsolanki00@gmail.com>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20260831190349.29590-1-lovekeshsolanki00@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi

Some minor nitpicks/personal preferences if you are sending a v2.

I don't really object taking this as is either.

On 8/31/26 22:03, Lovekesh Solanki wrote:
> Commit 8f5b7e2bec1c ("usb: hub: fix detection of high tier USB3 devices
> behind suspended hubs") holds a runtime PM reference for
> USB_SS_PORT_U0_WAKE_TIME (200ms) after every SS hub resume, so
> downstream links have time to finish trianing before the hub can
> suspend again.
> 
> But 200ms is excessive for root hubs since a root hub has no upstream
> suspended hub whose wake propagation needs to be accounted for.
> The root hub still needs some time for USB3 link training to complete,
> And root hubs also default to zero auto suspend delay and get
> periodically resumed by userspace USB enumeration opening and
> closing their usbfs nodes (adb, libusb).
> This extra 200ms hold stretches this resume into a suspend/resume
> cycle of roughly once per second, which on idle AMD systems have
> been reported to cause system freezes.

I'd highlight the fact that this patch mitigates the AMD platform issue.

Maybe begin commit message with something like

"Holding a USB3 hub PM runtime reference for 200ms at hub resume triggers a
  AMD platform issue. Users running Android adb report crashes after adb has
  been polling and waking up the USB subsystem once a second for some time.
  Vendors are working on a solution. Disabling USB runtime PM is one way to
  prevent this issue, but it is also proven that reducing the hold time to 120ms in
  resume also mitigates it. See Link for more details.

  Reducing the hold time to 120ms for the USB3 roothub is in itself a valid change
  and optimization as the current 200ms is excessive...
"

> 
> Shorten the post resume hold to 120ms only for root hubs but
> keep the 200ms for external hubs that the original commit is
> intended for.
> 
> Reported-by: Mathieu Fluhr <mathieu.fluhr@gmail.com>
> Link: https://lore.kernel.org/all/CAPyJwA_D9qw0T72f8zwM1yKjP+To=maVANbcdsWM7yRmbBxYvw@mail.gmail.com/
> Cc: stable@vger.kernel.org
> Fixes: 8f5b7e2bec1c ("usb: hub: fix detection of high tier USB3 devices behind suspended hubs")
> Signed-off-by: Lovekesh Solanki <lovekeshsolanki00@gmail.com>
> ---
>   drivers/usb/core/hub.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 3345b3298daf..e1415ad5f908 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -76,6 +76,12 @@
>    */
>   #define USB_SS_PORT_U0_WAKE_TIME	200  /* ms */
>   
> +/*
> + * Root hubs have no upstream hub whose wake propagation needs to be
> + * accounted for, but still needs time for USB3 link training to complete.
> + */
> +#define USB_SS_ROOT_HUB_U0_WAKE_TIME 120 /* ms */

I'd do minor changes to the original code comment above the first #define,
and just add the second define right after it

/*
  * modified original comment
  */
#define USB_SS_PORT_U0_WAKE_TIME	200  /* ms */
#define USB_SS_RH_PORT_U0_WAKE_TIME	120  /* ms */

Thanks
Mathias
