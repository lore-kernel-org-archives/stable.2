Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CE43D7D84
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 15:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780326498; cv=none; b=jlzHaR7zpKuFv+l6E9EfJHobYxwWWlVLKp0oJt+G90zABeXs+jHOjqAgKTzt8aaUsl91shVsCnsbOYTrPvbBojLL17Pmjkm7Z01M4baOWZEonyiCMjKc1pL9MfLJ9NwHHmz+QKNe9w4ZXhwEqkxqE5+r9IOQyoriMxPt+mLtmGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780326498; c=relaxed/simple;
	bh=8cYW1eZoP6NBNGgjXZ5EeGzBWJiUFyOZDDX8DreahPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dgt+Bj9f0h07TZxDYPdrqDMu8rHHRakRI/jtt2FR74WZ7fUyMcDjX9h5ABGELwDrKBaHdL0/lCeGt806Ge+sdEdHRAg9eIUdz7Xw6aB8MNJoRrxDVOf42pvvm8aSRINPUFVWUcNaiRuxsGv2THUc0L7ACNCkqV1D7MrbUOX1Ues=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/eIcnx9; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/eIcnx9"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-45fe59255beso851151f8f.1
        for <stable@vger.kernel.org>; Mon, 01 Jun 2026 08:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780326496; x=1780931296; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/iDvFkdNstCMV6U6YBcdPpzEdn9fHll2vJW0mE3op7o=;
        b=W/eIcnx9x2qiMXYqTwnjxzj1De0XzRjRutk7v952pCfNih879aCH4qPFA2mxNTkAjr
         GSydIoNShWsyybsfT5UICvLEL0hi9blzHqyQYGBNTB9hk7ry+AOC08WDC/EGmzh6imlu
         JmGYBo1q2p97R51k183KrMDMENdKPpl4dAwpx2QKwHIEirtYWh94vItZJBz+yAIHQIJF
         aJqwf0BcpSYmUh+PBadmQ72dXvsUgwHbt69EYp92qmQg1e0WUoWJJQ4LuNM7gp60xn71
         c1Er8uy9xjGpHoPn87nw8kp4USv63CjP/OG8fVhtiyow+rcLkBofpyO7ZrIRTftBi+AM
         6wTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780326496; x=1780931296;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/iDvFkdNstCMV6U6YBcdPpzEdn9fHll2vJW0mE3op7o=;
        b=HaUNW+O5GHmYKk/4T0plImUvCBGzByR9S5vhCrU+hDCza8gTqcYYgiDHNOd29Zcm64
         VTlnj9teigi5FOYPT7n1emv1wvpEhA5DV5a56Lp/OcbTLfPsIIqrENTPcinKGAOzIWnd
         cMHL+YZGileYUgOmbz9Y38LMyVQLftBfwtOy/xgPoiNZ93JshH8Fos+fHFe+OrdXdzBJ
         94dDhCe28Ibo7O68QNqTLPp40Cic/JLjZaBWyxLzdLFH1bYfUHnhyuRjOLZL7gFL49Pt
         2UrTKpl2nJXuc5i+5TVOVxUoOnAfTMTOx50ligp9fmKJGcFAhCcrVduIbJ1mfFsFoLVn
         ZbuQ==
X-Forwarded-Encrypted: i=1; AFNElJ/rP28H8l7IgXs2Ezjg1BqBIphO5iz+V+ggeeizHE76ax0CBrr9ptsD2gwtYBcRAylKNPNqc/A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1xqHMYU9eDdBMo5Xh8rugoOmBxaN6Yj9PqKWCae8fZZ+WUO9d
	fDpZFQLtAGrAkrIhdzqA/bHfHU0zGbcMCAJ9YogWUmpYv4bYiNjrHuof
X-Gm-Gg: Acq92OGWUf0A0vkOZ/8P+WSBLN/ATVaseiOgbmM+farsrHXCtZVMc8m+8E01BLd7KxA
	Pfintr1c9rt7N7BvoR1+U2JPKAhETsXmpgmO+GFRuKw6c1SxXdAXIrHszaqP6Wnr+3nfMTT0Yiv
	vmtn4qjhQvlNUBURjHA/0CvbJnqzAjup9hHN+lNqjXZF431ReHQn8AKpiJa8S1HQHmhSF1zGEJX
	yFqEW+JKP19xqFa4T2Mfn5FoTsiyVrKKyi2RBnRRlZtyZHyBSygUbUQfM1aTmBFw/hrXdsiba1g
	8tdjKp61EnB7mf8mUccjPfmbci2kpeK42bwF2VXIXc/etbP1CBoGRqP1ZzqNBKTgsNwiYKMXIg3
	IR+mlfqShkUksP825jJCqYleS8TaJsozxU+MdfX9x4OdLFsFdtqiJZQ5A2VxqtQDv90DgFmPQX4
	yl2WCE1RzV0nKvgoKfrX7Q8SNlA9BSEIIIAw==
X-Received: by 2002:a05:600d:4453:10b0:490:6869:ef13 with SMTP id 5b1f17b1804b1-490a2918e9fmr148899075e9.14.1780326495794;
        Mon, 01 Jun 2026 08:08:15 -0700 (PDT)
Received: from Red ([2a01:cb1d:897:7800:4a02:2aff:fe07:1efc])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4909c6319ddsm245702965e9.0.2026.06.01.08.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 08:08:15 -0700 (PDT)
Date: Mon, 1 Jun 2026 17:08:13 +0200
From: Corentin Labbe <clabbe.montjoie@gmail.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
	linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, stable@vger.kernel.org
Subject: Re: [PATCH] crypto: sun4i-ss - Remove insecure and unused rng_alg
Message-ID: <ah2gXTMxfH-ux_J2@Red>
References: <20260529193648.18172-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260529193648.18172-1-ebiggers@kernel.org>

Le Fri, May 29, 2026 at 12:36:48PM -0700, Eric Biggers a écrit :
> Remove sun4i_ss_rng, as it is insecure and unused:
> 
> - It has multiple vulnerabilities.  sun4i_ss_prng_seed() is missing
>   locking and has a buffer overflow.  sun4i_ss_prng_generate() fails to
>   fill the entire buffer with cryptographic random bytes, because it
>   rounds the destination length down and also doesn't actually wait for
>   the hardware to be ready before pulling bytes from it.
> 
> - No user of this code is known.  It's usable only theoretically via the
>   "rng" algorithm type of AF_ALG.  But userspace actually just uses the
>   actual Linux RNG (/dev/random etc) instead.  And rng_algs don't
>   contribute entropy to the actual Linux RNG either.  (This may have
>   been confused with hwrng, which does contribute entropy.)
> 
> Fixes: b8ae5c7387ad ("crypto: sun4i-ss - support the Security System PRNG")
> Cc: stable@vger.kernel.org
> Cc: Corentin Labbe <clabbe.montjoie@gmail.com>
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---

Acked-by: Corentin LABBE <clabbe.montjoie@gmail.com>
