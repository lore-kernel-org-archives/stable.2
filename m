Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9C13839BD
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 20:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789072956; cv=none; b=Z1LenE122k8CED9it0VJUVrYgrce82dVLEZPwAtuwKgaHyxuy5mQlKa01xNBp0SKByKOaPL/bx2A/fOLdRQ9RUZemvrFzR79sCrrWuRhGncU9PVRWPQqm2T1f7a4bZM3SNK68P7HYNFuLCHGKAI12rd8vbqOliYUGwzYUkvMQOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789072956; c=relaxed/simple;
	bh=T8AI6zz98YT2XvxQexh25jUz8hb2aezWsx53Uje81zY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hlnXnqCKya+c3ZGp7SZ3Pbd22lJEcBmZJg7WRGXfedMHZcHLcvMECKGr0CiHju8dwXQFzuFfAbO5G/Ap7WaZ4sd/2Bcn6feryeI3ouv8lVGQ3gYn60NmOjwmNM2VR6O+n57DWVuCMocm7Qn9wEUsgHHVdbUIoVto6C/8RwVrew4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=w+w50t/D; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="w+w50t/D"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-4b3a61bdf22so193382b6e.3
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 13:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1789072952; x=1789677752; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EJeMjEnGwE6YfwsB0ZWzUhZX7pW6U3oN/OTqHwlEwzY=;
        b=w+w50t/DcUyo5Idks+n9jIiWfXcV7oQ7XbleirNFB1k3EmBg2fS1m8KGBt/jn15U8B
         wNST0Nf9+lp6PQ+vkzR7zvzbxIjzZ43ImJ2QZi0rFDGxFDZnBVq6Pq4SILlGOkLLnEBo
         NvSlrNT3dSO/gKCWzCRX01zHWyAy45SrnPHxxSe8ZMK73UINvqKJ4Uz3pvTNJhpH4z19
         W+WRADR/Oq2fd9St5Q8cOnkJCkYAYexWpXpoHIdR8UnovjEM2sHuIWyy1GAUI/jg4qGa
         zv4dmG76bO9yW2PXEHED7kICYDnrLtkriI0ww8qKLAswR4SLH1qToIbs0VRwkWXmnsbX
         /qXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789072952; x=1789677752;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EJeMjEnGwE6YfwsB0ZWzUhZX7pW6U3oN/OTqHwlEwzY=;
        b=DALRWzbThY4Sz/es5q7aIzi/sQxC5FwRvNK60isOsUT0Ll0S1/sfUzFE9tVgK4p+FY
         JRJ09Mk5t9h4kbEhdsE+uc7xFxIjODTv+pGxqlGbVCvB75I/44ob/KeXLWNAosLb36Bp
         CdvGt3jXHD50glzY5HIr5xhA2R58DUIA8hLGw3uyTYD/VsihWbyP5Jms6wqWp5AVjoMQ
         J92CB7OXsZhxIJN+uhbXWdU8+Ml4Jui+EEVk88nZFIx4nbfTYQJ3nvAh4W8vGBDb0AUn
         EYd/MVkFXOsmO0wZcxxCLFnsD70OTWtXJPvpE00oGtcT00Ys+Uwt6INDtXs/LofDiwJg
         VOvA==
X-Forwarded-Encrypted: i=1; AKwUvBzDUJG/YRiTeSimhajJ6Cm5tIO76o02vDkuIKpdAvPP83wdzbj8ti9WlPMaK40PYIGSsh5q1ZA=@vger.kernel.org
X-Gm-Message-State: AFuF++nS7UlKDZWB4AppfYpH06OHJxGUvr1gw/sIoZfiyMIWCLhsXeL9
	dC0sMQ0UU6nO/qBXTKkpajXHi5uASAvw3yBZqw3LyYZZFRVtmGh9rrYySFjMomrGnPE2HRZ7J4h
	oNem8xXE=
X-Gm-Gg: AYBFou25Q4t5RS7qsMMj/m4CarehPyOrf2/Is8AGg/WLjYJGB0K2E7JV7Tf0b6xpZbs
	nzOHI+5ntNYVVXoP3PWQgIrkJ7maW9QCPmTt9j0YRYAMFwNEPNzBzdah5d4SG0ohzJV+fnztk4l
	UoFoB1mSI7eiT7UURVvp7CAW88g4okcTum9E2rK4ty3tsNjyrkOUkLEtxPukEC3pgqh1gsvROcN
	5pZsjZv8bm50R0ZLHMmfspxDLo9kxPbW/k5qIhfDyv8Ku65hwoET0PE1sQO+reAVVhxPkLS5Ped
	S1uqlaAAOKlGddzTNJd4RGUWCnhzE+NC+P5Z8llaxHHwmat+3bjxmU0mzuuNw9GZZStM3XpXW6G
	8NzunwY66EfOSzzYk6kxcmKcmPIF4L4u46JyFqjfgmOp1NPVxv31jbkpFTONI5IDTbv50DQkiKs
	b8j02vjYImKv6QRd6GirJuXbbkVopUx/CAX0iKbAg0yCFShHl/Oy+M4FSJqj9h1SaR7HO2EibLl
	D8Sn9CRRw2hVgCARWRRRXk7Qw1S5uwRcFQ2SZFQBVs0ZBwRU1j4UglK
X-Received: by 2002:a05:6808:6d97:b0:4b9:a88b:8882 with SMTP id 5614622812f47-4c31bceee11mr683144b6e.24.1789072952050;
        Thu, 10 Sep 2026 13:42:32 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4c330daa69asm265238b6e.5.2026.09.10.13.42.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2026 13:42:31 -0700 (PDT)
Message-ID: <f62ed378-6dc7-4574-80fb-54b07f7bcf31@kernel.dk>
Date: Thu, 10 Sep 2026 14:42:30 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] io_uring/net: don't overconsume buffers when using
 MSG_TRUNC
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: io-uring@vger.kernel.org, stable@vger.kernel.org
References: <20260902230041.1320658-1-krisman@suse.de>
 <20260902230041.1320658-3-krisman@suse.de>
 <0f5e8693-dcba-4fa8-87d1-570ac08e2d83@kernel.dk>
 <87a4pp2iog.fsf@mailhost.krisman.be> <875x0d2ij4.fsf@mailhost.krisman.be>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <875x0d2ij4.fsf@mailhost.krisman.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/10/26 10:11 AM, Gabriel Krisman Bertazi wrote:
> Gabriel Krisman Bertazi <krisman@suse.de> writes:
> 
> 
>> I'm folding your fix up in the v3, modulo a compilation error.  It only
>> changes the error path, the bug is still fixed on 7.3 with your patch
>> folded in.
> 
> Please scratch that.  I misunderstood your previous email. I see you
> applied it on io_uring-7.3 with your fix up.  Looks good and the
> test still passes. I'll turn it into a liburing test.

That'd be great, thank you!

-- 
Jens Axboe

