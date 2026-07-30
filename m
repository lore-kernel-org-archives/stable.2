Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437E3449B26
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 19:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785438689; cv=none; b=oiF9DIW84a5YnQTSkYdmi8MNYBbYBj9zcMWJemz3gev9OKJ6rDhsrKJn8OrbDUGQqCYhw1TIR3nG8fTjCYDNSMK7/qX4Sn7X+kzfpqlm2hZfIFSmu0H96rXw4nEPJW24iMsPf+mfXXwbb6wVa7RvnUz7URW7Y52yXD+9kLRYxsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785438689; c=relaxed/simple;
	bh=cJ63BXZMNe1uR9WDgELx6Fj9oC9EAwfnNbOJJ077Vq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pb8BWCNRXSLO4teyOaXtObPKwEJAGu8zfurCYiAjxGl1WfQMZHYf7f27W44DAOda3Fd2l2eGxsNlZGyXxKmqwak59g+RrxpLHk+FTLYDQ9t9XCUIRqbqCdUGmDLZiCkhvi2XiLmGoOl4rYmgBskhpkncxW8i7+el+iObd2M1lAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=TXLjcIMX; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="TXLjcIMX"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7eb42a2f5feso113180a34.1
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 12:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1785438683; x=1786043483; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=50+BRi1M80OADWMBtwF8+tIWW7M6cT13tg7MUfRqqQQ=;
        b=TXLjcIMXo/Eh5AgN+poiFkHREYPmUBMuIhetTF1zjTzCUwPAY206t4/rH8HvKamkvO
         069oKewsEUvLsIXuIWawcDLeNHYC/OsrAiRe9D0g1N23UtWpr5jgDIspCHUL0wQBXOWa
         RgVA9BQPG6lJWb8ptaQF1/pRZGg2mvX3yrFr6ucRYfGOtTjSHXL2iasQIK+cajcySVMT
         hIt/x5DGZt5s5qMIWIyNSH5+v3vdTO4NaC7gySXCidI7HAEnq3AnK1lzFG+kNKdQ8Tmg
         rsv+4pPJ8p2aELeoRgV4XyZdTyOnXFnX2PdH/6dtQ+i4thd504aQse5J8Vn1HWw2WsUA
         nc6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785438683; x=1786043483;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=50+BRi1M80OADWMBtwF8+tIWW7M6cT13tg7MUfRqqQQ=;
        b=YhPeAU4r5JexUmzENxHl+IEEnkkh7oeiLmZHrlEgdfV3kbpPwV4zMxlt3P1N2BhRYI
         OSDouW/7BOa59uCsxtgFOCtuolc/H2nc+7ymzBMaRLW8mUqtQwtCMoLA0xG/Iau1JuTK
         9xIr+5IQdahstmeLoYKa0egKnp7eeeuCdxDJ0hIhP3QSUHS7715u+5szRZMA60VvS82N
         hUVBXpC8rkFn7752LPMTXkt4bbwNN0MUMXnFLKKqdJ9ZR/pyGJVGvm4rlVDijdlpZOvH
         OdPm/+iN8R2kZmaTDjUtRBCXr/nIyLmKwplZHQ+NofdBbJ0YN2mdtq/emi/lBgJBNCY7
         Gkfg==
X-Gm-Message-State: AOJu0YwJ4PJW2FZK43Uof5FAIXpWTW+nkLjHtFwxhLs/Iwrrk8UvsHxB
	d7O8LvOw6eiNHogvRW9H6MS1jaDotiOypRUEjJCCTg9+PYnOaJCsCc7y/dawe3aUbtY=
X-Gm-Gg: AR+sD12+RTi0630mBLoak4U4bqZR1Y9eI0Dttaju3KKWlH6i2yz7KUMQf38EtRlSRKn
	Ux7n4RIqhMGsGrFXrAOfQb+PAXHB8ThKA0TgdWhuwLFxcCWJQIwK2uxDWg+aQvHK5+OAqtKs4Ng
	PeS8b4r+WLvG2emZd4rBpze55hfIue64wsKXTWRkmqqx+zgwuRvu0lDf9MflCTHp7fULcn4KfQo
	DLTasgQTQynXDEH6GxJpMGJi+7Fx3VoPKGvOBxYX0+eSG7K7fmt8re6VrJ0o/U6AzuyF8YmUcoH
	plczGRFhFNNC9oSjCl9Iv15teADA18wcH4DIGGg8b1dVRqPdjtgVFXFSpDqTGoHXwODtsETMtbf
	6PzoECVK2Z99S/8z/mEA/WjE3TIvKE0Z30lLfoRQQaWxrkG18OKKiIC36LzkA8X44UlyTkV0Wdq
	WziKZ+WGlJMnzdUtdnFSG1u3xhXFZsSQu4ZYZWr7WXjRLAIiCLvaTjIdebqHB8Akh2j++0KRiEG
	0qVcExhA6PD9S/w6TYE8+gdKMVfOIIcEL3IWWqhOpD44rE=
X-Received: by 2002:a05:6830:488b:b0:7ec:553b:4964 with SMTP id 46e09a7af769-7f02c15619dmr3071607a34.24.1785438682818;
        Thu, 30 Jul 2026 12:11:22 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f00d595321sm5403413a34.6.2026.07.30.12.11.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 12:11:21 -0700 (PDT)
Message-ID: <be4367b4-5846-4595-99cd-204b8ad48293@kernel.dk>
Date: Thu, 30 Jul 2026 13:11:19 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] io_uring: preserve task restrictions across exec
To: =?UTF-8?B?7J206rec66+8?= <fyonglkm@gmail.com>, io-uring@vger.kernel.org
Cc: stable@vger.kernel.org
References: <CAPLyb-a7bWCq0GzyOcztLm3-7H0GOP64JynosfO9k+yHy7diPw@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAPLyb-a7bWCq0GzyOcztLm3-7H0GOP64JynosfO9k+yHy7diPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This patch is completely mangled, email too fwiw. Can you please send a
text/plain variant? Thanks!

-- 
Jens Axboe
