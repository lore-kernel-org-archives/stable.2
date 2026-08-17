Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48C5347529;
	Mon, 17 Aug 2026 13:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786973846; cv=none; b=VNt0KKXJbc8JbyJQj97erMHp3aud6IZQLwnvMU+coFSEhqfXkGkd2+Hx88BrrG+NFfYSq6iS8oscBkldZXqH8Bd+np1HIDZPoF9stOycH1FtoeqX5QPNb6rBnFUt8djMfJQFpdYE//NtwJWDZBwBGoEEHjQLbV4jSZCvefbUwZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786973846; c=relaxed/simple;
	bh=ATKu1NaVCSAbFWJ1duEZ4qn7VCIj2cNoMx74eOWAt08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qJiDDAliDKmD0yvoYUdso6ilLiyLgvZeG7coCAl8V4zIRLQuaegGMC4eFhRy/2Ho4XFB0463w6dTQE3cRnV7i4Q/GBwxklco2XV04w9fz+D56xu0UWaOqOKSGtR9icvzrzsip+mZyHcgU6xe1LHcsvo5Vgg2BhrwbEEEDB1ITo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AOpy38GE; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AOpy38GE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786973841; x=1818509841;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ATKu1NaVCSAbFWJ1duEZ4qn7VCIj2cNoMx74eOWAt08=;
  b=AOpy38GEKf28SAmXRwm6A3pn7ZymKh6Agy0BxDjnCAP5dLZtpBK5ltbB
   ExCFJd3Srdd6pGMKDL+B3GXxvnnTJHJsIw1SjKcBxHqCEgwZPRSb+IxCK
   zC+Qg6MSqGhJZ4Yqhn7Yqu4UkjwbPUiTB4kb31WBUh7YGE1Znk5eumtj3
   5ulF/YNaVo2/8l1aVL1h1+LC6BSJcwkoLYg6jOlWca6MCmhY+Zk5VBjrc
   PmWshr+4DNQbtJfar0biIpSnyE09DBsTrUrqEazWuHwu6SA5IbGe3nz1Z
   GJc71+iIUJlkklhfHoqNEIpO29Xy1lQI9RUxdjdSaOZRTxcI3I03QPB9B
   g==;
X-CSE-ConnectionGUID: WjsVgn8FSQOjVUUM3YCVkQ==
X-CSE-MsgGUID: cI8KLDDgRo6Of8PFFBrExA==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="87514821"
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; 
   d="scan'208";a="87514821"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 06:37:19 -0700
X-CSE-ConnectionGUID: jwC4U05WSa2cmRUSykzWFA==
X-CSE-MsgGUID: 7WXHSTqhRDeJuoUTvMSnCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; 
   d="scan'208";a="258717198"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.67])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 06:37:16 -0700
Date: Mon, 17 Aug 2026 16:37:13 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Esben Haabendal <esben@geanix.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Esben Haabendal <esbenhaabendal@gmail.com>
Subject: Re: [PATCH] Input: gpio_decoder - fix bit order reversal introduced
 by bitmap conversion
Message-ID: <aoMOiZNrbOtRgXu-@ashevche-desk.local>
References: <20260817-gpio-decoder-bitrev-v1-1-6ffb77e323b8@geanix.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817-gpio-decoder-bitrev-v1-1-6ffb77e323b8@geanix.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 17, 2026 at 01:50:27PM +0200, Esben Haabendal wrote:
> The switch from a manual loop to gpiod_get_array_value_cansleep() +
> bitmap_read() inadvertently reversed the bit order of the decoded value.
> The original loop treated GPIO[0] as MSB by shifting left on each
> iteration, but bitmap_read() returns GPIO[0] at bit 0 (LSB).
> 
> The previous bit order was correct according to device-tree bindings, and
> the change broke existing users.

Oops, thanks for catching this!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


