Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795302840;
	b=nOtVitGlXS/xJJbs8Tv59S2KDFYL89x7ZmAyG07EFTSHdkREAI3WedmPVdzFNR2VOm5R
	 WTmQZIL1PjQ/ZQ/piUw2V8LDzpr9rMe+6Pm2F80GHcKTQQOqZ1xS8JLTTKd3THRkVPNGJ
	 SlcsWcPDfAQIaWUoWa85/MRhSLW6htzp/2j6RgiaiE092AkWc9Hy4dEVDJZlz+E7aqgJr
	 QW35HiC332bnVDxcGhWC94cpNKLLZf2jwtVxdNPub0whuuT5F8N5e7lny7PAmKJVLeM1v
	 w1u467XliwBKSRxSIPTZvS2LhIUX4tRH8TNJ2OaI4s/FLejDymnjy3JB4kAJ3xHEVYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795302840;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=usOW7zkOKd+CsW2sizPj373F9nTRk2BJ1UL0D9Za7Rg=;
	b=xwpYN0xQAwH11UX+wn7NCEa6IVxS+8sfBUTqEuCZObmNSJL+gcOlSeIg2ZkajiE3cUmU
	 Ol4q5/PCbJGqnGKIR7ZLQ6a9j/fw9REZWt/QffTQqUrDRDORwLxYosRW5A+EmrTpK4fQY
	 7StRXpjfYQK8GDgv/I0YFwpFfhuwMLxF0w2ct9ZAGzLYdVWsfXMNlbgvQ/nRXp0wLVWub
	 uARJu5yf3uA1cdjV1M7moZBWEeIU8gXcgXzUWyrf+9MDRGXpibVlYMiPezj/ArV5UJrDI
	 B7Nv0t8v9MoBhKLIvNGxiQ5SkhycOF0TqYVtEScX/057tgBv8sEmGjo58JkyJ978Atw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="jRhz//rL";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF17606A320;
	Sat, 21 Nov 2026 23:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jRhz//rL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B14991F000CA;
	Sat, 21 Nov 2026 23:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795302839;
	bh=usOW7zkOKd+CsW2sizPj373F9nTRk2BJ1UL0D9Za7Rg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jRhz//rLE7ydUSPwJWr9CTfcCk3pqiYRoAubNhAezdfGfCz/SGwPZPjBeiuVkqZI0
	 JhMMRtEuNUP1LUCfJlj01BQn2TBj2EOvp1cVaK+44RwT1V0KfMJMv6JFkER8y6/Pe2
	 bnpo+B9cS+nx/T2Nd3Pm1VRqmGTZVVhHs4at0+68ch/fRXC+u92jzmHZMykd89s8LW
	 efEn1oBzI+jPlEvfCnXkGg+E8HMw/BA+OCiRqXM5gcxgab3sNyBF9XgjHueg4IKc/r
	 69IVsNGZ7JZguLfVD/bVTWMbYChhqruf4pwnEJvfWYrpuXDMhl2RuYsA//DZQEGcqR
	 +Y3aHaQVyt8AQ==
Date: Sat, 21 Nov 2026 23:13:54 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Joe Sandom
 <joe.g.sandom@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 10/10] iio: light: tsl2591: Prevent infinite recursion
 on threshold boundaries
Message-ID: <20261121231354.4aba2068@jic23-hlaptop>
In-Reply-To: <20261119153151.1397003-11-lee@kernel.org>
References: <20261119153151.1397003-1-lee@kernel.org>
	<20261119153151.1397003-11-lee@kernel.org>
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

On Thu, 19 Nov 2026 15:30:43 +0000
Lee Jones <lee@kernel.org> wrote:

> tsl2591_set_als_lower_threshold() adjusts the upper threshold to
> als_lower_threshold + 1 whenever the new lower threshold is greater than
> or equal to the current upper threshold, and
> tsl2591_set_als_upper_threshold() symmetrically adjusts the lower
> threshold to als_upper_threshold - 1.
> 
> Writing 65535 (TSL2591_ALS_MAX_VALUE) to the falling threshold wraps the
> 16-bit addition to 0 and calls tsl2591_set_als_upper_threshold(chip, 0),
> which then wraps 0 - 1 back to 65535 and calls
> tsl2591_set_als_lower_threshold(chip, 65535) in an infinite mutual
> recursion until the kernel stack overflows.  Writing 0 to the rising
> threshold triggers the same cycle whenever the lower threshold is
> non-zero.
> 
> Reject als_lower_threshold == TSL2591_ALS_MAX_VALUE and
> als_upper_threshold == 0 with -EINVAL, propagate errors from the
> cross-calls, and only update chip->als_settings once the I2C writes
> succeed.
> 
> Fixes: 2335f0d7c790 ("iio: light: Added AMS tsl2591 driver implementation")
> Closes: https://sashiko.dev/#/bug/linux-29f0f993-c799-4717-9daa-d0ad367f4e6d
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
Ouch.
Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan
