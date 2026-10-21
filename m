Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792588527;
	b=jMkl9VBB97dsNQUAqbqJJoIS0FmjX7o7prxehf7dd63Rvjc7wybw4BDQjtKYAcVO4vrO
	 uGNY0xmcMfzI45RGjYIaEO0goNIeuYFWeZwlGvVEh7Hem/RrgfP85Z52DM8hnTg7/k+dY
	 ZSZM2eLaQrFA0/ObgnUVCuIR4LHIOSc3sbWYJlC/6STW55UJKdmmxPPCv8s2CJoEezIyF
	 VdDC6RLMmhMXU9/45wHs5Ek7iVC3YEVXpO2Mc4RyAzqFqKVPqSVCDbnIHm6O2wyDhTAfS
	 DxuvRVqysY+LIFNjE3J8+PpYxNo0WdbTrYtfyFzd/RMUh0an6uQBppcktujPmwNEkNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792588527;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=1qWGBjrp7WefR89knHU5GCESRR8RYu8esz+z+k4V8A4=;
	b=kP8oQteEing+kJ3h4/HdhRfL2K1S9d7dLRbWvOjVLmhv2+gMkGsD4awAGaxRFe55R6/t
	 /SyGVc5mBf9dTJdTSKDUzXvOY6PeI2fDx1mw96VY8n52EbrnOQquuPyvfBPDHU17s8Za2
	 ZRYqs/L+ABonrhNKJ4h69MeRV0G5dgbjgj2/8cv90XOR/2YmOLB4p/bp6Hhw/X8CIuFyW
	 x9n32ycaltDBBTa900MjIOBhDSpj+DY69B6LEs7Q9j1WJ+UO5aAgIjnXU84s4PbS2VYpm
	 g81lN9eZV71e9xqTzjDlchJrTNAcbq5SLoNG5OZrB6k3dsNnCg1lOiu5MyOWKBhavZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=orPI+dYQ;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81EC606A321;
	Wed, 21 Oct 2026 13:15:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A81EC606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=orPI+dYQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1qWGBjrp7WefR89knHU5GCESRR8RYu8esz+z+k4V8A4=; b=orPI+dYQRBg/JKhrgSaPakH48w
	a9a+wqY+UqHndDax5gq1vrccdvTLcIufYEnNfNROWQSpysW6r4tnCKRJ40GHrtcMKguCPRwlvd/VX
	qU85VImLDgWmuWvm/dUdNG2yvKvITu3fP0PUKtC8WDmT33Hcq6qhkCIKmbFZAHQq2E458HubVSIIU
	TvntxxegpYZAxjmeCH3DaFriySzXZDPh1Q6n9MFNnlfTcHoCf63qEq7CDpN/RyMLLvfgp818Bd7+s
	TMhFUIZRGWAy6rlkbPianNElPnwrwOWbLeqdJrMT6s6AnL8baDZveXAXqPYkDKQ+EGXGclya9sXpz
	3abD/R9g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xJWA2-00000005q3h-2CKf;
	Wed, 21 Oct 2026 13:15:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 75491300454; Wed, 21 Oct 2026 15:15:17 +0200 (CEST)
Date: Wed, 21 Oct 2026 15:15:17 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: Patch "sched/eevdf: Move to a single runqueue" has been added to
 the 7.2-stable tree
Message-ID: <20261021131517.GN2823843@noisy.programming.kicks-ass.net>
References: <20261021115034.4170616-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021115034.4170616-1-sashal@kernel.org>

On Wed, Oct 21, 2026 at 07:50:33AM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     sched/eevdf: Move to a single runqueue
> 
> to the 7.2-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      sched-eevdf-move-to-a-single-runqueue.patch
> and it can be found in the queue-7.2 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 

Ufff, why are we backporting this?
