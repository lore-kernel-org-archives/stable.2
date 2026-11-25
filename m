Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795617995;
	b=Jrqh+GQrDkXHs62D2ae+dSHlC5JObW7srhlqGcbSTBk1g3g0TV2BVpMOuXeLp1cIjfct
	 XMSdgP01KVXjm3cdCyVwPBVdgl2X5FUogTZrZOOo4aw/w3LxRYSYrw6bUeYU6LfSsVEhM
	 SxIBKQJaBc+hhW7o+nLKkCevujDiw4xeyoQcd37pRM9nWqXxjUtYNhLKMVUh2+qilF6fq
	 lXSTzVKwUB3XI2V84voMzKxgi2xN2vo0qm5LhvRW9iPwdKLXN0gvDhxloTQCvvcMu28DV
	 JdNBqZRUtrAvGArRasU/B92j+vva7ajOWJ7Z+lu7ouCjc4R+HAuarEyFcLr/5sGOIGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795617995;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=zmYXp/SZeKmTso9e6sihph0kRU8kuuepp6e2FB+t/v0=;
	b=o3QIIiC9cFYjIU++OIdVp73mV0Q4IVPaMrv5/aPVHpjdI+INabpGc38py3wLK22OMCGB
	 Rqy1wBVliRmsazd9uiwhsR6teTEegTt+rOkomA0kG3N0v0GbBTvNg+XtavWV/JmKCgyQs
	 QheCF9FmhbEHsRGMUqbdxh7uTZKOrtQUUVMghDQo75BXAhuTZdvBFVWJ24AzFTd8DIqmV
	 IbouSwMYxeGhBn7TufyLFYzFZECsYkp6OIYK8RtWtChQ0xPPMgQqESszaMI6B9QvuWyKq
	 Ad+Wth5t+8bT9Au5lFkXt3Iw5NigANPfQQGUUaqBrjeHx6AEuWrb93P7N73JyheShEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QXvelYy0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6307C606A321;
	Wed, 25 Nov 2026 14:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QXvelYy0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FA951F000C0;
	Wed, 25 Nov 2026 14:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795617995;
	bh=zmYXp/SZeKmTso9e6sihph0kRU8kuuepp6e2FB+t/v0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QXvelYy07AdhitCCjm0BU67OI6FOBDg8O7roKUvJwcUmJ8W2Ee+8XHXxUppS+jvC4
	 mMbMN/33uvpHBRaZuhCN/Xv8As0JGeHCY2ERDdsdIowh8lEJXfTxzKItyx1Ndad6o1
	 TV4LiypcSJJw/qzoOhS7iqdyFru/IZPKZPTfXp6grDEIYcoxnFgY6jP/bGsNPzSiBW
	 Hj89zM4Ne6HDuuc1wSn8Et0WkWiay7TGBcZFNOxZzwg5xwKMV3chFFwh2rKtjq5PTE
	 XKlKPs0vgt8nwIciwMlf85YskgkKdeZfFZF2/Wh5obhBWb/fHOmIf1pomPdTYqPWEN
	 vKuoetiryLFkA==
Subject:
 Re: [PATCH net v4 2/5] net: wwan: iosm: validate the ADGH datagram length
From: netdev-bot+sashiko@kernel.org
To: fangxy@xiaopeng.com
Cc: loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com,
 netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 johannes@sipsolutions.net, maoyixie.tju@gmail.com, zhugl3@xiaopeng.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Wed, 25 Nov 2026 14:46:33 +0000
Message-ID: <179561799387.3135.10134611969059298688@kernel.org>
In-Reply-To: <20261121141850.73754-3-fangxy@xiaopeng.com>
References: <20261121141850.73754-3-fangxy@xiaopeng.com>
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

- [Low] In drivers/net/wwan/iosm/iosm_ipc_mux_codec.h, the kernel-doc for
  struct mux_adgh describes @length as "Length (in bytes) of the…

--

net: wwan: iosm: validate the ADGH datagram length

This adds a bounds check on the device-supplied adgh->length in
ipc_mux_dl_adgh_decode(). A datagram is now dropped if its length is not
greater than packet_offset or is larger than skb->len. Before this, an
underflowing payload length or a zero-length clone could be passed to the
network stack.

> diff --git a/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c b/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
> index 5c33171ca7012..65421f6b4c91e 100644
> --- a/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
> +++ b/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
> @@ -473,6 +473,15 @@ static void ipc_mux_dl_adgh_decode(struct iosm_mux *ipc_mux,
>  	if_id += ipc_mux->wwan_q_offset;
>  	adgh_len = le16_to_cpu(adgh->length);
>  
> +	/* The device supplied length bounds the datagram. It has to
> +	 * exceed packet_offset and fit into the received block.
> +	 */
> +	if (adgh_len <= packet_offset || adgh_len > skb->len) {
> +		dev_err(ipc_mux->dev, "invalid ADGH length %u, skb len %u",
> +			adgh_len, skb->len);
> +		return;
> +	}

[Severity: Low]
This isn't a bug, but the new check disagrees with the kernel-doc for
struct mux_adgh in iosm_ipc_mux_codec.h:

 * @length:		Length (in bytes) of the datagram header. This length
 *			shall include the header size. Min value: 0x10

dl_head_pad_len is only ever set to IPC_MEM_DL_ETH_OFFSET, in
iosm_ipc_mux.c:

	ipc_mux->session[if_id].dl_head_pad_len = IPC_MEM_DL_ETH_OFFSET;

So pad_len is 0 and packet_offset is sizeof(struct mux_adgh), which is
0x10. That means adgh_len == 0x10, the documented minimum, is rejected
here as invalid.

Dropping a header-only datagram looks correct, since a zero-length clone
reaching ipc_wwan_receive() is what this patch fixes. The issue is that
the header says 0x10 is valid while the decoder logs it with dev_err as
an invalid length.

Firmware that sends header-only ADGH blocks according to the documented
minimum would get one non-ratelimited dev_err per block on the RX path.

Should the kernel-doc be updated so the minimum requires a payload? Or
should header-only datagrams be dropped silently, or with a ratelimited
or lower-level message?

> +
>  	/* Pass the packet to the netif layer */
>  	rc = ipc_mux_net_receive(ipc_mux, if_id, wwan, packet_offset,
>  				 adgh->service_class, skb,

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261121141850.73754-1-fangxy%40xiaopeng.com
