Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1313941BA83;
	Tue, 28 Jul 2026 09:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785229981; cv=none; b=rIHfzspahUp9E7RPS6ULnAMv/SwjNYpY/ARe7cG4ZAETsmNbdRoFnBXWLBrfotqCrqwXZAdu1WeY2CbI5hkashRnCQdjeQfBHfhr27MK2YA/qmgDkpqMHq8nlRW24XarQoGp+FBbUZCsfH0NL/tWmoAX91sTv7oq7ARf3DkAPk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785229981; c=relaxed/simple;
	bh=2Y5Ddy6YBpNukUMpkjHulXxHsH+jwexPsJuHKpaSEMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UzCZGoS7gKrXoQFcuN9RxaBK75xzId+usOc0W84gOdbb3ppEpNNpv0PgcVGhwZ5nDvG04JKutF49Oo9ZwFJCKnarZhbX4WdzlBru6pdwJnuf7110v0k8cTMGJHnpBsCGR53O0EGoH4/LREjvNhWnbJjBCXzzoZVak0UfNLtxCek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IlwnkKV8; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IlwnkKV8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785229979; x=1816765979;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2Y5Ddy6YBpNukUMpkjHulXxHsH+jwexPsJuHKpaSEMk=;
  b=IlwnkKV8mJAmqrqiOAsZrJQPRm1MUpTvL/q9oIT32fWZF4HjaK5eREC7
   7LffqAKqFXskO0ZL1jfXa3GHFo9pbkJo5yFk8cD/UYUqmvZqvnSdXVUvN
   gkyx+ckiWW9AbzQCevIspw+PYBSdELhoWFtJsIpIDJCkrffy1wiMguPCh
   ihLI4zLu7Y9TeD0GqDNtqY6CDp9oK/kYxiQWTnHngdV9fLumQ+Xe+6xL5
   0B/QV2s9jAgHLlfoLjqVE5pfE1X/hbZrpDaRklPvM6sKPS/meSiGY4jEb
   hEb/lL5Gwb/G+AnMKl7S+qUKixouA1sMvvfTpTEebT7k1+0fvp6CFSwUG
   A==;
X-CSE-ConnectionGUID: PKNqChOhTu6nWPL7ftNwMg==
X-CSE-MsgGUID: vvYJRIDkTU23FadQTehM9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="89630624"
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; 
   d="scan'208";a="89630624"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 02:12:58 -0700
X-CSE-ConnectionGUID: t+8rU5ebQz2149ZgRoJYvA==
X-CSE-MsgGUID: wOppPnCwRO2HuwR1JWRHrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; 
   d="scan'208";a="263438311"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO [10.245.244.93]) ([10.245.244.93])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 02:12:56 -0700
Message-ID: <35af8a6d-6303-4dc8-a2fb-f10a1e4968dd@linux.intel.com>
Date: Tue, 28 Jul 2026 12:12:53 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] xhci: dbgtty: Fix unregister on tty_register_driver()
 failure
To: Lucas De Marchi <ldemarchi@nvidia.com>,
 Mathias Nyman <mathias.nyman@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 demarchi@kernel.org, stable@vger.kernel.org
References: <20260720202716.76000-1-ldemarchi@nvidia.com>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20260720202716.76000-1-ldemarchi@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/20/26 23:27, Lucas De Marchi wrote:
> If tty_register_driver() fails, it drops the reference, but fails to set
> the global dbc_tty_driver to NULL, causing the unregister to be called
> again when module exits.
> 
> On module unload dbc_tty_exit() only gates its cleanup on the driver
> pointer being non-NULL, so it operates on the already-freed driver:
> 
>      module_init(xhci_hcd_init)
>        xhci_hcd_init()
>          xhci_dbc_init()                       [return value ignored]
>            dbc_tty_init()
>              tty_register_driver() fails
>                tty_driver_kref_put()           -> driver freed
>                (dbc_tty_driver left dangling)
>      ...
>      module_exit(xhci_hcd_fini)
>        xhci_hcd_fini()
>          xhci_dbc_exit()
>            dbc_tty_exit()
>              if (dbc_tty_driver)               -> true (dangling)
>                tty_unregister_driver()         -> use-after-free
> 
> Fixes: 4521f1613940 ("xhci: dbctty: split dbc tty driver registration and unregistration functions.")
> Cc: stable@vger.kernel.org # v5.10
> Cc: Mathias Nyman <mathias.nyman@linux.intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Lucas De Marchi <ldemarchi@nvidia.com>
> ---

Thanks

Added series to queue

-Mathias
