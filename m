Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B45737F006;
	Mon,  1 Jun 2026 22:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780352930; cv=none; b=mtA3gc8VXfNL9ll4/8AfqGZbtORNt6gNrq8SKCnMeRqCologRmIs0BldVc7nbCay4Gw7GYWqwKWKoUQIx8nvGL/r6PYB/PZE2HH3Bj2Wjf305VorGklOhvxTYPiSbJVcfgyi/ew6mcgMwfnHgKcowxqNcJjRE+lezqerN+yEtEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780352930; c=relaxed/simple;
	bh=ERdhZ8EuJghlpLmz9mtQPK9NrYe8hlS83gRzrpqbFo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DGe2/4z+AA4ahUUI4oDFEQq5YYll/4cgrSw9w4f2Peo66TrxxEXmm92GKdPT9KlVWVpTIwG7X8cot7niZYAHfBmIhOkN05iuzulsXQeWEz8Xp7U6VocbQV4lr5QdvbGXB2PYRLRxiJCr2eaigC+SWDddPsKJXsmia7J5sR830QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=YcLNd7rn; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="YcLNd7rn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Vn9sIhpIFNFI+ZKHx2gIeEyw1tzWiM3HqPBJWGJUqpk=; b=YcLNd7rnB1S7L2suVwz9wKJm+b
	5NShjn41nv3e+99446hUTC6rtc85gU0lVLeYKOZrEeZ9FqiwqJgnLRHFUkUXjPes/RwGH9CUFxYzY
	mZun3MCNV3TTHns5mPeFUr5G1UKk9r/51gBTl58biuMz8eqOyiC+Onhpf+cjed2j39rPCjpiE8cGb
	VYPnncYRy+VjgcMyaB/zalA9+akcwUHPQOlUG9ULNemC/HmkDqYVz++qesH3Elb5x+QIKeWovLV5g
	bzHzhMA0TiyIT1JqX0kQh1uUOa9A19ewxqzNv7oqLLZTxMulw2j8UR3+4tyg/BWDkCJSEsDBHCiJ3
	qY7gD76Q==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.localnet)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1wUAsF-003dnt-2h;
	Mon, 01 Jun 2026 17:12:43 -0500
From: Elizabeth Figura <zfigura@codeweavers.com>
To: Thomas Gleixner <tglx@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Maoyi Xie <maoyixie.tju@gmail.com>
Cc: linux-kernel@vger.kernel.org, Maoyi Xie <maoyixie.tju@gmail.com>,
 stable@vger.kernel.org
Subject:
 Re: [PATCH 2/2] ntsync: honour caller's time namespace for absolute MONOTONIC
 timeouts
Date: Mon, 01 Jun 2026 17:12:43 -0500
Message-ID: <2267204.NoIQtlUJzc@camazotz>
In-Reply-To: <20260528063311.3300393-3-maoyixie.tju@gmail.com>
References:
 <20260528063311.3300393-1-maoyixie.tju@gmail.com>
 <20260528063311.3300393-3-maoyixie.tju@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Thursday, 28 May 2026 01:33:11 CDT Maoyi Xie wrote:
> ntsync_schedule() takes the absolute timeout from userspace and hands
> it to schedule_hrtimeout_range_clock() with HRTIMER_MODE_ABS. For the
> default CLOCK_MONOTONIC path, it does not call timens_ktime_to_host()
> first.
> 
> A process inside a CLOCK_MONOTONIC time namespace computes the
> absolute timeout in its own clock view. The kernel reads the same
> value against the host clock. The two differ by the namespace offset.
> The timeout then fires too early or too late.
> 
> Other consumers of absolute timeouts run the ktime through
> timens_ktime_to_host() before hrtimer. Examples are timerfd,
> posix-timers, alarmtimer, posix-stubs and futex. ntsync was added
> later and missed that step.
> 
> /dev/ntsync is mode 0666. Any user inside a time namespace that can
> open it is affected. The visible effect is wrong timeout behaviour
> for Wine in a container that sets a CLOCK_MONOTONIC offset.
> 
> Reproducer: unshare --user --time, set the monotonic offset to -10s,
> issue NTSYNC_IOC_WAIT_ANY with a 100 ms absolute MONOTONIC timeout.
> The baseline run elapses about 100 ms. The run inside the namespace
> elapses about 0 ms.
> 
> Apply timens_ktime_to_host() to the parsed timeout when the caller
> did not set NTSYNC_WAIT_REALTIME. The helper does nothing in the
> initial time namespace, so the fast path is unchanged.
> 
> Fixes: b4a7b5fe3f51 ("ntsync: Introduce NTSYNC_IOC_WAIT_ANY.")
> Cc: stable@vger.kernel.org # v6.14+
> Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
> ---
>  drivers/misc/ntsync.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
> index 30af282262ef..02c9d1192812 100644
> --- a/drivers/misc/ntsync.c
> +++ b/drivers/misc/ntsync.c
> @@ -19,6 +19,7 @@
>  #include <linux/sched/signal.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
> +#include <linux/time_namespace.h>
>  #include <uapi/linux/ntsync.h>
>  
>  #define NTSYNC_NAME	"ntsync"
> @@ -836,6 +837,8 @@ static int ntsync_schedule(const struct ntsync_q *q, const struct ntsync_wait_ar
>  
>  	if (args->flags & NTSYNC_WAIT_REALTIME)
>  		clock = CLOCK_REALTIME;
> +	else
> +		timeout = timens_ktime_to_host(clock, timeout);
>  
>  	do {
>  		if (signal_pending(current)) {
> 

Looks correct and passes tests here.

Reviewed-by: Elizabeth Figura <zfigura@codeweavers.com>


