Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB96534E744;
	Sun,  6 Sep 2026 19:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788721978; cv=none; b=cjJmy55aTU4rQmi+na7SDfgmWic5gbMjhBLda7Vw2GK+eOOEVkkkV3DfJkcVXph4DdfXgQUZZXKjj8lhEa3naMTnmQWv9qCoqCKcfdlhCn0hOirT0YH6f1L11vyZ89z4A0EfbbHx3IVqJPNpdUHsHXgqh9JfHrooiMdrgP/g7xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788721978; c=relaxed/simple;
	bh=ARZSddmj0XeCLuMzroyiL4lLcJIWgmzqmeDwixSxUgw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DoZOQTJWg4bBaGfOI50uHoEBIg5vapbTXqVGZxJmhc2cXMRCSRhoUfK0/cA10NjCvxX7DI7Ez6km8IbeXnZP+EJidstSUR2RieK8gEzECVy4yH8gdTVt6cjxQeicaJJ0G8eQqq6xkW/EfArmDDo9f/hViMpfOLf0r4EUUkCo41M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mbscmGdn; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mbscmGdn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788721976; x=1820257976;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ARZSddmj0XeCLuMzroyiL4lLcJIWgmzqmeDwixSxUgw=;
  b=mbscmGdn4JvdLG+41HIZgCUuHQXsEoRnVsYZ3HX9IeTLmD5AXexFewfS
   8U8MY4i9QzGCKAyLiE+/iwZ2LzOKgTnoPcqONxdCIj2196XaXqKQIGfby
   CK+s6BYiXOvN+Gsv4nuCQZnEOG3RyI9mrUCLFHPVnEqM18WeL5v1Q3thY
   G8HemxOyeVSH59TNvQautQMO4nVnYzVKKtx6nFKGYKrW4EN5ArIWg0b1k
   TrYYOYobNlS8ffCNN5/wIK1rOOUmAeYMnvoYz1JK3CtyCwevJ0IcnAgrd
   MLFiWM9uuuw4/vI9XJdWxEhiIdjuCaFBhIVnev4+CXoWH/6OSHFyQAWdm
   g==;
X-CSE-ConnectionGUID: gbtx83M1SdOc2DICiu4OAg==
X-CSE-MsgGUID: E9qcZpMWSZm9zqLEMOBWUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11898"; a="111912884"
X-IronPort-AV: E=Sophos;i="6.25,265,1779174000"; 
   d="scan'208";a="111912884"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2026 12:12:56 -0700
X-CSE-ConnectionGUID: cQyrjwFrTQGOkpYRj2GVaQ==
X-CSE-MsgGUID: oMRqnj9XTdmrG3bhpI3Y2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,265,1779174000"; 
   d="scan'208";a="270012387"
Received: from smithj1-mobl2.amr.corp.intel.com (HELO [10.125.111.58]) ([10.125.111.58])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2026 12:12:55 -0700
Message-ID: <1987b7d6-7aa3-4bcd-9082-f2cdfde7c1e4@intel.com>
Date: Sun, 6 Sep 2026 12:12:54 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [tip: x86/urgent] x86/mm/pat: Fix effective RW computation in
 lookup_address_in_pgd_attr()
To: Nathan Chancellor <nathan@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, Dave Hansen
 <dave.hansen@linux.intel.com>, linux-tip-commits@vger.kernel.org,
 Juergen Gross <jgross@suse.com>, "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 syzbot@syzkaller.appspotmail.com, Atish Patra <atishp@meta.com>,
 Nikunj A Dadhania <nikunj@amd.com>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
References: <20260813-cpa-fixes-v2-5-39b4ff90f91d@kernel.org>
 <178837401172.3717435.314324339347590321.tip-bot2@tip-bot2>
 <20260905044253.GA3816371@ax162>
 <b3fe6376-bd3f-4c58-8698-abcca3ad7186@intel.com>
 <20260906181247.GA1148584@ax162>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20260906181247.GA1148584@ax162>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/6/26 11:12, Nathan Chancellor wrote:
> On Sun, Sep 06, 2026 at 07:50:26AM -0700, Dave Hansen wrote:
>> On 9/4/26 21:42, Nathan Chancellor wrote:
>>> I just bisected the following warning on a couple of my test machines to
>>> commit 453e78594434 ("x86/mm/pat: Fix effective RW computation in
>>> lookup_address_in_pgd_attr()") in next-20260904.
>> ...
>>> If there is any information I can provide to help debug this, I am happy
>>> to provide it.
>>
>> Well, the thing you bisected to is the patch that fixes the warning. The
> 
> Hmmm, I don't see a warning prior to this patch though. Do you mean that
> this patch is just revealing the bad behavior that you mention below?

Yeah, "fixes" was a bad word to use.

The W^X detection has been broken for a while. The patch you bisected to
fixes the W^X detection. It doesn't actually cause the issue.

>> actual issue comes from:
>>
>>         if (pages == &its_pages)
>>                 set_memory_x((unsigned long)page, 1);
>>
>> which its_alloc() does on an execmem allocation. Any chance you could
>> get the output of:
>>
>> 	/sys/kernel/debug/page_tables/current_kernel
>>
>> for the page that page that it's complaining about? I'm curious if this
>> is temporary or permanent.
> 
> Sure. For
> 
>    CPA detected W^X violation: 8000000000000123 -> 0000000000000123 range: 0xffffffffc0200000 - 0xffffffffc0200fff PFN 100e00
> 
> I think it is this line if I understand correctly?
> 
>   0xffffffffc0200000-0xffffffffc0400000           2M     ro         PSE     GLB x  pmd

Yeah, that does seems to show it getting fixed up. Thanks! That means
that the warning (at least in early boot) is essentially a false
positive. The problem is that there's module-load-time patching too and
that is much later and is arguably an actual problem.

Oh, and thinking about it a bit more... This warning came from
alternatives patching which is too early for normal text_poke(), thus
the existence of text_poke_early().

Anyway, I'm curious what Peter wants to do with this.
