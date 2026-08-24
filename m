Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F603655D6
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 15:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787584547; cv=none; b=fRQK9QE0vaNrRCwBlloMqI2mJ981l2Jf6lqj0Z3fnFbQ4RhV3Vq6V3iE6o+DaRddVb/CySUAINxklhQe26yE5zNLifI7tLK4mag+kaYJVus8n+5iZVXRmCJn9QjVXcZIki8hPLos81betvfGx2jjSl4yclTBzOF7PTOjwwiMv00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787584547; c=relaxed/simple;
	bh=gTXt/T7JdJ24JqXu08VXblSchYqRse2SDOCitpcqN8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kcVm3nU7H7a4gB/SIKkVvT/1wLgT0YgP+gFl33MJG5OnBxT5F/q5BHM3pQ4ff/j1MsoUFPtK1mwlJAy4O4k/5D+G4yZuSjaTLhmURtAg75Z41Ruux8JWsPZ9JS4+cAfk/SBNxt57dYHQmcUtnuWCehkfBQkbnDIBrqIyGxIy6/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oLgkVZNJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oLgkVZNJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 952721F000E9;
	Mon, 24 Aug 2026 15:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787584546;
	bh=PrU3A7MpYkg3zFbcviJ1bsAH95YevKQo3Mw0q4TSNqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oLgkVZNJjX36aOPkTqWKHmmfOADOGg5pfFxEBJfXpw2spee26AmEQvf6LTPCc1rg8
	 Tm/UYIXvEaCSqlV7BxccO4HovlzVO1EsL+cBSJOnei7HD+IDXYThRTrTzO+lloYQWE
	 mfOQvvSmfWQk+OKX4LbyZRYm/F5suL00kxBC0oNU=
Date: Mon, 24 Aug 2026 17:15:41 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Donglin Lyu <DongLin_Lyu@outlook.com>,
	Ruslan Shevchenko <adefka@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 6.18.y 2/2] Input: atkbd - skip deactivate for HONOR ZQC-P
Message-ID: <2026082459-tweezers-freedom-b725@gregkh>
References: <2026082021-ungraded-halves-33f6@gregkh>
 <20260824145035.3662153-1-sashal@kernel.org>
 <20260824145035.3662153-2-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824145035.3662153-2-sashal@kernel.org>

On Mon, Aug 24, 2026 at 10:50:35AM -0400, Sasha Levin wrote:
> From: Donglin Lyu <DongLin_Lyu@outlook.com>
> 
> [ Upstream commit 410c44b1096789d0c40fbee706520e981dba7bc1 ]
> 
> The internal keyboard on the HONOR ZQC-P (HONOR MagicBook Pro 14 2026)
> does not work after boot.
> 
> Using the kernel command line 'i8042.dumbkbd=1' makes the keyboard
> functional, but the CapsLock LED does not work. Adding the
> 'atkbd_deactivate_fixup' quirk fixes the keyboard and CapsLock LED
> natively without requiring boot parameters.
> 
> DMI: HONOR ZQC-P/ZQC-P-PCB, BIOS 1.09 03/19/2026
> 
> Fixes: 9cf6e24c9fbf ("Input: atkbd - do not skip atkbd_deactivate() when skipping ATKBD_CMD_GETID")
> Signed-off-by: Donglin Lyu <donglin_lyu@outlook.com>
> Tested-by: Ruslan Shevchenko <adefka@gmail.com>
> Link: https://patch.msgid.link/20260801151115.52709-1-donglin_lyu@outlook.com
> Cc: stable@vger.kernel.org
> [dtor: keep all HONOR entries together]
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/input/keyboard/atkbd.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)

Did I miss a patch 1/2 for this?

And this patch differs a lot from the original, why not just backport
the id table changes that were done in the meantime instead?

thanks,

greg k-h
