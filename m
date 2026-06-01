Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F993DCDA4;
	Mon,  1 Jun 2026 20:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780346594; cv=none; b=o91JN4H6FNvWr+C/YfoYHgKLZgdXnLGKXntAgwn2Ciu5BBi6j/3LZJ+U9rA7UDRpq4inn0G67agJomuE81HkCI+d4QmPXv37Fo03W2Qa0LEZGPxmGsxigTJajU+ewVI2r/5hIMrUH2GvoKjH8dtxsBkaKJvMhngPA+0/LjUkUBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780346594; c=relaxed/simple;
	bh=fOGSZLe6merD5rMvEEGhH7/QQJN7eja4hCCkHPCcY+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bT02rGWGcY9CGWnAd+TWIGuZZu0qbAD6BhnIQ7bNMHPJKTsbbY6++vav5U/Is0+qyWWgTpNf6iQCoQJmh5It2+qtHn9qrUCVPFEmMhVmV0b8cf4LOOroZqTU2YqM3viB5SBkwHtJlmlF3hMLxV5LS6fLiJXZn6xmve3GqsSBWW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXgPVvfs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXgPVvfs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B7D1F00893;
	Mon,  1 Jun 2026 20:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780346593;
	bh=+uw086cjFZdYmPMPQz8ZpiQh3kOo1lbXDBzkinb0UZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GXgPVvfsVXGA9rI4vI8Bf8Qgxsc7GKAT2k+osTb3bAsjRjBTn9ty9u9rv9gGaG2R/
	 NfJdYECPlPknmaPjewBW1EhrfhfWJn3o2A67PdrdIXYEwvWGEPbbEH+zouk2L1H6zu
	 1TSMG2FTmBY1DEApLI14bHpjdfKTAIdgxEeo/6j8Z9peQud/5hg0gPJetEfHmNj/zi
	 +AynVzF2BI2ICb8wTkjItoO5qjCRtudT8cbBlpRNRcJb0X3lPpCBi3sTYRJ+u5m8Xq
	 h3iYwFvhCgMI0pCmQi5vFCpPJgB8sPKhBi2+nock8O+oLQB4WOv3rwyBXQMY4JgW5s
	 Tbm1XVfOILP1Q==
Date: Mon, 1 Jun 2026 21:43:09 +0100
From: Simon Horman <horms@kernel.org>
To: Doruk Tan Ozturk <doruk@0sec.ai>
Cc: alex.aring@gmail.com, stefan@datenfreihafen.org,
	miquel.raynal@bootlin.com, aleksander.lobakin@intel.com,
	linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
	security@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] mac802154: llsec: add skb_cow_data() before
 in-place crypto
Message-ID: <20260601204309.GA3410996@horms.kernel.org>
References: <20260525161806.96158-1-doruk@0sec.ai>
 <20260526183726.56100-1-doruk@0sec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526183726.56100-1-doruk@0sec.ai>

On Tue, May 26, 2026 at 08:37:26PM +0200, Doruk Tan Ozturk wrote:
> llsec_do_encrypt_unauth(), llsec_do_encrypt_auth(),
> llsec_do_decrypt_unauth(), and llsec_do_decrypt_auth() all perform
> in-place cryptographic transformations on skb data.  They build a
> scatterlist with sg_init_one() pointing into the skb's linear data area
> and then pass the same scatterlist as both src and dst to the crypto API
> (e.g. crypto_skcipher_encrypt/decrypt, crypto_aead_encrypt/decrypt).
> 
> On the RX path, __ieee802154_rx_handle_packet() clones the received skb
> before handing it to each subscriber via ieee802154_subif_frame().  The
> cloned skb shares the same underlying data buffer via reference
> counting.  When llsec_do_decrypt() subsequently modifies this shared
> buffer in place, it corrupts data that other clones -- potentially
> belonging to other sockets or subsystems -- still reference.
> 
> On the TX path, similar data sharing can occur when an skb's head has
> been cloned (skb_cloned() returns true).
> 
> The fix is to call skb_cow_data() before performing any in-place crypto
> operation.  skb_cow_data() ensures that the skb's data area is not
> shared: if the skb head is cloned or the data spans multiple fragments,
> it copies the data into a private buffer that can be safely modified in
> place.  This is the same pattern used by:
> 
>   - ESP (net/ipv4/esp4.c, net/ipv6/esp6.c)
>   - MACsec (drivers/net/macsec.c)
>   - WireGuard (drivers/net/wireguard/receive.c)
>   - TIPC (net/tipc/crypto.c)
> 
> Without this guard, in-place crypto on shared skb data leads to:
>   - Silent data corruption of other skb clones
>   - Use-after-free when the crypto API scatterwalk writes through a
>     page that has already been freed by another clone's kfree_skb()
>   - Kernel crashes under concurrent 802.15.4 traffic with security
>     enabled (KASAN/KMSAN reports slab-use-after-free)
> 
> Found by 0sec (https://0sec.ai) using automated source analysis.
> 
> Fixes: 4c14a2fb5d14 ("mac802154: add llsec decryption method")
> Fixes: 03556e4d0dbb ("mac802154: add llsec encryption method")
> Cc: stable@vger.kernel.org
> Reported-by: Doruk Tan Ozturk <doruk@0sec.ai>
> Closes: https://lore.kernel.org/linux-wpan/20260525161806.96158-1-doruk@0sec.ai/
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
> ---
> v2:
>   - mark as net fix per Olek's review
>   - add Closes tag
>   - add Reviewed-by

FTR: An AI generated review of this patch is available on sashiko.dev.
I believe that review can be treated in the context of possible follow-up
and should not effect the progress of this patch.
