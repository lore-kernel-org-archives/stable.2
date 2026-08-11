Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E4043E060;
	Tue, 11 Aug 2026 16:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786464309; cv=none; b=q4aQcV56F5N1+VR4XAbeIBeGieJy6m1S5fgrW80xOHcNMlAzWwPyEpDWW9rfVtY9WhSbhI7zPy9hi1/3cjJMt5ay3XmVOfhigaNsaETRu+EO99IKDXzYSZ4g58tVuCfxCTrElbiIdajd0PoJ13HjfTYXCWFfkH8KMIfDyjJ+HeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786464309; c=relaxed/simple;
	bh=uAi3gO1UCP7xJ3A/k1FPskXge2DQlBmkkoSV+9bJOfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wo3rYgG704xGa8VHice9k4Ny9RMlUzOsM2N0hNnd1osMHvzfvfoxbGPFyJW3cJUKmzAqKSTjLUUgXcRMqWUm3BJSNcr3Z1pOD5cbggjZoUvi9U2Up9AliA2oDWs1zjKAzV2OODbBAlSJS1rniY80ZQn90HKxkE0PCSK6QmYsPzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LlNLW50x; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LlNLW50x"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fV22DXvFaPiEI9aBwVUNJQ10aIYtD8oJV0tSksIm6BE=; b=LlNLW50xoFCPQvK5mF8oQKwji3
	TWQ5qRjx1XE4DiNwIzLwoppbz+s5zTXJMZuBb7w60GOoulrgxRNVGOeLXuri+AMXFcnm4gfL6cRO4
	ycb2pcpzx8GqrJQK+h6YlqbfHvP6REEhY6Ht8FiF5GcIQWNxdzc7y0jmtiXemAVD9NQRS9kPR8V59
	NDPziscZnLOdISkINvfocHOLE+bYMr32CsvKJtn58EQQeV/pdreRxmNmNYEYjtfOaCKaBDSrIL4y1
	1lJEq5OvSKTpTUscRx6SKKgEtmryToRsSQsxHLX6TULKQolJZty1E47zrtJ3hPNeisf1zX8ea3D+R
	tzyVRYyQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtoyO-00000000fCS-0ke8;
	Tue, 11 Aug 2026 16:05:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D90C1301127; Tue, 11 Aug 2026 18:05:02 +0200 (CEST)
Date: Tue, 11 Aug 2026 18:05:02 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>, ElXreno <elxreno@gmail.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/6] sched/core: Make core-sched flips wait for in-flight
 selections
Message-ID: <20260811160502.GA1246887@noisy.programming.kicks-ass.net>
References: <20260807210221.232543-1-tj@kernel.org>
 <20260807210221.232543-3-tj@kernel.org>
 <20260810111546.GV687043@noisy.programming.kicks-ass.net>
 <07a6cb06c1edc43bee7e8a2c20661a2c@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07a6cb06c1edc43bee7e8a2c20661a2c@kernel.org>

On Mon, Aug 10, 2026 at 12:10:20PM -1000, Tejun Heo wrote:
> Hello, Peter.
> 
> On Mon, Aug 10, 2026 at 01:15:46PM +0200, Peter Zijlstra wrote:
> > I'm not entirely sure this is the right commit. I suspect this was a
> > problem right from the beginning. This pick_next_task() always had a
> > prev_balance() call that could drop the locks IIRC.
> 
> You're right. The balance calls could drop the shared lock mid-selection
> since 539f65125d20 ("sched: Add core wide task selection and scheduling"),
> so stable should target v5.14+. The sched_ext fold only made the window a
> lot more frequent.
> 
> How would you like the two sched/core patches routed? I can take the whole
> set through sched_ext/for-7.2-fixes, or hold the sched_ext side until the
> first two come through tip.

You can take them. I just double checked and I don't have anything that
will conflict.

Thanks!
