Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8ED45BD78;
	Tue, 21 Jul 2026 10:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784629478; cv=none; b=Zz+ZdbelINgWNEq2K8Ww5/k1wvJrojinOdVO3HNVxX+ss47frnAz8mEsKNFx0EfmwWahFkFwV2wRsTCNckBs6bcSpzml6rkjtC0LzMjBrFMqHmV7i8sHbPl1MvMdxuETO0hAoLQwXgYFVxEmxCUPtoxGYi8C2VofSj5UUkW7THw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784629478; c=relaxed/simple;
	bh=8kyVLgfefu/oT3YJXfkoO+ml1KqFnGihaI4aBgjp3CM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o1Ho3ffw8p+2urHg11YUIDVWs0eEbafdG4kQmWIFqwK0ADDCUp+wT7mInuD60Sx0hZYdPIoTA9AcssTmQHXeqGuo3EmiSc9D69wVMHLKIakS6J0BX6Q0OHekoc9YD22zm9m//sJuXmAVyNwe3T/n4Vr0MbQ1k+J4/3UpezAdiF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MUqoKZJh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MUqoKZJh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2BEB1F000E9;
	Tue, 21 Jul 2026 10:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784629476;
	bh=pT5BtT4gQxptRHiptEfDygJMcbVQACDKOZrYIYo2Zfo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MUqoKZJhjkN+nW9EenUQ+6WbzVhKeTDi3HFvsnl3gvkeitOUSgY0DQo2fk9S8Mj32
	 K6A+1UedsQZrmPRfj66hSvQ/HCcD+vTsLevGcQtzOlgOcUIWnPN+xlSVkwhexisx06
	 n9uZttZMPa88XlK2FFLD512x9628wJB5TpqFvK2xPPJPMF5kW1FVIv8Jy8s7O1MkGH
	 mgjujNCklUOKvLcS2JpVBRNtoGXkp88nXvNhV64WN8rjFPu2HGsaG6QMTvHSoZFXln
	 JdnaDquzwIARmH8CygsuuZ9ajboonUzIgMszY/wAzaV0fZbjVFmX0A05wTPJ/yWumE
	 IvtsAv/Fq6syg==
Date: Tue, 21 Jul 2026 12:24:32 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, stable@vger.kernel.org, 
	"Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH 1/5] dt-bindings: usb: parade,ps8830: Add
 parade,disable-usb4 property
Message-ID: <20260721-imperial-wrasse-of-pride-ac53f5@quoll>
References: <20260718-ps883x-disable-usb4-v1-0-cec86d0b909e@oldschoolsolutions.biz>
 <20260718-ps883x-disable-usb4-v1-1-cec86d0b909e@oldschoolsolutions.biz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260718-ps883x-disable-usb4-v1-1-cec86d0b909e@oldschoolsolutions.biz>

On Sat, Jul 18, 2026 at 07:06:29PM +0200, Jens Glathe wrote:
> Document a new optional boolean property "parade,disable-usb4".
> When present, the retimer rejects USB4 mode by returning -EOPNOTSUPP,
> forcing a fallback to USB3 + DP Alternate Mode.
> 
> Assisted-by: Grok(xAI):4.3
> Signed-off-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> ---
>  Documentation/devicetree/bindings/usb/parade,ps8830.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/parade,ps8830.yaml b/Documentation/devicetree/bindings/usb/parade,ps8830.yaml
> index eaeab1c01a594..44242907461eb 100644
> --- a/Documentation/devicetree/bindings/usb/parade,ps8830.yaml
> +++ b/Documentation/devicetree/bindings/usb/parade,ps8830.yaml
> @@ -66,6 +66,12 @@ properties:
>            Sideband Use (SBU) AUX lines endpoint to the Type-C connector for the purpose of
>            handling altmode muxing and orientation switching.
>  
> +  parade,disable-usb4:
> +    type: boolean
> +    description:
> +      When present, the retimer rejects USB4 mode (returns -EOPNOTSUPP).

You described the desired Linux feature or behavior, not the actual
hardware. The bindings are about the latter, so instead you need to
rephrase the property and its description to match actual hardware
capabilities/features/configuration etc.

> +      This forces the Type-C stack to fall back to USB3 + DP Alternate Mode.
> +
>  required:
>    - compatible
>    - reg
> 
> -- 
> 2.53.0
> 
