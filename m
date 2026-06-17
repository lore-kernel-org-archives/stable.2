Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB3539E9C8;
	Wed, 17 Jun 2026 22:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781734747; cv=none; b=f8HsnJvv1DQXCMOEvKMevGXEivDdVwaUqxr7xXaQXEdgZ3WjdglfU4P8M/G1jbyuZUm+eVGxbLKTBlvwac/0MVCIFHwwdokoiZZhyq6wTV5htOpuHCWHIySHKLsUB5LlrtHjOHy3C61VYBDAjhSCjoDaooBTIEEGk8Jmyymqzhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781734747; c=relaxed/simple;
	bh=iwOB2BjRpWHpiAkjAunSy1kSThaOq0jrJ2urVceQOo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EUYo/cxs0YVyjxVr+YFsqOoxi+lUfDxMkPAGG8TM5A0u1JOxx9R6f3EhyLeuBy9CfliiPj77EFMajzi9IxWE2di1l8d+97feKLX+yNsdrMsd1JfQXge6dHJlSRxGf3CsLh/6blII1J5fH1JNc0Q+4QwhK04wqnvkhsr8sT6lGYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Nd2VCaWK; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Nd2VCaWK"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9E67040E015A;
	Wed, 17 Jun 2026 22:18:54 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id vxrtJOhXEUgf; Wed, 17 Jun 2026 22:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1781734724; bh=0f++1YPuGU5ow7b72prPIvdwxMCAYDA1ZPUqkcuhCPw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nd2VCaWKziaZOZ4bMV6vnMQI+BEohcevqcsu6njOO4c+Ip1jsXkF5+6sNLtQW8Qsb
	 Ut6B8PVN0NOW6GEqxOIy3G1lYZB97Hw5DPRGG6K8Kg+smR2pvBe/JVsQPOYNxQhpVr
	 Nw46UL+OO7cp0GkbNHHXQyb/7hNGLbaHQrdwIh/XZujzax9Y31uQ32sifR1HKsMcmP
	 ReHn9ILE3W7by602SwxSNxZJJsf9zAlMcDv7ddovN2pTfWcX5Fdv+yH0pBol8h7PVF
	 wx3soDVj0mTKrEoXR0Us64tc1wf7aSAt2VL2DksQoP0HtvesQkvCHYqKilndDwK9WD
	 uNy3jPkoH9U/ohEXyHil+wkadwzAKOo4fEf0/kQhhxtg8LZS1+tg2+eKyQo+D1XxkA
	 DTRQ9zxw7DkVYR7yS2CRwMIbsc2L/9KL3P+Iwt5qF1qFM0mP1JJBYuBG8ufMGXuJi4
	 wjr/1p2tbYAH3CNEvVaZNtB8Eq88O3xTCVp+qupacOIrENDiM3eFSdbh3DghzuCtu3
	 ht1xvJs2+X0dck5f0tuqDQ1w/Xt9zoYVXbfe9J3IICkg8awZ+Rs8cyqd0RKnkPhP03
	 6lMNjjPck1LP6HrR9yFGEs2misZPT7Taar3fjWUO/fSlhJ5lRp/p7AfSLjIsYun9D6
	 m8RZvavoN8TGkkPp+2vWA7Ms=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::3a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6EC4740E00BF;
	Wed, 17 Jun 2026 22:18:37 +0000 (UTC)
Date: Wed, 17 Jun 2026 15:18:34 -0700
From: Borislav Petkov <bp@alien8.de>
To: Dinh Nguyen <dinguyen@kernel.org>
Cc: tony.luck@intel.com, dbgh9129@gmail.com, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] EDAC/altera: Use parent device for devres in
 altr_portb_setup()
Message-ID: <20260617221834.GAajMdOocCPq39b-s0@fat_crate.local>
References: <20260617164303.585555-1-dinguyen@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260617164303.585555-1-dinguyen@kernel.org>

On Wed, Jun 17, 2026 at 11:43:03AM -0500, Dinh Nguyen wrote:
> Anchor the devres group and the devm-managed IRQ requests in
> altr_portb_setup() to the actual parent device (device->edac->dev)
> instead of the embedded struct device inside the copied per-port
> altr_edac_device_dev. This keeps devres_open_group(),
> devm_request_irq(), devres_remove_group() and devres_release_group()
> all referring to the same long-lived device so the group and the
> resources allocated inside it are torn down together.
> 
> Fixes: 911049845d70 ("EDAC, altera: Add Arria10 SD-MMC EDAC support")
> Cc: stable@vger.kernel.org
> Closes: https://sashiko.dev/#/patchset/20260503212558.2811480-1-dbgh9129%40gmail.com
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
>  drivers/edac/altera_edac.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

How urgent is this? Can it wait until the merge window is over?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
