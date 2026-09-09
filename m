Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358E65625ED
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 13:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788961535; cv=none; b=X6wC/5ljrakvDwyEu/jqwEOo9mYii47PA3wS+4t938QmiqEotf1htvdxOTEnnqowdDVGpErF4AgmQ7JrK4SXQBP5hD8LWlU3R1vxedrX8BKvVc67AHkJRaJGSOp7vVF9gLoa+Y/Tth8dayZcX+xktWBjZSCqMYZoSJSl1i6zn2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788961535; c=relaxed/simple;
	bh=i0VT1OqBwdS71Uf2IVo6PfkEcn4RaE4yYClA5DJrApM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TR1GsOfWg/uRS2L+rwRIBRnD8ZQCLxHJ+xPq6D4TInrf83kHkfNeKpy/lzg7Be9rHTsdjlAlLVnjjJKqtTTqi8c4raUZizvasowaQQNsMJ7cXrQc5Sgbo8Xa2dfgMDDXgvWqmLK6toR8VQoywQv6aXmOm8bpvOoqBSdPztjyzKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f3CzoA5s; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3CzoA5s"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49cca4ffdcfso48377745e9.0
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 06:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788961531; x=1789566331; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=b8YKB3/dJvd9GLizbpdWgBqtE5BIptbKHlbLLtYjluU=;
        b=f3CzoA5sQghKNhyeFM0SByTb417WCMUIosqI9SPLPTaFsENGmWVMlyNfajctG1FJOA
         gjqLXKsybDbQzNB3v3siu4ydu1oEz/QMeHcQoZgOK1I+RkNkMidEB9v9CfwA/6Y/ze6b
         uR+Go3acgcl7gw7GjmpEHyN3GVXOh2SKLtd0LZBunrzsbvkVEaY25llAzbdChYHzyJCG
         oOfPvu7QrBeZ2/HepX/0mrWPXUCEl3ZMOnRrl2peLFtNIvt8F3fmhE+0rtQdftTMMhCb
         BcanwuhEyQkzLaQeF6rzgp4yalzfMV+Iqo6qAlNV0v6T6Bby0RrM+2sFc5Dyb5K8P2kM
         7NJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788961531; x=1789566331;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b8YKB3/dJvd9GLizbpdWgBqtE5BIptbKHlbLLtYjluU=;
        b=gA5Pek3CTxPpWWR2FQKGcAEvIYBak49pOcdGrCb+reDk3juZtaKUvopsL77p/h/YaO
         d2Hetzg5PTfoKvGCRYgSJphpyLhcKSdxB0GsnzrOXQh0SJaHUot8KuesYVg8nMk5dgSZ
         jS5vuMkhDI/wiSciJmJu5rEj18nMGsiwn0HC31UAUE3z+0Ud2h3p/sjFvQsKROPpUqhV
         J+P61MLpONi3hbpzU+cE94QtO4FZNxI4+A1eanSVXRDydyNP0h25nv64wCqkRseLBVfY
         8HNRIddNAEmSaIs0DJ23KjrYp5wjLqHy2ZMccDfnwRuEW2tSbaFcXBDkzK/Y2/W/xZED
         ZSbg==
X-Forwarded-Encrypted: i=1; AKwUvBwhtCVyf2bOCRSZM5srzb4tGIrsAGqsDw1ZLt57xV1uzo7cW/SUZAymyuvup1b604sXOQL0NyU=@vger.kernel.org
X-Gm-Message-State: AFuF++mrLijVbnP3Mqkpv8prLV2fsxzDBESfEhVayDeoMUVwkLVrsiSn
	H7cydDDkQWW9YVPJcQvR9ShlCr+HZ4E0u4+Y5Y3qFyK7ImYfSGZQ49Oy
X-Gm-Gg: AYBFou1x+zMQs6LDeGICSdf4d4xhn2jaGRTZA8PurGUFnzIuP564CW5Jr/8gArfBwHS
	HAootmjM/SbeGcNmVYQ4F12WxHrGLzHxDtVWy4tr5hqIhddHnG0DYLs1dd4Lsme7KuY5jbozg6K
	BAAHDfhn9rQbOBY4kJeWkSPbY6ziRSzYKdiAlOufPjCl1kRow1SY56ypkDiURG5jHcWvbHo/iAg
	V5Xv1BAvHTfkSI2XhSOXvOZBJo0p1Q2+YLRuLA+9YPvZOit4i9Kg91SMnIBKyUoZzY8fAXK9M8x
	/Bsr8AKFE/eK+eva9oRjVlXI+nn6wn/ig/bkOZmuwcZO+6pYiVM7j+2om7HdE+mbn6hTT7jpRXY
	CYk734YConLcw6cYmZjlZawEUzz/EXSCg6Rx4tKw3re5jGt8PKzaMSTqXvv0nc78ZfufcxHIOZc
	X5JDHCuO5kMQO9T6WgwyAd4KUEbMyiSPfBh6sXuh7ue9bYYRxAxmdYDMRP6nR1r3OF5AYx3dC7e
	lLHEBVWW4Y9P18w4RtpDTRF0TN784G4Y3Bxbpxn7b+zF6HF6OAYHpCfgQQ5t1bpixEkdeMxJdWy
	DMvdni8GjkBbJiL+j3HlrVxWk8GmB7pIy5Qmmawmpws+uTKOwlWgS0BhqThShZTnham0izbhSxb
	uXB6bFAOw923yyQMBat5C8vPJa9n92djkm2FCxZCgx6wwTuAXem9WrBNBl0PwYDJH++5Nx0i20B
	8lHlAc
X-Received: by 2002:a05:600c:8b88:b0:49c:fc6e:a3d8 with SMTP id 5b1f17b1804b1-49cffde8d95mr318555215e9.23.1788961531014;
        Wed, 09 Sep 2026 06:45:31 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883953cfsm36848889f8f.13.2026.09.09.06.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 06:45:30 -0700 (PDT)
Date: Wed, 9 Sep 2026 15:45:26 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Kim Seer Paller <kimseer.paller@analog.com>, Marilene Andrade Garcia
 <marilene.agarcia@gmail.com>, Jonathan Cameron <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: max14001: add missing MODULE_DEVICE_TABLE
 macro
Message-ID: <20260909154526.00002640@gmail.com>
In-Reply-To: <aqFhagdhM4Z57eqh@ashevche-desk.local>
References: <20260909130304.1395-1-joshua.crofts1@gmail.com>
	<aqFhagdhM4Z57eqh@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Sep 2026 16:38:50 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Sep 09, 2026 at 01:03:04PM +0000, Joshua Crofts wrote:
> > The MAX14001 has an SPI ID table, but does not export it with the
> > MODULE_DEVICE_TABLE(spi, ...) macro. Because of this, SPI-based module
> > autoloading fails on systems that don't use devicetree (e.g. via
> > spi_board_info).
> > 
> > Add the missing macro to export the alias information.
> > 
> > Fixes: 59795109fa67 ("iio: adc: max14001: New driver")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> > ---  
> 
> Changelog?

God, I should start using AI to check my patches before sending.
Appending below.

Changes in v2:
- edit commit message (expand on module autoloading and SPI)

-- 
Kind regards,
Joshua Crofts
