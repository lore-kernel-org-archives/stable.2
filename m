Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A23540B6F9;
	Tue, 30 Jun 2026 12:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782823077; cv=none; b=Abs/OZC6gev9qchWZvfMxV3o2ud7maQyotbHB5TxQJHOavzl9bLiEj87LJ94eFBM2tzQhgd4BTGK+46k08rVOsro/si1tqrUgfip/yljNW2V3NpsdZI+E6DU96DAjA1/ahgcBvr4LXkIWpiILu0I8Empg4k//TC3gFe6neUcegM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782823077; c=relaxed/simple;
	bh=gFrSgFmeb/xqCopXlwbbqo/0obZElfXwNWbu9ZgZAes=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=VBdn7t/T8K2AMuYg+Fo+iajERZQ3oHrngY2fhM8j1V4YSoJkjBlCbzRvXV5Rm0b0+TWbPb+0PbtlCrlQFbYdbl/v1G9s9HS4gVdfoF/1Hsh6qDrUhutdIvzTSAeQwE+Fb+W/0gC3SCsTtLkcf8/SyjxxQXWWvxY8FZbGEaXqh4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yt/5L7H/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yt/5L7H/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B3541F000E9;
	Tue, 30 Jun 2026 12:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782823075;
	bh=gFrSgFmeb/xqCopXlwbbqo/0obZElfXwNWbu9ZgZAes=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc;
	b=Yt/5L7H/IkbJ9HNCJOdZa23vVb/ZtSnHchmYg+O3goLpkPlSXZpYXob7ZCcB/3dIL
	 TUl9LNgwWQNx527FTikZLkkz3u9bW5U5/VcwQnkW64KB/061DouY40i3ITsBDfpWG5
	 cF2oCQnEkUZ648ANOj0HejnPcVkywnjSwNY4UmSWADyjLg2GwaF4ZNvjq3uPquvVIL
	 XKp8LdwYFmIUAoCALE7z3PMSPeUZtbpToOlz6y3Cn5qtQsuooA8EeBSWhrRoGmh5sv
	 3Q/Pct2EoLle52uw8PfTNHu2qVs+i7VTfFh6qP1EarbnGLq/wrLfVw8392mSHz9t1p
	 FrPmsXWXe4PEA==
Message-ID: <b10ed22795de18c499f444e3ce8f3756@kernel.org>
Date: Tue, 30 Jun 2026 12:37:53 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Romain Gantois" <romain.gantois@bootlin.com>
Subject: Re: [PATCH v2 1/2] drm/logicvc: Avoid use-after-free with
 devm_kzalloc()
In-Reply-To: <20260630-logicvc-uaf-v2-1-99e881833860@bootlin.com>
References: <20260630-logicvc-uaf-v2-1-99e881833860@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, "David
 Airlie" <airlied@gmail.com>, "Jason Xiang" <jx@jasonxiang.net>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>, "Paul
 Kocialkowski" <paul.kocialkowski@bootlin.com>, "Paul Kocialkowski" <paulk@sys-base.io>, "Simona
 Vetter" <simona@ffwll.ch>, "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Thomas
 Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

On Tue, 30 Jun 2026 11:10:10 +0200, Romain Gantois wrote:
> The logicvc driver calls drm_universal_plane_init(),
> drm_crtc_init_with_planes(), and drm_encoder_alloc(). These functions
> should not be called with structs allocated with devm_kzalloc(), as this
> can lead to use-after-free bugs. In fact, a use-after-free caused by this
> has been observed on a v6.6 kernel.
>=20
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
