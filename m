Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084BA22A4E9;
	Thu, 17 Sep 2026 00:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789605463; cv=none; b=PMMFv6n1FgEqUrKs9Ty+ObI0vAy1tgaYbDlhHuJYt6Z+LYD/R2SJKdyk47lkrUgakLVKGGAp2c+4x7hKTYleIPAxFFfYq0mrD0Nwfo4gm9xQys1NwlKVniJfrb2VcklNJ7zOlJ1ZshCq7dw6vCbzt8NKsMBkd67IEePqBXGAWww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789605463; c=relaxed/simple;
	bh=9C3qRVbLzi7//u7PrW2lIHIf9POM5tqrlVH3xVAWEwU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XWv4Baihvrp4GE3rRVacAf5hq6rmXXkBlEYtjEqjE+1TWRqHOyeoOgmvhhQWmC6u6nqa71kavXHHvtHk6x/VL39H4b0HsnTBOR+ZvQBX3ZI06NzX4bioUVccNT17UDzKeVZ4HrYl2NmLbyxDI3k5xtHFCS9ONI/gdPyoy2R2s28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QwpKnPxL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QwpKnPxL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF9241F000FF;
	Thu, 17 Sep 2026 00:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789605461;
	bh=9C3qRVbLzi7//u7PrW2lIHIf9POM5tqrlVH3xVAWEwU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QwpKnPxLmlxB+bxRwuzoAStYMWOT2NmCF3IKBfkq1SMQ6O+XOXtAnSxPYQSutNoic
	 IfLAJYnl2haYfaRERdJJX+8Ai93qaSC6Z+6SCRgzIgY0/EZ6723MhKhqQlj6rN/f47
	 +UIhbaG7BN9vCPChuu1mywIdZ8+Ow+MPqYY3zDkEKXtODCNVirIPOIJdignDkhhlOz
	 MLFsPH1hRNJLFWboN2YAAPg3hhaAeUtmoPpJA3OXNJXjEi3LhVe1R0Q9NNuA7h3UDN
	 n3iVnT+X+MbrV/Zyap59EVynt4uc4UPldytzcU4IXahzVqANqWpsH80gNJ1BrNOFKH
	 J/XHAFoIFjEmw==
Date: Thu, 17 Sep 2026 01:37:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: Wentao Liang <vulab@iscas.ac.cn>, andy@kernel.org,
 dlechner@baylibre.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, nuno.sa@analog.com, xc-racer2@live.ca,
 stable@vger.kernel.org
Subject: Re: [PATCH] iio: light: gp2ap002: Fix runtime PM leak in
 gp2ap002_read_raw()
Message-ID: <20260917013738.64ef0574@jic23-hlaptop>
In-Reply-To: <CAD++jLmJ_t1DVkDfRwbTQ23w9AJ9wpB3yqcCCTXqe6H8A_-D9g@mail.gmail.com>
References: <20260916163646.2084234-1-vulab@iscas.ac.cn>
	<CAD++jLmJ_t1DVkDfRwbTQ23w9AJ9wpB3yqcCCTXqe6H8A_-D9g@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 16 Sep 2026 19:34:56 +0200
Linus Walleij <linusw@kernel.org> wrote:

> On Wed, Sep 16, 2026 at 6:37=E2=80=AFPM Wentao Liang <vulab@iscas.ac.cn> =
wrote:
>=20
> > pm_runtime_get_sync() increments the usage counter even on failure,
> > so every successful call must be paired with a put. A failure of
> > gp2ap002_get_lux() returned early and skipped the paired
> > pm_runtime_put_autosuspend(), permanently preventing runtime
> > suspend. Jump to the common exit that releases the reference.
> >
> > Fixes: f6dbf83c17cb ("iio: light: gp2ap002: Take runtime PM reference o=
n light read")
> > Cc: stable@vger.kernel.org =20
>=20
> IMO not stable material.

Also that's not what upstream looks like:

https://elixir.bootlin.com/linux/v7.2.5/source/drivers/iio/light/gp2ap002.c=
#L246

Wentao, that function would definitely benefit form use of the
ACQUIRE macros in pm_runtime.h though if you do want to
improve it.

>=20
> > Signed-off-by: Wentao Liang <vulab@iscas.ac.cn> =20
>=20
> Reviewed-by: Linus Walleij <linusw@kernel.org>
>=20
> Yours,
> Linus Walleij

