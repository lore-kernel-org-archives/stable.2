Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1464F37AA79;
	Thu, 27 Aug 2026 05:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787809506; cv=none; b=eFcjJEx/PjvzcXfTiJtaI5eTOi6fNjRbwsyWXPpuFxhmuvjwHgf1yo9UbaKGalOCpCxRYjM2h+50TWiafsoKju9y+fU1bwkBTz2d4bNRLTGNqrIPyLsDAdIflxl+u/s9kYKUg1QMKNs4AZ7W5ZPtSDoXFLhBzvBUut9vzx8mV7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787809506; c=relaxed/simple;
	bh=rbXSWgKzazQvZwxLWS+nWr1eIZAVSEDtkI8wzuDLtu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HqxwQCyzMPbG5pTjvd8muXCem2pNZT25PVwlLqBUsTWq4YxmUX35RKKdQs9tX+rXucYgmO2xDq6UWlsxLSPm/HjmGOU87vePcW1uCUm69CGJ3mR22c8djmDjheBMh+oCaWxVk5tRFi5mOQ/NB54yk2Lm+9UwbU5aGsiK+U5TVXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WVmkVXpi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WVmkVXpi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B9A1F000E9;
	Thu, 27 Aug 2026 05:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787809504;
	bh=ITjXPOQMGodkBrrE4KhMrY4jMpREvF6KXR1OZaOgHAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WVmkVXpifm7J5lrxBSX/ngtfBMVhzPSVQbsURAV0H0dfRYx+uH1K29l33p2QxY/f1
	 +c3Bb3xuhv2qZP7rwwvR9yUwIaT7gaYlRZ3ZP7BphkdMFA7W/tOkqXvyatWkFcKLA9
	 x9BZ4wtN8i/Oiht9OTsqY6JDo+/jJ1vF5HHbFJ2k=
Date: Thu, 27 Aug 2026 07:43:22 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Shengzhuo Wei <me@cherr.cc>
Cc: sre@kernel.org, kees@kernel.org, linux-kernel@vger.kernel.org,
	Andras Domokos <andras.domokos@nokia.com>,
	Carlos Chinea <carlos.chinea@nokia.com>, stable@vger.kernel.org
Subject: Re: [PATCH] HSI: hsi_char: Fix use-after-free on device removal
Message-ID: <2026082724-nervy-footer-515a@gregkh>
References: <20260827-hsi-char-uaf-v1-1-4f824216a541@cherr.cc>
 <2026082727-hacker-flaky-2578@gregkh>
 <ao_Gi6O2VQw7RUQd@pve>
 <2026082735-unbend-laborer-ec4f@gregkh>
 <ao_NyQWCKIDQr_5a@pve>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ao_NyQWCKIDQr_5a@pve>

On Thu, Aug 27, 2026 at 01:40:25PM +0800, Shengzhuo Wei wrote:
> On 2026-08-27 07:15, Greg KH wrote:
> 
> > I'll defer to the hsi maintainers as to what they wish to do here.
> > 
> > Also, how do you remove a hsi device from the system?  Is this on a
> > dynamic bus?  For some reason I didn't think that was possible.
> 
> Yes, HSI is a regular driver-model bus (hsi_bus_type in
> drivers/hsi/hsi_core.c): sysfs unbind and module unload reach
> hsc_remove(), and omap_ssi's own remove() cascades into it through
> hsi_port_unregister_clients(). I verified the unbind path in QEMU
> while auditing the sibling cmt_speech driver, which has the same bug
> and whose fix I'll post separately.

unbind is not a "normal" thing to do, so much so that hopefully the
kernel will be tainted in the future if you do it:
	https://lore.kernel.org/r/20260826-bind_taint-v1-0-52b05f4a965c@linuxfoundation.org

So don't go through lots of work to add code/logic for something that a
normal user can never ever hit.

thanks,

greg k-h
