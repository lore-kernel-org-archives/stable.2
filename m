Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3A130D3E9;
	Thu, 17 Sep 2026 00:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789604660; cv=none; b=kMFp1rkxwAXkFwt0F5rhisk94ZwwRYrfFycPrAI8WiGUX1V6ejztaSSuu6OhXbt1BgoCd1bmQuFCWYE4LOJhQWvvjtczWWiWoN16MwMIZKzEgTdQNqIzT5sdX/KmnGK0iytmkHw39Z1J9XHQ1fWHFTmHlFOEC6cBRMReBibQxIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789604660; c=relaxed/simple;
	bh=Tkd9LkGaAjmN7N4DPt0Sicp7jDFUwKBLtRelz/pwwvU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tfLgsS/HLejypZBFPJBhBILPpnOrMKtJNDxMH+ehvkcBQ5GwSnUQBhgrxC88B+J+5yJg7frcRsGLFtXHrBO8/GXV4vlqSQ4exjFLcu9kQ08c0S9hIFkHydDlxGcXpELLntZ8Lfnv+OJ4GibqyceZF9T/6l46d6FZpcDlchIiu7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YxglV0yJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YxglV0yJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE041F000FF;
	Thu, 17 Sep 2026 00:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789604659;
	bh=bXx8CeHaYeCSufdg37KV3sidk9aNAlvq6YcptTYgHh4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YxglV0yJuyyAsjVRyMK20Ve+pp9tlHo9Q3J0oAyN0JarotW/w1kQhBc8Da2D7azY7
	 iu8SeDuTKEkU8clgg1Mg2aVc677XRFWz4nWpzKhlyeJ9fFdnitHE9XcsIOt6bH8POJ
	 D5q+SzV2mhF8bzs79JHCHK/q8EjdZSlmYQe3gc1MhPYXnJw4wEaTMD5H88qEdPNdrO
	 WbwKNJNDptavtmkHAvflS8kkMNRp9gqwAgHpsdzx0iv/2KcqDCtXjItiKTMXvQZ/YH
	 pl9ibofR2T28k6Wl/5PWojBKGV71g5rpD/WO+tntRTa0RFe3G+qZu4FqDUSzVDyR/E
	 N7RR6VRWe5jug==
Date: Thu, 17 Sep 2026 01:24:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: Wentao Liang <vulab@iscas.ac.cn>, andy@kernel.org,
 dlechner@baylibre.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, nuno.sa@analog.com, stable@vger.kernel.org
Subject: Re: [PATCH] iio: accel: kxsd9: Fix runtime PM leak in
 kxsd9_write_raw()
Message-ID: <20260917012414.4a171c2d@jic23-hlaptop>
In-Reply-To: <CAD++jLmD7jgAtwo7A01Ow0f=qYQGcE_XAPWJ1Hw+oyquGqEe_w@mail.gmail.com>
References: <20260916161205.2082579-1-vulab@iscas.ac.cn>
	<CAD++jLmD7jgAtwo7A01Ow0f=qYQGcE_XAPWJ1Hw+oyquGqEe_w@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 16 Sep 2026 19:33:47 +0200
Linus Walleij <linusw@kernel.org> wrote:

> On Wed, Sep 16, 2026 at 6:12=E2=80=AFPM Wentao Liang <vulab@iscas.ac.cn> =
wrote:
>=20
> > pm_runtime_get_sync() increments the usage counter even on failure, so
> > every successful call must be paired with a put. Rejecting an invalid
> > scale value returned early and skipped the paired
> > pm_runtime_put_autosuspend(), permanently preventing runtime suspend.
> >
> > Fixes: 9a9a369d6178 ("iio: accel: kxsd9: Deploy system and runtime PM")
> > Cc: stable@vger.kernel.org =20
>=20
> It's NOT that important.
Also not the current code...
static int kxsd9_write_raw(struct iio_dev *indio_dev,
			   struct iio_chan_spec const *chan,
			   int val,
			   int val2,
			   long mask)
{
	int ret =3D -EINVAL;
	struct kxsd9_state *st =3D iio_priv(indio_dev);

	pm_runtime_get_sync(st->dev);

	if (mask =3D=3D IIO_CHAN_INFO_SCALE) {
		/* Check no integer component */
		if (val)
			ret =3D -EINVAL;
		else
			ret =3D kxsd9_write_scale(indio_dev, val2);
	}

	pm_runtime_put_autosuspend(st->dev);

	return ret;
}

Which could be improved via the ACQUIRE magic but none the less doesn't
have this bug. Was fixed back in June.

Jonathan



>=20
> > Signed-off-by: Wentao Liang <vulab@iscas.ac.cn> =20
>=20
> Reviewed-by: Linus Walleij <linusw@kernel.org>
>=20
> Yours,
> Linus Walleij

