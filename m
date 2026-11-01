Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793556634;
	b=MV+58SQNWsfn+450IMw+LqkrMINgOeg7s/1k0H8Wd+9LLxuwhrcmlIU0Pvz6u2KRrBoG
	 Y7UJgwsZwHgEql5IjXoqOTVJKNHPPkjE//cV+ueTSL5zbyW0HsupvZikpkwWYyjBJtfFm
	 b7G2yz/vdCeTFYrqnc/122aS1kUjbwb9AFC0Gxse2bDC4r27HmRPCX70HVYOFfeW4kvcp
	 phjyakd8Jy9txR5snNqQk02rhUVV46m2kmYdhtXphpYi2m5VbgmOUyFsttb4lJNJZq54c
	 q09CKfxGTjPPQqmTMjHEeGdA7ClDDzqXvLvGTQp5kmDudqYLST7W2BlMpq3CxTLkjSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793556634;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=0hxWHPGkr2KljC8sKP9AzlOB+XGDxu5M2lhqfh9ZHrs=;
	b=s6euzWxwiSThgZccSMAKGD4lhGDdjZsQSifRcIijG4vQ3RTAzp4EP/1wcUamXf9g9TC6
	 boAvGTe3eI314mdFuI0CEPC2ByMZc747X0PHdRPg0xujPQO1xWAf9mWhuFU+h0MqxWhbI
	 CJ4xlv1K5CB+T3HMW9ilAHTjPfpsypwvXzN5fdcN6QGwoWxpxOvC/fSCVzSSTaWBPpeOy
	 9rZRxuFqu9/FG08UHUBYYZYKkswCD8fzuoUCUirIyDF486mh2XQwMS/iHerAlAau1WDIa
	 FCKvm9IzVjuZdWBRfjAdJH0voFw7g7uV/ZDM/AWjZW49sxejUidLQrvhn4SPskwwkdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mgjqbTkV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6DD606A324;
	Sun,  1 Nov 2026 18:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mgjqbTkV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 026731F000C1;
	Sun,  1 Nov 2026 18:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793556634;
	bh=0hxWHPGkr2KljC8sKP9AzlOB+XGDxu5M2lhqfh9ZHrs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mgjqbTkV/wqm3aG+dhiuBnca1/A5JAH/J18T4t38XCAI/1r3WQUvr5I4+gMhBHRyc
	 5esa5QU+9KHh1X9qb8Eyxkxyb4gsw9/ZXsUnku5CWNuMzjNH0Df5xLoCrdPBmhQAzG
	 khYHTJ3hPjz0qu5ug7BwkfX5pmDTUKSeuEDJwsBRJ1HVvyQBpeiLVlu9fF1nK5fDv0
	 XOJGN/OIx0INususzJMP9orpEEZISjqe1U6GSnlrzLC94lCIzIyiRmFjqFTfQHu9Yg
	 5Go2cS4tmfVSQEun/vuiHqT7eynmzOw5zPD/1mPkGAMB0JQ7DKhAr060A1NI9hCDGF
	 jeo8DgPojlLjA==
Date: Sun, 1 Nov 2026 18:10:28 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Liu Yufei <lyf98405@gmail.com>, Alex Lanzano <lanzano.alex@gmail.com>,
 David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Gustavo Silva
 <gustavograzs@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: imu: bmi270: fix zero timestamp in triggered
 buffer
Message-ID: <20261101181028.7ff3c23f@jic23-hlaptop>
In-Reply-To: <auNHyQGAcTcq8G2V@ashevche-desk.local>
References: <20261028-bmi270-fix-timestamp-v1-1-99c0e5fe7d0c@gmail.com>
	<auG5MXTh9ZkXMw55@ashevche-desk.local>
	<auID4_vQSZXuNk0Q@gmail.com>
	<auNHyQGAcTcq8G2V@ashevche-desk.local>
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

On Thu, 29 Oct 2026 15:19:05 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Oct 28, 2026 at 10:24:11PM +0800, Liu Yufei wrote:
> > On Wed, Oct 28, 2026 at 10:58:25AM +0200, Andy Shevchenko wrote:  
> > > On Wed, Oct 28, 2026 at 10:59:26AM +0800, Liu Yufei wrote:  
> 
> ...
> 
> > > > +	s64 timestamp = iio_get_time_ns(indio_dev);  
> > >
> > > Do we need this variable? Why not call it directly?  
> > 
> > The intent was to capture the timestamp before the bus read, so it is
> > as close as possible to the data ready event rather than after the
> > regmap_bulk_read() over I2C/SPI.
> > 
> > If that difference is not considered significant here, I'm happy to
> > call it directly in v2.  
> 
> But the time of the event in the kernel should be ideally with data we get,
> not in the past, right?
> 
> Jonathan, what our expectations / requirements on the timestamp capture?
> 
As close to data capture as possible.  For drivers with a dataready
we grab early in the interrupt handling. Where it is being driven by
something else (such as polling elsewhere that didn't grab a timestamp)
we grab at time of read as that's the best we can do.

Jonathan


