Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F653A1B5;
	Sun,  4 Oct 2026 05:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791091349; cv=none; b=Vvbv0PfyiDtBd8In1xtu5KQg3UL5gRj9Bd+JGZLIvekp71kb5kXQGyieiaZOk88SPh+lk16EtMGCpMimzF7EJmdHELtHIOTUzcDLnr1x2bokKLbOI5Yb8BOPZzIJ1DZj8N7RJ/u9bGqIkwQqSewz86FCvVQifqlfwknlIw8+/gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791091349; c=relaxed/simple;
	bh=B/MSL//zhiKLAEpq4hA5MO5s6LQMX2bzSD9HF9K4irw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M+LAS9vlj1+Z1lUjE8eozjcu9/Dg8n0GSkxXln5jOATR3oKhnqYYBAIm8g0QG1bhf8q/7g8ZGbi7ppBPDvu54AblMzyRrVhbKn1NicjskveTpkYGoDuJZMiNadd2dyLt7I5ZJZId1vt7vWNYXSPKghQR1heCLvYR1EnBufLeMYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KXSapPqB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KXSapPqB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C42A01F000FF;
	Sun,  4 Oct 2026 05:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791091347;
	bh=YkYw579dmCP/OW8cBpO24TIOyF4rtApoF4Uc+p+Gn+Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KXSapPqBqCmX23LS4KhdkfTPLHTxFqdLCk6lCVT2/cvV/UIF8JF2v2ArEeJB+Esam
	 m4zwRjQOksrJ93EljNWn2PvbEWLklRXuoYnm3Wi437y2Y2WFPG8h50qMD7749wPqSB
	 s6vJxkKs7NH+bELgmr9obGx0D/ZU5jeKh5fJ6DSAJBpc+tvkMcGc31sY5Dpx68cV53
	 3CJZlI9bUCSPP8EqTleMEMEi31rVNhNbxwLFG5yZalj88yAYb+I/dLomHfHsv7W9gg
	 InAll+klajYy5g32LBw1bboJ9RATZn+MwpdQvEiNM67LkTP3TBWhKN2EaYohjKnRdT
	 cufHwtQZy87jw==
Subject: Re: [PATCH net v3 1/2] xfrm: iptfs: track independent drop deadlines
From: netdev-bot+sashiko@kernel.org
To: roshaen09@gmail.com
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com,
 herbert@gondor.apana.org.au, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, chopps@labn.net,
 linux-kernel@vger.kernel.org, lilly@aronleigh.au, shubham@octane.security,
 gio@octane.security, robert@octane.security, paolo@octane.security,
 stable@vger.kernel.org
Date: Sun, 04 Oct 2026 05:22:26 +0000
Message-ID: <179109134634.434549.13083312620990703023@kernel.org>
In-Reply-To: <20260930050307.1978654-2-roshaen09@gmail.com>
References: <20260930050307.1978654-2-roshaen09@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 (2) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] iptfs_reset_drop_timer() now calls hrtimer_start()
  unconditionally every time any queued state changes.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it is in the
  code the patch touches and relies on.
- [High] This problem wasn't introduced by this patch, but it is serious.

--

xfrm: iptfs: track independent drop deadlines

This patch records an absolute drop deadline for an in-progress IP-TFS
reassembly. It adds iptfs_reset_drop_timer(), which arms the shared
drop_timer for the earlier of the reassembly deadline and the reorder
window slot 0 deadline. On expiry, iptfs_drop_timer() now drops only the
state whose own deadline has passed and rearms for anything that remains.

Link: https://lore.kernel.org/netdev/20260824072851.301644-3-lilly@aronleigh.au/
Link: https://lore.kernel.org/netdev/apaRiWQn54Pr9hpm@secunet.com/

> diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
> index 6920940a35b49..e538cc98e2572 100644
> --- a/net/xfrm/xfrm_iptfs.c
> +++ b/net/xfrm/xfrm_iptfs.c

[ ... ]

> @@ -703,15 +705,38 @@ static void iptfs_complete_inner_skb(struct xfrm_state *x, struct sk_buff *skb)
>  	}
>  }
>  
> +/* Arm the shared timer for the earliest reassembly or reorder deadline. */
> +static void iptfs_reset_drop_timer(struct xfrm_iptfs_data *xtfs)
> +{
> +	u64 expires = 0;
> +	u64 now;
> +
> +	assert_spin_locked(&xtfs->drop_lock);
> +
> +	if (xtfs->ra_newskb)
> +		expires = xtfs->ra_drop_time;
> +	if (xtfs->w_savedlen &&
> +	    (!expires || xtfs->w_saved[0].drop_time < expires))
> +		expires = xtfs->w_saved[0].drop_time;
> +	if (!expires) {
> +		hrtimer_try_to_cancel(&xtfs->drop_timer);
> +		return;
> +	}
> +
> +	now = ktime_get_raw_fast_ns();
> +	hrtimer_start(&xtfs->drop_timer, expires > now ? expires - now : 0,
> +		      IPTFS_HRTIMER_MODE);

[Severity: Medium]
Can an overdue deadline keep getting pushed back here?

hrtimer_start() is now called every time, so it replaces any expiry that
is already queued. Once the earliest deadline has passed, the timer is
restarted with a relative delay of 0.

IPTFS_HRTIMER_MODE is HRTIMER_MODE_REL_SOFT. On CONFIG_TIME_LOW_RES
builds (m68k, parisc, csky), hrtimer_update_lowres() adds one jiffy to
every relative expiry:

kernel/time/hrtimer.c:hrtimer_update_lowres() {
    ...
	timer->is_rel = mode & HRTIMER_MODE_REL;
	if (timer->is_rel)
		tim = ktime_add_safe(tim, hrtimer_resolution);
    ...
}

So each call after the deadline moves expiry to now + 1 jiffy. The reset
runs in these places:

- for each new most-future reorder packet, via
  iptfs_set_window_drop_times()
- for each reassembly start, in __input_process_payload() and
  iptfs_reassem_cont()
- for each reassembly completion or abort, via __iptfs_reassem_done()

Say the expected sequence is missing and these events arrive more often
than once per jiffy. Would the overdue timer then never fire?

If so, the saved packets and the overdue reassembly would wait until
traffic pauses or the window fills. At that point
__reorder_future_shifts() forces progress, which can take up to
reorder_win_size arrivals (up to 65535).

The old code only started the timer when !hrtimer_is_queued(), so it
never replaced a queued expiry.

> +}
> +

[ ... ]

> @@ -1162,12 +1190,9 @@ static bool __input_process_payload(struct xfrm_state *x, u32 data,
>  
>  			xtfs->ra_newskb = skb;
>  			xtfs->ra_wantseq = seq + 1;
> -			if (!hrtimer_is_queued(&xtfs->drop_timer)) {
> -				/* softirq blocked lest the timer fire and interrupt us */
> -				hrtimer_start(&xtfs->drop_timer,
> -					      xtfs->drop_time_ns,
> -					      IPTFS_HRTIMER_MODE);
> -			}
> +			xtfs->ra_drop_time = ktime_get_raw_fast_ns() +
> +					     xtfs->drop_time_ns;
> +			iptfs_reset_drop_timer(xtfs);
>  
>  			spin_unlock(&xtfs->drop_lock);
>  

[Severity: High]
This is a pre-existing issue, not one introduced by this patch. Can
xtfs->ra_newskb be overwritten here while another reassembly is still
in progress?

For a single SA, iptfs_input_ordered() looks like it can run on two CPUs
at once. The timer path takes the flushed packets under drop_lock and
processes them after releasing it:

iptfs_drop_timer()
    spin_lock(&xtfs->drop_lock)
    __reorder_drop()
    spin_unlock(&xtfs->drop_lock)
    iptfs_input_ordered()

iptfs_input() does the same with the in-order packets returned by
iptfs_input_reorder(). Nothing else serialises the two paths:

- xfrm_input() has already released x->lock before calling
  xfrm_inner_mode_input().
- drop_timer is not pinned, so get_target_base() can move it to another
  CPU via get_nohz_timer_target().

iptfs_input_ordered() checks ra_newskb and ra_runtlen without holding
the lock. It takes drop_lock only around iptfs_reassem_cont():

	if (blkoff || xtfs->ra_runtlen || xtfs->ra_newskb) {
		spin_lock(&xtfs->drop_lock);

Take the timer on CPU1 flushing seq N+2, which starts a fragmented inner
packet, and advancing w_wantseq to N+3. At the same time, CPU0 receives
and processes N+3:

CPU1                                CPU0
iptfs_drop_timer()
  iptfs_input_ordered(N+2)          iptfs_input_ordered(N+3)
                                      sees ra_newskb == NULL,
                                      iptfs_reassem_cont() drops
                                      the continuation
    __input_process_payload()         __input_process_payload()
      xtfs->ra_newskb = skbA;           xtfs->ra_newskb = skbB;

Is skbA leaked in this case? Nothing ever frees it or times it out. Also,
ra_wantseq and ra_drop_time would now describe the wrong packet.

The later patch in this series, "xfrm: iptfs: hold a device reference
while packets are queued", adds netdev_hold() for ra_newskb. With that
patch, the leaked skb would also hold a net_device reference and block
unregistration of that device.

[ ... ]

> @@ -1363,13 +1388,6 @@ static u32 __reorder_drop(struct xfrm_iptfs_data *xtfs, struct list_head *list)
>  		__vec_shift(xtfs, count);

[Severity: High]
This isn't a bug introduced by this patch, but this patch edits
__reorder_drop(). iptfs_reset_drop_timer() also now bases the timer on
w_saved[0].drop_time. Is the window layout that __reorder_drop() leaves
behind correct when the walk stops early?

The rest of the reorder code assumes w_saved[i] holds sequence
w_wantseq + 1 + i. __reorder_future_fits() uses index = distance - 1.
__reorder_this() shifts by count + 1 so that the new wantseq's own empty
slot is discarded:

	/* Shift handled slots plus final empty slot into slot 0. */
	__vec_shift(xtfs, count + 1);

__reorder_drop() increments w_wantseq and walks slots 0..k-1. It stops at
empty slot k if that slot's drop_time is still in the future:

		for (; s < se && !s->skb; s++) {
			if (s->drop_time > now)
				goto outerdone;
		}

It then adds k to w_wantseq, so the new wantseq is the sequence held in
slot k. However, it shifts by only count.

Doesn't that leave the empty wantseq slot at w_saved[0], with every saved
skb one slot too high?

For example, start with w_wantseq=10 and
w_saved=[skb11(T1), empty(T2), skb13(T2)]:

  timer fires at T1: w_wantseq=11, skb11 sent, walk stops at slot 1,
    count=1, w_wantseq=12, w_saved=[empty(T2), skb13]
  seq 12 arrives: __reorder_this() sets w_wantseq=13, count=0, shifts
    by 1, w_saved=[skb13] (now in the seq 14 position)
  seq 14 arrives: __reorder_future_fits() computes index 0, finds skb13
    there and frees seq 14 as a "dup of a future"

skb13 is then held until T2 (1s by default). If nothing arrives before
T2, __reorder_drop() sends skb13 with count=2 and sets w_wantseq=15. A
later seq 14 is then discarded by iptfs_input_reorder() as a past packet.

The later patch "xfrm: iptfs: hold a device reference while packets are
queued" does not change this logic either.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930050307.1978654-1-roshaen09%40gmail.com
