Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795593209;
	b=eLps+hM4UJ8cFolgYSXQLKy59xKAheIlh/drOUX0+p4jnbn2YtEIHSjIslvxWh6DM2Bi
	 zoFWBbs785VYCvP7Hpbtr6qCLdapBZzW0sRVudH0THnMMuVmM18SNTiUOA1ItUXT6C1IP
	 2dkgXtsdbfTM0ZDiGEvahXipfeb20lfETxE7Fo/myfSskg2Pz4lK5wXXbdIPn6uz6NQm7
	 9WyjIIeYDMDg+Qh57XOsIh6U5/BUduLg+YaBCA59a/IVY6ASSPExoxk4+7QyWo1DgCYUo
	 O4vIgUH80/vb4wJkc8rA53c1gVefOOIiX7n817wwCSevHlInHvIuZW8nqbloGqm6oGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795593209;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=asAIkoqL4rWRijwrcZTmejrceLoeC5xA34MCJHZUYsY=;
	b=O/soh0EYgq7MJInzZHCfToCKaVtkH3bbp4hEYA/dTTqiuHynHMEWKXi0lxuY1gGb7u4u
	 lgXAtdcSlN982dwgTIyLQRkeKZDq3C/8u6trhcunmOdxiocNI2qZcJOd6OMmASqI7tBfs
	 eImrJ4Ax/YMCZ/XkwbiAaXFfWcOjUhKR/LZSXAm9kM/jxaKwHk7Pp50T2TvOL8DqX+8ey
	 jrEx9SZaxsvZ/eZzQgIRjHYOybeQZYic6PwjRMONEZOr6bFaT1ZhNeAvuIBBaPKmKT4PE
	 j6eHWTpuqmaH/5ybOyvn59tezwquagqOnl4JfYIOzhGG/4Jdh0VYfRABTgemkyhsduw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bkYtNNeX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E169606A321;
	Wed, 25 Nov 2026 07:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bkYtNNeX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24F5F1F000E1;
	Wed, 25 Nov 2026 07:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795593208;
	bh=asAIkoqL4rWRijwrcZTmejrceLoeC5xA34MCJHZUYsY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bkYtNNeXnbcRSV1hUxf42xU6Ba9CPJEBbGlyH3DbeNlfe9Caz59rNZxIhKSHaRgb6
	 B2kmw+qxnTlAZWVtnAxmXzwQXs4wDgxaLwMM13ONtXuLAjqxP1839ac/NPTS/njthS
	 ge7BGDVDcJEBtr2/v9vOJoRRHUaYBfOGkfx3BkIzja+RsUjOoVGK9u7rlsFt3Z8wQq
	 Ktgt5cQWoeS4efAkx1qh3BVzF2Nkui0/OgOY+1qnjpx+1JoJARqSirNwQ5eKInYMUK
	 zLKGS7a39N2wTHaNu77td4dduWIIzd7SyPqB1vrh+H78tK+YCokTH2vUUZFX9G+fJO
	 Zlk3bIUwKVGiA==
Subject:
 Re: [PATCH net v2] r8169: clear RxOverflow before unmasking interrupts
From: netdev-bot+sashiko@kernel.org
To: jure.rebernik@luxonis.com
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, sgoutham@marvell.com,
 jacob.e.keller@intel.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Date: Wed, 25 Nov 2026 07:53:27 +0000
Message-ID: <179559320769.3135.10021676764558133789@kernel.org>
In-Reply-To: <20261121073652.410916-1-jure.rebernik@luxonis.com>
References: <20261121073652.410916-1-jure.rebernik@luxonis.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] In rtl8169_poll()
  (drivers/net/ethernet/realtek/r8169_main.c:5673-5680), RxOverflow is…
- [Low] The changelog says "On this tree the patch was only built, not
  run; rtl8169_poll() is the same here as in v7.2." That is wrong.
- [Low] r8169_init_napi() registers rtl8169_poll() for every device with
  irq_nvecs <= 1.

--

r8169: clear RxOverflow before unmasking interrupts

The patch clears RxOverflow in rtl8169_poll() once NAPI completes, just
before interrupts are re-enabled. Without this, the RTL8125B stays stopped
after it runs out of RX descriptors. That stall comes from 6994520a3328,
which removed RxOverflow from the interrupt sources.

> On this tree the patch was only built, not run; rtl8169_poll() is the
> same here as in v7.2.

[Severity: Low]

Is this statement accurate? In this tree, parts of rtl8169_poll() come
from the multi-queue rework:

36af5aac9545 ("r8169: prepare for multi irqs and napi")
5df447aee076 ("r8169: refactor RX path to prepare for multi-queue")

For example, rtl_rx() now takes a pointer to a single RX ring:

	/* rtl8169_poll() is used only when there is a single RX ring. */
	work_done = rtl_rx(dev, tp, &tp->rx_ring[0], budget, napi);

Also, rtl_ack_events() now has an irq_nvecs > 1 branch that writes
ISR_VEC_MAP_REG.

The single-vector path still writes IntrStatus_8125/IntrStatus as before,
so the logic looks functionally equivalent. However, the A/B results were
measured on different code than what is submitted.

With Cc: stable and Fixes: 6994520a3328, the context line above does not
exist in any stable tree, so each backport will need to be adapted by
hand.

Could the changelog say that the code that was tested differs from the
code submitted here?

> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index f151ab6813932..99b0a410f58e4 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -5670,8 +5670,14 @@ static int rtl8169_poll(struct napi_struct *napi, int budget)
>  	/* rtl8169_poll() is used only when there is a single RX ring. */
>  	work_done = rtl_rx(dev, tp, &tp->rx_ring[0], budget, napi);
>  
> -	if (work_done < budget && napi_complete_done(napi, work_done))
> +	if (work_done < budget && napi_complete_done(napi, work_done)) {

[Severity: High]

Should the RxOverflow ack depend on napi_complete_done() returning true?

napi_complete_done() returns false early while busy polling:

net/core/dev.c:napi_complete_done() {
	if (unlikely(n->state & (NAPIF_STATE_NPSVC |
				 NAPIF_STATE_IN_BUSY_POLL)))
		return false;
    ...
}

It also returns false while defer_hard_irqs_count > 0 and a
gro_flush_timeout is set.

With threaded busy-poll enabled on the NAPI instance, napi_threaded_poll()
keeps NAPI_STATE_IN_BUSY_POLL set while the kthread polls:

net/core/dev.c:napi_threaded_poll() {
    ...
		want_busy_poll = val & NAPIF_STATE_THREADED_BUSY_POLL;
		in_busy_poll = val & NAPIF_STATE_IN_BUSY_POLL;
    ...
		if (want_busy_poll != in_busy_poll)
			assign_bit(NAPI_STATE_IN_BUSY_POLL, &napi->state,
				   want_busy_poll);
    ...
}

In that mode, rtl8169_poll() is called in a loop and never reaches
rtl_ack_events(tp, RxOverflow) or rtl_irq_enable().

The first interrupt has already masked interrupts:

rtl8169_interrupt() {
    ...
	rtl_irq_disable(tp);
	napi_schedule(napi);
out:
	rtl_ack_events(tp, status);
    ...
}

So the interrupt handler, the only other code that acks status bits, does
not run again.

If the 256-entry ring overruns in this mode, does the RTL8125B latch
RxOverflow and stay stopped until busy-poll is turned off or the interface
is reset? Every incoming frame would be counted in rx_missed.

Socket busy polling (napi_busy_loop()), defer_hard_irqs/gro_flush_timeout
and irq-suspend look like they cause the same stall. In those cases it
only lasts until the busy-poll or deferral window ends.

The descriptors are already back with the NIC whenever rtl_rx() stops at
a NIC-owned descriptor (work_done < budget), whether or not NAPI completes.

Could the ack be tied to work_done < budget and moved out of the
napi_complete_done() condition?

> +		/* After running out of RX descriptors the chip does not
> +		 * receive again until RxOverflow is cleared. The ring is
> +		 * empty now, so clear it before unmasking.
> +		 */
> +		rtl_ack_events(tp, RxOverflow);

[Severity: Low]

This isn't a bug, but the comment presents this as general chip behavior.
The changelog only describes and tests RTL8125B.

r8169_init_napi() registers rtl8169_poll() for every single-vector device:

	} else {
		netif_napi_add(tp->dev, &tp->rtl8169_napi[0], rtl8169_poll);

get_max_irq_nvecs() only allows more than one vector for
RTL_GIGA_MAC_VER_80. So this extra IntrStatus write now happens on every
NAPI completion for RTL8169/8168/8101/8125/8126 as well.

6994520a3328 was tested on RTL8168h, on the premise that running out of
descriptors needs no special handling.

Could the changelog and the comment say whether this RxOverflow behavior
is specific to RTL8125B or also applies to older chips? Could they also
say that the change affects all chip generations but was tested only on
RTL8125B?

>  		rtl_irq_enable(tp);
> +	}
>  
>  	return work_done;
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261121073652.410916-1-jure.rebernik%40luxonis.com
