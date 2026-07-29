Received: from mail-oi2-f1.google.com (mail-oi2-f1.google.com [74.125.231.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAA645517C
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 15:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785339583; cv=none; b=IP9pmpe4b0yOn4qa6WXmP3KX33YmvGJgdmMYsxtQaV7FqIGti7zvguV9+P9zKfJ3g8ZY0gt5xwkbRx28yTyhVMyW2pbmsaWEeOMeoPZZeZ6vq5lC0NeIxEKdEXdt/C/xs1facoNsQDHh9hYqr0IaTA+q70XyW4WNczZAzgzp5qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785339583; c=relaxed/simple;
	bh=Buvb78MLeilA7v8GfjII4orSEtPBuLR9Q+/HBBsh6Zo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=spz8w985pgJy/Ok/KjROnPFWAAoj/hfLekyPfWpe07yDGgxobg914mDS752Yf/7Mk9uva2HmhrXiNOuRRLhP9xkxNYJipljqExp5VHGVc+xyXjJagKyoL9VgifDKUVcEYm3z8LbwLVA2TCQUQDs1Bh8j6cCaJ8cfXzA2CL99SPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=0TOScDI9; arc=none smtp.client-ip=74.125.231.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="0TOScDI9"
Received: by mail-oi2-f1.google.com with SMTP id 5614622812f47-4960cd51443so95058b6e.1
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 08:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1785339580; x=1785944380; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GS17j0/tL0T7r5MZuQYpNYrMe7AhNMQwhW9AnPMzvM0=;
        b=0TOScDI9n3sxwahHdXx+iZV9K9K3yQ/ChB1aJfQ6S7h7NMEqANwnK0ajVHbyZCd0kB
         clTWxdAC0ISf65oDEtQEizwLVvqq/pLXGNUxriIgO0vkUGRwAJNv2B3156KUb1BizFhN
         xe6BLuyoi4ovMCu9VJCgtmaPxzo0/T+Lq78XWyGzX0tWloDA6tMLUkVmf1bGmmm/Vjen
         qmiDITe91ce3jhG+LIXa6EWmuN1ol9/aRalBcZMLms+SxaWdl+jFV6msSZiPzNnXZOcE
         eHjfpig6agGA8hjz1sMKuuEPqzYcRI7TY7cS0sFWNOoTuebyAMViTZ1tT4+JyCFiiDfN
         oy9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785339580; x=1785944380;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GS17j0/tL0T7r5MZuQYpNYrMe7AhNMQwhW9AnPMzvM0=;
        b=gNqrA86THIWHaR42O0w0F1YGittYx0u8iVyTSkCye7M/uJHbD2Lf7Fine26LgOkksM
         MMNebc3FXU/GFCwiXZmtRiKBRI/Cmj9rOQg8D4O7v7tM/jIwnMR/xAzf8vA52GzmSP7u
         FBqm1C3QCu6RWKvF/StKlMVKIfry27aULZmtL7C2UEepeLhDmU1P/X1IMJcIH6d4rtlk
         aVo3OSHa/XMw61vefyD9ZlueBOLJQCjTR2MTUgxyUHLpjQsnmRExX7iuvWgo0iYJEJvv
         eYWghYk+WNj0cVLT/AefXskHVKdF40VyDOIw+mbejHpH1sNAxLIDuHw9XsQ51Z4vLGoj
         OkNw==
X-Gm-Message-State: AOJu0YwsEQYZRzsOSNFZB9QMoRZfRjQg9JM4uijQw67+9EOSQs6dbyif
	QNzNcLPKgd9KY3WENTOSNsIzpR8YfbcpKZUeabTy1pBnBJnjdI+8uNBsAfE9Fx34n+gPdkzcKYH
	lZB/91EEhqmLN
X-Gm-Gg: AR+sD10RbTdQRBuCFPMs9x+aW/Zfxy4GfhGDGqE4VIqemr+GmHSDjy+hkLlJkQrZ3M1
	RC7A4X3JTn0AV6dNJ10ktHbdfmg6olk3ZwFxoyzyJJGvlahTNLrQIQbpKQH2NUX22654GYsDoHo
	KYO1Cze89J2MeaUNEYfwfcacIfHz7roEhWqQFFOCKHztUcrkqMAW7nujHZ9WZEdRdKNjpq525dn
	Ccat5K6BRbm2YPW7PEi5HeohuSJ7gHSY9BkPTExHcuEACrUb0va2mFCj0wavQANZ5QkvaFDjxFQ
	bvH/LDDOsCXZL9Fk4bPBVdNtH7Orov/XEcixcz1xCLLVkMj/NpTeV7LrTgKeSXJISlf01tIH40Q
	pR/4ZoRlP+RctSydfzSZqRTdgSvc2q7Weec5OlJJt/whfG3yEerGQOJ3VBT1gkL2ev80Js3jiUC
	jF21fpl6Qnt9Aez3WFkv2pLfQpjQkg68pNHjppQLFNv9zDFeBBCD5CL1SBLKNezArOli4XSrVuy
	7lISwTynxK1uaCMjWB3se2CHA==
X-Received: by 2002:a05:6808:e89:b0:495:4a22:f29e with SMTP id 5614622812f47-4ad5bb1c0b2mr4036097b6e.25.1785339579691;
        Wed, 29 Jul 2026 08:39:39 -0700 (PDT)
Received: from [172.19.0.220] ([99.196.129.79])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4ad6ed2caa7sm2046581b6e.6.2026.07.29.08.39.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 08:39:37 -0700 (PDT)
Message-ID: <e82bbbe3-a1b1-45bc-b865-e3ff6ac95015@kernel.dk>
Date: Wed, 29 Jul 2026 09:39:25 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] io_uring/net: don't truncate the bundle segment length to
 int
To: Baul Lee <baul.lee@xbow.com>, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20260729151504.47280-1-baul.lee@xbow.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260729151504.47280-1-baul.lee@xbow.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/29/26 9:15 AM, Baul Lee wrote:
> io_bundle_nbufs() works out how many buffers a short bundle transfer
> consumed by walking the mapped iovec and subtracting each segment from the
> transferred length:

Should already be fixed by:

https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git/commit/?h=io_uring-7.2&id=bc6d516abfe7085bf706aff22127859f06174f75

-- 
Jens Axboe
