Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DC647ECEB
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 16:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786121049; cv=none; b=IWHOH587PPiKwiRohJDK6F8KNYQ5KOZkZd6oRBwaRDrFFNro7F8yAWRohKlp0pf055UBAfAv+0VsEiHISVNoF5qESV9IPQhMLYtkSJLsWqChXt8870Ey39xkA2J37cHSzZhgr5iU25PhpuC8D0bI3Ijce4EKfKTCey6iuf3ClBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786121049; c=relaxed/simple;
	bh=uPhLGPhcYhdMfSp4rrZp74jm8xFS8hjXR/BosdftPU0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UwGhkLgkTSz3cqbNN3HMZHdJ9elwRfbDZu2Ff4ZdnJyESr6m7WBdFUzMvSMUpvD2cAErhIwrdSYSBDUHkX14EDJtduw+G9efghmkSqNKIcPs7X951h0IsWIVsuyXEsSB89RH8M9dlGSzSQBcypI03HOkeRSJ1cY9cBrz+uhMxlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UcT2M3h9; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UcT2M3h9"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49554ebb87dso32989065e9.3
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 09:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786121044; x=1786725844; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3QXb84XN1127M+aZY6/SeCM+ISG9Q4eDpoIhqwUcmGU=;
        b=UcT2M3h9RMhWwlsYKBJV4IzIj8IK0p8L6BlAMqKaHKzJ90hXgWWBUlqgwRHRMBu3HP
         zHInYBcMuQXkiT1I2mPxrGCNoltKBHnVz8wZAbVkAtjoN2O03c3K00G9JiHsnisc4ztF
         TZaIUYe0JEEjqw4HZV1LrYrWp4QQFk4P4VadnUQc0mi8nUfyWp/yAAWdmP8zDGiDE2q3
         3OKxdlKbL2MFiwuTxa7evZraV3ekmPpCr66dgH3PbhNcG1IiK96TDjvgUbr88lyFX1Ol
         Eh/AiM8gXCkoLesPfVRow1Sz2K8GnEnjSlfdjPyZ4Zlzq9tiGS0Mmt8UIKjwoQ41bHK7
         PATA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786121044; x=1786725844;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3QXb84XN1127M+aZY6/SeCM+ISG9Q4eDpoIhqwUcmGU=;
        b=qHWQtpb2r+ScWoaJDdft6mJ1mAATvt0SfVxD5ydf+ikI4gz/dmBYMSVPULRIA4l6we
         2sJreTOp2QJVNYo6lfD4cxKDMkrCtmG18RndDhK8/XTWVQE4KB0/T0zCyLhPg3IK2JkK
         g0iT9H/SDUYCI2mIcCj6PIwrzkiRk97BC/mhqvZR1/UOpbuhshv3cBU72drfCvzUSwVG
         oPfLZyWNY1plfYF4h1TtXKDRPAkEaGV6ckGIf+s60Pn6mep0FdjEX5zzDYUN9zEEm48/
         Z1tzLNcqwJ0YQYGhNfSTRYgRBGAHMCThayxqwjm5+fFXFN0eIGLoxBys4wfS663NEu8/
         IIVg==
X-Forwarded-Encrypted: i=1; AHgh+RqKZ/KRqkZVdATRQUlNLDPcRdqXR86p5ILDusxKlnDPTlTSM4Vg3y830plQBBCtX5u1vRbNwyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVMWXVp3ZuzUric5+nWtipZ7L0BryiqvOLQxjjAsclYWE5f05u
	W0axJOHVFRSBoDGuyWJpH6ltHKMhR81UrmUuBvK2fs9QZZin5fjg2lRsyYQKxnswwL4=
X-Gm-Gg: AR+sD10jw9/mk5L2uhBuW6wJDREUSpOiNvxyN6U8a4lTbcvIziduE+Ys4tf5vBtsr1j
	pySbADoFIneHWd3d3wlWD0N+v7EKRXpI0ZeW4MNDFwIAOjBarc4nN5tvl64DBOEK1Mi4SJOKK+6
	VDakeI3HAL32rxR9TJYQYmeDiEZ0t3lN3wrirMDR0f8g4OHnxt3y8kgLTC+LPauGQrmHX8LKwHR
	8mUQ+1TV+k5xmMrictqqljuSz1/9UlMk77+dYAbFPHq0d1UU8xoqZrrg2I0MOUVrCkOdTzGIV3n
	5HNRjOpyKC9FJJRckWY+ggvOTZOOyeOm6RA8QrYhEEGXcigdg0GI7c3BK59AZqcvkVtd7kF48wC
	vzoFT05jCywtaU3VmKKhSmnCAxt5ToUliRtD48MpcnPyJkbiwD+2FO/CpOZJomUaP6PcL0D3SBU
	Qt4+n6PzLwDc2SLACDX7YKKX9IoDJi6bWIj28lCUfB8pDzrHY1tW5571gHMU3fUBCFb5z0JB1yl
	6HD5+3XtGk+QUgqvTuYd97Meg==
X-Received: by 2002:a05:600c:46cc:b0:495:4e89:3f30 with SMTP id 5b1f17b1804b1-49961b8a027mr11821095e9.15.1786121044328;
        Fri, 07 Aug 2026 09:44:04 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021f9182sm7368787f8f.28.2026.08.07.09.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 09:44:03 -0700 (PDT)
Date: Fri, 7 Aug 2026 17:44:02 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 stable@vger.kernel.org
Subject: Re: [PATCH net 1/2] ipv4: mcast: getsockopt: do not overwrite past
 optlen
Message-ID: <20260807174402.2dfc12d6@pumpkin>
In-Reply-To: <20260806-mcast_fix-v1-1-bed0a5518e57@debian.org>
References: <20260806-mcast_fix-v1-0-bed0a5518e57@debian.org>
	<20260806-mcast_fix-v1-1-bed0a5518e57@debian.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 06 Aug 2026 02:42:00 -0700
Breno Leitao <leitao@debian.org> wrote:

> getsockopt(MCAST_MSFILTER) can write past the end of the buffer the caller
> declared.
> 
> This is because the copy_to_user() does not respect the optlen, and can
> write over the allocated buffer, overwriting userspace undesired
> memory

Nak. This is just the way it is defined.
The application provides a length that is just the header.
As you noted the header contains details of the real buffer.

There are quite a few sockopt like it, you have to support them.
There may be some where the length isn't checked and is just assumed
to be the right size - they have to continue to work as well.

	David

> 
> The amount written comes from the numsrc the caller left in optval, not
> from optlen. do_ip_getsockopt() reads optlen once, to check that the header
> fits, and then reuses the variable for the length of the reply, so by the
> time ip_mc_gsfget() fills the source list nothing remembers how big the
> buffer was.
> 
> The copies go through copy_to_user(), so this reaches only the caller's own
> address space.
> 
> setsockopt has had the matching check from the start:
> 
> 	if (GROUP_FILTER_SIZE(gsf->gf_numsrc) > optlen)
> 		return -EINVAL;
> 
> Clamp numsrc to what optlen holds rather than rejecting. Another option
> would be to reject (-EINVAL), but, that might break userspace _more_.
> 
> For reviewing purposes: size0 is the header size, so, the available
> buffer is len - size0.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  net/ipv4/ip_sockglue.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
> index a55ef327ec932..2e4e19b90645b 100644
> --- a/net/ipv4/ip_sockglue.c
> +++ b/net/ipv4/ip_sockglue.c
> @@ -1447,6 +1447,7 @@ static int ip_get_mcast_msfilter(struct sock *sk, sockptr_t optval,
>  {
>  	const int size0 = offsetof(struct group_filter, gf_slist_flex);
>  	struct group_filter gsf;
> +	unsigned int max_numsrc;
>  	int num, gsf_size;
>  	int err;
>  
> @@ -1455,6 +1456,10 @@ static int ip_get_mcast_msfilter(struct sock *sk, sockptr_t optval,
>  	if (copy_from_sockptr(&gsf, optval, size0))
>  		return -EFAULT;
>  
> +	/* Maximum number of sources that would fit in the userspace buffer*/
> +	max_numsrc = (len - size0) / sizeof(gsf.gf_slist_flex[0]);
> +	gsf.gf_numsrc = min_t(u32, gsf.gf_numsrc, max_numsrc);
> +
>  	num = gsf.gf_numsrc;
>  	err = ip_mc_gsfget(sk, &gsf, optval,
>  			   offsetof(struct group_filter, gf_slist_flex));
> @@ -1474,6 +1479,7 @@ static int compat_ip_get_mcast_msfilter(struct sock *sk, sockptr_t optval,
>  {
>  	const int size0 = offsetof(struct compat_group_filter, gf_slist_flex);
>  	struct compat_group_filter gf32;
> +	unsigned int max_numsrc;
>  	struct group_filter gf;
>  	int num;
>  	int err;
> @@ -1483,6 +1489,9 @@ static int compat_ip_get_mcast_msfilter(struct sock *sk, sockptr_t optval,
>  	if (copy_from_sockptr(&gf32, optval, size0))
>  		return -EFAULT;
>  
> +	max_numsrc = (len - size0) / sizeof(gf32.gf_slist_flex[0]);
> +	gf32.gf_numsrc = min_t(u32, gf32.gf_numsrc, max_numsrc);
> +
>  	gf.gf_interface = gf32.gf_interface;
>  	gf.gf_fmode = gf32.gf_fmode;
>  	num = gf.gf_numsrc = gf32.gf_numsrc;
> @@ -1705,6 +1714,7 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
>  	switch (optname) {
>  	case IP_MSFILTER:
>  	{
> +		unsigned int max_numsrc;
>  		struct ip_msfilter msf;
>  
>  		if (len < IP_MSFILTER_SIZE(0)) {
> @@ -1715,6 +1725,12 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
>  			err = -EFAULT;
>  			goto out;
>  		}
> +		/* Do not write more sources than the caller said optval can
> +		 * hold.
> +		 */
> +		max_numsrc = (len - IP_MSFILTER_SIZE(0)) /
> +			     sizeof(msf.imsf_slist_flex[0]);
> +		msf.imsf_numsrc = min_t(u32, msf.imsf_numsrc, max_numsrc);
>  		err = ip_mc_msfget(sk, &msf, optval, optlen);
>  		goto out;
>  	}
> 

