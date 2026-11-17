Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794876470;
	b=asjg8Pdz0ubWBpd1Fx+CqNa74o0mrEs5LCF2VNq3x3j3zZZZPkE4jsOq5wOW61Jktodv
	 8m7O+yftqcLGkH/Rj29FtLJY3Q1bmdBdnk5gGK6Awd10D/RylJE7nrlxo1F8WJn6LNBRb
	 r7iUvdV46dU3P77+NFPg0SYzUcc4tAIYB59xoMesiDyScRdE7K/VTdO4nhqZA0AVbjeuW
	 xm34peNsYxOL+b6zN0tSJQXlobA3X7T6yStNmZFXuaB8eHrrhpq8+vsiaXpNvk1rSmHth
	 SKxfgx9Ijxf/WxZ5rD40KXAoEU9iSLY/Ml9/H5ygi24iXg12F4AR1BUFApfIu3H8hTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794876470;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=E1Vdr8L834LnwapaFjKfnPdDs1qFqrw3OV9z5nj6l34=;
	b=K02+vn0pBkcpljZpP5EcC6KIUDBZv4QAy9Hvkk7CyYlw12AMnoDSmGGL5b7p+w2F26kB
	 LBvW7Swpjwk8DDUI/tjueTclRzl5QNSUCvQ2WCzY68+552ywwbvqeE2x+jXxBv/y6KEGO
	 CxyVKGd5WVRwIwM/LU0cAoMNKeurxlITIGHQrYz2+FLI6Fn3alV9SCzoKcfhJs9Dy7WM7
	 7B8VH/bAz2RBl6gbc4pWsd4DygcOiqq0/v0ZTjOplTnJB3AUal5VWO65IJcQ2WTHvlNYP
	 z8HhNOpYfLsPyl1V6H8Fe6IzHXovDVg17sYP+W/+x2kWeEznBcJAgSwECb0AfxvswNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UlPws3m3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8B7606A31C;
	Tue, 17 Nov 2026 00:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UlPws3m3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D70C1F000C4;
	Tue, 17 Nov 2026 00:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794876469;
	bh=E1Vdr8L834LnwapaFjKfnPdDs1qFqrw3OV9z5nj6l34=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UlPws3m35X2LNi1fP7ibSAxJZBpEgNQzXP++s7KzKXZ5UDBRHTX7IUJy3PsbGzBcT
	 T8rjRFn23y5gqfSiJUYSEbcbK9L0LmzHV5h2eW9krxchndN+2KLiqcHaIaUXZwpV71
	 J+r64Sryj9J+IYqBCoUK0/EQDEniYdLdnwpb0HDTRPsOgNg7OfnPoo2xqQzt2MCILP
	 g20mK4wcMVWpO2jPWoyJN29nWSwb+2p8Gxc3rJRwBNW3xxYbFkhlQIU5yM2gpgA6UK
	 rr7tQh0KESSdYocjgwQwI8hp47mGQ6hwY7AiGu1M9kMANtVzaLIPu4A8D0eaFcgBiN
	 Y6tx5GOXq5DWg==
Subject: Re: [PATCH net 1/6] i40e: fix napi_disable hang in i40e_down() during
 firmware update
From: netdev-bot+sashiko@kernel.org
To: anthony.l.nguyen@intel.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 luoxuanqiang@kylinos.cn, mheib@redhat.com, fballuch@redhat.com,
 aleksandr.loktionov@intel.com, richardcochran@gmail.com,
 saikrishnag@marvell.com, stable@vger.kernel.org, vadim.fedorenko@linux.dev,
 jacob.e.keller@intel.com, rafal.romanowski@intel.com
Date: Tue, 17 Nov 2026 00:47:48 +0000
Message-ID: <179487646854.3136.3461897028756425738@kernel.org>
In-Reply-To: <20261113004602.129864-2-anthony.l.nguyen@intel.com>
References: <20261113004602.129864-2-anthony.l.nguyen@intel.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 2 (1) · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete and the commit message gets the root cause
  wrong.
- [High] The patch adds an unconditional set_bit(__I40E_VSI_DOWN) in
  i40e_vsi_reinit_locked() and still ignores the return value of…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but
  i40e_vsi_reinit_locked() calls i40e_down() unconditionally, even when…

--

i40e: fix napi_disable hang in i40e_down() during firmware update

This patch sets __I40E_VSI_DOWN in i40e_vsi_reinit_locked() before it
calls i40e_down(). With the bit set, i40e_napi_poll() bails out and
napi_disable() can complete when the rings hold garbage during an NVM
update.

> i40e_down() expects its caller to set __I40E_VSI_DOWN before calling it,
> as noted in the comment at the top of the function. All callers do this
> except i40e_vsi_reinit_locked(), which calls i40e_down() directly
> without setting the flag.

[Severity: High]
Is this accurate? i40e_set_ringparam() in i40e_ethtool.c (the ethtool -G
path) also appears to call i40e_down() on a running interface without
setting the bit:

drivers/net/ethernet/intel/i40e/i40e_ethtool.c:i40e_set_ringparam() {
    ...
	/* Bring interface down, copy in the new ring info,
	 * then restore the interface
	 */
	i40e_down(vsi);
    ...
}

By then i40e_up_complete() has already cleared __I40E_VSI_DOWN, so this
bail-out in i40e_napi_poll() never fires:

	if (test_bit(__I40E_VSI_DOWN, vsi->state)) {
		napi_complete(napi);
		return 0;
	}

If the descriptors hold garbage, can this chain hang in the same way
while holding RTNL?

i40e_set_ringparam()->i40e_down()->i40e_napi_disable_all()->napi_disable()

The other callers already seem to set the bit:

  - i40e_vsi_close()
  - the DOWN_REQUESTED branch of i40e_do_reset()
  - i40e_set_loopback()
  - the err_up_complete path of i40e_vsi_open()

Two later patches in this series modify i40e_set_ringparam() but don't
add the set_bit():

  - "i40e: fix freeing of TX rings on RX allocation failure"
  - "i40e: avoid resetting BQL state when freeing temporary Tx rings in
    set_ringparam"

Should i40e_set_ringparam() also call set_bit(__I40E_VSI_DOWN, vsi->state)
before i40e_down()? The later i40e_up()->i40e_up_complete() would clear it
again.

> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index abbc71e815ae3..dd729776c64dd 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -7461,6 +7461,8 @@ static void i40e_vsi_reinit_locked(struct i40e_vsi *vsi)
>  
>  	while (test_and_set_bit(__I40E_CONFIG_BUSY, pf->state))
>  		usleep_range(1000, 2000);
> +	/* required by i40e_down() */
> +	set_bit(__I40E_VSI_DOWN, vsi->state);
>  	i40e_down(vsi);

[Severity: High]
This is a pre-existing issue, but i40e_vsi_reinit_locked() calls
i40e_down() unconditionally. That includes the case where the VSI is
already down but the netdev is still netif_running(). Can napi_disable()
then run a second time on NAPI instances that are already disabled?

The first napi_disable_locked() leaves NAPIF_STATE_SCHED and
NAPIF_STATE_NPSVC set, and only napi_enable() clears them. A second call
would spin here forever:

net/core/dev.c:napi_disable_locked() {
    ...
	do {
		while (val & (NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC)) {
			usleep_range(20, 200);
			val = READ_ONCE(n->state);
		}
    ...
}

It would do so while holding netdev_lock, and also RTNL in the MTU path.

One way to get here is a tx_timeout that escalates past level 3:

i40e_tx_timeout()
    default:
        set_bit(__I40E_DOWN_REQUESTED, pf->state);
        set_bit(__I40E_VSI_DOWN_REQUESTED, vsi->state);

i40e_reset_subtask()
  i40e_do_reset()
    set_bit(__I40E_VSI_DOWN, vsi->state);
    i40e_down(vsi);           <- NAPI disabled, netdev still running

ip link set mtu ...
  i40e_change_mtu()
    if (netif_running(netdev))
        i40e_vsi_reinit_locked(vsi);
          i40e_down(vsi);     <- second napi_disable()

A failed i40e_up() inside i40e_vsi_reinit_locked() also leaves NAPI
disabled, so the next MTU change would hit the same loop.

The new set_bit() has no effect in either case. i40e_vsi_close() and
i40e_set_loopback() use this pattern to avoid a second teardown:

	if (!test_and_set_bit(__I40E_VSI_DOWN, vsi->state))
		i40e_down(vsi);

Would that pattern work here as well? It should also prevent the hang
this patch targets.

>  
>  	i40e_up(vsi);

[Severity: High]
What happens to the new __I40E_VSI_DOWN bit if i40e_up() fails here, for
example via i40e_change_mtu()->i40e_vsi_reinit_locked()? The return value
is ignored. i40e_up_complete() clears the bit only after the rings have
started:

drivers/net/ethernet/intel/i40e/i40e_main.c:i40e_up_complete() {
    ...
	/* start rings */
	err = i40e_vsi_start_rings(vsi);
	if (err)
		return err;

	clear_bit(__I40E_VSI_DOWN, vsi->state);
	i40e_napi_enable_all(vsi);
    ...
}

So the commit message's "i40e_up_complete() already clears the flag when
the VSI comes back up, so no additional cleanup is needed" seems to hold
only when bring-up succeeds.

i40e_vsi_start_rings() enables Rx before Tx. On -ETIMEDOUT it returns
without disabling the queues it already enabled.

If the Tx enable times out, every Rx queue could be live. Their
descriptors were already filled by i40e_vsi_configure_rx(). Meanwhile
__I40E_VSI_DOWN stays set and the netdev is still IFF_UP.

A later ndo_stop would then do:

i40e_vsi_close()
    if (!test_and_set_bit(__I40E_VSI_DOWN, vsi->state))
        i40e_down(vsi);     <- skipped, i40e_vsi_stop_rings() never runs
    i40e_vsi_free_irq(vsi);
    i40e_vsi_free_tx_resources(vsi);
    i40e_vsi_free_rx_resources(vsi);

Can i40e_free_rx_resources() then unmap the Rx pages and
dma_free_coherent() the descriptor ring while the hardware Rx queue is
still enabled and can DMA into that memory?

The stale bit also makes i40e_quiesce_vsi() return early without setting
__I40E_VSI_NEEDS_RESTART. A later PF reset, which is common after an NVM
update, would then not reopen the VSI, even though the netdev reports
IFF_UP.

Before this patch, the same failure led to a double napi_disable() hang
on close. i40e_down() still ran, so the rings were stopped first.

i40e_vsi_open() handles the same i40e_up_complete() failure with:

err_up_complete:
	i40e_down(vsi);

Should i40e_vsi_reinit_locked() check the return value of i40e_up() and
clean up in a similar way?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261113004602.129864-1-anthony.l.nguyen%40intel.com
