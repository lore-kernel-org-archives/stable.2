Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33AD3264FD
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 20:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792268419; cv=none; b=ZKDhdq+yX0Xj1EkF3YvVKW0ruz2/+zrb0gulFxt3RBC3Y3/vlmjFlDV7sF5uV5AxRFlID5aiBPv+Khru5qsp/ZFlFNK0cqwBRV1M/Un2lj8jlywjUVdMUjTPaqfJM5zdIdGwnj5iAvEkREsl8TNyH5+8/30LFflQ2bNmPNXEP/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792268419; c=relaxed/simple;
	bh=iOj45D9QjveBgDHXCRQAAzL9Yq6CKk3ChsV5jSGC1lQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QQgZPOSD+++uVzbNUtne1jlitXQxChd/AO6+gil/z4GBZU9aVglMlDveoHfXE/Qa3mlI9L9NKmMSMZqXbemkFzZLStcrRX2wqkvGl8aBrq3vTNC/64GoGNmEW7UL/yd3HEE0z8eeG+e2qTrCUbRKwGK08oFhIf7gKFt8kf7Lx5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YON0DWgG; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YON0DWgG"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a1d293b293so5162995e9.2
        for <stable@vger.kernel.org>; Sat, 17 Oct 2026 13:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792268417; x=1792873217; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gzxrQpRqiMxGfds7uvrOMz2fXfxEw8AQx180UBPaRVo=;
        b=YON0DWgGN6Mfi/4sF/8gI+tiuKKQL22E6m9fR0MR1uDgCJjG6j2gehScbJDJ6ECg1h
         dJoswkdUm2OV7xS70Lc5l8flzlAUMDEIqvzpqGS0vL+V8sHD+K4yc+dChq0SEDz5AhMK
         mh1xZqKLKU+X4NlrfuAL05HuWUads3T2UUG53H/aezXaTPDdnI3N5ygaLQaiRRHK3jal
         O+pxju9dYWCG3ehYGImy2+gznGREl6isRRhPII8zpRqBpJKtXJKt3az5+ixmZvGSE+Pf
         n9Sl8s31b9/kkoWLwe/fUq5dDpkjUY5phbgplNPL8Klt5MwmeCdvbHCrH5bklReC0i1I
         uAMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792268417; x=1792873217;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gzxrQpRqiMxGfds7uvrOMz2fXfxEw8AQx180UBPaRVo=;
        b=yjpQau28iSw8AIEFJrI8tBBPZ6D2ZygLyZZudisssH9QcbVuOw2SYd9ZYNpC0hSFJV
         wvBPHGyVc6WJZKpF10W9fEIWsLQAn93ARytOS3duAux2IiWxK5IMoyL3uFDmCeyWNThA
         VkRd+BkeAdIYJ8mKl/Cflmc5YfHtEsHKqBRJv3zdiUeAjTyORAiMO4imfgzZ75JWnLyM
         AQCJpOxP922oX3bAQ/X1oFUxv1atMe8Mf4ltGgMbWKxhupeHLtR1VnBETXF6DqmTMVx6
         RXukBwfL0VHgnBHMAKfdMQhTsx0r3ks9d+dTd/Zjfbfmuq2BxZIFd0DBi//5z+6gCIwj
         MErw==
X-Forwarded-Encrypted: i=1; AKwUvBxx0DtAW07qzs0UBh86timHW0UbsIiFu7kE7xqQ7lhUVG/zEf4MQonchJeqBk+3RHqrkf9Unu4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLeDe1JqBRGWzz9HkJOJETOqKLCrIjx1zKby46BJHjdNGugDfLs
	QGOr04m//18nmdoSusZ0XAvw2swq4300ptb+etEEHLB5QxepRCxQ/erL
X-Gm-Gg: AYBFou0YNcXnXuuH9q9yfSg3o1ksrQqwHO/8ZyxuQLBXe5K2U8csp2Gc0x/vgPjqMz3
	8YlFb4vl+m5lmC2fCuwP0VtNfytbUj8NaW6ZCIoUDFAXHz5O3m4U7CA5FHMjpFpTF5BeEhoiAMi
	jxAP6IzCDADsrW4DO3SSct8drJg5xoFDqL51cyc0+rslqdzCmi9Lv/X8tGnp+jqaSq6OBlLvo6J
	TpeReBCt4OznqoxUY8OeS4zeIlk4uZWVQnhd9IS+dJCdKojJCxK+Lcqj1uoTqUgj41axz4IcvNo
	/FRwSfFxFcoM7mJRJ9kKORAdhsFVzd+wnshzVczqe+M/lS9+5Bh35kxVfJW5EgRDWm/8AFJTDjF
	wmQbysRPADQm2Bgnvg0lG3y6vAEZNVG5+SBnfhKib2toDp90vRj+fvLdJPGLnl4yX6vZLodoXju
	IIJrTBG5oFfImsrYsYKFBtqeaYeoxmgEKSSu13chkTUwD1OESPO26Qlpnt9dYqEEdGn82deFeHt
	SjzSt/OnLdSJyxvhvPUbz44KUsU5tkf+nEv+rOM2pRRpG9kvWw3IYdVKBfpnyY/v0sZv4WomO9a
	sfgwu0WvO2wUnCkFMHA1UtYgQ74oqPtCOuKIgUCFv+kZwc9FHPo8jtWihijACzhcFS1KKYPRye4
	08JMk+bU0TKSQNROQOLxdEApw48t76X7oIYvDgiElPHGPIENB
X-Received: by 2002:a05:600c:4f42:b0:4a1:ddca:8b66 with SMTP id 5b1f17b1804b1-4a1ddca9066mr49709165e9.31.1792268416816;
        Sat, 17 Oct 2026 13:20:16 -0700 (PDT)
Received: from systembl0wer ([213.194.212.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1c8ddde4esm191084495e9.12.2026.10.17.13.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 13:20:16 -0700 (PDT)
Date: Sat, 17 Oct 2026 22:20:13 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, Dingisoul
 <dingiso.kernel@gmail.com>
Subject: Re: [PATCH v3 0/2] iio: gyro: mpu3050: add missing trigger cleanup
Message-ID: <20261017222013.3ada690b@systembl0wer>
In-Reply-To: <20261017192151.15986386@jic23-hlaptop>
References: <20261017-mpu3050-fix-v3-0-d6f29f335a2b@gmail.com>
	<20261017192151.15986386@jic23-hlaptop>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 17 Oct 2026 19:21:51 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sat, 17 Oct 2026 07:19:19 +0200
> Joshua Crofts <joshua.crofts1@gmail.com> wrote:
> 
> > This series fixes an ignored error return value that causes the device
> > to behave in a weird polling state and a subsequent use-after-free bug
> > reported by Dingisoul.
> > 
> > Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>  
> Not sure where signing off on cover letters came from. There is no need
> as they don't form part of the permanent git record so DCO doesn't apply.

This is actually done by b4 automatically when creating a cover letter.

> Series looks fine to me but given others have been actively responding
> to previous versions I'll leave it a while to pick up some tags.

Sashiko had a remark about there still being a possibility of a UAF so
I'll have to check that out either way.

-- 
Kind regards,
Joshua Crofts
