Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907123B42C5;
	Tue, 30 Jun 2026 09:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782812704; cv=none; b=hJlrmPujeUwcBRf8uzPqwruAMgLAQ4Z9X235txQLd/Ev4NeypCUNMdwx/ldqI7M99LnE6r1FCdHBO/ikpMWJxaDVB0Rvbl86TPxRDvHVD60+bkaUnMyARIN/pKGXxGDRJRX1XBW7VUzTRSR8HFC1/4LkqpLf+SgtENVkpE5P3UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782812704; c=relaxed/simple;
	bh=4DOfS0q2fNlZSxTeZ6/JGzRAnFYMAcN2e1WPkYAv+DE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g6mnsNkQV1Eh8JZadfaeYxFv2+JgQ5A7dWFPTZI9790cc8uIT7dQDAjfxRQgo5uSbyXFJ1eMPlqeDrVwc3kyXNOEJrhe6q+11FJS7S/INbkXxBo2fVWCOf35Pv3h4u4O+TGJJVADovAEV6OLyv5VjWJ10DLBCirHV5VxasPT880=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=coTjloB/; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="coTjloB/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782812702; x=1814348702;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4DOfS0q2fNlZSxTeZ6/JGzRAnFYMAcN2e1WPkYAv+DE=;
  b=coTjloB/PFJMlTAaa/XKUUrsIcCwQc0vl6f3p3EIykcleUEAK0oZuMeL
   YqobReYt11wfaqE8HHQ8sMDLBLfZfmBB6L/lEi6LIdwLxfOEIMJyZZz7J
   dm4ry4SJmXd5+eNtmTgQpYdToXATwUVpLk7yUtkAGuTIx9L7rnCp8RIBz
   fHAnskVUBSYcxC5BwTjj1j8OjDu2O2GHXcsJbgPGufG35/QxYr0c3+XEO
   5oEkcDAb7DeHjXp8bPPebxmbey510eB1cFZhkVrUcI9pGgwWQOehN7wua
   mfh92NdIDW6lQuDwbG3IcVHo4Cw2fCZzjOhCl8zwVJh90E8CLowb47k80
   A==;
X-CSE-ConnectionGUID: ju5wRZ/VSqeqK4wOuKjWTg==
X-CSE-MsgGUID: z/mFM3QxTimRpQIMRCcTGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="82509623"
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="82509623"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 02:45:02 -0700
X-CSE-ConnectionGUID: koiyIAHVRr6vwtJThEIs+w==
X-CSE-MsgGUID: T2ttrrZZQ7e3F9tPqzAwDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="251164995"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.232.65]) ([10.124.232.65])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 02:44:57 -0700
Message-ID: <ccf419bb-6b87-450f-a371-5e198fa99e5d@linux.intel.com>
Date: Tue, 30 Jun 2026 17:44:55 +0800
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
 <96a18944-bc0d-47dd-b435-e9aa63b93c43@linux.intel.com>
 <20260616100202.GJ42921@noisy.programming.kicks-ass.net>
 <47a9642f-68ab-432c-a607-548995bd82fa@linux.intel.com>
 <27d77639-a948-4f0f-8cb5-1d06966bac0f@linux.intel.com>
 <20260630094312.GA751831@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260630094312.GA751831@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 6/30/2026 5:43 PM, Peter Zijlstra wrote:
> On Tue, Jun 30, 2026 at 05:14:41PM +0800, Mi, Dapeng wrote:
>> Hi Peter,
>>
>> Could you please queue above latest v4 patchset
>> (https://lore.kernel.org/all/20260616044654.3468742-1-dapeng1.mi@linux.intel.com/)
>> which fixes a defect in patch 5/8  "perf/x86/intel: Validate the return
>> value of intel_pmu_init_hybrid()"? 
>>
> Damn, I knew I was forgetting something :-(
>
> Let me go fix that.

Thanks! :)


