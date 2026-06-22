Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69014340407
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 17:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782150510; cv=none; b=m7BE2O3UzD3ACfrnlopkyFy2gDEakLy1RhWnLK4tvvHMDbRNvZbtNNVcRlt+xAFZLdzwzqQXYptwon8C5f7M7mkF1EZsW+R5rqZ55E/6209pa7J/EKJ5wDCXmrhsNNc1Tkx0ray7KCetTp0yZusePg8SoGKH1xHyX3elgey68YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782150510; c=relaxed/simple;
	bh=rT+UtKMtzGnsnjtDXBDLQP30MQk3djrKnOyWlXkyvIw=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=U+39+tMJLMkDpq64lr9AKBdg9rUUW8SOuK6aQdGrngyDeiNx6FnLfhyeDBPVc5j0YUMKiHM2XwS6jkBjp3AHzodm44Um7IdNA9XDfh0u2aj+wo/J+aIBMT3CJ7kZfZYAYmxfAjh5a+SOTPvytpAhXvmXPZhR/sLHVIJds5yQwe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q0f92W9A; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0f92W9A"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-805f5d1a6c3so8444207b3.1
        for <stable@vger.kernel.org>; Mon, 22 Jun 2026 10:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782150508; x=1782755308; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=33veWonGavd+osVYaZO16Ido/MSdlOEETv1HhacB24U=;
        b=Q0f92W9AAVD8CyTlZPOOj6rGZXrm1afo90xqXd/BHWsbEW6084DAARrb18A/Uiv3mR
         3k/ki1DY49QLWFWy8bZ8QyUEr+miikmIAyUM2x3kGMwG2oGLE+r1Gx4UJpVl1d2oaQs2
         h5Vu5gq/TqZ/KWVv/PaRpOM+wtiSAFreC5D7x2YjQaErOxHbQYQRX0oaXHh/UiEadmEe
         RLP7VL7ZL+R+oz3Rc8fNu40bdCMo7s7eIvpFhBgCmP7L9g8ztSQdBabQ4e+DSZDF6/vy
         jBxD+1cREN6469Qx3TIm+0W9oG6/9EYkDK9id4i1WGzjrXAkd3AOPRnOrFv7nama0sAa
         PPgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782150508; x=1782755308;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=33veWonGavd+osVYaZO16Ido/MSdlOEETv1HhacB24U=;
        b=LP6PXIM4CZSTYlnu7qLNq+cpFKXBilGJ6qSzdl5XSNKeGXsxr9n2NzB9YD5WH1MIax
         J37Qv/jTlkrpkzscoSF9S0bUqzPMivE7zzWgBUjmpgNBWWOZoIX3ADFq2sxwwHPXQGj6
         8beRjlU3SI89A5notTkeP47tPzmRKZ3qui1SWIgocPGZ2hQb+LL/SMjTSl5JLPkK+Xiw
         OcxPinXjqnI4Ca4RzYlnW0c8IQH7YRnbXl073GD8V+OryE86mjov01I/oGwn5hxZwCLG
         Fd/zpj8/dLP8eQpxFp4S4Nz9ummPl4o69Qx6JhwZDb/1aPNUWkbIlQcSTrZvEuneKe5S
         qXkw==
X-Forwarded-Encrypted: i=1; AHgh+Ro2DpL1+JEkg7Q5ZcRXbga92TDGVj5hvY++6d3o9oTli9QVmoEjHjuIEDmNS9RliXEUNw8jBV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHmvmKeGpHndx6zTzT9uEgVsehE2gbqPWj1fTdFOmHVvhJugRO
	cdYi1wjoONYJOQiF9XjkUSX3rYjPsJPmmGlSw64g83lDcvzw2RhGOPkQ
X-Gm-Gg: AfdE7cmq6XIJ4edAg5JC38eBLHHOqJyaZlYCyCBwv7obQfnzwmX6qlP10CllfzcppLa
	DhT6iHwKYci1dx9ZQBylprfg2EbgmPRomiKDa9L1QRwPxxMIIc5QrnWq9xGncsdRiIeHxUV8QQZ
	61PIgQP6x+rhFYyniJRdyhu183kIKbkHrwVyYcSv5pXS3fLKCDw0M1dnFdstV4q3+RdbU7b89KB
	7YPVh7wb78VO9EHmJ3qnGa5482X3vQwHi2kUDYxzBLAF/7b0ICxTl2LkDF3DqH8UtGVswpymzHA
	en59P5X2DvGrv6LnF6+n+/3flZ93uqWx8EnBnmEex4XQLpZigeJBVCAdMLZr/0tUAYCeIhcq0nS
	ryEUhQnH6Pq3q8aZP6qOkqNJdQv6P21yZHFRF6qkktm63X8bf7OjsbZRue4xgpFaafpC50sNQKZ
	OVvYW8KJlRygnY7v2xG6JWEvMyeXKTkXnfWHpCgmjhmJJn4c+D6rXVD5oQq/O320/LvtYMBVhtR
	Cuak+2W/0Sv14U=
X-Received: by 2002:a05:690c:4b10:b0:7fe:bd7:9cae with SMTP id 00721157ae682-80178c4a2ecmr145514817b3.44.1782150508479;
        Mon, 22 Jun 2026 10:48:28 -0700 (PDT)
Received: from WIN6DK41G9CSL2 (c-73-56-149-95.hsd1.fl.comcast.net. [73.56.149.95])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8025f8da5fbsm34884557b3.30.2026.06.22.10.48.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jun 2026 10:48:28 -0700 (PDT)
From: "Brien Oberstein" <brienpub@gmail.com>
To: "'Stefano Garzarella'" <sgarzare@redhat.com>
Cc: <netdev@vger.kernel.org>,
	<regressions@lists.linux.dev>,
	<stable@vger.kernel.org>
References: <467b01dd017b$733792d0$59a6b870$@gmail.com> <ajkAlpiyPWmNPWfx@sgarzare-redhat> <618701dd023e$063de350$12b9a9f0$@gmail.com> <ajkmjgGdJp9Dj6em@sgarzare-redhat>
In-Reply-To: <ajkmjgGdJp9Dj6em@sgarzare-redhat>
Subject: RE: [REGRESSION 6.12.90 -> 6.12.94] vsock/virtio: large AF_VSOCK transfers reset under backpressure
Date: Mon, 22 Jun 2026 13:48:27 -0400
Message-ID: <672f01dd026f$54fa0600$feee1200$@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGzlm2Q3QdtCPSkkHXQpTkeFGbfJwIutksBAb+8QgECzm+rZbZnykdw
Content-Language: en-us

Hi Stefano,

Confirmed -- the 16 MB buffer fixes it: with socat owning the VSOCK-LISTEN
and SO_VM_SOCKETS_BUFFER_MAX_SIZE/SIZE at 16 MB, a 6.12.94 guest passed
21/21 large transfers (1.5 MB x12 through 8 MB); the same 1.5 MB payload
failed every time without it. So the per-socket workaround covers the
bridges whose listen I control, but not vsock services I can't
reconfigure, which stay broken on 6.12.94.

Agreed the old behaviour was buggy in its own right -- it was
over-allocating past the advertised buffer. The practical effect for me is
just that a config that worked on 6.12.90 no longer does on 6.12.94.

A question mainly for stable@: until the merging work lands, would an
interim be acceptable -- something that keeps ordinary small-packet
workloads under the limit without reopening the DoS? I don't have the
kernel-side expertise to judge what's safe there, but I'm glad to prepare
and test whatever interim you think is right, and to test the merging
patch when it's ready.

Thanks,
Brien

-----Original Message-----
From: Stefano Garzarella <sgarzare@redhat.com> 
Sent: Monday, June 22, 2026 8:22 AM
To: Brien Oberstein <brienpub@gmail.com>
Cc: netdev@vger.kernel.org; regressions@lists.linux.dev;
stable@vger.kernel.org
Subject: Re: [REGRESSION 6.12.90 -> 6.12.94] vsock/virtio: large AF_VSOCK
transfers reset under backpressure

On Mon, Jun 22, 2026 at 07:55:30AM -0400, Brien Oberstein wrote:
>Hi Stefano,
>
>Thanks, that matches what I'm seeing: large transfers reset mid-stream
>instead of the sender being throttled (reliable above ~1.5 MB, fine below
>~90 KB).
>
>The bind for me: it's not just this mail bridge -- I use AF_VSOCK for a few
>host/guest services, some of which open their own sockets, so the
per-socket
>buffer workaround can't cover them all. That leaves pinning 6.12.90 (losing
>the DoS fix and further kernel updates) as the only blanket option.

Okay, but in that case did it work?

>
>A few quick questions:
>
>1. Is a -stable backport of the merging fix likely, and roughly when?

We don't have a fix yet.

>2. Could a smaller interim land in -stable sooner (e.g. more default
>   headroom) without reopening the DoS?

What we've merged so far is the best we can do for now, but anyone who 
wants to help improve the situation is welcome to submit patches.

>3. Will the fix guarantee backpressure for any packet size, or just widen
>   the margin?

It should fix STREAM sockets for any packet size.
SEQPACKET/DGRAM is a bit different since we need to keep boundaries, so 
it will come later if needed.

>
>Happy to test any patch

THanks, I'll ask you to test.

>I have a solid reproducer and can turn it around
>in a day. I'll also file this as a tracked regression so it's not lost.

Unfortunately, it's always been partially broken, using more memory than 
specified, so I don't know if this is actually a full regression, but I 
understand.

Thanks,
Stefano


