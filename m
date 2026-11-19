Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795087456;
	b=Pd7+fV/LpZdHwiDYwVQpsFPxj4Dopz/nM3nkYP2NZcGmWUWfOc5u+ANb6T03WJh0CDXd
	 sKEOY+9HoZaVHmIqBzE96KAktR+4jqYpul3cr+RKBckv/lpfB42FUhMqiSYxLNZZnPb3k
	 xAWO2okHXHQlA/aTlGrwrYfL1PLMH4pHG3kts5jebPzDBsumRjDebIuPIpg9U/l1kIka8
	 +60OwKRBtU/O0fvny8WjjphfCE2NZlyQvD79GMMIJz4yiEjJJPziCVnlqwHrdJhxVSfYh
	 n6hSpTsbDIdS3s55Ju5PxjG9vVEjTQKrfZDuhlAR40h6pT7ryHpAnIaDV5lATK22e+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795087456;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=PAbCKhxpRkBffJWgsRtKYvAYQkiZqg3MoFHOfafjj7I=;
	b=mP7VnehN6+a5Qtxel0q+efgxHWtZESxmyUZWWZJ0zo+y4Tek4a4Bv1Z4FKxuTk8yC2ZI
	 GLJpgY9rgybE6hjgtXVx6hVqr7NzI3eTYlYPvWQdoV8uRvrdlXQk7PbDKre8ndj2Zq5Pb
	 Q0EVttlzuhWMEGaRMFk0LZDGZ+QBoi48KCKC74ifLbwyOhnC3Uc1EyGT9wpB2n37pQTjr
	 Ahga01hqBgHzSguswVWDdkLwkXvyUCRhOlPrpcB1mDT9/oHtpPBB2aCDhONGvkVIS22GU
	 uQp6SvqvaxdY7LTspQyqW97CwsI1bFbnXvTden/XGsVqPNT6YHoOGZkTNtk1KugsaBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PQlFHyVn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0773606A326;
	Thu, 19 Nov 2026 11:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PQlFHyVn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DE071F000C5;
	Thu, 19 Nov 2026 11:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795087455;
	bh=PAbCKhxpRkBffJWgsRtKYvAYQkiZqg3MoFHOfafjj7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PQlFHyVnL719LmbhVpx+mjI6xRk6OVIKiMmHw+GvFflDKHLBFnA6zci52jYLuOSzo
	 NR3pt0KAtun2FasVaOmNk9Goes6SYI/S3z11jEp131dN9pfVEj5G6+70AFwJR7/rC0
	 xL+MxScusFNHVhNp84bPq1FIcloF1DPuHrolJw79YJMHRPNGNaWC7gV8bzMu0qF8q4
	 4riiillfyhA9JZ9Pibu2KHH8MKff+15mr+Hon6kkW0dtC0Fi2F5pFh6Rrep+KlMk+R
	 FInoyKoua3H2uw37uIiL4n5VHQztII/f66agXZ4ex/FSw1XwrzW5MoF874KGpt85P/
	 +RrDtrl55zTDQ==
Date: Thu, 19 Nov 2026 11:24:09 +0000
From: Simon Horman <horms@kernel.org>
To: Vincent Choiniere <choiniere.vincent@hydroquebec.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v4] ice: fix Tx hang dump using stale tx_buf[0].skb
Message-ID: <20261119112409.GU860048@horms.kernel.org>
References: <20261112-ice-tx-hang-dump-v4-1-9125f687669b@hydroquebec.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112-ice-tx-hang-dump-v4-1-9125f687669b@hydroquebec.com>

On Thu, Nov 12, 2026 at 01:45:56PM -0500, Vincent Choiniere wrote:

...

> @@ -424,6 +429,78 @@ void ice_prep_tx_hang_report(struct ice_pf *pf, struct ice_tx_ring *tx_ring,
>  	buf->vsi_num = vsi_num;
>  	buf->head = head;
>  	buf->intr = intr;
> +	buf->queue = tx_ring->q_index;
> +	buf->next_to_clean = tx_ring->next_to_clean;
> +	buf->next_to_use = tx_ring->next_to_use;
> +}
> +
> +/**
> + * ice_tx_hang_snapshot - copy the timed-out queue's ring at report time
> + * @pf: PF on which the Tx hang was detected
> + * @tx_ring: ring saved by ice_tx_timeout(), possibly stale
> + * @ev: event to fill in
> + *
> + * The saved ring may have been freed or replaced since the timeout (e.g. by
> + * ethtool -G or -L), and a freed ring may be reused for another queue. Use it
> + * only if the timeout was on the PF VSI, that VSI is up and the timed-out
> + * queue still maps to it. Those paths, and the reset paths, replace or free
> + * the rings under RTNL or from the service task itself, so with RTNL held the
> + * accesses below are to live memory for them. The ring may still have been
> + * reset in place since the timeout (e.g. by ethtool -G or an MTU change); as
> + * before, its state is read when the report is generated. Driver removal and
> + * devlink reload tear the VSIs down before the service task is stopped and are
> + * not covered here. ice_clean_tx_irq() may still run and free the skb at
> + * next_to_clean at any time, so only the pointer value is recorded and the skb
> + * itself is never dereferenced.
> + */
> +static void ice_tx_hang_snapshot(struct ice_pf *pf, struct ice_tx_ring *tx_ring,
> +				 struct ice_tx_hang_event *ev)
> +{
> +	struct ice_vsi *vsi = ice_get_main_vsi(pf);
> +	struct ice_q_vector *q_vector;
> +	struct ice_tx_buf *tx_buf;
> +	u16 ntc, ntu;
> +	void *desc;
> +	u32 size;
> +
> +	ASSERT_RTNL();
> +
> +	if (!tx_ring || !vsi || !vsi->tx_rings ||
> +	    test_bit(ICE_VSI_DOWN, vsi->state))
> +		return;
> +
> +	if (ev->vsi_num != vsi->vsi_num || ev->queue >= vsi->num_txq ||
> +	    vsi->tx_rings[ev->queue] != tx_ring)
> +		return;
> +
> +	q_vector = tx_ring->q_vector;
> +	if (!q_vector || !tx_ring->desc || !tx_ring->tx_buf || !tx_ring->count)
> +		return;
> +
> +	size = tx_ring->count * sizeof(struct ice_tx_desc);
> +	desc = kvmalloc(size, GFP_KERNEL);
> +	if (!desc)
> +		return;
> +
> +	ntc = READ_ONCE(tx_ring->next_to_clean);
> +	ntu = READ_ONCE(tx_ring->next_to_use);
> +
> +	if (ntc < tx_ring->count) {

Sorry to nit-pick, but I wonder if it would be nicer to move the kvmalloc()
call and associated error checking be moved here...

> +		tx_buf = &tx_ring->tx_buf[ntc];
> +		if (tx_buf->type == ICE_TX_BUF_SKB)
> +			ev->skb_ptr = READ_ONCE(tx_buf->skb);
> +
> +		memcpy(desc, tx_ring->desc, size);
> +		ev->next_to_clean = ntc;
> +		ev->next_to_use = ntu;
> +		strscpy(ev->irq_name, q_vector->name);
> +		ev->desc_ptr = tx_ring->desc;
> +		ev->dma = tx_ring->dma;
> +		ev->desc_size = size;
> +		ev->desc = desc;
> +	} else {
> +		kvfree(desc);

... and remove the else arm of the condition.

> +	}
>  }

And further, the sense of the condition could be reversed, saving some
indentation:

	if (ntc >= tx_ring->count)
		return

	desc = kvmalloc(size, GFP_KERNEL);
	if (!desc)
		return;

	tx_buf = &tx_ring->tx_buf[ntc];
	if (tx_buf->type == ICE_TX_BUF_SKB)
		ev->skb_ptr = READ_ONCE(tx_buf->skb);

	memcpy(desc, tx_ring->desc, size);
	ev->next_to_clean = ntc;
	ev->next_to_use = ntu;
	strscpy(ev->irq_name, q_vector->name);
	ev->desc_ptr = tx_ring->desc;
	ev->dma = tx_ring->dma;
	ev->desc_size = size;
	ev->desc = desc;

Regardless, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

