Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160014B7A4D;
	Tue, 29 Sep 2026 23:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790723398; cv=none; b=QKmdQWjiGpkOS6okacuD6NIvtXr/UB2GyZcEY2GSgDww8ShKjAyqon48KUqGlqVXzFDQ18bxhKgSamhfWosa4d+b44ehjAbsvZa5TM9KUKDjjT1qAuPB+b8Pn2hHU+bDJiEgRhE1Ph1e29HeDtLeGmb3lPgPnUzUaB2MFvGhZHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790723398; c=relaxed/simple;
	bh=Eh9OKMokxv7hISf6O+yViQFfrtfGj+wm3beSRRyLJTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QAOulleraTRBOS/n5X30eSTYSaZOydejcQd+fTbj8GTUesK7+EzRLkyJTfkiZdgm7NuycUhkrQXBBo4+kPRnKI8IilUxRfPh5DzYPJskTuFfoPAdT9rTfo23Z/Z7p+8rx4GLQXjGdsjPWETcPJhq9/VBVmbKsBDuod5xQnRNyec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=J/5oOhz3; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="J/5oOhz3"
Received: from LAPTOP-F8U7OQUB.localdomain (unknown [167.220.26.102])
	by linux.microsoft.com (Postfix) with ESMTPSA id BB93E20B7166;
	Tue, 29 Sep 2026 16:09:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BB93E20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790723344;
	bh=Eh9OKMokxv7hISf6O+yViQFfrtfGj+wm3beSRRyLJTA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J/5oOhz30yi8CC5f95jnNVOY5DAXjih4p1AnzrPwET41rEeIS8IAJbvwnoEf5BvjZ
	 hCR7Pun6Ibf34zFhNvRb9hbCc2SExzQTbmtDSvLpSVOTIFCDoD0b6HV6eD6FJ7Kaeu
	 RZ1tI/2nOsIYzxL/N7lzybTVeZhJtF5F4JY4bYCQ=
Date: Tue, 29 Sep 2026 16:09:45 -0700
From: Tahera Fahimi <taherafahimi@linux.microsoft.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, raminwo0202@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, apais@linux.microsoft.com
Subject: Re: [PATCH V1] xfrm: prevent policy_hthresh.work from racing with
 netns teardown
Message-ID: <arxFOXGFq3GEgsLS@LAPTOP-F8U7OQUB.localdomain>
References: <20260820211418.1409602-1-taherafahimi@linux.microsoft.com>
 <2026082106-widget-steed-ece0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026082106-widget-steed-ece0@gregkh>

On Fri, Aug 21, 2026 at 06:25:45AM +0200, Greg KH wrote:
> On Thu, Aug 20, 2026 at 02:14:18PM -0700, Tahera Fahimi wrote:
> > [ Upstream commit 29fe3a61bcdce398ee3955101c39f89c01a8a77e ]
Hi Greg,
Sorry for the late reply, I was on a long vacation.

> No it is not :(
Agreed. This is not commit 29fe3a61bcdc; it is an independently implemented 6.6-specific fix for the
same issue because disable_work_sync() is unavailable in 6.6.

I will remove the upstream-commit annotation and resend it.
Sorry for incorrect annotation.
