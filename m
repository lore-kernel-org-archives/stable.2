Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1A727FB37;
	Sat, 12 Sep 2026 16:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789229538; cv=none; b=fPuOyarfSJAmjLuPWB6AWTrVgtnRvm/8WhVSdZUaf1gtzXxVk+VpvhtJ4lq36/1zbpakfhHj4V0SHSVbtSm0/9VQl7eaC/5/dwCqRFbGVtxiqFJPdFowUIwTi0Qz+z7+N4w3HPVq/uqT6rsPYNDqaiyMwPtvFwaOG37tB6ioDKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789229538; c=relaxed/simple;
	bh=/5XDS5I2FpSYo7ty4xDIhET6H6VzMYBWxA8HwL5Erz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J+d/+Myq58xh5JOQec9HQcgc2VHCnxdQFpFFyyQ+6SR6WUlvMZLvzmUySR8mekJUlDFDRl5P2HLIHi8YT9TbfHCLEkxoSLjObp/RWMAiljirnanjSLNuYYtLkuxk11hTUOabUzjEqOW7Rs3Epdvv+LppLj6f4br5Qbgn43ZIF98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=SGW6JWjL; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="SGW6JWjL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1789229523; x=1789834323; i=deller@gmx.de;
	bh=3ngN4ZWRCLH+XX1mopcWZzQA129ptK2GaQ3K1ELNRrY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=SGW6JWjLOhZVdnQvPbDPnesEHhZEavkFNCIBIbc7VvWUi/7LzvlFE8XIKMOTYOTC
	 THRW0+D8nXSIvXnzk31GGKo2cW6mpV5oZ40HHevr2hTfEOzSUuwdr6At0gg1MIQ/Y
	 sYVp5gEIMtmTLSODvPOe7CWgB05CRDwkkMoNkuS9bX/c9b1z26FZqgmQ31rtIaeSP
	 5dlL6+LrBer4aztfBY9iAR19638mV2KLJZeXd8CjVFTepD8+XeIsyc6psnWwOyxQY
	 idFOZwCaqrOdmGc7is5rLRzvcUi+ob3VXNOWy7VMHdqTF3cfPmNLiRy5pFZNYWVxK
	 d20K3EyO5qg7zgjEhg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MFbVu-1x2cWL1FGg-006YdA; Sat, 12
 Sep 2026 18:12:03 +0200
Message-ID: <12560087-a0e2-4abb-a283-5bbf93b65e89@gmx.de>
Date: Sat, 12 Sep 2026 18:11:56 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fbdev: sh_mobile_lcdcfb: Restore the per-overlay sysfs
 attributes
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Shixiong Ou <oushixiong@kylinos.cn>, Chintan Patel
 <chintanlike@gmail.com>, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, stable@vger.kernel.org
References: <20260912102152.86744-1-kmehltretter@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260912102152.86744-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EtXx+HMLTK0aZ4MS6HNDFC/vWhY1m3Q0E0w1XZZRYGIpiSxqitu
 wkyNkrD2SAJ7AX8czVjycylaUY8Qf1hLFUgxGrzPESOeDRHQK1Mdrkbgfyz9k1IWASZg3Lx
 thntcz22AX9X7CHz4ZJqFN//yb/8XE31psnMHV0RYV4AwRVfPfQeJv0MDACu0SEnEVaMh7C
 EJrvoy6LNRmLx33ZAn4aw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QMMKjO9FmBw=;TwDjlXq9Vbl3+keDyYuAMhXTh2Y
 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

On 9/12/26 12:21, Karl Mehltretter wrote:
> The ovl_* files documented in
> Documentation/ABI/testing/sysfs-devices-platform-sh_mobile_lcdc_fb no
> longer exist.
>=20
> Commit a979182a2453 ("fbdev: lcdcfb: Register sysfs groups through drive=
r
> core") moved the attributes from each overlay's framebuffer device to
> the platform driver's dev_groups and renamed them overlay_*. There is
> now only one set of attributes for the whole LCDC. The callbacks still
> expect dev_get_drvdata() to return a struct fb_info, but the platform
> device holds struct sh_mobile_lcdc_priv, so they access the wrong
> structure.
>=20
> Restore the documented names and register the group on each overlay's
> framebuffer device with device_add_groups(). Remove it with
> device_remove_groups() before unregistering the framebuffer. Skip
> creation when dev_of_fbinfo(info) is NULL, as the old device_create_file=
()
> calls did.
>=20
> Drop the CONFIG_FB_DEVICE guard, since the driver already depends on it.
>=20
> Fixes: a979182a2453 ("fbdev: lcdcfb: Register sysfs groups through drive=
r core")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
> Changes in v2:
> - Use dev_of_fbinfo() for overlay sysfs registration and removal (Helge)=
.
>=20
> v1: https://lore.kernel.org/r/20260907021844.25497-1-kmehltretter@gmail.=
com/
>=20
> Found while reviewing the sysfs ABI documentation. Shixiong confirmed
> that using the platform driver's dev_groups is wrong here.
>=20
> Compile-tested with Clang 22.1.8, ARCH=3Darm and W=3D1, using multi_v7_d=
efconfig
> with COMPILE_TEST=3Dy, FB_DEVICE=3Dy and FB_SH_MOBILE_LCDC=3Dm.
>=20
> Also checked FB_DEVICE=3Dn: olddefconfig disables FB_SH_MOBILE_LCDC beca=
use
> of its existing Kconfig dependency, and the framebuffer core compiles.
> This does not test the driver with FB_DEVICE=3Dn; removing that dependen=
cy
> requires additional changes outside the overlay sysfs paths.
>=20
> No runtime test; I have no SH-Mobile hardware.
>=20
>   drivers/video/fbdev/sh_mobile_lcdcfb.c | 39 +++++++++++++++++---------
>   1 file changed, 25 insertions(+), 14 deletions(-)
applied.

Thanks!
Helge
