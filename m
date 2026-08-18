Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC1537C931
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 06:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787036360; cv=none; b=Bm1p/QPQA33xieKJ8KNkz6I9tjtEZbOHq2JN1vR3Oxc5EZSBj8ZGkYbp4WTFJrdfynxgtCiGzkVr26S9eWFL3aCHVC1mkceDDyjgC/t1ifFoffjNbCHkDXpfffyeMwmrjFQ86tyGVOn9lQJd9a+L2Gai7p7gx+9rnkVWFvTLTGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787036360; c=relaxed/simple;
	bh=Lo9Dnt2y/TMGSSskmCCw/E68ISLvoXSSWMqfmsWr4W4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uUKBQdSrp8mLF2c/gj/NGq9VStgSyfqbrz0DWH5REX4ZE1XMInO4z87PedccUJIkApEyUly+9rctNrSNHl2VKCZJ+lLzKw2Dku1d7xf9bI5evwmmMZVuSemvTzgJmYe8Mo/n1Jqnuatz4bEqozwIW6RZKe1BWTUQPS1ai3NkNk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/qJj9Tb; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/qJj9Tb"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cab973140bso65009125ad.3
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 23:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787036357; x=1787641157; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EsgqEQAUqrVWXU1GldXAhQw/hCdlChW/NiKf+A/QTHM=;
        b=K/qJj9TbqgJIQQyPUVfyJ91r2dc4GyrA13mhJYIyUJApa1JmjYsdYrZa5pKOHJmFl8
         rXF7ub+jJVk8iCi6ZYonZZwPJKLffwSWwLXr3l2BC+QmKvUTFisz4BVFjHTO2qmxrASD
         folm+hRObzREp7uz5hE1rdjvKA50Lyl+0Mq/O9UCUOd9Xa7/ZDv5iejp/Ibh0M4UPmDR
         LhETIae7nLCGdivTyRT3A91lnA3dlHGbI1w2dBh+dgGzK3EajU8m6f7qnxIt7RzLGfVg
         9xBpxaWI8K47ntdL3pzJnggjPNU7HDAKodWt4vZwjqvee1DMFdOtL94q8C5efFL8rTQX
         ziLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787036357; x=1787641157;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EsgqEQAUqrVWXU1GldXAhQw/hCdlChW/NiKf+A/QTHM=;
        b=qmxwrOKYcRimzK+074KfEn5XZdzJ2RB2IAdI0ud/Q+Ivo1l6azGNqq7gzMPTYW2vCH
         7zHaig1ALqtWmvdcIbm5lfz6Huoc3HRl/HzC9uy9o2iEViHiDGZb2mAL7ukmXBCCv+GL
         w72qijCzLb17/fbJnTIp+RmHYGDE+jCoqfZ5a6cVjTZI4lvUctCtxHKGKFTeIzUa/wsK
         /zrpqENq2zgxeGcdZ3F2habma3KprT5yTg3JJGVZUYAoaXHUj3ymAc5XcD02tyaOt0In
         L8EfE18q8q7oue6XCWgwQqQmsJAqajHUj37MoRkvYck0xq85O2n5V3OOOyys8loUvmTH
         l9MA==
X-Forwarded-Encrypted: i=1; AHgh+RopmTkG0QXZAGf+uO6uAo1NMCgW7JojGCv/gKDsYpmsLxW0dRQwnyymwxOnE65Ou0ClOoGbztQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzbbkpGizPNsSaWm8qH6a8xorbyQ7HL5ev4toOVe8bBx9S/plT
	+Vf5O77LN51Q1wsB9VdjWXmUNKz9qxfptHwbFFqOLgb8XauwIM6t5EGx
X-Gm-Gg: AR+sD10/huabR9SornbUTAASIKMb1sxDR5JUL+hbZt2Kokc9ILuTrEeDGIc9eVa9QTi
	4KPyJGAnFmgblKnEUMT4nv9/mN9PUrjzJ66nA+z1D8mAmVHW5ERkS7R0soIrVB7iUJ5B90zTwaG
	YjONrTxaaFDuyq8I+BNAxhIXbdmKv8o1XBwxRiyuu4CbFcsy5IJqbyLh3nw7cFy2xyS53uPMHCo
	/On5bkkwdca7uyh56ZonzawqfId9kJwvt3/5OwyRqXGxiWm4zAvZd3PmVjkEFTrG0pLhKTlsXOO
	dN3bkNRnU7zWtAMcmZGWZm8/Ajrda1IOk0JW1fqoIs83nsttlaz723BL6PXZNRFI6qLRqyTKC6V
	WxooNOwvk4ez8gH1Fqs7hcdunTA+WRoZt9Ata7vudXG7iHMmnU0ftAGlHfSVcyL4lHhwIvLSYVS
	zHkX4fNuakXuEZAoD9vjgn7SIYnL0ZiG7Cmbqk2r9b7ZvGaz7HYW+3UWPT768cD0BmGBzNB0D6I
	vYi6GhwHHdK76w=
X-Received: by 2002:a17:902:f548:b0:2ca:e565:7b15 with SMTP id d9443c01a7336-2d3b0874ce2mr279530695ad.10.1787036356990;
        Mon, 17 Aug 2026 23:59:16 -0700 (PDT)
Received: from [100.82.107.240] ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d5c1e528b3sm10780415ad.46.2026.08.17.23.59.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 23:59:16 -0700 (PDT)
Message-ID: <badd3ede-02ca-4fa8-9a51-a2f973dd97a3@gmail.com>
Date: Tue, 18 Aug 2026 14:59:09 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: reject delalloc to nodelalloc before applying
 remount options
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, tytso@mit.edu,
 adilger.kernel@dilger.ca, libaokun@linux.alibaba.com, jack@suse.cz,
 ritesh.list@gmail.com, yi.zhang@huawei.com, bretznic@gmail.com,
 stable@vger.kernel.org
References: <20260814034855.1573759-1-guzebing1612@gmail.com>
 <an7Gj2vWVpbP584g@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
From: guzebing <guzebing1612@gmail.com>
In-Reply-To: <an7Gj2vWVpbP584g@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/14/26 3:41 PM, Ojaswin Mujoo wrote:
> Can you please add an xfstests for this. The test can stress this path and
> then use the _check_dmesg_for helper to detect if there were any
> i_reserved_data_blocks related warnings.
> 
> Regards,
> ojaswin

Hi Ojaswin,

Thanks for the review.

I have posted the corresponding fstests regression test here:

https://lore.kernel.org/linux-ext4/20260818064023.2309786-1-guzebing1612@gmail.com/

The test stresses buffered write/truncate operations in parallel with
the expected-failing remount,nodelalloc operation, and checks dmesg for
leaked delayed allocation reservations during unmount.

Locally, the test fails on an affected kernel with
i_reserved_data_blocks not cleared warnings, and passes with this patch
applied.

Thanks,
Guzebing
