Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5DF4A1DEE;
	Thu, 15 Oct 2026 07:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792050071; cv=none; b=IA+CCIOmhMNY/ArfVRipDUoBbwulIABbA5xOxxprIHVZL0qrrYzbsHcY32BXdoQdeIzeFEPjpUTwedDHetdJqOzY2NZfuCD0Be3cht0cemucvnzm83rhxkNReCA4nFeNXIGwDYgEbvL7GrzfxtD/vohc7bzCNy0zWZTBwSIIWRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792050071; c=relaxed/simple;
	bh=Bhb9PRDELKoYFVHioioYpXD32C8uZsrMg1J60jThYKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sHTk17crn5EVt9UifL56V429wkMsU9s9pjKoEkjQRmn56XWzQ0lyUJNj3Gm4SPFoeoa016Np2l9CEWRGZOpJ4SOivKoJaLycOEdGHhoETpW6thPMA0JSc1o15HAJk5Zwh6DHmvGAwEEaCfAzwzVrzE3oMaXaLvWJbDF63q/T5/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XGEPkz6W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XGEPkz6W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB8E1F000C4;
	Thu, 15 Oct 2026 07:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792050068;
	bh=zxK1+UObHuf3zlOuhBsDQJxc1YfWtK0+CkxQmhUBnjg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XGEPkz6WQR27/VAG4cLv+gA5GCD9p3K+pQKFwpAYoPGTICIC8CPn7QRA7/kMT2/j8
	 D3ImYVfbpVUTN5SJeN4vs+ceUKMMHjL65TT4pPeJ0Tq3Jb58WLuvwoA3CUs2yWb7hd
	 SxzOqp1WmN8RxE4BAFwA7jpsN8w6oku/x/uv9aLfa73MWboAMXlYAYGY1gCrBOI1GG
	 tWL4CkhIwRNmsjtUH7Eic0GAaJabL/Fn3Uaik+QMkY52d1zt1r+/U/zpS5gRe1gjzP
	 yh8N6QHXKahKLq+Sm4VZSgc5FneXCk3dyKN9BkmY38ACS7lyZQAWn97ozXZXhqMZ+k
	 5RuMbVlqY6d7A==
Date: Thu, 15 Oct 2026 00:41:07 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Hardik Garg <hargar@linux.microsoft.com>
Cc: Michael Kelley <mhklinux@outlook.com>,
	"kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"namjain@linux.microsoft.com" <namjain@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] mshv_vtl: Check per-CPU register page before mmap
Message-ID: <20261015074107.GC936897@liuwe-devbox-debian-v2.local>
References: <20260911175146.1370148-1-hargar@linux.microsoft.com>
 <SN6PR02MB4157E82658A24F00691EEC8BD4832@SN6PR02MB4157.namprd02.prod.outlook.com>
 <06f970fe-ae23-4b5d-87fc-f2751bacc8bf@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06f970fe-ae23-4b5d-87fc-f2751bacc8bf@linux.microsoft.com>

On Thu, Sep 24, 2026 at 12:19:32PM -0700, Hardik Garg wrote:
> 
> On 9/21/2026 5:14 PM, Michael Kelley wrote:
> > From: Hardik Garg <hargar@linux.microsoft.com>
> >> Register-page setup is optional for each CPU. If allocation or
> >> registration fails, mshv_vtl_configure_reg_page() warns and leaves that
> >> CPU's reg_page NULL, but initial context setup continues successfully.
> >> Meanwhile, successful setup on another CPU sets the global
> >> mshv_has_reg_page flag.
> >>
> >> mshv_vtl_fault() checks this global flag before selecting the requested
> >> CPU's register page. With mixed setup results across online CPUs, the
> >> check passes even for a CPU with no register page, reaching
> >> get_page(NULL) when userspace faults in that mapping.
> > I'm a bit late in reviewing this because I was travelling all last week.
> >
> > This patch seems like it is just papering over the real problem, which
> > is that a global variable like mshv_has_reg_page can't represent the
> > status of an operation that may succeed or fail on a per-cpu basis.
> > I pointed this out (as did Sashiko) in review comments back in
> > April [1].
> >
> > The only other place mshv_has_reg_page is used is in 
> > mshv_ioctl_check_extensions() where its value is returned from an
> > ioctl() system call made by user space. That's a questionable practice
> > since ioctl() usually returns 0 on success, though the man page for
> > ioctl() does admit that some ioctls use the return value as an output
> > parameter and return a non-negative value on success. But even
> > then, a single value can't accurately reflect the status of an
> > operation that may succeed or fail on a per-cpu basis. User
> > space would presumably have a similar problem to what is
> > being fixed by this patch.
> >
> > Is there any reason that the real problem couldn't be fixed
> > instead of doing this fix on top of something that is fundamentally
> > broken?
> >
> > Michael
> >
> > [1] https://lore.kernel.org/linux-hyperv/SN6PR02MB4157CF364DA2C0CC657A6DCBD450A@SN6PR02MB4157.namprd02.prod.outlook.com/
> 
> Hi Michael,
> Thanks for the feedback and for pointing me to your April review.
> After going through it, I understand that the NULL check only addresses
> the immediate fault, while the global capability still misrepresents
> per-CPU availability.
> 
> I'll work on addressing the underlying issue and send a proposed fix
> soon.

I have not seen this new fix yet. I will keep this patch for now.

Wei
