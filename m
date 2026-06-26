Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35339372063;
	Fri, 26 Jun 2026 21:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782510271; cv=none; b=Y2iGg5s4W7YwqT4tNJvaQjyspwH1/jgdknNzGxhiEpfr5D2RY+Fge7PEvrgAoy7UCJQVw9vnrIYw2BZRNOg3b3mzIRjwqTyROoNzjrQxP+jP7z/M/I44NvdCU5PvCtneyL8OJaoCuzBZljGf3DXW2GRp/p3Ha/7/L+K4Q2Z5qZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782510271; c=relaxed/simple;
	bh=nGXY2OWzFiqY2DwZxKwy0EflQ5luaLo56cujjqVw1Rk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=izNM1HF7ZzkRj4lfflPobfEGSYDhaszdp+ct6mUHgzoxNPRnJQR3vTDefHHQ7Y7qxBYAZNn5JWiy6Um4SrMdIX/cKxs3QsuA0R9gB6fX1sOxDcKGm7jMiTJyICOa3BbyguNvvONDXqRlbSxMD6y0wHfWSh+25LiZnljHcN167Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CwF7fkSo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CwF7fkSo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 021641F000E9;
	Fri, 26 Jun 2026 21:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782510269;
	bh=xqSusa91iwXAQMAzuUG88sce3Dd6CMB0xELPajKyb2E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=CwF7fkSorB1n5xBXy3lbh4qLVabQXotc/MtGWtuxNkREYB0OgluJ51i7Tps/1p+7u
	 Wt6149qnJ29Wh5baX7/1MWKZSdtqlDrBKLnqDSdIQV8PAddU6gSxsSEzAUmYBjqf7G
	 8lX3X8+RwtwpR1kc4ZroHKnBjFuZFN/0A54qVHalXBVtJls665uCnM9g1dQ3zQMoL3
	 vJAZrHlsUzFflz20IYSlp0nRiV/6qB6EL1zp0XAfi8lsyxlvFkEcSnKBD8hyAKAz5G
	 KCKQDrp48ftJCaLiz+sGCm9gw6yTVVy+aodO1AYFXWxclsaz5Lyco0GGD3pGz+N6P/
	 uH/6bi1JetG3w==
Message-ID: <6b4d641e-acae-4f53-840f-7ed4bfc25172@kernel.org>
Date: Sat, 27 Jun 2026 06:44:27 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: pata_pxa: Fix DMA channel leak on probe error
To: Wentao Liang <vulab@iscas.ac.cn>, cassel@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260625141837.62362-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260625141837.62362-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/25/26 23:18, Wentao Liang wrote:
> When dmaengine_slave_config() fails, the DMA channel acquired by
> dma_request_chan() is not released before returning the error,
> leaking the channel reference.
> 
> Fix by adding dma_release_channel() in the error path.
> 
> The ata_host_activate() error path already correctly releases the
> DMA channel.
> 
> Cc: stable@vger.kernel.org
> Fixes: 88622d80af82 ("ata: pata_pxa: dmaengine conversion")
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Applied to for-7.2-fixes. Thanks!

-- 
Damien Le Moal
Western Digital Research
