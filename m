Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792909011;
	b=Xsmh5YsPTsZcKx5bPncr9GVjvpE2Q0K9GtUOZLD9jQMpfOn2DYJugfGKT/U1VLn25om4
	 +ESZh3x2OpLylvR55ipW2cAuhOCBF91AFbzWq9jMrf0ykiy49UAy4+mTrbuo9yQNBfqWK
	 na67DmxLP3DQqcTPeUaMWiTWhc3tj6kiSoYJliHhcw5y6U21sPVkNBgIe1VhxynzP00ry
	 1yJMqSh3Kz9AGhfIwWEybx2yrVx1wdCjUx/AM6V+yLT6CzxSL5zu9zb7oDBeS/ru9h+Rm
	 szuhUZ/4LqtDIVCFgrpe6eGYthZy09osFJqqDx+nwbiqV/2skm4HewoW9G6oUCAI8xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792909011;
	h=Received:DKIM-Signature:Date:From:To:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=SRP8nZb2C09nTQawQpLUGcPnBKlbSpgwPopviakaXUs=;
	b=BKp5kYXeTQlpp0OUKBS6zNOsgH7QJRm5RAgWJyri6T53G395p1uJ0jm+pijo7hE7vSO5
	 yvFtVwI5ReBQDC/3kUdJd5vKTryvBtw8ULuep7/+WAkWDjQG0z99XSDKecJJGuKCDar4e
	 KHnoLkiy0bAaw924RpXWd6CebWtBJ8kZR7Pvod08uhLx4MR3xF+dQwUlvmOGbRfyHFGHS
	 PyrdOdsOCBVMDRyNNvsc6jax0Eqvu8rPK1Z9bRmqoW8V+4tWCdRC8m4bUnoUuRbVv9/22
	 WcSPxxvfCJp+n6XyH8eu5saoBiTQztP3UXw/xWn7dIXmkrxAlXs6DmrGyEV+B+/TPQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="A7Yg8I4/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F3A606A31E;
	Sun, 25 Oct 2026 06:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=A7Yg8I4/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBC7F1F01825;
	Sun, 25 Oct 2026 06:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792909010;
	bh=SRP8nZb2C09nTQawQpLUGcPnBKlbSpgwPopviakaXUs=;
	h=Date:From:To:Subject:References:In-Reply-To;
	b=A7Yg8I4/fq+JFr4w7sXObFLPHve2rQJbwts2pPyoPZIvzC3Vq1XqFJ0933fruY4GI
	 meKK5qWlNxFOEAVa3nY+UlEdRzz7Mlx4pQA78eaCDub07g0RUo+6Ql47S8W2TNEUAP
	 zNB50QuC+O2zBpgXVK+W3RFm3qJD2ycl3T9rXqAY=
Date: Sun, 25 Oct 2026 07:16:47 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sasha Levin <sashal@kernel.org>, Marcel Holtmann <marcel@holtmann.org>,
	Salvatore Bonaccorso <carnil@debian.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Erik Brangs <erik.brangs@gmx.de>, benh@debian.org,
	stable@vger.kernel.org, regressions@lists.linux.dev,
	linux-bluetooth@vger.kernel.org, 1149377@bugs.debian.org,
	Christoph Zwerschke <cito@online.de>,
	Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [regression 6.12.y] After backport of 980084de4d9b ("Bluetooth:
 btusb: Add ASUS USB-BT540 for Realtek 8761CU") bluethooth not anymore
 working on 0b05:1bef ASUSTek Computer, Inc. Bluetooth Controller (requests
 firmware)
Message-ID: <2026102508-thicket-duration-c971@gregkh>
References: <8aa88f3e-2dd7-4bfe-a0f3-e5ecbbade84f@leemhuis.info>
 <2026-10-24-1-daily-reply-0001-bluetooth-asus-rtl8761cu-firmware@kernel.org>
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
In-Reply-To: <2026-10-24-1-daily-reply-0001-bluetooth-asus-rtl8761cu-firmware@kernel.org>

On Sat, Oct 24, 2026 at 04:10:59PM -0400, Sasha Levin wrote:
> > I did meanwhile and agree, the backports of these should be reverted
> > from 6.18.y and 6.12.y:
> >
> > * 980084de4d9b25 ("Bluetooth: btusb: Add ASUS USB-BT540 for Realtek
> > 8761CU") [v7.3-rc1]
> > * 6f0624b4427e38 ("Bluetooth: btusb: Add ASUS USB-BT600 for Realtek
> > 8761CU") [v7.3-rc1]
> > * 4a23ce935f74d1 ("Bluetooth: btrtl: Add the support for RTL8761CUV")
> > [v6.19-rc1]
> 
> The stable trees match mainline here, so nothing is going into stable for
> this. The fix has to come from the Bluetooth maintainers or Christoph: an
> upstream revert of the ID commits, or a fallback to the ROM firmware when
> rtl8761cu_fw.bin is missing. Stable will take either one for 7.2, 6.18 and
> 6.12 through the normal Cc: stable route once it is in mainline.
> 
> The other way out is on the distro side. rtl_bt/rtl8761cu_fw.bin has been in
> linux-firmware since 20251111, so a newer firmware-realtek package fixes this
> without any kernel change.

That's the simplest solution, any users hitting this should also upgrade
that package as it's been out for almost a year now.

thanks,

greg k-h
