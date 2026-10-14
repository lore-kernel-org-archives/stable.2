Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930ED55C314;
	Wed, 14 Oct 2026 15:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791992448; cv=none; b=BMTGE6tOdczSKSoTHTxUNR6XPm+Z1VW/wta+aZo6I5zQC0Sgc0XZkOUhOGL7ObJm//sM4ShFD3pGEAenG0qRDx4amNV/TOGYi8DBvhXenaUyk0BKDHGe4YZAgIy2kNCZYZIsTqpYmwQiTKZAVsNJqxAYIS5V5I77nEiRRj9b/Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791992448; c=relaxed/simple;
	bh=VGR1U2Q2yccirOzCq9j3N28WgaHfxLVicd4wih2+iuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LDDFSe2buwSQ9uKQJFn5f2TXec8SpjE5VVPid/i0RvNgciBN+5nHNhwhzVdoBHqOrxGHr1HRj0ZNobEuj+I+yNXTBQCLboSYgpom2vqXa7Gj8DXPtkEeQCJAFolK6RwHiFF2g28U9ddh9Js4X9/9TyqZ5/LCIEf5nSvB1esdJUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B4W8y2qm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B4W8y2qm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 583E41F000C4;
	Wed, 14 Oct 2026 15:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791992444;
	bh=TFFzJPKCak8bHUbu3iKW1Dv5/m+pJOET/smJpVdcZ+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=B4W8y2qmOuRfnq0tsJTTXypfj3XI403SWtfCpe+a4YPuetyEBeqaTsAsJtnvw0IGT
	 zV9yGgGaH6a+ffY29XjThxzA4i4lptCsWNqTAf7i31JNge8pmfdxmTGFwOzUoQ2i0L
	 wgL3oDV0WCrdsUKTapHCLDD/HzLgdz1cl7bzdSxg=
Date: Wed, 14 Oct 2026 17:40:49 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Phil Rosenthal <phil@phil.gs>
Cc: Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Johan Hovold <johan@kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] serial: core: Shut down a running console port before
 removing it
Message-ID: <2026101433-refuse-unbiased-4b63@gregkh>
References: <20261013-serial-console-remove-v2-1-2eca1a92c10d@phil.gs>
 <2026101326-outmatch-regular-f8ae@gregkh>
 <61E0B380-1646-4770-BF37-E1E4329FEE86@phil.gs>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61E0B380-1646-4770-BF37-E1E4329FEE86@phil.gs>

On Tue, Oct 13, 2026 at 04:42:47PM +0000, Phil Rosenthal wrote:
> On Tue, Oct 13, 2026 at 06:12:52PM +0200, Greg Kroah-Hartman wrote:
> > Is this the same as:
> > 	https://patch.msgid.link/20261003163337.45577-1-igorpetindev@gmail.com
> > ?
> 
> Yes, it's the same bug and the same fix. I hadn't seen Igor's patch when I
> sent mine, sorry for the noise. His is in tty-testing already, so
> please drop mine.
> 
> > Why does that commit set a field and this change does not?  Which is
> > correct?
> 
> Both work. Clearing port->console isn't needed for the fix, and it does
> no harm. uart_shutdown() doesn't look at that flag. It is only read in
> tty_port_shutdown_locked() and tty_port_close(), on the last close of a
> tty, and by this point any open tty has been hung up, so
> tty_port_close_start() returns before either is reached.
> serial_core_add_one_port() sets the flag again when the line is reused.
> 
> The other difference is that Igor's patch calls uart_shutdown() only if
> tty_port_initialized(), as my v1 did. Sashiko's review of my v1 pointed
> out that a console port removed while suspended is not initialized but
> still has its suspended flag set and its transmit buffer allocated, and
> uart_shutdown() would clear both. That needs the device to go away
> between system suspend and resume, and I haven't found a way to test
> it. If you want it covered I can send a patch on top of Igor's commit
> that drops the tty_port_initialized() check.

That would be nice, thank you.

greg k-h
