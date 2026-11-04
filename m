Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793825600;
	b=Clwyq3GBinsKqBCVElREvT0aJFKWRSSHjjT04o4FKPYoJglCWcPw2qzJYzLB8J4lR8wn
	 UPtwujvtZfHEfKE2LBVjx3ss6CxxQwf2dDH1/67hJJocoQp0NtGfAYQZcXe7q/cpecSIL
	 EisTYurL/T8Fo7qCfRDPhOoNFGPrtkN5bAgFHuVxJvJQNhj56Gva4GwC3zk4RyJHafrIm
	 ZW2IPSRlqYXSoO+lzdcUSSf+nL6N2NWRjB0qizf9vtE49K9UE+o4KXgS+Is8nJiWh+eWe
	 1pK5BtNcCOi4/ZGcPryLrLR9oqQSaVmFMzvzaUnh7rNGF50Logzkn60hKvQh3GBIdXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793825600;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=zmIllNxlq1qbZlqDqgKqiUCF60RhHYXlnOkbeNtuUlY=;
	b=srSWqhgUa3Jt3b9SOrH2AY0uvVH/n8DVZeq1XWlZNWKGBQ9gZGzpS85RWjN2gm+8LEiQ
	 5D9pbHtrvtTpd94l9HFW/Ud/6ENuvg/7vgEGtJESw+ydcSnkZhNj4Uxy0BbS+GPaL8d0A
	 Wivjv0EIlwzt+5oMXNVmQqP7FTqGF1Y1TRZiR0mm0dQMBgkXFWJGxpnBqOLNaMVTGBHXG
	 BN6E7tyuVlnJhqCikTg8+SeRecioW/U21Kocf21pMltfsPrQtIWSbP6hxrRg9l9MLoMlH
	 4WhWsJKslHy/y++vSGsEDNrf1/EY2OsE49R59daK6vSCwr88lPC04PBRD/XqavsNRhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="llSXl4/m";
	arc=none smtp.remote-ip=209.85.210.44
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CA1606C5AD
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 20:53:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96CA1606C5AD
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=llSXl4/m
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-843b6f8e2c7so1256464a34.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 12:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793825597; x=1794430397; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zmIllNxlq1qbZlqDqgKqiUCF60RhHYXlnOkbeNtuUlY=;
        b=llSXl4/m6ChCGlkvI0c77hAKQlSxp6woYS0eVy8/xadckgZBEqq3KkBZo8Ba6k9+NM
         hx1k6fHmjndQ2v6K5UkCLuw4Muzo+rx5km7wN4yHQqfqSvCUaY9JOiC34d1EwFIskxPi
         BnZvQYEvslx/eOCU18Q2UCBynRabNYHNH54naa41f8rDYbcx2W5IBta9gS63Qu6jOJxu
         fOPNc2ZDr4u938JJ4k4d7i9YGhXeSkKLd8FTmgfT8DhlV83djezDu6PKkiOGtb4/Y6dU
         ciXblWS62yxcx4vQ5HUfcrfQLB0V5korP2pZSUzTDZKZISVguvDrRxO3ZG4WiWlY/B8U
         I0Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793825597; x=1794430397;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zmIllNxlq1qbZlqDqgKqiUCF60RhHYXlnOkbeNtuUlY=;
        b=FxHpNpX29+E0e3Im4e9x0z4aa9c8wPt/6eYxq98t6RP+Wm3Qwd7PO3cMPPqH5CboAX
         QxV02T/nwvRKEgVwBtXfGfL1GDzBDvPKkMY29fa6KuEuISSoEbZA7FEfViYx8jG3hN14
         jLHOGmLtcv/84laLjfHx0tpA21/8Gg0qjfL3pPmrt/XV8YFfVnBvrbc1V/Htx+AGCCv+
         IK/uq3C+B7+gYiJLgRaEalRI8cj+oeCIEtHWfMVRRsSZGaOsQVjHfnq51Wedk5nle4Su
         iTU5+K8jX7Q3Q2CJWbgTE5e3HdjzJ6BSICaZpDEnsC8NBUrHW4ndVjZvjMWZy32REXA2
         Uvaw==
X-Gm-Message-State: APuU4Z/QYo2GRbASK/TQbbmxWXmDzw+dUKi6ZGS2v/4HD1MCTt/enX2O
	wgpFVsdLWVHr7RVAWD9b3yQ8DKlrL7axJP4RtE77L3qIAGkr+8If8dhE3OKoABs5cDxq3H3sXk8
	2z8oJJfE=
X-Gm-Gg: AYBFou2U9UoHG/qH1cx/Ul7rnGjc76oIss0IgtM3/SzIkOcTUfVzF/OvXbkHVT67HGR
	wCN5e2H0snTJLqPHPujq6Zce7tQrt8X9czSRUYFpILouSPurRs0HZwS9xb6TTxe3M7nic9NiVcc
	1JI6UUq5v6y7jH/RX0irHFvkP2u9TeJJfaeWHGVpEDqz3Xd5fP0iYJ7qTrj7hlBQXUL1dTKQe02
	GSiMgmEfbj3QNJmRA4kpD4BJ5BrC0/GFh7AdXDZOTbNI6KPqM5PX3KLiTRDSsqnzGUEX0oHtrWO
	BdVOh6+VR00Y6c84vf0zVdvW2NqXSY2Y/lgEjqrtJgYZ7VEX8g/YyMSejRvF7TZni8QV05sqvlQ
	99N2CWuOjsl+LCTGF1dEr71siAcbONPBw5bmK4hQNX4AbNPszrZfo/T7TwRwlC9ngNX9+altU4I
	ca3e4D346wBZ7cwBywyIhtBbTkuivEKo7tKTi8dIfRAdSVqRyWBZm+MSfXxMt/t4WcNUbQKbcz5
	1qkJgtmNEpBuvDeBYQrKc7pU8b4IEo9dt0sGGHGyDoUulla4c2KGUB0J0KB9lpWR7SwWAW4zsW2
	RW7J5SGe0R+uNtTEMf0Q8B4MT5BAkWao65yVs8RG6PsMCArwnNksOj0BaPhwJQUMFKNcVIZy9hT
	R481fgsvk
X-Received: by 2002:a05:6830:3153:b0:830:43b8:72db with SMTP id 46e09a7af769-85d365ca9a6mr16991361a34.24.1793825597551;
        Wed, 04 Nov 2026 12:53:17 -0800 (PST)
Received: from [192.168.2.38] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85ef3e603b9sm2755698a34.20.2026.11.04.12.53.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 12:53:16 -0800 (PST)
Message-ID: <0503e43c-5a26-4ee2-9781-083f16ce5cb4@kernel.dk>
Date: Wed, 4 Nov 2026 13:53:15 -0700
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
Subject: Re: [PATCH 6.1.y 0/8] io_uring fixes for 6.1-stable
To: Greg KH <greg@kroah.com>
Cc: stable@vger.kernel.org
References: <20261104184328.516206-1-axboe@kernel.dk>
 <2026110410-coasting-snowplow-6509@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2026110410-coasting-snowplow-6509@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/26 1:51 PM, Greg KH wrote:
> On Wed, Nov 04, 2026 at 11:43:20AM -0700, Jens Axboe wrote:
>> Hi Greg,
>>
>> Here are io_uring fixes for 6.1-stable.
> 
> Thanks for all of these different series, all now queued up!

Let's thank my tireless virtual assistant. Have the entire
process dialed in now, we'll never miss another stable
patch again and may even proactively backport things that
are in the "good to have" bucket in terms of behavior or
fixes.

Which makes me ponder if I should just switch the io_uring
side to be entirely self-provided, rather than have any kind
of automatic picking?

-- 
Jens Axboe

