Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795257824;
	b=IJVc0FVAIeNaFYOQ/Tk6z6oemuUeKOqLHkVm4oq3oPHMHCa6MTay0Hsipgv6zv7T29FN
	 wlKVS//q+ZgFQNdCf8XVGQjHGjIjQuhIRAud3U93rlPzH5RrUfMahqsyzPcjERQ/B61iy
	 njbN8O0Hyf/4EQlBwVKhbQ2PZ0Y1PN3hmnvFzN7i5iMMn14FsX0MBpZqu2OmbdUWX+iFG
	 A/xs+/I4XewKCUkT2ZkZNUDH7EVPaK0h1/uTB5x2+/UG6ivOuPzMQ83k7NUQ+jQAxpy1K
	 RxJks8RFi6KwfmE8jp0M/AimQ9kAz1hsh/j5BVGDWtKGHRfawJROEXSD/4LGO48t6BQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795257824;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=5qFrHybFgn3xA42XyK9cEuXKRJg4yf4XyYywjW290pU=;
	b=tB3ZWAu32BN0YM9NV05zyqyBFwpmLmZzvsgxmGGkKFRhnWjGDVBnOnazCPHLHIw4RmfU
	 dHCz9GWE/jCcaY6wxRIxrIi9D5lbPX1Ov9xM7t1qzGY0R2CEe/AeT7K7kc5pTT4eBT21Q
	 MVQPCo8ywQB1uB0ZyK1bmoPDVME/90329bTlvcfYX2BG8doZB4xEFULplYl3DBVyE4O/z
	 1ExGw9nGdcDgDyxmB1oXsymVWBTUtiX4OMR+pbt724UzOZ3dVhj1EcLtui3AoOffPn1GC
	 yyFkmWt2GaKqq23pkvIAUB2nUHTsCkXlQt/+fdkYvEc1zfM9swEv1fBHnNhXZGupjqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mCyJLkO5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B23606A320;
	Sat, 21 Nov 2026 10:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mCyJLkO5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3114D1F000C6;
	Sat, 21 Nov 2026 10:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795257824;
	bh=5qFrHybFgn3xA42XyK9cEuXKRJg4yf4XyYywjW290pU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mCyJLkO5qU1yecQLntXP9mZJ02uePt0B2S82MR7Q1IojntTzrqruWZ5Oq9DqfYFTS
	 WXWRJ8744YfWdqNDKhyrhNwwT1chaU1ZLJ5cZ8U4uC4canysDHdCY2fjIdp3Y/loJv
	 5aBfnnGGAgjFD7uc5sVwKJgMBAsddij4MoYTGZDioZN2D5ftBFIu27rmygsGdOZNo8
	 W+lPIPvXUqmpEHG5B70JRrAgkfB5S5rHRby8+/ZBugd6jt5TYP0WrMnGf4mOVk3pgo
	 xvvhzn0sxGLQib98lxRgZcNKE7/eBuq+5vws/nHZWIl/KSg4xRUXB1cJ29naJTVVhL
	 kackkBgXVImow==
Date: Sat, 21 Nov 2026 11:43:40 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, =?utf-8?B?QW5kcsOp?= Apitzsch <git@apitzsch.eu>, 
	Luca Weiss <luca.weiss@fairphone.com>, Daniel Scally <dan.scally@ideasonboard.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Hans Verkuil <hverkuil+cisco@kernel.org>, 
	linux-media@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: media: i2c: dw9800: Redocument
 DW9800K
Message-ID: <20261121-judicious-vengeful-ant-f9bcb1@quoll>
References: <20261119-b4-dw9800k_cleanup-v4-0-df26c431595e@fairphone.com>
 <20261119-b4-dw9800k_cleanup-v4-1-df26c431595e@fairphone.com>
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
In-Reply-To: <20261119-b4-dw9800k_cleanup-v4-1-df26c431595e@fairphone.com>

On Thu, Nov 19, 2026 at 10:51:23AM +0100, Griffin Kroah-Hartman wrote:
> The DW9800K's properties are too different to justify sharing the same
> bindings file as the dw9719, Create a separate bindings documentation
> for the Dongwoon Anatech DW9800K with its updated properties.
> 
> More specifically:
> 
> The DW9800K did not share the SAC1 and SAC6 modes
> that the DW9719 used.
> 
> Description of vcm-prescale does not match the calculations labeled in
> the DW9800K datasheet for how clock diving rate is computed.
> 
> New property timing-control introduced to offer more fine-tuned dividing
> options available to the DW9800K.
> 
> Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
> ---
>  .../bindings/media/i2c/dongwoon,dw9719.yaml        |  1 -
>  .../bindings/media/i2c/dongwoon,dw9800k.yaml       | 91 ++++++++++++++++++++++
>  2 files changed, 91 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/dongwoon,dw9719.yaml b/Documentation/devicetree/bindings/media/i2c/dongwoon,dw9719.yaml
> index 8e8d62436e0d0c4f9af9e52262b23881abd37cec..38db0764c0f70ad49295dcddc182b7e100a68b29 100644
> --- a/Documentation/devicetree/bindings/media/i2c/dongwoon,dw9719.yaml
> +++ b/Documentation/devicetree/bindings/media/i2c/dongwoon,dw9719.yaml
> @@ -21,7 +21,6 @@ properties:
>        - dongwoon,dw9718s
>        - dongwoon,dw9719
>        - dongwoon,dw9761
> -      - dongwoon,dw9800k
>  
>    reg:
>      maxItems: 1
> diff --git a/Documentation/devicetree/bindings/media/i2c/dongwoon,dw9800k.yaml b/Documentation/devicetree/bindings/media/i2c/dongwoon,dw9800k.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..99f3b506cf12c63ddef1e3d18fd59179a5e7800c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/i2c/dongwoon,dw9800k.yaml
> @@ -0,0 +1,91 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/i2c/dongwoon,dw9800k.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Dongwoon Anatech DW9800K Bi-Direction Voice Coil Motor (Bi-VCM) Controller
> +
> +maintainers:
> +  - Luca Weiss <luca.weiss@fairphone.com>
> +  - Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
> +
> +description:
> +  The Dongwoon DW9800K is a single 10-bit digital-to-analog converter with
> +  +-130 mA output current sink capability, designed for linear control of
> +  bi-directional voice coil motors (Bi-VCM) in camera lenses. This chip
> +  provides a Smart Actuator Control (SAC) mode intended for minimizing
> +  mechanical vibration.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - dongwoon,dw9800k
> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: VDD power supply, can range from 2.3V to 4.8V
> +
> +  dongwoon,sac-mode:
> +    description: >
> +      Slew Rate Control mode to use: direct, LSC (Linear Slope Control) or
> +      SAC2-SAC5 (Smart Actuator Control).
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum:
> +      - 0 # Direct mode
> +      - 1 # LSC mode
> +      - 2 # SAC2 mode (operation time# 0.48 x Tvib)
> +      - 3 # SAC3 mode (operation time# 0.72 x Tvib)
> +      - 4 # SAC4 mode (operation time# 1.20 x Tvib)
> +      - 5 # SAC5 mode (operation time# 1.64 x Tvib)

That's ABI break, although you explained the reasons, but ABI was
released and I think this can easily support older ABI while fixing
things: simply use old values without SAC1 and SAC6.
OTOH, how did DTS work with value =2 (so SAC1) and =7 (SAC6)?


> +    default: 3
> +
> +  dongwoon,vcm-prescale:
> +    description:
> +      Indication of VCM internal clock dividing rate select, as one multiple
> +      factor to calculate VCM ring periodic time Tvib.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum:
> +      - 0 #  Dividing Rate -  2
> +      - 1 #  Dividing Rate -  1
> +      - 2 #  Dividing Rate -  1/2
> +      - 3 #  Dividing Rate -  1/4
> +      - 4 #  Dividing Rate -  8
> +      - 5 #  Dividing Rate -  4
> +    default: 1
> +
> +  dongwoon,timing-control:
> +    description:
> +      In LSC mode (252 + value * 4) * divider value in microseconds
> +      In SAC mode (6.3 + value * 0.1) * divider value in milliseconds

This should use property units, so microseconds.

Best regards,
Krzysztof

