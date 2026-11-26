Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795720222;
	b=riP7LJI1YNSVrnQq/mzLIRb5GTi2PUQs4mLhjU7MLCHRE6foi5F5OLcO5rFszgSpmfor
	 G6a2mTLMzNyirbXLyChjXeZfbymcBWgwxqD7sTboCZcJ3o+ONG3JvzDGVDHgwXqh5qJt1
	 HdtrII+iKSPQCco4hh+rfQgvTB3vojvUgHCgjxc5JJhHo7OOG/X5nWvzRtW4r0peNDSi8
	 Dx02ZgtTAMKVKXV9dx13RTRP+75ycvbMQjK1da2Xd+T4Od4+26SWEr6oZS4BkejdEy28G
	 drJQmlAGqNplbDuphV8xhZpMub9Ji90OVQ41MUEuZDURZbxkeUrYfgXnK4zOL890nFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795720222;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=TV32o9zQpYhUiUQjEmoO+2Rwd1ROxOgeiiHCRTH0FNY=;
	b=rvHHxTKFEVteHdXQt2q1GAUr06XtWIccTfqJ7AzLVXomP+rECbJ2HR/+kDXMZZeXpF4H
	 cOgYXpfEwZwY9jlteo+H3S3LaeEO+MbKHeGNZRlYT8h6GliWJyWzqSgph2XBUTasERXnW
	 N3W2EfWKXvy28v0GEoNIpFnNsc1dK4xBG14hykHDONpfw1DXOdClxdxZPq/loDH5hAq9O
	 XlB4XvNGuCkkTLLa6jQDwCl9mG5f8iIaX0rhsKxRgyEqQH+f5Dkke2PV261mMx1cydUd1
	 i0JDJA3oCtxfWs2IzQZyZI7zd36g5jl4fVB/pxlqXWiSKmUsOHuKdZ8mIe5PLj4k1+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A98G2EOQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA44E606A31C;
	Thu, 26 Nov 2026 19:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A98G2EOQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF4E1F000C0;
	Thu, 26 Nov 2026 19:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795720222;
	bh=TV32o9zQpYhUiUQjEmoO+2Rwd1ROxOgeiiHCRTH0FNY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=A98G2EOQeYjWwFMq51ltb6NEp5AtYeB4pbb9DwRwsR2W6meTrqjwdQlf0SwnKfRbh
	 7xSDDDHheF4WIVelq2m48qKw+uAicy2ZwFbrRPtWv8oP2CKs0ifTCcrOM+ZyuqNYXy
	 Vvv9kD1IStFotaC4U1xQcl7EDHawcOb8P7gs85E7TS/LcnWED8hA3vgd5bEZoDtj5W
	 +M2hzd51w386OzqmFnbEJ8GrOmFwFwyO1PwtHgu0dxDs91DCrHpit41RKe8TOE8feS
	 RbPjOke720OM4YfNu5thYDyifY9OpujuIM3etcjrpDFkIrWqM1BYUaVSpT/fz42l7R
	 nUmhFGowma3Uw==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Griffin Kroah-Hartman <griffin@kroah.com>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Joseph Telaak <joseph@telaak.dev>
Cc: linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-doc@vger.kernel.org, stable@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20261119-ktd202x-et6326-v3-0-98b836b1cddc@telaak.dev>
References: <20261119-ktd202x-et6326-v3-0-98b836b1cddc@telaak.dev>
Subject: Re: [PATCH v3 00/11] leds: ktd202x: Add Etek ET6326, hardware
 breathing and fixes
Message-Id: <179572021838.20937.4574539480025572624.b4-ty@b4>
Date: Thu, 26 Nov 2026 19:10:18 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Thu, 19 Nov 2026 19:07:22 -0500, Joseph Telaak wrote:
> The Etek ET6326 drives the status LED of the GL.iNet GL-SFT1200 (Opal)
> router. It is register compatible with the Kinetic KTD2026, except for
> the flash period: Reg1 = n is (n + 1) * 128 ms on the ET6326 and
> 256 ms + n * 128 ms on the KTD202x. Patches 6 and 7 add it with the
> KTD2026 as fallback, so older kernels drive it with slightly off blinks.
> 
> Patches 1 to 5 fix bugs that have been there since the driver was
> added, and come first so they can be applied on their own:
> - a blink shorter than 256 ms became a 16 s blink on 32 bit
> - with fewer LEDs in the DT than channels, as on this board, the driver
>   read past the end of its LED array
> - a blink with a very short on time was programmed as never on
> - delays from the timer trigger that add up to 2^32 (or 2^64) divided
>   by zero, and long blinks overflowed the on time on 32 bit
> - a blinking multicolor LED also lit its colors at brightness 0
> 
> [...]

Applied, thanks!

[01/11] leds: rgb: ktd202x: Fix the flash period of short blinks on 32 bit
        commit: 280cea5d04e30ca4be4f43a87e3fcc91a6cdb5e3
[02/11] leds: rgb: ktd202x: Fix an out-of-bounds read with unused channels
        commit: 8cc3cc7d69aebf33972f26a1087e47be56abf5ab
[03/11] leds: rgb: ktd202x: Never program an on time of zero
        commit: 8186b7a8675a76698c0dc8e168c082261a566c89
[04/11] leds: rgb: ktd202x: Fix a division by zero with long blinks
        commit: a6cb0f219dc69db535ba7325fd8ed915f2b82483
[05/11] leds: rgb: ktd202x: Keep the unlit colors of a blinking LED off
        commit: e99f5c1e90d29a8c2b8f0a3302d46e070a15bb99
[06/11] dt-bindings: leds: kinetic,ktd202x: Add Etek ET6326
        commit: 687bf2fbf1cb94d9339e6171e7e53ec5ae4bb1c7
[07/11] leds: rgb: ktd202x: Add Etek ET6326 support
        commit: 84c670760a749139d4c902f50a05185ab20bf2c8
[08/11] leds: rgb: ktd202x: Add hardware pattern support
        commit: 72609d1f742cfe2292d3eb297a4f5e1b9751fe0b
[09/11] leds: rgb: ktd202x: Limit the LED current to led-max-microamp
        commit: 264bad714fc2917560612183f2228305e555e86c
[10/11] leds: rgb: ktd202x: Fail the probe when the chip does not answer
        commit: ce4bd4b6e549ae034e3b0be3f5f126f82f15d304
[11/11] leds: rgb: ktd202x: Don't let a blinking LED retime another one
        commit: 4b39400401bc02c532977481344d0e54b166b9c7

--
Lee Jones [李琼斯]

