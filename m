Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793953282;
	b=IkZpCDUA2pgcDMrdNBBVkyVonvsmd7Ele5Ub2cOTN0lpbNGLjkJ0QZxGLmohxuViuyid
	 kqkQo89QX9JeklyWQ2Cx7XHZHLCXr3bWYj5PindUYLdzUaN2LuF/ufM0Odpn5eeWrmDaJ
	 ai2UDk50hpNJ9dSti0rMtaWCJ0t/Yjw0ot9ICTqzFpA8MH/gqgDTDl5scx5xdcd7Y+oSs
	 v2VQSBWyGowIa7SN/RE93WrhJQh/d0IlN38t7A+ekq14fX3iK/PPDoEnhz3rkpnEfQOTS
	 +NxNGFD83WiX4BcNvy80vvAFc7kT9sYSzVVuKegPOxfKaoLhje146M1gmHq0v7GPLfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793953282;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=tXtS1Em7b2x/aoxEcgyB2IvYBL9Ky3IS8jlOY8JmCdw=;
	b=AsIBFOrumCxvg2ITGWn2KsrwFLRvDBg+QL8+myfuDdMSD/tpi0VbwZ3Sz5cw7lY49Nd+
	 eFjhlo0gEpNke8wjOSTsrNNPOD9hCbrdO+bbLCMxl/gZZN7ltPWnmSo49YmOFz6FHyj/Z
	 YsCmUnx6xqclRvADrO3eJ+8fJDwN9TfUF2gkln1xn8c4ucXu7hbnbblZXCbK+78b8RU+q
	 tLaWtFXsLcPUtHhTEjwdMu08er9aF5U1Uz1WA573jH/BaBAwUMPdAd6lt8N/UQzffRMaF
	 WV9lG6tWjfRvFytEsdrOiuaIfUG3RQRmrtQUwffnZxXjfNtdTygp2xbGpW7UP7UNbYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QCfjJa6p;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BF8606A326;
	Fri,  6 Nov 2026 08:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QCfjJa6p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1E551F0089F;
	Fri,  6 Nov 2026 08:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793953282;
	bh=tXtS1Em7b2x/aoxEcgyB2IvYBL9Ky3IS8jlOY8JmCdw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QCfjJa6pK3BRpFP825bjAs4y5WPmB3jWnmAyv5CHhIOXjDZ4msNgTD7x3+dGZxwwX
	 z8ddU2hbVy48TfJHHsxKAq0IVG0j4vcCihKEwSnTI1o75Rb6kCsv5X0gPwo+PPtHVa
	 bFUTFajGGPRncSHNlNf3WTD7tdodP+5JxbsulJA3uSK6kePQ+IiUdTfxiBFP1Va6dC
	 oqqs34f+RY8Y0RftVN2B3ZQZPbwdtTvw+kZ/E9YGfom8EHajPhww6CGy55C3ekxY1m
	 rWlKCffqZrENiNXvZfmd9Ri75CUTEZCpTfhpC2j4RpxMXfaCi8nvUzmNLu6yAWcaSN
	 DkByMm3RF1HhQ==
Received: from johan by xi.lan with local (Exim 4.100.1)
	(envelope-from <johan@kernel.org>)
	id 1xPFCJ-00000008NDB-1kVt;
	Fri, 06 Nov 2026 09:21:19 +0100
Date: Fri, 6 Nov 2026 09:21:19 +0100
From: Johan Hovold <johan@kernel.org>
To: Zhao Feng <zhaofeng2@cmss.chinamobile.com>
Cc: linux-usb@vger.kernel.org, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	syzbot+58b2d8b19cd6761a395b@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] USB: serial: mct_u232: fix NULL deref in open error path
Message-ID: <au2N_7iL_eXU6RCy@hovoldconsulting.com>
References: <20261106081254.1389-1-zhaofeng2@cmss.chinamobile.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261106081254.1389-1-zhaofeng2@cmss.chinamobile.com>

On Fri, Nov 06, 2026 at 04:12:54PM +0800, Zhao Feng wrote:
> The MCT U232-P9 has no bulk-in endpoint; received data arrives
> through the interrupt-in endpoint of the second port, whose URB is
> stashed in priv->read_urb by mct_u232_port_probe().  The generic
> port->read_urb is only allocated for ports with a bulk-in endpoint
> and therefore remains NULL for this device.
> 
> If submitting the read URB fails in mct_u232_open(), the error
> message dereferences port->read_urb->pipe, causing a NULL pointer
> dereference at offset 0x50 (the pipe field of struct urb), as
> reported by syzbot on KASAN-enabled kernels.
> 
> Print the pipe of the URB that was actually submitted instead.
> 
> Reported-by: syzbot+58b2d8b19cd6761a395b@syzkaller.appspotmail.com
> Closes: https://syzbot.org/bug?extid=58b2d8b19cd6761a395b
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhao Feng <zhaofeng2@cmss.chinamobile.com>
> ---

Thanks for the fix. I apparently beat you to it, though:

	https://lore.kernel.org/linux-usb/sashiko-outbox-201021@kernel.org

> No Fixes tag: the buggy error message appears to date back to the
> original driver import; the introducing commit could not be verified
> with the trees available to me.

No, this was introduced later by a clean up from myself.

Johan
