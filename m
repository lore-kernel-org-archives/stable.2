Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795622501;
	b=AJOzksNZWO3IJ+ud3ppbXqO/JZW7d95HsvjVB+z3F0BJ96nF+DhkpG+lrt3toL3j/dq4
	 CLt9CtjGPk4mUM2XNs2lKp7NGyvB7/QN5FAGFhtZh5Wzlxxt5smErhxtkx7MOmqg89Nfo
	 r30Dgz0SOM3YnfKaWI9LL7TuvUUy9+C0kr/2iys9QFFR8Y3YQVWB9nXdcpzxToqlCXSDF
	 Wg6hGQEkAYN2LuXuwMTPc7NfRDK5ETz4N2Oey4U8JgAadwEHdzP80b/KN3+I5Gklv4Ok3
	 Y+TReO34c/5BQXMKJ2NhsYUdDCLvHI3XivnMPFaS+He57eJ8t1fXJMLALUoq9vrPLUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795622501;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=KpsyoMrq8QFDKuaJNC38lM4n/9s4W8IMaJXnzULPzCc=;
	b=snqnFUxXq2nLnzSOCdz9vr9dwDN20nP8/xmcRXf/uI60HTRpdGH1p2KRhirFPVtVZpkc
	 cLxTzYTqVr3+j4xv+LvK/jxxUy3uj5g613VYQ2/OUzY6ZQfezIZBNpRv8UkZJxq6uFwfn
	 o8RL7RyWyAEYBjvReJGGJ/yLA4edujrihlcRMY137xfs7aVZ9qrU6V6AFM0cyD56N5F3N
	 QKcG0cHqY8S3g4ZjlXVYWBP6GIJoCvqmlAt2qbyQ2+FfVfcIdXA5wJvw8/VrxkJY/yZKK
	 LDevEIxTAqc4HAeqy2it/naFlxLX0t0C5fFofgR7av6Hq1AVFgdBbht56W7q6zW9A2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HCuiBrPV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 2BFCA606A329;
	Wed, 25 Nov 2026 16:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HCuiBrPV
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id DC1A71F000C4;
	Wed, 25 Nov 2026 16:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795622500;
	bh=KpsyoMrq8QFDKuaJNC38lM4n/9s4W8IMaJXnzULPzCc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HCuiBrPV+Vda2f9OpEln1OADkYjDim7ja1XnIebWLpOEW3hUO4OyKj0hISym0fZvX
	 zL+GDpjPfphxsEu8+JnQN7DDWvPhvC70xccRlp2J4wVi860m3Jk5Pu4VscvBEyK2Un
	 nHuo6vneKOZL4oP2C7vcaiNIbJbf2zEQE+YEmqQOBlZIGon83NLu+cElvx5Ox/N1ak
	 oOqGBLAc8r0xPC/rOOrBVQV1bs3Of1aWAp0d2Fnn9j2VzZA0115nJTsTUrxn59UK8k
	 2fBVHLmvalW1IZwDk3Q2/MXaL6Qwu1CfUCzHqVIB7mCKAkrfG3k8xNYH3YrU82mWsV
	 fDi88CDW3CZBg==
Date: Wed, 25 Nov 2026 17:01:36 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Srinivas Kandagatla <srini@kernel.org>, 
	Khouloud Touil <ktouil@baylibre.com>, Linus Walleij <linusw@kernel.org>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] nvmem: keep write protection disabled while writers are
 active
Message-ID: <cifzn2uoh4lvfuamvezuthqcebz2oz7eqdldnbln6untros5f2@oav3dnjjiv4y>
References: <20261117-submit-nvmem-wp-serialization-v1-v1-1-539d121f8f5e@gmail.com>
 <8c0a616b-e7a5-4043-bc86-3bee5d0c9e48@kernel.org>
 <p4nohmtiuicrys4i2ipwstdjt7sj3g2yyli4beygutkyn5ghky@d54oxjwiyzm4>
 <CADvTj4ou6+gg8xK4p9623xr=mZecmrgPpV76pU_-h=qS23UUrg@mail.gmail.com>
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
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADvTj4ou6+gg8xK4p9623xr=mZecmrgPpV76pU_-h=qS23UUrg@mail.gmail.com>

On Tue, Nov 24, 2026 at 09:48:31AM -0700, James Hilliard wrote:
> On Tue, Nov 24, 2026 at 6:04 AM Bartosz Golaszewski <brgl@kernel.org> wrote:
> >

...

> >
> > Well, we have a use-counted gpio-shared-proxy, but this addresses real
> > hardware components sharing pins. This is a case of "logical sharing"
> > where you have a pin requested by the subsystem, which is then used by
> > multiple consumers. Normally, we do this at the subsystem level, like in
> > regulators - which BTW probably suffer from the same issue - but here
> > it's more visible and more likely to be hit.
> 
> Both NVMEM writes use the same WP descriptor. They look like one
> consumer to gpio-shared-proxy, so it can't tell when the last write
> through that descriptor has finished.
> 

Sorry if I didn't make myself clear, I didn't mean we should use
gpio-shared-proxy here - I meant, the "logical sharing" doesn't mtch the goal
of gpio-shared-proxy.

> > We can either address it here or we can possibly introduce a use-count
> > helper for GPIO descriptors at the GPIOLIB level and re-use it in
> > regulator core. In that case, we'll still need serialization but I don't
> > like the idea of using a mutex and holding it over the entire operation.
> 
> The posted patch drops wp_lock before calling ops->reg_write(). The
> mutex protects the writer count and the GPIO changes: the first writer
> finishes deasserting WP before a second writer can enter, and only the
> last writer reasserts it. The provider callbacks can still overlap.
>

Thanks for clarifying, I got confused by the usage of a non-scoped guard()
but it's in a dedicated function.

> One detail for a shared helper is how to handle a GPIO error on the
> last user. regulator_ena_gpio_ctrl() keeps its enable count if disabling
> the GPIO fails. In NVMEM the last provider write has already finished,
> so we return the error if restoring WP fails, but there is no writer
> left to count.
> 

Right. Maybe it is better to fix it locally for now.

> > How about a read-write semaphore, taking it for writing, checking if
> > we'll need to set value and keeping it for writing during
> > gpiod_set_value_cansleep() or - if not - calling downgrade_write() and
> > running the actual nvmem callback allowing for concurrent operations as
> > it is now?
> 
> If every writer starts with down_write(), a second writer still has to
> wait while the first holds the downgraded read lock across its callback,
> even though WP is already deasserted. Did you have a way for that
> second writer to take the read side directly in mind?
>

No, you're right, we need to wait until setting the value is done.
Nevermind that comment.

With the above clarifications:

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Thanks,
Bartosz
