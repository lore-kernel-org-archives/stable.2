Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602494DA52D;
	Thu, 23 Jul 2026 14:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784818283; cv=none; b=sPe9sx/bvGQg6Mtb9xnS4viAAcFWmb/IU8RAsXPXAV5L2ngi+kA2CKV8YZOqB7h/rkJ+AZ42ipLwCWV5T6u+rh0GW5xVVZx0m6MKuzEEdQpBPti/EMCTX3mHCzze26OpouBn60C2Vve6By/VFDapDchs9t1BV5FSqp52XzNmhU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784818283; c=relaxed/simple;
	bh=bo0psonNraxj8x0yWejSWZqg9Lnrd8p57oiXrPHZtn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bWLC6J5dUM63opSsleZBKbDr7gvCpLtnfJhlDI9uWusFo4XykoQerY0Rb2/VvyxhKQ3LC9KK+F3y5muqh8dtUXqptFaOl+Xtg/wm6nZcja8KJhswZZsz0H3gb9LKCB/pQ9/X1FS97DebwSPpMJTF7IYyak9xGY2el+/eJBzAdK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=y5qrVIWY; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="y5qrVIWY"
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id CBA411FCC4;
	Thu, 23 Jul 2026 16:51:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1784818276;
	bh=L81t0RxognekUv+isDAzjLN9J7y7BlKmipXl6TxVhJM=; h=From:To:Subject;
	b=y5qrVIWYSWKlP7XRksHKIpGCxu3KiUu04Ou/KLAbywuJgT8P+rlYmG+XptXHyIvvD
	 udvT9QyKkgV3aW8f+MENKwFaCAVeICzEGul4XkmgMhgY6BNd6C8tVbFIuDg5XrrGF9
	 HyyFNNf5paORonquhN19DOwiXD2ulQicGDAp0nMKwS0H2Ftw4Law1fzVc8bIsn9tBy
	 O3mOhd1YKdF9NkV9gFduCGInQ0wn55C1TeS0v4V84FitaVYICXBnIGah6eOBGxIcyR
	 7Tc0kvf4x36HT35usbwC0zAnaUp5cZsSF46qHfoYix1tR72/GDq1vKkcmef7ORK/Oh
	 BocZDZhxrGAlw==
Date: Thu, 23 Jul 2026 16:51:11 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Doruk Tan Ozturk <doruk@0sec.ai>
Cc: briannorris@chromium.org, francesco@dolcini.it, kees@kernel.org,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] wifi: mwifiex: validate HT/VHT capability and
 operation IE lengths
Message-ID: <20260723145111.GA236955@francesco-nb>
References: <20260709100800.7026-1-doruk@0sec.ai>
 <20260715185543.14478-1-doruk@0sec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715185543.14478-1-doruk@0sec.ai>

On Wed, Jul 15, 2026 at 08:55:43PM +0200, Doruk Tan Ozturk wrote:
> mwifiex_update_bss_desc_with_ie() records raw pointers to the HT
> Capabilities, HT Operation, VHT Capabilities, VHT Operation, 20/40 BSS
> Coexistence and Operating Mode Notification elements taken straight out
> of a beacon/probe-response buffer, without checking that each element is
> long enough for the fixed-size structure that later consumers read. The
> buffer is a tight kmemdup() of the on-air IEs (beacon_buf_size ==
> ies->len), so a truncated element placed last leaves the stored pointer
> one past the end of the allocation.
> 
> At association time these pointers are dereferenced at fixed offsets
> regardless of the on-air length: mwifiex_cmd_append_11n_tlv() memcpy()s
> sizeof(struct ieee80211_ht_cap) (26 bytes) from bcn_ht_cap and reads
> bcn_ht_oper->ht_param, and mwifiex_cmd_append_11ac_tlv() memcpy()s
> sizeof(struct ieee80211_vht_cap) (12 bytes) from bcn_vht_cap and reads
> bcn_vht_oper->chan_width. A nearby AP (rogue / evil-twin; an open SSID
> needs no credentials) advertising a BSS with a truncated HT/VHT cap
> element therefore triggers a slab out-of-bounds read on the victim's
> association attempt. This out-of-bounds read is the primary issue.
> 
> For the HT-Cap copy the over-read bytes are additionally placed into the
> outgoing association request, so a limited amount of adjacent heap memory
> can leak over the air. In station mode this is small (single-digit
> bytes), because mwifiex_fill_cap_info() rewrites most of the copied
> HT-Cap before transmission; the leak is a secondary effect.
> 
> mwifiex_set_sta_ht_cap() has the same missing-length pattern: in uAP mode
> it reads two bytes of ieee80211_ht_cap.cap_info from a
> cfg80211_find_ie(WLAN_EID_HT_CAPABILITY) result in a client association
> request without checking the element length, a 1-2 byte out-of-bounds
> read (used only to select an A-MSDU size, not leaked).
> 
> Reject the frame with -EINVAL when any of these elements is shorter than
> the structure the driver later reads, matching the length validation the
> FH/DS/CF/IBSS parameter-set cases in the same beacon parser already
> perform. mwifiex_set_sta_ht_cap() returns void, so there the too-short
> element is skipped instead.
> 
> Found by 0sec automated security-research tooling (https://0sec.ai).
> 
> Fixes: 5e6e3a92b9a4 ("wireless: mwifiex: initial commit for Marvell mwifiex driver")
> Cc: stable@vger.kernel.org
> Assisted-by: 0sec:multi-model
> Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
> ---
...

> diff --git a/drivers/net/wireless/marvell/mwifiex/util.c b/drivers/net/wireless/marvell/mwifiex/util.c
> index 7d3631d21223..844223c04e2e 100644
> --- a/drivers/net/wireless/marvell/mwifiex/util.c
> +++ b/drivers/net/wireless/marvell/mwifiex/util.c
> @@ -721,7 +721,7 @@ mwifiex_set_sta_ht_cap(struct mwifiex_private *priv, const u8 *ies,
>  
>  	ht_cap_ie = (void *)cfg80211_find_ie(WLAN_EID_HT_CAPABILITY, ies,
>  					     ies_len);
> -	if (ht_cap_ie) {
> +	if (ht_cap_ie && ht_cap_ie->len >= sizeof(struct ieee80211_ht_cap)) {
>  		ht_cap = (void *)(ht_cap_ie + 1);
>  		node->is_11n_enabled = 1;
>  		node->max_amsdu = le16_to_cpu(ht_cap->cap_info) &

Can we trust ht_cap_ie->len here? Who is writing this field?

Francesco

