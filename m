Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD6136B918
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 21:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786396924; cv=none; b=bZCxGk7u8wDlBFKwmoElTOsAJPb7b13zzU6+6ugaCvNN2ij7k51Wwlm0hNB6XoqmvJL2Ha4iDvOQUDMYfSF/o1fQR7vZ0NGCgNhzTVqL38QeohinfTTYwrauIvSyND8GY1BEyHiPZhz5w8/VoFZ15kxZTtykjxSZhMmonpAe7TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786396924; c=relaxed/simple;
	bh=u3J1P0V/lrlVu8SSFvtDJpPgm7O26Oz/OmRIQoNjRsM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FJfQTaGiFxlqDelrydd8S8LH8kEnBmnD+03devNiz10m0kzsjYcdoUSsu0hZkIKHc6ODeXoiwTwoJJsmxLGubrfivA6hIT0fbY2jP7tOtfdUW8cFhVvci0M/W1ECfRTeE4A3GqFhtGWk5evCOKtdOMtNlRdCE+269R+KkCHrxQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FG0IspJ5; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FG0IspJ5"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49954b88fffso25697925e9.0
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 14:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786396921; x=1787001721; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=loowZSCDEoAH8n1u824WB8hUr1YFRKDzZIPJTUykWOI=;
        b=FG0IspJ5HHAd76qoOOTzPmRTg5gKLmhOMSnRawELIn62xZed8lLmfH/CP4GuV5NUDS
         fR1wwCR2a/ar00pJ0k1Tp38eX7UiaC2O1HL3O8+HGyL4YdYI1JcJs7q9UOJUy1xh4UQy
         3l4Q87ZKaHFZrXP75Ku17kvSTbtL+FrednBGOjY4S7UMnt4XDOZXlv/PC49+0mrhaPCM
         PCVnUMVFmlEg63vUHlPn85Ts1vj59CPIhGtARC7XfzBfP9rt9df3+LeUIRIrDyXOOpk/
         ePL+yA3bMu/A5rNIfE3FgdkFsHvx++UCk78qyMXnlP9Gsg4tIYJlKPymuqZVSW+v7pNi
         hxzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786396921; x=1787001721;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=loowZSCDEoAH8n1u824WB8hUr1YFRKDzZIPJTUykWOI=;
        b=Z0cyQMRJR8Z1tTpy0VA0uYlaO+Oy4f102wBd/O6LtZvfZf8XLK4WtD6eFvj08qkMxb
         azuWEcJ6+/Asyg5IgqN6t2ikm6mlsh8tD5+VnpWtNEPpeoI89t6Hvj30brH6c9k4rkpY
         FixNv+hwI7i5X5rOyoHYPPt8afrezATymG2kPiOgeciXyDqvu+KCrEuXbdtLXG6FYEzb
         bWbFcSVAzSRCL+jWXVW7BBAw24AgLj8DlyaOX3ufZ4XMOMhr7LRLWtLnyEOzsWKCUZhO
         tzd1z1MTQKMctmBeav3RCbxVI498N9S9PlxJTsm9W3HTpACFgmVqi7zaXZ8rHulv4fd/
         MdfQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpbuv/d5/eAObmICMn/3KARshs97BDso570jGUPp76pkISzfN22ciWtR/uAGfPVXIqYemt6cak=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQyQsZ46qKkH8FnzlDrOaWVTWzY0eAL9mfdaaeqduyp8HYCS5Z
	iS6ercBEmAUZNzt8QwGUY6vfGX6CLVI4qFaZUVzA26+K1ujjoKNWQWFe
X-Gm-Gg: AR+sD136lxVtx+L8JbyXtFEFULTofy1zHszFwKNnoz2mPWgmrJHZgqcCkSBuduQqH3S
	j8kuTvLYDghqXRjKUgs8C/DSHza+PovxnQvwQwiMON2lJ5qgMJDG05G81cwFyYZZVVH1sSqnjkF
	c9fkBjMvMJCPwdZOrdSzpuavINBSF7FkLcr5z9Uzg68tFH6VT3oShsR/xA8ABLM6HRAoUWAlzt/
	Rkg2lWKaUdvCG9t5bXAtNxKmR/URP9+jAKKXcc5UOvNkOyvPexiaNrojbAWanXTBuHYFw9ZcsCA
	Iq5yWjYGi1LKrJ/otZni5bIEO+JPh55kqbEkvjRLOBLK/edQ7S/YEUFGuy3MbngDmE8HZvI4at5
	zrHo8Aye87KvU+SaamIaRmYM8bkm23x2FNxMmXBrDtispY0hwhZXNE4kld2eb6DgzXzXy6ycDud
	FfWiFKwO2QTVF92RT2dFKxDeZZxprXZNlTh3ECfBPoe0ZRbSWOX9pb1O8mdCiYDd42BRauZP1Rj
	g5IvDk/4WQwuLHNIRSWv0Mtsg==
X-Received: by 2002:a05:600c:4585:b0:493:bb6b:5bb5 with SMTP id 5b1f17b1804b1-4996198e51dmr270048285e9.13.1786396921162;
        Mon, 10 Aug 2026 14:22:01 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499740c1f61sm19621785e9.5.2026.08.10.14.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 14:22:00 -0700 (PDT)
Date: Mon, 10 Aug 2026 22:21:59 +0100
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
Message-ID: <20260810222159.409357fa@pumpkin>
In-Reply-To: <anm9gImFEz6EkUZ9@gmail.com>
References: <20260806-mcast_fix-v1-0-bed0a5518e57@debian.org>
	<20260806-mcast_fix-v1-1-bed0a5518e57@debian.org>
	<20260807174402.2dfc12d6@pumpkin>
	<anm9gImFEz6EkUZ9@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Aug 2026 05:48:53 -0700
Breno Leitao <leitao@debian.org> wrote:

> Hello David,
> 
> On Fri, Aug 07, 2026 at 05:44:02PM +0100, David Laight wrote:
> > On Thu, 06 Aug 2026 02:42:00 -0700
> > Breno Leitao <leitao@debian.org> wrote:
> >   
> > > getsockopt(MCAST_MSFILTER) can write past the end of the buffer the caller
> > > declared.
> > > 
> > > This is because the copy_to_user() does not respect the optlen, and can
> > > write over the allocated buffer, overwriting userspace undesired
> > > memory  
> > 
> > Nak. This is just the way it is defined.
> > The application provides a length that is just the header.
> > As you noted the header contains details of the real buffer.
> > 
> > There are quite a few sockopt like it, you have to support them.
> > There may be some where the length isn't checked and is just assumed
> > to be the right size - they have to continue to work as well.  
> 
> Thanks for the review.
> 
> The generic getsockopt(2) contract says otherwise.
> 
>       For getsockopt(), optlen is a value-result argument, initially
>       containing the size of the buffer pointed to by optval, and modified
>       on return to indicate the actual size of the value returned.
> 
> You are saying that we have userspace program in the wild that doesn't honour
> the contract above, right?

I've just looked at the old history, since the code was added in 2.4.22 'optlen'
has only needed to be the size of the fixed structure on entry and has been
been updated to be the total size on exit.
The maximum size of the buffer comes from its sl_count field.
Code that doesn't use the glibc wrapper could be relying on it.

There were definitely places where the driver code has traditionally not
checked the length at all - and userspace wouldn't have set it.
The last might have been in the decnet code.
I'm pretty sure there are other places where the length provided to getsockopt()
is only that of the fixed header, variable data then follows the header.

IIRC there is a recently added one for async io.
Can't remember where.
It checks the 'header' size and takes the full length from within the header.
That one definitely requires (and checks) for the short length.

> On the set side (setsockopt) of the same option takes the opposite view.
> It rejects calls if optlen is not properly set.
> 
> 	err = -EINVAL;
> 	if (GROUP_FILTER_SIZE(gsf->gf_numsrc) > optlen)
> 		goto out_free_gsf;

It has always been asymmetric.

	David

> 
> Back to getsockopt(2), I was trying to look for users it, and glibc
> passes the full length for both options, with optlen and numsrc coming
> from the same variable:
> 
>       /* sysdeps/unix/sysv/linux/getsourcefilter.c */
>       socklen_t needed = GROUP_FILTER_SIZE(*numsrc);
>       gf->gf_numsrc = *numsrc;
>       result = __getsockopt (s, sol, MCAST_MSFILTER, gf, &needed);
> 
> and
> 
>       /* sysdeps/unix/sysv/linux/getipv4sourcefilter.c */
>       socklen_t needed = IP_MSFILTER_SIZE (*numsrc);
>       imsf->imsf_numsrc = *numsrc;
>       int result = __getsockopt (s, SOL_IP, IP_MSFILTER, imsf, &needed);
> 
> So the clamp is a no-op for every caller that goes through libc. 
> 
> So my conclusion is that this is a bug: setsockopt and glibc both treat optlen
> as the buffer size, and I could not find anything relying on the get side not
> doing so.
> 
> If you know of a caller that does, I will drop the series - I would rather
> look at it than assume it exists and assume that it will break someone that is
> leveraging a buggy behavior.
> 
> Thanks,
> --breno

