Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048787;
	b=yNV/VOBayJcii2Xbozvjz4+A/dn0MsoxQiUWZpAGFTNvc6bseDp89z+voKt5jo5PvsY8
	 0ctl6b8kacz/GjUGaBdzy8xiDWWoSUWPmeR7NS0d5Lv/g/4InDhL+v5M10knDESwprcRx
	 zWgPuYtxTb8hx1FlQXfw8d4e+ZxDpyNTVjFL5xLIRteD8X220uEI8U0zIqPpJ0qAuHsP/
	 XH63M6aT8x5kJWC76p//qRfO0BxDwaUKrevG5AuKEevtM/t2xbZDTzJ4zGJA9BTotxGyI
	 GUWI6RgHiN5jMa2g4L1p77MrzZ4kHHt7OyBEZncclzGSxJ8jtf+8CN7Ivm07lUEtGgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048787;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=eZM++BX8xZsQxJCDpXHirlsgqErEbRg0Tg12fOOlkHk=;
	b=L5Uk2kIjSYIqgI/VuHMrDjEyT3irdjCeNlIiT3K7XccDc5zgySZGoZH3vL5CFl/Tpl0/
	 lezlQq2ERneULmsHVy76ijyXJh6X0LJAudm03JFmUWiAS0qBjZ5ZJijaiJTpLSQGz0hL/
	 8zG0CmbaZyadRXEnzJ32NgYTyvhHTD60acASL9qTU6xH1D1pvVzkEUWzcEG3nvZo35FWH
	 Du7cpCS7wATOSlEh3pAHTsBupvbNB6WYiNujhJSg8pwcLeagXY0avA3hYzi2nUKYxW+bU
	 hDSgbqzj1oCCNjAaYkv9K+Iks2+aJm1RX2cIK5DZMd8/1mwpVSTzFQRsihZ8SMks3ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cJ353Bxl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D52D606A32C;
	Sat,  7 Nov 2026 10:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cJ353Bxl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E2EC1F008A1;
	Sat,  7 Nov 2026 10:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048787;
	bh=eZM++BX8xZsQxJCDpXHirlsgqErEbRg0Tg12fOOlkHk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=cJ353BxlPZRJTNd6rvdHQc8v05Ocp2yXR7njFSjrKT1hsN5XJ69HQGcpfV9AZkwgr
	 5T33vlNY56aYvWv0RHbo0RYQW35bleti2pfCo/Q3tjqXJARzm5lYi6IDB9Xp7o66ZA
	 ANPFw2brmHTMOBLy2uoUxHQ2/qWuluJomhw/YFbiKfCBhtLZyNGpZCkQsqbY8Gqan9
	 l47TMr/BynWhWAeS2YvhettkwdKv8VKfm+5q5YqsLcT5VNHZmQdVTTfEw6tX8Xoj19
	 A7AlAa9Vii4Zs78wsKmE1TCsQa9eid5r/myWUmuhY4CaciNK3/gfEUm/xHvF0pDevw
	 OSgSbxfqfYoJA==
Message-ID: <4a0a327e-10b3-491e-8eee-12e72e71629b@kernel.org>
Date: Sat, 7 Nov 2026 11:53:01 +0100
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
Subject: Re: [PATCH 3/4] arm64: dts: cix: fix I2C bus address and size cells
 on Sky1
To: Gary Yang <gary.yang@cixtech.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Fugang Duan <fugang.duan@cixtech.com>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 cix-kernel-upstream@cixtech.com, stable@vger.kernel.org
References: <20261107011012.3655873-1-gary.yang@cixtech.com>
 <20261107011012.3655873-4-gary.yang@cixtech.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <20261107011012.3655873-4-gary.yang@cixtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/11/2026 02:10, Gary Yang wrote:
> The I2C controller nodes inherit #address-cells = <2> and #size-cells
> = <2> from the soc@0 bus, but I2C child devices always use a
> single-cell address and no size. With the inherited values every
> child node triggers a reg_format warning, and a device described on
> the bus would be decoded with the wrong address layout.
> 
> Set #address-cells = <1> and #size-cells = <0> on all eight I2C
> controllers, matching the I3C nodes that already do so.
> 
> Fixes: fad32e8ac460 ("arm64: dts: cix: add DT nodes for all I2C and I3C ports for sky1")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gary Yang <gary.yang@cixtech.com>

1. Fixes cannot depend on the driver.

2. Also, explain what is the bug here. Your commit msg has absolutely no
indication of the bug.

3. DTS cannot be combined in this patchset and must be split. Don't mix
patches from independent subsystems when you send something explicitly
targeting only one subsystem.
See also: Documentation/devicetree/bindings/submitting-patches.rst


> ---
>  arch/arm64/boot/dts/cix/sky1.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/cix/sky1.dtsi b/arch/arm64/boot/dts/cix/sky1.dtsi
> index 0a820f45feb9..a18e8fd43fcf 100644
> --- a/arch/arm64/boot/dts/cix/sky1.dtsi
> +++ b/arch/arm64/boot/dts/cix/sky1.dtsi
> @@ -290,6 +290,8 @@ soc@0 {
>  		i2c0: i2c@4010000 {
>  			compatible = "cdns,i2c-r1p14";
>  			reg = <0x0 0x04010000 0x0 0x10000>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;

How is this a fix? Really.



Best regards,
Krzysztof
