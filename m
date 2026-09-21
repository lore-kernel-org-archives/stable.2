Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B962D7DFE;
	Mon, 21 Sep 2026 01:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789955916; cv=none; b=PjwMeWzrphg7DyNuQaLrxocDhPr/Adv/S2WUCzebe1o1YNGhSHuV67J4aogB/bN7W/KdXHQc07XB6E4W79g7z16SlcL80yBTAMoWDQCEiUJ2LdGJw5/issA/IMaNEdVZndOZXYyeBFuaorCj9xd2AMzr1gaeImcG4xbNvAYvqV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789955916; c=relaxed/simple;
	bh=5coExd6InwyjV2N9ObND15XZVAjB5K61znmv8sLq8Z8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IJYlSkcofuynnL1olCOLuNfVI2YuTwdnfmAcPHJhPjmOEHqHsn6fWj4tdpk9SeUwtycM0Dnyb2k7MbfJdMzB/UbbDeTFL+alA2MDZFGtnFlS9VL9AhvDQ6s5EoN/ocpWoTYiN9tC3oKYvTnnKVC2XlXaUkqzhxYHcqtNnQ7da7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ud/7jvuI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ud/7jvuI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18D341F000FF;
	Mon, 21 Sep 2026 01:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789955915;
	bh=CmDQvve4IUQ8n9Vbugtsr6C9/eRnJcWDnccLZOqsG3A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Ud/7jvuIAA5dClkGFEPa89n4vj9mBYYxCE7CbFlmix3uVBe2xusVRo8OofhhTK1Yz
	 9EbWD0wIjYKwzxlzXtQZNdgwlYpB4uZJgUvntMl2tdo/Ym2Vnag8iuQJMWLZm04OQ+
	 0S/HzR75ja5tsyVCr9LM+SBrN0PPGnTy6Pn1EFQlrEo1/c9P1usW9+MTUYZbGRVfl7
	 XRUheL0I09MaJvzujGFwaDsddepxcJEkRy2tfciK9eFzlkedeFbghUhtSHWN9wPfdV
	 TFcjfRRO0O3tCjc4QJ14XXA6W+kOGXPCrJKXNfD7O6BNe3oAgmPdT21ul1XzcYhOiT
	 /0h774iNPEgJg==
Date: Mon, 21 Sep 2026 02:58:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol via B4 Relay
 <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Cc: jean-baptiste.maneyrol@tdk.com, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] iio: imu: inv_icm42600: force accel odr change when
 switching power mode
Message-ID: <20260921025822.3494f4b8@jic23-hlaptop>
In-Reply-To: <20260914-iio-imu-inv-icm42600-fix-odr-change-event-issue-when-switching-power-mode-v1-1-9bbe0cb3eb07@tdk.com>
References: <20260914-iio-imu-inv-icm42600-fix-odr-change-event-issue-when-switching-power-mode-v1-1-9bbe0cb3eb07@tdk.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Sep 2026 14:43:42 +0200
Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org> wrote:

> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> When accel must switch from low-power mode to low-noise due to a change in
> ODR, there is an hardware bug that sometimes prevent the ODR change flag
> to be set in the FIFO header. If this happens, the driver is stuck waiting
> for the ODR change flag that is never happening.
> 
> Fix this by using accel_force_odr flag set when switching mode for forcing
> apply of ODR change. Do the apply after parsing FIFO data to let the flag
> do the job if it is here.
> 
> Fixes: ec74ae9fd37c ("iio: imu: inv_icm42600: add accurate timestamping")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.
Applied to the testing branch of iio.git.
Most likely any fixes now that don't need to be rushed in will
be queued for the next merge window.

Thanks

Jonathan
