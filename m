Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEA42EDD7D;
	Thu, 25 Jun 2026 14:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782396094; cv=none; b=OUMHzk7qxEfyWnpequEZACd6QL/AEUFpFiUT+QjFlaugt/koUeh2U99/NXA6k3xxmu7FFhsgbU9D8tTHXvNp+LKaRXrN9lQHOae7UWyptO2Bm3NDTL8mRlrVSqvNtjyz0q/RWQIutBTCzYUgyiBmNqErcBhVTCqczKFteynN/QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782396094; c=relaxed/simple;
	bh=2hc8qBoOkck7WCbYgfm7FidvX81QoZKx6sh7wleyU5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UwBIwL129lwzFE7obHAM2S8nqpasHDPdEeI04v7UHgOXkzKmtjpYrrehBsvDV2zczHCaxLgmLQwYTVFZJm7bD8egjxuF4LphVhBa572p0JzNMwFdy1fXyG+kxaBjT2uZsjY0dQqp2FtMA+7yoPyrRhpsBP8LhEQYbEsngp3H2v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UBihqjH2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UBihqjH2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 000E61F000E9;
	Thu, 25 Jun 2026 14:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782396092;
	bh=UPjYKRx/JznPkgUBzNwXhhTkZxqTJPaIysGlReLI8jE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UBihqjH23k5nnsBHhRWtajsrTp8HxLF+0rWzQC17uNrLFEpseJYLpTLLBROougkxq
	 2hmAaLuG3ZiZbu3p0wTNx+QjvUOnk7EVpxFwpbLktWzl0FFrW+mwoutvYllZcQVzh4
	 NSkvwqZVSLvLdZAKqXN/RHEJaxiwq2MlHwiE3dM0=
Date: Thu, 25 Jun 2026 15:00:20 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Adrian Korwel <adriank20047@gmail.com>
Cc: linux-usb@vger.kernel.org, stable@vger.kernel.org,
	heikki.krogerus@linux.intel.com
Subject: Re: [PATCH 1/4] usb: gadget: f_uac1_legacy: fix file handle leaks in
 gaudio_open_snd_dev()
Message-ID: <2026062500-thinness-crudeness-7036@gregkh>
References: <2026052517-undergrad-reformat-44bc@gregkh>
 <20260525202612.680-1-adriank20047@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260525202612.680-1-adriank20047@gmail.com>

On Mon, May 25, 2026 at 03:26:09PM -0500, Adrian Korwel wrote:
> gaudio_open_snd_dev() opens the ALSA control device file first, then
> opens the PCM playback device. On two error paths the control file
> handle is leaked:
> 
> When filp_open() for the playback device fails, the function returns
> immediately without closing the already-opened control file handle.
> 
> When playback_default_hw_params() fails, its return value was ignored
> and both the playback and control file handles were leaked.
> 
> Both leaks result in gaudio_cleanup() calling filp_close() on already
> freed file objects, causing a use-after-free.
> 
> Fix by closing previously opened file handles before returning on
> each error path, and by checking the return value of
> playback_default_hw_params().
> 
> Fixes: d355339eecd9 ("usb: gadget: function: make current f_uac1 implementation legacy")
> Cc: stable@vger.kernel.org
> Signed-off-by: Adrian Korwel <adriank20047@gmail.com>
> ---
>  drivers/usb/gadget/function/u_uac1_legacy.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)

Something is really odd with your email system, look at what is on the
list from you for these patches.  It looks like:

 525   C May 25 Adrian Korwel   (  43) ┬─>[PATCH 1/2] USB: serial: io_ti: fix heap overflow in get_manuf_info()                                        
 527   C May 25 Adrian Korwel   (  40) │ └─>[PATCH 2/2] USB: serial: io_ti: fix heap overflow in build_i2c_fw_hdr()
 528   T May 25 Adrian Korwel   (  77) └─>Re: [PATCH] USB: serial: io_ti: fix heap overflows in get_manuf_info() and build_i2c_fw_hdr()
 623   C May 25 Adrian Korwel   (  54) ┬─>[PATCH 1/4] usb: gadget: f_uac1_legacy: fix file handle leaks in gaudio_open_snd_dev()
 624   C May 25 Adrian Korwel   (  64) │ ├─>[PATCH 2/4] usb: gadget: f_uac1_legacy: fix use-after-free caused by bound guard
 625   C May 25 Adrian Korwel   (  40) │ ├─>[PATCH 4/4] usb: typec: thunderbolt: cancel work before altmode is removed
 626   C May 25 Adrian Korwel   (  35) │ └─>[PATCH 3/4] usb: gadget: f_uac1_legacy: cancel work in f_audio_disable()
 627   C May 25 Adrian Korwel   (  40) └─>[PATCH 1/4] USB: serial: io_ti: fix heap overflow in build_i2c_fw_hdr()
 628   C May 25 Adrian Korwel   (  40)   ├─>[PATCH 4/4] usb: typec: thunderbolt: cancel work before altmode is removed
 629   C May 25 Adrian Korwel   (  35)   ├─>[PATCH 4/4] usb: gadget: f_uac1_legacy: cancel work in f_audio_disable()
 630   C May 25 Adrian Korwel   (  54)   ├─>[PATCH 1/4] usb: gadget: f_uac1_legacy: fix file handle leaks in gaudio_open_snd_dev()
 631   C May 25 Adrian Korwel   (  64)   ├─>[PATCH 2/4] usb: gadget: f_uac1_legacy: fix use-after-free caused by bound guard
 632   C May 25 Adrian Korwel   (  64)   ├─>[PATCH 3/4] usb: gadget: f_uac1_legacy: fix use-after-free caused by bound guard
 633   C May 25 Adrian Korwel   (  35)   ├─>[PATCH 3/4] usb: gadget: f_uac1_legacy: cancel work in f_audio_disable()
 634   C May 25 Adrian Korwel   (  54)   └─>[PATCH 2/4] usb: gadget: f_uac1_legacy: fix file handle leaks in gaudio_open_snd_dev()
 636   C May 24 Adrian Korwel   (  41) [PATCH] usb: typec: thunderbolt: cancel work before altmode is removed  
 637   C May 24 Adrian Korwel   (  62) [PATCH] usb: gadget: f_uac1_legacy: fix file handle leaks in gaudio_open_snd_dev()


You have threading issues, patches in multiple places and resend, and all mixed
up.

Please resend everything that has not been accepted, as new versions, in the
correct way, and we will be glad to review them.

thanks,

greg k-h
