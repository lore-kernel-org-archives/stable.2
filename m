Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68694078FE;
	Sun, 18 Oct 2026 22:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792363040; cv=none; b=QI2jnrz5U4uuOoHHcRKJ67H6jF7qB1wZYqT87smfpLLEd/fBU2F7XVo2+72FRzHVGLisM47ngMOvBeLh1mNy7/xP4RiBTtUqFJUTAtZtBP1lVItQgAIszkiBCx3dNLTOqWsBzWRXhbH7tVLcbUOcNHxfH3LHA/PPACCZeZ2BuRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792363040; c=relaxed/simple;
	bh=UBuprx3+gAQtfinB2Bh85hyB9tcv2lYohL3gHhjC9a0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qm14vcazjnvaFWkKiaolJIVdz9rHWEXKKO7/G1kX+Kyqc+zU+LxuOpRj6pzdcG+NTYEfqqDpxsB60VZIKJ/tAfOrJZdoNeZVrAjvSwMCalpKnCceONoehZ1x2pxV6O7SlauHBvvpxdkmuReP9G2R7Ga5hX6tXsjCYoG/aEqy3GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULxi0fEN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULxi0fEN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD431F000C4;
	Sun, 18 Oct 2026 22:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792363039;
	bh=E2qpwMKbvIabL7Fm/yRT68Ksi57dQztpeO83C0o6OuA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ULxi0fENT1ULSbJFKkVetQWZDG1hDEXtXMFGB+6PRRTNqD3Ff3+LFNxHYGADnfY37
	 6jN5eGhRwOZ/e+NDQHzid67FtUiH4iD+GifKnzlbCxLh3QimLZbdUZREoVjDYSYdnO
	 ZL+H3b9ExidlZk0nGKlJC+urN1NQCNehlJBw3Cu58q4N/KDBmflvh0qrKWmDuw8LH5
	 NBhDFSOb9+ZtcDGnJgyeo4uIe//nKkXr1AuLCSNpytCcESyWH49xYiKscFaW+EkvzK
	 2OQKyieBZ10T66IDCHXeLVX0hOqR1iMDQ2yObHApNPencommjISxr66Un0f3MddcM4
	 yAxbz9XAfoTBQ==
Date: Sun, 18 Oct 2026 23:37:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Leonard Crestez <cdleonard@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] iio: trigger: Return an error when the trigger has no
 free irq
Message-ID: <20261018233711.133a80f0@jic23-hlaptop>
In-Reply-To: <20261006084352.00006689@gmail.com>
References: <20261006034147.2370-1-kmehltretter@gmail.com>
	<20261006084352.00006689@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 6 Oct 2026 08:43:52 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Tue,  6 Oct 2026 05:41:47 +0200
> Karl Mehltretter <kmehltretter@gmail.com> wrote:
> 
> > iio_trigger_attach_poll_func() prints an error when all
> > CONFIG_IIO_CONSUMERS_PER_TRIGGER irqs of the trigger are in use, but
> > returns 0. The buffer of the extra consumer is enabled without a poll
> > function.
> > 
> > Disabling that buffer calls clear_bit() with a negative bit number and
> > drops a module reference for the second time. On arm and arm64 the
> > clear_bit() goes about 512 MB past the pool bitmap. That is an oops if
> > the address is not mapped, and a bit cleared in unrelated memory if it
> > is.
> > 
> > Return the error from iio_trigger_get_irq().
> > 
> > Fixes: 995438233579 ("iio: Fix error handling in iio_trigger_attach_poll_func")
> > Cc: stable@vger.kernel.org
> > Assisted-by: LLM
> > Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> > ---  
> 
> A 10 year old bug. Nice find!
> 
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> 
Applied to the fixes-togreg branch of iio.git.  Thanks,

Jonathan


