Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792982235;
	b=kwhnQ6Vcejz9v2vCukvxYyH7Hv7pS8HWYUe4kP8Ur6YCxmexnTp2y4FATr1eK7/gjZW9
	 qdJ3/8VOWD1LOOiGUFOYXHFon2vfLiV/w3DaveNLYphstTzz1JaF8wCP71SbwynRu/K7i
	 BKDQmooH5ZWZZ23pkS0dA3CspO+ktVHMR7ax6vk9CDbObVXviJpKN1iKO0xr1K3VqukC6
	 E/S2JOe+bavGzejCsgcU27w/jnevAbZA6OXWJ/SRsxMONWU+/kMUD7CaF0k3bjFeGQ+xQ
	 8BPS9F7OCLCkLX2/Yk6llc8Jtv1hxclwU6VPYCYG/u+QjBYxowZfezxeAvqg5F2lTyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792982235;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=lYq05nfqgUxcLi4v/X/IWHrkdgOxcK1p03EpXP0/uf0=;
	b=ESqklaLcchAulk7QS7WXWkHWSHKQmgUAh12MNOCrS2PS0xLmhzk79sSqmlPl1QXvJlCC
	 taPxJpRawyjEwTefoL0i77/s0bzKUZhwkw8EWeN8T9A+r/Y6tLN22mA0/FauHhQm32bLE
	 A815yFg8GHTwii4kYoRVRI9JUinXV67f9izUUcFcNZJ78CwVH9lQUc5krcAZXB6c4Pwb3
	 gdpoyqWsKOV6wCAycj4A7nqRPRcO9y4OJjchtl+aXBlVfVYJe5er1TBiOs+zI2mT1hA1f
	 bDJsy8sh4bV9Fc1AxPQRdWDOV3+lKhuCzCkpXfkQCvjr0LmsxhtHmFFszrq/ndlvOpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n0SrDaff;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5CA606A31A;
	Mon, 26 Oct 2026 02:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n0SrDaff
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D71B61F01825;
	Mon, 26 Oct 2026 02:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792982234;
	bh=lYq05nfqgUxcLi4v/X/IWHrkdgOxcK1p03EpXP0/uf0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=n0SrDaff+i64/yEyNlUqUoqOGUVN1QNFWy7k+UCZ8C80FQwwxbiGgu6jYr9NBRVZc
	 dEUjG5YSBSrNG41xpx695YSv8m1dwGqkn/itEbEf9DKdCxPfTF2g8x8LmcIGYGOaFy
	 oS09u7VIx7KguiRqvJRirk9qe4yZZMg70u7bINRVHV0Mc3uk8k6crI9/rzW6KWAX4K
	 fgYMIdk4WleNJc9iGTn7KyNMM2VlmZiFK0TC/NDNpbuiSi/MfheqCNRQYBIHtc7k5A
	 bgnuaeqcHS4v0Y53W9nSX2/uDqvtd+0UzFek0ctw7tHDAItsNq7ws4apKb+DD2kULV
	 twmwV2hzPnE1g==
Date: Mon, 26 Oct 2026 02:37:09 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol via B4 Relay
 <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Cc: jean-baptiste.maneyrol@tdk.com, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] iio: inv_sensors: do not compute period estimation when
 updating odr
Message-ID: <20261026023709.0c0032e7@jic23-hlaptop>
In-Reply-To: <20261020-iio-common-inv-sensors-do-not-compute-period-when-updating-odr-v1-1-8fedaea8116d@tdk.com>
References: <20261020-iio-common-inv-sensors-do-not-compute-period-when-updating-odr-v1-1-8fedaea8116d@tdk.com>
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

On Tue, 20 Oct 2026 18:28:47 +0200
Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org> wrote:

> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> When odr is updated, the delta between the interrupts will change and it
> will lead to a bad period estimation.
> 
> Avoid this by preventing the period estimation in this case.
> 
> Fixes: 82bd09ce4fd3 ("iio: inv_sensors: improve period measurement by using a longer delay")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Applied to the fixes-togreg branch of iio.git.

