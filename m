Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EC0470E88;
	Wed, 22 Jul 2026 19:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784747536; cv=none; b=nv/2jCdiGDlI8S4RW0j5H7huergSAphSv/z8zV9D9lO/j7v+62H1831mSApoG+JOoIM/cJvNnqD/kRUeBswAuGPWEyxvvfJDkENl3oLeC43N7YdlRvCwfpRZmqwyEP8OCJ7CarXh5JOZk8W1UYXlQIESNK/Fmeem0WkoqDSW3w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784747536; c=relaxed/simple;
	bh=VtB1aFQfW9LnBteRoiNWJjOXWORUeOhKtjTAyPJQIAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YPjnPmqGVBrBBX65UqU7h3r6Y3S4g9OxEWku+OOABHEUVLI6aWLn7XqDLh34J1s0JKQw6ZxYGB2wLM6tMqeDfUgxD+YpF58lRKXoigbIbG/nxoUoka8w01HatTsk8B/uqS2tCvNEizt9Dc4o4t/Z/V7Za1IQjsjlHVv4OuJnXTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=HSV0F3Vp; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="HSV0F3Vp"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8650B40E00C4;
	Wed, 22 Jul 2026 19:12:13 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id YFRlmKBRAw3g; Wed, 22 Jul 2026 19:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1784747522; bh=4shX5CPgyIO6cU0JzUl/q3lakWlHOh3pNfKnsSEqcww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HSV0F3VpTXnevoG5R+VWP0cxLQbKTHQ4D+pO8V2QFF+jBnh5RqADGlBUGPKlYxL9j
	 0FN1ZvuvhoAr1Q04KtwXfPcuP9JewgkQcGVJD+6z4jqpet6eDJbNOxrfRYfDJxPH+V
	 s3SjKDgFEUdx+WqhGLl/8EUlGSrHNdNtUYHKUsLb/9ohlOe8oyC0q1VlSsjvsGg0bZ
	 nViwW500TpRAwHvlVdJ8CFEtSFUtXv3fHN+1YE23rxwg0OaSFWS11942Ki2mce8Kam
	 dfdnYq4aDShsNU1SM3GjBDiSE1Awfai7/TPjOcP1XE7akYDnxozrPLmIo86OUgqesq
	 lgoBh4VnOIXfnqF4o26M/sSjgcbG3BwkiNMmFBVFpvglm73Ja8oBDFfVbFwXCOBQ00
	 y2hXt7cRWBhwwUgX2L9GaDW1l+EbQ9coNzaOgvRTTYCfJei2LCpw+MeEoWozkWDSEG
	 J+OglBPkrrYoyqElsbpYLNUbmLipxNxiAqB1TZQNYS3Asa1e2XQC3dqqgXi+pM0Hds
	 zTibWzJOJCIlqLPKso7HHLezBD2m276A9WI5/6eq5iHw7KWE5ePdgkv0pHJfEh/T8I
	 nbo/TtERJoz0nY3lo2b1L/iyUhwuJNcPrO90RCqL60ED1UfzA5r+Z5oPjZUGY/HNik
	 x1fhEZgRZfI4AQXZrDWfRHZA=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::2b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3935E40E00DC;
	Wed, 22 Jul 2026 19:11:56 +0000 (UTC)
Date: Wed, 22 Jul 2026 12:11:52 -0700
From: Borislav Petkov <bp@alien8.de>
To: WenTao Liang <vulab@iscas.ac.cn>
Cc: tony.luck@intel.com, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] edac: fix kobject refcount leak in
 edac_device_create_instance
Message-ID: <20260722191152.GDamEV-OR36VVL2TH0@fat_crate.local>
References: <20260628132155.45969-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260628132155.45969-1-vulab@iscas.ac.cn>

On Sun, Jun 28, 2026 at 09:21:55PM +0800, WenTao Liang wrote:
> kobject_get(&edac_dev->kobj) acquires a reference on main_kobj, but it is
> only released when kobject_init_and_add fails. The success path and the
> block-creation error path both return without calling
> kobject_put(main_kobj), leaking the edac_dev kobject reference. The
> main_kobj pointer is local and lost after function return.
> 
> Suggested-by: Greg KH <gregkh@linuxfoundation.org>
> Fixes: bee33f22d7c3 ("clocksource/drivers/nxp-pit: Add NXP Automotive s32g2 / s32g3 support")

An EDAC patch fixes this?!?!

> Cc: stable@vger.kernel.org
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
> ---
> Changes in v2:
> - Fix patch format based on reviewer feedback
> ---
>  drivers/edac/edac_device_sysfs.c | 1 +
>  1 file changed, 1 insertion(+)

Also:

https://sashiko.dev/#/patchset/20260628132155.45969-1-vulab%40iscas.ac.cn

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
