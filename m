Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794578594;
	b=tWb2RuPjtC5tM2h6PxYU3C8UBPvsY+UoAlzOLLdzN1bLaKlXQYQUEDoe4979wlSypTHC
	 wYwdPgpJT2Y8HN9La5p/UfQmAYZ91/Ek/TYMx5DacIo+THv/KFcPqrfjjMQkIPDKyglZT
	 AutTCjOH5gMDjlTIU2apopRMw1K5YbHG9TnAkiK9A4SBRufGldSKnlyLJYzKTda6S5L+L
	 EQpox1pD+bRe9GyZ1XY8b+10rt+QAs8kHxN9giG8PJJh9Yp3WooPipmMsdHPj5ASLmH6/
	 8PUL+YkiQ/PQ1lJexyf1PcwF1dq3p49q9zm25TpiOITE3XEjw3BnCEHzz5WYExXu/bQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794578594;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=81KIsd25j6/GuL/3OC5Qj28XzdmytWscWrgvMbG4NNU=;
	b=nlJfHVBQETjAGxaWlQD5K2j2lyASrr7Dkx+QSxqKrVV5PBVWhVQL0DkTg9JLISQdTw7Z
	 K50j7ZxtYnplfkAHnrAEvp6EQmiHyqHWuomV5GjP1QU//fRSkAuAuDKcGbMux43o/y5D8
	 f3sZ5ASVpIl7PC7Wuu0AZ5jYoEux4RDGxfkWZKMNBjDju/ZSBrlzVJSDx25ODPapuUYp0
	 mRiYl5K9VRf5PrjBCbwuZP482o/IGsp71/KDi8ICNwS6XFW5AfbnKTvKKeZvnSGKwvk2X
	 i5XPAilBrRQPoYndOmx7LoH8k657lYsrKby0XhLv94VpDLQ00bN0umu+rA4ZHGvnhTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RN2gsuUc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BA5606A883;
	Fri, 13 Nov 2026 14:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RN2gsuUc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB0961F000CE;
	Fri, 13 Nov 2026 14:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794578594;
	bh=81KIsd25j6/GuL/3OC5Qj28XzdmytWscWrgvMbG4NNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RN2gsuUc9Di1qiHwbhHx0kiCejS7+TgHVn6DuD0Y5DFKSKO+hccJKpIeH9ymg/fHf
	 638Bu+wFXv5/TrsJSUsE9tBGodh+QArfxkyuZq/eYeJADaTgkWLmnbcxvx6y44R4my
	 Gu086r8bRLU5gQDydyEJtcAG5Mf9kpkf/f5+VKMDbtblun5fz6J4AcpCz90kp8UTWk
	 VA3q4l72c+nsWmp2kWVYDZaXudR9BiAhSihfXuB3UfFXalC5mdPL5O1zSzLAxOKcDh
	 hxIkwhwqxmTuzk3uDwag0F4PPLhkv52dcSdICvIAutnFdUsdWwtRPxRTecewND7GEl
	 +/2vQwwS705vw==
Date: Fri, 13 Nov 2026 22:03:10 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Chad Aldreda <ca@modelmiser.com>
Cc: Dan Callaghan <dcallagh@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Sami =?iso-8859-1?Q?Ky=F6stil=E4?= <skyostil@chromium.org>,
	chrome-platform@lists.linux.dev, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] platform/chrome: cros_hps_i2c: fix use-after-free in
 release() after unbind
Message-ID: <avcYnkCehqVqvmWK@tzungbi-laptop>
References: <20261113073351.805165-2-ca@modelmiser.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261113073351.805165-2-ca@modelmiser.com>

On Fri, Nov 13, 2026 at 07:33:58AM +0000, Chad Aldreda wrote:
> hps_release() finds struct hps_drvdata through file->private_data and
> calls pm_runtime_put() on hps->client->dev. hps comes from
> devm_kzalloc(), so it is freed when the driver is unbound, and a later
> close() of a file opened before the unbind reads freed memory. If the
> client was removed with delete_device, the i2c_client may have been
> freed as well, and pm_runtime_put() runs on it.
> 
> [...]

Applied to

    https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git for-next

[1/1] platform/chrome: cros_hps_i2c: fix use-after-free in release() after unbind
      commit: 2c1aa3d09aad89def46cab40b6c14938833c352e

Thanks!
