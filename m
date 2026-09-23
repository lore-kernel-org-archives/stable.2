Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077155519AE
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 15:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790177363; cv=pass; b=GXO7xTyhvyFqkEVBy/GpjQ51wirVRza99Tnr2qS5zRwrztEB3iX7f6qH/oPGK+RdvxrzWi6n9EwST56Bx4orp+oLXTwjfprB6sssDTC+NvD45XL9plTNxDh+T1xFs9hQBcn/FWY1ZoVJVlo90imI/0e/8WzNsL3EKthIcESVJPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790177363; c=relaxed/simple;
	bh=W3L1Ga4gldUm/u+KC6eY0nX2Qj45M7j9FHJidvF7yQE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=OfYa7r7xQ+CiGIzMTyZzQ4fgvh497BrKcRuQsM3csRSrgSRgD4KYNwcjpo+pn3wPc2rY+0HshcMaTU/y0AOg+K2EPf6O0pNHnJAArjxOdNcMhmJVQY6GXZb/Q0aAhOGFgMn4jhgGValnRxTE1iummLCb01NqZwjK0/RTqXeh1v0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems; spf=pass smtp.mailfrom=starlabs.systems; dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b=EghSO2Wf; arc=pass smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b="EghSO2Wf"
Received: by mail-yx2-f13.google.com with SMTP id 00721157ae682-85d440939f0so12034797b3.2
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 08:29:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790177353; cv=none;
        d=google.com; s=arc-20260327;
        b=r73y4SRYL6N0z+t6jsJ2uWZf2KuR8C9Vk51EChx5Q+pxHq90Ugg7uq204H5dXkFFaV
         Ylvkbx6eyuXole0sKA677skpJ3900yQ8GhcYhMRO7/PF8m+63I4K2WgLK99C5uYFt/bK
         S+tFt+t/h5gJbQRTWQ0XQnM7m6QdCrxGYhQKaFPPKq0pNAc6G/jMW5dxO2J6NtL/DXMU
         85MeglawBPOnurftzIxxWxMLdbck7+NgMOqBaKOtSzA1avMul53y9QPlh85bKDFRWs7c
         /mQdIMB5iA2EoJyKaWvtJOf4ItxmIOrewCpd1kfUCzmTEYIJ6L4Tq+5LiNh6X9xQuIaL
         YWeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=W3L1Ga4gldUm/u+KC6eY0nX2Qj45M7j9FHJidvF7yQE=;
        fh=RvEWwL4CdzthXqFPrJY1v5EhszSUJtREhzms1oh7XMQ=;
        b=GoHQBKz65/oRUPQGeDGpS4PSKpru+y030FduHDOJHc4XFQX954oHLQmfPPPVcLStv6
         wOTzXSJ6D85mcC9Dq0qNFMcq59Ils8DyVGgaI57JkgJTHdbY9I/Wf92k+BhEfkEP3Hxf
         hZldulUF415liJqLKxeDwqJYx7m9+OUxDKZWr4qkoRQSHs8BzXPopRy6UNsY5/Ubi6wt
         1OW1p61NgihCwQSnxRmhWBTYI6e90GQmH7claxYXQr7HwHbOj7KBOwAFVXeagllExbBi
         fOJh75tT6XVT+XQPXlcogySrSQfCVQAgbldmBVnaAC2UkCcx05EwAWJ3jK3mE3nLs8ri
         Pw2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20251104.gappssmtp.com; s=20251104; t=1790177353; x=1790782153; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=W3L1Ga4gldUm/u+KC6eY0nX2Qj45M7j9FHJidvF7yQE=;
        b=EghSO2WfLWNAaWKoHPlIVyaVJ0uG3tFpqv7wLBvgnhdtEtd6NEPdD2H5Y7h1LYBcfG
         /Y6BJxHUuYdaK9bGUftVhvN7jplfVE7uCsYN0FcHfM2XXtC28ZZ7u15cswM2KZFmGOuu
         T1h6DnZSw6Vzn9z5R/3ILtzauoSKCOzAKk7Y12Q/eYytirb5XbtKcqXWDkU01UL9OUvZ
         7mDd5ExNdJxc1j1CpjvZElQXMVVWUWng7rWY67co9Y6OkJapENZUAMlZbY2MYoqszyih
         4ARsGdN0hCkLjjfZWZU+b3PzcS2YAk0c44pXWNaZbVS64lFSyNjf9A2QVaptK3cz2MBs
         ziBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790177353; x=1790782153;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W3L1Ga4gldUm/u+KC6eY0nX2Qj45M7j9FHJidvF7yQE=;
        b=bWtoMSdfAlXCQSgJVY7qq3TV0SGtw2sr9Zguei7DDTaHnoOjbbxlQ4wF0euvp0egMy
         /sDhC1H1T5TJprXAFB5xpo0EVvuur7+u7Cj90u/y9EuZqTp2kTiboA7spsbs3TKs2pQD
         sByRNesrCO1QTKqdBVuc66ht/r9uStiJgqkzlWkwWyiWmytYjsYvtYpSxrtsMlK73ej9
         C5MdZUidBfCcSYwOg5VHtjHsltOf3ltE0WDg7SBlcIm7oWR3yTPyPqdwl8vE0PKTz55l
         c/o6Lbw26t/I3C7ircXVNgt7lYzgfwAm+Xdedq2fneHIj/KqOz9GAlDQeclO3J24Kew4
         E8hA==
X-Gm-Message-State: AFuF++lopRibh4vTexsnDmBAudzGAKvIZFKvZQzTyXzqoXY8gXIKPL4x
	2UJtws99t1mUx/8XYquq5AQtruR8O+eeEXQXkg4o212AoIupTI9XyiuQdU+w50H9XTWRBNLxnsn
	RBkH/4W2jrljCrsgYWrTeiIZtohlWZhyPm8eYkW0uIysF2zSgD46cWQ==
X-Gm-Gg: AYBFou1H4jAfHxPQgHlk5jKew6HiNlvOPDK/2ZDKQbScE5V8rT7VkP0v10wIllAUqR1
	gyNpJbiIMVcprT91vhN/9LYyNHyqDMFuifFT8mHHgQvf5Wx+pTWHY/zyP5vosoh05X6BMoWifgd
	zmC/tzHbildbIXj0ADfY57RKBZQZUrC3jvEXVgsyqomVqAE+vippucQ6SlPqNmUL7JrXs+njYTk
	W+ULQAOESnWQIvv2u1xBehUNoFfqXr6JtLs8JoqQSeh4P/tTBCmB/ccwx5Mi6mk90NinNeTAxQx
	NlISriWmMXKc7C/baov9jP0yL/E2yRsrjiXQeG49yvF4ANqQwZQKYKTJig+FpAOmE9Zto0kXpOA
	IdLm4sdFGQQicoDMlAwy54A==
X-Received: by 2002:a05:690c:e3e1:b0:8a4:c2ca:163 with SMTP id
 00721157ae682-8a4c2d94c2amr13829657b3.62.1790177353191; Wed, 23 Sep 2026
 08:29:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sean Rhodes <sean@starlabs.systems>
Date: Wed, 23 Sep 2026 16:29:00 +0100
X-Gm-Features: AcwNN1WxDuwqrtT-JCyiAXCJciP7_NgbKO9ocoYOrhAnphhFHjLdEN4Io0O3bXA
Message-ID: <CABtds-0tUXgbbabA=eTj0NAkRx6oN7LHk34MMmT-GsJYuwddng@mail.gmail.com>
Subject: Backport Request - ALSA: hda/realtek: Add StarFighter HDA SSID
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi

Can I please request that cd401c70df472d3eddd0b6b055726a03c212181a
("ALSA: hda/realtek: Add StarFighter HDA SSID") is backported?

Our production firmware supports this SSID already, so if this can be
backported, we can remove the old SSID from Linux and our firmware.

Many thanks

Sean
