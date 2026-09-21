Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B6543DED7;
	Mon, 21 Sep 2026 08:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789978452; cv=none; b=prOZLD57Vipw08sBxAL9qALACG5OA05XIC1IA2TANyCJTTdNzKyWX1mbLePKonO4P7Xm8ABzTBBd3eOmN8s8dAIOa9GzXzFNPo9Tc4C1ZIYA1AxMn4wbFYYeqLULIajU7w3GGa2NYm/9spGM/KQ+CRXZ60P1BVeJtKplgOcLJr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789978452; c=relaxed/simple;
	bh=l86fcK3hzGtcAhCB4Bph5mI/Y/C58kNNTjHtXO0F+DQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Og12WSdWM3/iUsvykuTeiC5t7VzArk2dyv1uyXYzSAdJvq0juyFlXpD+raSzVySHksIVoc79LXGNEXxydJ3uM6LRp+e6qAFL+0WmI3ucuX5TZSUMyIP+XkAeYE3TiEZOgm6K5CrVs15ecE/WOneIG7n+vIuYqhK7asCJP0qK0xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lv1Wwrl4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lv1Wwrl4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 105141F00893;
	Mon, 21 Sep 2026 08:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789978450;
	bh=QV2/QXe484Gw8p7XltnERZH+6cG8HTSHFECBhKmtXKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lv1Wwrl4uTm0a4TZD1SB3DeteIWPupRg0iisUPbSxYynHo0rfVBmw6n+ttQroo2T6
	 88juhH8uHCYZegj+pPVvmW3WrzOn5bWGxwAsYKq0laBIhKLRy3Oj7bbuAjrrxFoSuE
	 XFD8O2kpyNbMi8indT59lJaZsaOSEOkeb6ZIOyBw=
Date: Mon, 21 Sep 2026 10:13:59 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Park Tae-sun <ts930@dgu.ac.kr>
Cc: Hans de Goede <hansg@kernel.org>, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: fix buffer overflow and OOB accesses
 in rtw_check_beacon_data()
Message-ID: <2026092127-rigid-anchovy-3aa3@gregkh>
References: <20260921073730.83679-1-ts930@dgu.ac.kr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921073730.83679-1-ts930@dgu.ac.kr>

On Mon, Sep 21, 2026 at 04:37:30PM +0900, Park Tae-sun wrote:
> In rtw_check_beacon_data(), the Information Element (IE) parsing logic
> has boundary validation issues and search window calculations that can
> lead to out-of-bounds accesses:
> 
> First, IEEE 802.11 beacon frames contain 12 bytes of fixed parameters
> (Timestamp, Beacon Interval, Capability Info) before variable IEs start
> at _BEACON_IE_OFFSET_ (12). The function checks len < 0, but if len is
> smaller than _BEACON_IE_OFFSET_, (pbss_network->ie_length -
> _BEACON_IE_OFFSET_) underflows on the u32 field, and reading the beacon
> interval at offset 8 via rtw_get_beacon_interval_from_ie() accesses
> out-of-bounds data if len < 10.
> 
> Second, the manual vendor IE loops for WPA and WMM advance p by
> (ie_len + 2) on non-matching elements, but calculate the limit passed
> to rtw_get_ie() as:
>   (pbss_network->ie_length - _BEACON_IE_OFFSET_ - (ie_len + 2))
> This only subtracts the previous element's length rather than the
> accumulated offset (p - start), causing p + limit to extend past the
> end of the buffer on subsequent iterations. In addition, calling
> memcmp() without checking ie_len can read past short vendor elements.
> 
> Third, in the WMM loop, once the OUI matches, bytes up to *(p + 22)
> are modified without checking whether the IE contains the full
> 24-byte WMM parameter payload (WLAN_WMM_LEN). A truncated element
> leads to out-of-bounds writes.
> 
> Address these by:
>   1. Checking len < _BEACON_IE_OFFSET_ at function entry.
>   2. Using the existing rtw_get_ie_ex() helper which validates
>      element boundaries and OUI lengths before calling memcmp().
>   3. Passing ie_len directly to rtw_parse_wpa_ie() without +2,
>      because rtw_get_ie_ex() already includes the 2-byte header.
>   4. Verifying that the WMM element has at least WLAN_WMM_LEN + 2
>      bytes before modifying the parameter records.
> Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Park Tae-sun <ts930@dgu.ac.kr>
> ---
>  drivers/staging/rtl8723bs/core/rtw_ap.c | 81 ++++++++++---------------
>  1 file changed, 33 insertions(+), 48 deletions(-)

How did you find this?

How did you test it?

You need a blank line before the Fixes: tag, right?  Didn't checkpatch
catch this?

thanks,

greg k-h
