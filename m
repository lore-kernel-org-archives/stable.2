Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEBA4AE13A;
	Fri, 25 Sep 2026 15:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790351448; cv=none; b=QJZcZnjSEn4bsuwEtwd6jfU2/JhbFOGvcIu++ZTNvdebaFs6TUrZTv2/kqZJ6w9chL2bHB+FlCQfPSsuZEipIMZuLOFRJ5YvGtXjPGLamoX4irM5NLJsCG89IiBtk8xir2a3HGWTDPyyiX9LZNNvocCUFSdgAT1Tymj7agzVry4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790351448; c=relaxed/simple;
	bh=uiYJw6GP2RWahh6Fv/9c5C9P83RGijexm9mhQVgfyzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rdML+3/1T4enc0PB5NMXpQK+H5jMTOJOS7vYIfkWpK8IRU+rfQmY60MGpEiRpiJLkJvcfVdnspWjzAqpF9Y/UC89yt1j4Xv1YWsjvOoTIzHCKJ8tZQzDCSgBi7GaYIhvpFl4IV/9qP3sDb7Y/leCEwy8G3YARuSeam476lPgMQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lWI6wYJ4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lWI6wYJ4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB0281F000FF;
	Fri, 25 Sep 2026 15:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790351444;
	bh=e56tkvOHVIQN62mcifM58McnqV1YO4jtccCjT2VAcdc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lWI6wYJ4OzLYOy5J+5JDB2g1RCkyfNPWTjTUA8XgxLT1S3zLCTTE1WDBSuw3lIxNF
	 QWpVgiQo7YGgiFogGqHZgb3Hn5QbguLF65HEhJsvghromzF5d7EbW936J/GEQsZZxC
	 0MaoLGmoHFufm08A/rjTrVJMh1bUPoXZdkLxywhKVl4voBXns1hHYKJ3qN6gCf9nsA
	 WW6EGKFZWaZfX8dKwbvMwgxnMMnINB3oAkIMo0+0N2vA65qEKCyBbAXT8m96YHY9/L
	 pK/bj7nqvFouQC3l4G8HNZjuayG+Dl/1WhvJXc+2hhFNpqWfxdRsuzlQZztKcykVAV
	 W0HdygahcFOGw==
Date: Fri, 25 Sep 2026 16:50:40 +0100
From: Simon Horman <horms@kernel.org>
To: Liu Chao <liuc63@xiaopeng.com>
Cc: netdev@vger.kernel.org, linux-nfc@lists.debian.org,
	sameo@linux.intel.com, krzysztof.kozlowski@linaro.org,
	simon.horman@coderberg.com, stable@vger.kernel.org
Subject: Re: [PATCH net] nfc: nci: reject unusable max payload limits
Message-ID: <20260925155040.GP13925@horms.kernel.org>
References: <20260919054931.2157758-1-liuc63@xiaopeng.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260919054931.2157758-1-liuc63@xiaopeng.com>

On Sat, Sep 19, 2026 at 01:49:31PM +0800, Liu Chao wrote:
> nci_core_conn_create_rsp_packet() copies the controller-supplied
> max_ctrl_pkt_payload_len into the new connection without any
> validation, and nci_hci_send_data() sizes its fragments from it.
> When the controller reports 0 or 1, the subtraction in the loop
> underflows (skb->len is unsigned), the "last packet" branch is
> always taken, and skb_put_data() runs past skb->end into
> skb_over_panic(). A limit of 2 still works: the first packet
> carries the two HCP header bytes, and every chained packet one
> payload byte.
> 
> Reject a zero limit at parse time, before the conn_info is
> allocated and published, so there is nothing to unwind. A
> zero-payload connection cannot carry any data anyway, and both
> in-tree creators start sending right after the connection comes
> up: st-nci sets up its HCI session, fdp downloads firmware
> through the generic data path.
> 
> A limit of 1 stays legal at the NCI layer, since
> nci_queue_tx_data_frags() can ship one-byte fragments over such
> a connection. Only HCI needs two bytes for the HCP header, so
> that check lives in nci_hci_send_data(), which snapshots the
> limit the same way nci_queue_tx_data_frags() does and returns
> -EPROTO below 2.
> 
> Fixes: 4aeee6871e8c ("NFC: nci: Add dynamic logical connections support")
> Fixes: 11f54f228643 ("NFC: nci: Add HCI over NCI protocol support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Liu Chao <liuc63@xiaopeng.com>
> Link: https://lore.kernel.org/netdev/20260918185458.2711284-1-liuc63@xiaopeng.com

Hi Liu,

I am wondering if this patch is intended as an alternative or supplement
to your patch at the link above.

If it is an alternative then I'd appreciate some clarification of how
the following point in the cover letter of the patch at the link above
is addressed:

  Reject the zero value in the fragmentation path rather than at the
  assignment sites.  nci_queue_tx_data_frags() is the only place that
  loops over the RF data path's conn_info, and nci_send_data() takes
  the non-fragmenting branch only for skb->len <= max_pkt_payload_len,
  which for a zero limit means empty skbs alone.  Validating on
  assignment would not be sufficient either, because
  nci_rf_disc_rsp_packet() allocates ndev->rf_conn_info with
  devm_kzalloc(), so max_pkt_payload_len is already zero before any
  notification arrives.

In particular the "not be sufficient" part.

And regardless, I have a concern, which is touched on in the AI-generated
review I passed on in my response to the patch at the link above.

My concern is that conn_info->max_pkt_payload_len is read by various
functions in the call chain leading to nci_queue_tx_data_frags(). But it
can change at any time, leading to possible inconsistencies.

I have not analysed what they are or if they manifest in bugs.
But I do wonder if a single snapshot of max_pkt_payload_len needs
to be taken and passed down the call-chain.

...
