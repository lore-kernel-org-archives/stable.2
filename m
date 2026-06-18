Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C9E2E7380
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 18:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781809086; cv=none; b=nMRjfN+okvokU6JznnZKcd4cBxCcXu7XwOTcutQWqZ9leu+BH2or1Ei+iKa8o1LszJ8h6ODvxlOB9AY3S87l4DuzkKP2rIJFdBNHNxlSiza4lPl4h18u3Ht0MocDfsh6too98e5HTLt8qPERbVUlV5fVcJF+fL8oX8x7zNKTaWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781809086; c=relaxed/simple;
	bh=PD6CHh12XmvOzKqEhPnlPddPvwTRfUqT40UI+Wz7KZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kz24TTxououAImZF/reIA3vdDDPzAxXq4mKjkF/kyKHo8rZmMlwoM9/Ll+5SJZUdTG2HClN9vFFxhEEImgZtgBZfXi5WZ/gmTpRWR5Y3UVh+uDf/sAecIAUqpou5EMTpJNfHMsJOdMQX9XZWxgm5A9Vr5w6KReQuFHyMN14sYMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lNzC74sl; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lNzC74sl"
Date: Thu, 18 Jun 2026 20:57:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781809081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ccRwH1M9+EU8H0Zn/3IoMPQP/R82XHic9JmeEjLVWNs=;
	b=lNzC74slItOJob95QVJFnMjXkZVw079r7zo+HtHEUoBGMFNu3qGyeWDFeC9Ko3JHGMcw+d
	OlKXj2G1TRswuGsSFEoDq2kDElQD1kLIH+wp0nwkmc+AulZhYozRgV9zXvK+mFMpcPHM1p
	R3odZB//Mnqlw0CbJN7clptVx4NN3cQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Chao Fan <fanc.fnst@cn.fujitsu.com>, stable@vger.kernel.org,
	Borislav Petkov <bp@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/boot: Reject truncated acpi_rsdp= values
Message-ID: <ajQ_tNrz5hkS1MmB@linux.dev>
References: <20260617130417.36651-4-thorsten.blum@linux.dev>
 <20260618045400.GCajN56AKctO0qB-sF@fat_crate.local>
 <ajQI0mJwobsGHj6F@linux.dev>
 <20260618163856.GAajQfIDh0s31VINiS@fat_crate.local>
 <ajQx7dBWRuRFuKwE@linux.dev>
 <20260618180412.GBajQzHB3Rj0SrS1Eo@fat_crate.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618180412.GBajQzHB3Rj0SrS1Eo@fat_crate.local>
X-Migadu-Flow: FLOW_OUT

On Thu, Jun 18, 2026 at 11:04:12AM -0700, Borislav Petkov wrote:
> On Thu, Jun 18, 2026 at 07:59:09PM +0200, Thorsten Blum wrote:
> > On Thu, Jun 18, 2026 at 09:38:56AM -0700, Borislav Petkov wrote:
> > > On Thu, Jun 18, 2026 at 05:03:46PM +0200, Thorsten Blum wrote:
> > > > get_cmdline_acpi_rsdp() can truncate it into a different, parseable
> > > > address and use that instead.
> > > 
> > > How?
> > 
> > The buffer has 19 bytes to hold the "0x" prefix, 16 hex digits, and the
> > NUL terminator.
> > 
> > cmdline_find_option() copies only bufsize - 1 bytes, but returns the
> > full argument length. So for example:
> > 
> > 	acpi_rsdp=0x0123456789abcdefx
> > 
> > gets copied as:
> > 
> > 	0x0123456789abcdef
> > 
> > which boot_kstrtoul() parses successfully. The user supplied an invalid
> > value, but we silently use the truncated prefix as the RSDP address.
> 
> My question stands:
> 
> "Or are we protecting people from shooting themselves in foot now too?"
> 
> Especially users who should know what they're doing...
> 
> IOW, how far are we going to "protect" here?

Only far enough to avoid using a value the user didn't actually enter.

A user can still shoot themselves in the foot by using a syntactically
valid but wrong address. The check only rejects an overlong acpi_rsdp=
value after cmdline_find_option() reports that it didn't fit in the
buffer.

We already reject values that boot_kstrtoul() fails to parse; this is
the same idea: the copied string is incomplete and shouldn't be parsed.

Thanks,
Thorsten
