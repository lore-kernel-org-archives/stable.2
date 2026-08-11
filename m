Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E2D3546EB
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 23:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786491136; cv=none; b=bWFm39Dj1PhJys4N97p94jfhOw/XXyJKejzVkuop8Vuc8yO5DGjOnjPP4kk1uxEUE8cUxHtbnTpaZGDQyneGN7V8Dv9mTFd012RR5Ixg/7HmZIrxxSAYz7CRV3j8Q0IRDJmwd1fjTo8QR+EtVNvTqKK4yiTLZ1LW2Xe/m5kXqdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786491136; c=relaxed/simple;
	bh=aSYeai7t0ui+YeQIJ74IQsmgiJ7c6FpXpe1kJX2U+8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QDDGdilcYo2uVgKMjKQcdvjGRtNLqjVRyOEG/dvAo9wsQYuRn4Zh7mtbYBHLJpbvnbcg6MKbUp7Aj1iVmEItNlR9uR2NLMyRDGqeBUHbDhWTYBfGqBPuDD0T8nWFZ033/Tq6p9ydWf5b6bFnDY2BMNJoqUA0Z7/LwCW4+ezDX2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oPkotRVh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oPkotRVh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5BBA1F000E9;
	Tue, 11 Aug 2026 23:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786491135;
	bh=OQX4pVZSTfSEQ4XXp4arsqEshIczzDx6VGtuP9M/uAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oPkotRVhzuAXzgd4MNynYSQFR92MvCN4eYwbXJHAO3eMD7xmbqNZYWeQETlKSXHfu
	 XIrSjt15C41fZGvvoi/yKTB/KZG7PkiBujKFBcyjkY5dskmllGnBHe+lx5IHjCqvLP
	 OE8/GvtGU94yGhME1DlaCrSisM3Q8c4uASFnjcqE=
Date: Wed, 12 Aug 2026 08:30:42 +0900
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	vegard.nossum@oracle.com
Subject: Re: Question: Why don't I see FAILED patch notifications for commit:
 622ebfac01ba4f9c0
Message-ID: <2026081210-lugged-bleep-94ba@gregkh>
References: <5b4ec416-804a-4bd6-aa12-5c317741977c@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b4ec416-804a-4bd6-aa12-5c317741977c@oracle.com>

On Tue, Aug 11, 2026 at 10:36:25PM +0530, Harshit Mogalapalli wrote:
> Hi stable maintainers,
> 
> I am curious to know why I can't see FAILED patch emails for:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=622ebfac01ba4f9c0060cebd41257fe46fc4a0b3

Why would you?

> the broken commit is in all stable trees:
> 
> Commit Data:
>   rev              : 355f4fb1405ec29d0fac49b4d41fcd78cbd455d5
>   subject          : kvm: nVMX: VMCLEAR an active shadow VMCS after last use
>   stable patch-id  : 67a5f1f0e5c07f4d579e84e2028f04fa5d0a393c
> 
> In Branches:
>   mainline             : v4.9-rc4 - 355f4fb1405e kvm: nVMX: VMCLEAR an
> active shadow VMCS after last use
> 
> and the fix has a CC: stable in it.
> 
> So I am wondering why FAILED patch notifications are not seen on
> stable@vger.kernel.org.
> 
> https://lore.kernel.org/all/?q=KVM%3A+nVMX%3A+Hide+shadow+VMCS+right+after+VMCLEAR

Because it is in a bunch of released kernels already:
	6.6.148 6.12.101 6.18.42 7.1.6
And queued up for the next 6.1, 5.15, and 5.10 releases, it's in the
queue.

thanks,

greg k-h
