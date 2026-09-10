Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6CB513565
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 16:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789058965; cv=none; b=UK3ENXW6psM0/eewNiKBZt3Wxuf9HhfSssvC6GCOKpfTtnBP26gvEcUT6udDn54xQyhH+CuUK6NEYfOHECP5bEaPfaJDJr8nQnO0h+FW/fHtqoq94zIIkTSZ3jcE83p43N0nPFSGiyQg8Udh2aC7LvV9GIqbilrJQJDvlkQQBx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789058965; c=relaxed/simple;
	bh=et0IgSAi65WntaNByaMxMnNVQe6qfEdQwD5tqMZuHTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AefX1XphLWapIAWqxYgolUQ12KfQpkktLwJCzQOM4B4Kmr8XduSQC3Mi+dRR6CJTokq7XmhxtTiQvKu7p59DfJFL1n8t2mozXcvoBm03PricpnXSK1rd/MUVwNvtpKoSHXMX4o5OlqpjXGkpgxr1WHqnNAsMLbxpMIK7OxZ7SDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pardini.net; spf=pass smtp.mailfrom=pardini.net; dkim=pass (2048-bit key) header.d=pardini.net header.i=@pardini.net header.b=SRnYUbHo; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pardini.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pardini.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pardini.net header.i=@pardini.net header.b="SRnYUbHo"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6a0de062db5so11274886a12.1
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 09:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pardini.net; s=google; t=1789058962; x=1789663762; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=trXMroz5mGRhnvsqxF0GR3hfGr2ispYPFG7I9RaBuY8=;
        b=SRnYUbHo7aDB9qNwRUFjDbMAwui3H40oD1onMYwI1gpayJaSnAfFuRDBzlF4gPvlFy
         jj2fbeha677dIuoVZcn3XP0oiO40vfM/V4YU1MuViYuGljApvrz602lvh/FbPyGl+zcD
         fUWe7ivp73W1vein78q8BJPCNDianX2pd4qUnxVKK7etnaxLKVeK78e5K3KZU8THhS/8
         ld8wyGx3PP3G8HTbBIhqKidnIk6IhCAqrG8ZrKtQhSVQmbmlfjW45F5PhXo/zrJ6QxzI
         UMSAnzEwimnT5ECaRZvTFeMuisW9rVDWFsHOjhvLFKBfNmO/rReYFJCBuwLmbyocJNNI
         Pdrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789058962; x=1789663762;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=trXMroz5mGRhnvsqxF0GR3hfGr2ispYPFG7I9RaBuY8=;
        b=PWTjuLj44lvrA68Kbg9aohM5fdBQAczgACaIua4QAQxr6rjKFw+turdBBeZYx/drFx
         z/HYhRd/aVJqdHQHhG/4UxCwByGKitXxHpzQi4ISjQGqq9LVl7FqLUpZkeeepapqvSLB
         IDeZjHjwHMDGdmuYe7JIFCLmYg9xjtysS6wEqh5R2nqmTqStJu746C2zzZp0z5GZWTsC
         kWzoIcL+oKwboBTW9TCBxtHtsUiSSakQr/zouB9ZhQRU1jdc0x1AMiB+NEVhKr3EcdUK
         I5+Hb2JwKz6xNKD0mbt6L+9COWny6RkhBmeJkluuScZfyo8WhDoJZWicfWN5kzxLH4Pq
         qP5Q==
X-Forwarded-Encrypted: i=1; AKwUvBwDo9hYkMNDvZDp+AhpH2xmZLGbuqYAxyl7k7sOwZqjSVAJ15P1xvFMw392E0u1HidbEudehkE=@vger.kernel.org
X-Gm-Message-State: AFuF++kupHJhkn5d6un/n5PhW6sXAjp3aFOEEmGND+ECxRlXMxnLCmqt
	p8Br7o15wNqEs5FzHMgOTKtwv1MTeayo2A1yYj72Mt9B75dw6F1e6iPX5oA+PBYVhQ==
X-Gm-Gg: AYBFou1CK26PfNtSq+mnCY3CVRFtNYRfXm7sUSB8Whoyv2DgZUhkwbsVz3x2ibu3z0r
	xI2XW1XDS9+eNAsBv9FUjCSnYV8hIY5f9KNnJko6ShpYCDnhnKgAOiFRjRQZW8HRldjPWknomoL
	8dsqlTCSVYAj5hfx9ma4WVKKig7ltY1BJVevdqJXYGcwkatuIjHlDRk5Btt4m8FgHQVki7oJJ5o
	fkG5VtWy5TcO7t0N9hXKeHUmsYlv67ANFSEU6P8SaZiRFyXvWyoQbYQ1l298r4uIWwql3DXzO8S
	ugnOgEGEyESsqM+MNij8rsdlaAvDIi+HvHIHIUZoSciqHtZL/ifTb3NQvT3sbaQEtz6N3xlmWRG
	KPUIMZwO8e4H5vA/zOvlyGzjkTdpE5O0YHXMBlI2CaAEXUxjz329EYisvg/EZ9Ypv5bDtVfCSUO
	zhE4PalnCwmMbqJ5zKL4IxCdPwsCfx01/7YsVyYamI8E/EBiUgtQ7XM/fND685EBYZTEvB+2qc6
	3fGeiDuEWc3fUcLBxnWFDKo9Wv2Ek1swmEWhQ7SNfwwv/0fQKHmrpc1AWi6bx+fL0pD12OyXlB6
	97fzynweQkxePVy2F/5dMLZUOA5faZyJO3wf14AAAYFcsLILICbtPFBTZA==
X-Received: by 2002:a05:6402:2b9b:b0:6a9:a3a4:797d with SMTP id 4fb4d7f45d1cf-6a9a3a47b3fmr2194091a12.10.1789058961506;
        Thu, 10 Sep 2026 09:49:21 -0700 (PDT)
Received: from ?IPV6:2a02:a466:4d7a:0:8888:6b72:e1ae:406a? (2a02-a466-4d7a-0-8888-6b72-e1ae-406a.fixed6.kpn.net. [2a02:a466:4d7a:0:8888:6b72:e1ae:406a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c294682fcfbsm143774066b.16.2026.09.10.09.49.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2026 09:49:20 -0700 (PDT)
Message-ID: <08011075-364c-4520-857e-cd1acf955b53@pardini.net>
Date: Thu, 10 Sep 2026 18:49:20 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] nvmem: Derive Rockchip MAC addresses from the OTP
 CPU ID
To: Alexey Charkov <alchark@flipper.net>,
 Srinivas Kandagatla <srini@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Michael Walle <michael@walle.cc>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Finley Xiao <finley.xiao@rock-chips.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ricardo Pardini <ricardo@pardini.net>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 stable@vger.kernel.org
References: <20260902-rk3576-otp-cpuid-mac-v2-0-e4b7fe2ab13f@flipper.net>
Content-Language: en-US
From: Ricardo Pardini <ricardo@pardini.net>
In-Reply-To: <20260902-rk3576-otp-cpuid-mac-v2-0-e4b7fe2ab13f@flipper.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/09/2026 15:07, Alexey Charkov wrote:
> Rockchip SoCs are shipped with a unique CPU ID in their internal OTP
> memory, and Rockchip bootloaders use it to give boards which have no
> dedicated storage for a MAC address a stable one anyway: they hash the CPU
> ID and patch the resulting addresses into the device tree they hand over.
> 
> Kernels started without that fixup, e.g. straight from the SPL in Falcon
> mode or by any other loader which does not implement Rockchip's derivation,
> fall back to random MAC addresses which change on every boot.
> 
> Formalize the derivation in the DT binding and add a Linux kernel driver
> implementing it, so that a Linux image can use the same stable addresses
> regardless of the boot flow.
> 
> Only RK3576 is wired up here, that being the SoC I can test on. Other
> Rockchip SoCs keep the same CPU ID at a different OTP offset - 0x7 rather
> than 0xa on RK3588, for instance - which makes supporting them a two-line
> addition to the driver's match table plus the layout node.
Hi Alexey,

I went off trying this on RK3588 and - exactly like you said - it 
translates perfectly there, just with a different offset. Thanks!

Not content, I went for RK356x as well - and that revealed what I think 
is a snag.

Both RK3576 and RK3588 currently describe their fixed cells as direct 
children of the OTP node -- turns out that is the "legacy" way, which 
works due to 'add_legacy_fixed_of_cells'.

But RK356x/3528/3562, done more recently [1], use a single 
'fixed-layout' with child cells; and there can only ever be one layout, 
so we wouldn't be able to use the new layout for those.

I imagine one way around it would be to allow such fixed cells also 
under the new layout, by delegating to 'nvmem_add_cells_from_dt()' and 
adding patternProperties with '$ref: fixed-cell.yaml' in the binding, 
similar to what fixed-layout.yaml does, but I'm unsure that would be a 
good idea?

Either way, thanks for this, it really helps with Falcon mode and edk2; 
I can also use it for the fixed-function RTL8125 PCIe NICs I started 
describing [2] (and will eventually send a v5).

[1] https://lore.kernel.org/all/20260312213019.13965-3-heiko@sntech.de/
[2] 
https://lore.kernel.org/linux-rockchip/20260617-rk3588-dts-rtl-eth-describe-dt-alias-v4-0-2bd38922d129@pardini.net/

mvg,
Ricardo

