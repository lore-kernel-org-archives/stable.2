Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3B234F483
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 06:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788156979; cv=none; b=cFvrQAEWuGxRj6s9bPcXQvGEvs5q93uSUiMyacOPymh8xD48m+WvDHaLhyGMOBJFed8CRnbv6sUBz2NJwXUXpP8K/YPXjFVgnVlk5JFvkPiJMwhNa57Ef6p6KghzkMu/CDGQGzt3etyUfP+a/Qr871Ox1KHjFkEZ/o+fH4ycL9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788156979; c=relaxed/simple;
	bh=s9OINHCECiugw6Bxleag8Ex/yIbXRXGyauw5I/9QSdc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=l4kLo3aI2++8oozGSqq18t8pIrX/it163HHfkYoARGe3MmgWALsbFiFZM+UGxzK+x1WSqka2/C0Ja7SoginDJzd9WZRHA/M72cd6Sz18RKHIOi6ARLAiVJ+nG3eiodlEZhKzxE8mu66cs52XYTG42BYjTqmyUVfxU+3Fvgd3NY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6cp+DQ4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6cp+DQ4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6533E1F00A3D
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 06:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788156977;
	bh=nQ1mOUazk5upCwE99RY/bxkx1ogD35Z5ZprZqBWTmPY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=a6cp+DQ4T6ccSctZrh/akEI1RYQmrxP8trpi3/4MBrf1pw1J8rIQmGZ0xr9BFTSfi
	 o0/3iLjvtKRkFjf6lYU7HvNKLfXjIz+ec3GgahH9Y55JySz7ekK21nObPGcmZ/uOBt
	 yaz+dFz7ZcnXS3zhI4ih8JzEW2v6tfj/K/DvUbaBw8TuRgZ121Qciq5VlHywwzRQ1m
	 Ftn0trevG7zQkb8AzA3TRoa9ha7hOjbP7wjzGow5lCxrXgXSFvIBVX6ln3ZVbygv/N
	 p+3xeCsee2chOCYAcivwFxIDQFfw3c0BJ6F3PY3IQhuHTqN6oMGj7S/+KJhp3x65su
	 bfdWv1aMoTH2Q==
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfauth.ams.internal (Postfix) with ESMTP id B8903198006B;
	Mon, 31 Aug 2026 02:16:15 -0400 (EDT)
Received: from ams-imap-11 ([10.64.2.31])
  by ams-compute-02.internal (MEProxy); Mon, 31 Aug 2026 02:16:15 -0400
X-ME-Sender: <xms:LByVamJ7YeNEvsdQ5Y59DrfwXpB_TjwlTyX_bJRfLfv6LDGtGi4wnA>
    <xme:LByVao9oQvsisq7XdcG8CRYfCvOghSz89z2vpa2siduxQ3YtucXsOwquH4aQ9DR0S
    ChPkAZO1ur9rdgMRNQLYdXxiEacoYvH6AJv77CWcjRluGg7c8R13BA>
X-ME-Proxy-Cause: dmFkZTGRWh3uAKJSJ4fzX7rQUTkRM0ok+x/9RVY95O3Kt4edIQPIo1yJqgLo4+wl9GIaUM
    Wf8bZrzB15C1S53cXh2wjZRLf2q/UgVT1n5TsW7zTfa3WG65q87zeGcgvWR0AgpkKuJ4LY
    sJ2CIIYGo/xMIC692J/5sSbaE6Zuwi2J0VQpbRvGreXOZ3QyH3CY2i1gFm6e7QbyDW4bdv
    XpRpoi+TP0awhJOXN0sIHbiLb+aJCUr2C1r9+Awi9h0sSAUAlYyp8zsbKIGINIqe4Cnk8c
    tsshHKB+sXTCCUw9lgMoozWSOKPArHEJ4wbyK7YGlnZlUf9j/531J8moto0g/EMln/JMQE
    S7gQiRYEpv5NiofMsAEWSr9F1A3Xaud8jtXNZUlNPNO58ewVHnaXAQkp2enfpiF6zSJ/sp
    UX/JyD2c6L/lPsj0KTaJvnLbZN3GpZKQYaipS3QwUdez3c3vi44ypBHxlCyy79NwUuDSFF
    td9jmitMJCFRHcrJQ+0GZH/zSMzj+TuMC6cDUNfaewl1USOVroOxyZB2ESZ1aGvoBXHJd9
    0sdZmP7D1JxqyNm2WgNcSs4wQF/NFl7NYTKUQjYaWbzGjkKVmJQ1dxKuH4ogl7jmCUVUz0
    w0FyFcBFGqdfzn6/o4+rB9QoR+z1Dp7h8IS6TjRMgp4kAMWisJx3rZC3suYg
X-ME-Proxy: <xmx:LxyVaor5sfsREBCEH4eOTypzkAHN3YpRbkQkBFQSsmd-gWb0oJimLg>
    <xmx:LxyVarMi_T_Ox9-Wj9JcVHmVN8XYFs6gi9lBkCtm8WR-kSQysvQPzA>
    <xmx:LxyVahrRnlY7Iqvq9CYqmqxxGyXGNtD_U0CwXtRrsqPatamZri7f8w>
    <xmx:LxyVamtl6REANe3zb3EWJipMSBViE5rmUnWQeQwRmTxcmTR2qTKn5A>
    <xmx:LxyVao0oQPZc3hQMux2mHrUHAgkSU1cV7x6tNCqtqQWHLBEUiPIlxG7H>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id A90ACF8007B; Mon, 31 Aug 2026 02:16:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 31 Aug 2026 08:15:52 +0200
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Karl Mehltretter" <kmehltretter@gmail.com>
Cc: stable@vger.kernel.org, "Catalin Marinas" <catalin.marinas@arm.com>,
 "Will Deacon" <will@kernel.org>, "Ryan Roberts" <ryan.roberts@arm.com>,
 "Mark Rutland" <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Message-Id: <7f744f2a-409b-454f-bdb9-fccb5031640d@app.fastmail.com>
In-Reply-To: <2026083125-upbeat-series-9565@gregkh>
References: <20260831054247.33352-1-kmehltretter@gmail.com>
 <2026083125-upbeat-series-9565@gregkh>
Subject: Re: [PATCH 6.6.y] arm64: mm: clear extra idmap level before use
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Mon, 31 Aug 2026, at 07:54, Greg Kroah-Hartman wrote:
> On Mon, Aug 31, 2026 at 07:42:47AM +0200, Karl Mehltretter wrote:
>> The 6.6.y adaptation of commit 0e9df1c905d8 ("arm64: mm: Don't remap
>> pgtables for allocate vs populate") removes the clearing performed by
>> early_pgtable_alloc().  Its replacement clears allocations made by the
>> generic page-table walkers, but 6.6's create_idmap() still allocates an
>> extra root level directly when a sub-48-bit VA kernel is loaded
>> sufficiently high in physical memory.
>> 
>> memblock_phys_alloc_range() does not zero the returned memory.  The direct
>> caller therefore publishes an uncleared root page and passes it to
>> __create_pgd_mapping().  A stale nonzero entry can trip the bad-descriptor
>> BUG_ON or be followed as a page-table descriptor, preventing the kernel
>> from booting.
>> 
>> Clear the direct allocation through its linear alias before publishing it.
>> init_clear_pgtable() also supplies the barrier required before the table
>> descriptor becomes visible.
>> 
>> Mainline is not affected because commit e6128a8e523c ("arm64: mm: Use
>> 48-bit virtual addressing for the permanent ID map") removed the dynamic
>> extra level before page-table initialization moved out of the allocator.
>
> Why can't we take that change instead?
>

Nope. That relies on a massive refactoring of the arm64 startup code.

Can we just revert 0e9df1c905d8 (aka 54322d95309d) instead?

