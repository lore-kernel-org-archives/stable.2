Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [194.59.206.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FEC3B811F;
	Tue, 18 Aug 2026 08:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.59.206.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787041937; cv=none; b=YR0xt009kGC6jvKNYj/wiAj9cBG+qjCjiFQm5GvBbDwiGL3KeO1K4Gq1A/95AjhvxiRr4L3oer8O7iBz1JAsW6vDaq4dye1sW5NJYjL9puKEyWDsN1YVxqU60J5bONZQOv9elHOE7eVrncdxJzXcc5e6tg9z+FTlPNz71Bs7Cmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787041937; c=relaxed/simple;
	bh=8gWzpZryodg//Tt6gkCoheUeq+Zzndr2R8oDIMpEIpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JWfciPpJlDsRtALpy0a63iMukuOGxJbid7PsVpLlVINJ4plc+cdIhHXJNJfFSvEEif/c491q/KG+zS51rADIlIIGHzWy2LVcs14uJVYpsmrh6ji9ikL0wxyT7UppxBwI89VNe1odH2N7JJbt59BIWH0lOzwdpiXdXVelcFRs/uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=XD6u/0i+; arc=none smtp.client-ip=194.59.206.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="XD6u/0i+"
Received: from relay02-mors.netcup.net (localhost [127.0.0.1])
	by relay02-mors.netcup.net (Postfix) with ESMTPS id 4hPNGz3lDRz4CyS;
	Tue, 18 Aug 2026 10:32:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1787041931;
	bh=8gWzpZryodg//Tt6gkCoheUeq+Zzndr2R8oDIMpEIpk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XD6u/0i+/Rau8gNSjM3A6B+2JW3/9sxWqJIRdRTpea1tmCFiZM5EhySKroNjFyINB
	 IYAFlwip/zF0NhZSSLjLhLuhuy1hqw1JmKlYU/4VMqM/Zbl36KZTMe7hhw4qLaCQOh
	 u3XjxS+eOwT94u0bXwvq1JJ3RM9poCD3n3pUYGui0kvw0kfgRpD9ssmgCAfKbWwJgN
	 4cYvRCyvbXJ4PF+jqBJy0H3E+BszIcFytUy9nHefsim2JIouuAQU8tfm7TqgKwQuib
	 N2+z1bIArTFPSVvkVTVT2zckXXZTy8WeAiWoMbacsQCPOUXTNTQaL/WpRjo+s6K0e6
	 6owEJKz0bPxUA==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by relay02-mors.netcup.net (Postfix) with ESMTPS id 4hPNGz31Qqz7xMN;
	Tue, 18 Aug 2026 10:32:11 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4hPNGy0mg7z8sb7;
	Tue, 18 Aug 2026 10:32:10 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id D18A55FAAF;
	Tue, 18 Aug 2026 10:32:04 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <2719a7f9-71cf-447b-b4fa-a53e598d3d5a@leemhuis.info>
Date: Tue, 18 Aug 2026 10:32:03 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: typec: mux: Fix typec_switch_match()
To: Marek Vasut <marex@nabladev.com>, linux-usb@vger.kernel.org
Cc: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Jens Glathe <jens.glathe@oldschoolsolutions.biz>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 kernel@dh-electronics.com, linux-kernel@vger.kernel.org,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20260817182302.146546-1-marex@nabladev.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <20260817182302.146546-1-marex@nabladev.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <178704192528.3564116.6843811556363461498@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: D18A55FAAF
X-NC-CID: /Bx6R4kcJ3GShYDC85Bp7vJBFzp1xv5TR5uNsXCFgLZpDNNxlmc=

On 8/17/26 20:22, Marek Vasut wrote:
> The fwnode_typec_switch_get() sporadically returns NULL instead of an
> -EPROBE_DEFER for orientation-switch described in DT.

Hi Marek! Just to make sure, have you seen the patch submission
"usb: typec: mux: initialize orientation switch array"?
https://lore.kernel.org/all/20260804083434.20885-1-i@4t.pw/

It has a fixes tag for the commit you mention and reads: ""Commit
a53b4f9c51a9 ("usb: typec: mux: avoid duplicated orientation switches")
started using the orientation switch result array as state for duplicate
detection, but left the array uninitialized.

The first match therefore scans indeterminate stack contents before any
result has been stored. [...]""

Not my area of expertise, but it sounds related, that's why I wanted to
ensure you are aware of it. If it's something else: sorry!

Ciao, Thorsten

> This makes it
> impossible to discern whether the DT does describe an orientation-switch
> which did not probe yet, or whether the DT does not describe the switch.
> This happens with gpio-sbu-mux connected to an I2C GPIO expander.
> 
> The class_find_device() on typec_switch_match() may return NULL in case
> the mux did not probe just yet early on boot. The sw_devs[] array can be
> empty on boot as well. If these two conditions occur, then the conditional
> if (to_typec_switch_dev(dev) == sw_devs[i]) evaluates to true and the match
> function returns NULL, which propagates to fwnode_typec_switch_get() which
> makes it look as if the orientation-switch was not described in DT.
> 
> This is incorrect, because the mux driver will probe a bit later on, but
> at that point, the caller of fwnode_typec_switch_get() already got the
> NULL return value. The NULL return value also does not trigger IS_ERR(),
> therefore the caller driver interprets this as if the orientation-switch
> is not described in DT, and does not return -EPROBE_DEFER to try again,
> even if it should.
> 
> Fix this by checking the class_find_device() return value, and return
> -EPROBE_DEFER if it is NULL right away. If the return value is not NULL,
> perform the deduplication test, and if that test passes, consider the
> return value to be already non-NULL.
> 
> Fixes: a53b4f9c51a9 ("usb: typec: mux: avoid duplicated orientation switches")
> Cc: stable@vger.kernel.org
> Signed-off-by: Marek Vasut <marex@nabladev.com>
> ---
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
> Cc: kernel@dh-electronics.com
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-usb@vger.kernel.org
> ---
> NOTE: A similar change was reverted in
>       f576c75f95a5 ("Revert "usb: typec: mux: avoid duplicated mux switches"")
>       Maybe the orientation switch commit also needs a revert ?
>       Or the mux switch revert can be undone and fixed using this NULL check ?
> ---
>  drivers/usb/typec/mux.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
> index 9b908c46bd7df..2bc7e8edb3cbd 100644
> --- a/drivers/usb/typec/mux.c
> +++ b/drivers/usb/typec/mux.c
> @@ -56,17 +56,19 @@ static void *typec_switch_match(const struct fwnode_handle *fwnode,
>  	 * function "defers probe" for now.
>  	 */
>  	dev = class_find_device(&typec_mux_class, NULL, fwnode,
>  				switch_fwnode_match);
> +	if (!dev)
> +		return ERR_PTR(-EPROBE_DEFER);
>  
>  	/* Skip duplicates */
>  	for (i = 0; i < TYPEC_MUX_MAX_DEVS; i++)
>  		if (to_typec_switch_dev(dev) == sw_devs[i]) {
>  			put_device(dev);
>  			return NULL;
>  		}
>  
> -	return dev ? to_typec_switch_dev(dev) : ERR_PTR(-EPROBE_DEFER);
> +	return to_typec_switch_dev(dev);
>  }
>  
>  /**
>   * fwnode_typec_switch_get - Find USB Type-C orientation switch

