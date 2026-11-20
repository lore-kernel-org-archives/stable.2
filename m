Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795184350;
	b=IcRjfEEDoNpb/j3ydy0NyIzCLBXPLGpzkd90iTQLU61KY7BJ21lWf90mjoAPFbu2EQWY
	 Dzim0BDCJNirpDGcqeuelpsDVHGlesktOh9+ywv3rFrwPDvJWL68MT2bNnwtrY/KLgABm
	 stFubA/eu6SzcouN2o6ccF1y6hsmSRXI3mz4l5uo+X/MJS7vcY00WjowDUf7C9iRBCkWX
	 QwOEYb0DAU2OF8kv/5cDhATF3fMAbCiMUg2nQapjrWZcwHeR7UKBLfVguGK5p7u6VFU8v
	 mWPAzla8dGPb2BrFC/KmxbV0Nh7Mxwk3FcBz6ZVO+Mk76YPYegGiC5yJYnkruW6b0OQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795184350;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=kCmSLUIBckuiPzspA4IkBNq6yFuVZYYrJamPoUyPQzc=;
	b=v6cuCh68txTlgAgc6KE0uR2MWR0fIgBJDreLwStCr8dCduLbPcfsgS4PrrhEgztJ2c9l
	 rwUI/45Mwy32uaoRSH0tKc8idVZ8/UHqJjO8CKDEeGebGCE6rJTqCi8vj9EglOA+rQ5aZ
	 dWT3R/2znh7cWI7xpwDTA7pkB8z7V6MLtFQJNR8HXIW/8tiJ+vgwvdu1F0XLNwNtUCSVQ
	 SPuRMCPK2CyUimKbOWZX4rOVGNZdPGyIGngsOI2q2s7wzl+j3hIkoFcVyaCvGyHlPsESM
	 lFC1PIb8xABZk4qQkxA3tGwjiv1FsVmZK+FCs0WGZyXwQNrImQLuXNdfALlhGaBK+Tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=S4JWxgYa;
	arc=none smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DE5606A325;
	Fri, 20 Nov 2026 14:19:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92DE5606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=S4JWxgYa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795184349; x=1826720349;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ygMS8bfp+r/Ry1VqGSfmzGK524Y0flw4JjnPVtZrE40=;
  b=S4JWxgYaREfKin62JHBXPYznOo5k1wg3bbv5OuPT1sUpGHBX9yYc6JMc
   VhoKkQs1bJdnXHyMI6JEovh/b/Wng3bBuPlf125HMY4kEvlwDTDFlpZtr
   u1+zlN6GRRLCu3mogcECKAeW2hM8OiDr888OZ/ju6aszTVDF+7AKzeqGF
   GzcriK4t1xxgIc2sNSKx2FzT91Ce+ZD4OJ8pmh9x9hJVXLi01NYIlbsoZ
   BlP0NHXrwHmoK8cgWxkm7Fgs2L5aNPSqG86B15PmeqKsBuDFRFnT3Tvru
   D0KkabOTDQf2QEiklojpNoZyBVvpvi7e6pJ42v3sNFZIa8j6uO+U9Ys3B
   g==;
X-CSE-ConnectionGUID: ADYLFS5jTIuZK4Nc0ztZzQ==
X-CSE-MsgGUID: tsBz42D6QZmDYwzvYT3UlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4106151"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4106151"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 06:19:09 -0800
X-CSE-ConnectionGUID: 3kryz8ETQe2llA/oIdr6sg==
X-CSE-MsgGUID: dfuxc4MWSeOGSmDhZLL9Kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10696880"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.218])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 06:19:07 -0800
Date: Fri, 20 Nov 2026 16:19:04 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: silverducks@altlinux.org
Cc: bnatikar@amd.com, Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com,
	brgl@kernel.org, linusw@kernel.org, linux-acpi@vger.kernel.org,
	linux-gpio@vger.kernel.org, mario.limonciello@amd.com,
	stable@vger.kernel.org, westeri@kernel.org
Subject: Re: [PATCH v2] gpiolib: acpi: Add ignore_wake quirk for Gigabyte
 B650 GAMING X AX
Message-ID: <awBW2BeZjVdDi_Ha@ashevche-desk.local>
References: <139a1c14-39a1-4bc5-aba3-673ba603821d@amd.com>
 <20261120125823.716828-2-silverducks@altlinux.org>
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
In-Reply-To: <20261120125823.716828-2-silverducks@altlinux.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 20, 2026 at 03:58:24PM +0300, silverducks@altlinux.org wrote:
> On 11/19/2026 7:46 PM, Andy Shevchenko wrote:
> > On Thu, Nov 19, 2026 at 03:28:45PM +0300, silverducks@altlinux.org wrote:

...

> >> Hmm... And you are running the latest BIOS?
> >
> >+1. If a newer BIOS de-flags the pin (ExclusiveAndWake -> Exclusive) or
> >stops asserting it in S3, this quirk would permanently disable GPP7 wake
> >on units that no longer need it. Please confirm the BIOS version it
> >reproduces on and whether the latest available BIOS still shows it.
> 
> Ah, right, my bad. The version was F31b.
> I've tested again after flashing the latest F42e (october 20th, checksum
> 1DA1). S3 works on it with unpatched kernels.  Diff of the relevant sections
> between these versions:
> 
> @@ -66279,16 +65498,11 @@
>      {
>          Method (_AEI, 0, NotSerialized)  // _AEI: ACPI Event Interrupts
>          {
> -            Name (BUFF, ResourceTemplate ()
> +            Name (BUFF, Buffer (0x02)
>              {
> -                GpioInt (Edge, ActiveLow, ExclusiveAndWake, PullNone, 0x0000,
> -                    "\\_SB.GPIO", 0x00, ResourceConsumer, ,
> -                    )
> -                    {   // Pin list
> -                        0x0003
> -                    }
> +                 0x79, 0x00                                       // y.
>              })
> -            Name (BUNP, ResourceTemplate ()
> +            Name (BUNX, ResourceTemplate ()
>              {
>                  GpioInt (Edge, ActiveHigh, ExclusiveAndWake, PullDefault, 0x1388,
>                      "\\_SB.GPIO", 0x00, ResourceConsumer, ,
> 
> @@ -66330,24 +65547,40 @@
>                      "\\_SB.GPIO", 0x00, ResourceConsumer, ,
>                      )
>                      {   // Pin list
> -                        0x0003
> -                    }
> -                GpioInt (Edge, ActiveLow, ExclusiveAndWake, PullNone, 0x0000,
> -                    "\\_SB.GPIO", 0x00, ResourceConsumer, ,
> -                    )
> -                    {   // Pin list
>                          0x0009
>                      }
>              })
> 
> Seems like this has indeed been fixed on firmware side in the new BIOS.
> Pin 3 was not just deflagged, but removed entirely.
> 
> Should I rescope the quirk to F31b or drop it altogether?

No, since there is a FW update available and it fixes the issue.
However you can do a blog post or something like this, so internet
will remember that.

-- 
With Best Regards,
Andy Shevchenko


