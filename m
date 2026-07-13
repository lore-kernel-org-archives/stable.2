Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC13D3E317F;
	Mon, 13 Jul 2026 09:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783935878; cv=none; b=owu5k5DkVL5x6+7EPKk11sxsbnVyNtDjUzWDmrN7V6pM2+rnz1koYGQkbKXB1Q8siTptXjJWYxVxxsxwpSBgIw84bTAHZz8DqLzBR0ODedSEO3pjmUp89sy4r97HMShqE8gT8nHAeWRIm22jmuwxvq55I/jpmhHonDLNsNHCGt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783935878; c=relaxed/simple;
	bh=+7gAFvFLFPoQRgPokJTx11BL8sBGtpxgHRyIubmkZc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C15fqPprNTKRWgky8Eruc0Z5fNPyz7O5M5/k346kv5m57U4qqFt9wCA7FrdaPu9OM6gkFoM9FIZ31P4mX49UAZKiEjSj0gTkymoJxE4ObVMoepHLiuBAY/Xxg7lX4YA7gemA3b8qFgscAXwwzTgyYitCyIWkzo14uzOfR6s3ArE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nEMjW7be; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nEMjW7be"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C64F11F000E9;
	Mon, 13 Jul 2026 09:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783935875;
	bh=qxsGI9Zyteh6FG0mUQ4jl9Xk+5ewuaH192RWKWhC658=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nEMjW7beRgVnP/HuOCkTspA4zut9iVLrKUoi6uGr8piXfy2cRvJGlDdhmckX4mEez
	 9FM7WYjkNvfOzqq15ZnyvZueYdx7boqMKVkDPZWj9s5DyCCP/i7cyagRb0dYea8bgm
	 qlZvphc06TXryMV8/84bJz8GzzVrKrbyteU7zKjf98rBBTHEupN4rJ9XJWYqMSxDRU
	 BBmNsgFA72HbPo9M82npnClwcibrKADo4iN3nB6JoZl0yivEF81y2pVDuRx4CktARv
	 ag4NcFdlJmp4zkjVdQgh+GsVJXyfRIJ2z/+EhtTdFrpdLkj7i/6bRGMQM1QPiD3Upy
	 V8H8Mj8aHZFwQ==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1wjDDF-00000004xUs-2KnB;
	Mon, 13 Jul 2026 11:44:33 +0200
Date: Mon, 13 Jul 2026 11:44:33 +0200
From: Johan Hovold <johan@kernel.org>
To: Tim Pambor <timpambor@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] USB: serial: ftdi_sio: add support for E+H FXA291
Message-ID: <alSzgeKQIiYP8T7g@hovoldconsulting.com>
References: <20260711-fxa291-v1-1-cbd0b2652a9f@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260711-fxa291-v1-1-cbd0b2652a9f@gmail.com>

On Sat, Jul 11, 2026 at 05:36:30PM +0000, Tim Pambor wrote:
> The Commubox FXA291 by Endress+Hauser AG is a USB serial converter
> based on FT232B which is used to communicate with field devices.
> 
> It enumerates using the FTDI vendor ID and a custom PID.
> 
> usb 1-9: New USB device found, idVendor=0403, idProduct=e510, bcdDevice= 4.00
> usb 1-9: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> usb 1-9: Product: FXA291
> usb 1-9: Manufacturer: Endress+Hauser
> usb 1-9: SerialNumber: 00000000
> ftdi_sio 1-9:1.0: FTDI USB Serial Device converter detected
> usb 1-9: Detected FT232B
> usb 1-9: FTDI USB Serial Device converter now attached to ttyUSB0
> 
> Signed-off-by: Tim Pambor <timpambor@gmail.com>
> Cc: stable@vger.kernel.org

Applied, thanks.

Johan
