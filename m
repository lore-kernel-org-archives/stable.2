Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35218145A1F;
	Sun,  9 Aug 2026 23:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786318146; cv=none; b=iXYbMkdZnbZLa8LDqEpdVcXfL9waJYaOfZ7qB27l9irzwYebxtoP2gtMM2KE8lQvbUrgMEqIXemsC+Ehs20AH5zlBk3grynVQuvYx/fI7Q6fJrY/6u/stMOyqrF0HN34IR4XZppoikGL35dkQfRSZXtN2g3XHpWM3ZtFaTA0wek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786318146; c=relaxed/simple;
	bh=lH6hCaoxJ9qNZV1NhVvH1hhkfFg0CwlqvGP6Pk4nQ0U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nPjra3Vq79x42rmO2yzUEk/TY9YfgTTObdiZBYhJJ8W+cZELSER5ZQgZLcajpz1XwTNwKGOLD+tFST2YcwP8cgCVOYLHEZRKny+j9NydDK7HLix7TmbS4n3KGU3qZEK7F2ul8j1LHd5Z8U2ZuhXiB8mybzxxxt7AoPMKcqISO34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aYoSwoOk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aYoSwoOk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F3B91F000E9;
	Sun,  9 Aug 2026 23:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786318144;
	bh=ESoj1CSYNXs4T5zv6fkm/gcAMz0k6ko6BHpxZHfwO+o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aYoSwoOkWDB/9srUE7IEwIuFKWWrdx2hHTejHBy+QhN1W0XMow+uAwrbuA9OqITrj
	 nKMWJP8XTLfxO6R6CpCSPTQ7nf/01Z6uehVvrOcKINOayP9niB+eV6EX0TbyrfqS7/
	 cAwPYWvpRRufuaHWregN5tRBMBKwgBx1+WXBDPbX4+2wmHQMXZ0dqSpmb1z5YLZ0ob
	 Q2rMpTpuFT+V++n4+QxbjObNUy6RICNuyGXLNq9qpwPrOKS3nNe0F/w44uvHcS4Psi
	 Mg6SjuMildDPimSxIu58gyZvxYGnBtavv3n1pTPQT1L2bB1ZZQTrkBhZDII2h+ma/V
	 rzegzNa33/FaQ==
Date: Mon, 10 Aug 2026 00:29:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Shengzhuo Wei" <me@cherr.cc>
Cc: "Marcelo Schmitt" <marcelo.schmitt@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, "Michael Hennerich" <Michael.Hennerich@analog.com>,
 "David Lechner" <dlechner@baylibre.com>, "Andy Shevchenko"
 <andy@kernel.org>, "Cosmin Tanislav" <demonsingur@gmail.com>,
 <linux@analog.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] iio: accel: adxl367: clamp FIFO sample count
Message-ID: <20260810002900.4b95dbb7@jic23-huawei>
In-Reply-To: <20260809-adxl367-fifo-clamp-v1-1-6eb35eaebcde@cherr.cc>
References: <20260809-adxl367-fifo-clamp-v1-1-6eb35eaebcde@cherr.cc>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 09 Aug 2026 06:32:37 +0800
"Shengzhuo Wei" <me@cherr.cc> wrote:

> The FIFO entry count is a 10-bit device-reported value and can therefore
> be as large as 1023. fifo_buf[], however, only has room for
> ADXL367_FIFO_SIZE (512) entries.
> 
> After rounding the count down to a multiple of fifo_set_size,
> adxl367_push_fifo_data() uses it directly as the length of a bulk FIFO
> read. If the reported count exceeds ADXL367_FIFO_SIZE, this can
> overflow fifo_buf.
> 
> Clamp the reported entry count to the size of fifo_buf before rounding
> it down.
> 
> Fixes: cbab791c5e2a ("iio: accel: add ADXL367 driver")
Same comments as previous patch.

For 'similar' fixes like this, even though they are to different
drivers I'd put them in a series.  Makes it easy for reviewers
to post comments on the whole series.

Jonathan

> Cc: stable@vger.kernel.org
> Assisted-by: GLM:5.2
> Signed-off-by: Shengzhuo Wei <me@cherr.cc>
> ---
>  drivers/iio/accel/adxl367.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/accel/adxl367.c b/drivers/iio/accel/adxl367.c
> index 8c3de11a10a37d228f8758b688156e3ee958c4e9..c82f6c8e5a0d8f4a66ea6c97b78c3838f6138502 100644
> --- a/drivers/iio/accel/adxl367.c
> +++ b/drivers/iio/accel/adxl367.c
> @@ -787,6 +787,7 @@ static bool adxl367_push_fifo_data(struct iio_dev *indio_dev, u8 status,
>  	if (!FIELD_GET(ADXL367_STATUS_FIFO_FULL_MASK, status))
>  		return false;
>  
> +	fifo_entries = min(fifo_entries, ADXL367_FIFO_SIZE);
>  	fifo_entries -= fifo_entries % st->fifo_set_size;
>  
>  	ret = st->ops->read_fifo(st->context, st->fifo_buf, fifo_entries);
> 
> ---
> base-commit: 848acc8ffe1b7cd5f1bf427b93069becfebc2c9d
> change-id: 20260809-adxl367-fifo-clamp-50f2110e03f8
> 
> Best regards,

