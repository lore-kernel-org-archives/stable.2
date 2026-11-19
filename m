Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795130702;
	b=tGyeoSXw3A5Yq4eqIJouEUaTKQcOXZJaQsqELcn+OVU2P4qdJiUak1fL+ZT45wJqEa8P
	 OVO51q9AUGrZzYUtTJm1Vat+n2/iHsBLNj5k6gK4GG73LX5I2vCLJ01VG0tTT0NdsqRiZ
	 4XJmq5QK5HHV8ahYum0YXOcrzs68p5+auSrFMvbNgtgfCOaS7nnkXsWrORATolAZ1GC/W
	 hILKZFVv+xxZnH6YxLCdNeceANNEAak9SoN9jO9JhKFkKKSu+DHzyG1m3yEPk+8VFY+ad
	 6Kml3+4LjNajj1k5kumyw+je4jJffv/0uwYJbkfcvcSHHdlpB4qhy32eURQJQFmhGiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795130702;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=A3/j58FnCswZ+e/bDMljzhv86aLIWl4e+Biclhf+r6w=;
	b=JLeaWDxn3kZNzMNlYw3CNTzZqqHD8B+VVwTjSYe0o1EX6ZPGISg/ch1xmUsFyr+4ZlzK
	 1WaamB5Yac75pQYPHUcvlcgpmWHzxDpVAcssy3AefETjdU+wcDkPxWr/qod9ImN1G9rQl
	 R86WzkIY4U/jcZO2+LwEDko1DjFyQO9IxgztoEsL6WPJpfzOi68QeMpVcafyhLzvn8dSB
	 ZkPFBPKPYKB5aC9KU/w7ZpPpVXcHIcitLKFJavLSfyrq2ZBZr/kOAnVGA0cP8HP4ONhbq
	 eH6zVVtQyiKGE4z3Q423A+Gh7ggD/wk4bfHbd3fbw53TJx/DxC569ijGt54ouq9HYdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=LMrJHfjJ;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A745606A325
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 23:25:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A745606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=LMrJHfjJ
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-33fb4680717so600568eec.1
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 15:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1795130701; x=1795735501; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A3/j58FnCswZ+e/bDMljzhv86aLIWl4e+Biclhf+r6w=;
        b=LMrJHfjJa8FHEuRUacP3O32umu6ScfYLRrxWk9UT+M2wdLWFO9EnM4hOOqI6/Fq7S0
         DVoIE6I4v1tSeWgaOAUK+yLPmP30hDnIGM2g1tBFy5ujDEYFcgQQmHE4DaA9Ca3RA4eJ
         ebDCjXiLitXY6QPlH3CvskQDfs8NUkqyr/jzrI9aziefd8yKy2KoupiwvUNc+Ll/bXNE
         Yy7OOnFqsPPR44V4Mx7jajA99tpJQASkd/F/vsPFYjBNjMFN62PK8Amow5TximsttJPX
         KV0F1GjHA98LKAUwlaYXwhNDSYJHZfIv8QQJFjqquBMqZP06O6jtwCYr+bt8HeE/akyG
         HaHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795130701; x=1795735501;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A3/j58FnCswZ+e/bDMljzhv86aLIWl4e+Biclhf+r6w=;
        b=Y8Xlgzkt9HJ4Ja9irHbAtc8UsTh4CsAzy+1TlG3UoYH5+/WHVSHFpYdEip0HnQrEJh
         HXMtBfpFDqVUzkw8ncfqgtGx2kvOjylq6T1yA7I72L5JyxdgVzpKFynntVtjkl8OrCyS
         NavhDoWGqTKWEAsSvMw/Ox95Vs45OBP7DWs1mW+Iay630vCM2KJk8duwk+UR0jlSgvVp
         q1UTqE34AXgjiQoMavgH1Mv1Uvs1Fu5z/QOioZSCU0uB7FFSd3D9IMnpx4oMKXM9SiQd
         jYWBT2ZF+ZwwJR0GqYbgE2VITf918houkYMGRJNQVfUXtP7q6cj2eGMVGCJouMw38piT
         y5BQ==
X-Forwarded-Encrypted: i=1; AL+hErE9Kas56UlNeyuJIdCx4k+28+liulPS+76WACIJq8JzjeTNxvY0P2YdKK7zksGa6o2Uoqb/aKw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8mqIBUF+SwpD4KM4rqrmT7FzMr7a2qOqYOJjg5ZXnXev3JrODY
	haIzOy+5XvxZnFtEqIoQsjHI3NY3wL9Zr27DeZ8QxA2ZZeSFQei8LLEMD26O7HAA7MQ=
X-Gm-Gg: AZFdTZc8OPQyccNDkruR0qU1ke67urJo9AU3QHtcWfEygcabJI4vZvDeRVIoLl8gIHC
	ZUTne9w64RViXt91b5mTZERN2qTXcS5v6CJCaYiDQkkJoRfP5HJwZX7P6obXVNYVtR0+zBNmfrC
	oKEQ+tnUGU42Xue3K13AqSLOSKjLQTUaLZoFtJCdPN0cTRdt+VcNu6LyGKE9+rTQbkopqsyfIZe
	5U1wJMpWMc+Tf1C0ieoMyerhbzRtUHSMAelBqOexSKW2wOBao0nnMygjGBIwlnd52ofVr7GZvkJ
	WkyZMQE9JkXRb3t3V52pcUbtxzRe3fG6jcXd+yI5j+KcvFNloMcTZpdCn+r5aDlwR8HY6cbKykb
	veg+LkLOr4zQZSTnCMCTIZDt3jvcE1yyuEVB4chcWeMLQKJ0Bff3wRnRV7cwGRACSr2krHj6dZd
	UlcRrWry7q57XhWdYZlk7F0M4LzHJJWgG/mWlSEy3pKs+BMiEOEv9X83bZjY9ShJbI7HbqTgsjQ
	wuRP09NOkkUQmRWZdL53x6knFlbdm6HfsldSdVG9YyZnov4wODVU/kQydtbE/MYrdy3xtrlmE00
	Pq2vGRdDkp+Sz/D82ui8nalv91eaCO3TB6R9zC7NgvyUPJe1ezssYUvEML7U/gyeEjqHAnPcRVc
	j83DtGjzHs8faxoI80dJHTcxt2qUhstLrDbrhBT3lScTEZlkk++KTWIN/4p9cRJF6rKHAIg==
X-Received: by 2002:a05:7300:2290:b0:379:24d9:cb98 with SMTP id 5a478bee46e88-3856925c033mr993484eec.0.1795130701452;
        Thu, 19 Nov 2026 15:25:01 -0800 (PST)
Received: from [192.168.1.142] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385672c6f31sm1782850eec.15.2026.11.19.15.25.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 15:25:00 -0800 (PST)
Message-ID: <981f45d2-c38c-4ac1-893c-17ce3a8c3f0e@kernel.dk>
Date: Thu, 19 Nov 2026 16:25:00 -0700
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: io_uring/eventfd: registered eventfd signals only once after the
 cd305ee3633a backport (6.18.y, 6.12.y, Ubuntu 26.04)
To: Sasha Levin <sashal@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
 Yufan Chen <yufan.chen@linux.dev>, dev@rebasedinc.com
References: <oMhla8VwCWoihfrmgn8znIy60W1QXI8g_v2OyB9i6sWESIDlVJlwoGGOLylJgIHRARNoieXUVRGqzeB__KvHMdXgnCfPPovs8vLMOzaMPEw=@rebasedinc.com>
 <draft-agent5-0001-re-eventfd-signal@kernel.org>
 <5d92861f-9a4d-4810-8700-b9e457ed9c86@kernel.dk>
 <2026111605-deskbound-clobber-a4a1@gregkh>
 <07947062-2974-4630-90db-1556e25b50bb@kernel.dk> <avxLtZ2YLHdbeZxC@laps>
 <8e6c1d69-9910-4c89-832a-34ecd65a0ca7@kernel.dk> <avxPlrd77WiXagvs@laps>
 <8e8bd832-ead2-4d77-9ca8-48274637d26e@kernel.dk>
 <20261119203921.972086-1-sashal@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20261119203921.972086-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/19/26 1:39 PM, Sasha Levin wrote:
> On Thu, Nov 19, 2026 at 11:10:03AM -0700, Jens Axboe wrote:
>> But apparently nobody looks at aio?!
> 
> We do :) Here's what happened with each of them:

Good!

>> Commit: c03ce4173c7b
>> Date: Apr 13
>> Fix: Ring mapping inherited over fork
> 
>> Commit: 3adf7ae18bf4
>> Date: Apr 18
>> Fix: Partial mremap of the ring
> 
> Neither has a Fixes: or a stable tag, so they're not even in a stable tree.

Gotcha, that seems like a problem then for current maintained stable
kernels, where any user can crash it...

>> Commit: 398e3fa789aa
>> Date: Aug 13
>> Fix: eventfd/epoll recursion on poll
> 
>> Commit: d53b5aa5cfae
>> Date: Oct 29
>> Fix: Fault races ring truncation
> 
> Both shipped last week in 7.3.4, 6.18.63 and 6.12.117. My LLM review
> flagged both as CVE worthy. The 7.3.4 batch hasn't been assigned yet.

Makes sense.

>> Commit: b44341e39d85
>> Date: Oct 22
>> Fix: Request count overflow in ioctx_alloc()
>> CVE-worthy? Not in my opinion.
> 
> Agreed. No Fixes: or stable tag on this one either, and there hasn't been an
> AUTOSEL batch since it was merged, so it isn't in any stable tree.

And this one doesn't matter, imho.

>> Date: Oct 30
>> Fix: exit_aio() returns before complete()
> 
> I'm assuming this is ac4b449b39e6 ("aio: don't let exit_aio() return before
> complete() is done")? It has a stable tag but only went into v7.4-rc3, and it
> isn't in a stable release yet, so it hasn't come up for review.

OK, it was just late to the party then.

-- 
Jens Axboe
