Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A4F32AABC;
	Thu, 17 Sep 2026 00:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789604976; cv=none; b=aC2C+sxHuHTKkg2Af8z8HnUPlvIMoJoln9+3SVLrPkPZfR/MJuRJ+HzXU8zLr6YzInMPmoV068qslGPC8AY8sdA5TQ9egH4QF2PF91Op/X6Y6largaRwlzAAqhi717qHBRSDxf2z58twCbOmVbm7GEicHGkaa/VSE8uQS0ukbrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789604976; c=relaxed/simple;
	bh=92IIyBBm+WWc5qwB/zSd/ki3saJWvgsg7zeV9xwmBqA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g+mgown1anAyugaqnW5tULPsTI8Lpf24RA54S0DVcDNRFA6e3Zq5ZgDD2G7Ofr0CHeIkBY3zJMBllSan0Tapf9pK44rn+BAzwFl9+xxhKg69zClvo19yFjCbJoW+5DUMhBpSU6PjCY3yG+mx8LwXjegUO8vdt9xwlogqtasiXH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ldMYg7mF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ldMYg7mF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 249131F000FF;
	Thu, 17 Sep 2026 00:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789604974;
	bh=n7RmGOhGmPAeu/1tVB/q4BEwbQ9D4mfFx4grzq6nCrw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ldMYg7mFaqAEwmCRKl7mzwxCLW7lWYlk9kbgnZuqjTgpohm5tJiD95CBui8M0lWCT
	 AFQqXblZx4ZFQSTmuOzaudYJOMUk+D7Vaqt2eZGtD8nAgOD7F07YbBgIPLk2ndYQS3
	 CHWfKP2Pu8pDKqKSJeQHUrvJuGBsOcfLDEdQIXfre6ALuC9MPvre+FhbeO5u+ewIQ3
	 d/jmAMw6dRWbdqB9rLEQfAze25mSXlcjd0lbFL1FWQlNksDdzIGynw8yXJZWk35d6s
	 rMZyvtIU+6cMLq+uu4v9XHLMI1pQSwbKpSEhvLm5Fjj9HuNK+sKCWn34LK1s5VS+m2
	 mr/ucQGP65DYA==
Date: Thu, 17 Sep 2026 01:29:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: andy@kernel.org, dlechner@baylibre.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, narcisaanamaria12@gmail.com,
 nuno.sa@analog.com, stable@vger.kernel.org
Subject: Re: [PATCH] iio: chemical: ccs811: Fix trigger reference leak in
 ccs811_probe()
Message-ID: <20260917012928.0c631aec@jic23-hlaptop>
In-Reply-To: <20260916162534.2083446-1-vulab@iscas.ac.cn>
References: <20260916162534.2083446-1-vulab@iscas.ac.cn>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Sep 2026 16:25:34 +0000
Wentao Liang <vulab@iscas.ac.cn> wrote:

> The reference taken with iio_trigger_get() is only dropped by
> iio_dev_release() when INDIO_BUFFER_TRIGGERED is set. If
> iio_triggered_buffer_setup() fails before setting that mode, the
> reference acquired for indio_dev->trig leaks. Move the
> iio_trigger_get() after the buffer setup succeeds.
> 
> Fixes: f1f065d7ac30 ("iio: chemical: ccs811: Add support for data ready trigger")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Not this solution. See bma220 and other similar replies.
