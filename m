Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794876471;
	b=FkIbKIvePfdJx3Z7XNkzgIpP3MH+a/CBNkCn/6sqBad97b+yxoG1Sz7bx8VwCH9S1RV2
	 4+LR185p4R9zbr6PijKcHlFYoHjde7h4a/k+h8NDcN+CWwlXP2g6JtJAzoF0NWXfltJPT
	 PenBCuhNVetc/CcJoZoeSpo4rraFdGk8gmqomRCFSPozTaCImuL0wOzpuH5DrVF7LsJ7M
	 tCasJKhB24tq+DnHbiCckeLq+Em/MiIladUQH/IWOINC6tUo6+3mKlMQ/e1wZog9hBKXH
	 POUv9G47FET9FgsLh3mUolBkvrqPgO6lfWF8PvO93QScceY9U7LxQ35yyy1DREIZ8qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794876471;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=hhknR2CMqirxAtldjyoyIn+m0/i18Htb3W1llHXKCFs=;
	b=srt7VUsIjK4bPcm9kvRBsviYQ92+79XWdPWPZ7PwFrZa2h/vCiLp8JXMCc1ZZcxOooma
	 eA0cdgGgOzUnapfXbMcVHnEajjxR7bSc9rf3lHZpKM0IsLykmiC8uIWLldIZlqr0d6M2Z
	 EC0zQ11t6RxDoj99R234aGCYslvoB5v2BxNJroaToUoI8EIolr4xiRJCFkUjUBSpbF30R
	 5dSoJIn+8adZOQpOPD111SAy1vYMpU5dacbMV/DBssUgG1XfPXw6CsKR4HpuUZ57H4kkO
	 YKzEFZcvC0zEjPXM02IB3ElEoM8TYS6K7QgPGMqrsVUBLk0EvBwiUlZjLEG6J7LPqxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="k/6wsKm2";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3E7606A334;
	Tue, 17 Nov 2026 00:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k/6wsKm2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 925741F000C4;
	Tue, 17 Nov 2026 00:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794876471;
	bh=hhknR2CMqirxAtldjyoyIn+m0/i18Htb3W1llHXKCFs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=k/6wsKm2ZuO4BjO7ZKNRVv4OG9zUb3A2Q5SkqXFJIGvPwHceXlW/SK0A+I8VxOl0k
	 TOI4OEGT/bNREj2YWGI4qdvIkq7EdVAJbUurE0I2+Msk11YCuUUQ7xqA2o0eoMSHPz
	 x/25sF7rUF+bU+5W7hK6PUYQFIwFxMZstmzNxvG97efzeH0J48zcm+4niOxT53eL/2
	 iSjnZun+3v01AdTCG69cdc5Cxz4aLVPvKRrfcBh3ub43Jtsp/RubHxbR3Ya4LQ1Zh4
	 Xm95iWCdTNoepOI5Yj1X5RuxoKUBxeg7ZIOQB+UTlyOr5NqDucZGsJEGizj4ZGGepP
	 BEWsFoLD0lJIw==
Subject: Re: [PATCH net 3/6] i40e: avoid resetting BQL state when freeing
 temporary Tx rings in set_ringparam
From: netdev-bot+sashiko@kernel.org
To: anthony.l.nguyen@intel.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 luoxuanqiang@kylinos.cn, mheib@redhat.com, fballuch@redhat.com,
 aleksandr.loktionov@intel.com, richardcochran@gmail.com,
 saikrishnag@marvell.com, stable@vger.kernel.org, vadim.fedorenko@linux.dev,
 jacob.e.keller@intel.com, rafal.romanowski@intel.com
Date: Tue, 17 Nov 2026 00:47:50 +0000
Message-ID: <179487647012.3136.17665986611017849845@kernel.org>
In-Reply-To: <20261113004602.129864-4-anthony.l.nguyen@intel.com>
References: <20261113004602.129864-4-anthony.l.nguyen@intel.com>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message names the wrong function for the idiom it says
  it copies.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the same bug
  exists in the sibling ice driver and this series leaves it unfixed.

--

i40e: avoid resetting BQL state when freeing temporary Tx rings in set_ringparam

i40e_set_ringparam() builds temporary Tx rings as struct copies of the
live rings, so the copies share netdev and queue_index with them. When an
error path frees these copies before i40e_down(), the BQL state of the
live queue gets reset. That can trip the BUG_ON in dql_completed(). The
patch clears netdev on each copy before i40e_free_tx_resources() in both
error paths, so i40e_clean_tx_ring() skips netdev_tx_reset_queue().

> This mirrors the
> same idiom i40e already uses for XDP Tx rings, which also have no
> netdev_queue of their own (ring->netdev = NULL in i40e_vsi_setup_tx()).

[Severity: Low]
This isn't a bug, but is i40e_vsi_setup_tx() the right function name
here? There's no function with that name in the i40e driver.
i40e_vsi_setup_tx_resources() is the closest match, and it doesn't touch
ring->netdev.

The XDP Tx ring assignment appears to be in i40e_alloc_rings() in
i40e_main.c:

		if (!i40e_enabled_xdp_vsi(vsi))
			goto setup_rx;

		ring->queue_index = vsi->alloc_queue_pairs + i;
		...
		ring->netdev = NULL;
		...
		set_ring_xdp(ring);

Could the commit message point to i40e_alloc_rings() instead?

> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> index ef756487d6684..58d842d676422 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c

[ ... ]

> @@ -2248,8 +2250,11 @@ static int i40e_set_ringparam(struct net_device *netdev,
>  	/* error cleanup if the Rx allocations failed after getting Tx */
>  	if (tx_rings) {
>  		for (i = 0; i < tx_alloc_queue_pairs; i++) {
> -			if (i40e_active_tx_ring_index(vsi, i))
> +			if (i40e_active_tx_ring_index(vsi, i)) {
> +				/* not live yet, skip its BQL reset on free */
> +				tx_rings[i].netdev = NULL;
>  				i40e_free_tx_resources(&tx_rings[i]);
> +			}
>  		}
>  		kfree(tx_rings);
>  		tx_rings = NULL;

[Severity: High]
This is a pre-existing issue, not one introduced by this patch. Does the
sibling ice driver have the same problem in ice_set_ringparam() in
drivers/net/ethernet/intel/ice/ice_ethtool.c?

There, each temporary Tx ring is also a struct copy of the live ring, so
it keeps the live netdev and q_index:

	ice_for_each_txq(vsi, i) {
		/* clone ring and setup updated count */
		tx_rings[i] = *vsi->tx_rings[i];
		tx_rings[i].count = new_tx_cnt;
		tx_rings[i].desc = NULL;
		tx_rings[i].tx_buf = NULL;
		...
		err = ice_setup_tx_ring(&tx_rings[i]);
		if (err) {
			while (i--)
				ice_clean_tx_ring(&tx_rings[i]);
			kfree(tx_rings);
			goto done;
		}

The free_xdp/free_tx labels are reached when the XDP ring setup, the Rx
kzalloc or ice_setup_rx_ring() fails. They also clean the copies before
ice_down() has run:

	/* error cleanup if the Rx allocations failed after getting Tx */
	if (tx_rings) {
		ice_for_each_txq(vsi, i)
			ice_free_tx_ring(&tx_rings[i]);
		kfree(tx_rings);
	}

ice_free_tx_ring() calls ice_clean_tx_ring() in ice_txrx.c. That function
only skips the BQL reset when netdev is NULL:

	if (!tx_ring->netdev)
		return;

	/* cleanup Tx queue statistics */
	netdev_tx_reset_queue(txring_txq(tx_ring));

txring_txq() resolves to netdev_get_tx_queue(ring->netdev, ring->q_index).
For a copy, that is the live netdev_queue.

Consider ethtool -G on a running ice interface, under memory pressure,
with Tx traffic in flight. If one of those allocations fails, can the next
netdev_tx_completed_queue() from ice_clean_tx_irq() hit this check in
dql_completed()?

	BUG_ON(count > num_queued - dql->num_completed);

That would be the same panic the commit message describes for i40e.
Nothing in this series touches drivers/net/ethernet/intel/ice/.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261113004602.129864-1-anthony.l.nguyen%40intel.com
