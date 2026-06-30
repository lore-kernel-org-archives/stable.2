Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B6637F01B;
	Tue, 30 Jun 2026 09:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782812602; cv=none; b=TKteSnyzJ5lrqIOUpU3buLdAgBlGCKUl4k7aC6n3VRtR8F0jK8zJ/JctXRMwm0+bTj+/g8HuCV2I/P+Gz1kxBCBuayd0tSego/Wx8BowP/0lisLk4IeY/uUEmfb3WVszicHTPeJ/WBM146vMo6BJQ0tsuR7aUJzSAvLjaXmGVIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782812602; c=relaxed/simple;
	bh=2CZ3IBM/SX7QrvokcEf2DjBZg7/wMx5sxrEESHTc7qY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u+trmzHceutEl8pgO6YwKJI+7fXAOiu2XVeb+M1PlJQpC65LQD2SKTN7ZlPcJ0YxtIEer3dO3krqb6r+CsOPSwHETW4gOqurvFUw9C3/XM/Myp+KRXfeDmSy8cDaU9UFM95enN+FTFKdkdbrDnanlMTACEsVkdQzOUnsbBzDBUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=r2ceabJY; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r2ceabJY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=+KtGqf5qrj4n5Eu5jLie9nXpmZtOilkQd9anw89Ux9A=; b=r2ceabJYVvP/EszJ712Ba3hqal
	FshM/Pa21JdfJFUvMwZsUVpI0yEc+gSQkpgp6zkiVQF/C2sEqY4bOpWtMLoSFr8HrunrI3HH24D9B
	TdWAofRRcyMpjR8hxO/pVdbYCeOx5Vw/Q9bYWLAYURnpeThOiTv61e5t3VJjtJjh8kkBwdTvG5xMz
	vIRzsZwP0XFbi7Xaw1jfypiCCzSqobeM8mE8rllLoCzxbn0W7KgMwh6O7UJwGK/1+PMBlav+J3dRH
	di8U6IniwBRyui6uXc9T8VXU9ta14x0RUdX0lMK6DKlHALzPcEWoLo6mEoc7PBaLeHw5+BMdcqkEG
	z6bjjQ7A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weUzq-00000004jQv-03jb;
	Tue, 30 Jun 2026 09:43:14 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1AC16300339; Tue, 30 Jun 2026 11:43:13 +0200 (CEST)
Date: Tue, 30 Jun 2026 11:43:12 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>, stable@vger.kernel.org
Subject: Re: [Patch v3 1/8] perf/x86/intel: Remove anythread_deprecated bit
 from perf_capabilities
Message-ID: <20260630094312.GA751831@noisy.programming.kicks-ass.net>
References: <20260612090114.3188886-1-dapeng1.mi@linux.intel.com>
 <20260612090114.3188886-2-dapeng1.mi@linux.intel.com>
 <20260612094648.GB42921@noisy.programming.kicks-ass.net>
 <96a18944-bc0d-47dd-b435-e9aa63b93c43@linux.intel.com>
 <20260616100202.GJ42921@noisy.programming.kicks-ass.net>
 <47a9642f-68ab-432c-a607-548995bd82fa@linux.intel.com>
 <27d77639-a948-4f0f-8cb5-1d06966bac0f@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <27d77639-a948-4f0f-8cb5-1d06966bac0f@linux.intel.com>

On Tue, Jun 30, 2026 at 05:14:41PM +0800, Mi, Dapeng wrote:
> Hi Peter,
> 
> Could you please queue above latest v4 patchset
> (https://lore.kernel.org/all/20260616044654.3468742-1-dapeng1.mi@linux.intel.com/)
> which fixes a defect in patch 5/8  "perf/x86/intel: Validate the return
> value of intel_pmu_init_hybrid()"? 
> 

Damn, I knew I was forgetting something :-(

Let me go fix that.
