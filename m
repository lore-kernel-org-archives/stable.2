Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793060890;
	b=mnwVtQPHSUeIPU5MGSdekOtlSp8/mL83VUQUZ4DJ2DCt0n8rYyl5ScEuRePxpWQEr4Ws
	 3dhiY+13o1s7+WxDCXtprMfNOuMAMWgQye2sVhJnlB40LRKwO8E19zkpVBJ9TObONaEuQ
	 lBKf2gGFtd6OoLMtxS0pD2KZNZEDIQnLODGtmk6fadJNlR0PSTnciw6Tm2RaAI3kOKF5i
	 MaiuSItALCnSXeKGQ2DmS3IFcs+w4KVHcjGI5aWD7N87S9cghKItp8oILAVAqR+lurlzD
	 0bu8xArjIzyfGQJWWxVCXo5GWQ8QnA+vzFhCldctGpeyEu2x9kuo9+8HBnV8tGYMFvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793060890;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=MkfGnpqGYjGPFiZABngyJ79AmLIOHmQWONEJ+cfbN6M=;
	b=T3GRLcD7N4agkXKZVbgqb+lde1R/L1qjZ0Fr2N8EkFsh6O5UH1Q2yRM8ciRYjmkyedtM
	 xrdd94hFbU+Bv+VXPW1D8B2hLRcDOy2xaub4JAEBXQNiGvRFl7iEUHKWPaAiawMik8Hmj
	 dEnwD9148r2D4RDmOn8WeoQD7HlJ74+up7MBeltiIyOxs6ReLsV65BxsovNjmzDcGLBKW
	 PwJCyBQ7ymd80EUKAq5H7BF/a+LMJBhtBp6uVNBOfD0Qa5jKt2qZ9y22CMieYSSJ8oOcI
	 bJF/ieXdtYEXXFvC6KRf4WFDs03V9nDRhhbj1vI+QKTtZQOg054AAeSnUfpUKLXs1vQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aqoDcATv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F3D606A31B;
	Tue, 27 Oct 2026 00:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aqoDcATv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 407871F01825;
	Tue, 27 Oct 2026 00:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793060890;
	bh=MkfGnpqGYjGPFiZABngyJ79AmLIOHmQWONEJ+cfbN6M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aqoDcATvj9CJhxZn/Jgta9FLrTOim6C6UJtspvQJAmBcjEsDKrqISdUiEzqmoNs9M
	 28QMNGGZY2BJCWhRTowcypmeDm5K37/a7T1+RT9Ts9P5p2oGFJ1LoAr5KTCnBBmZpx
	 nK1t9FQiCdC1OulZkPdW3/ziC+BR2VEY6DetKvoLpwJ3pkriT7j8R8scr2/G3qjHQD
	 ikhcwA4DWQ89BOP0Ic5qsTpJygnbCQtiQo1fQ8hrpY+cg4hyE0dVfiRbmmwFYt1+L3
	 yUdr6So6GIMS12GK+SoJ2IxOcYaIR7n4acC9TLI1J3EmeJpJl92YKByKWS1PO8XxAc
	 Uw5qUlthhHo3A==
Date: Tue, 27 Oct 2026 00:28:03 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: andriy.shevchenko@intel.com, Andy Shevchenko <andy@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Eddie James <eajames@linux.ibm.com>, Joel
 Stanley <joel@jms.id.au>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] iio: pressure: dps310: wait for a new sample after a
 ratio change
Message-ID: <20261027002803.74cab82c@jic23-hlaptop>
In-Reply-To: <20261026173910.23788-1-zoone.rupert@gmail.com>
References: <20261019153328.80739-1-zoone.rupert@gmail.com>
	<atZqSXI14WojGso5@ashevche-desk.local>
	<20261026024605.3286702f@jic23-hlaptop>
	<at8X810dwa98w9iL@ashevche-desk.local>
	<20261026173910.23788-1-zoone.rupert@gmail.com>
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

On Mon, 26 Oct 2026 19:39:10 +0200
Rupesh Majhi <zoone.rupert@gmail.com> wrote:

> On Mon, Oct 26, 2026 at 11:05:55AM +0200, Andy Shevchenko wrote:
> > If Rupesh is going to add the patch to clean up that (before or after this patch)
> > I wouldn't be triggered.  
> 
> It's ready. It turns the 30000 into 30 * USEC_PER_MSEC and does the same
> for the other sleeps in the driver. It is in a small cleanup series that
> I'll send once the dps310 patches already in flight have landed.
> 
They are all (including this one) on my testing branch so feel
free to send new patches against that.

Thanks,

Jonathan

