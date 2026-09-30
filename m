Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB733503BF7;
	Wed, 30 Sep 2026 14:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790777517; cv=none; b=LPFsR6khlD4lw2mmbIqD3PQe5NZDXyUz7OZpMiAhwsVlX8ntkRvP2xFsindvOhpYqxs9qklDx/opLhZVNdNWvkPn1prRdEi+T5jb29NH4w643blpvj22L8ldYAzzYIWFZ9v24xTn4Kis1rehV9xDl99oPig1pIFnP9R1j0vyrBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790777517; c=relaxed/simple;
	bh=qp0LaLDpg5DZ9fxCCUSpSPNZRXxO1kMnkc5t58N7g4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cWepfd2CdS/2475cXXSVfv+O21vXp/rgsqNrsU1EUziat+IL1kuLqVdgx13Dy0qXDRC+yOP78gXOAJJ4Mru3RVriQnldA5BWf4DsXTLAGS/VsDGi+QLLDajY5ZDovX8f0JaNCvQhH4X0c4ZYx5lbCzmXqx3HCUTLaEzBX7F4sKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p1Pi/I04; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p1Pi/I04"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFE011F00898;
	Wed, 30 Sep 2026 14:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790777502;
	bh=tpjpeK2yd8GJDiul24Mvy//HkZJFfNSXXt2BdrztT7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=p1Pi/I04GYIpjdYpppyFl6bF+8FcsNuqQe0WXbQIjCFW24oI0/LtWVmqiPQl3u6lO
	 Njwsoscpco/PKKIA4a2TGzZNrmONRAdIAlLtHOwLA6TTMmAjZUpFxvCJPjKldQtNAq
	 cadG4sR3d9Gn7EHr9hnejpgQkCd1gH4ckzVfNgqs=
Date: Wed, 30 Sep 2026 16:01:29 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Minh =?utf-8?B?VGnhur9uIE5ndXnhu4Vu?= <zizuzacker@gmail.com>
Cc: stable@vger.kernel.org, Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org
Subject: Re: [PATCH 6.6.y] net: usb: lan78xx: program MAC_CR for LAN7801
 fixed-PHY link
Message-ID: <2026093022-concerned-gestate-2a88@gregkh>
References: <20260605121535.51414-1-zizuzacker@gmail.com>
 <2026060535-subpanel-proven-595a@gregkh>
 <CAH9t78zjHGm-EFmjeJy3fMZ0fs3m+ZKWynaJkd8GDZdWoZDLHw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH9t78zjHGm-EFmjeJy3fMZ0fs3m+ZKWynaJkd8GDZdWoZDLHw@mail.gmail.com>

On Tue, Sep 29, 2026 at 02:36:13PM +0700, Minh Tiến Nguyễn wrote:
> > Please backport exactly what is in the mainline tree, otherwise odds are,
> > this one-off fix will be found incorrect (we always get it wrong...)
> 
> Hi Greg,
> Sorry for the long silence. In June the board was still in development
> and I only made the link work; I've only now had time to recheck this
> against mainline and test it on the hardware.
> 
> You were right. Please drop my patch; these two mainline commits fix
> the same bug:
> 
>   5160b129f65f ("lan78xx: Enable 125 MHz CLK configuration for LAN7801 if
> NO EEPROM is detected")
>   799f532de136 ("lan78xx: Enable Auto Speed and Auto Duplex configuration
> for LAN7801 if NO EEPROM is detected")
> 
> Could you apply them, in that order, to the stable trees that don't
> have them yet (6.6.y and older)? They apply cleanly. I tested them with
> the 6.6.y and 6.1.y driver on the board: without them the LAN7801 MAC
> stays at 10 Mb/s and passes no traffic, with them the link runs at
> 1000/full with no errors.
 

Now queued up, thanks.

greg k-h
