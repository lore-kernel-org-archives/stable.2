Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4950D3AE1BC
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 07:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786433336; cv=none; b=YOnU8hWO475eEA0aKKkEotHhNVPCcpvg++cOL8L54OY2KnCnmUtJJX3Qysm/vPxB1KY4utER2khL1+WOImNvZS4uOG4lTKTLSdsalFBfr1rWokXvEHQaKjpDcT8ivNoJWN7ETvTYsNquJIkj30XSEfesyMsvVK21gaCO7nmdBb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786433336; c=relaxed/simple;
	bh=8EXUz96E7wG5U1YoUA9ESlWFgT1FDI24Ni/grIsQTP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WDMN594zcD58d7CY9hU3uuOojLxKgS1ChTmD124WabdA5NjG37cpKKn9TIYi5IBdzG/jTw0ePYNLjSqqxvSs5lCwoTMa+PUTiRO6r3wBgdmjloh+OcQEfOQeeE5ay9j4Y/IbcbG9NBkIo9Z+G67Un8va++PKKLrwR0ERWw/sTGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R2QqVsKD; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2QqVsKD"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4957eefd361so20323155e9.1
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 00:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786433333; x=1787038133; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yDP8FL9MuQ0PXH9ggGxLVTnQzIMzeA/Agxw+EtHBOZU=;
        b=R2QqVsKDGWsIAMzJGwdzO7QNPxbKvRdLr5jwPHJGY8Acoms4jBz2XwCN9VQuAU7BR5
         cvUljH+YksFNonerLwIN/FeTjNLna8Uv/UuoNDO8+B/N2EYfiWUzWvV8SssQN98qX7Xd
         2btASV+x7XJH9rQty9JGnhgsr/EKIy+yGfx0vkAx18Sn2vUhjOaZBRdTJ5PU0mG54JKP
         JXYhStO909iJcebRIWzFN7yiWPnJslFPPjoVNStit0jyu7pdUJuopA67z3aEDr6WPzSO
         uyPcwrvKzdXUqCz1waRqdzJ37821KH6ffF8dkYpqHl/FjcNIqmrUn3g60XSoJIUDILSC
         DYbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786433333; x=1787038133;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yDP8FL9MuQ0PXH9ggGxLVTnQzIMzeA/Agxw+EtHBOZU=;
        b=JC2nf/v8+vwfkZQdOd4LQ+YXzuo1oVi5BMOGhGaTcOpt5P/d5vftDMFUFfl+yopoKN
         9X9lz3NLgjBmL61yLQqoG4Wh4UOAC87TEE0vc2W97NIREOdD5IVfUPfigPiDxRZDXSya
         lkgs1uNQisKZMGbQi+TQtJwLG6+uMzKl5opP+ZKKrLd6MkS6NKfs40FlVzVmqJQV52BY
         fARN85wgTItoPr7kCvepXLXlwqt1mZk6SDGiKP6giWCNCTfcrz5x5vUYbkChNNQBqkmp
         1nNw/KB8382PvWnNIlJaL3aY4paRhCXAKb2eQqICCgT9dosDJyWib4eGZ5m4rB1KJH11
         2EkQ==
X-Gm-Message-State: AOJu0YxuAdv57DuQa0o78LSQFTAulgtA1hW+lxbR5uSVHzlx3ZkOJPgJ
	fpADDMTXcvgvvyJ4DTB3tOctkgjaJ0CDa5zdUAteCL/+nlJZhQrE7VzY
X-Gm-Gg: AR+sD10ddsgSP0ItwNqiJ4pDIA4Emfvt6H07x5alhtPU5hS0GEC/GfOn3hXF5+G5T7G
	Is9fdJsGTexcXRBWMxDjj1yTjA2BOkzsKiQEU2siVXVweHlHsEzqHOIqZaOVgMUGAB8g8xshz/F
	sT1/ksQA5Xck2jb7dQLmmAih0IY+gZcsJUUSYMAw0BZAf374I6+ZVS0oqA9uu/Bp8XBPV/1yxDJ
	liVO9RxGulzjH4R93qyQrqeD+CDhwmqRBkKqAKa+o+e2hL1IFM1XlLrUUy69jBTfJji7sgpioYS
	+qp6gQOU26JWPvaQPmuiRT9daKeni7oWEsX/9Uak9LbPAJFWmzxAHwmtKSmNqNbBO/DCjK0CmYK
	dfB3rkuXyKjQt0RlEWzWUWxTuTWRTS/F0udZyv/fCYolVpM7Y6cGdmz8xeyyXXUgoIxjaCNyd4E
	hHflJ9/9j1lvuewU31GYnEimmFqROnIaEJfkunm5pwDduFJo8AZ5YMkrKXwq96q5izXme6eeqOO
	pVP
X-Received: by 2002:a05:600c:1381:b0:495:5fdf:2075 with SMTP id 5b1f17b1804b1-499783a9ef4mr21293835e9.0.1786433333391;
        Tue, 11 Aug 2026 00:28:53 -0700 (PDT)
Received: from [192.168.10.195] ([188.216.175.96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997415df9asm41374625e9.13.2026.08.11.00.28.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 00:28:52 -0700 (PDT)
Message-ID: <1caea72e-b9c8-452b-a3ff-5690d948b4fc@gmail.com>
Date: Tue, 11 Aug 2026 09:28:52 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Please revert 1191285ecb42 from 7.1.y
To: Thorsten Leemhuis <regressions@leemhuis.info>,
 Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Mario Limonciello <mario.limonciello@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 George Zhang <george.zhang@amd.com>
References: <9c6acb62-4080-48e6-9ba2-d1c457c4ec88@gmail.com>
 <2026081106-pebbly-cahoots-37a7@gregkh>
 <23db5f95-c2d6-4712-856e-28f647e184f7@leemhuis.info>
Content-Language: en-US, it-IT
From: Sergio Callegari <sergio.callegari@gmail.com>
In-Reply-To: <23db5f95-c2d6-4712-856e-28f647e184f7@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/08/2026 07:24, Thorsten Leemhuis wrote:
 >
 > And yes, 6.18.y seems affected, too, according to a comment in the
 > ticket linked below.
 >

Yes, my bad I only mentioned 7.1.6 to be quick. My actual concern is 
that the troublesome commit got to the LTS kernels, which I think is the 
biggest issue right now. People may find their display completely black 
or almost black as soon as their DE starts. Getting to the conclusion 
that they need to /reduce/ the brightness to recover is not totally 
obvious and is not applicable at all if you have a system that is 
touchscreen only (since you won't be able to see where to press).

 >> It needs to be reverted in Linus's tree first, otherwise the regression
 >> will be hit when you update to 7.2.

Indeed, but I think the biggest issue is with the LTS kernels right now.

 > Normally I'd agree, but according to one reporter that problem does not
 > happen with 7.2-rc:
 > https://gitlab.freedesktop.org/drm/amd/-/work_items/5562#note_3603131

I'll see if I can try myself the 7.2 RCn series. From my superficial 
analysis of the commits that brought us to the current situation, the 
troublesome commit actually tried to patch on a true issue, namely that 
the user facing brightness data is not mapped symmetrically to the 
hardware data, but that the correct solution involves some more thorough 
rework of the brightness coordinate system. So there may well be some 
larger activity on it on upstream.
 >
 > Given all that I wonder if dropping that commit for now might be the
 > best move.

Personally, I think that dropping on the stable series would be 
beneficial, unless upstream can now offer a correct solution to pick. 
Behavior you get by dropping is not 100% ideal but certainly not as bad 
as what you get with the problematic commit.

Best,
Sergio
