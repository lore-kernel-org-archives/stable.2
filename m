Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E93E3932C8;
	Tue, 25 Aug 2026 10:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787654227; cv=none; b=aXzSYGXz9hUnvCeX5Ty/QHix54cl4JInh27+VdTV69EpxzX+XyXTqMt3m5Xbu6/d8iwDmDwhpASZMtZvcOLqJYHuWf83+i/Yw7gkQMIsvV02apVDTsW06Uvpf/LOajEUwkAC61YOBUTGlk9zOXB2iYAKHtMvXXRuhiXQyhLD7qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787654227; c=relaxed/simple;
	bh=TzE/qZDQjWmMK2nKObW7NKxRq3DLrv7cvwB5ACNPEhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o/L2G5637PmdJs255SuliVDx0Vbuzi+9s6g+cfWyXIaDCpAZEoCFfJqhEAvptpep1G0J2cd9/hjkxm5uU6VnyIUHlTga0+exV0rgu0Nf1vnQFfuZtcpsuzV1RCIEdpSNqBua8BqtMbk2XZxY55y/bYxgdB5ydglJ7cCHG32sEag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=uYuWeT0N; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="uYuWeT0N"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+WeqyAoN4PwVARBGRrg9cd0bZ+XLeTX2CqqweZNfuiQ=; b=uYuWeT0NmdNqXtDkIUiXLycZa+
	CHsmnDBIV4R/6NsN9SbNLY1yXKjHg4Qa2DVco2izRji2JaCi264eFbOcdzI/cmFDN5ZnAQGEwlr3/
	+DKxUPI3MyclEBUUpxlMwBS4dWyhLwBymutg85QlqzAlZS+MAHq84Yt4dnPF3lrduOJgjPUXQtuGK
	uHA/p9llyF1dSyVvzd3tKZLvHAtpaIhO5t3agj7XEoLpqVfE0kTIL9Q9qPybzTxV6epV9Dd6+GMMe
	rZ+2DrhtcM/epqyFDPKAE5oq9OisfYS9BxnV39btrW//AyJmUiRh5XoR5QLkX8ijIocPfbN/52kx2
	87xFwjVg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wyoWF-00ENXg-0m;
	Tue, 25 Aug 2026 10:36:39 +0000
Date: Tue, 25 Aug 2026 03:36:32 -0700
From: Breno Leitao <leitao@debian.org>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH net] net: fix spurious TX timeout after dev_activate()
Message-ID: <ao1bBrMlSGfmpkYp@gmail.com>
References: <20260824-trans_start-v1-1-0419cc427ed9@debian.org>
 <4f3857029d855ed4e513ae01a2e8f018@tipi-net.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f3857029d855ed4e513ae01a2e8f018@tipi-net.de>
X-Debian-User: leitao

Hello Nicolai,

On Mon, Aug 24, 2026 at 05:13:13PM +0200, Nicolai Buchwitz wrote:
> On 24.8.2026 13:45, Breno Leitao wrote:
> > While debugging another issue today, I found out that my TX queue is
> > stopped for 136.07 years (4294907392 ms).
> 
> nit: 4294907392 ms is ~49.7 days

Lol, let me fix update it.

> >     bnxt_en 0002:01:00.0 eth0: NETDEV WATCHDOG: CPU: 28: transmit queue
> > 23 timed out 4294907392 ms
> > 
> > 4294907392 is not an elapsed time. It is the value of jiffies at that
> > moment: INITIAL_JIFFIES is 4294667296.
> > 
> > dev_activate() runs transition_one_qdisc() over every TX queue, which
> > resets trans_start to 0, and then stamps only queue 0 through
> > netif_trans_update().
> > 
> > Stamp jiffies instead. A queue stopped across dev_activate() now gets a
> > full watchdog_timeo of grace, and is still reported if it is stopped
> > that long.
> > 
> > Fixes: 9b36627acecd ("net: remove dev->trans_start")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >  net/sched/sch_generic.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
> > index ef2b4bf515641..4539dc2c6d380 100644
> > --- a/net/sched/sch_generic.c
> > +++ b/net/sched/sch_generic.c
> > @@ -1278,7 +1278,7 @@ static void transition_one_qdisc(struct net_device
> > *dev,
> > 
> >  	rcu_assign_pointer(dev_queue->qdisc, new_qdisc);
> >  	if (need_watchdog_p) {
> > -		WRITE_ONCE(dev_queue->trans_start, 0);
> > +		WRITE_ONCE(dev_queue->trans_start, jiffies);
> >  		*need_watchdog_p = 1;
> >  	}
> >  }
> 
> Follow up or v2: netif_trans_update() in dev_activate() now seems redundant?

Yea, good point, we can get rid of netif_trans_update(), given we have
updated all the trans_start in here.

I will respin this one.

Thanks for the review,
--breno

--
pw-bot: cr
