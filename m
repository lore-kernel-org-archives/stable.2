Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874C934B437;
	Sat, 17 Oct 2026 18:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792261317; cv=none; b=P743tEB10nnxD3fSQZ7tGKor60QTPesjd0ZjkY+Na+cLhS2zcmmY/GTeO/0a/Mm3oxZDBAqsMgunzSRZh/ufmAl/5HkI3SRpcQBh/4qA3nD+qVrd7we7lvLqmGAjoTkgjLzMAXyh5wB9T3nuJrqDgl2gOD+yty6jyGkbpRktNtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792261317; c=relaxed/simple;
	bh=QETSnqD9zHjeV9yBvtwla31e3iQ8e0pj8gX4m8227gM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KsAGg6QVICjpn09aALSKr00eKP7UTLdT9ej7iroBxQgBXbKF7dMDwrbgjgGp/92+HmbAV/WH6T/0OLey16AmmtnYLuh7sTuSR2pZg/DbToFUm3fZCeU6JJBPKM4KUo4rZWwjUX6NWbFNA4I4guWyoz1dXEh623ZzVxWh9RSDJO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hpzjDh9K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hpzjDh9K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C2081F000C4;
	Sat, 17 Oct 2026 18:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792261316;
	bh=QqYFkxl/6C3+duZbw8hxCBJgXVRgxDNSm7oaIlCYRzw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hpzjDh9Kr37vLYco+W9Zre3BIC92hP01J4HKjetV0adnU4amiG4Z/xfcr7mnpoUgo
	 KYFES4x3LtrNUjYuBZqHD14ObzelHlwHt7fRpB/OKsboEjNXU6C7IVkcsXDOAOGQE9
	 jTs30YWrCEWHXNcqRHYALydFBJFE43927m+69xAPB4nTv3hmxokDlH7oQYWp4wgpFU
	 zPdyF2QxO0DEo3SRMVc7wHczuOp7S/MBuOvxGBdBm0mHvZniQaN19iGxtd4W5wItnl
	 lb4eEmafkz/S5BkX+UfET9Xp/ciy3tCwKQf/unFa2wUqN0eIv4gJeoOALmagQyuQUf
	 SsUHCVrlDqN2Q==
Date: Sat, 17 Oct 2026 19:21:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, Dingisoul
 <dingiso.kernel@gmail.com>
Subject: Re: [PATCH v3 0/2] iio: gyro: mpu3050: add missing trigger cleanup
Message-ID: <20261017192151.15986386@jic23-hlaptop>
In-Reply-To: <20261017-mpu3050-fix-v3-0-d6f29f335a2b@gmail.com>
References: <20261017-mpu3050-fix-v3-0-d6f29f335a2b@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 17 Oct 2026 07:19:19 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> This series fixes an ignored error return value that causes the device
> to behave in a weird polling state and a subsequent use-after-free bug
> reported by Dingisoul.
> 
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
Not sure where signing off on cover letters came from. There is no need
as they don't form part of the permanent git record so DCO doesn't apply.

Series looks fine to me but given others have been actively responding
to previous versions I'll leave it a while to pick up some tags.

Thanks,

Jonathan

> ---
> Changes in v3:
> - Add a separate patch addressing the missing goto on trigger register
>   failure
> - Link to v2: https://lore.kernel.org/r/20261015-mpu3050-fix-v2-1-53f73581e62c@gmail.com
> 
> Changes in v2:
> - Add a local struct iio_trigger and assign it to the data struct only
>   after a successful IRQ request to prevent a null pointer deref as
>   pointed out by Sashiko
> - Link to v1: https://lore.kernel.org/r/20261011-mpu3050-fix-v1-1-f55b0d138be4@gmail.com
> 
> ---
> Joshua Crofts (2):
>       iio: gyro: mpu3050: fail probe() on trigger registration failure
>       iio: gyro: mpu3050: add missing trigger cleanup on remove()
> 
>  drivers/iio/gyro/mpu3050-core.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> ---
> base-commit: a3b3580713f3ac5a32dc2874ee546828977a1d68
> change-id: 20261011-mpu3050-fix-145a77d5229b
> 
> Best regards,

