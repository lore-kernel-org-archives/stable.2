Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1037C39D6FA;
	Tue,  6 Oct 2026 09:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791280619; cv=none; b=ZjKcQjHDc+90GuMdKmR53uQ2VoRHIVqOGxtY6amomCoXHRdXrphKXKglrS8jhenLEEWj3+dQ03m9pnhLGHMOwjCqZHyGrvGkwKHJzgz8hNfaRzmGm+bM+gH67Gt0czeUKNLIrNSXK31IL8fH9fO/hz/+c0bI1xsVn0jb7XK7Yw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791280619; c=relaxed/simple;
	bh=AleYvG/qq8AFQ+xETaiTdk8DrGfhb9/hI1aqS/R4jxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cKwaKaevPfDz1BYSJpIQmbe6YW9tBT2rHFb3tXl9AqWxqfs+xL1uBzfMR9epWWqMope2eEgNLgt+XcmPGIomHb9bKWS1bHV2XtbvMvFh5JrGN/aDkwQKuBhJXerTi1JNr2ax5jdqQpDOSMiYdwj5mi7/muoOeiM4MJwZKGBCAa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4xn/b42; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4xn/b42"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D999F1F000FF;
	Tue,  6 Oct 2026 09:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791280617;
	bh=AleYvG/qq8AFQ+xETaiTdk8DrGfhb9/hI1aqS/R4jxM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Q4xn/b42sovP3gmwYnSwgeQmC5kz6pxAhQrc8udqr/1e3D/IMfo3ktg9Na6UAH1bJ
	 6lLvvsap7sWw4PZ946I+FVXPYBIUbUPTp/87dqWluvS7mV7IjoNvyXgkretQiKX91z
	 tnOfvqPjon8/99vc+aG2KW4VJrr5Linqb0Xn64shBx6Lv75hkp2q4DG2LU2l84YwkU
	 O5fZG/m99eKn1pyoiqefHqdt+yiBibJU0rItAfYEj0A5zfOXlji8mDTOX7cNoCNJgN
	 ZB1rt/k2G8gHOF4VCWXmnlspYgFq9dzCncCh+TH4ro1aZ/bSy8dNyshYWOi5KifTCZ
	 eYWI6NFy19TLg==
Date: Tue, 6 Oct 2026 10:56:53 +0100
From: Daniel Thompson <danielt@kernel.org>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
Subject: Re: [PATCH] backlight: lm3630a: Cancel delayed work before
 destroying workqueue
Message-ID: <asTF5StelmN4BQxo@aspen.lan>
References: <20261003030439.599330-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261003030439.599330-1-mhun512@gmail.com>

On Fri, Oct 02, 2026 at 11:04:39PM -0400, Myeonghun Pak wrote:
> The interrupt handler queues delayed work to read the interrupt status.
> After free_irq() stops the producer, this work can still be waiting on its
> timer. destroy_workqueue() cannot drain delayed work that has not yet been
> queued by its timer, so the timer can outlive both the workqueue and the
> devm-allocated chip containing the work.
>
> Cancel the delayed work synchronously after freeing the IRQ and before
> destroying the workqueue. This also waits for any running status read to
> finish before the chip's resources are released.
>
> This issue was identified during our ongoing static-analysis research
> while reviewing kernel code.
>
> Fixes: 0c2a665a648e ("backlight: add Backlight driver for lm3630 chip")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.
