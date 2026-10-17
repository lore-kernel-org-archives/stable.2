Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF9429B795;
	Sat, 17 Oct 2026 03:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792209303; cv=none; b=PDBVI6PdlwsmGl6/fyfaMOMfsopbP7LwZDIwv0cTNVUcwoaeTSM7jo/ISsnUibaSef37lMeGxKjIzdxOULWRrw84b0yO2aIpYB42rJzkLmBUego6VRW5W5kH0CRxD2pA4oveyZ/Nx9zk9Iw1rnUOXNgfF8wHuIt2Qr8c/VsHRl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792209303; c=relaxed/simple;
	bh=WQxIWjVKXq7oJufScal/3s5vd7daAbc5n5ip9vXLHBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i34sLR9EWloHGji9dG0I0394G92HyJc+CBTViYJFLPY8A9udfbZqfAQy9xhPSC0bLmueicnFUt6rnLJwDFAyChv6kJ2Z+VHWtV6AvYUFWV7VB/GbODbS7EvF7ao0JsIacrGTK53utY8ZQ1JbTXfIRVR2S1ZSRfk0L47qATrk178=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NIzmr8ur; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NIzmr8ur"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14C9E1F000C4;
	Sat, 17 Oct 2026 03:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792209301;
	bh=dYKqmfQOQ8r5Ld/7QkbmnQUf9ML++5Y7VJQOWpm16G8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NIzmr8uroyLTVOd5r5AYJ++HjeebF8iOPLBQVryhIXgDOGnPaD4ofgzuy+TVzsnlc
	 vP4HTMhiekeOI3LDDr4YfXDebeEO4szjeN6Q3HqtUFE5g1+sxZz0vpQX7jisRRplYG
	 yqY4/50chIVzl3vh4AwTkNmjK3m2w31p5Y3P696QEHIwTMJNjforU4PwruNcrspOIm
	 xywgfzENWeyiAPHwPHpeD760Ccf5/abicisCRlfseMTjZwDh90nt0QlrrD5boDmutP
	 3KS9B8l6lCslb3YLXK1j8J8l/zdmO67YyHZLWHulAa9uoDhJHpCrylRB91lJ3xtUls
	 CNfC5Peatb6sQ==
Date: Sat, 17 Oct 2026 09:24:38 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Joonhoe Kim <26rote@gmail.com>
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, christopher.lew@oss.qualcomm.com, 
	deepak.singh@oss.qualcomm.com, pranav.phansalkar@oss.qualcomm.com, andersson@kernel.org, 
	linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH net] net: qrtr: ns: retry service announcements on -EAGAIN
Message-ID: <atLkH_D2JrYdzacx@debian>
References: <20261016124600.31-1-26rote@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261016124600.31-1-26rote@gmail.com>

On Fri, Oct 16, 2026 at 09:45:59PM +0900, Joonhoe Kim wrote:
> Since commit 544d85de4dc2 ("net: qrtr: Send HELLO message on endpoint
> register"), qrtr_node_enqueue() returns -EAGAIN for every packet but
> HELLO until our HELLO has gone out to the node. The HELLO is retried,
> but the NEW_SERVER announcements sent in reply to the remote's HELLO
> are not, so a service registered before the remote came up is never
> announced to it.
> 
> On Kaanapali the modem sends its HELLO before it accepts ours. With
> rmtfs started first, the modem never learns about rmtfs and its
> watchdog resets the SoC about 40 s later.
> 
> Retry each announcement for up to 10 s while it fails with -EAGAIN.
> announce_servers() runs from the name service worker, which can sleep.
> 
> Fixes: 544d85de4dc2 ("net: qrtr: Send HELLO message on endpoint register")
> Cc: stable@vger.kernel.org
> Signed-off-by: Joonhoe Kim <26rote@gmail.com>

Thanks for the fix!

> ---
> Tested on a Lenovo Legion Tab Y700 Gen 5 (out-of-tree board support)
> with rmtfs started before the modem: without this patch the SoC resets;
> with it the announcement goes out on the first retry and the modem
> stays up. Starting rmtfs after the modem avoids the problem, but
> distribution units start rmtfs first and let it boot the modem.
> 
>  net/qrtr/ns.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/net/qrtr/ns.c b/net/qrtr/ns.c
> index bcb090ee79d4..33a9c4449d6f 100644
> --- a/net/qrtr/ns.c
> +++ b/net/qrtr/ns.c
> @@ -5,6 +5,7 @@
>   * Copyright (c) 2020, Linaro Ltd.
>   */
>  
> +#include <linux/delay.h>
>  #include <linux/module.h>
>  #include <linux/qrtr.h>
>  #include <linux/workqueue.h>
> @@ -226,7 +227,13 @@ static int announce_servers(struct sockaddr_qrtr *sq)
>  
>  	/* Announce the list of servers registered in this node */
>  	xa_for_each(&node->servers, index, srv) {
> +		unsigned long timeout = jiffies + 10 * HZ;
> +
>  		ret = service_announce_new(sq, srv);
> +		while (ret == -EAGAIN && time_before(jiffies, timeout)) {
> +			msleep(100);
> +			ret = service_announce_new(sq, srv);
> +		}

This loop is going to block other nodes. announce_servers() is called from
ordered workqueue which only executes atmost one work item at any point of time.
So if any other node queues command while this loop is running, it will get
blocked.

What you can do is, ask your LLM to rework this code to schedule a new *delayed*
work in the same qrts_ns.workqueue and just keep on rescheduling it until
-EAGAIN is not received from announce_servers(). While the new work item gets
scheduled on the same workqueue, the delayed work gives other node's a chance
to execute and not just block. You can use a conservative delay of 100ms.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
