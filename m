Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793956931;
	b=rYsQiTEmYJsGSiAwbUmWGlvEOns0SlTEqTnXDdXOM/W7wBtcQCcEYWozt9Fi2Km7yssu
	 gxkkB5qJDHHcDJWs/LjzSs7APW64AC5VZMIY2qjTp2CDODyrmEPOMSfs1HTbfr5xflA1o
	 34bZ3XcERTMWzwImSpMPoG+nrHgJNoJcwfjGa6uOPZOLs1QHDWCS9GT0o+mwq2nrkmxQl
	 fyfjzEDtbzcWyx+c10vfMtYAw68Efzzjsza9rxqpsnZo9duunWEdWaGh8BU/FHRAe5NWm
	 CHpWry2/YJ7olPE5JJ/Inqt4CXlxZXd/JE+g0y9OOLvcZL43sSSenPKDVi63PDq5Qpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793956931;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=BK67UWeyDCYkVIdsN2UiQcCy7uNbGk0i6Dpj6j7cO5M=;
	b=hNDizjjB9qFPDNnl4vfu3cQU6iN+6StoHSldxfANKEW/pAxa8fyZmJxuxAXPNY4nj+fY
	 iybLKao0LP1jEvN1LeIr3U/KyTxsd+WwGjTKPEtTu1vr8LZsTaO0rfsw8MuGmm2FAAm6T
	 CYO7RnsNkIzJpXzy5AtJwE6UtraGiK82ol2oA2z+u4fz6SKMNV6Px88s+f6XrJ5Miqvev
	 4f6fpS2hUGxmJ8FkzgE9nxcMNiqBwKKwkigQhZYCjBGrDJVlbRcyx9Usa+oP+ORFfJYgq
	 NnYphnsRpVTAtLo4J7Ll/eywPic6HbZX95CG2rf51CWwoQO4m6U4LD/4xwA10oxVTPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TbevARwK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id C4DDE606D815;
	Fri,  6 Nov 2026 09:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TbevARwK
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id E78581F008AB;
	Fri,  6 Nov 2026 09:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793956930;
	bh=BK67UWeyDCYkVIdsN2UiQcCy7uNbGk0i6Dpj6j7cO5M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TbevARwKj03Idms0HL0Vf4StM+AvKFmGABtHRc9fLJYptaU5MXjyG4PFu0c5Wvahu
	 7QkGaO8YEoVPmTRIHQXW/AURaMl9dJCJMUi77sPXxdL4tuzmWdODFTO/IJwIKxXch2
	 BeIkhAsvRK7n071pWasKGZeYR/WiCntFX1dN+Y6AezvZ53/psQ4fZ4IGE0yjqjDOQ3
	 gOSD0dA2gp8CRBnXnn1turpZCNPTlBNGF5GtPwu14/TnFgNx22wURFVQrTPTRtdDQ/
	 J3S2kTOYLMEXRUOfpUdZg+1Enj97eg7m6lUELbS2YN746KlMFLpIDGqRzWGqStpjfX
	 EJUj/cEgDnQaw==
Date: Fri, 6 Nov 2026 10:22:07 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Linus Walleij <linusw@kernel.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] gpiolib: synchronize updates of descriptor labels
Message-ID: <zgvjoccnnhhjmlejoazmz7mpfmndbhi2filwbtudq5i6s46boy@szoywmokacny>
References: <20261105-gpiolib-set-desc-label-corruption-v1-1-fa84726ceac0@oss.qualcomm.com>
 <auyYVmSaLBS--52n@ashevche-desk.local>
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
In-Reply-To: <auyYVmSaLBS--52n@ashevche-desk.local>

On Thu, Nov 05, 2026 at 04:53:10PM +0200, Andy Shevchenko wrote:
> On Thu, Nov 05, 2026 at 02:23:45PM +0100, Bartosz Golaszewski wrote:
> > desc_set_label() swaps desc->label with rcu_replace_pointer() but
> > without any synchronization of concurrent updates. The swap is a plain
> > read + write: two threads can observe the same old label and then call
> 
> s/call//

Why? It's "call $function_name" which happens to be call_srcu().

> 
> > call_scru() on the same SRCU head corrupting the state of the chain.
> > 
> > Add a spinlock to struct gpio_device - we're using a single spinlock for
> > all descriptors as using a per-descriptor lock would unnecessarily bloat
> > the size of the desc array with very little chance and no consequences of
> > contention - and use it to serialize the pointer update.
> 
> ...
> 
> > -	old = rcu_replace_pointer(desc->label, new, 1);
> > -	if (old)
> > -		call_srcu(&desc->gdev->desc_srcu, &old->rh, desc_free_label);
> > +	scoped_guard(spinlock, &desc->gdev->desc_lock) {
> > +		old = rcu_replace_pointer(desc->label, new,
> > +					  lockdep_is_held(&desc->gdev->desc_lock));
> 
> Can lockdep_is_held() return anything except LOCK_STATE_HELD here? Or is it
> checked outside of this scoped_guard()?
> 

No, but I'm doing it for completness and to self-document the intention.

Bart

> > +		if (old)
> > +			call_srcu(&desc->gdev->desc_srcu, &old->rh, desc_free_label);
> > +	}
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
