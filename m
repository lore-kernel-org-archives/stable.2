Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4543A361979;
	Thu,  3 Sep 2026 09:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788426626; cv=none; b=Xeb6cb0EdsfBIxCMT1PSzMHboN8+2OoB/g/leebvpvfjpqw+TjieSV6xnwb551SDLJQ/foLYycdcx0iYwpZL0/P3G7PRoO92skL6fqqzGNmHTk1EkJNFQ7xWWC8daDT1ybeeAtJUPAMuwuypkhFoLebSzBDoPzWFUULLg/hjSMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788426626; c=relaxed/simple;
	bh=3wUDtsWJRe6lCYem7xPUUCsaxWOeHPVwUgwy3LFyfOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UcK6ODiS5P+SpNmuHFxMTNKhkStmUBfgZHHDWTrxgQZYGp72FbSTG2SSRB9MoBE5fA9Fyg5+53YfvAbZP9lLtjvKaebjsIEPjA0yx4o7pPt77F6XfSja/4m+vhxPr9DeDMenqj7h4tD9GPKfCLNI7+poPFGClq4bKPT1P431U3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Do2U7w2R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Do2U7w2R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B81E71F000E9;
	Thu,  3 Sep 2026 09:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788426624;
	bh=gJ6VJKhqGsNlt68X2iPTDP9HFGyl7OR12DYDMAomfSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Do2U7w2RK/1AV0+OWzbCK1EXkz7HXhlb4wQy4tq+2CHO2JKNK5E58UQEZ0T3/zolO
	 sePT9bTM+BvSHxahBUMknhxE4tFH6FhgQaLDy09roiKojobegc60xhPK2WOGxmzuzh
	 mpEYfsUzoB7HysSsSvWopUclWPhL4Jxz97ad7HzTS2xOJMwm8Gp69Culy55KOe7Rdm
	 7ZvtKQeeKSPLwS4XS+R494R+dAJh8TF5Ob1fwaIojhDfn3uvO2erF43DFjYx3rQWuY
	 hAeN5wyPyolMYPTGxYHpiILHsSacg5gCJz6y65ZHIiMr35X9ROVyJ//Wp1Coa8YAA7
	 SVA682h45TL9w==
Date: Thu, 3 Sep 2026 10:10:21 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Christian Loehle <christian.loehle@arm.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mailbox: pcc: Synchronize channel IRQ before unmapping
 shared memory
Message-ID: <20260903-subtle-cornflower-guppy-b64a03@sudeepholla>
References: <20260828161033.3783599-1-christian.loehle@arm.com>
 <20260903-impetuous-exceptional-python-db8aba@sudeepholla>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903-impetuous-exceptional-python-db8aba@sudeepholla>

On Thu, Sep 03, 2026 at 10:03:38AM +0100, Sudeep Holla wrote:
> On Fri, Aug 28, 2026 at 05:10:33PM +0100, Christian Loehle wrote:
> > pcc_mbox_free_channel() unmaps the PCC shared-memory region before
> > mbox_free_channel() invokes the controller shutdown callback. For
> > interrupt-capable extended subspaces, an in-flight handler may
> > consequently access the mapping after it has been invalidated.
> > 
> > Release the mailbox channel first so its IRQ is disabled and synchronized
> > before unmapping the shared-memory region. Serialize PCC channel
> > acquisition and release across this sequence: once mbox_free_channel()
> > makes the channel available, another client must not replace the
> > shared-memory mapping until the old one has been unmapped.
> > 
> 
> Breno Leitao has already posted the fix for the unmapping before freeing
> the channel. You just need the mutex guards.
>

Failed to add the reference to it [1] earlier.

-- 
Regards,
Sudeep

[1] https://lore.kernel.org/all/20260812-pcc-v1-1-5a94d2cc26cc@debian.org
