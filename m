Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F073EBF0C;
	Sun, 18 Oct 2026 19:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792352307; cv=none; b=g25TnUC4hFsbWOMNgMPdBfsVtNBvWLdLk+zeSBbQO0/6ysXIZJQqorSsLg+TNaO1bigYzmj3pUzqq0nsb8j4JFV42DnBGYWiFaDuAqJTyt44XGRiJX5qnlYSyY1Y6YC9edyVzNzpMFvqMTXlLYYylFwcnk/FUYMB20nHIuEYpxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792352307; c=relaxed/simple;
	bh=eUApO1/mNIubcllxlKeOwoXElBbtZWPMbkIj+/BEwj0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F1Llu7CL4Ia27wzzHw1QCv5BMFtewwK5Mhmk4HWJbV/BLfCrqZPY21o/LGqdk2frqxJvDmXauv7Wf0GZdB3L1mlTpdJb5YR7C5S2p+TWCNhiuDMvFa/0bxzdZx9s5BCf6UijIHeLa87bCr8EeBwIHLutK5M0pHPY8Vn/wYwi5Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E5T63JNK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E5T63JNK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C61F01F000C4;
	Sun, 18 Oct 2026 19:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792352306;
	bh=eUApO1/mNIubcllxlKeOwoXElBbtZWPMbkIj+/BEwj0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=E5T63JNKqImQalgzanozpxCNEmDCBjhHIpliHjC70jy5FUCbM3PAnmNrQA8p0PkU9
	 7XBKnfvsbEXsOfu0MwSclX1M872P8zKMi458ucpMdc4eKZhG1Ng8oT8u5pw3Zt0+bP
	 cKN7pjrYnM87FEIrGg2WehUQvr2NkDtCXnkB1fPJ66JXiXTZ0b1QZISkbYlkbqtz7D
	 B9vdOoJDG8bCKj6XlQsxQwKE6SBqtaoItK4WQsY+pjtPpS8MwKAsb4z6hCMZhR22sJ
	 oan8jezzFIhghO8WSJcn6GQ0PZL7yFcLP5Zt9hHRTAMjpIOOMWeiCw+0MBfgXg9ncD
	 LSgBQRYIX5c3g==
Date: Sun, 18 Oct 2026 20:38:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc: BouziguesAlexis@johndeere.com, Lucas Stankus
 <lucas.p.stankus@gmail.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Lothar Rubusch <l.rubusch@gmail.com>,
 linux@analog.com, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] iio: accel: adxl313: add missing buffer selections in
 Kconfig
Message-ID: <20261018203819.48ff35f5@jic23-hlaptop>
In-Reply-To: <aszu6m0hclBWzPEv@nsa>
References: <20261006-fix-adxl313-buffer-deps-review-v1-1-386006c407be@JohnDeere.com>
	<aszu6m0hclBWzPEv@nsa>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 12 Oct 2026 15:30:50 +0100
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> On Tue, Oct 06, 2026 at 07:08:58PM -0500, Alexis Bouzigues via B4 Relay w=
rote:
> > From: Alexis Bouzigues <BouziguesAlexis@JohnDeere.com>
> >=20
> > The FIFO support added to the ADXL313 core uses
> > devm_iio_kfifo_buffer_setup() and iio_push_to_buffers(), but its Kconfig
> > entry does not select the required buffer support. Enabling either
> > frontend without IIO_BUFFER or IIO_KFIFO_BUF causes undefined references
> > to devm_iio_kfifo_buffer_setup_ext() and iio_push_to_buffers().
> >=20
> > Select IIO_BUFFER and IIO_KFIFO_BUF from the shared ADXL313 core symbol
> > so both the I2C and SPI frontends have the required dependencies.
> >=20
> > Fixes: ff8093fa6ba4 ("iio: accel: adxl313: add buffered FIFO watermark =
with interrupt handling")
> > Cc: stable@vger.kernel.org
> > Assisted-by: LLM
> > Signed-off-by: Alexis Bouzigues <BouziguesAlexis@JohnDeere.com>
> > ---
> > Add the buffer selections required by the ADXL313 FIFO support.
> > The shared core symbol covers both I2C and SPI frontends.
> > --- =20
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
>=20
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan
