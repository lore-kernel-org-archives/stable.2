Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6486730F92D;
	Wed,  2 Sep 2026 05:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788328535; cv=none; b=qVIJz/V0bdw5aDw2j1WdMcNOamHSd4xn3Svl6ac4q1SDz2k3q87kKNZpZSLgQO0aSz8Ft4bf6nMqpNzh0N3YxudJfU4jm+4DBnYjfUIVox3+ifvjQcUAYrznp6Jz12dNRrGTDEixz6FXLSSuou/TgsHEYeJlyze4dfzpJZiA24k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788328535; c=relaxed/simple;
	bh=dP8xOwptnwuFulq8KyeVpJc8L6Ock8u0IQcdQN8pmzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NRLei5IywOq4OW+Q0NOay+xTJSj8r4GlBEwo5DQ1T0+aDNbpWoYS94VQ4zy4YHf7ZqRBwAyge7VUZBh9n7OqsBQyrA6rj8CJPU1Q70YEuvWLSADVOi6TAgfCQgOCiyeYFR4uo5PI2acVweOwFIKI95Wu18OLPvXzKbLwPbWgKTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1wjs1SfM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1wjs1SfM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DB991F000E9;
	Wed,  2 Sep 2026 05:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788328533;
	bh=dCm64HI2fhPUP2fHwFtHqJmn6zUfeUHDXK5GZJT4mUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=1wjs1SfM1meOADC5HsbA2I9cdz0Ifo4lyyb7zCvOeIo7GiWLO1NrrzHbYMQlEt7jz
	 Izk+0eFskEn9UmkI06em0LpGXGjIJ2FVkUdsBRCwJ1cLIvTFeN/Ayxi0cck68nTQT9
	 uAOE1Crtic1N6uMTh/x8GWnk6rBLE5VzUxY2AyWY=
Date: Wed, 2 Sep 2026 07:55:29 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yudi Yang <2000jedi@gmail.com>
Cc: vaibhav.sr@gmail.com, mgreer@animalcreek.com, johan@kernel.org,
	elder@kernel.org, greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: audio_codec: fix stack overflow in
 stream name parsing
Message-ID: <2026090219-democracy-chip-87fd@gregkh>
References: <20260901185600.2725678-1-2000jedi@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901185600.2725678-1-2000jedi@gmail.com>

On Tue, Sep 01, 2026 at 01:56:00PM -0500, Yudi Yang wrote:
> intf_name and dir are 32-byte buffers. Parsing a module-provided AIF
> stream name with unbounded %s conversions can cause buffer-overwrites.
> Limit each conversion to 31 characters.
> 
> Fixes: 60e7327d54b2 ("greybus: audio: Find data connection based on id")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yudi Yang <2000jedi@gmail.com>
> ---
>  drivers/staging/greybus/audio_codec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

How was this found and tested?

thanks,

greg k-h
