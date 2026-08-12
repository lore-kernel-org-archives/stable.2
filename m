Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C62423E86;
	Wed, 12 Aug 2026 10:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786531295; cv=none; b=Rfp3wqLQ9OzoEINwvymmM5CV5gJYMnGugR0yFlEh9B8/5RdR8VvIo3Y6LQhI7nti7Aj05dMSrhfgf3BlwBr5DSLblDqHBXYC5vUr7avig98V0Og8WijfkqgQr4BsQmtZG9X4L4C4qzFde3B7yQuG2fLf0uNHnOsU0C7zp2g2uIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786531295; c=relaxed/simple;
	bh=LI69VhETGYnsQTfu2sZYzBewBVSkd5mJT4BTMYbj82M=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BLTQ/ThwbfCRqgHoAGm88tqMFoYgSz+f7vnbuDwTflgoFSiC9pOVAU9g4a1bTx3ToslEjSpIuQ/QEQacis2W4hMVQlYz56ma3AKoeWuXVt4/JVlo11J7mgt8oCUAWAR8A059ugyOTEffj3BxK93EU7cxVALC5OgErF2rO26Apj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GTHYWqYh; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GTHYWqYh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786531294; x=1818067294;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=LI69VhETGYnsQTfu2sZYzBewBVSkd5mJT4BTMYbj82M=;
  b=GTHYWqYhFzh/n4NAZ3KDkJYxzJ//IYGBYLpgwUiJJbGqbhvfMnVvDA7w
   j1hOy51ZIxTj3zIuB5ctDyWHQ60dKSpt9Td8pTm0OnxHpRrL+FJjiSnkH
   HIw7y5FhTuoJoWZqpt9u7eDQBTkIftMTIDohdcuiLeQ1ZSkv/jbIxHFON
   khJkVA3kBBHGxilCve6TflJXb7MtMB/dyBGAJRN0csSf/yKLYNZkcCqai
   mBkkZ5a7PwKUvtja2lc5KjpPb7vIcp6eAG/BYCBDmvCwlEker/QaZTOTw
   mPN15GLxRJYNZlP8Jget8gKLVgyVgew89xhXmn3rR/QUfV5EyeYsV5Cz+
   g==;
X-CSE-ConnectionGUID: VutCw7+xTqOitDq5GGcJRQ==
X-CSE-MsgGUID: xQ5+gFzaQkGv4yMmNNswzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="87202586"
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="87202586"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 03:41:33 -0700
X-CSE-ConnectionGUID: dK+sPNikQUKgeaybNAsM0g==
X-CSE-MsgGUID: m6jAUjNiSQ2WRV/T0alyIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="268755202"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.181])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 03:41:30 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 12 Aug 2026 13:41:26 +0300 (EEST)
To: Muhammad Bilal <meatuni001@gmail.com>
cc: platform-driver-x86@vger.kernel.org, jorge.lopez2@hp.com, 
    Hans de Goede <hansg@kernel.org>, linux@weissschuh.net, 
    LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH 11/13] platform/x86: hp-bioscfg: advance elem past consumed
 array elements in string-attributes
In-Reply-To: <20260803143037.93105-12-meatuni001@gmail.com>
Message-ID: <f337b075-fbb4-db20-8a94-b58b254fd864@linux.intel.com>
References: <20260803143037.93105-1-meatuni001@gmail.com> <20260803143037.93105-12-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 3 Aug 2026, Muhammad Bilal wrote:

> Same defect as the companion fix to enum-attributes.c in this series:
> the PREREQUISITES case consumes "size" consecutive ACPI package
> elements via elem + reqs, but the outer loop only advances "elem" by
> one per iteration, causing the next iteration to misread a leftover
> prerequisite entry as the next property and abort the parse with
> -EIO on the resulting type mismatch.
> 
> Fix by advancing "elem" by (size - 1) after the loop.
> 
> Fixes: e6c7b3e15559 ("platform/x86: hp-bioscfg: string-attributes")
> Cc: stable@vger.kernel.org
> Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
> ---
>  drivers/platform/x86/hp/hp-bioscfg/string-attributes.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/platform/x86/hp/hp-bioscfg/string-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/string-attributes.c
> index fe5a9a3a4ef1..5abec8995911 100644
> --- a/drivers/platform/x86/hp/hp-bioscfg/string-attributes.c
> +++ b/drivers/platform/x86/hp/hp-bioscfg/string-attributes.c
> @@ -233,6 +233,8 @@ static int hp_populate_string_elements_from_package(union acpi_object *string_ob
>  				kfree(str_value);
>  				str_value = NULL;
>  			}
> +			if (size)
> +				elem += size - 1;
>  			break;
>  
>  		case SECURITY_LEVEL:
> 

Hi,

First of all, thanks for working with this driver.

There's no need to do the same fix in n patches. If the problem is the 
same in multiple files, they can be in the same patch. You just need to 
generalize your shortlog prefix a bit when combining.

I'll probably take this series once that is fixed (and after I do a 
deeper review on them changes) ...

... BUT,

This entire driver was merged half-baked, with outstanding comments from 
me unaddressed. One of the most important unaddressed comment related to 
the massive use of copy-pasted code which leads to having the same bug in 
multiple places.

Once this series is done, could you try to look into consolidating similar 
parts in these attribute type files so that there would be a common 
function that is called by each of these attribute type files (and if a 
common function is not possible due to types, perhaps macro could be tried 
instead)? I'd be very welcoming for such a cleanup to finally start 
cleaning up the mess this driver is.

If you extract e.g. hp_populate_integer_elements_from_package() and 
hp_populate_string_elements_from_package() and diff those two functions, 
you'll see what I mean. A struct is even called "common" in the struct
string/integer_data so I expect it could be parsed by a common function.

-- 
 i.

