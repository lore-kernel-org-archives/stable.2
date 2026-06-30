Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006D33E7BC4;
	Tue, 30 Jun 2026 09:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782810890; cv=none; b=CWyU7JlWhng0BcBvK04EhAGJJFOXeOUqd6kC8zMuUJEJmKCRndGyUb2S3MVCFSkI6hqMcCmTtMW2+8V3ktCYgAMoHALckedi/eHXQgFoZm5bGWtIzLavc0wbhZjWZDoH+j7ULRiWCW3bg6/m4BxwiAvx8I6cb5q/nSYsiRH9TgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782810890; c=relaxed/simple;
	bh=6lQFdWznq+BLbi+99Oc1Lczbvo6VTG6ewbkZj6xMA8U=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=CiN9kO6sxkbDZ+rXL4w6vdlet7fNFd1L6iMnm99kGUovY1tm8nj7QRpzJgPacna99v6aFmL/Jz+P40MEbWJJi2GGH5sK5zEmgMqVTH5BzS3V5H3ZI8rigsdoUpiIcO4MRCwv5KmRAg6M+80kxz3ZaL+u/k+dmbNATRAGHUKFkt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BBTeNj32; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BBTeNj32"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782810889; x=1814346889;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=6lQFdWznq+BLbi+99Oc1Lczbvo6VTG6ewbkZj6xMA8U=;
  b=BBTeNj32XRexjuG5CdpUvHIimjLymyh0lFsGrEULxbmzO0zj2OEqOYt+
   rfMfhY29Iuyf7At6HgCryE/r+kB/ZlBXuer/ezvkBv1Yguobvz2oIgn2A
   WVSSa6joC2xirJBIr8uYXnEZeEnrlBR2QFYBvkNkuNduiGWH9v8lhb0NU
   pRTJn4x8ARPHDQpqqPxXuLWVO5kWIT/oY6dEp5TfkSDRolT5uGciq6cCg
   EEfBVVY6cHVeqkuEhJXPNEGxctglmnk4x2ODSoUob6/QWTdV0WisGJ8iQ
   GqnXjN4ctWxagWP+qyaWRE8ZWkEa9hCgpz7S3shlw1dKV1k6EKaAdF8je
   Q==;
X-CSE-ConnectionGUID: 1XJioo8FTfC4Kj556y3dIw==
X-CSE-MsgGUID: +uKARftzTWuB11QW9JNCRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="94117608"
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="94117608"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 02:14:48 -0700
X-CSE-ConnectionGUID: xMxvLKDITRSeHD1a5z3YjQ==
X-CSE-MsgGUID: R+JEnplvRFqZmS+MRchD8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="252349250"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.232.65]) ([10.124.232.65])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 02:14:45 -0700
Message-ID: <27d77639-a948-4f0f-8cb5-1d06966bac0f@linux.intel.com>
Date: Tue, 30 Jun 2026 17:14:41 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v3 1/8] perf/x86/intel: Remove anythread_deprecated bit
 from perf_capabilities
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
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
 <96a18944-bc0d-47dd-b435-e9aa63b93c43@linux.intel.com>
 <20260616100202.GJ42921@noisy.programming.kicks-ass.net>
 <47a9642f-68ab-432c-a607-548995bd82fa@linux.intel.com>
Content-Language: en-US
In-Reply-To: <47a9642f-68ab-432c-a607-548995bd82fa@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 6/17/2026 8:14 AM, Mi, Dapeng wrote:
> On 6/16/2026 6:02 PM, Peter Zijlstra wrote:
>> On Mon, Jun 15, 2026 at 08:59:29AM +0800, Mi, Dapeng wrote:
>>> On 6/12/2026 5:46 PM, Peter Zijlstra wrote:
>>>> On Fri, Jun 12, 2026 at 05:01:07PM +0800, Dapeng Mi wrote:
>>>>> AnyThread mode deprecation is enumerated by CPUID.0AH:EDX[15] instead of
>>>>> PERF_CAPABILITIES MSR. It's not a good practice to define a bit to
>>>>> represent "anythread deprecation" in perf_capabilities. It leads to the
>>>>> anythread_deprecated bit could be overwritten by the real value of
>>>>> PERF_CAPABILITIES MSR, just like the below code in update_pmu_cap() does.
>>>>>
>>>>> ```
>>>>> if (!intel_pmu_broken_perf_cap()) {
>>>>> 	/* Perf Metric (Bit 15) and PEBS via PT (Bit 16) are hybrid enumeration */
>>>>> 	rdmsrq(MSR_IA32_PERF_CAPABILITIES, hybrid(pmu, intel_cap).capabilities);
>>>>> }
>>>>> ```
>>>>>
>>>>> It leads to the anythread_deprecated bit is cleared to 0 and the "any"
>>>>> attribute is incorrectly shown in the /sys/devices/cpu/format/ folder on
>>>>> these support Perfmon v6 platforms, like Clearwater Forest.
>>>>>
>>>>> ```
>>>>> $grep . /sys/devices/cpu/format/*
>>>>> /sys/devices/cpu/format/acr_mask:config2:0-63
>>>>> /sys/devices/cpu/format/any:config:21
>>>>> /sys/devices/cpu/format/cmask:config:24-31
>>>>> ```
>>>>>
>>>>> So remove the anythread_deprecated bit from perf_capabilities structure
>>>>> and directly depends on CPUID.0AH:EDX[15] to judge if anythread is
>>>>> deprecated.
>>>> Again, no markdown please. I've stripped it from these patches.
>>> My bad. Thanks a lot.
>>>
>>> BTW, Peter, have you pull these patches? I didn't see them in perf/core or
>>> perf/urgent branches. Sashiko reports a defect about "Patch 5/8:
>>> perf/x86/intel: Validate the return value of intel_pmu_init_hybrid()". If
>>> not, I would post a v4 patchset to fix the defect. Thanks.
>>>
>> I had them in queue:perf/core, but realized it was *really* late in the
>> window. I'll probably move them into tip post -rc1. If there's a new
>> version by then, I'll be sure to pick it up.
> Thanks Peter. I posted the v4 patchset yesterday to fix the defect of
> Sashiko. Please pick up the v4 version. Here is the v4 patchset link. 
>
> https://lore.kernel.org/all/20260616044654.3468742-1-dapeng1.mi@linux.intel.com/

Hi Peter,

Could you please queue above latest v4 patchset
(https://lore.kernel.org/all/20260616044654.3468742-1-dapeng1.mi@linux.intel.com/)
which fixes a defect in patch 5/8  "perf/x86/intel: Validate the return
value of intel_pmu_init_hybrid()"? 

Besides this change, all changes of v4 are same with this v3 patchset? 

Thanks!


>
>
>
