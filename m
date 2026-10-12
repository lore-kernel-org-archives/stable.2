Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA0033B970;
	Mon, 12 Oct 2026 21:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791839980; cv=none; b=ON21yXyWmo+hSVXZ+mdPQzZ7LZVmW4DUxS13QkCgJYmKLHfOm++fJNoYU0I+XOVczHa9xuzX+nqDp7zfEZGWtvFYYtDzbbJZVoefhKv+d/VnLAAtWAihnyuhATb/iXfdZimEqrxnQ/li7EhMFk+3tnJO1CA93BrM+GjkJLGS2Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791839980; c=relaxed/simple;
	bh=j+KaGoOIRszOeK3fNcaXug0ofuQHZm/Sz5IFIFZJYlU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VC7tBD5V6HPyPd1DEz8ZGanuLfANw+yPFP4MzS7BtEZ602k9XsnOdz0jVf3bTVLHIRzL1FohaugDJ6qqkRp1t4aDGQs4Ah1TqC44uO4QxiYBcMs7Pc0r34AGJ4csKmIraL/SKn+Kx0wn8Ffqpjf53XSqvYVtXHQMWqjPtSkqAwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=jM6DVHTK; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="jM6DVHTK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1791839967; x=1792444767; i=deller@gmx.de;
	bh=dap8Bv+YPmF10BEHHU3Socqip7C5SF6uMfgF7HPONJc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=jM6DVHTK57GbDNBNyT0/js0d+qzoECSfyL/RH0iI6y0zLR/NDoMglV8Da780GYK3
	 W1z+3TSn4TiLbDuaAMPJ2/FZ+STMiDSxn9lmk8bTFJbDqryDmJeYSoRhAPqEx+Sm/
	 jDjiiFgbfDygIo40nzCOviTfteocI5EDlbgzd8v/fzA4AkIkMCIDrwZvcs8223k/k
	 IDQZ1wvqFHZprocFii4yyw89yGPN7v3VyM0tDKUhW2prub6RJZlR18YJjs+E3OZR9
	 J9OfvUn1MQJK0MuHrKsVZFC4OxN9AeHT54T1TNFoVkvy5lQWzet0Mf9Uhotj1DhXz
	 AHvBPksiQ5LS0v7rBg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M5fIW-1xJ8JI3vYI-00FIJz; Mon, 12
 Oct 2026 23:19:27 +0200
Message-ID: <99014db6-89e9-495d-acec-e53134ce2a90@gmx.de>
Date: Mon, 12 Oct 2026 23:19:24 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: core: Initialize modelist in framebuffer_alloc()
To: Andrey Misiurov <andrey.misyrov@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Abdun Nihaal <nihaal@cse.iitm.ac.in>,
 stable@vger.kernel.org
References: <20261012175338.2283897-1-andrey.misyrov@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20261012175338.2283897-1-andrey.misyrov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8QR7epM5F7D1CSFIa23FBpMwmX5rWtf175lKE14yZGTaRTuD+kW
 8rVP63CFFLSxVqzoh/N2ev29Fvk+hZqjXETX6OAxpg+xBzXzY+wl5gyF2NCvrWkEBo30PwT
 MnNpNJujs/90nzfslVFS584u6CvZvlfZF8Lq4etecdfJQ7Tps5sU88tdzlni+H92oid/QeW
 hSZsMxx7CXJODYSeWGhFw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DhxMI5sJQDE=;WPskaRAkh9U3M0uHs6M1jVHLKfI
 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
 Ub9do+UHjTCeSMGjUHnMSCo3ZFRqU=

On 10/12/26 19:53, Andrey Misiurov wrote:
> framebuffer_alloc() returns zeroed memory, so info->modelist starts out
> with NULL next and prev pointers. The list head is initialized only
> later, by fb_videomode_to_modelist() or by do_register_framebuffer().
>=20
> The "fix potential memory leak" commits listed below added
> fb_destroy_modelist(&info->modelist) to the probe error paths of s3fb,
> tdfxfb, tridentfb, i740fb and carminefb. These paths can run before
> the list head is initialized:
>=20
>   - s3fb, tdfxfb, tridentfb and i740fb call fb_videomode_to_modelist()
>     only after a successful EDID read, and tridentfb can also hit the
>     error path on an ioremap() or kmalloc() failure before that;
>   - carminefb jumps to the error path when fb_find_mode() fails, before
>     its fb_videomode_to_modelist() call.
>=20
> fb_destroy_modelist() then dereferences the NULL head. Reproduced on
> Debian 12 (6.1.180) by binding s3fb to a VGA device without EDID and
> forcing fb_alloc_cmap() to fail:
>=20
>    s3fb 0000:00:03.0: cannot allocate colormap
>    BUG: kernel NULL pointer dereference, address: 0000000000000000
>    RIP: 0010:fb_destroy_modelist+0x10/0x80
>    Call Trace:
>     s3_pci_probe.cold+0x12b/0x2bf [s3fb]
>     local_pci_probe+0x41/0x80
>     pci_device_probe+0xc3/0x240
>     really_probe+0xde/0x380
>     __driver_probe_device+0x84/0x150
>     driver_probe_device+0x1f/0x90
>     __driver_attach+0xce/0x1c0
>     bus_for_each_dev+0x87/0xd0
>     bus_add_driver+0x1ae/0x200
>     driver_register+0x89/0xe0
>     do_one_initcall+0x59/0x220
>     do_init_module+0x4a/0x1f0
>=20
> Initialize the list head in framebuffer_alloc(), so info->modelist is
> always a valid, possibly empty, list and fb_destroy_modelist() is safe
> on every error path. Keep the lazy initialization in
> do_register_framebuffer(), as drivers that embed struct fb_info rather
> than calling framebuffer_alloc() still depend on it.
>=20
> Fixes: 3b0ed04bc852 ("fbdev: s3fb: fix potential memory leak in s3_pci_p=
robe()")
> Fixes: bb019d755366 ("fbdev: tdfxfb: fix potential memory leak in tdfxfb=
_probe()")
> Fixes: 7a35ec619d9a ("fbdev: tridentfb: fix potential memory leak in tri=
dent_pci_probe()")
> Fixes: 5936063409af ("fbdev: i740fb: fix potential memory leak in i740fb=
_probe()")
> Fixes: 6fcca16a2b19 ("fbdev: carminefb: fix potential memory leak in all=
oc_carmine_fb()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Andrey Misiurov <andrey.misyrov@gmail.com>
> ---
>   drivers/video/fbdev/core/fb_info.c | 1 +
>   1 file changed, 1 insertion(+)
applied.

Thanks!
Helge
