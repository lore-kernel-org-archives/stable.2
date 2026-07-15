Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933D3382394;
	Wed, 15 Jul 2026 14:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784126427; cv=none; b=XHgPXT5X5Xco01xagYMmX6x/F78vgHsGSjY8aPL8cFCsOgmUGUJF9LGdl8l9ACXdDDQTgbFDuP1mDAd6fpnK17/LYddMzVzsHmLQo4bdde10D2mPSkFbKgjz9/GDzTfVaEdPAuK0fPIx0RzaJEt0VeGKzmaeLuLEEVDhsB96KjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784126427; c=relaxed/simple;
	bh=6L7zLNyw2pE8kNF4I0hoWQiKZ0Ntlnm6L7nqYM5hsEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ar3OSRXux073hq1ZA/Pp/NXP8RBrTMnkhMwpE/pnCq+6bLW/gBwwWLfWakc0igbvMBEDJSopzLcm8Lf2MDH8RNnh1FDUUHsNV5Y+owf2apYit1swVdk4UV3PhAuYlPNtiK417SgZMHIDyGl8CNLOYKwyeWY890lT34zUVvXXrXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=H5k+RAGq; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="H5k+RAGq"
Received: from francesco-nb (xcpe-178-82-120-96.dyn.res.sunrise.net [178.82.120.96])
	by mail11.truemail.it (Postfix) with ESMTPA id 348251F8BF;
	Wed, 15 Jul 2026 16:40:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1784126423;
	bh=3HBqysY8L8H+pbooKAQH34sou14Vctg8Aps0cc9+WE8=; h=From:To:Subject;
	b=H5k+RAGqTClAGMuO13DgtB1rxjdvIXtEK3HngP/rbUAVtNmvWGasOOs3MOfkmgb4a
	 l2LaBCUXt3gOAfQApmABL3PG4I3SloYiH1teg/ZewAVB4bnvSePZAcRNtLUEiH5eQo
	 4bbAiV1GrKA0pTsniS62KQekfqCDw28izP8WX/zm35X4Vq9zl6yVAJ2dMnigoBwVfq
	 VHUI46pqNoPiqFqm/GklnNKU5nXGcVTl7vS42uVC9Wd0Pbrh2ZMr9lyhWJ/9mp0gIs
	 JruB3UtpFFu5WNv06j6W4aeTa73tQJ5NK5fWhw8zY/dXmNatEQFzFBIO4h50XXQEuV
	 AwGjP1gxUzHbQ==
Date: Wed, 15 Jul 2026 16:40:21 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Doruk Tan Ozturk <doruk@0sec.ai>
Cc: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Kees Cook <kees@kernel.org>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] wifi: mwifiex: validate HT/VHT capability and operation
 IE lengths
Message-ID: <20260715144021.GE56330@francesco-nb>
References: <20260709100800.7026-1-doruk@0sec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709100800.7026-1-doruk@0sec.ai>

On Thu, Jul 09, 2026 at 12:08:00PM +0200, Doruk Tan Ozturk wrote:
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
> Reject (skip) any of these elements whose payload is shorter than the
> structure the driver later reads, matching the length validation the
> FH/DS/CF/IBSS parameter-set cases in the same beacon parser already
> perform.
> 
> No dynamic reproducer: mwifiex is a fullmac driver for Marvell hardware
> with no mac80211_hwsim equivalent, so this was confirmed by source and
> structure-offset analysis only.

Were you able to test that this is not breaking the driver functionality?

> 
> Found by 0sec automated security-research tooling (https://0sec.ai).
> 
> Fixes: 5e6e3a92b9a4 ("wireless: mwifiex: initial commit for Marvell mwifiex driver")
> Cc: stable@vger.kernel.org
> Assisted-by: 0sec:claude-opus-4-8
> Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
> ---
>  drivers/net/wireless/marvell/mwifiex/scan.c | 12 ++++++++++++
>  drivers/net/wireless/marvell/mwifiex/util.c |  2 +-
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/marvell/mwifiex/scan.c b/drivers/net/wireless/marvell/mwifiex/scan.c
> index 97c0ec3b822e..997e7e19525b 100644
> --- a/drivers/net/wireless/marvell/mwifiex/scan.c
> +++ b/drivers/net/wireless/marvell/mwifiex/scan.c
> @@ -1384,6 +1384,8 @@ int mwifiex_update_bss_desc_with_ie(struct mwifiex_adapter *adapter,
>  							bss_entry->beacon_buf);
>  			break;
>  		case WLAN_EID_HT_CAPABILITY:
> +			if (element_len < sizeof(struct ieee80211_ht_cap))
> +				break;

why break and not return -EINVAL? (this in general, not only on this
specific one).


