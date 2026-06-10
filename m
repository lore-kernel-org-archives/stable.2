Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C0F1A6824;
	Wed, 10 Jun 2026 01:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781056687; cv=none; b=FBJNPn78690W6htUANKVc5Mr38knS9xr1gLxvsqd/sLWGHtdxmCZkGzyVNAuNr0bAE5CqF4nV/bv524HLnneHRy/unxfsMpfVPB5dXgJNK9lONUv/qnZwBa5WjAK5vj1b6xJ3Ekgh7huYICWYKN/bZ2B8zpZ27yP9RhbJC95obE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781056687; c=relaxed/simple;
	bh=Q4j0ls/UCfJrw9HSNbY3NapJ+F1R4VCFbMF19Wx2MPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZC3Zq6MitZQrar+2Io24hx2XySA0Bof65YjzGo8hfoTev9coGddzEmwJ81biMhCehsGO+lUaFwuT6G1HbDBvZwBzky19bnmuAPcIK89RFl6loPFaPO1ZuJYIba1Gepc3fOpIK/ij1bFmxyPDfvUnsYuQ1XYGMrwWTlq4xuIpmRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SUBlfSh9; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SUBlfSh9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781056685; x=1812592685;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Q4j0ls/UCfJrw9HSNbY3NapJ+F1R4VCFbMF19Wx2MPA=;
  b=SUBlfSh97qZCD69qiG+U1KC/3v0PUEGhJ+MIwyoo0RWI+fgSLkaazJxa
   N44/YLvy9bOvsHsUHPMmOYck7h+eEhEpEuIa1+Ly2RBYqt9P5ze5nX/ko
   BySRrPE6WifSaAkju5fCUf2TLY3NIJxm6PE/b80bV/LKfxzoKeeD/jKyL
   1rxjehQeipJITokOXj2pPrzCAnyDbQr1XhgAfhrO3dHTK3oS+x7PcU+aK
   kPvjsq6/BEQzUltOT4g9MYfMEUhvGB1nzW035MqmPiRZMNnw4wCwSYXTB
   L898ZSfoxFHpaR9F99TCnrKP0L78NweAhSTsgXmnsaZOS6CzD3VMWyiJA
   w==;
X-CSE-ConnectionGUID: ms3JBe/ASmK0KvyUKTCtjg==
X-CSE-MsgGUID: FL7cvQL2TpK/4Vc/GoyYSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="99415579"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="99415579"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 18:58:05 -0700
X-CSE-ConnectionGUID: 3aTdGoFBREGPJLDvIuHRiA==
X-CSE-MsgGUID: 8YDN1tweTYmKZ1uXGPKD5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="251103418"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 18:58:01 -0700
Message-ID: <257bf622-885b-45cd-bcef-052056a6a58e@linux.intel.com>
Date: Wed, 10 Jun 2026 09:57:59 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 5/9] perf/x86/intel: Drop LBR entries whose privilege
 level mismatches br_sel
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>,
 stable@vger.kernel.org
References: <20260609050222.2458129-1-dapeng1.mi@linux.intel.com>
 <20260609050222.2458129-6-dapeng1.mi@linux.intel.com>
 <20260609145250.GD49951@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260609145250.GD49951@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 6/9/2026 10:52 PM, Peter Zijlstra wrote:
> On Tue, Jun 09, 2026 at 01:02:18PM +0800, Dapeng Mi wrote:
>> Before Arch LBR gained CPL filtering support, a user-only branch stack
>> could still contain kernel addresses. As a result, kernel branch records
>> may be exposed to user space even when PERF_SAMPLE_BRANCH_USER is
>> requested.
>>
>> For example, on Intel Tiger Lake, the following command can still report
>> SYSRET/ERET entries with kernel-space from addresses:
>>
>> ```
>> $./perf record -e cycles:p -o - --branch-filter any,save_type,u -- \
>>  	./perf bench syscall basic --loop 1000 | \
>> 	./perf script -i - --fields brstack|tr ' ' '\n'| \
>> 	grep -E '0x[89a-f][0-9a-f]{15}'
>>
>>     Total time: 0.000 [sec]
>>
>>       0.219000 usecs/op
>>      4,566,210 ops/sec
>> [ perf record: Woken up 1 times to write data ]
>> [ perf record: Captured and wrote 0.551 MB - ]
>> 0xffffffff93c001c8/0x7f12a2b1d647/P/-/-/16959/SYSRET/-
>> 0xffffffff93c001c8/0x7f12a2b1d5c2/P/-/-/17535/SYSRET/-
>> 0xffffffff93c01928/0x7f12a2861000/P/-/-/6719/ERET/-
>> 0xffffffff93c01928/0x7f12a297a000/P/-/-/8575/ERET/-
>> ```
>>
>> The problem is that intel_pmu_lbr_filter() does not fully validate the
>> privilege level of sampled entries. It filters some mismatches based on
>> the branch type and the to address, but it does not reject entries whose
>> from address violates the requested branch privilege filter.
>>
>> Fix this by extending software filtering to validate both from and to
>> addresses against br_sel. Any LBR entry whose privilege level does not
>> match the requested user/kernel filter is dropped. This prevents kernel
>> addresses from appearing in user-only branch stacks, and likewise drops
>> user entries from kernel-only stacks.
>>
>> Cc: stable@vger.kernel.org
>> Reported-by: Ian Rogers <irogers@google.com>
>> Fixes: 47125db27e47 ("perf/x86/intel/lbr: Support Architectural LBR")
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> ---
>>  arch/x86/events/intel/lbr.c | 14 +++++++++++---
>>  1 file changed, 11 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
>> index d4c0ed85e1fb..807ce903c972 100644
>> --- a/arch/x86/events/intel/lbr.c
>> +++ b/arch/x86/events/intel/lbr.c
>> @@ -1212,7 +1212,7 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
>>  {
>>  	u64 from, to;
>>  	int br_sel = cpuc->br_sel;
>> -	int i, j, type, to_plm;
>> +	int i, j, type, to_plm, from_plm;
>>  	bool compress = false;
>>  
>>  	/* if sampling all branches, then nothing to filter */
> If there, might as well order those variables in reverse xmas.

Sure. Thanks.


