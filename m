Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2DB3ED11B;
	Mon, 24 Aug 2026 13:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787578014; cv=none; b=humUmu1aZQlKAYKSwbl8qPS/uSzibcj2wzOyXBiWF4wk0vp20O3V+smdML29zyKT2sAYKhxllJ/lWKOJmW7+Bd9UQ5+Ckw/GouvmaVAxVgHd4L5X2Tyfj/FMJjuPvUw5/EJCjizLWg/S05iEpFXBpKX8Hd4rbD4DVGDTIkiavIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787578014; c=relaxed/simple;
	bh=FMJbQtMMgNNbORcoge09ddpIMw6e5QqLTU2uTn8kpP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qeR8Do3VQhmh723gA+7gYh7u9ZDHy4JAFqcV8JxVNcEZejSGzyEWXamtrNByNjLr2CM5bzGVhBXlDtmtUYx7fZzxqymXQyQhfGCCKMxza68KWJeViIURCgsughg/z2Qvkzu91bJci7iDqf/+Q5tmZUkhqy8I/pYhBh0iGI0IIB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X7TtIcMT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X7TtIcMT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F98F1F000E9;
	Mon, 24 Aug 2026 13:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787578012;
	bh=KKdPmuKxsjqwqACAUmiBDhB0JrLkRUVVpBePnsfePhg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=X7TtIcMTg6DLA9TOqA/ARJ62HGd1JhujT54HfQl/WI3oxQMsSboxrTF6xTlpbGJBO
	 4fllMcMui2271vLeLw6WH57SQvKn4MwJYYR044uTqkjOii1zgAArV2FmyRUsNCf1gn
	 ptKx3MnMxf7Xh7ZXxzoyfIPTsq7ZKjgO+MsRCxRE=
Date: Mon, 24 Aug 2026 15:26:49 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: peter_hong@fintek.com.tw
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	"Dynetrex, Admin" <admin@dynetrex.com>
Subject: Re: [PATCH v2] can: usb: f81604: fix struct f81604_int_data size
 mismatch
Message-ID: <2026082440-subgroup-breeding-b73e@gregkh>
References: <20260824-f81604-fix-v2-1-fc9be5581394@fintek.com.tw>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824-f81604-fix-v2-1-fc9be5581394@fintek.com.tw>

On Mon, Aug 24, 2026 at 09:18:14PM +0800, Ji-Ze Hong via B4 Relay wrote:
> From: "Ji-Ze Hong (Peter Hong)" <peter_hong@fintek.com.tw>
> 
> The struct f81604_int_data defines 9 bytes of interrupt data:
> - Byte 0: Status register (sr)
> - Byte 1: Interrupt register (isrc)
> - Byte 2: Interrupt enable register (ier)
> - Byte 3: Arbitration lost capture (alc)
> - Byte 4: Error code capture (ecc)
> - Byte 5: Error warning limit register (ewlr)
> - Byte 6: RX error counter (rxerr)
> - Byte 7: TX error counter (txerr)
> - Byte 8: Reserved (val)
> 
> The hardware sends exactly 9 bytes for the interrupt endpoint.
> However, the struct was defined with __aligned(4) attribute which
> caused the compiler to pad the struct to 12 bytes.
> 
> This causes a problem in f81604_read_int_callback() where the short
> URB check compares urb->actual_length against sizeof(*data). When
> sizeof(struct f81604_int_data) is 12 but the hardware only sends 9
> bytes, the check fails and valid interrupt messages are discarded.
> 
> This results in the driver only being able to transmit once because
> the TX complete interrupt is never processed.
> 
> Fix this by removing the __aligned(4) attribute so the struct size
> matches the actual hardware data size of 9 bytes.
> 
> Fixes: 7299b1b39a25 ("can: usb: f81604: handle short interrupt urb messages properly")
> Cc: stable@vger.kernel.org
> Reported-by: Dynetrex, Admin <admin@dynetrex.com>
> Closes: https://lore.kernel.org/all/A3834A07-5639-4779-844F-C5843DFC3928@dynetrex.com/
> Signed-off-by: Ji-Ze Hong (Peter Hong) <peter_hong@fintek.com.tw>
> ---
> v2:
> - Added Reported-by and Remove mismatched Fixes tags

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
