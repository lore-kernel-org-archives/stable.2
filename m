Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795300328;
	b=W7rqCZsv3cOxDkHFaUgF4LtIzHAOlufZ4j22RNA49m8bHOPKlfJKybUmjue5KTf1ZzRW
	 TsHTcU1qdIsT8rmVYNUPsrz0XvguhLzoiloikuB0/VVRmuClK/JzkFMLXxI+wnO11QUZb
	 LbtNyW9nucMWTbikhH5HDWlvWINrwac7Bfgt/4oxPEPvUtd4qYUS8eTuh2PRk7f4H9aF9
	 uaPCy2K+mPN4CGFKxTTFVGrzRxs/XLnb1crZ/3vRiNM7vvzKFMITBBPVxUxqhXHGCCHoQ
	 hTrc+nhdsnX0dUIVI3kfUUsPoGEhZ3ckKudNMMO/KkwVqlVxVm68YCRurWv8W+dh8ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795300328;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=m3bHg0Khc+Y2PaG9p3f/n+UpGEPji0VInlhNOxhqNcE=;
	b=wOky+URlBVov0/8XwPn2dwMcNniuIqojbnfmaXbcO63KVaUgqLpBW3weSpUk28zcKouf
	 CDGeMINAgSS1lv99O7EQm/nshVk2L+bztMrZTrgHKOSAVRScM3Sd8mHicUqeEEXZvIWxE
	 n+BvhI3P8F5s1pH9JKpgwYu0rNXtJHmD7y6Gih06pwhC0nqB9dHqdwNQOsVEB61AdyadZ
	 HHCQaocixwXKj/J638zy7y7uXtQy75DjfFzkHdoomkO/HZFAAd3iISB1OFc/MuW3LH6/w
	 32ynsq1LzcJLNhkGRTLZL7c4Hv0BDDuY+uWgDAmaLi01YQZPHgPO5qAqHdwkMdAnHgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mtkLaZSC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8FC606A320;
	Sat, 21 Nov 2026 22:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mtkLaZSC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE6741F000C0;
	Sat, 21 Nov 2026 22:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795300328;
	bh=m3bHg0Khc+Y2PaG9p3f/n+UpGEPji0VInlhNOxhqNcE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mtkLaZSC652+YO1ko95DhUWwhbnqVryzM7/pZmHBkYz+hX6mze30R+9EW3HjVYa6J
	 d3As2+j+e3RCojwZ/UupasIwbxq5ZJ1RjC0IuxhQkZRni2burFtE6+gL1xER/GhEU0
	 Qus/q6uz2WH1XKpIgIP2rbDzD9ihuPHUgHwkBhJ5cGmX5fjRbvhwJrt6tPAOKuZ22z
	 Qeljte5qY4ja6DJV1PMvIqico/hYlfG5QK/cJCpi0YnjWDCBYc/wTdFc+5OAHZ5DwF
	 FarBK1EecMmnIP4yG622eLNQY7BPTiwdF1owpzguTK30xvwcqvG9cXhlIjttH+ik2Q
	 gOjsd6V1emepA==
Date: Sat, 21 Nov 2026 22:32:02 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Lee Jones <lee@kernel.org>, Lucas Stankus <lucas.p.stankus@gmail.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Lothar Rubusch <l.rubusch@gmail.com>,
 linux@analog.com, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH 02/10] iio: accel: adxl313: Prevent FIFO buffer overflow
 in adxl313_fifo_transfer()
Message-ID: <20261121223202.6b69d61e@jic23-hlaptop>
In-Reply-To: <av8wSW6-ukmvRDnp@ashevche-desk.local>
References: <20261119153151.1397003-1-lee@kernel.org>
	<20261119153151.1397003-3-lee@kernel.org>
	<av8wSW6-ukmvRDnp@ashevche-desk.local>
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

On Thu, 19 Nov 2026 19:22:17 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Thu, Nov 19, 2026 at 03:30:35PM +0000, Lee Jones wrote:
> > The ADXL313 32-entry FIFO plus one sample held in the output filter can
> > yield up to 33 3-axis samples (ADXL313_FIFO_SIZE + 1).  Because of
> > missing parentheses in ADXL313_NUM_AXIS * ADXL313_FIFO_SIZE + 1,
> > fifo_buf is sized at 97 16-bit elements instead of 99, overflowing the
> > buffer by four bytes whenever all 33 entries are read.
> > 
> > In addition, adxl313_get_samples() returns the 6-bit FIFO_STATUS entries
> > field (0..63) without bounds checking, allowing a malfunctioning or
> > spoofed bus device to overflow fifo_buf on the heap in
> > adxl313_fifo_transfer().
> > 
> > Parenthesise (ADXL313_FIFO_SIZE + 1) when sizing fifo_buf and reject
> > entry counts exceeding ADXL313_FIFO_SIZE + 1 in adxl313_get_samples().  
> 
> ...
> 
> > -	return FIELD_GET(ADXL313_REG_FIFO_STATUS_ENTRIES_MSK, regval);
> > +	/* 32 FIFO entries plus 1 entry at the output filter */
> > +	ret = FIELD_GET(ADXL313_REG_FIFO_STATUS_ENTRIES_MSK, regval);
> > +	if (ret > ADXL313_FIFO_SIZE + 1)
> > +		return -EINVAL;  
> 
> ERANGE? EIO? EPROTO? (I think from the listed the first suits better, but maybe
> in errno.h a better one is lurking.)

EIO would be my preference given it's a sign of corrupt message or broken
hardware. I can tweak whilst applying if everyone is fine with that.

> 
> > +	return ret;  
> 

