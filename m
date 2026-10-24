Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792809280;
	b=oXLhXg6EJUXVpQVTMXRMDp7eSZGVArvKrwjDfoJethGrS1/w+Knc+VJj6Y0Sc3+quP+u
	 1oNojBZvZlUXDG9nWlAx0j+/Pue7mppPLzVxFbDG6qwxmWWS5iYlSwcMKyJTT/uy5OUxc
	 bzVHyLg0GKjeLIQl81Syf4LFpUlZ+e/T6SFce2JmQmxj/1QUtMvnPzUWqU7O48F3V81V2
	 m6kgwdy4zWj5pvL5hh1+gWOHoTyxCuMvLztbGwQvaGivhjS1V45jHiC8QLvotldrDoWnq
	 x7t0a8ctWW6EBeHU1Evq4FOPuAsuD6jt30LbC8iAjf4hPH6aZdjYe8+DUu7FAHg3UYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792809280;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=M5JU2/erofEbew8NRNDAiKyc3fsrvlFDG8suS9hpCgE=;
	b=tsEw1qFYtoYUHtZEUJWcRyA28VmlVYQFSsKH3I1EVzRJ8Y29uzo9LY4xjEXjvHB6FEn3
	 fIrWIoQ9WPYEa2wvXtjiNIjOGevgfHskgxHbVzzQuYkECRItWsWvsk27evlpDcVBY29WC
	 2q+aJXj65TYggs+OTmlm//UrYGHXJNMZnaGAZ3JIBO8vb0eBb9dMHO1OA7tyDmL2dVBut
	 7mvEt9foG3OF/hleRw79M5H4EFujS8BOv8f749tmatCmePkXPtGRBtJ/l11jDj7K07TjU
	 BMvcgfaGl5J9iWTK0Decxhu2v/OuOphbwXlZvXgxkiEm+rUisk7amGWtgW0fPMY/mHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="QaS50c4/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AF2606A31A;
	Sat, 24 Oct 2026 02:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QaS50c4/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87C171F01828;
	Sat, 24 Oct 2026 02:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792809279;
	bh=M5JU2/erofEbew8NRNDAiKyc3fsrvlFDG8suS9hpCgE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QaS50c4/QiPzRxxDD43Ud6JEcIjOt4wasEFymwzMzK5+eAiqDxxfWzI87I0OKrUhm
	 0yEOuok/j88y75Uxpw7czgLnvUvBw3L19tatryNZEJ78Y06FQdsan0f6dy9TPmgfJ1
	 sppR7IryyrQSCiDxTenAqmNzDGd7XEP7yfsbserjVjdVSQBf24xPYhsgKyH3cCVcB2
	 Ao344DXuI339wd1GKP0zvEJhnBRnLC3Tc++UqolgIxjNYatZZuwEb0OyPGY5Xc5NW0
	 UDq3E1hxk2Rzj6AIG43KfhjdNw2DQkdTXOVCN3FouEnEC6fQRZZ0/ttIvunWa00Q8H
	 oxCdOFQt1+BaQ==
Date: Sat, 24 Oct 2026 03:34:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: lee@kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
 mfd@lists.linux.dev, linux-iio@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mfd: mxs-lradc: Pass mapped IRQs to child devices
Message-ID: <20261024033433.23ee7ad4@jic23-hlaptop>
In-Reply-To: <20261018022400.599028-1-festevam@gmail.com>
References: <20261018022400.599028-1-festevam@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 17 Oct 2026 23:24:00 -0300
Fabio Estevam <festevam@gmail.com> wrote:

> The MFD resource tables store indices into the parent DT interrupts
> property. Since the MFD core is given neither an IRQ domain nor a base,
> however, it exposes those indices to child devices as though they were
> Linux IRQ numbers.
> 
> The touchscreen interrupt is at DT index 0 on both supported SoCs.
> platform_get_irq_byname() therefore rejects its child resource with:
> 
>  0 is an invalid IRQ number
> 
> On current kernels it also returns -EINVAL, preventing the touchscreen
> driver from probing.
> 
> The child drivers try to map their resource values afterwards with
> irq_of_parse_and_map(), but the touchscreen driver never reaches that
> call for index 0. More generally, translating the parent firmware's IRQ
> indices does not belong in the child drivers, where platform IRQ
> resources are expected to contain mapped Linux IRQs already.
> 
> Have the MFD parent copy each resource template and resolve its IRQ
> indices with platform_get_irq() before registering the child. The child
> drivers can then request the mapped IRQs directly. Use per-device copies
> so later instances and reprobes still start with the DT indices.
> 
> Apply the same fix to the ADC child, which uses the same IRQ mapping
> scheme.
> 
> Tested on an i.MX28 EVK. The mxs-lradc-ts driver now probes
> successfully, and its interrupt counters increase when the screen is
> touched.
> 
> Cc: stable@vger.kernel.org
> Fixes: a85a6c86c25b ("driver core: platform: Clarify that IRQ 0 is invalid")
> Closes: https://lore.kernel.org/linux-input/CAOMZO5CgTzo6GuXptD4mFTN=UsJJqpkixDW1Q64gqZGrij8+uQ@mail.gmail.com/
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
Acked-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
