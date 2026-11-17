Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794882102;
	b=sTxOJYONQBTtiVG9yqVs78suvxXz95GJKynQDJf6bQzkb3jhqAk2JsYO70FH5xg0AF2R
	 kZWst1fApU5u3klkysdjtGbII0TrMEUeWUf0qmXDV+pObZrEW1N0dCgB6/NEomKNmQGi2
	 ejubcBAyxgPKx6V5wiww3g54xo/cL+SkWz+T//JHvyxhVNO8PihnGkhhfU3+MNzdsvHvK
	 RtpcFLTqcPPsJgTDKz0PVBNFc5h/2EttLSWyFRhAYcWo9MJ1zhkSGZs7kmR+OtqpOE7qy
	 Y7kgsvxTkHedGliLcpU4r0uRPnjzROxwyT3L9iGLIzuNzpiMHhgzPmB5wiUyW0dM7vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794882102;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=ncld42tDn6XcKva7+KFXwbd1kjlUpIEInfIcN7jos5w=;
	b=EyVocIesdTRr6EbhV241JCnK83Hdcu9MURuXgqtOIUE/NO62stOW7DbycWRqsA/yOXKz
	 QAyJ6RAQFd2gqpvefwvqpQ+wUhYGcT2AmPgbeOXZyc37IEd0Yja+fEYNElBvRVf70bIeD
	 Hm2BOxYTERLm1AjdY0dI8rR2LLWcHHOaiDJQAVkk8nlVWewdtdzgFr88Xe36bu69zBIO2
	 XTd/MBi0Ke3dqMqBFJD8PMOZRAFW1zz4TJsAr+V3HndTJN3Zla8EbtuV2S/oBuRi3E57r
	 CReKCfLsKYGyijCM5uQeDicmk8xvmc3U4vab2wgDG0nYk4qZJZmyIUBrpRL/YV2VBNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ap+DPoBE;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1895606A31C
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 02:21:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1895606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ap+DPoBE
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-38133db970bso701561eec.0
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 18:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1794882100; x=1795486900; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ncld42tDn6XcKva7+KFXwbd1kjlUpIEInfIcN7jos5w=;
        b=ap+DPoBE17krcJNjdiBru2o3KKfNUg1GqppeX7H87tHY0/EgdFC55amn498E/TRGjI
         XOkt/8dRiA2ZEWoKm2mXahBPIGJj5CP1RNfob9xIUSEk696eyS7bboReH0vs53MS3pxC
         SlQVJq7Jp5mHiDczDMSuyDBXFvNVWASOX83rt7zkUtQIoJIxe74zqjP3gH0SIdDj8A6L
         hMX9qTAAGxgqVJ1o7lfHqnl68D0hhTnPhsFqFWopSkWRl55CbFV3SkcrsTgXu7z2jtTT
         Qj7JHCgSMoyjMokpywBA6Fp3/5cD1ijtcBTMlMdvVgBdt4lYdZDEz8BNu25oJt7J1SVV
         cv/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794882100; x=1795486900;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ncld42tDn6XcKva7+KFXwbd1kjlUpIEInfIcN7jos5w=;
        b=s44f0HUlITgYIwPf4WdLuRQRNvIYwHknwBbmGqt3ad8Mww2ArGm94mUsX9YtTwXaFT
         o+nJ8ScRDKjiv/hketNV1KJHTaFlpxAA36Mu/i3pKxLXd2/FL2u3G3XDriHZ7cazNXw0
         y+JRSKOrqE3d1/b/2CNznqXTyVll3lGkBNUUOGNjdTmfwYP/XFkKQztUNRTVt+F1KbCG
         tmxo2BACWN75U4jwj1yHIR/VEVqRldiIYomoTv4TY6tctmzItaFQomEqvu916EVJU32C
         SnYJdkIDpZLX3NnXh9Icd2raonFYXi0ZQcNYI7ZEIAUstd7TvFoytpWtf8/pvfB+IPVM
         0gow==
X-Forwarded-Encrypted: i=1; AL+hErE8KYNCbZpa1guUwNuU0wgepFxu+TNGuZbB6rbuCi4JXjDYVs30o06cr3Y0T4/UFf0AvcwOPAc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+hPKKX9j0IGRw29mLh4jtb0uQEM88zUL6ce6bBLAscJN++kS1L
	C8ca+ggYj9FF689bF6fbo8yAay6e40VHjhG60w8D3sEW4lh6bkjtn+rRmpxBnSPCteU=
X-Gm-Gg: AZFdTZctVyED4y4XX6qVpSkR6kNrkqxf99u2k6GIbk0EjXHXsADgeNu5RdyeODxlQT7
	DiZGS9FuS2h9CZtHv6R2YMLidjjwUmJeHCz+vWo2nvetNyGPD0e2iw8VFhdDh+LuhXGXl6kGSS1
	GFTLzpnZHHmmov9Xi59bXm3Wtry8urj7U/o737/yGQkPo4KuMUgP37TuMFoR9GrCHb5gsmmn/HL
	zeFupqGkRYyK1b2/lxAo1uGLSvuNR7wGNfkSry18Yay1M3D4Oi6/wYZIxL5jU0r6rjQ2IqLd2Bp
	kZ/cACNjszbupJ8eqOyIb3cf7KHlmNIW3E4xOfltYgy51GCR06WvYH7TTsGpYem4GbaKEjeE8D0
	mNlgIWSWyO0LhmZ79W/OMvioDAU+C7l53j8++DdmE/30KDKwJXaVtBK8M6S9exlzjtUx2b2oyjL
	B6W3/XrzSj3w+PtKQ6Xhc0iL+VLLG1D3OvUpRDN0a0UFSNBSXPHX4EQGB/K/gtsSGIH9GEalhs6
	xLu6ZYc4jQoD5mIitIKwja+C889vxxIQXaNio3mCG2EVPA2r7qrOlYkUSowgcK00VwOSidKMz5S
	NUEYi0brK4LPW+a0z0rguSTrCkqD09zsNpSIsiDKPc1sjDfSnexpPm0ljY1fHrflh9SmrzKJaJk
	3Gxi7nINJhtP0
X-Received: by 2002:a05:7300:dd03:b0:351:2958:1740 with SMTP id 5a478bee46e88-379681c67bfmr11608907eec.37.1794882099628;
        Mon, 16 Nov 2026 18:21:39 -0800 (PST)
Received: from [192.168.1.142] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37956bad134sm47264660eec.27.2026.11.16.18.21.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 18:21:39 -0800 (PST)
Message-ID: <07947062-2974-4630-90db-1556e25b50bb@kernel.dk>
Date: Mon, 16 Nov 2026 19:21:38 -0700
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
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
 Yufan Chen <yufan.chen@linux.dev>, dev@rebasedinc.com
References: <oMhla8VwCWoihfrmgn8znIy60W1QXI8g_v2OyB9i6sWESIDlVJlwoGGOLylJgIHRARNoieXUVRGqzeB__KvHMdXgnCfPPovs8vLMOzaMPEw=@rebasedinc.com>
 <draft-agent5-0001-re-eventfd-signal@kernel.org>
 <5d92861f-9a4d-4810-8700-b9e457ed9c86@kernel.dk>
 <2026111605-deskbound-clobber-a4a1@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2026111605-deskbound-clobber-a4a1@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/16/26 2:52 AM, Greg Kroah-Hartman wrote:
> On Sat, Nov 14, 2026 at 11:12:40AM -0700, Jens Axboe wrote:
>> On 11/14/26 10:42 AM, Sasha Levin wrote:
>>> On 2026-11-13, dev@rebasedinc.com wrote:
>>>> If this is correct, a backport of 04fe9aeb4f3c to 6.18.y and 6.12.y looks like the right fix; it keeps the CVE-2026-80920 fix in place.
>>>
>>> Queued for 6.18 and 6.12, thanks.
>>
>> Yet another bs CVE - Greg, please invalidate this one too, it's NOT CVE material.
>> Getting a little tired of chasing these.
> 
> Now rejected, sorry about that.

Not sure how we improve on that, it's really annoying to catch these bogus
ones after the fact?

-- 
Jens Axboe

