Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D65D1E7C03;
	Mon, 15 Jun 2026 00:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781485178; cv=none; b=l/3+b2DdVmhlQtf//AmdnSGRMTyvltolZNoPb7winDDVKUAdWF8foF1H2+3hA0/2lmqCaSFdnUZtXsD1lhpow8LNfT+Z1YGM6OrYMwLyDiJ4IBHBOuL5H/+q6OoYHCo9GgNwMCEcwJht/recUcRQN+oFd3dLstEaO1RdZGg9g+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781485178; c=relaxed/simple;
	bh=GvzcFmDoKn2j61FPJppk4b/2L7xwpyTxsJdRLuDHZGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ClGLy3KgqZj9U1xOyQn0uAwzStdxrrh4EizUtbP9kZ/Vbp9MPG+b2DR1hriVumSh3aQ+7gPoNrQlQ8vdLGtenNomgHffqIxVdIsFRHMjXzEP4y54H4+HlWsUIF1z+iNRmqWShi/m7GiritYq1ul9KIWHsgSGPsibgieoKUYF1c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J6y7rilT; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J6y7rilT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781485177; x=1813021177;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GvzcFmDoKn2j61FPJppk4b/2L7xwpyTxsJdRLuDHZGM=;
  b=J6y7rilTakBlSaBchHwDJoe63Bg0i3m8gNazjO139HwOolMd6XfXv+Ft
   dXCcFe9qrFjL2QWLz/IFDw3GzxUhf6xak4cYIDzE7Zk85S7l2d3JqCmqp
   mETm40+/tLuzIBtTLL5ECH99R2BQuKdumv5qFtDXfmkipm79pTiixyYba
   PtzsNwdr6PfQoM0yCJB7AtsjO07IczTiFBtEBeaRgB5VBuOQ9jJJ7DOpB
   aXtzUaN31Zui6Pu4QTdoxXqRxHnhXMhWv5vQN1kEcCGxInnVo29CjAkiU
   hTvTL7Ae11vZINLZ0GJdToethFIT8+nyuMPlH72850V6M4dsQDuPLBoKr
   A==;
X-CSE-ConnectionGUID: 3/MWPdaKQvKoOwwwqLW/eg==
X-CSE-MsgGUID: ygS2ZJGiRyGH5bWpPoxCng==
X-IronPort-AV: E=McAfee;i="6800,10657,11817"; a="93339250"
X-IronPort-AV: E=Sophos;i="6.24,205,1774335600"; 
   d="scan'208";a="93339250"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 17:59:35 -0700
X-CSE-ConnectionGUID: 7Z/un19+RbG+4st5CYsTFw==
X-CSE-MsgGUID: Cy/u5eTMS2uI271e1+3yGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,205,1774335600"; 
   d="scan'208";a="244418393"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 17:59:31 -0700
Message-ID: <96a18944-bc0d-47dd-b435-e9aa63b93c43@linux.intel.com>
Date: Mon, 15 Jun 2026 08:59:29 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v3 1/8] perf/x86/intel: Remove anythread_deprecated bit
 from perf_capabilities
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
References: <20260612090114.3188886-1-dapeng1.mi@linux.intel.com>
 <20260612090114.3188886-2-dapeng1.mi@linux.intel.com>
 <20260612094648.GB42921@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260612094648.GB42921@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 6/12/2026 5:46 PM, Peter Zijlstra wrote:
> On Fri, Jun 12, 2026 at 05:01:07PM +0800, Dapeng Mi wrote:
>> AnyThread mode deprecation is enumerated by CPUID.0AH:EDX[15] instead of
>> PERF_CAPABILITIES MSR. It's not a good practice to define a bit to
>> represent "anythread deprecation" in perf_capabilities. It leads to the
>> anythread_deprecated bit could be overwritten by the real value of
>> PERF_CAPABILITIES MSR, just like the below code in update_pmu_cap() does.
>>
>> ```
>> if (!intel_pmu_broken_perf_cap()) {
>> 	/* Perf Metric (Bit 15) and PEBS via PT (Bit 16) are hybrid enumeration */
>> 	rdmsrq(MSR_IA32_PERF_CAPABILITIES, hybrid(pmu, intel_cap).capabilities);
>> }
>> ```
>>
>> It leads to the anythread_deprecated bit is cleared to 0 and the "any"
>> attribute is incorrectly shown in the /sys/devices/cpu/format/ folder on
>> these support Perfmon v6 platforms, like Clearwater Forest.
>>
>> ```
>> $grep . /sys/devices/cpu/format/*
>> /sys/devices/cpu/format/acr_mask:config2:0-63
>> /sys/devices/cpu/format/any:config:21
>> /sys/devices/cpu/format/cmask:config:24-31
>> ```
>>
>> So remove the anythread_deprecated bit from perf_capabilities structure
>> and directly depends on CPUID.0AH:EDX[15] to judge if anythread is
>> deprecated.
> Again, no markdown please. I've stripped it from these patches.

My bad. Thanks a lot.

BTW, Peter, have you pull these patches? I didn't see them in perf/core or
perf/urgent branches. Sashiko reports a defect about "Patch 5/8:
perf/x86/intel: Validate the return value of intel_pmu_init_hybrid()". If
not, I would post a v4 patchset to fix the defect. Thanks.


