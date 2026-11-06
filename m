Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.56.87.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793964775;
	b=P3tOAa9IELYZztn4fEd7aQaao1AhfaqWzZwKPnyNstaxBDhI498W068C+PIdIvtuQzbD
	 OLCFYTsLDJXHRF0qLdSf7O6ITkLLqTdgJOGN9/zBRLzksvuFxyjhaYV6Uhv7sIQg3KU3U
	 mEApxO/Ss6BNIQmMAnc+8oJiI4xK8QompPXxul9gjl0EEf7jNQ97qSzeUWUwze6mJsWdE
	 STpMJMSVmr1Kbk+A6j/52RMJUozauKBU3xtGYeg/JC9D5gTwK0WWkV/13x4z79dgbb4ba
	 lQ6GYd4cpt0Lgoo40W0FteP2+VeJWZpSHPJD5uK2r2a3IQg9J8L5KcbFx7Jn1q2B/vw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793964775;
	h=DMARC-Filter:DKIM-Signature:Received:DKIM-Signature:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-Source:X-Source-Args:X-Source-Dir:
	 X-SGantispam-id:X-AntiAbuse:AntiSpam-DLS:AntiSpam-DLSP:AntiSpam-DLSRS:
	 AntiSpam-TS:CFBL-Address:CFBL-Feedback-ID;
	bh=2ilPdXoV+AvhK0fC2FnOFsRUV3deUGZ/dhGNf11FY8g=;
	b=Q01iRKUcNYADz1+DM6UqBPVbeerABlf29XRG4/B0lUIf3G58v4lkqU9KjWmP1B2724Fc
	 ll0j7xrwe5NMF0Ye9vO1HvzLvWUMNNF5WYj1GzQVZE0DKJymUQvPrAXBlkulo/3tVyr0k
	 ctud8sxNJJYozobTGL7jwS2Sj/K2fZiZ70UJbFQ6XFMM3FZcezeSO9zEyumlEE/A29nXB
	 kkVezVEaWNvYqmGYIwHp+3QKvlUADLeKl3gHU3cSKA8q9vdsR4wQjR1MmxMLDNb1UCEc8
	 IBHJM6F4VUGW6nV+HFkC3Wq7pM/hKy/DFVDyu5U8IJyPgOuMz20cuX1nmV667ESTsaw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valla.it;
	spf=pass smtp.mailfrom=valla.it;
	dkim=pass header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.a=rsa-sha256 header.s=default header.b=rmWAGRuh;
	dkim=pass header.d=valla.it header.i=@valla.it header.a=rsa-sha256 header.s=default header.b=mMMA7T9E;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.56.87.12
Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48870606C7FA;
	Fri,  6 Nov 2026 11:32:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48870606C7FA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.a=rsa-sha256 header.s=default header.b=rmWAGRuh;
	dkim=pass (1024-bit key, unprotected) header.d=valla.it header.i=@valla.it header.a=rsa-sha256 header.s=default header.b=mMMA7T9E
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-c9nw.prod.antispam.mailspamprotection.com; s=arckey; t=1793964774;
	 b=kfOUArOBMFPD4MpPe4knPJCoevtre6hOM1O3k3HviQ+mKLSlu48QlW7giwUc/8OJpm7zpyw+w4
	  ND9jGsp1Yss0wa2yzP4AZcGGwO8004Gm7NpMitTI/spGt09CA6U5LW1pWziThdPi0M3EfxASZ/
	  iAj/MIUtiqr7DKKrUtesJZJROjW1Q8i9iKFsN3iD/fPrdpK2K3APAtnzpLjSl7ZcepK24m4QcF
	  jE8uaQ7nYg4KL+CBfyxgh4P0IimrJvRPObPHEPX6I8vQhlLQp8GIFUL4KLXoM0n2P6Y8E5QTuR
	  1rrmx5GLxbR9auFwhZpZJn6t2Ftw6gJUcRsquzRO9ZjN2g==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-c9nw.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-c9nw.prod.antispam.mailspamprotection.com; s=arckey; t=1793964774;
	bh=StTLOIlH+mOroSjglTjzO+dphxU2ZLCcVyqxkOymtxI=;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:
	  From:Date:DKIM-Signature:DKIM-Signature;
	b=Y6ZB1+1/RXyx46KwpnmWyJDxZQVt+igXFVJ3w6WwXBzLoxbjtc9RkjPAPEFh+X7QK/TIbOfhBA
	  03PYf60UkGfJ/JGBkscsdLMqezh7J4JRI+FyhDbteqRs4Vmj/FoKAQO38GQnvthN4DkP6UgP/4
	  Ha8i1PnBvXuHDnVvpvRfi1SOcJOivJqOK8vevfRw31F0DNQRJuOQkNnui/gCw2NjWw38O87PPP
	  T5S4d8eKMlprjyaNOgkmMkJ5ATf6pjRXAbZic2I2KrzyU0JkyMHxVk0FWbOnFVv5/m5+1Lxn7r
	  E+ZCj81oX/WQ8dtg2UVf25TaqIZnVYrEayG1X7wsWSBzJQ==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	List-Unsubscribe:Content-Transfer-Encoding;
	bh=2ilPdXoV+AvhK0fC2FnOFsRUV3deUGZ/dhGNf11FY8g=; b=rmWAGRuh7HPXPkObP3TO+apeSS
	v5i4ExD5XPt+aizpJINqvD2AH49DlUPV30PppZY0RnjlHKNszpf6qySdkzT3inPgH9nr7XF6CUcEt
	4JPT07mM9eMgZQrXVXJPOWGQOAlw7LTBya2dPIoqJMX3mv3bGM5ukQHh4K+lXp4QSW2A=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-c9nw.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <francesco@valla.it>)
	id 1xPIBZ-0000000GzWr-3puy;
	Fri, 06 Nov 2026 11:32:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Subject:Cc:To:From:Date:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=2ilPdXoV+AvhK0fC2FnOFsRUV3deUGZ/dhGNf11FY8g=; b=mMMA7T9E18+dT9qqIUcQKG0CiI
	ZDCL797OJOhaIXVu2eXVqoT6Fje3mLrU896F6tTXMECzRJe5+5tPFnsk7LzmAD/CXjZWraYcXmlld
	J1HNbVFh7yoLSlPlXhRQ0GBLfVj90Rlu10wahyuS7CbaqdTGQ8cGeXuQuapFsP1pbd08=;
Received: from [79.17.15.196] (port=63381 helo=bywater)
	by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <francesco@valla.it>)
	id 1xPIBU-000000008gE-29Yl;
	Fri, 06 Nov 2026 11:32:40 +0000
Date: Fri, 6 Nov 2026 12:32:39 +0100
From: Francesco Valla <francesco@valla.it>
To: Yuqiang Sun <izaiahsun@gmail.com>
Cc: andersson@kernel.org, mathieu.poirier@linaro.org, 
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] remoteproc: core: Do not put the device when
 device_add() fails
Message-ID: <au24I4glFZ0S30A5@bywater>
References: <20261106065100.44269-1-izaiahsun@gmail.com>
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
In-Reply-To: <20261106065100.44269-1-izaiahsun@gmail.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: 13ca5306e4263fd04c114629ffd1e83e
X-AntiAbuse: ID - 13ca5306e4263fd04c114629ffd1e83e
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1xPIBZ-0000000GzWr-3puy-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-c9nw.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

On Fri, Nov 06, 2026 at 02:51:00PM +0800, Yuqiang Sun wrote:
> In rproc_add(), put_device() is called when device_add() fails.
> But st_slim_rproc_alloc(), xlnx_r5_remoteproc and the other 23
> drivers (which use devm_rproc_alloc() and so devm_rproc_free()) then
> call rproc_free(), which puts the device again. The reference is
> dropped twice, and st_slim_rproc_alloc() uses the rproc after it is
> freed.
> 
> Remove the put_device() in rproc_add() and add a comment saying why.
> 
> Fixes: 7dbdb8bd7c02 ("remoteproc: core: Cleanup device in case of failure")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yuqiang Sun <izaiahsun@gmail.com>
> ---
> 
> Notes:
>     Changes in v2:
>     - Comment in the device_add() failure branch (Mathieu).
>     - Shorter changelog.
>     - Rebased on rproc-next.
>     
>     Bug was found by kbound, an internal static analysis prototype.
>     The reproduction was assisted by Claude Opus 5.5.
>     
>     v1: https://lore.kernel.org/linux-remoteproc/20261029130037.5505-1-izaiahsun@gmail.com/
> 
>  drivers/remoteproc/remoteproc_core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index d5fa9d23bd5c..d0b1f6ee49d3 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -2312,7 +2312,10 @@ int rproc_add(struct rproc *rproc)
>  
>  	ret = device_add(dev);
>  	if (ret < 0) {
> -		put_device(dev);
> +		/*
> +		 * Do not put_device() here: the caller's rproc_free() does
> +		 * it, and the reference would be dropped twice.
> +		 */
>  		goto rproc_remove_cdev;
>  	}
>  
> 
> base-commit: b16b5a4fdf7d1f4ec15a53622d9b66081325fbf9
> -- 
> 2.53.0
> 
>

Reviewed-by: Francesco Valla <francesco@valla.it>

Regards,
Francesco

