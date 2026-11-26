Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795659492;
	b=Whqdq4c5NerbcOvyR/acw4b4c8cJH/RkBkRZLThj7cIsxvYBgDd6CHFmiK3VrLP0ZjAh
	 xyWZM0Q/qEUB0f54jH5tQid1qR1M0XIyjvK0UZ1bQ/mb0YZaeBNEgEulyxATPNIl4KVB7
	 dp0Xj3+1wa/j0rMo27suZb9YeE4XfWZMdBzUlDWEYfOodc1KkZNqTFzrgK0avqWzNOEC3
	 0x19NdjNUh2FkYwXyJapvVL2q0CO7scmBIImawMg35skF+SziKtqpzqFq9FalFu41IR1H
	 Jy0/R6lD/ChbBM81PqyLFLS1gu1fO/0PYF2Q0fJtcIJg9ave77t2nM+a9qz/+5H4dgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795659492;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=LQUBvpsucYn0MXvaNFNdOGS2lcFbmHtWdBHiuR+bvsI=;
	b=AE9KtuDjCiY3qEZ+xFgrr1sJM43u4KqdSp3WtaagquR4/FI7M4a0vtV1Nf0gvZjPNwy2
	 mJxGSCQwNJW1Bx8BRPNdh4wgEy0TGijfjdndeMdCaKUkCrO8+hoNOBOlJ+m0W7YDbNBuN
	 nF8B+ZjylMk/dvHFEWQGQ+NgdIWs2lphhcgo6BR1JGQhZamf5pj1ib2INbZcKPLJ7HYGm
	 LNtrzHKuqDAGgxdnMAzeWggfEvpg3FnHNHPiMqD08YMicmXcSwj5fRfMud6vWd3sCV8bU
	 zmjet8SSxT8LeNdlshMDVx/kYOaNxaV0ZbxjOiPK1W07lalKY9dErPKstlv2T3WZL3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l5+n1eRT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C58606A31E;
	Thu, 26 Nov 2026 02:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l5+n1eRT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4234F1F000C0;
	Thu, 26 Nov 2026 02:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795659491;
	bh=LQUBvpsucYn0MXvaNFNdOGS2lcFbmHtWdBHiuR+bvsI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=l5+n1eRTGE9j6AIAyRzjQe/w4VI7wW1qmM4hiEidqSJ8JqcusW2kfRIo19XqMlDH8
	 63SXriiJ/JYbvTNiCCrbh3kIqtfHg8Jwyc2XZzgwFfgU3DrE1bAwoYGMn2SZWgwwci
	 QRih/z5S5dKUtZK7QiE3mbgk4wkL1VKvUATHXPO1izzJcbskA2Ns8NfQJ1q95kSAzz
	 AdJkZphZVj/TRM1bWazvO+oGcM4LFcRnCWM2fW12mTZDRdUXGY1AgqTo04Q11fOE/9
	 wvuEtHiiyihwZff+HSE7c50387aZ7iie881iZz8eJ5Ak9+FrB8WGNoVcX1GSVlyIzq
	 7UkfrBcD+Upuw==
Date: Thu, 26 Nov 2026 02:18:05 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: phil.williams@advisoft.co.nz, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Mario Tesi <martepisa@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: imu: st_lsm6dsx: set ts_sensitivity on parts
 without freq_fine
Message-ID: <20261126021805.3060ed3e@jic23-hlaptop>
In-Reply-To: <awaYTa63V-LnP-T-@lore-desk>
References: <20261125-st-lsm6dsx-ts-fallback-v2-1-ea0ea2512070@advisoft.co.nz>
	<awaYTa63V-LnP-T-@lore-desk>
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

On Wed, 25 Nov 2026 09:11:57 +0100
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> > From: Phil Williams <phil.williams@advisoft.co.nz>
> > 
> > Commit 8abbf45fcda0 ("iio: st_lsm6dsx: Fixed calibrated timestamp
> > calculation") takes the FIFO timestamp scale from ts_sensitivity.
> > That field is only filled in for parts that have freq_fine. The
> > untagged-FIFO parts are left at zero:
> > 
> >   LSM6DS3
> >   LSM6DS3H
> >   LSM6DSL, LSM6DSM, ISM330DLC and LSM6DS3TR-C
> > 
> > st_lsm6dsx_read_fifo() multiplies the raw counter by hw->ts_gain, so
> > every sample is published with the timestamp taken when the buffer
> > was enabled. The accelerometer and gyroscope values still update.
> > Userspace that integrates attitude from the timestamp delta treats a
> > stuck timestamp as dt = 0.
> > 
> > Set ts_sensitivity to the previous fixed scale of 25000 ns/tick on
> > those entries. They have no freq_fine register, so ts_trim_coeff is
> > left unset and no trim is applied.
> > 
> > Fixes: 8abbf45fcda0 ("iio: st_lsm6dsx: Fixed calibrated timestamp calculation")
> > Cc: stable@vger.kernel.org  
> 
> Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
> 
> > Suggested-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > Suggested-by: Jonathan Cameron <jic23@kernel.org>
> > Signed-off-by: Phil Williams <phil.williams@advisoft.co.nz>
Applied to the fixes-togreg branch of iio.git.


> > ---
> > Resending inline. The first copy went out as an attachment.
> > No code changes.
> > ---
> > Changes in v2:
> > - Drop the ts_gain fallback in st_lsm6dsx_init_hw_timer() and set
> >   .ts_sensitivity = 25000 in the LSM6DS3, LSM6DS3H and LSM6DSL settings
> >   entries instead (Lorenzo, Jonathan).
> > - Leave .ts_trim_coeff unset on those entries since they have no
> >   freq_fine register (Francesco).
> > - Link to v1: https://lore.kernel.org/r/20261116-st-lsm6dsx-ts-fallback-v1-1-8ace30afbfb5@advisoft.co.nz
> > ---
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > index 823f8ac66..dffaf76b5 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > @@ -434,6 +434,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
> >  				.addr = 0x09,
> >  				.mask = GENMASK(5, 3),
> >  			},
> > +			.ts_sensitivity = 25000,
> >  		},
> >  		.event_settings = {
> >  			.sources = {
> > @@ -601,6 +602,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
> >  				.addr = 0x09,
> >  				.mask = GENMASK(5, 3),
> >  			},
> > +			.ts_sensitivity = 25000,
> >  		},
> >  		.event_settings = {
> >  			.sources = {
> > @@ -802,6 +804,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
> >  				.addr = 0x09,
> >  				.mask = GENMASK(5, 3),
> >  			},
> > +			.ts_sensitivity = 25000,
> >  		},
> >  		.shub_settings = {
> >  			.page_mux = {
> > 
> > ---
> > base-commit: fa2933aac170dd19c6a7f0d7b81a8f537e40915c
> > change-id: 20261116-st-lsm6dsx-ts-fallback-cd21f1d1e30e
> > 
> > Best regards,
> > --  
> > Phil Williams <phil.williams@advisoft.co.nz>
> > 
> >   

