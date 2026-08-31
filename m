Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7780483BCB;
	Mon, 31 Aug 2026 14:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788184917; cv=none; b=REfWMyANKHjYo8iTOjwXdu8aZ5fh9pKupM+w3UjIM058H7PgH2F+Gu7CXnCX+70vS6CKCJT5eOhRxom6Jkepre9w340jGSiveeO8zV7ICpZJG4+pTuRuY1voHSPIVd9PsnSrc8AWvIV6KjHZPTowsQHHstvkJ2dn+g2z3LniztQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788184917; c=relaxed/simple;
	bh=HkkYwCXClHUHEl9NKhPLtAnjzE+iPzvTB7Iy1juXmGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gC5NqyER/EyNlXn4POEbHKdVNff2TBsUSscauJit/Lhq7ZNrD+bsdqA0MPtdmyn//oIsJ9xsiOirLnH5rR+5qxgoGlRQtS63Bx18YO/jg/ehlWb5D3cRyNEcqb9OQC7oCNjh8PhxmTvBIEzo5DvhWd9nV6Y4yO7eRNJ7h9HxtWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LP9CUsrU; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LP9CUsrU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788184916; x=1819720916;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HkkYwCXClHUHEl9NKhPLtAnjzE+iPzvTB7Iy1juXmGE=;
  b=LP9CUsrUFNLJcs7A7ZH6HxhqyuqH5XdGM+QGplpdvN9JZDRpizihKE//
   YKH45ceU9/N+uqiXgaDALOpN0WTjsyclZaUOBGJSYrZqafLVf+AEa98GX
   csYaLQo0HKjR52AsiPKxsPn8jjpnhKbvZ7E0EQFEdKVFRTGOoPpDKUs1a
   rvo7onHM8JBqMFCPa8gS5DFyHBVta+lnW4mM7Jr4gJzdaU4GBRsfzASjh
   wtq+vBfv2OPTLT0UVvxtmqcnZ9t6FpFYJdlE9seoxHyrFDZJD5QXrIYZY
   5HZFFYOPbQZEG7QrkELMA4z2MJotb909h55kRfP3h15jN3lMoGwpvE9oH
   Q==;
X-CSE-ConnectionGUID: FjmHSotdQGGqzS5TQwNxlA==
X-CSE-MsgGUID: bqQ7ut9/SkiWMM/D3YlFIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="98928845"
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="98928845"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 07:01:55 -0700
X-CSE-ConnectionGUID: 8dUHOChJTr68s+J3q4OPoA==
X-CSE-MsgGUID: FaXJbmESQh+RZr77UvssPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="266220646"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.109.248]) ([10.125.109.248])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 07:01:53 -0700
Message-ID: <8c86db41-9270-42c5-b2db-133865d254f7@intel.com>
Date: Mon, 31 Aug 2026 07:01:52 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] stacktrace: Provide arch_in_event_entry_text()
 hook
To: Yuanhe Shu <xiangzao@linux.alibaba.com>, tglx@kernel.org,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org
Cc: hpa@zytor.com, xin@zytor.com, luto@kernel.org, jpoimboe@kernel.org,
 peterz@infradead.org, rostedt@goodmis.org, akpm@linux-foundation.org,
 rdunlap@infradead.org, elver@google.com, andreyknvl@gmail.com,
 glider@google.com, gor@linux.ibm.com, brads@mainlining.org,
 kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260831120221.2874445-1-xiangzao@linux.alibaba.com>
 <20260831120221.2874445-2-xiangzao@linux.alibaba.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20260831120221.2874445-2-xiangzao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/31/26 05:02, Yuanhe Shu wrote:
> +/*
> + * Optional arch hook for event entry text which cannot be placed in
> + * .irqentry.text.  filter_irq_stacks() uses this and the section checks
> + * below to find where a trace entered the kernel, so the ranges are not
> + * necessarily irq-only: on x86 they also cover the exception entry stubs,
> + * and an architecture may deliver syscalls through the same entry text.
> + * A caller that has to tell interrupt entry and syscall entry apart
> + * cannot use this.  An architecture overrides it by defining a macro of
> + * the same name in <asm/sections.h>, next to the markers it tests.
> + */
> +#ifndef arch_in_event_entry_text
> +static inline bool arch_in_event_entry_text(unsigned long addr) { return false; }
> +#endif

As much as I love inflicting x86-isms on generic comments, I don't think
this comment needs to talk about x86. I find the most useful generic
definitions to be like an instruction manual for future arch/
maintainers. Maybe something like:

/*
 * Used to help find where a trace entered the kernel.
 *
 * Architectures use this when event entry text cannot be placed in
 * .irqentry.text alone. Architectures should define their
 * version in <asm/sections.h>.
 */

... and then talk about why x86 needs it in the x86 definition.
