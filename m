Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86BA3DAABB;
	Mon, 10 Aug 2026 12:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786366150; cv=none; b=QtedG+G0aYZiHm3facM+s7yW2sypWl2qbY9ASrtZ/EKBupm0oHtq9GO/6oNfdADMXq1CGY+GsWiaQ8eS3k8jKUpAvOHIgWtzT1CklskTTVwARyb4tw5NgBNPvLBmkJk0HIUJOCp0VIBBKWlnq1NuVcbFG/fmJumrsHVS19oJB4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786366150; c=relaxed/simple;
	bh=CIDEHp8pZ8V4yvdoIPqxN4OATMI4JpS4FDXSzD6SSiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0cYP9G5wJCfVGWCwv1nHJP3At2ct0Kl0E9L+BYluHw6Bo2eS23ZJDitYLleVhHsq1XsX9EH7IKKhQQB1LPrZ8W7mz8CvDUzYW1QtLeK0kgM6P+mGdCWmiXqoHosB1i/mgsANwq4grWzUF64W8uwRIjLPw8lKG+UgoLDS8mK9Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=kD14nDfU; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="kD14nDfU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kPqgsopBsOGoIwjvTqVnsk5MAA/fpSIVwqcFNthrXfg=; b=kD14nDfUTypLiKPVAwSCNo7BNW
	dwSzLJEhGZMPP0mmECCfDMHtqcxk/WDwBOCybC1nqU8uPT372v0NUWxcv3PyKWCAIkKjBx4PRAvnC
	sxevWjGfsVpHhNwFk4C17/mO7grKJzDNMDh2hGVk+OH91VnSZ/HpgfX6FMXeuOcJYpItY4PhX4wcf
	zjD4+xWBNRdnlR0eK0EtIudmVUBIQzDaIbU+HGt2EsvAsEsOitDEJxNXVM3nG9a/S3uG2srNQCf8b
	zstnzAk7a/cE65jF+uDnLKInLNHDSy51mdVR2yiFLdNBzPOilbHpxwj3jKgOE21UPu5pZiP4yYCxc
	8UiUbUtw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wtPR4-002lDD-0l;
	Mon, 10 Aug 2026 12:48:58 +0000
Date: Mon, 10 Aug 2026 05:48:53 -0700
From: Breno Leitao <leitao@debian.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH net 1/2] ipv4: mcast: getsockopt: do not overwrite past
 optlen
Message-ID: <anm9gImFEz6EkUZ9@gmail.com>
References: <20260806-mcast_fix-v1-0-bed0a5518e57@debian.org>
 <20260806-mcast_fix-v1-1-bed0a5518e57@debian.org>
 <20260807174402.2dfc12d6@pumpkin>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807174402.2dfc12d6@pumpkin>
X-Debian-User: leitao

Hello David,

On Fri, Aug 07, 2026 at 05:44:02PM +0100, David Laight wrote:
> On Thu, 06 Aug 2026 02:42:00 -0700
> Breno Leitao <leitao@debian.org> wrote:
> 
> > getsockopt(MCAST_MSFILTER) can write past the end of the buffer the caller
> > declared.
> > 
> > This is because the copy_to_user() does not respect the optlen, and can
> > write over the allocated buffer, overwriting userspace undesired
> > memory
> 
> Nak. This is just the way it is defined.
> The application provides a length that is just the header.
> As you noted the header contains details of the real buffer.
> 
> There are quite a few sockopt like it, you have to support them.
> There may be some where the length isn't checked and is just assumed
> to be the right size - they have to continue to work as well.

Thanks for the review.

The generic getsockopt(2) contract says otherwise.

      For getsockopt(), optlen is a value-result argument, initially
      containing the size of the buffer pointed to by optval, and modified
      on return to indicate the actual size of the value returned.

You are saying that we have userspace program in the wild that doesn't honour
the contract above, right?

On the set side (setsockopt) of the same option takes the opposite view.
It rejects calls if optlen is not properly set.

	err = -EINVAL;
	if (GROUP_FILTER_SIZE(gsf->gf_numsrc) > optlen)
		goto out_free_gsf;

Back to getsockopt(2), I was trying to look for users it, and glibc
passes the full length for both options, with optlen and numsrc coming
from the same variable:

      /* sysdeps/unix/sysv/linux/getsourcefilter.c */
      socklen_t needed = GROUP_FILTER_SIZE(*numsrc);
      gf->gf_numsrc = *numsrc;
      result = __getsockopt (s, sol, MCAST_MSFILTER, gf, &needed);

and

      /* sysdeps/unix/sysv/linux/getipv4sourcefilter.c */
      socklen_t needed = IP_MSFILTER_SIZE (*numsrc);
      imsf->imsf_numsrc = *numsrc;
      int result = __getsockopt (s, SOL_IP, IP_MSFILTER, imsf, &needed);

So the clamp is a no-op for every caller that goes through libc. 

So my conclusion is that this is a bug: setsockopt and glibc both treat optlen
as the buffer size, and I could not find anything relying on the get side not
doing so.

If you know of a caller that does, I will drop the series - I would rather
look at it than assume it exists and assume that it will break someone that is
leveraging a buggy behavior.

Thanks,
--breno
