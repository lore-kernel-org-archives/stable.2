Received: from mta0.migadu.com (out-26.mta0.migadu.com [91.218.175.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E053149C4A1
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 15:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791300626; cv=none; b=Xh0a+EUE10Q3snvHPerlngJxDMRFYnu1UxjucvGqJXSw0iOCqO8xPksoPj58tzB8VEDsLrYiDR+2JKyOm9/BwgCcWHSlxaOu1Lc3EwLtENpyjaxQcKgeqk9ces4hjS0C/mUaa4jOGGlY0hC8usXcIJclauiiHgdNPea2npJTIro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791300626; c=relaxed/simple;
	bh=C84pxLYYf1AcdF5SVJ71El9O7jnOkiH92N9DdKK6uEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m4ey8lLxvvgEZauPqFC/PBJGFFWf5qpb+JyVuBNeC+As/eEjwSs8Q70+cCRsGeux4igmhnKK/LuusEvKMZsP0yDJvjWzhumK+LDywld5mWj1RXiJ/1UGDvd0CgfZ66wzrH1LaMd3cc2kWzoBZPbXkX9y345f8kbxMjoEuITirho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tYEDJmUW; arc=none smtp.client-ip=91.218.175.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tYEDJmUW"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=C84pxLYYf1AcdF5SVJ71El9O7jnOkiH92N9DdKK6uEQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791300620; v=1; x=1791905420;
 b=tYEDJmUWW2H3V2VommmBpD/oDQ5cUdkXrzEmKjc3ntmhybjS2CF36Sry0te5eRJUMA6UnF6I
 8FNsUvhFjF5I13Sf2L+v5vNw4pstj73P1O4XX4VyL3uZg3Wo+g8XHrqXpqLfa40D+3zp80SgEYZ
 ZOyCp+XvGvadGxB4iMcDt9ys=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 06047bbc7ae74eb4;
	Tue, 06 Oct 2026 15:30:15 +0000
X-Mizu-Trace-ID: 06047bbc7ae74eb4
X-Migadu-Flow: FLOW_OUT
Date: Tue, 6 Oct 2026 23:30:37 +0800
From: Chen Yu <chen.yu@linux.dev>
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Chen Yu <yu.c.chen@intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Vishal Badole <Vishal.Badole@amd.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, platform-driver-x86@vger.kernel.org,
	K Prateek Nayak <KPrateek.Nayak@amd.com>,
	Ricardo Neri <ricardo.neri@intel.com>,
	Kayra Cizmeci <kayracizmeci@gmail.com>, stable@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Klaus Kusche <klaus.kusche@computerix.info>
Subject: Re: [PATCH v2] sched/cache: Honor asym packing over cache aware
 scheduling on hybrid systems
Message-ID: <asUT-eR9yteRmB_v@three-body>
References: <77ceef1e51b895760dc5f6c9cde985a1679545b5.1791224900.git.tim.c.chen@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <77ceef1e51b895760dc5f6c9cde985a1679545b5.1791224900.git.tim.c.chen@linux.intel.com>

On Mon, Oct 05, 2026 at 11:29:53AM -0700, Tim Chen wrote:
> Date: Mon,  5 Oct 2026 11:29:53 -0700
> From: Tim Chen <tim.c.chen@linux.intel.com>
> To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
> Cc: Tim Chen <tim.c.chen@linux.intel.com>, Chen Yu <yu.c.chen@intel.com>,
>  Mario Limonciello <mario.limonciello@amd.com>, Vishal Badole
>  <Vishal.Badole@amd.com>, linux-kernel@vger.kernel.org, x86@kernel.org,
>  platform-driver-x86@vger.kernel.org, K Prateek Nayak
>  <KPrateek.Nayak@amd.com>, Ricardo Neri <ricardo.neri@intel.com>, Kayra
>  Cizmeci <kayracizmeci@gmail.com>, stable@vger.kernel.org, Vincent Guittot
>  <vincent.guittot@linaro.org>, Juri Lelli <juri.lelli@redhat.com>, Klaus
>  Kusche <klaus.kusche@computerix.info>
> Subject: [PATCH v2] sched/cache: Honor asym packing over cache aware
>  scheduling on hybrid systems
> X-Mailer: git-send-email 2.32.0
> 
> A regression was reported on an AMD Ryzen AI HX 370 running a cache
> intensive Clang full-LTO link. The little cores run at a much lower
> frequency (3.3 GHz vs 5.1 GHz) and have only half of the L3 cache
> (8 MB vs 16 MB), so pinning such a task to the little-core LLC
> hurts twice, and full-LTO builds slow down dramatically compared to
> pre-cache-aware-scheduling kernels.
> 
> Asym packing and cache aware scheduling express conflicting placement
> strategies. Asym packing wants a task to run on the highest priority CPU,
> whereas cache aware scheduling wants to co-locate the tasks of a process
> on one LLC regardless of the priority of CPUs in that LLC.
> 
> When asym packing tries to migrate task to an idle core that has higher
> priority than source cpu, let asym packing win.  Moving tasks to a higher
> performing idle core will buy more performance than cache co-location.
> 
> Prioritize asym packing over LLC balancing for regular and active load
> balancing.
> 
> Fixes: 23b2b5ccc45c ("sched/cache: Introduce helper functions to enforce LLC migration policy")
> Reported-by: Klaus Kusche <klaus.kusche@computerix.info>
> Closes: https://lore.kernel.org/lkml/2180ea5a-eb28-4152-8d4d-cd00b0c24b2e@computerix.info/
> Suggested-by: Kayra Cizmeci <kayracizmeci@gmail.com>
> Tested-by: Klaus Kusche <klaus.kusche@computerix.info>
> Tested-by: Ricardo Neri <ricardo.neri@intel.com>
> Cc: stable@vger.kernel.org # 7.2.x
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> ---
>

I leveraged AI to test it on top of 7.3.0-rc2 using an emulated hybrid setup on a symmetric
AMD Ryzen 9 8945HX (Zen 4, 16C/32T, two 32 MB L3):

By hacking the AMD pstate driver and QOS to limit the L3 cache ways:

  - LLC0 "big/fast":   CPUs 0-7,16-23, max freq 5.46 GHz, 16 L3 ways (32 MB),
                       ITMT prefcore ranking 236
  - LLC1 "little/slow": CPUs 8-15,24-31, max freq 3.29 GHz, 8 L3 ways (16 MB),
                       ITMT prefcore ranking 100

Workload: an 8-thread pointer-chase ring (24 MB working set).

This patch works as expected:
Before the patch:
                 cache-aware ON       cache-aware OFF
  throughput     ~230 M/s             ~530 M/s           (-56.6%)
  placement      6 of 8 threads       8 threads LLC0
                 stuck on LLC1


After the patch:
                 cache-aware ON       cache-aware OFF
  throughput     520.7 +- 18.3 M/s    512.9 +- 16.6 M/s   (+1.5%, noise)
  placement      8 threads LLC0       8 threads LLC0


Tested-by: Chen Yu <yu.c.chen@intel.com>

thanks,
Chenyu 
