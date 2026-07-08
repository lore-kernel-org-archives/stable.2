Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2338B382281;
	Wed,  8 Jul 2026 14:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783521878; cv=none; b=fOPR7s4+Os/Pql6YOuqd5ByXvyr1777FcUSl1PBXQs/SfVbStCAFl8+EEJudUKbEFHGOlVwWDc7uLEknQz6T0ywcL+asNAop6Z++UZNw4ebfUxzeNEwS6fU8r396T+/a7HMWKW8aE3fUfIafDRY5okIj2rZy6EOvGRBFJwOOg9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783521878; c=relaxed/simple;
	bh=Rg52ve3wPs5SpbK5r3u/AJva8doUjDczh/yGR2+7woA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kCnvgofCR7/BphQtONt37yvisgvRjxoUWDKxCZnVfwNgRMgGiJcqMabL91Xd21M5LGnaIRGLtR+KFH2wc5Gvtc6wk34Ivs9Dm56rTZd3AUWF5H1Qq5IVMufk8EUdqj5dAjiMA7/KpK3VZAgLko2MUgQpRRy6Z7nP8qphHml/o8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kV/tLy5o; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kV/tLy5o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783521877; x=1815057877;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Rg52ve3wPs5SpbK5r3u/AJva8doUjDczh/yGR2+7woA=;
  b=kV/tLy5ol9gHoaxWEujAq1UrhIvKzXnMnDoJfPqqGh5/Ec/gdc9VOtnS
   oOvf31hQd6/Mcc9hYujLdDYgNXLhBryPYGBWeTriyCe4Sg65RXzVC/fH5
   eLco3zeMGcFGXbGAcYrW/MdpCYPkc38nkeyG1AhRSZ/OgTEl0OXU96MkV
   BNCDDw5l8FcH4PAD1XNoYIKKW4k/EuhL1r7+uXolRmRip5tAYfalQzeqm
   yKOTQyHnd8horO4kutq5goXHno01XodGTIT+uRmgKTWC5CPmq19Mbj/1x
   Lpedgq21t2yklcwl7S7nWc8Mrm7XgKS9A/gGMH4P0G7mXSMXc+J2T1wb5
   Q==;
X-CSE-ConnectionGUID: EsAG9zrGRlKcSfXpXZkn6Q==
X-CSE-MsgGUID: ywnVAB35SY+/bfXx7mP/6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="88098552"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="88098552"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 07:44:37 -0700
X-CSE-ConnectionGUID: OkDdlxJVQ9idU4vklQi4gw==
X-CSE-MsgGUID: Q7p+tOlJSRuxWNwR6Rn/Tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="254398464"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.100])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 07:44:34 -0700
Date: Wed, 8 Jul 2026 17:44:32 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Biren Pandya <birenpandya@gmail.com>
Cc: sakari.ailus@linux.intel.com, mchehab@kernel.org,
	dongchun.zhu@mediatek.com, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Subject: Re: [PATCH v3] media: i2c: ov02a10: fix endpoint parsing
 use-after-free
Message-ID: <ak5iUKb9MQ2noWNe@ashevche-desk.local>
References: <20260613112920.64617-1-birenpandya@gmail.com>
 <20260708130534.29329-2-birenpandya@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708130534.29329-2-birenpandya@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 08, 2026 at 06:35:33PM +0530, Biren Pandya wrote:
> The ov02a10_check_hwcfg() function calls fwnode_handle_put(ep)
> immediately after allocating and parsing the endpoint. However, it
> subsequently calls fwnode_property_read_u32() using the same 'ep'
> handle, leading to a potential use-after-free.
> 
> Additionally, reading the optional 'ovti,mipi-clock-voltage' property
> used to overwrite the 'ret' variable. If the property was missing,
> 'ret' would become negative, and this failure code would be incorrectly
> returned at the end of the function, causing probe to fail entirely.
> 
> Fix the use-after-free by moving fwnode_property_read_u32() before
> the endpoint is parsed and freed. Avoid the error leak by not
> assigning the result of fwnode_property_read_u32() to 'ret'.

...

> +	/* Optional indication of MIPI clock voltage unit */
> +	if (!fwnode_property_read_u32(ep, "ovti,mipi-clock-voltage",
> +				      &clk_volt))

Besides this being exactly a single line in length (80 chars),
the way how we check and read the optional properties is like this

	if (_property_present()) {
		ret = _property_read_u32();
		if (ret)
			return ret;
	} else {
		...apply default...
	}

But since this is a fix, just make the above a single line for now and refactor
in a later change.

> +		ov02a10->mipi_clock_voltage = clk_volt;

-- 
With Best Regards,
Andy Shevchenko


