Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF303FF1B8
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 11:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781090156; cv=none; b=cXZH2aBwuzlLnPvYthFKwuF811bWSU3ZFms2bBUHmEsXB41G0tIqe7ckLmCbF603byG+qlhmvoBI6o7/HTj3duUBq9w6JDeCu4kRo2wVFix21b9dn5/lPW60w7wUMkbN4BDqgX6MFLmxLEasqFVhZMG9NiGdHBCK+9s9rPU3cj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781090156; c=relaxed/simple;
	bh=KWnTRg+mjczQPC1dW7dIXNyJPlDFUHTGB3Kh2mwFLDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i6kq4JIBkIVC1tLxDXmBzE2OyFAewNhXgdir4S8+pSuEKXJ1hTrsF6hb3o4kyQJNjgrad1IW15kUsSF43mGpgtTYXNAxoN9OHrjfe6LpuAKJV7Nggx6AOB1+vYpIhBW5zs70X8wVdyFVWhm0Xz2KSbyPICmfUBZZm3VY+KYj2rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eo9jjdpI; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eo9jjdpI"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2bf2e8ccca1so47403585ad.0
        for <stable@vger.kernel.org>; Wed, 10 Jun 2026 04:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781090149; x=1781694949; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KWnTRg+mjczQPC1dW7dIXNyJPlDFUHTGB3Kh2mwFLDE=;
        b=Eo9jjdpItbvADubbbLtK16NOdH25wRxW7bhQmfdAFY2BZdUElg3s2MFG+qDqmbOS9c
         BA7ZjYnpun7mC/yZV88tn9n5nNLoeEWWiEcmJVi8gWkqUkruJ9umatzowbcmzjmgXaP4
         LXotIqaOGiIDQMfbmAYD7RUPeBcW2v7BZczpN6EEHeazzs4EykRVz9AIgHPpHxJaj3gr
         QIZadKVzPLc5MijAiP+LOPdjSF88nurhl3Pcow5JEoiTNwIG8uCQ7StFGwi8tLo47jz8
         m1Z3dnbI1svYdeQYVwLUN0t6xl1KClXoMR98qSG7Pe/N0N15f5xWWIswtii5QT35Yb2P
         LwwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781090149; x=1781694949;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KWnTRg+mjczQPC1dW7dIXNyJPlDFUHTGB3Kh2mwFLDE=;
        b=f/uYRkuR+bLXqYUpA+E2fjNMOtt2v6NbK5VUEgwwomWefDutPnZM5/GWOdTCTljrQC
         GHpU3ZPPXBsy42TDIB5b/eppspTlaZqGGjsCbVYNxQPBdKueKCIOj9liYB5lb5SFCJC2
         M+br0LotsS6kiFmcwDKfY0+RAvIW7u+aAh6P7J6D9xQJuheTuvDKRogFSlpRwc2Sm503
         9KOpooS2a00qg+ITFA+kZQTHu/dvqVpGv6V1ehar4JhYlZk6BAtYuyBWMmpdXUY1q02Z
         sGAs0LFDKwEIhvbVe7yJUha9O4ly/v4z/oICFUf92jpYsGziJKJtIZ1g4CO7CFJf/JI5
         CXQg==
X-Forwarded-Encrypted: i=1; AFNElJ/sRB0GN8k+ooHaH/0LdrS6uHylHURke/GLyg6ROq/Y26falsR1HoDZ8DAhL1dygQ/3oP9Z0ms=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhMbNOvsA6rVsbIhD/4esIUR40QSopMVyAoisXkA565zmW+VZo
	37Zogv9ejjk0aX414nGj7862fSe4qxBBY/v7WJFS2U+ZAWAXT/Hvt6EJ
X-Gm-Gg: Acq92OE4Y+oEQrgvwYZU8hILSJv2jGcPQtOv0sRFqFwyQnVdTWv+yvX3uFtyl3aBm+G
	mTW00ZXzDaytSrvb8twMCPRFT4ePelslyf2sQHIiuJZk8o8CEUIkB9opBjmV00rBIuupj5YAJjC
	5PCNoSUAoQo6m1M1TMIcj0xWedWbi8P3wuaf7s4eM8NkWiNhpJNunwez6XT3xLsXc1WxIsE2mdF
	PdBFjC95/eJTcFOfbCHzvMx2cnwGGolNmyW7976uV+uB9IaPPVp1JhfmqsM4KLsPGYF6JJ7SG+X
	PKnHnq1f51qTT6WGpC7h0yFcyjFubhMPA1Rr69Gdpz12AvT0dTwYIbbYaRvJybGKFEMKL7xbIBw
	gq48L9cTZqXcf85pCpPqFJnTDJFo0MWX8IDaAyL5LEnmKG/HPclJdCMC/CPwtUn7CCkU2JBvSu5
	yTzt6dzuvB5ctUTUCX5ZHvK4D9Sb4HlV6WH040yklIlWPAYflToxsiD5wSx+eJlA==
X-Received: by 2002:a17:902:e848:b0:2c0:b6c7:2273 with SMTP id d9443c01a7336-2c1e79e29ebmr292674635ad.3.1781090149023;
        Wed, 10 Jun 2026 04:15:49 -0700 (PDT)
Received: from [192.168.1.116] ([223.122.38.120])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e234sm251459075ad.53.2026.06.10.04.15.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 04:15:48 -0700 (PDT)
Message-ID: <4bef16f2-ad9d-4417-ae12-484ffd7a87a9@gmail.com>
Date: Wed, 10 Jun 2026 19:15:45 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme-apple: Only limit admin queue tag space when
 with Linear SQ is present
To: Christoph Hellwig <hch@lst.de>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
 Neal Gompa <neal@gompa.dev>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260606-prevent-tag-collision-t8015-v1-0-93ccf4eca550@gmail.com>
 <20260606-prevent-tag-collision-t8015-v1-1-93ccf4eca550@gmail.com>
 <20260610051146.GA559@lst.de>
Content-Language: en-US
From: Nick Chan <towinchenmi@gmail.com>
In-Reply-To: <20260610051146.GA559@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


Christoph Hellwig 於 2026/6/10 下午1:11 寫道:
> On Sat, Jun 06, 2026 at 09:25:25PM +0800, Nick Chan wrote:
>> Apple NVMe controllers require tags of pending commands to not be shared
>> across admin and IO queues. However, on Apple A11 without linear SQ, it is
>> not possible for either queue to skip over some tags and must go from 0 to
>> the configured maximum before wrapping around.
>>
>> As a result, in order to prevent tag collision, dynamic tag reservation
>> while a command is in-flight becomes necessary. In this context, there is
>> no reason to limit the admin queue's tag space, as it is not helpful in
>> preventing tag collision.
> I'm not really into these Apple specific, but what does
> "dynamic tag reservation" mean here?

This version is based on an incorrect premise (v2 is correct and already applied)
so feel free to stop reading.

In this version, the incorrect premise is that it was not possible for either queue
to skip over tags and must go from 0 to the configured the maximum. 

Under this premise, the only way to prevent collision is to set a bitfield indicating
which tags are in use when submitting a command ("dynamic tag reservation").
If a tag is already found to be used when submitting a command, return
BLK_STS_RESOURCE so the caller retries later.

Best regards,
Nick Chan



>
