Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A7A3C73F7;
	Thu, 30 Jul 2026 12:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785415138; cv=none; b=vDiaal2jX0V7crqBtRuDM4WD+WodRhtXKoOcGb5cEf4plEbcxPEz6dLaJiMxzhyyd7JPHDFiQ2jGt0YQq2l12srKD31we2orZ2Bm01t5lcTuqeDN9fM24bSJnk0RQGJUZarjZuzxoJcTizpwr2hlMtqAPq/fKW6UNi9aDpS/W6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785415138; c=relaxed/simple;
	bh=VePT+HoxY5sug0xyNMVuJZyCS5iGb8lfdl3PzKeXBIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gGvcC/hINL4kW6A5z5Womud51djzZe6xpMf2jmO8Z0/7yk53rfo79mykCHu+4qrWULBafHyu2JfZDzB724vMGnSNnCyqpttiLjNocLwfMpxwdqhKlKOds3GHNkfuhxoStENukTb70NyAMIJ93uA3SGSK+4BB5Kh+BT0V+xNb3Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=szfeQsL0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="szfeQsL0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F08F1F000E9;
	Thu, 30 Jul 2026 12:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785415136;
	bh=G9dBsbHFtnsoPzu1y2fk+jp8KXfdGqzJ6CGDLwjFSLc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=szfeQsL0GjeRmU7x5/3KTNo6HFlRs/BtXNMvrSP65YMLUuEc962xADY1zoWj067tu
	 jfNFsES8WDbUV6dFd8TlW0/QuBOlDrZVzHzs6yJL+HkOmB+cI752BZWL00J8TXYJqp
	 pPtL0COPn6RiXhRkq3RmgiHODZLszf107/LU1d40=
Date: Thu, 30 Jul 2026 14:38:42 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: stable@vger.kernel.org, Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>,
	Kees Cook <kees@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Tiwei Bie <tiwei.btw@antgroup.com>,
	"open list:USER-MODE LINUX (UML)" <linux-um@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)" <linux-kselftest@vger.kernel.org>,
	"open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)" <kunit-dev@googlegroups.com>,
	bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH stable 6.12 0/9] Kunit backports for older systems
Message-ID: <2026073005-release-puzzling-8f07@gregkh>
References: <20260724214119.1066665-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724214119.1066665-1-florian.fainelli@broadcom.com>

On Fri, Jul 24, 2026 at 02:41:10PM -0700, Florian Fainelli wrote:
> This patch series addresses an issue we encountered on older Ubuntu
> 20.04.6 LTS servers whereby running Kunit would not return to a prompt
> and it would not be possible to Ctrl-C the running session either.
> 
> Benjamin Berg (2):
>   um: Set parent death signal for winch thread/process
>   um: Set parent death signal for userspace process
> 
> David Gow (1):
>   kunit: tool: Terminate kernel under test on SIGINT
> 
> Shuvam Pandey (1):
>   kunit: tool: skip stty when stdin is not a tty
> 
> Tiwei Bie (5):
>   um: Add os_set_pdeathsig helper function
>   um: Use os_set_pdeathsig helper in winch thread/process
>   um: Set parent-death signal for ubd io thread/process
>   um: Set parent-death signal for write_sigio thread/process
>   um: Preserve errno within signal handler
> 
>  arch/um/drivers/chan_user.c            |  2 ++
>  arch/um/drivers/ubd_kern.c             |  1 +
>  arch/um/include/shared/os.h            |  2 ++
>  arch/um/os-Linux/process.c             |  6 ++++
>  arch/um/os-Linux/sigio.c               |  1 +
>  arch/um/os-Linux/signal.c              |  3 ++
>  arch/um/os-Linux/skas/process.c        |  3 ++
>  tools/testing/kunit/kunit_kernel.py    | 39 +++++++++++++++++-------
>  tools/testing/kunit/kunit_tool_test.py | 42 ++++++++++++++++++++++++++
>  9 files changed, 88 insertions(+), 11 deletions(-)
> 
> -- 
> 2.34.1
> 
> 

Many of these are not in newer stable kernel versions.  So can you send
patches for 6.12 and all newer branches (i.e. 6.18.y and 7.1.y) for the
missing patches for them, and then resend this 6.12.y series and we will
be glad to queue this up then.

thanks,

greg k-h
