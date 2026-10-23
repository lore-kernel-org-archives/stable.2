Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792776194;
	b=05yZ3p+FVj9xnG4BGEXGNbSNZZCz7F+eyDHFZzq/OlZzrxBhKhJ1//owPkdwjofqCE3z
	 6KW8q1JoNufynbRj0vJXCBVJV90sJTRIGal+NjXgQe2IyLX1yRbVyndQKaoCNhQ1smTxr
	 P7kHujr8OcUrjUys+NHiAtkMYqNKajQ/rvNMRS+v43A1EeKA0+uqzikxzS5NAbFjPWGq2
	 HfzoQso3gERy2xvQ2KGxu/FO5EFELJBfWSEhwuAzDJ0RpAICiIRjomwrrAPUfnl1X7lPH
	 bBjPWownwPl+FikiIGBCYm1+1viBXz/QXYtJu/xzVZ86qHGF/AZL8jiHhl9DHSK0pcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792776194;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=e9CHgVUiuUr9z0N9kziykHeUFdcQZLlPHyMU3G/0OGQ=;
	b=DJ29wBC6rdfFnKwB0E7kaguPp3FZatzB9iBxoKV5V0/WtDYBj6smgRl37lHQ1znzi2kT
	 wdcs2z1hWgmxIjPXqHz1+QATFM+FcdSvL30rdVUISHqLJsDZiKVEwolRCESS47XgsX55e
	 iFV25HCG7OhVUEaKebks5niiLQ+E9kN1GqCBnqIRqWyI/V8WgP50ob7M2SvqrJlSJxrx3
	 KSPAeUlN8+RpcpU2azkUwLy3xsHCTR+Tt/NSjuZsQMmEn7czdceYKlWLM0afhyeHFkVSH
	 +wbvWtKzQo3kvdTxjgXjFyxl5ZDf6z+6REXxzyw+0psurpceC1aJD7LnjryUSFak2Pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lf47zUJY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F398606A31A;
	Fri, 23 Oct 2026 17:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lf47zUJY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB4441F01825;
	Fri, 23 Oct 2026 17:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792776194;
	bh=e9CHgVUiuUr9z0N9kziykHeUFdcQZLlPHyMU3G/0OGQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Lf47zUJY+b8Bje9PmDyS9i4Yc8Cek+co4EKCjYbZdpzfOTGDTk0E819ITQgyQPCEK
	 Gp67JgfrWhN5UOM+6B0GRm4Sz01NAbGpYEqRWjeshmcygRg7AsWpYmrU3LgCzeLSvK
	 hYUSiJXYoIc+PJfrrlBkqeo08CQpKxJpQA/FXSVr9nf8mMEUPrbLObZDZ7OWK2QTNB
	 wdt9lg7gC+ArwBFseNv/svO2YbDqY3uqlNsF7NmQ1Pzb0GdhieySORaNVcGLiqrvIv
	 UkOBGnixkH+OCKXAS0eY29y/1i4FRnwHtJ7u6Ae9lc1+or5zyuA8rdEpEXwQbzbBRO
	 6L0H0EhazrSGw==
Date: Fri, 23 Oct 2026 18:23:09 +0100
From: Simon Horman <horms@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: mhun512@gmail.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, ae878000@gmail.com,
	daniel.machon@microchip.com
Subject: Re: [PATCH net v3 2/2] net: nixge: wait for DMA reset before
 releasing buffers
Message-ID: <20261023172309.GC888721@horms.kernel.org>
References: <20261018020840.3851552-3-mhun512@gmail.com>
 <179237585255.3135.18388695192416186276@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179237585255.3135.18388695192416186276@kernel.org>

Hi Myeonghun,

On Mon, Oct 19, 2026 at 02:10:52AM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 (3) · Medium: 1 (2) · Low: 1
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] The patch only partly closes the hole it describes.

I believe the issue above was covered in your response to the AI-generated
review of v1.

https://lore.kernel.org/netdev/179108725013.434549.7036380491047031962@kernel.org/

> - [Medium] One reset timeout in nixge_stop() now disables the port for
>   good, and nothing in the driver can recover it.

And I tend to think the above is an intentional implementation trade-off.
But could you comment on it?


> - [Low] On reset timeout, nixge_stop() now returns the error from
>   ndo_stop (line 959).
> 
> Pre-existing issues:

...
