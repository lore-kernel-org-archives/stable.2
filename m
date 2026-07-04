Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9712745E;
	Sat,  4 Jul 2026 23:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783206174; cv=none; b=pgC5fQJ6Dok4MZkfSeo86OdKwjGRfe3jw/IiKkRiUm7/jAKFj10saTYffQXgaIo7bJm3uj/AEd6H3X0wrlKt5/VGU/S+pjzjBWsT1YYkIdX7DH6bgfV9HxHMZif0Rby4lr5dTuFWhZ1fIjGSMifLoJyNHavxTjOVkxD01AbVBqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783206174; c=relaxed/simple;
	bh=wXIEMPdC6Er9iIYlanGeGdxwew/cKQhTPjmDWaMWD4A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a7166WBQwfi6wPy+xEWih39jiJmZ0Jf+uibsVn50sXR1hlGjY84GdVzwoHe4B4FNjN37DIEdzjyGaP7z/8QaNsPFy7hAnT4sQHOe61lYoIZem6FnUQa1hDiCwkYcint3Td+vrao/elnLdDDVPBtRFVukARjqLO3jo7o9/Sgw0gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h67+KYn6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h67+KYn6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 862CD1F000E9;
	Sat,  4 Jul 2026 23:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783206173;
	bh=0768mBwHe2Molg2SRCkHhLeJGImarGUSJmRvZS7FwDE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=h67+KYn6VCvLEQIo2TqVBhkODGVnZevD8Y2Gb81SE1s9FNRO38RmJzExO0g1OXpTb
	 tDftCor6/g134FUdez5XpMKCJC23Lo0zquBj0tU1MKSSvFTgWav0+EKZMl9di2kpgo
	 XygIeQEVMDZAMNVg9HH0gWf9bYpeOYr8lj6zQwd9jUR/vKl3Vf3IQNzKFIMAzxLRUZ
	 evJhIVKyjjUexaMFQQ4+I3qlCoyXkYuVlBHhbBujS6WCkbppnNG8gSaMJSTAteG1ff
	 +nZcKBkLxjJCs9au4DIabs4ZrBYup0CZMnmkVMQhrr3wSD2LDIFOVf6Pvzh393kOXr
	 oyVyUr7NVg1DQ==
Date: Sun, 5 Jul 2026 00:02:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jean-Baptiste Maneyrol via B4 Relay
 <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>,
 jean-baptiste.maneyrol@tdk.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: imu: inv_icm42600: fix timestamping by limiting
 FIFO reading
Message-ID: <20260705000246.1d168743@jic23-huawei>
In-Reply-To: <akjzIfY5xnA6ahM0@ashevche-desk.local>
References: <20260629-inv-icm42600-fix-watermark-fifo-reading-v2-1-967e375db7b3@tdk.com>
	<20260703200455.5fa70e5b@jic23-huawei>
	<akjzIfY5xnA6ahM0@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 4 Jul 2026 14:48:49 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Fri, Jul 03, 2026 at 08:04:55PM +0100, Jonathan Cameron wrote:
> > On Mon, 29 Jun 2026 21:51:55 +0200
> > Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org> wrote:
> >   
> > > From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> > > 
> > > Timestamps are made by measuring the chip clock using the watermark
> > > interrupts. If we read more than watermark samples as done today, we
> > > are reducing the period between interrupts and distort the time
> > > measurement. Fix that by reading only watermark samples in the
> > > interrupt case.
> > > 
> > > Fixes: 7f85e42a6c54 ("iio: imu: inv_icm42600: add buffer support in iio devices")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
> > > ---
> > > Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>  
> > 
> > That's not confusing at all :)
> > 
> > I've applied with the invensense one only - shout if you want something else.  
> 
> But the From should be equal to SoB, that's the requirement. So if you also
> changed the authorship to follow it's fine, otherwise you need to use @tdk one
> in SoB (and that's what I think was the initial intention).
> 


Good point.  Flipped to using only the tdk one.

J
