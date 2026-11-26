Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795713027;
	b=1j+RuvSj1O5LHCvkSwVbhJ7jiEj5SJsmcN2MKKITi0rdH5QkbVAsOhWkly2PlsbKrRs1
	 HaS+xL7KUeVPzx/W6tEEr1k2PI0DiDOgODwk/uvJcZw/1i2F7g3xXkcQz4ybRKOnlaUeI
	 j4gkWsNZWQCMVkmGl9Tx7rCT5P5TQxa5oa1LW0NBkWHDyb2ietDUVBUGKrfmPCljrebU7
	 dunweJquNzTQeHC+wThkfpnyIhZZ+HmIV5TDhG4oUdyupNpxVH4cFfl+8uKDj/0n40Urq
	 PNxMOmxsuU3Q+Gl75xgEKKKunU7w6Q39y4dj1fq4HhoJQkzZcJAgCbly3cllzN/9Arw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795713027;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=FyyXaulDNsV1sLugG5jJc46SYf72/gB7nyQwyq3TG/U=;
	b=B0QRkhivCX0Gh9hWgfv/Yaobn1zDxLSBp4RrxMWE6PBxHFRjjIlByixW3pCRhfQSVzGc
	 lii0nm0TVn/QgWUIy8f4Fs7dMoY/WwMqXEHGrLxln4KIa0kH0hxr/x7j17foLucmi2fxE
	 2mFnUaxXGPMUCFOBhJac7e9M22Vgv1rK/rE0mvEoASGP60ubtHu9ztG8oM9ZIo6QmV/Vm
	 1eMJzzCW7K2ipkas/FmQuzZmrwYnnPHO2mG2Jrs57QheUWIYYGSVrrGHuSKQhj5+cBEvr
	 U2AaSUq5bKyYJiTm4QVtrhViY9QRMYOIENDoVDjED0Ws6oooGYLmQ3q+1VmfCXyiN2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R1cWSuSl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2316606A31C;
	Thu, 26 Nov 2026 17:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R1cWSuSl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84DC21F000D2;
	Thu, 26 Nov 2026 17:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795713026;
	bh=FyyXaulDNsV1sLugG5jJc46SYf72/gB7nyQwyq3TG/U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=R1cWSuSlgpdW+Jd9ZN5+vSRFQrgmabxLkV5QxePCtX9eaDMwpUIiY7JpE3pnDmQL6
	 pIxrqcirhLpEsIEFK1V8hz7s9z+An/QtB8OUBuyywTndTeCuGWs5APvZkeTJPDsVQa
	 C+lCfMIYQDOxneNk2Az/BAmSJCsg5KlemO4Z4K7JuH/+4bY0ev3ld5VIIy4YQObu9W
	 ojm6apMtqR6zyiVzEMLzTr8c4lq5lFtuwG7RcJ82/IxhS604UeXQPjqcpJkr6qWzTB
	 rUBFZmCC4pIsR0AsnU7NqcMMozLms1oUJ6wHz/HwZa5+H09d2vfNEy96Z8HmhwtllD
	 dY9+kWUPz97Jg==
Message-ID: <d2cc5da0-fc31-4565-8cff-cb505bd1d3eb@kernel.org>
Date: Thu, 26 Nov 2026 19:10:21 +0200
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 03/14] PCI: rzg3s-host: Don't mix goto-based unwinding
 and cleanup helpers
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 robh@kernel.org, bhelgaas@google.com, p.zabel@pengutronix.de,
 geert+renesas@glider.be, magnus.damm@gmail.com, claudiu.beznea@tuxon.dev,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, stable@vger.kernel.org
References: <20261019065025.2146539-1-claudiu.beznea@kernel.org>
 <20261019065025.2146539-4-claudiu.beznea@kernel.org>
 <179562484639.5580.736218629244331876.b4-reply@b4>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@kernel.org>
In-Reply-To: <179562484639.5580.736218629244331876.b4-reply@b4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/25/26 18:40, Manivannan Sadhasivam wrote:
> On 2026-10-19 09:50 +0300, Claudiu Beznea wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> rzg3s_pcie_probe() releases the sysc_np OF node through the
>> __free(device_node) annotation, while the rest of the function uses
>> goto-based unwinding. According to cleanup.h, the two styles should
>> not be mixed within a function, as this makes the ownership semantics
>> hard to follow. Drop the annotation and call of_node_put() explicitly
>> on the exit paths instead.
>>
>> Fixes: 7ef502fb35b2 ("PCI: Add Renesas RZ/G3S host controller driver")
>> Cc: stable@vger.kernel.org
> 
> Is this really a stable candidate?
Indeed, will drop the fixes tag.

Thank you for your review,
Claudiu
