Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263E7446BE2;
	Thu, 17 Sep 2026 09:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789635721; cv=none; b=G6lD/Np/w4wChXhma7SSKWR/a7tlt6Zniz4zAI6VEgOG2TKxqlKLCwrFlpKIbppieHv1vD4ieO8e5YlfN0+5dGBIzyXvvvSg2MieJPur4H2M+BYX6fbL45Caqka4JG/9mBvE9z1ECygThREaUTPRZ5QnbSVxpfvsdr+0MuELwVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789635721; c=relaxed/simple;
	bh=hOxMFmQLcNxOnRueiOovJFtugGEqFBHOfWPa34lr4H0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kszni6eklKTYzhAPg0O+Tdgr6QN19OSj9ry79Pqb6FIPYLAJF3ZcXTDzqkRlHNtyC6oaYRU/tC17rJ9d08QlaGGQkm1O/Nz8PqZmy9ffkPFWkUGZPRuUv4Y/28Lg4hpiuOx22QeL9VgFywHhOSXW9I/SABqmiCOMs1ne3Mv7ZDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EzIf5YvM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EzIf5YvM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3077E1F000FF;
	Thu, 17 Sep 2026 09:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789635719;
	bh=22ILZwMvHlhpYtPZdJuYIJAvZNVUuTsQTLzN6aj5t9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EzIf5YvMqD53pm33kjOIcSTLdkJvzct6Fe/4h6oE6BM2XJPabE9BAk1/OURW9kG8m
	 CuYzkvY0AN2IEEzCggYUlQG+OyU36/z0La+w2HOrOY0pPpq1IrMbQhBkTiiVX3p+aT
	 t+RHSz6j/j49Lgiy0KqSHxcpcaDwFM8jYrYkww1M=
Date: Thu, 17 Sep 2026 10:00:03 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Xiang Mei <xmei5@asu.edu>
Cc: stable@vger.kernel.org, rafael@kernel.org,
	maciej.wieczor-retman@intel.com, pawel.chmielewski@intel.com,
	lenb@kernel.org, linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev, bestswngs@gmail.com
Subject: Re: [STABLE REQUEST] ACPICA: Fix NULL pointer dereference in
 acpi_ns_custom_package()
Message-ID: <2026091756-grass-jingling-2c16@gregkh>
References: <ztqdpwmbpfusfens334indnsykgejamscwhv6dylk6xckr5uyg@scsb6egwneel>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ztqdpwmbpfusfens334indnsykgejamscwhv6dylk6xckr5uyg@scsb6egwneel>

On Wed, Sep 16, 2026 at 04:47:53PM -0700, Xiang Mei wrote:
> Hi stable team,
> 
> Could you please consider backporting upstream commit
> 
> f8d14b7bb0063bbbd86c0e4d73edb8cea7b362bc
> ("ACPICA: Fix NULL pointer dereference in acpi_ns_custom_package()")
> 
> for 6.18.y, 6.12.y, 6.6.y, 6.1.y, 5.15.y, and 5.10.y.
> 
> It prevents a NULL pointer dereference when firmware supplies a _BIX
> package containing an unresolvable first element.
> 
> The fix has been in mainline since May 27 but is still absent from the
> longterm branches.
> 
> The upstream commit applies cleanly to all of these branches.

Already queued up, thanks.

greg k-h
