Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF29367B6D
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 08:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791966547; cv=none; b=phABlIH2uwktKYYW0mP5V5TP8tj9PJADLgEzBER7OE330ObJRHlxYXlU93g48ccETyMHkaDZNTvETYR6C0ARsgPuUEYybmz8eXMfFIzqTf/MoVGWONd1hNI0dA9JhHhAk2lRnnWQpjYnN4KlvhDMR/ehTiSL9bQEKlhKbmE/d1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791966547; c=relaxed/simple;
	bh=K1xTFF0dZvielDw7CPdKjT3Dos7Fsn3aW1yWLZaKQb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s3yVbz62v1BUXywJnBKbZORWzk1wSTfEut7/Lmz2KGzKYxLhNcDEiMHaRFGxWL7s2zpnerOlmE8VERr02eNqVl9cYy8XW6+YnQUkkh4K/NvZl0p6SB9vpf4pmO2CL+2u6dSLgL2hizngAhrV1A+i78/qb4OvYpx04R3DIINllD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EgFed68e; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EgFed68e"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48af27fe287so236023f8f.0
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 01:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791966544; x=1792571344; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ONOYFUsExbiTAqauGcHDMWUDVRV1mSLiP5XphPmFoUU=;
        b=EgFed68eXGL3coPtaEb352qXlKG2T+5+8wH2QxfE0ZOieJEb46OYWjWxsO/ulYoO+n
         JsOKRntrefw1bBTbd67DdSJuGQQAxEs8ZwMhsEOdh2+0kSWvcAGd+3GHGunWJ3FQbQEl
         oXmLskyPmoGg75x2/8Rl93C+kuv8xDSGvVv3tddKMtDByA20m608mw5fRYanSYfLmEeV
         KX/s/0d3m77q69uOAx10yClZvPgh8lTKmkqJT9y68ncxw2aRm987J6e2w5k9v7SZDjtP
         f0gyO3WyIfFW3nrYbc71jxZL3sf5ltlr+JgmRoHMXRGiX0cn937IPMQrRGkciLorn3Pa
         o9qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791966544; x=1792571344;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ONOYFUsExbiTAqauGcHDMWUDVRV1mSLiP5XphPmFoUU=;
        b=Kj0scuC5CCMWaffR6zPrG/1RJMIwaymB7L0A1r5EFv+suS0HaCg/ygkPDgLTTpW8up
         70w0IyPiTxTbiUn2Uo/57C1BQXZzxJzNNmhJ4Kyy+ECCCNYIYYlR6FVuzwSGnUvsSVPy
         kDrB1Jsbet+Cw80D6dzeBN9SV276T9lxZp9VO3Kp++VFKLQblOfIR/fOTQ8YxIs/3X3q
         Ajua2iLZFNEG7iiLFgGW/43QJx+Wq5SkjJIS3+lK8mOD6sVDdhFd6azgKrwnV3+i6/xq
         tNxevWYlDxAaoj3/mflK7qXGvuK633gZZ1gdFdG7/774SVTdArqT8ehWy9T5faYPN/3q
         c4mg==
X-Forwarded-Encrypted: i=1; AKwUvBynlk99ShGn6fvedp10DG1/qm3OlW4s2dMMx2yesZ7jDUHQYYLZuN65z6+djlXgSNa9muxg5JY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIboCqG8Vq6oxhud4lGlABJzQHrUzGSq/kJ41sbvrsEVo2XhQoB
	3WMMcPjTBgGZojz0BcD302gQrPBGSmLcrgGGMO5iUnA5lhM5CrhCWSjz
X-Gm-Gg: AYBFou1bzEIFBmwp4CY2uQzJpVs+U86Yo2SgYpc0wWBn8SssQvNGOBLNoXIJYhzptIW
	qpuUMv9XwrrAGAspxpr+dKd8uFx7HekB1sL/Sondd3tO0TpqnX4/9zT/bzWDOeN1+5zcz7IuqOS
	pl7+SECDoO+5xXM9pg3JJO+GAWZ5O7agMRPJ1iYM0TgfFMAwB6GgTRD3OhNE67rTRjv8zl//c0Z
	KqINlUbYvQychO8D2pVwG+XemGXxEfM2NYZFiKWggsVRTngXOr8iicTZrx74hsgrDI2aGIKj5yw
	56/nmZejf45xDY6thSFPwo93+cAfqLg4Bqw+32KkuYfXtK6M1TdTXoZTAXbIeAGfVZY8zKp/wsa
	MqCdNEqAttyE2wNd39JP8nhIyLd0G+zTlF3xfuKmkGONGvf/fK1B6aJym3KKUM43VPYWnJ30ldj
	1c7rQYnhEi3hWAxuQQp1DIkWua23qkUhVV8u2cAFDylzIUHQw/47tF5E97szBsZ/baUto=
X-Received: by 2002:a5d:6443:0:b0:48b:536:c93 with SMTP id ffacd0b85a97d-48dbaae36f4mr21674351f8f.30.1791966544421;
        Wed, 14 Oct 2026 01:29:04 -0700 (PDT)
Received: from localhost ([2a02:8308:b092:fd00:20a4:7be9:4762:f55])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48ded185de7sm1899715f8f.31.2026.10.14.01.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 01:29:04 -0700 (PDT)
Date: Wed, 14 Oct 2026 10:29:03 +0200
From: Jan Remes <ciakval@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Joe Sandom <joe.g.sandom@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jan Remes <jan.remes@mycroftmind.com>,
	stable@vger.kernel.org,
	Martin Triska <martin.triska@mycroftmind.com>
Subject: Re: [PATCH 1/4] iio: light: tsl2591: don't divide by zero
Message-ID: <as89TxIwfpw7x40g@mm-ntb-00805>
Mail-Followup-To: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Joe Sandom <joe.g.sandom@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jan Remes <jan.remes@mycroftmind.com>,
	stable@vger.kernel.org,
	Martin Triska <martin.triska@mycroftmind.com>
References: <20261013143943.436816-1-ciakval@gmail.com>
 <20261013143943.436816-2-ciakval@gmail.com>
 <as5zy1LRyE5hr6vn@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <as5zy1LRyE5hr6vn@ashevche-desk.local>

On Tue, 13 Oct 2026 21:09:15 +0300, Andy Shevchenko wrote:
> On Tue, Oct 13, 2026 at 04:39:40PM +0200, Jan Remes wrote:
> >
> > Fixes: 2335f0d7c790 ("iio: light: Added AMS tsl2591 driver implementation")
> > Cc: stable@vger.kernel.org
> > Reported-by: Martin Triska <martin.triska@mycroftmind.com>
>
> How was it reported? Offline? Off the list?
> Otherwise we have Closes tag to point to the report

Yes, this was reported off-the-list in an internal report at $DAYJOB.

--
Kind regards,
  Jan Remes
