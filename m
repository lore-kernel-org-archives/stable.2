Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB43C28030E;
	Thu, 13 Aug 2026 00:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786581292; cv=none; b=nNvc9SXpF4l6AJLGoJD+Jfd93UAggSfTdPBOs5VRdHxE9VTWabuejHiXLEHKsGKAHvITN9XpAqtQ3869eHsTeX+7EScUi83rNBN+w3m/WyeYXASHgSBQAXjv0cJZ6H4abbAQnLRf4JLH0oAhSJi4aV/ucA9BIQ+DNKckTyZxgwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786581292; c=relaxed/simple;
	bh=KFj5P24F1AEnJChNSamgwtFXe6TOTvTWTTn7fKE+zlc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dh4zTTAUZxiCcDOARL/kzxGGpTU1fTu9qkBuUFSfZQhsqQNJj2HWRdANMSzTHs5r4EZ4O1nIcibYPN/D9mbVl27pX5CAINfxP2w1tH7IbUaz1PJgv3NbvmQAlLC01Y+I+ATgpfxXETisRowSE1kyqGSxe5sgVsTQfhLXF9/RwFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iWkrz68W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iWkrz68W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC7CB1F000E9;
	Thu, 13 Aug 2026 00:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786581291;
	bh=1aXrKHxQvIMQY5Fq2SP3Tt8YhX6vdX8ILbhu43aUsa0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iWkrz68WVE012c0Usm5StSB7Z+K0hcpicJKbZOtUfO3p34BHfcug1oK/xuk/6mVGx
	 76XsIdWe0jukaYPKjFjz0skAkf3roPjlcM2DXO557HxHPLTXr1iEnmqWRzUSbcdkg4
	 Yt696vb5JGUa4KkADajTjZihkYgGV4pZmia/NDaIv00HGxB6OHXiHKCG3k3hlHGjBF
	 hb0jUCey7wx/NMw0xEEddLZ3BeVUvkGtHYsnoHSeCslpB1oY0JEyB9jR8BbtSQ9p7J
	 1spMoOc8l1d1PsI3NwCtRD7S5B4XLz4jSCf79cQl/DL+EHuoyXB/YkMwRYi2odaCR9
	 S+pogIbP0oEOw==
Date: Wed, 12 Aug 2026 17:34:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: David Lee <david.lee@trailofbits.com>, jhs@mojatatu.com,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, Kyle Zeng <kylebot@openai.com>, Dominik 'Disconnect3d'
 Czarnota <dominik.czarnota@trailofbits.com>, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net] net/sched: sch_taprio: do not requeue a deactivated
 qdisc
Message-ID: <20260812173450.74e528b7@kernel.org>
In-Reply-To: <87ecgc48x3.fsf@intel.com>
References: <20260805102514.740834-1-david.lee@trailofbits.com>
	<87ecgc48x3.fsf@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 05 Aug 2026 13:19:36 -0700 Vinicius Costa Gomes wrote:
> David Lee <david.lee@trailofbits.com> writes:
> 
> > From: Kyle Zeng <kylebot@openai.com>
> >
> > Root qdisc replacement and deletion call dev_deactivate() without
> > resetting the old qdisc. This marks the qdisc deactivated and waits for
> > existing runs to finish, but leaves TAPRIO's private hrtimer active.
> > advance_sched() can therefore requeue the old root after the final busy
> > check, allowing a new run to overlap reset and destruction.
> >
> > Do not schedule TAPRIO after its root has been deactivated. Keep the
> > test in the existing RCU read-side critical section so that it pairs
> > with the synchronize_net() in dev_deactivate_many(): a callback which
> > observes an active qdisc must finish before the final busy check, while
> > a later callback observes the deactivated state and skips the requeue.
> >
> > Fixes: 5a781ccbd19e ("tc: Add support for configuring the taprio scheduler")
> > Cc: stable@vger.kernel.org
> > Assisted-by: Codex:gpt-5.6-sol Codex:gpt-5.5-cyber
> > Signed-off-by: Kyle Zeng <kylebot@openai.com>
> > Co-developed-by: David Lee <david.lee@trailofbits.com>
> > Signed-off-by: David Lee <david.lee@trailofbits.com>
> > ---
> > Bug found and triaged by OpenAI Security Research and
> > validated by Trail of Bits.
> >
> > The supplied v7.2-rc3 trace contains a KASAN use-after-free. The
> > reproducer did not trigger a sanitizer report in the current v7.2-rc5
> > campaign and can be shared if needed.
> >
> >  net/sched/sch_taprio.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
> > index 299234a5f..2cf76df43 100644
> > --- a/net/sched/sch_taprio.c
> > +++ b/net/sched/sch_taprio.c
> > @@ -990,7 +990,8 @@ static enum hrtimer_restart advance_sched(struct hrtimer *timer)
> >  	hrtimer_set_expires(&q->advance_timer, end_time);
> >  
> >  	rcu_read_lock();
> > -	__netif_schedule(sch);
> > +	if (!test_bit(__QDISC_STATE_DEACTIVATED, &sch->state))
> > +		__netif_schedule(sch);
> >  	rcu_read_unlock();
> >  
> 
> I'll be the first one to admit that taprio is a weird one (that it keeps
> a timer around while it's running among others), but it looks to me that
> this check would make more sense inside __netif_schedule().
> 
> Let's see what others think.

see the clashiko AI comment below. If that's true and indeed problem
did not exist before 47e8dbb6e763e5 -- then the fix is misplaced,
like you say. (I'm not sure about __netif_schedule(), to be clear,
but some_qdisc_is_busy() is not strong enough?)


The changelog opens with:
  "Root qdisc replacement and deletion call dev_deactivate() without
   resetting the old qdisc."
Is that true for the trees the Fixes: tag points at?
That behaviour looks like it arrives with 47e8dbb6e763e5 ("net/sched: do
not reset queues in graft operations"), which added the reset_needed
argument and made qdisc_graft() use:
net/sched/sch_api.c:qdisc_graft() {
	...
		if (dev->flags & IFF_UP)
			dev_deactivate(dev, false);
	...
}
Before that, dev_deactivate_many() ran dev_reset_queue() on every txq
unconditionally, and it did so before the some_qdisc_is_busy() wait loop.
dev_reset_queue() resets rtnl_dereference(dev_queue->qdisc_sleeping), which
in the root-graft path is still the old taprio qdisc, so
qdisc_reset() -> taprio_reset() -> hrtimer_cancel() disarmed advance_timer
before the busy check, and nothing re-arms it outside
taprio_change()/taprio_start_sched() under RTNL.
If that reading is right, the requeue-after-busy-check window does not
exist without 47e8dbb6e763e5, but the patch carries
Fixes: 5a781ccbd19e ("tc: Add support for configuring the taprio
scheduler") plus Cc: stable, which aims it at every stable tree back to
v4.20.
Should the Fixes: tag name the commit that made dev_deactivate() skip the
reset, and should the changelog mention that this reset-skipping behaviour
is a recent change, so the backport range is clear?
-- 
pw-bot: cr
