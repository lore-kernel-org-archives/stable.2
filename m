Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF933451BB;
	Tue, 29 Sep 2026 15:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790697451; cv=none; b=Qx4M5wAgI4Tbbv8PEWCV1M+78osup+JX2CIPJ/7vvX2Tjs+uRWWmcAEUe2zhH1PHRdD77j3Vs8+DCR4dIsR0aAmw5jSZpjGSywoLNETPs0bQWGDMPS1urx4nJ7fNGj8YzhzS4aLj/4r59E/SUsgemwI1MTeLuSgldv3I/CfP2pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790697451; c=relaxed/simple;
	bh=nplzv4/H8WZJY03fdbtUd2cEkHTRbiZvUXdyFwV5sHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WmIqCOuxZoc83X6VzgQWDjonIKmF+hD75WEOP2wsacxF+Ov4qsaAa+bnE0zkRo80xVu9AX/oVFEteTHQ0DRnZ+5AjYXCiSnP7xLVEFBQhPgO6dUyurXW6u4oLbvVFUFoAnFaT3LmNkw6w1m40HyR/V3a2qOHxmS5b40p10UP1Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nbx553qb; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nbx553qb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790697450; x=1822233450;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nplzv4/H8WZJY03fdbtUd2cEkHTRbiZvUXdyFwV5sHg=;
  b=Nbx553qbPD4H6BzU6AFt0BDNH70JIlDJr458rGueChI6vtWO9VevpKVQ
   5SwoBoMcgr6GtdwU/A8wSd21DdqWCg2oySrzJDSJlLstjoKyzyUySWG7V
   K/X7irBoGkoisN1eAm06d+2BNEVm21T2lDv7YgQ7uOTNS9N4LYTdNHVI0
   EZlBcs8HjqxFFzTWwTrzVq4jW+nMMLJfuttwpPEoCd2qgQfMBaN3EcJKY
   q9XsessI7hThrWq+gtL/PxgtTTl0NBcTmoyIUEd4Uczd23s2OvntyZ3Gq
   lHb83ESzmQFKGefKNh2YSNB3RK3i8O9Mcbv54AWkeIvYpQFYc5fpQVeyF
   Q==;
X-CSE-ConnectionGUID: /1FAHWpeTpSw0VGfwDsGig==
X-CSE-MsgGUID: 4r6415SVSgy5mLMqBhMtxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="90282900"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="90282900"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 08:57:29 -0700
X-CSE-ConnectionGUID: qf/DA3rNT7uy8Fa4pxV3+A==
X-CSE-MsgGUID: YRELTodrRCGppx+aCplGWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="279223578"
Received: from vverma7-desk1.amr.corp.intel.com (HELO [10.125.111.116]) ([10.125.111.116])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 08:57:29 -0700
Message-ID: <92104265-aaa2-4594-aea0-29fd1841157e@intel.com>
Date: Tue, 29 Sep 2026 08:57:28 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/fpu: Free dynamic fpstate on exec()
To: Guixiong Wei <weiguixiong@bytedance.com>, x86@kernel.org
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H . Peter Anvin" <hpa@zytor.com>, "Chang S . Bae"
 <chang.seok.bae@intel.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260929151013.81562-2-weiguixiong@bytedance.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 xsFNBE6HMP0BEADIMA3XYkQfF3dwHlj58Yjsc4E5y5G67cfbt8dvaUq2fx1lR0K9h1bOI6fC
 oAiUXvGAOxPDsB/P6UEOISPpLl5IuYsSwAeZGkdQ5g6m1xq7AlDJQZddhr/1DC/nMVa/2BoY
 2UnKuZuSBu7lgOE193+7Uks3416N2hTkyKUSNkduyoZ9F5twiBhxPJwPtn/wnch6n5RsoXsb
 ygOEDxLEsSk/7eyFycjE+btUtAWZtx+HseyaGfqkZK0Z9bT1lsaHecmB203xShwCPT49Blxz
 VOab8668QpaEOdLGhtvrVYVK7x4skyT3nGWcgDCl5/Vp3TWA4K+IofwvXzX2ON/Mj7aQwf5W
 iC+3nWC7q0uxKwwsddJ0Nu+dpA/UORQWa1NiAftEoSpk5+nUUi0WE+5DRm0H+TXKBWMGNCFn
 c6+EKg5zQaa8KqymHcOrSXNPmzJuXvDQ8uj2J8XuzCZfK4uy1+YdIr0yyEMI7mdh4KX50LO1
 pmowEqDh7dLShTOif/7UtQYrzYq9cPnjU2ZW4qd5Qz2joSGTG9eCXLz5PRe5SqHxv6ljk8mb
 ApNuY7bOXO/A7T2j5RwXIlcmssqIjBcxsRRoIbpCwWWGjkYjzYCjgsNFL6rt4OL11OUF37wL
 QcTl7fbCGv53KfKPdYD5hcbguLKi/aCccJK18ZwNjFhqr4MliQARAQABzUVEYXZpZCBDaHJp
 c3RvcGhlciBIYW5zZW4gKEludGVsIFdvcmsgQWRkcmVzcykgPGRhdmUuaGFuc2VuQGludGVs
 LmNvbT7CwXgEEwECACIFAlQ+9J0CGwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEGg1
 lTBwyZKwLZUP/0dnbhDc229u2u6WtK1s1cSd9WsflGXGagkR6liJ4um3XCfYWDHvIdkHYC1t
 MNcVHFBwmQkawxsYvgO8kXT3SaFZe4ISfB4K4CL2qp4JO+nJdlFUbZI7cz/Td9z8nHjMcWYF
 IQuTsWOLs/LBMTs+ANumibtw6UkiGVD3dfHJAOPNApjVr+M0P/lVmTeP8w0uVcd2syiaU5jB
 aht9CYATn+ytFGWZnBEEQFnqcibIaOrmoBLu2b3fKJEd8Jp7NHDSIdrvrMjYynmc6sZKUqH2
 I1qOevaa8jUg7wlLJAWGfIqnu85kkqrVOkbNbk4TPub7VOqA6qG5GCNEIv6ZY7HLYd/vAkVY
 E8Plzq/NwLAuOWxvGrOl7OPuwVeR4hBDfcrNb990MFPpjGgACzAZyjdmYoMu8j3/MAEW4P0z
 F5+EYJAOZ+z212y1pchNNauehORXgjrNKsZwxwKpPY9qb84E3O9KYpwfATsqOoQ6tTgr+1BR
 CCwP712H+E9U5HJ0iibN/CDZFVPL1bRerHziuwuQuvE0qWg0+0SChFe9oq0KAwEkVs6ZDMB2
 P16MieEEQ6StQRlvy2YBv80L1TMl3T90Bo1UUn6ARXEpcbFE0/aORH/jEXcRteb+vuik5UGY
 5TsyLYdPur3TXm7XDBdmmyQVJjnJKYK9AQxj95KlXLVO38lczsFNBFRjzmoBEACyAxbvUEhd
 GDGNg0JhDdezyTdN8C9BFsdxyTLnSH31NRiyp1QtuxvcqGZjb2trDVuCbIzRrgMZLVgo3upr
 MIOx1CXEgmn23Zhh0EpdVHM8IKx9Z7V0r+rrpRWFE8/wQZngKYVi49PGoZj50ZEifEJ5qn/H
 Nsp2+Y+bTUjDdgWMATg9DiFMyv8fvoqgNsNyrrZTnSgoLzdxr89FGHZCoSoAK8gfgFHuO54B
 lI8QOfPDG9WDPJ66HCodjTlBEr/Cwq6GruxS5i2Y33YVqxvFvDa1tUtl+iJ2SWKS9kCai2DR
 3BwVONJEYSDQaven/EHMlY1q8Vln3lGPsS11vSUK3QcNJjmrgYxH5KsVsf6PNRj9mp8Z1kIG
 qjRx08+nnyStWC0gZH6NrYyS9rpqH3j+hA2WcI7De51L4Rv9pFwzp161mvtc6eC/GxaiUGuH
 BNAVP0PY0fqvIC68p3rLIAW3f97uv4ce2RSQ7LbsPsimOeCo/5vgS6YQsj83E+AipPr09Caj
 0hloj+hFoqiticNpmsxdWKoOsV0PftcQvBCCYuhKbZV9s5hjt9qn8CE86A5g5KqDf83Fxqm/
 vXKgHNFHE5zgXGZnrmaf6resQzbvJHO0Fb0CcIohzrpPaL3YepcLDoCCgElGMGQjdCcSQ+Ci
 FCRl0Bvyj1YZUql+ZkptgGjikQARAQABwsFfBBgBAgAJBQJUY85qAhsMAAoJEGg1lTBwyZKw
 l4IQAIKHs/9po4spZDFyfDjunimEhVHqlUt7ggR1Hsl/tkvTSze8pI1P6dGp2XW6AnH1iayn
 yRcoyT0ZJ+Zmm4xAH1zqKjWplzqdb/dO28qk0bPso8+1oPO8oDhLm1+tY+cOvufXkBTm+whm
 +AyNTjaCRt6aSMnA/QHVGSJ8grrTJCoACVNhnXg/R0g90g8iV8Q+IBZyDkG0tBThaDdw1B2l
 asInUTeb9EiVfL/Zjdg5VWiF9LL7iS+9hTeVdR09vThQ/DhVbCNxVk+DtyBHsjOKifrVsYep
 WpRGBIAu3bK8eXtyvrw1igWTNs2wazJ71+0z2jMzbclKAyRHKU9JdN6Hkkgr2nPb561yjcB8
 sIq1pFXKyO+nKy6SZYxOvHxCcjk2fkw6UmPU6/j/nQlj2lfOAgNVKuDLothIxzi8pndB8Jju
 KktE5HJqUUMXePkAYIxEQ0mMc8Po7tuXdejgPMwgP7x65xtfEqI0RuzbUioFltsp1jUaRwQZ
 MTsCeQDdjpgHsj+P2ZDeEKCbma4m6Ez/YWs4+zDm1X8uZDkZcfQlD9NldbKDJEXLIjYWo1PH
 hYepSffIWPyvBMBTW2W5FRjJ4vLRrJSUoEfJuPQ3vW9Y73foyo/qFoURHO48AinGPZ7PC7TF
 vUaNOTjKedrqHkaOcqB185ahG2had0xnFsDPlx5y
In-Reply-To: <20260929151013.81562-2-weiguixiong@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/29/26 08:10, Guixiong Wei wrote:
> Make fpstate_free() operate on the fpstate pointer itself so it can
> free the detached allocation. Use it for the existing reallocation
> and task release paths as well.

I had to stare at this for a moment to get what was going on. This is
trying to say something like:

	fpstate_free() only frees the fpstate currently associated with
	a 'struct fpu'. It is unable to free an fpstate that has been
	detached from the fpu, such as after a reset.

> On an AMX-capable system, 1000 iterations of requesting XTILEDATA
> permission, executing TILEZERO and calling execve() on the same image
> left 1000 16 KiB allocations attributed to __xfd_enable_feature() in
> /proc/vmallocinfo. None remained after this change.

I really value being succinct in these changelogs. Both the subject and
the changelog don't really get to the point. Shouldn't this be:

	x86/fpu: Fix memory leak with dynamic fpstate and exec()

?

In the changelog, shouldn't it say "leak" somewhere?

>  void fpu_flush_thread(void)
>  {
> -	fpstate_reset(x86_task_fpu(current));
> +	struct fpu *fpu = x86_task_fpu(current);
> +	struct fpstate *oldfpstate = fpu->fpstate;
> +
> +	fpstate_reset(fpu);
>  	fpu_reset_fpstate_regs();
> +
> +	/*
> +	 * Free the old state only after register state ownership has been
> +	 * invalidated. Otherwise, a context switch could save into it.
> +	 */
> +	fpstate_free(oldfpstate);
>  }

I'm not sure I like where this lands.

The problem with the code now is that it expects it is always OK to call
fpstate_reset(). In fact, it is dangerous to call fpstate_reset() on any
fpu that has dynamic state allocated because it will be leaked.

The patch fixes one of the call sites of fpstate_reset() but didn't make
fpstate_reset() itself any safer.

Wouldn't this be simpler and more foolproof against new users?

 void fpstate_reset(struct fpu *fpu)
 {
+	/* Free dynamic fpstate (if any) before resetting pointer: */
+	fpstate_free(fpu);

        /* Set the fpstate pointer to the default fpstate */
        fpu->fpstate = &fpu->__fpstate;
        __fpstate_reset(fpu->fpstate);

It will mean one more change in fpu_clone(), but I think that's OK:

 int fpu_clone(struct task_struct *dst, u64 clone_flags, bool minimal,
               unsigned long ssp)
 {

        /* The new task's FPU state cannot be valid in the hardware. */
        dst_fpu->last_cpu = -1;

+	/* Break the link to the other FPU's fpstate:  */
+	dst_fpu->fpstate = NULL;
        fpstate_reset(dst_fpu);

I'd much rather special case clone() than the other paths.
