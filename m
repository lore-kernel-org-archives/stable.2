Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8A23845BC;
	Tue, 28 Jul 2026 07:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785224446; cv=none; b=fHhuFfNHtloDAQ4JJ+90GcHS70UvYofYYxiGUt3lAXZZ8Ot6xHRi+dOfAGDVNS6xp7vrwsCTQ2v8dRNhhJ7HMicyaQ39aQEEalvJSi91eIArxVM87Ng92p3GcpnXRH1kNOA0QsQDXaVgFUowmmxIXOr9LuCdd2gBPb59w0bZmgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785224446; c=relaxed/simple;
	bh=rrihhYA2gi833VCb+7lIwC72FMpMN1SSrvaeN9g6jQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tarPmkehwoXU6TTsLcGOFb5shYyGiqSyohvt98st9lUrnd33F22lS61C/VU03pDCNyBlhcGvsNYjSMIaYfXRSP1R1xYAXm+yD3Dto+9TC5YI/lUvje7DasmzLmN5+ZHZhNiFwLDXufMh9vn1faPpCs8i0yvVUpRMgRGK6SeY/vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PGt+eXP/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PGt+eXP/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E9641F000E9;
	Tue, 28 Jul 2026 07:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785224445;
	bh=iQg6cMZb34SYEIs09J6YbsKfyEc6r8rw45jwah0X8+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PGt+eXP/bcoD5TY/gdjmHcuNjwiAmZ8SaSHfCmCHi+5owiTA0a6UE4k6KsYnzqoQI
	 VacituVkB15iQU0rAoAaB8dISgR60WC+XBdOkb2OQzgRG3a7ulm9F4/95Cz78YOA9h
	 j5aAqSEn0j52UVWv55SYa+3G6kbq1n+m/i5OtDdA=
Date: Tue, 28 Jul 2026 09:40:32 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Muhammad Bilal <meatuni001@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/5] staging: rtl8723bs: fix OOB read in rtw_get_wps_ie()
Message-ID: <2026072825-idealism-mortuary-5cbe@gregkh>
References: <20260718185445.63070-1-meatuni001@gmail.com>
 <20260718185445.63070-2-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260718185445.63070-2-meatuni001@gmail.com>

On Sat, Jul 18, 2026 at 11:54:41PM +0500, Muhammad Bilal wrote:
> rtw_get_wps_ie() walks a series of information elements taken
> directly from received/associated wireless management frames
> (beacons, probe responses, scan results). The loop condition only
> checks "cnt < in_len" before reading in_ie[cnt + 1] (the IE length
> byte) and before a 4-byte memcmp() at &in_ie[cnt + 2], with no check
> that those offsets are actually within in_len.
> 
> A malicious or malformed IE blob (e.g. a truncated vendor-specific
> IE placed near the end of the buffer) can therefore make this
> function read past the end of in_ie by up to several bytes, both in
> the loop condition path and via memcpy(wps_ie, &in_ie[cnt],
> in_ie[cnt + 1] + 2) when a spurious match occurs.
> 
> The sibling helpers rtw_get_sec_ie() and rtw_get_wapi_ie() in this
> same file already perform the equivalent "cnt + 2 > in_len" /
> "cnt + 2 + in_ie[cnt + 1] > in_len" checks, added to those two
> functions by commit 1463ca3ec660 ("staging: rtl8723bs: fix OOB reads
> in rtw_get_sec_ie(), rtw_get_wapi_ie(), and rtw_get_wps_attr()").
> rtw_get_wps_ie() was simply never brought in line with them. Add the
> same checks here, plus a length check before the 4-byte OUI memcmp.
> 
> Fixes: 554c0a3abf216 ("staging: Add rtl8723bs sdio wifi driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_ieee80211.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
> index 54f805a6b5ce..2fb5863dbeef 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
> @@ -668,9 +668,15 @@ u8 *rtw_get_wps_ie(u8 *in_ie, uint in_len, u8 *wps_ie, uint *wps_ielen)
>  	cnt = 0;
>  
>  	while (cnt < in_len) {
> +		if (cnt + 2 > in_len)
> +			break;
> +		if (cnt + 2 + in_ie[cnt + 1] > in_len)
> +			break;
> +
>  		eid = in_ie[cnt];
>  
> -		if ((eid == WLAN_EID_VENDOR_SPECIFIC) && (!memcmp(&in_ie[cnt + 2], wps_oui, 4))) {
> +		if ((eid == WLAN_EID_VENDOR_SPECIFIC) && (in_ie[cnt + 1] >= 4) &&
> +		    (!memcmp(&in_ie[cnt + 2], wps_oui, 4))) {
>  			wpsie_ptr = &in_ie[cnt];
>  
>  			if (wps_ie)
> -- 
> 2.55.0
> 
> 

This patch doesn't apply to my tree :(


