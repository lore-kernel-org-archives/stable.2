Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793963768;
	b=0kPpOIiIh07HzZnTNpkWGL8hmkh9jL6v9BvS1NvXz7gNzy9uZpAPjG4frhqdpfUZtTL9
	 C9Km53Rw9YXKXbDMFl/egP2EAhO7xO5qdrXcnnsFF20JdfrS1JGGbG+6J41+GDK4RAmeF
	 2fIO/b/Bln0OK0a6JbMwQy5uOrH1gzj4/+Oh3lo4PO3Z6CfBH/0DHYsu9ib/IakA4JTli
	 jVIAVMbjv8WjtDeaCbzNT+WkMcjIfSrzKE6HWj5wZDgx42WtLki7xkXp8+WlZ/Ms8K+09
	 Vcr4LkG8YD8+rweVlTeCmIoXgE2iFebUxrc1A6Os9QhYjRP5i39JucfKFyznD9jM9FQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793963768;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=wbqbZlCH7YXcVsufdxHlWbVJML/TMT3EJO6Q4weCv7o=;
	b=l1oXmPo6riSBs/ysjHJxWGKWt8rUtae6/Q7YYxUpTOe68oX4NHEn5CdrhVIfu4ZoPBOw
	 FpRZYRT9oS+WAkzIHm1vcEpYFG+BUDTBxUtS1vQHYvrcg/YKTum2CUcR41iVBYnaRopw7
	 6uki6mPIxFpJNexJgYbOTBOosnzXzGJc91aFdnO+2w/5EUtdaVdxGVX0KfLd36wBWvA5M
	 +AoVOtXSQ+qVp8WWnlEr9VuEOWsRaHfVVo+6KTF0K62oM4PLLbAQjGcvwNlPTflG50JO2
	 u/Cikj22sRl50LFCXcXHTrlS1rG1xJWiZpmhbHLic5ZyHSE4ANFSnMW5jwGqJFjN5XQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dO6W+C2v;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAEE606A32C;
	Fri,  6 Nov 2026 11:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dO6W+C2v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D331F0089F;
	Fri,  6 Nov 2026 11:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793963767;
	bh=wbqbZlCH7YXcVsufdxHlWbVJML/TMT3EJO6Q4weCv7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dO6W+C2vZVjfBxkb094IePRjcbEh9989thGug6bb/G63BtQ6kCSRD200KjL+dc4sM
	 1zYW2eJn7N3kQzs9bSCGopMIWJuNyL8oMaJfECNmoFgTAnTOtuqqPtdjVUsLTgJ1i7
	 yMy6hZzEUH0PlfaMVV07FAC9gJE8v55hyZBngniY0c1lyza/uAb4G13FjHb0a+wfs4
	 mtrMecqNiA+wJd9ZanP/ZzuIj/la8B0BxAgAClPTSKY7zUUDXJIHs4eZU6L6bAjS0c
	 RDarZErMJYsXhzDjLPZ1JoU38IzG7v3XBBP1Qu8ajb2KS54rxPG+HR2jbGjOmoEjGs
	 Y6l7rnGJU1OIA==
Date: Fri, 6 Nov 2026 12:16:03 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>, 
	Conall O'Griofa <conall.ogriofa@amd.com>, Jonathan Cameron <jic23@kernel.org>, 
	Salih Erim <salih.erim@amd.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Michal Simek <michal.simek@amd.com>, 
	Andy Shevchenko <andriy.shevchenko@intel.com>, stable@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: adc: xlnx,zynqmp-ams: limit
 external channels to 30-50
Message-ID: <20261106-funky-dainty-puma-c6bd43@quoll>
References: <20261104164510.105359-1-kapoorarnav43@gmail.com>
 <20261104164510.105359-2-kapoorarnav43@gmail.com>
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
In-Reply-To: <20261104164510.105359-2-kapoorarnav43@gmail.com>

On Wed, Nov 04, 2026 at 10:15:00PM +0530, Arnav Kapoor wrote:
> Channels 20 to 29 of the PL-SYSMON block are its fixed channels (PL
> temperature to VCCADC), which the driver always provides. Only channels
> 30 to 50 (the differential input, VUser0-3 and VAux0-15) are external
> channels that can be described as "channel@N" child nodes, yet the
> binding accepts any N from 20 to 50. Listing one of the fixed channels
> there only makes the driver add it a second time.
> 
> Limit the child nodes to channels 30 to 50.
> 
> Fixes: 39dd2d1e251d ("dt-bindings: iio: adc: Add Xilinx AMS binding documentation")

Drop, no bug is fixed here. Driver should simply not register such
channels second time, so it's a driver bug, not a binding.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

