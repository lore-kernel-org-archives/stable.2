Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A757A39DBF9;
	Thu,  4 Jun 2026 18:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780598296; cv=none; b=Ykh2pq+hFnVj7eUlemZHngBkPXCWsr72x/vF4Jf4NoBwxlMb87D/tL8KEUecLVd5vqHRx1WbH5Lnd3uy88iRtaIiEvC4t1lXfRIO4i+gTegX1ACPac8uZ1disiRpWksKarWIxDjA/h71wAkI1Tw06icZxTVVo+9EH36Emhb0nvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780598296; c=relaxed/simple;
	bh=nvYUXkfDK0Y+2JTGS2nXWF1n/TpKuLyIUK0lVQFHunw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nktm0RBPDBv1zvtBwbQeY1N2lINxdnX7VnKzHtB0v00qhwGuxdHdUecXfZGFeer7tSYBZVFMcIl88o/2Jf+E/s+Offmu5hP1AuUJKlfok/G0JCGdUaLPbuNR61zSKp5FudVUwpTtZSbJnePdok9UJXYNa52UvgNDPnnHBiXtqXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dvg9CaVt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dvg9CaVt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25D1F1F00893;
	Thu,  4 Jun 2026 18:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780598294;
	bh=g40q2WcZX+txbiJLhCakWPgHdl3H8ExECh2BVSyQZ6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Dvg9CaVthlf48311aTtg/33nEoFiSccwVKxZ9vCNOLLP2B/NVYDGrT8S4XUJ0Dt86
	 /R/Oimr6FThgLrSCZmR7bv4iRHLSzP65da5lEypnLMzKgBzP/z4LfRgUtIQGWGy31y
	 StE5wTRXOzCDEStDjsTJEkMHwetdG8Ul8qIbRwTk8Jkk5uj8+fcGhLVUQ+YglfGKya
	 EFi1t7v7tGJr94xz19/HbhiQay0miooKrwD7+OzXdLzaKjsuxVUaUYroJLo2ibQP1w
	 ATUTvJuom4hlJAt7+Qi/IPeFcuo4FkUBp97hqpnQUt6JGzxUhm7aaxzZZANmOVYuoE
	 JG8HMadAd36gA==
Date: Thu, 4 Jun 2026 13:38:13 -0500
From: Rob Herring <robh@kernel.org>
To: Hongliang Wang <wanghongliang@loongson.cn>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>,
	Andi Shyti <andi.shyti@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
	loongarch@lists.linux.dev, stable@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: i2c: ls2x-i2c: Add clocks and
 clock-frequency properties
Message-ID: <20260604183813.GA982803-robh@kernel.org>
References: <20260604015848.18643-1-wanghongliang@loongson.cn>
 <20260604015848.18643-2-wanghongliang@loongson.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604015848.18643-2-wanghongliang@loongson.cn>

On Thu, Jun 04, 2026 at 09:58:47AM +0800, Hongliang Wang wrote:
> Add clocks and clock-frequency properties to examples.
> 
> Cc: stable@vger.kernel.org

Not stable material unless there's a warning in the example (and there 
is not).

> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Hongliang Wang <wanghongliang@loongson.cn>
> ---
>  Documentation/devicetree/bindings/i2c/loongson,ls2x-i2c.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/loongson,ls2x-i2c.yaml b/Documentation/devicetree/bindings/i2c/loongson,ls2x-i2c.yaml
> index ee09c6d9c5f0..0beb7f2515c8 100644
> --- a/Documentation/devicetree/bindings/i2c/loongson,ls2x-i2c.yaml
> +++ b/Documentation/devicetree/bindings/i2c/loongson,ls2x-i2c.yaml
> @@ -37,11 +37,14 @@ unevaluatedProperties: false
>  
>  examples:
>    - |
> +    #include <dt-bindings/clock/loongson,ls2k-clk.h>
>      #include <dt-bindings/interrupt-controller/irq.h>
>  
>      i2c0: i2c@1fe21000 {
>          compatible = "loongson,ls2k-i2c";
>          reg = <0x1fe21000 0x8>;
> +        clock-frequency = <100000>;
> +        clocks = <&clk LOONGSON2_APB_CLK>;
>          interrupt-parent = <&extioiic>;
>          interrupts = <22 IRQ_TYPE_LEVEL_LOW>;
>          #address-cells = <1>;
> -- 
> 2.47.2
> 
