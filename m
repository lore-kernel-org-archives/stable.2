Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EF536B90C
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 21:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786484772; cv=none; b=Ud0Nv8quBlpMEJjj+e+xO9mHXxDm+CUeVryBZSKKYHEl/tlZvgYkKNYkyuCJi5lv0+vvVuQaCj5G2a2TmreE29Iv3SjDILvg+YYgApDpiGWorq5z3SQzJk6M0zeuaeuM2txvi1X7rWgo+iYbCOoG24CIqk6ii30M4ixUrCRUAr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786484772; c=relaxed/simple;
	bh=M6+x42Ra9mZV5aXqeupA2cbnRBucXuDnlPx1Q6OKhFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rRsw0gjW+4X+x9F/9JfmlFGMfZT4R4Dw9/OsvTeCVV9110uZZFMJdbVjSdEPFG1rnuibXMsF4K9pBUCU/9IcoGPJry9+GaPhShNxVBHxotK2rbeo07eOaYJHnXU4YSYz0rimNAUSd7QCVu+G5utJJBRNLgREZw7agpb7uaDDjPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VXQQQgAv; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VXQQQgAv"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8486672f03cso434074b3a.0
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 14:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1786484769; x=1787089569; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S0KVLMdXm3gz895ibuakjkga/MkVR3K4Q+M5sDfPkq8=;
        b=VXQQQgAvRwdiw0bxVKduum1tUEa+krLf3W+LsMHL1fjEmSw49BH35cXCxxVuW5MJ2x
         Tsrn8755PRWPtZUxJGcGUb9FCXUCf5+yWv2tOL14p1ehXtJwudDNOkqViJ/2Rs29k52M
         ngSMtVa6DALlf1fLaxOOfvrpSXDpvk6fKKyR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786484769; x=1787089569;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S0KVLMdXm3gz895ibuakjkga/MkVR3K4Q+M5sDfPkq8=;
        b=QjkXj2GYl9UjkuADfIovBUCf2GmWH3cO7mP6r0ZNIbQNA1A+CloAyOaTWk/+cQ7mSx
         FxDjDugZCFXZxHf7CT9OEkufNpnTtojXTtmsPWKQTPWkrorUoTAnHuxPwiwz4BaSHW3E
         Owc0ZRpLHL9/w80t0LuZ4jaULG1hkD9DWve+8fiwNTA38ZVje1OANwgGtjlSKQDCFmCR
         o+No+gYxgIrZ5inXHFkLoujTZF3R/3kJrmIAtlJCHwaGBj/X4EgMLlWFw/wCZ3dEDvww
         552WH4Bk4pJMEe8/pDRtpJjEORLaO8Q3qOoHvmZk2Y2NgWdO0xDOXbfGyyztXX1tePaQ
         r84w==
X-Forwarded-Encrypted: i=1; AHgh+RoMpzFBTWt9OD7k8jQvfqj1WKxVu5mLJf21nRkrCScN6IDPa3VBdkExyp5Oa3NtCjmQVtNobVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyidJgElHdxe9jfc+AjgDfO9zeYXZmU0xKOctYO8FyhRWMVXExw
	bciv8GFMmdGLt30w0CbL99gcCtrEZEwjmccUCwffibGBHuh9MKkXIp5aB0Q+rozeLA==
X-Gm-Gg: AR+sD13GrxZG/VP5DkDvx4jJyzMtpMSYEikFsjrfCv3emXoq5fO3+qLOy0/vvPTDg8B
	2MAsWyPe6MZc0s4WWENERGKVZQIj5VPI7hjiZCc+D+ANUdvVYHE5pwouCEtEMbqxpqqDblZtuPM
	2Lg2160HPAnoHGCENAY6QtJQw80IrTDpHzsRNkQ4jXPe9yKX1iTEhDWOgEOjdG58Xi3lXu+De9A
	JTdRk/37JHI1j5Iof8IpVO2K+okvd2lXbz5o0CGZ/FfzYRcEB3n0c52QYeGQpzbyohaEEApDW78
	uJ8iO73wv52IvS4y1GdyL3/RosYyM7G7qJeZW1Ta1nr9na2FUP4kMI2O3+SFtocE8sQnTdLQgJK
	eCgME79QJ5iYZfD7Fh0+nWzKFr+nEqu2VLI2xb3jdf1D8iLyDDVRLQAQclJWPelGANC7Exw2+7q
	Oqb8H6ouE0VAu10DxJaKhT9QAUZAex+zGOuTrmC+PPec1RkhNGgxR6oZWw53Y2EIiJJsuW+dnrw
	yKknvsCxI8/vn5PUKT+JQwm9W8=
X-Received: by 2002:a05:6a21:a49:b0:3c4:1c9f:d7e with SMTP id adf61e73a8af0-3cc2b77a9fdmr9612504637.6.1786484769271;
        Tue, 11 Aug 2026 14:46:09 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:79fa:d268:80cb:4947])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-14124451180sm2624868c88.1.2026.08.11.14.46.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 14:46:08 -0700 (PDT)
Date: Tue, 11 Aug 2026 14:46:06 -0700
From: Brian Norris <briannorris@chromium.org>
To: Doruk Tan Ozturk <doruk@0sec.ai>
Cc: francesco@dolcini.it, kees@kernel.org, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] wifi: mwifiex: validate HT/VHT capability and
 operation IE lengths
Message-ID: <anuYHjoUCW5rSVyt@google.com>
References: <20260802124426.87779-1-doruk@0sec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260802124426.87779-1-doruk@0sec.ai>

Hi Doruk,

On Sun, Aug 02, 2026 at 02:44:26PM +0200, Doruk Tan Ozturk wrote:
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
> The length tested in mwifiex_set_sta_ht_cap() is ht_cap_ie->len, which
> is attacker-controlled on-air data, so it is only used as a bound.
> cfg80211_find_ie() walks the IE stream and returns NULL for an element
> that claims to be longer than the data it was given, so any element it
> does return has len bytes of payload inside ies_len. The new test is
> therefore a minimum-size check before the fixed-size cap_info read, not
> an assumption that len is trustworthy beyond the bounds cfg80211 has
> already enforced.
> 
> No dynamic reproducer: mwifiex is a fullmac driver for Marvell hardware
> with no mac80211_hwsim equivalent, so this was confirmed by source and
> structure-offset analysis, and compile-tested only.
> 
> Found by 0sec automated security-research tooling (https://0sec.ai).
> 
> Fixes: 5e6e3a92b9a4 ("wireless: mwifiex: initial commit for Marvell mwifiex driver")
> Cc: stable@vger.kernel.org
> Assisted-by: 0sec:multi-model
> Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
> ---
> 
> Changes in v3 (per Francesco Dolcini's review of v2):
>  - Commit message only; the diff is unchanged from v2.
>  - Spell out why ht_cap_ie->len is safe to test against in
>    mwifiex_set_sta_ht_cap(): cfg80211_find_ie() already rejects an
>    element that claims to be longer than the data it was given, so len
>    is used purely as a minimum-size bound, not as a trusted value.
>  - Restore the note (dropped in v2) that there is no dynamic
>    reproducer and that this is source-analysis plus compile-tested
>    only, answering the "did you test this" question on v1.
> 
> Changes in v2 (per Francesco Dolcini's review of v1):
>  - Return -EINVAL on a too-short element instead of break, matching the
>    FH/DS/CF/IBSS and VENDOR_SPECIFIC cases in the same function.
>    mwifiex_set_sta_ht_cap() returns void, so there it stays a skip.
>  - Switch the Assisted-by trailer to 0sec:multi-model.
> 
> v1: https://lore.kernel.org/all/20260709100800.7026-1-doruk@0sec.ai/
> v2: https://lore.kernel.org/all/20260715185543.14478-1-doruk@0sec.ai/
> 
>  drivers/net/wireless/marvell/mwifiex/scan.c | 12 ++++++++++++
>  drivers/net/wireless/marvell/mwifiex/util.c |  2 +-
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/marvell/mwifiex/scan.c b/drivers/net/wireless/marvell/mwifiex/scan.c
> index 97c0ec3b822e7..22031faba057f 100644
> --- a/drivers/net/wireless/marvell/mwifiex/scan.c
> +++ b/drivers/net/wireless/marvell/mwifiex/scan.c
> @@ -1384,6 +1384,8 @@ int mwifiex_update_bss_desc_with_ie(struct mwifiex_adapter *adapter,
>  							bss_entry->beacon_buf);
>  			break;
>  		case WLAN_EID_HT_CAPABILITY:
> +			if (element_len < sizeof(struct ieee80211_ht_cap))

I think this is more clearly-correct when you use this form:

			if (element_len < sizeof(*bss_entry->bcn_ht_cap))

Same for most/all of these. See especially the note for
WLAN_EID_OPMODE_NOTIF below.

> +				return -EINVAL;
>  			bss_entry->bcn_ht_cap = (struct ieee80211_ht_cap *)
>  					(current_ptr +
>  					sizeof(struct ieee_types_header));
> @@ -1392,6 +1394,8 @@ int mwifiex_update_bss_desc_with_ie(struct mwifiex_adapter *adapter,
>  					bss_entry->beacon_buf);
>  			break;
>  		case WLAN_EID_HT_OPERATION:
> +			if (element_len < sizeof(struct ieee80211_ht_operation))
> +				return -EINVAL;
>  			bss_entry->bcn_ht_oper =
>  				(struct ieee80211_ht_operation *)(current_ptr +
>  					sizeof(struct ieee_types_header));
> @@ -1400,6 +1404,8 @@ int mwifiex_update_bss_desc_with_ie(struct mwifiex_adapter *adapter,
>  					bss_entry->beacon_buf);
>  			break;
>  		case WLAN_EID_VHT_CAPABILITY:
> +			if (element_len < sizeof(struct ieee80211_vht_cap))
> +				return -EINVAL;
>  			bss_entry->disable_11ac = false;
>  			bss_entry->bcn_vht_cap =
>  				(void *)(current_ptr +
> @@ -1409,6 +1415,8 @@ int mwifiex_update_bss_desc_with_ie(struct mwifiex_adapter *adapter,
>  					      bss_entry->beacon_buf);
>  			break;
>  		case WLAN_EID_VHT_OPERATION:
> +			if (element_len < sizeof(struct ieee80211_vht_operation))
> +				return -EINVAL;
>  			bss_entry->bcn_vht_oper =
>  				(void *)(current_ptr +
>  					 sizeof(struct ieee_types_header));
> @@ -1417,6 +1425,8 @@ int mwifiex_update_bss_desc_with_ie(struct mwifiex_adapter *adapter,
>  					      bss_entry->beacon_buf);
>  			break;
>  		case WLAN_EID_BSS_COEX_2040:
> +			if (!element_len)
> +				return -EINVAL;
>  			bss_entry->bcn_bss_co_2040 = current_ptr;
>  			bss_entry->bss_co_2040_offset =
>  				(u16) (current_ptr - bss_entry->beacon_buf);
> @@ -1427,6 +1437,8 @@ int mwifiex_update_bss_desc_with_ie(struct mwifiex_adapter *adapter,
>  				(u16) (current_ptr - bss_entry->beacon_buf);
>  			break;
>  		case WLAN_EID_OPMODE_NOTIF:
> +			if (!element_len)

Are you sure "non-zero" is the right check here? This field is used as
'struct ieee_types_oper_mode_ntf'. If you used the sizeof(*...)
suggestion above, I don't think we'd fall into that type mismatch trap.

Brian

> +				return -EINVAL;
>  			bss_entry->oper_mode = (void *)current_ptr;
>  			bss_entry->oper_mode_offset =
>  					(u16)((u8 *)bss_entry->oper_mode -
> diff --git a/drivers/net/wireless/marvell/mwifiex/util.c b/drivers/net/wireless/marvell/mwifiex/util.c
> index 7d3631d212236..844223c04e2ef 100644
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
> -- 
> 2.43.0
> 
