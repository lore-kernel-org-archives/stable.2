Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CD1BA45;
	Wed, 30 Sep 2026 04:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790743089; cv=none; b=VJ+VHyipzE/FfC+48BlrAybEIhp3gz7VjV6k9Tm05wkEt+rEu1FbRYeV4WoEf9ip+4vK7XTcU1RUI20ED+L/JMtkBhwcDWAgIO/uOwMn5+Hf/cr90u9/nDTbkTHr2KAOgqmvpWV1zjLs7q+ARNsWQpKgUD+C7wC8ovNirnn6jmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790743089; c=relaxed/simple;
	bh=M6uU8o49tDtv7jDAxqBwJvlXDMmRkeZt8ZPOr04/u7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qDeTDPvUpwF9zycqv/n/bGwqOO/RrDMBgBDWTk0NOrqwRU1/U5VlYTL0hWbF7FYEu4+tS6RwKaoqiEWNLWhsK7AyKIy2nFegPuK4jKVqFoPG+KEFFEzMTWVagLKJxDd+WkD5TVD1xdP4IPTC5RaI8AoJyZ0ryjcWPsDbPK/6eeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U+mf5QYL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U+mf5QYL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A3E81F00893;
	Wed, 30 Sep 2026 04:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790743087;
	bh=WeoG1KdMb7QoLuwFDC5VcWZ9vh49HZi5r7TodOIdtJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=U+mf5QYLr799YO7rxHSTCrEMzVxOc4KWNjoS4s4aWqfQVmPIYXDI97IxOBSvBFxIc
	 994lA2+elhoHF3GnJzfSuP9gZGgcKBDYvRL6fu81jGe9wy+lp0Wa6sSaiQ5nCQniRX
	 JSTfPHXY0Poi4t4W3uPhMNMesuSFWpdMS9pfKev4=
Date: Wed, 30 Sep 2026 06:38:04 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Gongwei Li <13875017792@163.com>
Cc: linux-staging@lists.linux.dev, Hans de Goede <hansg@kernel.org>,
	Dan Carpenter <error27@gmail.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Gongwei Li <ligongwei@kylinos.cn>
Subject: Re: [PATCH] staging: rtl8723bs: fix scan-abort timeout in
 rtw_scan_abort()
Message-ID: <2026093048-thrive-phoney-5b9e@gregkh>
References: <20260930015024.3627275-1-13875017792@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930015024.3627275-1-13875017792@163.com>

On Wed, Sep 30, 2026 at 09:50:24AM +0800, Gongwei Li wrote:
> From: Gongwei Li <ligongwei@kylinos.cn>
> 
> rtw_scan_abort() checks jiffies_to_msecs(start) <= 200, but start holds
> an absolute jiffies value, so this converts the time since boot rather
> than the elapsed time. Once the system has been up for more than 200ms
> the condition is always false and the loop never waits for an ongoing
> scan to finish.
> 
> Use jiffies_to_msecs(jiffies - start) to get the real elapsed time.
> 
> Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gongwei Li <ligongwei@kylinos.cn>
> ---
>  drivers/staging/rtl8723bs/core/rtw_mlme.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
> index d18768a51b19..d4beff59f272 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
> @@ -931,7 +931,7 @@ void rtw_scan_abort(struct adapter *adapter)
>  	start = jiffies;
>  	pmlmeext->scan_abort = true;
>  	while (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY)
> -	       && jiffies_to_msecs(start) <= 200) {
> +	       && jiffies_to_msecs(jiffies - start) <= 200) {
>  		if (adapter->driver_stopped || adapter->bSurpriseRemoved)
>  			break;
>  

How was this found and tested?

thanks,

greg k-h
