Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3D0182D6;
	Mon, 21 Sep 2026 00:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789949691; cv=none; b=FbxSRqh4Xyu7NjOe0z5GREf8XiSrb+dt6NKe7PQM5IHcp6CAKQRUZUvjR7nw4if/Txl/mLT/JMhKk6+CuAU5htEGBWJydp1ap8RQDU8CKUw/nX6sLvazm1ppJHtMINDYQ49uM2RiPsKBkTVddJ0JMkgGSWxRnVF5LJWR5QQ4vtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789949691; c=relaxed/simple;
	bh=MF9MDvo0+v4jp0d+yKGWb2xCti+x5/t7U3PxG8gsFFA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yk2Ue1h8c8wgJ4VBEvCe6Mvahin18SHbBhuAC9BgMzY5fdABX7owN2KEc1dgBRCVo+ZxPqBBBJdfUb8MtYVJOMuQshrT+5EISd+4dsXKz581xWr/nRxNMBvV8l6ItVWL61wSlFKO1Meyuyo8BKQ/MDICCKWZWaKH+LTi0XI9Vfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/BXwGpz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/BXwGpz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC77A1F000FF;
	Mon, 21 Sep 2026 00:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789949690;
	bh=H9n14ecYroU7+DDO7NNn5gqPEvYih3tU4SI/4RTqUOg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=h/BXwGpzwvMMl60jjUUC9Kl6ZHqrND4q9enkECK5ewsMOK6xiYfIdxihYg/EVNTB4
	 jTu2+13wihO63GvQHNT1TmbIdBrYeCO+F+Nw3+JakUmgnUnkxNShbv3gLTsNdZpCYP
	 LPyhoLfWO8VqUcYALZcgwyKmr/M+91PaekaiP5wqK9EGKa6QDzeR7JLqjEdSPW+05T
	 ByzbN5Vob9DXwvDbpnIymLKdGbRl/U5uqJXFHepDu5bDQEsZMS+yolMN8yMBgUkofi
	 x7U2r/jIk9WN4gow267HaZjjuJgKYk+UzadiROdp9dnFoGanZOyRY7rPbZYhpkR5go
	 hFyoxdW1hWm2w==
Date: Mon, 21 Sep 2026 01:14:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>, <linux-iio@vger.kernel.org>,
 <linux-stm32@st-md-mailman.stormreply.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 Sashiko <sashiko-bot@kernel.org>, <stable@vger.kernel.org>, Andy Shevchenko
 <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v3] iio: adc: stm32-adc: fix check on internal channel
 availability
Message-ID: <20260921011442.1c5a8403@jic23-hlaptop>
In-Reply-To: <20260916-adc-fix-intchan-v1-v3-1-b5f05b86bc60@foss.st.com>
References: <20260916-adc-fix-intchan-v1-v3-1-b5f05b86bc60@foss.st.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Sep 2026 19:18:38 +0200
Fabrice Gasnier <fabrice.gasnier@foss.st.com> wrote:

> If an unsupported internal channel like vddgpu is requested, the driver
> prints a warning but falls through and assigns it a valid int_ch below.
> 
> This causes a problem later during setup:
> stm32_adc_int_ch_enable() {
>     ...
>     case STM32_ADC_INT_CH_VDDGPU:
>         stm32_adc_set_bits(adc, adc->cfg->regs->or_vddgpu.reg,
>                            adc->cfg->regs->or_vddgpu.mask);
>     ...
> }
> 
> Because the register offset is uninitialized (0), this performs a
> read-modify-write on offset 0, which corresponds to the ISR register.
> 
> Fix this by returning before a valid int_ch is assigned. Choice is
> made to keep current driver behavior to warn about the channel name.
> 
> Fixes: cf0fb80ae167 ("iio: adc: stm32-adc: add stm32mp13 support")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/20260911162602.D323F1F000FF@smtp.kernel.org/
> Cc: stable@vger.kernel.org
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan
