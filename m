Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036A9342C93
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 17:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781805568; cv=none; b=MgRy+gkkxW1oPwWRsJi7HQjSx8jGTiT+00dhDK30UcA/C3UBOVNkhmV8lUXQGHfsJ8yBrr11xlNIB2LRrT9u2v8xpEY26Qg9xIGnl+HiKbPMXoIazubzwnTNlZkzOthOpLF5w6PepDwlf1a++t2GHfgj/WjQLXEU9Tj0yQaMDxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781805568; c=relaxed/simple;
	bh=Mz2OgKw2e5hGZBqXv90nCOlP8G+uXbR6biA60XzPE0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AP10dGQvjFyh3dDZ67CpEyDJxUj2+IqUBO4Rt/DS0xcVLba+Zz9gep8w19iOLZIpuCSQC80PAzIUtEfarwZ+yJHU2BMf4ykYCuLas4piWLfEnZh9IvE01NmirHwM/9unvay94nOjhmxaDSe49qVdof3vTmgrxHc1fvQDQwIvOpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f8ct75yZ; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f8ct75yZ"
Date: Thu, 18 Jun 2026 19:59:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781805554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cGeKgfr1mMtriAvoilvPELR8x/9wz1z2bvibyiqBjtw=;
	b=f8ct75yZjnUGvSuzP4eNi5lB/mzcWXugQMjqeLYV5RpgjfLtrgEjs6woDALv2DG//w35YO
	7xbqT+/aV8ynH7iR2b5lcUzNo/4RxxkeLZs6xwnYGRxoSM1wOGByMZnjLrUK61PUojbidq
	fXfyzacdb36GWvy4h25JRpVE1Hv+pJU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Chao Fan <fanc.fnst@cn.fujitsu.com>, stable@vger.kernel.org,
	Borislav Petkov <bp@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/boot: Reject truncated acpi_rsdp= values
Message-ID: <ajQx7dBWRuRFuKwE@linux.dev>
References: <20260617130417.36651-4-thorsten.blum@linux.dev>
 <20260618045400.GCajN56AKctO0qB-sF@fat_crate.local>
 <ajQI0mJwobsGHj6F@linux.dev>
 <20260618163856.GAajQfIDh0s31VINiS@fat_crate.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618163856.GAajQfIDh0s31VINiS@fat_crate.local>
X-Migadu-Flow: FLOW_OUT

On Thu, Jun 18, 2026 at 09:38:56AM -0700, Borislav Petkov wrote:
> On Thu, Jun 18, 2026 at 05:03:46PM +0200, Thorsten Blum wrote:
> > get_cmdline_acpi_rsdp() can truncate it into a different, parseable
> > address and use that instead.
> 
> How?

The buffer has 19 bytes to hold the "0x" prefix, 16 hex digits, and the
NUL terminator.

cmdline_find_option() copies only bufsize - 1 bytes, but returns the
full argument length. So for example:

	acpi_rsdp=0x0123456789abcdefx

gets copied as:

	0x0123456789abcdef

which boot_kstrtoul() parses successfully. The user supplied an invalid
value, but we silently use the truncated prefix as the RSDP address.
