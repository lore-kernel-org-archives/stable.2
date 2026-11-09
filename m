Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794229292;
	b=BHjHaYzK2fys1Brlpfw+84Oe7E62cXQwKxWFO6rZLGY9Lp8np4049I15CEvyt9KWZCow
	 gqxhVqRuCGM6VtSza3MAOMuKpy6rv+TS5uvjlbuSRq67HqzmRggYD3WoCdBZ0UsNEArxG
	 yKPdi0xdcO9e+NhSoaaYyaNqIpwSZsRFff0KIKMdOSnd9BTB7q4lH1r3DmdCSibIljTb7
	 mPcWky92QeOGi2AmuKogkFZdGfS9AYQRzZfsUjIARHqqa7kMwcckCVR0YtO6rPy4Eo9C4
	 V08HPvsuQ8oLroU41a0h4P5L54at79ZBe4xSDZ/DvkaRtoNvVBdfF4lilY0gTl3XRWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794229292;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:
	 Organization:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=GrnS4jLv9hDP6qcIq7PmJP9UPyicS96uU+61H009H4c=;
	b=ozueAw4sPsTaWv7oUUyenI6AXK0xgAK2b6nMZIOEaCYNb5/PRODawKkwwSMHsojm1u2f
	 SdVJ2UJeJLNYhM+/cd96gQ5ALNVe8jXv6U0xyTY70dkKIiFEND300Kgt7kR0g9noWIqXT
	 c9GDFq1/C8tCYJOoQG8KdCPFyqHs6/CjzldAap9prFACiK2KsCC37oYRHsCtE4xV8sUl0
	 Q1aaF3vV1or/Hn50XkOMQnU9HIdaqKAi821yerHetc8g7YCiqeZL7mQJz/IUxVQ57gDRA
	 /KwIqLnn+8VKitwn5Osf+N2F//sB0vJKHKJdK4kldNbAXbWios2JQn4EVEnVDl7DWgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=g16flIQi;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7113A606A31C;
	Mon,  9 Nov 2026 13:01:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7113A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=g16flIQi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794229291; x=1825765291;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OhnZ8KrQ1e0IGGbUwmpfLGs0XbCEpAloNu6dadFWA+w=;
  b=g16flIQiSxjfI8VP4zj+dEaT2uGQALOajlj+zwNTlDDtShyZnaW0uZSJ
   RHncDRDL0w3llEJH56KJ+qRfXoirUPi+xhL5MdffVzdz7tpZcgakJS/Bs
   OiS0kt/9AhBGmn/r1V/0yDszekK8Nw2qkW2rS/JJh3Ir3bj/9LH34tQYr
   oe89nL3XwehoI/K8vSpip/xSZNlWarw5ckugXpOrzfetg4ZlIAS4es3M6
   /fakIZwghYpK7G6Pj824u6a4UtfDLNARSkHNRPSkfknuM4hIeyjOM0a9y
   uNVzdAeIsjRbk0eYG40Y0dQjk0YwxApJDIqnB78Z3Xl1NDq0dgz/ZJC8K
   w==;
X-CSE-ConnectionGUID: QfFUXbeNQXSazI6XlD9j0w==
X-CSE-MsgGUID: xOPI8AicSDSJJwHpM9Yxsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2866101"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="2866101"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 05:01:30 -0800
X-CSE-ConnectionGUID: 039pQ77LTj2MWhcf819ksA==
X-CSE-MsgGUID: actMIGJiT6OrtWqfwZ7O9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="9634622"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.119])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 05:01:28 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id BA32F121B96;
	Mon, 09 Nov 2026 15:01:24 +0200 (EET)
Date: Mon, 9 Nov 2026 15:01:24 +0200
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: b.danias@tutamail.com
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Serin Yeh <serin.yeh@intel.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Robert Foss <rfoss@kernel.org>, Hans de Goede <hansg@kernel.org>,
	Bryan O'Donoghue <bod@kernel.org>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/3] media: i2c: ov8856: Don't power off a suspended
 sensor in remove()
Message-ID: <avHEJFI-DNz074FS@kekkonen.localdomain>
References: <20261104-ov8856-pm-fixes-v1-0-1958b730ce66@tutamail.com>
 <20261104-ov8856-pm-fixes-v1-1-1958b730ce66@tutamail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104-ov8856-pm-fixes-v1-1-1958b730ce66@tutamail.com>

Hi Babis,

Thanks for the set.

On Wed, Nov 04, 2026 at 11:42:47AM +0200, Babis Danias via B4 Relay wrote:
> From: Babis Danias <b.danias@tutamail.com>
> 
> ov8856_remove() calls ov8856_power_off() unconditionally. The sensor is
> normally runtime-suspended by then, so its regulators and clock get
> disabled a second time. On every unbind, the regulator core refuses the
> extra disable with an "unbalanced disables" warning, and the clock
> framework warns that the clock is already disabled and unprepared.
> 
> For the clock this is more than a warning: the clock framework keeps
> one enable count per clock, shared by all its consumers. Where sensors
> share a clock, such as the TPS68470 clock that int3472 hands to every
> sensor behind it, the extra disable can stop the clock under another
> sensor that is streaming.
> 
> This has been the case on devicetree systems since the power handling
> was added. Since commit 609a71568664 ("media: i2c: ov8856 : remove ACPI
> node bypass mechanism"), it happens on ACPI systems too. Seen on a Dell
> Latitude 7320 Detachable (rear OV8856 behind a TPS68470) when unbinding
> the driver:
> 
>   [  220.072107] unbalanced disables for CORE
>   [  220.072109] WARNING: drivers/regulator/core.c:3262 at _regulator_disable+0xc3/0x150, CPU#2: tee/8667
>   [  220.072825] tps68470-clk already disabled
>   [  220.072828] WARNING: drivers/clk/clk.c:1188 at clk_core_disable+0x82/0x140, CPU#2: tee/8667
>   [  220.073620] tps68470-clk already unprepared
>   [  220.073623] WARNING: drivers/clk/clk.c:1047 at clk_core_unprepare+0x1cf/0x200, CPU#2: tee/8667
> 
> Power the sensor off only if it isn't runtime-suspended, then mark it
> suspended, as other sensor drivers such as ov5675 do.
> 
> The problem was found, and this patch written, with the help of an AI
> coding assistant (Claude Opus 5.5). See the cover letter for details.
> 
> Fixes: 0c2c7a1e0d69 ("media: ov8856: Add devicetree support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Babis Danias <b.danias@tutamail.com>
> ---
>  drivers/media/i2c/ov8856.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/i2c/ov8856.c b/drivers/media/i2c/ov8856.c
> index 42c4b9c4e..988ce0310 100644
> --- a/drivers/media/i2c/ov8856.c
> +++ b/drivers/media/i2c/ov8856.c
> @@ -2367,7 +2367,9 @@ static void ov8856_remove(struct i2c_client *client)
>  	pm_runtime_disable(ov8856->dev);
>  	mutex_destroy(&ov8856->mutex);
>  
> -	ov8856_power_off(ov8856->dev);
> +	if (!pm_runtime_status_suspended(ov8856->dev))
> +		ov8856_power_off(ov8856->dev);
> +	pm_runtime_set_suspended(ov8856->dev);

Also setting the device suspended should be conditional to its status, not
just powering it off.

>  }
>  
>  static int ov8856_probe(struct i2c_client *client)
> 

-- 
Regards,

Sakari Ailus
