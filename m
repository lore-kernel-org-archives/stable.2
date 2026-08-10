Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C8E37B016
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 23:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786404733; cv=none; b=dMQLDRuixdXOOI5d8WfyS9VlE5uS153RmcYA+5HVmPVly3R1tBuEkns/1pVS50mYjcmK1SL7obhswFBuhVHYzh86n/ZRVT/1gKt5sR/LsdEyU7EQaQJdR5U2uErJQQZXHf/SHILyzMxiSXEblwWnh18XjEYIUTfjSqRXv21vA84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786404733; c=relaxed/simple;
	bh=mtdk4PdCGzfXjtebI3yvexVP78xJ1WnS7QktGMK5WDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XIADEcN7CMHU1mm8yTcUVc1ovWevxqW0YJjDeeIq1fVp1XCPPu54KQipx2yBauAtCTTeQDjxv740VdiLw8sbCkAVL3xL2IONFBl2hYfFhxAsZ16BToP4QQNP2r2J9kf468ilZIlw8yLg2+GaX922cbFPTs+7uD7faC0QNT/obFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bAoGdgLq; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bAoGdgLq"
Date: Mon, 10 Aug 2026 23:31:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786404719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mtdk4PdCGzfXjtebI3yvexVP78xJ1WnS7QktGMK5WDI=;
	b=bAoGdgLqKPs4RmrfYj7UjV5IDIbN0Mi7q9W/lgRTAfbDZRZV7GDKpk9L4iStBySlia+NRw
	JRbs5tXMZoMbAgxsb6XaCa8XB4OGqagcuBixKAkJdobAGP4EJThni5Mogr3eHwGKo+D4uM
	gCdGtNxZEfJcjjyNEgNaIzY5KKC4+Do=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
To: Peter Zijlstra <peterz@infradead.org>
Cc: John Stultz <jstultz@google.com>, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Janne Huttunen <janne.huttunen@nokia.com>, Zicheng Qu <quzicheng@huawei.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Shubhang Kaushik <shubhang@os.amperecomputing.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Xuewen Yan <xuewen.yan@unisoc.com>, William Montaz <willymontaz@gmail.com>
Subject: Re: [PATCH 6.18] sched/fair: Revert 6d71a9c61604 ("sched/fair: Fix
 EEVDF entity placement bug causing scheduling lag")
Message-ID: <anpfJp_tuKDuePJM@linux.dev>
References: <20260324100126.3502-1-willymontaz@gmail.com>
 <20260415211149.2658910-1-jstultz@google.com>
 <anksxhdkYBfcpJmN@linux.dev>
 <20260810073830.GC1642880@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810073830.GC1642880@noisy.programming.kicks-ass.net>
X-Migadu-Flow: FLOW_OUT

On Mon, Aug 10, 2026 at 09:38:30AM +0200, Peter Zijlstra wrote:
> Yeah, this should be fine without 4823725d9d1d.

One heads up, our review tooling caught this after I sent the
Tested-by. The revert was written after commit 80390ead2080
("sched/fair: Separate se->vlag from se->vprot") took vlag and vprot
out of their union, and 6.18 still has the union. Without that split
first, the rel_vprot path in the new reweight_entity() scales vlag
twice and curr's vruntime comes out wrong.
