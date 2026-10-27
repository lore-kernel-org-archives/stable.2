Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793118209;
	b=dsCPve19oGisteI3QXD1HxwYsSReI4Nd45U1GDE7r1lbjtoSJth0N2dZ0albMKt/gyLZ
	 X/zeducZWSgK7g2/QzJHsG5wQaZO0Cue8ESQDtZmgXXNMKvDqrGdKA4lxyR9uXkSx4dxS
	 ZGpAegrfz7spSoN9gRcxUcOQOzKzxtXKPqNpo0xK3rUnPgQBzJh2Zb+ZdxD0/dimQXJNI
	 cm9UqaV3k7eMoiU9T74bMc3rsC7Zq3sEXNHxA6b4XSH0dkvUxG0nPJmIM5kC1Zo22SPH+
	 tBBQJPPV/ZUOuhz5jTEdesRmYFjywfgCdihxplmQbDv2ONv8BoZ8hMEmIyIi40c1Kxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793118209;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=mNMwuXSQRXxNMG3rtdBhKcCiulBVAGeYSZyqVQf8428=;
	b=gf3DiBLkcwpNVd8p6gv6J2zZAcNafbzmc3b4RLE8fBQJZnIKwU0qRp4DZzRbnrXdUAs3
	 IiXha4F/+zRmzBYD2fUIRUyzP9nZ3u3pNG/h6khxsJp6+ymnmnRH3cscLYLB9YKQn8wMl
	 WYWYTPm5BP+cr8y0K+UAwc2Faqf61+cu259/SuAE5YTimzYEqfo9OEM3CjiPZYbjwXc2M
	 +nx+RnrSqOGxpo/2mcLdh+umsciscb9ldJLIh9b8X6iDEmG/6BBscQJT9Lt5vVdfvCDqu
	 nfMN6/kg2fNcMAgD9c40u6xGfElO+iLVny5C+V1muzO2WWj5RM7Isk235HCz54S81Yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ft5ZSqBt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CAA606A31A;
	Tue, 27 Oct 2026 16:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ft5ZSqBt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C6161F01829;
	Tue, 27 Oct 2026 16:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793118208;
	bh=mNMwuXSQRXxNMG3rtdBhKcCiulBVAGeYSZyqVQf8428=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ft5ZSqBt/6XSO/DXyV0jaof13uIDBHdK2olt6i4yhJ4tTgp+A3csICEJLwmPExrbf
	 bgpFl4YzWX79DPsPjph1VKWGWwao72ybjGbYwsClNXCe6/b1xcOG0QLif9TdowYzhD
	 4/1qlE0TdpdPT9AtBZ/3ReO183Sn+6epYCRE8BOKUBYd0cCDwrxWbdDpo94v15gewE
	 oWTPRI3dPFq12OiUIGo/6CNRzdc4Zy/TgWT4tJN/gyzBAv+vzrNsnRs3Pt/TFJLEWU
	 cMdcRcw1skz3kjK2T/Xn/7HceXCyA/3VoWhBF/6LtJtkmYOAgODoW6uDHtZ+0FrsUc
	 s12al3r3ya9ow==
Date: Tue, 27 Oct 2026 16:23:24 +0000
From: Lee Jones <lee@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	John Stultz <john.stultz@linaro.org>, mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mfd: hi655x-pmic: fix IRQ action memory leak on removal
Message-ID: <20261027162324.GI2195460@google.com>
References: <20261027024609.117371-1-lgs201920130244@gmail.com>
 <c04f2ba8-fc83-4118-a26a-76ea8cbee518@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c04f2ba8-fc83-4118-a26a-76ea8cbee518@kernel.org>

On Tue, 27 Oct 2026, Krzysztof Kozlowski wrote:

> On 27/10/2026 03:46, Guangshuo Li wrote:
> > hi655x_pmic_remove() currently removes the regmap IRQ chip before
> > removing the MFD child devices. regmap_del_irq_chip() disposes the
> > child IRQ mappings and removes their IRQ descriptors.
> > 
> > The hi65xx-powerkey child registers interrupt handlers using
> > devm_request_any_context_irq(). During child device removal, the
> > device-managed cleanup calls free_irq(), but the corresponding IRQ
> > descriptors are no longer available. As a result, the allocated
> > struct irqaction objects referenced by irq_desc->action are not
> > freed, causing a memory leak.
> > 
> > Remove the MFD child devices first, allowing their device-managed
> > IRQ handlers to be released while the IRQ mappings are still valid.
> > Then remove the regmap IRQ chip and its IRQ domain.
> > 
> > This issue was found by our static analysis tool under development.
> 
> More of postings by bot ignoring any feedback.

What did I miss?

This person seems to be answering to my feedback:

https://lore.kernel.org/r/CANUHTR9B84LoCjOtS5N5qGO0KXSXUbZkrKZ3_GFTwXmVoPQ0SA@mail.gmail.com

-- 
Lee Jones
