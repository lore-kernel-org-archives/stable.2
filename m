Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639813537E8;
	Sat,  3 Oct 2026 09:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791019122; cv=none; b=ZVuDHfTNcipf68lXDr2fb3IPzNIKTkBeZgUiTL70qJOBm++Bqeu5ARcwtue7IcUBz1Wn17rSbKRDDHDeQQX9XGGA/3t0dijxqOF/xJL1YjEq05/SZvzDxlBWbb5PLzhkQdzO2VRSnfKLsNj+nMExP9oLO9SFoY+cJ00FBykcwxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791019122; c=relaxed/simple;
	bh=6UG7OBe1pIKeQYfgpbxk8n7/tnFRBnoNzl8SocuNRbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JtnKrnY6NI+NUNX1GRCp4lXZTOidZjVig7Bbo+2IU1icnCM8dVrfWLxkt3Dx//5+lCZdJoXMEI5Zsr538NFEUVpSGn5IGRu6Zg4QsC+TgEhQXCS88h6dJIWKXwchxVDyOqD/JRfqM7G8fNeiyL3uWeubVCSa99ugfoi7mCGr954=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RVdZvFd7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RVdZvFd7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B8C81F0089B;
	Sat,  3 Oct 2026 09:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791019121;
	bh=6UG7OBe1pIKeQYfgpbxk8n7/tnFRBnoNzl8SocuNRbg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RVdZvFd7/PpZR32+eZg7X1QRZ7g/q6oTQ6OEknlAyPszGrI+fv6bFpSXAyKc2n4zO
	 8n9dU5jrjDG9xlXBZuisTlYA/57Bbcu5eQoFDFyO84sITO/5CnXX6WWdnkBEMZx74e
	 IPRAGMZQ92UbIT3O+wG+rhkYCWoziPX2apKLB+P5U7QySKxwSQEcHkhUlLzvczlE+K
	 Mhf+JUQdE+YYzI9grPKcdqxagMueig5tF5FxMnRN5hD9J9bNu+kbuVchQ2qFpvmZtz
	 1bkwmpwcbXXW2P5N2ghxQg5qv3iFPV+bRYp8oq8CNgm2PNxz5+6mp64P0ehGIFm3hn
	 0SXBRAqR82yCA==
Date: Sat, 3 Oct 2026 10:18:34 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: rppt@kernel.org, peterz@infradead.org, akpm@linux-foundation.org, 
	david@kernel.org, mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	linux-mm@kvack.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev, stable@vger.kernel.org, 4ncienth@gmail.com, 
	alexander.motin@truenas.com, caleb.stjohn@truenas.com, ameer.hamza@truenas.com
Subject: Re: [REGRESSION] secretmem: SIGBUS on memfd_secret() pages while
 perf record runs
Message-ID: <asDF77csaLDIuHTB@gremlin>
References: <20261002175651.811343-1-ameer.hamza@truenas.com>
 <2026-10-02-rc-reply-0003-re-secretmem-sigbus-perf@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026-10-02-rc-reply-0003-re-secretmem-sigbus-perf@kernel.org>

On Fri, Oct 02, 2026 at 09:30:23PM -0400, Sasha Levin wrote:
> > Since commit 97d34aa65c29 ("mm/secretmem: properly account locked
> > pages"), in v7.3-rc2 and the 6.18.52 and 7.2.5 backports, touching a
> > memfd_secret() page for the first time fails with SIGBUS while the
> > same user is running perf record, and read() into such a page fails
>
> Thanks for the report. I've dropped 97d34aa65c29 from the 6.12 queue,
> and also removed the copies that were staged for 6.6 and 6.1.
>
> 7.2.y and 6.18.y already shipped it, so those need an upstream fix,
> which stable will pick up once it lands.

Sasha,

Could we perhaps take a breath and pause?

This patch fixes a really quite serious vulnerability that allows an
unprivileged process to allocate arbitrary, unreclaimable (i.e. OOMK cannot
save you) memory.

Allow me to assess the validity of this report _before_ dropping things
from queues perhaps? :)

It was sent late on Friday in a week that I was ill and it's Saturday
pre-LPC, so that's hardly a timeframe that I could reasonably have replied.

Thanks!

--
Cheers, Lorenzo
