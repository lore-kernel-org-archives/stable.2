Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793880223;
	b=NFFmtWYnYUA6szOoKisBYA2IRzcPT9CsdE6v1E0XFnPA4f308t2NznNwFWblhfIOQeL5
	 kHr4VPDyM8+jPh7LKIFaZKboAEMrQCYUYztNHGWVmTqXJWn39cDbuGKt8OnihgFle8Vo+
	 X0ftKdPeU7Xb+tKIRPMia3DTaFBZZOuKsqfO2cmoyqYVGfskIt6+H2H7taApyp16G3TZz
	 ppcyFOLkwYO7wm7XjpYYMgOMiVvAeGsLMzRxp9uZo3nWwfOz6+2LPYCV0O0/9L370gB1l
	 sd6dzTM5UP8j+lu7Ove7luvGVwaOCflNedNWF8aZTGnV8eBoQxySdBT+BPClceFBWNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793880223;
	h=Received:DKIM-Signature:Date:Content-Type:Content-Transfer-Encoding:
	 MIME-Version:From:Cc:To:In-Reply-To:References:Message-Id:Subject;
	bh=WGS1mz0b8oFaWIqUZVZWSLYtt5loWQVV/ILwaxsjzyE=;
	b=PdWNbQwNR178sX1QSJdx3wkwPpOCKq4tAzZEFDTQ45i++W0y8O/1IGcA6UCsz7Yw/PTg
	 Xb4JnH4Xj/rF9cSjFHFNP2+0U/V1hxueP1hzfJMSirjBidTDRGl31KauT2YXgGQEydzG0
	 wJFCxwH1ojBNvjmsGTdxydZEp7IClB3ezsQuRM36jGzjitVqzZcmaF323TR89jn4zo8JC
	 ZWVmWlggpHLSLpo9tWfj/Ys7vJZJZC8KsZkMnk2Sb9Oxs3aDvheXZCD3auGtIqpQci6or
	 0NQ1LJBZEX1chFw1IXmSS0HygI5Vw2KBoViwXFIdCSN4ArrTr96/ottUB2tSwr60FzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bjSyHRul;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995EA606A32E;
	Thu,  5 Nov 2026 12:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bjSyHRul
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C7F11F000C1;
	Thu,  5 Nov 2026 12:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793880223;
	bh=WGS1mz0b8oFaWIqUZVZWSLYtt5loWQVV/ILwaxsjzyE=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=bjSyHRulyxZsUrZW8blMgIH4KygL0S78OcETdG+T0UH+XIoDXwOQndon4ggfhHqky
	 /AncCoTir7BBXGVEAUIb+JGNqxMjcNFQIjIwnSfOWccYHS/fgLDfwViD1r13wUjDrV
	 MZLfQeYjrF1aZJN4hn1JMSsfY0LXkaLoNbuOmYHjXhnPa9gsxX5VBfi6Alod64HGbw
	 cPQCm263HqhzEf5d9+8opd+tu4OVeojhFHgmFbFYU2EBYY4220w+1mllTfmzNa3meY
	 sGk/dytjZY5tdAUPxDQZzwNYj51ydLZGwX3cqVYcUVO4JfmXJpem/xwFxpwAPAZngj
	 O8bTVHk64of+A==
Date: Thu, 05 Nov 2026 06:03:41 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>, 
 Hans Verkuil <hverkuil+cisco@kernel.org>, linux-media@vger.kernel.org, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Daniel Scally <dan.scally@ideasonboard.com>, 
 Bjorn Andersson <andersson@kernel.org>, stable@vger.kernel.org, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
To: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
In-Reply-To: <20261105-b4-dw9800k_cleanup-v3-1-6850ee6a5a5a@fairphone.com>
References: <20261105-b4-dw9800k_cleanup-v3-0-6850ee6a5a5a@fairphone.com>
 <20261105-b4-dw9800k_cleanup-v3-1-6850ee6a5a5a@fairphone.com>
Message-Id: <179388014029.1297019.12610765343474899975.robh@kernel.org>
Subject: Re: [PATCH v3 1/3] dt-bindings: media: i2c: dw9800: Redocument
 DW9800K


On Thu, 05 Nov 2026 11:29:00 +0100, Griffin Kroah-Hartman wrote:
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

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/media/i2c/dongwoon,dw9800k.example.dtb: actuator@c (dongwoon,dw9800k): 'dongwoon,vcm-presc' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/media/i2c/dongwoon,dw9800k.yaml
Documentation/devicetree/bindings/media/i2c/dongwoon,dw9800k.example.dtb: actuator@c (dongwoon,dw9800k): dongwoon,vcm-presc: b'\x00\x00\x00\x00' is not of type 'object', 'integer', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20261105-b4-dw9800k_cleanup-v3-1-6850ee6a5a5a@fairphone.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

