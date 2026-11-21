Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795257454;
	b=ndaTWQLfb2mpIfMmoiCP2TQLRhaJUzlce0SQ7sC5edlYAASbzGYcgtvV0In/5OspYlxc
	 AR1TDpypFWBKUgvj1vKLf++cXbtEJducKHKv9eFrjsGcPaeZDv8fuVzTmC5mKMMdk1X/H
	 NRcE/qZUmivUMG0iT4daeGLLytdPh6DMT2p8FOi6tHlV9anoFxTJBi7gmLADvNtrukm+k
	 1WeMWb4YXsEA+TLiLQaC32oZbm8OPJIvtTQAAuFF5SvQz9J4NDZP9WggiRPwdfvib9ICU
	 5dusoqCAibNjQVAlF/ASpOXmEH38jYUV6ik/60OMb0fOHn7EV20ilYhOKhhBsVfcUcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795257454;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=vgbZcP15nzhX4TU9itRCl8mUynOAxDJsEFuECV83UHk=;
	b=jCVBVLyhw34pac9bW0A+WLgmeDI0+Ql+HZe4R9YtrHCn1r9PLgkctc/fwzowc1PnvxUU
	 l6AfR+WiIo2wxnfhZfPPW90tFEfDRpPSegOl2OCixgbY+DpLtaPi+kEiLIL8jVFr4INyu
	 7HJb/u1OeXRlzWxIMFojhHhE3hqLgXYpxOocpPcg1QRr8C7jochFBayVNUS+cXJXSpNCF
	 mKPszgo3Qsdw+WuAUDzaU2yBzK87Lzc8wHt9kWVSr52ijtAHzD2rUXmiiCo2TAF4bcvyA
	 YH2cfkXihuEjLUplkjL0QBIK6WANBt0wDVbKBYxVuRj2lrv0CO3f3cVljEd1xRR5IzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GwYNcUeO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8AA606A332;
	Sat, 21 Nov 2026 10:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GwYNcUeO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88FB21F000C0;
	Sat, 21 Nov 2026 10:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795257454;
	bh=vgbZcP15nzhX4TU9itRCl8mUynOAxDJsEFuECV83UHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GwYNcUeOo/2yEunNuuHg8zjTDzp1JwtFCzYWYJ26itRi2nLyAeH/TWMgSL/hwEnLz
	 BKGjonAJ/kjbn5K2VraDDh7jJzZpS0U32s1FZgbTjG+uR9gMC+Kv03agohc6YnPCLE
	 KdsBz2jFhpbV9e7PTMbdv00LmeuaT7NN+va8twDa5AG5E7ucL5GxUWy/0ejgnxJMqO
	 JZGm35u0rQZyjrhUUU76sxfpfTnaQZL5kg1TLxi1wPs171t5je8l/oeVY6Q/8Iam8X
	 0D5zWFpTU1kYcb8unYUqnfM2e37bvUtq9JQNe5OZJHPMMrZ1ILSFzn1s+ycAcosRqB
	 tb6XMVZKSBiHg==
Date: Sat, 21 Nov 2026 11:37:31 +0100
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
Subject: Re: [PATCH v4 3/3] arm64: dts: qcom: qcm6490-fairphone-fp5: Fix
 DW9800K support
Message-ID: <20261121-magnetic-boobook-from-jupiter-a79b77@quoll>
References: <20261119-b4-dw9800k_cleanup-v4-0-df26c431595e@fairphone.com>
 <20261119-b4-dw9800k_cleanup-v4-3-df26c431595e@fairphone.com>
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
In-Reply-To: <20261119-b4-dw9800k_cleanup-v4-3-df26c431595e@fairphone.com>

On Thu, Nov 19, 2026 at 10:51:25AM +0100, Griffin Kroah-Hartman wrote:
> Update the node for the DW9800K for correctness.
> 
> Now we correctly select SAC3 mode and enable timing-control with the newly
> updated device tree bindings.
> 
> This is a breaking change for a part that was previously functioning,
> but only due to manual register writes in the driver. Now that we have

So keep things without breaking them. Keep proper manual writes for old
DTS.

Lack of datasheet is not a reason to break working DTS, because if it
was working, then missing docs were not so critical.

Best regards,
Krzysztof

