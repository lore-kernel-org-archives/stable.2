Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF676526A98;
	Fri, 18 Sep 2026 21:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789766871; cv=none; b=KtLtOnfjtu16SLYq/DCLpGdvZk1kvAmB8DAdiLC7w5OVz40egBmEMfECyWEUeWrm/PKMtcOhRN285WVorTzq+uHBRHPJEKd8G7COki01qXy9YacI+oF76OtzRU6ae2zjNfqEngzT5GiWmyPiXBqe3Y6dHrDjKQqY6bbfDFNw2lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789766871; c=relaxed/simple;
	bh=4joJeY/FhxP8hbD2+CVa7nwQDJAssnMbgl6m3xljYmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ejoqiOHRqa4tCuYVSqHJPKUzmRIXH5YsByyuIThEo7An0uGyKmHgCvIx17d6vuMo3CfRMPOlaQLrosVCpPiB7yQNc+e0iuxNu/McZw4lhHlSUt1h6/m+obWQcc0Qh4PlCB3Y3QEiwU6VFNDTbEATckLic8lOTXIRvrkn8rO2hsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nymUY77y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nymUY77y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 503B81F000FF;
	Fri, 18 Sep 2026 21:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789766870;
	bh=AAWyuctPVywEaJDhqz0fxjr2xNWHTqfUBZJQEGLZ6wY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=nymUY77yDFJa5HAS10PSXfm3EaoZh8KmMuLNoI3wRYm0WhtvKUA1mEvA7GH63jW5j
	 7THcOvJlWJDSjuNxf3IiSe0D4Lui+0f3IPHuQO9aum0ZcJWEZwsspa2CuPEpPWM5Cp
	 COaFRUUX2z/CH8lRErPX28u+jAoB148i/Wx4N1P9YKc7wBO8LzPEjcUsTpjF5tB8tt
	 D7fDYF6gw7/eVUqyhicJYM5awpKVlqvmebBpD4Pt4Vk0tQhzgrEz9rXGo7wLqrc30+
	 XTgAvJbs80xnExZ00mmcwS2wvXJHWZ7oy/1a3AtNd2/AHJoOpUoHtsbfeNFZuewnCL
	 bMZL+qRIJXuvg==
Message-ID: <b178b943-fbb1-4653-9dac-8821addbfa23@kernel.org>
Date: Fri, 18 Sep 2026 22:27:48 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmem: core: Fix nvmem use-after-free in nvmem_cell_put()
To: Wentao Liang <vulab@iscas.ac.cn>, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, miquel.raynal@bootlin.com,
 srini@kernel.org, stable@vger.kernel.org
References: <20260917123344.2151268-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: Srinivas Kandagatla <srini@kernel.org>
In-Reply-To: <20260917123344.2151268-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/17/26 1:33 PM, Wentao Liang wrote:
> __nvmem_device_put() drops the last reference to the nvmem device, which
> runs nvmem_device_release() and unregisters and frees the device, but
> nvmem_layout_module_put() then dereferences nvmem->layout on that freed
> device.
> 
> Call nvmem_layout_module_put() before __nvmem_device_put() so the layout
> is still accessed while the device is alive.


This is almost 3 or 4th time, am seeing patches from this email,
repeating and sending duplicate patches with out checking correct tree
and without checking mailing list.

Please do not waste maintainers time.

this is duplicate patch of 5b6b6fc49189

--srini
> 
> Fixes: fc29fd821d9ac ("nvmem: core: Rework layouts to become regular devices")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/nvmem/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 311cb2e5a5c0..4df7efde2cd2 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -1593,8 +1593,8 @@ void nvmem_cell_put(struct nvmem_cell *cell)
>  		kfree_const(cell->id);
>  
>  	kfree(cell);
> -	__nvmem_device_put(nvmem);
>  	nvmem_layout_module_put(nvmem);
> +	__nvmem_device_put(nvmem);
>  }
>  EXPORT_SYMBOL_GPL(nvmem_cell_put);
>  

