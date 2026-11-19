Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795097785;
	b=1i6bXJTFmCU/2GbUjIxeXOPU9+T/eAEj+9OkKu917d9CQDJY3oy9s0J8gdspuVYxRU/j
	 Q5E8dbKWM4q9uZ2xErNLhA2MYUFG1BFN6sfTmZLSzLxWTJkjUh4px+ESLemVRLgqkZjQu
	 tLA0jv1Aq/i0Ntl2Ufm4VaXW03rAARnxotdx6Eu1hE4KXzm8QYdIx47J/XAqddn/sH0vI
	 IosW68h58tuqyYTa8YYTdtDtR757TOTCtj6lmH/gSBGsA11LIBwbm9TimCQtPMJO3R1tM
	 tcOJCzcVKJT/m8yeDVr8fDD1piXrUHWXkWkYnUNe7F9BABO1UxvCaJCkLWdQBKcw5Lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795097785;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=RvP7hMRsWVM8btK1nsXQy/u5gRKUh/9shR14WhIy4BM=;
	b=nBKVMx/qfRi4Fpf3a0n9n6nKiE16s/6VCjV4UIQA5CskHwda5JuAGUI1+n9w7spIFcc5
	 FQtHfyhIW6AP9859n0232S5wic0hnUUik2lFig2QklcgdbovoigyxPa7Yazp+IOabxmB7
	 G7RBpc8OYXj0q/vE0SXMEQuu4IbQhFoBJcJnPU9xeRwhRIC0JcV9ICEtaNN8aTKbshTS/
	 HhiuqQ0XPCajXyL4GeOIR33lIxgo2jKI7jN8/JZGjQ3Aq7o+k+xO44LZD25GZehY3+vfq
	 nvjQYalFo9HrYfHchA4KODXyuGnuH8LwNhISMbLRHr7vMeZXc9a4HnMd3ISMZYuaPNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Dys+RchT;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAEA606A320;
	Thu, 19 Nov 2026 14:16:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECAEA606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Dys+RchT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795097785; x=1826633785;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cYUbJ6JlPEmLhq2na7DI0qoGMRjgS9yB45BhkEJbc30=;
  b=Dys+RchTqL1eqXy2saJIVF+GNhr9xbXZQ7Vd0bU/oGjbKtUOGMr+LlKp
   Zn7QFLIz8HnZQYMWqs/Bkfs5W+aJu2g5lKb5eUcITE28JR8OWUhguupC1
   wdNzRokqQe2v3Xw3+oJTH1ik6vdt2o6U3PKGj8fxk8bMfblsU18gggpkD
   FVy8Gbv9IfAK6LXLvY5NXvuFiDMeF9kELn8az7wvdmRg2/DO2dVc1+xfc
   Mzrz4FjzDgQwkCdZpvUVjiRdXkXRHbdxBvDHx0E+MPMQuaQGbrnvQg0wa
   DQ2LUJyhV3qe+2j4tzn+d6ZZwaomX6GhOloqW1rPVrXA7Mq1nnlGZMiA/
   Q==;
X-CSE-ConnectionGUID: gVrcFUu6S82rKhshTzMfdg==
X-CSE-MsgGUID: BtvjOTMvSqSBNufiLrQAfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3829150"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="3829150"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 06:16:24 -0800
X-CSE-ConnectionGUID: QH6PJbYKQTqH6/WBBp8Z7Q==
X-CSE-MsgGUID: B26etjMyShm5utmiEYgYEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="10669841"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.61])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 06:16:22 -0800
Date: Thu, 19 Nov 2026 16:16:19 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: silverducks@altlinux.org, Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Cc: linux-gpio@vger.kernel.org, Mika Westerberg <westeri@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-acpi@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] gpiolib: acpi: Add ignore_wake quirk for Gigabyte
 B650 GAMING X AX
Message-ID: <av8EszUWsJIq3hIV@ashevche-desk.local>
References: <20261119083813.390337-1-silverducks@altlinux.org>
 <20261119122844.445945-2-silverducks@altlinux.org>
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
In-Reply-To: <20261119122844.445945-2-silverducks@altlinux.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 19, 2026 at 03:28:45PM +0300, silverducks@altlinux.org wrote:

+Cc: AMD folks.

> The firmware's _AEI table on the Gigabyte B650 GAMING X AX declares AMD
> GPIO pin 3 as GpioInt(Edge, ActiveLow, ExclusiveAndWake). gpiolib-acpi
> requests it as "ACPI:Event" and amd_gpio_irq_set_wake() arms the hardware
> S3 wake bit for that pin. The firmware then sends the signal a few seconds
> after entering S3, so the machine resumes on it's own six to ten seconds
> after suspend.
> 
> Pin 3 is the only wake signal the OS can see for the whole GPP7 PCIe
> domain, and GPP7 has no _PRW, so ignoring this wake flag is the only way to
> keep S3 reliable on this board. Wake from USB keyboards/mouse and
> Wake-on-LAN through that domain is lost as a consequence, but I figure S3
> not working at all is worse. The power button still wakes the machine as
> normal.

Hmm... And you are running the latest BIOS?

> ---
> v2 - Put real name in signoff; Moved testing information to comment.
> 
> Quirk tested on upstream kernel v7.4-rc2.  Also tested on stable kernel
> v6.12, which is the version where the issue was originally diagnosed.

...

> +	{
> +		/*
> +		 * Spurious wake from S3: the firmware _AEI table declares AMD GPIO
> +		 * pin 3 (GPP7 group) as Edge/ActiveLow ExclusiveAndWake, so gpiolib-acpi
> +		 * requests it as ACPI:Event and amd_gpio_irq_set_wake() arms the
> +		 * hardware S0i3/S3 wake bit. The firmware asserts this signal during
> +		 * S3 entry regardless of the PCI wake sources configured by the OS,
> +		 * waking the machine a few seconds after suspend.
> +		 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Gigabyte Technology Co., Ltd."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "B650 GAMING X AX"),
> +		},
> +		.driver_data = &(struct acpi_gpiolib_dmi_quirk) {
> +			.ignore_wake = "AMDI0030:00@3",
> +		},
> +	},

-- 
With Best Regards,
Andy Shevchenko


