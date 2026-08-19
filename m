Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EC2420E9F;
	Wed, 19 Aug 2026 09:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787132548; cv=none; b=mESKe1NJsTSQqx0uO20FhnuwCKHM7COAFH8LhrsRxlb2jvtOp9IJuYojqvu6yiq/moE9WAzbe7pYs9rZRCE/YppIjFQa0YDMOC2isSE5PXJdmz7HdWg1sTy/xB8Dfs6NJzSCZPQ1Trpmn57+XNSy7blVgP75DkDnLY3V+RuRg6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787132548; c=relaxed/simple;
	bh=zteeWIqYiqlEBM+S8vDpVcNY3BE/YzVpPPwlswyixwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GBKjzEvkQiYyh8lBdkkAxtOIHSrWLaV0vMdY1LdN7mJItc+TSwvye11/dj5BJwqrpuJkhZmMFFeBxgr9/Wd/IMWMI6I27cFxHfVr9LgWEHQ7lxxjvJdJcxpW5zELqfczSNzJBrgN4CqYVwFBc+fgBIGKT1OMsFEMijGFCjYiIQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CsUEYzzW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CsUEYzzW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D2501F000E9;
	Wed, 19 Aug 2026 09:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787132546;
	bh=Gf0KuFmSKTNqCEIxnMS1RISpHG0M34ZcMXhe1a9iApw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CsUEYzzW7TnoCO1AT4j/E/+8N7DFlBpUheWzZr8EvTw90yUyDQlf1lumrLmK3YbMV
	 Z4pcm1TtUrgNdwqGFLWnYnzHbl425b9gaVzFs0WSFcNdfSlI+83yLH3A8lwgFv2s1J
	 CiUO9vQ+vKfNhrocQEe2zZ1hC7iwCrd5y6vC1kAaGqUuTr9MxnDXpYjNj4ZwGzbyA4
	 jh+nAdi7+ze3f0APyxRYSJ2hmlo3JA4sbsiqxR4a15pSqBmhwn6mWw6a6ZkaC/GNLy
	 OYY/nHFHkNU+ucbubuRa/1YcdvmOT1lwBrVM8rvMil4RJG8xIRWtNXHlrtlYOh0FIO
	 UeLND1xWta4XA==
Date: Wed, 19 Aug 2026 11:42:23 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Georgi Valkov <gvalkov@gmail.com>
Cc: briannorris@chromium.org, johannes@sipsolutions.net, andrew@lunn.ch, 
	krzk+dt@kernel.org, francesco@dolcini.it, johannes.berg@intel.com, kees@kernel.org, 
	miriam.rachel.korenblit@intel.com, wenst@chromium.org, rafael.beims@toradex.com, 
	avraham.stern@intel.com, error27@gmail.com, s.kerkmann@pengutronix.de, 
	gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com, robh@kernel.org, 
	conor+dt@kernel.org, Frank.Li@nxp.com, chunfan.chen@gmail.com, 
	linux-arm-kernel@lists.infradead.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v5 1/3] dt-bindings: net: wireless: add flag
 marvell,ignore-regulatory-hint
Message-ID: <20260819-generous-nickel-dalmatian-b6bb08@quoll>
References: <CADOrJmbTyrGGkq+9OJDXCgTa2HvNo8BWxoE6yjafcrOq7WNamw@mail.gmail.com>
 <20260817215428.84740-1-gvalkov@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260817215428.84740-1-gvalkov@gmail.com>

On Tue, Aug 18, 2026 at 12:54:26AM +0300, Georgi Valkov wrote:
> 
> diff --git a/Documentation/devicetree/bindings/net/wireless/marvell,sd8787.yaml b/Documentation/devicetree/bindings/net/wireless/marvell,sd8787.yaml
> index 930b700b73d0..5f235cb9f3e5 100644
> --- a/Documentation/devicetree/bindings/net/wireless/marvell,sd8787.yaml
> +++ b/Documentation/devicetree/bindings/net/wireless/marvell,sd8787.yaml
> @@ -59,6 +59,12 @@ properties:
>      description: Calibration data for sub-band 3 in the 5GHz band.
>      maxItems: 502
>  
> +  marvell,ignore-regulatory-hint:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Ignore an incorrect regulatory hint from ROM,
> +      so userspace can set the correct regulatory domain.
> +

Same comments, so you just ignored entire feedback?

Again: you need to describe the hardware, in commit msg, in property
name and in description. You cannot tell SW what to do, that's not the
purpose of bindings.

Best regards,
Krzysztof

