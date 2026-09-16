Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7709846DFF7
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 08:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789546905; cv=none; b=efggkqIaOA8izZbyeuP81vfuIGIyk3nANABoMH8xNsFJ2SkhOd9zbk9zP4ux1hQjaeNW5FsYFGcdso89T2JHnjQ+Ax+ksjQuQ4139MMkznQUWwxjk1Lgz0DtlnvfBUBhiFhnMtDf89rX6kDEGbz0bpvvT0xJhcf6MW32gRXGQFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789546905; c=relaxed/simple;
	bh=1HUGQWUo7DHa+QDueDddUtzEPEP4VkzaWUaP9uZ2X0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hIBTHojWNe0GauSdR0E9Z+02S6peJ1fSrYa35ePQ4TEEo3TNOQP+47KpF6TqzD5JOOOVunZHzdpqOsB0FIalLntEWb0dXT+cJZtzL7ykAJOi5vzYrFN31RH7tGflckoEM7PYIR1XCa2rMnkqQhDrJ/8qIAFhjp9D2KXcTvu7+HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nog/maE0; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nog/maE0"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912e4b11so3597045e9.3
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 01:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789546894; x=1790151694; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Bw432elLmhA4oy2qWRZIhT4M5eB1za1G9hSrgeusNHM=;
        b=Nog/maE0UF8Pv5w4f87Y92+hTJ9B0UFhPpIBZ/M378xf3MGgTi31u0SippM9dZKV6u
         Vmi7i8GqkzddAK33fd0PDalmtqmd9EGjGqG28czpyzbpJtzdaRGGZATjcPO7pibvyKT5
         UL9dvd8LUOqicH6MkTMlu7R4DFhr2vleT5wQEh7Hulp9OjEwP/O4fHyeiNhRGyni0Cdf
         qTwesT4cnDJiGv+snoUEgSbnKlVmnzGQoEIBjrM2b2QXW6XP/O11jCC2MglsJOEHgZHZ
         lQWpOIoG4FFP0DE9Ks3+FYVPlDTFPB2BBgJkMAFTnJVLSElAw7AmWSWU/8NVMOlZG8rf
         YHxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789546894; x=1790151694;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bw432elLmhA4oy2qWRZIhT4M5eB1za1G9hSrgeusNHM=;
        b=oyY60IHdRBuBo1GZ80i3lY+mUNQoQJaEmcOoCZddO9+i5XhAvtxCyNuTpKpwzvtAQ2
         Tr/7rgGOP6G8SGJTeScJz4kFhIlmfrlYov2DW4LQjJeIte/JiNkVOk3SIGXoOrKR2DGx
         AiydRntH88J4krAarNGiUKmv/HY+1FvkFomw5I64D1HBC7Yj/RjqOCW+rrmARyaHLwr2
         9lKe7xSMO4WGG94NIngWT/fjRxOXBKd5wZj6IT03pRIb1SKB9mE2QysUWYRyI668B0gl
         OAB4QSHWq7al42MZFvA5Yan4y5OOt/sexICZ00tKTF+fdoxBaxx9jdaSOupvjT5F6YPH
         Hgfg==
X-Forwarded-Encrypted: i=1; AKwUvBxJvuvRbgourkhQtLudLYcUjc4BproTHQyUfqssz5dyU/rCs0//q7xyFdEsnBDwmkedxVGrtFI=@vger.kernel.org
X-Gm-Message-State: AFuF++me+a3vP8xdrFJwz5pu9iyrlDnossiz+PQeuv9cs0wiGuvissRY
	xKYo3lPeV4VQ5djSgwkhBWM7BquImISTlXa5nslZIyAhm+KFALzeOd82vvTpbwwyYAY=
X-Gm-Gg: AYBFou2+ZkfiQwTKN8z8ANc4UugpMTeZUa2lD36FurDos4ptbMA96ucjsAzsfbu4rkf
	rV0UBDuDPXRoilumdb41Ql2lsbIjEeo1VkjWWke8WtKmqheJyAw453+NPnHyRRE9trcZeRS2iGx
	SV9PtjhkpIgjOzdDpbaTeppNov/RjBKQgMo9NfIJV8QO8XewEsENl3Wvcg3LzEaA+tJSLM4eUL5
	9HimV0/l6b7BvQ5k3gg1qR7Y1JByBeDW7/Jc4OstQ77q+DiYnhW3BQzrdPIjzq0B/0kVX518GNx
	mFf03QQgccZph/GpekMv5Vh/nYh6kX6qxj4irDCLiTwgErSG3NYF17VF3ke4SvEHJVet7KQR/t+
	uYFLowiYIW1xFNlHq0Txrx/hhh/q9o4qVBZJaqmPLMwanx1ajkYYg0GEgg6zJOEVS6p7QzTERUW
	+5UnnJbw+nUrWu07bIj/z01D+88eEB00kX+WPzNyg/4RzreWeamaJUJp5dBfsIeGwOUtMoDrqsn
	qBd2mK7eym/+hwTGL685ozLDz2ejKEBQDfXLNOIngWAdJ1ZjW5OUg4rja3IBpYRTpozgKaBa+6H
	jnHbBN/A08iAtH/zRsUg6LAdL9X1iuPNkcuHXDjNDsYPAaiWiOJXX6I/vsbleUChgVGgfKccq/J
	hrItlIoVC8/1A6kM6DhD2SJrhac5UOZXgmrDAfZrXvwmd952N5qCz35j5K7Q/ZVfg2fp718Nhau
	jYUlJt
X-Received: by 2002:a05:600c:470a:b0:49e:6bce:b0f9 with SMTP id 5b1f17b1804b1-49eb732cc87mr17337945e9.16.1789546893641;
        Wed, 16 Sep 2026 01:21:33 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e83da071asm73394925e9.8.2026.09.16.01.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 01:21:33 -0700 (PDT)
Date: Wed, 16 Sep 2026 10:21:32 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Johan Hovold <johan@kernel.org>
Cc: Peter Chen <peter.chen@kernel.org>, Pawel Laszczak <pawell@cadence.com>,
 Roger Quadros <rogerq@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Mathias Nyman <mathias.nyman@intel.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Heikki Krogerus
 <heikki.krogerus@linux.intel.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/6] usb: core: add missing
 pm_runtime_dont_use_autosuspend() call
Message-ID: <20260916102132.00005129@gmail.com>
In-Reply-To: <aqpOlKtxeROh-G_s@hovoldconsulting.com>
References: <20260915090223.1346-1-joshua.crofts1@gmail.com>
	<20260915090223.1346-2-joshua.crofts1@gmail.com>
	<aqpOlKtxeROh-G_s@hovoldconsulting.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Sep 2026 10:08:52 +0200
Johan Hovold <johan@kernel.org> wrote:

> On Tue, Sep 15, 2026 at 09:02:18AM +0000, Joshua Crofts wrote:
> > The fail label in usb_new_device() disables pm_runtime on failure, but
> > doesn't call pm_runtime_dont_use_autosuspend(), causing resource leaks.  
> 
> No it does not, as the device itself is about to be freed. Sure we could
> disable autosuspend again here, but it does not really matter.
> 

Okay, commit message aside, you still need to call dont_use_autosuspend()
on teardown as the driver doesn't use the devm_* counterparts. Currently
(according to my cocci SmPL [1]) there are 195 instances of this in the kernel.

...

> But this one should not have a Fixes tag and does not need to be
> backported.

Yeah, you already mentioned this in IIO once [2]. I found several instances
of patches like these being backported however, so perhaps times have changed.

[1] https://lore.kernel.org/cocci/20260915064327.1377-1-joshua.crofts1@gmail.com/
[2] https://lore.kernel.org/linux-iio/aoQEyeHUiTwWenBL@hovoldconsulting.com/



-- 
Kind regards,
Joshua Crofts
