Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B3E4ED185;
	Thu, 17 Sep 2026 16:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789661385; cv=none; b=izrw9IAWm/60/KWXJxQhc02WS8PLEpwz0iznmzeHUoKo70VPaOvx2vu6fwKcL943D+JBfekzJx7bmBDRg/hmO/DTn+W+PRDaqne+ZozPNAfcypD4OZjgCYpRdUWiSmf8RSF97MF7HPRoH4via9Lh14CnQRKDTm8/F5SolwH5zVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789661385; c=relaxed/simple;
	bh=y5azVuUQo0EKF38LkZBCTZ34UL5VDnoxn5clT/4I1jM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k8Bg9NA8+5oDaNOjU1UPyrWzdty7wF92ieRDFF89PKtUg0CXH939MiM8olam9/dkDUwLS1IxVxsvDU2xmn2wOASh+l5nJiSaLT4+Jd9FJf4ifesf6OGC9A7AscqnBDpMnupDwReuRzfM9ky1SfY/qOM9H8Fbz9lSkCRxOBpAWeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NLYO0Hfc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NLYO0Hfc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E14001F00898;
	Thu, 17 Sep 2026 16:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789661384;
	bh=kr5LGH29uDKquRiQJXiJGsHjLAXb24yTBoZUaAV3cJo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NLYO0HfcQp1DARE5KfoKBObCkPc/3sDlDJIXN08teLGPNvzNzIQQkbzmbL8rN2kPp
	 /qKUUng5fwkeqdh6SvjbcXEka2CaJL/UKxW4HlJJOFPCMgoBTu2X6EBHDubJGdEmbZ
	 epd97epfWyCRtUF5kN2t1AQJOE7Wc+KPHCD/14y8=
Date: Thu, 17 Sep 2026 16:21:48 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Adarsh Das <adarshdas950@gmail.com>
Cc: dakr@kernel.org, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org, rafael@kernel.org,
	stable@vger.kernel.org,
	syzbot+4393dfdddf166f2de2b0@syzkaller.appspotmail.com
Subject: Re: [PATCH] kobject: fix uevent socket use-after-free on net
 namespace delete
Message-ID: <2026091753-bootleg-manicotti-5c1a@gregkh>
References: <2026091756-widen-doozy-399c@gregkh>
 <20260917151830.89024-1-adarshdas950@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917151830.89024-1-adarshdas950@gmail.com>

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Thu, Sep 17, 2026 at 08:48:30PM +0530, Adarsh Das wrote:
> Hi,
> 
> Sorry, I wasn't aware of the Assisted-by tag before. Should I send a
> V2 with it?

Please do.

> For testing I ran syzbot's C repro with -smp 4 on master, with
> multiple parallel instances of the repro. I was able to reproduce
> the bug:
> 
>   BUG: KASAN: slab-use-after-free in kobject_uevent_env+
>   Read of size 8 at addr ffff88800fa7f090 by task kworker/u16:5
>   CPU: 3
>   Workqueue: ib-unreg-wq ib_unregister_work
>   Call Trace:
>     kasan_report
>     kobject_uevent_env+0xc71/0xd90
>     device_del+0x7c7/0xcf0
>     disable_device+0x1d2/0x260
>     __ib_unregister_device+0x26b/0x400
>     ib_unregister_work+0x19/0x30
>     worker_thread
>     kthread
>   Allocated by task 498:
>     uevent_net_init+0xe5/0x340
>     setup_net
>     copy_net_ns
>     unshare_nsproxy_namespaces
>     ksys_unshare
>   Freed by task 63:
>     kfree
>     ops_undo_list
>     cleanup_net
>     worker_thread
>   The buggy address belongs to the cache kmalloc-32 of size 32
> 
> With this patch applied, I ran the same repro repeatedly (including
> parallel runs) and did not see the KASAN error anymore.

Did syzbot also test this?

And I have no context here at all, sorry, please realize that some of us
get 1000+ emails a day...

thanks,

greg k-h
