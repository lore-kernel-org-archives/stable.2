Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794084227;
	b=vjDqYhbHHr7eBpVBDEuQmOXTPhm0sz6qsOIeegVqF0S5wUGSlL1pev6LMxQ/XFbRxbUx
	 L7ftj+4dttDX8fwXuxrhb5YXidzXd3oxw+h5U4dXb2H7YhRKXD85MX1TrW0/Bf2umazEA
	 4H6dkXCiV50YhUlbQSo7LJw0EUDPnerjrHCSKa/qu4Ljne2OQFl6Rw+kDWeaZ+yBZ281K
	 hEhi2Sop6Zr5Piz3hSG6M6W0n+9JMMaIKYGOjAIpOCd3c7Vva2xqbv/WWvo8gmuZ3OJqJ
	 jONPSX29gTq4Gwh0VBRR2RkXYPoN/p+0X6k8zKqO3ogW26r6pAsVMMg0RCUlS6riuHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794084227;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=xIJP/ux0u2zudpHSHBN3zgctS50zYkGAb3SzJpj0v60=;
	b=DOUU1II1nOjfg9iri/q+0JwIT+v/8t0+eZXUJF5MgfTEoj9opIA6qMLAR+Q96cCb5XqP
	 cRfSg49HF9iyBtFM3k4/q62LO5d6Kj1Tua1Izsk7oeOej1UTqU9GuzALAJo3alvlOk8wo
	 Q56hhk5f2BmfmAL1FyKtOPQ4ry955Ukt/FFKFMEdux3IZrJcoFYlcdqzpmkKzYnTvQOCc
	 vDXWGVj4T8HT9Yl0o56u41kcArp9Wzj5kRDuzPnnOkaV3dXNDO1Sr3JzV+cDN1iMYO7cb
	 fHjSvBqC2sNJRO7PS1uxGH3MNPlhSvMvVF27qIyB4pOA0Sj4TpnKMWMUGX7oCu1TxsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M+X1Qp2M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DED9606A326;
	Sat,  7 Nov 2026 20:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M+X1Qp2M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3DD71F0089F;
	Sat,  7 Nov 2026 20:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794084227;
	bh=xIJP/ux0u2zudpHSHBN3zgctS50zYkGAb3SzJpj0v60=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=M+X1Qp2MqP3zYUYD6309po4giUA4YS0ZDStqsnfzwZcAmmQCrqcKt6s94A2e5FQqk
	 3vygZ2+LcYgFDNYRd55jBzgAQQUuXC7EbCLqW58ObeCfkrwHiiMDOacRqLPdQNw2m2
	 jYPt46CupXaDMm3RrfIIjVKeoq0LX/8+u4ebkGPVOzdaklcrVgI5AZyRniVaGzAqYN
	 XdO8wXEFUCkudScu1VDf7OxnHqV3ZexLikZrtLUBB3DBzKSMJkXaYi8o0wjvgsJasb
	 HOTqkART3+P+yH6uImF3aJEX4+ftFHMkLvi9Q3Fr08affb8aAprixKWh4T1NADjlqJ
	 L+h4Il2mIsEnQ==
Date: Sat, 7 Nov 2026 20:43:42 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>, Conall O'Griofa
 <conall.ogriofa@amd.com>, Salih Erim <salih.erim@amd.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Michal Simek <michal.simek@amd.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, stable@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] iio: adc: xilinx-ams: fix out-of-bounds accesses
 when parsing channels
Message-ID: <20261107204342.4ff7487e@jic23-hlaptop>
In-Reply-To: <20261104164510.105359-1-kapoorarnav43@gmail.com>
References: <20261104164510.105359-1-kapoorarnav43@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  4 Nov 2026 22:14:59 +0530
Arnav Kapoor <kapoorarnav43@gmail.com> wrote:

> The driver sizes its channel array for 10 fixed and 21 external PL
> channels, but accepts external channel nodes numbered 20 to 50, and it
> never checks the remaining room while filling the array. Channels 20 to
> 29 are the fixed ones, so listing them adds duplicates and overflows
> the array.
> 
> Patch 1 limits the external channels in the binding to 30-50, as Sai
> pointed out. Patch 2 does the same in the driver and adds the bounds
> checks from v2.

Applied with the fixes tag for dt binding dropped.  
Note I'll take this the slow way so this will only merge next
cycle.

Thanks,

Jonathan

> 
> Changes in v3:
> - New patch 1: limit the binding to channels 30-50 (Sai)
> - Patch 2: only accept channels 30-50, so a channel node can no longer
>   duplicate a fixed channel (Sai), and add a static_assert() that
>   ams_pl_channels[] holds the fixed plus the external channels
> - Patch 2: rework the commit message around the duplicate channels
> - Rebase on fixes-togreg (now on 7.4-rc1)
> 
> v2: https://lore.kernel.org/all/20261023185652.195025-1-kapoorarnav43@gmail.com/
> v1: https://lore.kernel.org/all/20261021225356.625288-1-kapoorarnav43@gmail.com/
> 
> Compile-tested only (W=1); I don't have ZynqMP hardware. dt_binding_check
> passes, and rejects a channel@25 node in the example.
> 
> Arnav Kapoor (2):
>   dt-bindings: iio: adc: xlnx,zynqmp-ams: limit external channels to
>     30-50
>   iio: adc: xilinx-ams: fix out-of-bounds accesses when parsing channels
> 
>  .../bindings/iio/adc/xlnx,zynqmp-ams.yaml     |  7 ++-
>  drivers/iio/adc/xilinx-ams.c                  | 57 +++++++++++++++----
>  2 files changed, 50 insertions(+), 14 deletions(-)
> 
> 
> base-commit: c293f0db308fe76a0a9b0f6674cd2dea149b03aa

