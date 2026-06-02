Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F58D3D349A;
	Tue,  2 Jun 2026 10:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780395475; cv=none; b=eVJPWhEA4bKAb3buBXyGMAyR24oY7zGjM72wboJnipoUD02VaOX2C1arVOrsb5NWmx6BMY3Gs5PKCkcleeyd1+miaPio8ooD0ubxJeu9n5UlhLHusT+HyM7my7KRMSz68JnJwm1rMNBwCAJ1WuFRppEiKiEqI5YYo6V4Ya+h1ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780395475; c=relaxed/simple;
	bh=0Xwc8J6pstK6FPuxfGfZ0a8ZZw6vYlDnpkOAwM1wCZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eSD8LxjshX7Iflbmn33a7DgYvl5nNTbbFV0SGrgaXf9IJDJdJqNRvjPpSTHYOppsPnLArMTayD5+3ktECN/NIj11E54ZYo9mvZZeZ9/sngN6WKMdAHmYN+D/Hmwh+c6Js22zFkQprOf0Zkykz/uJ0R6ZFGaBEyQTY7zw1/fcMzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OGtn0kJe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OGtn0kJe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DCD41F00893;
	Tue,  2 Jun 2026 10:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780395474;
	bh=sOUTmCnODvoRiB4svT1aqcrWncFRBiBKgj63J/VkJHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OGtn0kJepFBMpmV/220GBzd6lN8Zh5Ff7HU69LeZuDR8hWPfTDHKD/sBawoZyNrFq
	 3IBM2Xy7XgsdN1pgaqsishkuXS/csW7fsh/ZW3+R8j/dWyrLLuQPGnrjoUYaKIbWdc
	 xIdc8IZUYN3uUMonCJne59IjM56Wsbz/MgRJ2wUjLUy4zzG0xNPNd1Y8eT9wzwZfSB
	 FhJt5QqTY8aBmD1ehPRte4vp6z54hH2fnvXAHpHJWH3XwNilhf1S8EubxS1gornIMj
	 pNIjbpbOdd0gX74B1C+KlxpbjZdoa3ZyFtc0FJ/sCZkQ/zFUXQ6hvrWQC/ynQloAfL
	 2MAdALfjbkbsw==
Received: from johan by xi.lan with local (Exim 4.99.3)
	(envelope-from <johan@kernel.org>)
	id 1wUMBz-0000000ACp1-2ZbO;
	Tue, 02 Jun 2026 12:17:51 +0200
Date: Tue, 2 Jun 2026 12:17:51 +0200
From: Johan Hovold <johan@kernel.org>
To: Adrian Korwel <adriank20047@gmail.com>
Cc: linux-usb@vger.kernel.org, gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] USB: serial: io_ti: fix heap overflow in
 get_manuf_info()
Message-ID: <ah6tz1s90zvxaPef@hovoldconsulting.com>
References: <2026052525-devotee-reclaim-7673@gregkh>
 <20260525145832.2941-1-adriank20047@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525145832.2941-1-adriank20047@gmail.com>

On Mon, May 25, 2026 at 09:58:31AM -0500, Adrian Korwel wrote:
> get_manuf_info() reads le16_to_cpu(rom_desc->Size) bytes from the
> device I2C EEPROM into a buffer allocated with kmalloc_obj(), which
> is sizeof(struct edge_ti_manuf_descriptor) = 10 bytes.
> 
> The Size field comes from the device and is only validated to fit
> within TI_MAX_I2C_SIZE (16384 bytes),

get_descriptor_addr() does not validate this, but apparently
check_i2c_image() has already done so. I added a comment about that
since it's not obvious.

> not against the destination
> buffer size. A malicious USB device can therefore set Size to any
> value up to 16383, causing a heap overflow of up to 16373 bytes
> when plugged into a host running this driver.

You also need to account for the first two bytes and the header so these
numbers should be 16377 and 16367, right?
 
> valid_csum() is called after read_rom() and also iterates
> buffer[0..Size-1], compounding the out-of-bounds access.
> 
> Fix by rejecting descriptors larger than the destination struct
> before calling read_rom().

We should also make sure that the descriptor is not too short so I
amended the patch when applying.

End result is here:

	https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git/commit/?h=usb-linus&id=183c1076eca43bbb3e7bdf597456f91d81c73e74

> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Adrian Korwel <adriank20047@gmail.com>

Both fixes now applied, thanks.

Johan
