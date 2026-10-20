Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493835;
	b=4zU34Ib80ExvMMC7HDmjybK48ABDouAViTTDO6tzzm5cNx9KYgvoPJp5ypSIlumdKSQq
	 q4NMmR8nqdoj8fc2T66sci7tf0xLkOo8uK3IWZLblH+tn05sk6a6YoMGSqDc9njAg6eJI
	 bZ6W9B1/gUhhb7OumNPqkNZJjFG/4/6sOOY8/OttS9yG1BJ+mQclhPSeTSUJr8t+eQMdI
	 fXybYCOb2nEueV7/yIXV+YNmJIWjYeqzY4eQ2AqtEStrx5CGRJXBKg8S9JT1RhBN1UfoR
	 LGyLBsacQlTmx0Jd2SO0CXHb5In2taS+cGZQ4BLuLF3ChSmlun5Y4Cwt/Qe1nQ4/oAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493835;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Xmo5pGCKClMTznAgnt3P15PbfjUdQDHaOBja2Zq9dD8=;
	b=jc3dJM94yD80em0gedlujItaIr79KJIpTUfewQf6K3rH1SP0zGZwQ2oHA4NYECvDvdpq
	 l56195037xpJCgAPF/6xM7YlIFYFteOi3RgIR3qqSFeSjaONSw5DOIyhzKZshCbJ5fYRZ
	 ycskb6sM22RVxWFkvxw1ShcxfiPeKdsXkJGQfv6glXqkC8olPcQQUY9WGUkumwJqSyHtD
	 UfQY1/JJ9yNLXiQdlRNr4Vu0qmlSgyJ/bXdeVoiSFj6JgW9waQREc7ohLEv+cBr9LMP0D
	 t8XQfUK+CjIKmmsSvIyrrQx9cnLwym7Dwmi0lS43DLIAJ+rUC2a7qHmHZT82yDpByew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IG8CNnwU;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C567606A31C
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 10:57:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C567606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IG8CNnwU
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a1f403aca0so4889905e9.3
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 03:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792493833; x=1793098633; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xmo5pGCKClMTznAgnt3P15PbfjUdQDHaOBja2Zq9dD8=;
        b=IG8CNnwU3Yrj9dJ8HGq+mCXNLvDjQMFVKXd9PsRwu4nWGz2dDCgtbz/8x0FT463ahU
         uL12vHG8JwsMp6f2N5DElvkEFuZjOIoxpjr2CTgly2P1KGn4wNbR4YrxWNh3zUZ+deuq
         JLF2B0G339BdzTy9BSEtsuL4tAuyPRbCTeOhkafSrK9LYj8oBzky8Jja75yXmF8SDRqw
         bOydB5/9MlSxpEPaCoNJFF+zrYyTQXJu2xhjY/1Ohm5W04Xn39Abwj/Q+xQ4ZuckKuJ2
         Ps7ImPM35FH3Y7idboydTb9Fwa5MqaFu2iqTlbtXbvDXsVveqhPuaedBrNXLhWwP7eqW
         p9UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792493833; x=1793098633;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xmo5pGCKClMTznAgnt3P15PbfjUdQDHaOBja2Zq9dD8=;
        b=y7a/fOkpRiPy3UxdXByGhbLoARInVvk5wUCRAzAXQ3rsEX9/h65IMHFWTK/3Qy9tSF
         kfCHWdm93l4fScCIEGiRQK+LhzGGHUWIRNA99K6N25VAx9VO0i7rTOaqTgjx2xRWTqen
         Cs9LyBtln+mowxifvN95RNZfzzBcN3s9CB/YszVL+kzE25Y6EagDbh47I/QzxaVczTq8
         fhMN27FtkIZ2ybHNwkPnQ6k6drzZOA8GfzuDixCZG/PBaI5P/o24bC6F0/iG1oefOOqt
         TsZ7T6CfdblAIm8edeEKFKKPnaPsdUcjeUDSuWtrreVHRTkR832BBuU4Tew6eulS6Yqb
         Jh6w==
X-Forwarded-Encrypted: i=1; AKwUvBxrPSqeIcVnvw4+lIe69GwuEvIdICVKMxjC9Fd8QLQyO6qvLW/ZD6a+/qdkOANFEN7vYdAa8dQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJA4QPjMnI9aZRa2wjUAv22rNM7Fvs/1wYQ/li+ZgVCv8zDFCxB
	ONRumrviaae1gyE8BIp7iwzariIHx0Rb9rDj+DV898u0TxBZliWx4Kmg
X-Gm-Gg: AYBFou0j32kqhHWzGvlS+KE3UsuK80kAvvC7RMGjj4d8GB7/gM+aNreNr7ix103rA94
	4GgT6+tSoI2t0RL17IRwgGjUZELP5W7UQnREeEdOQWXa0x5jdt7tfZSr5vBXfdTNWoSKMUOcw0F
	qeXYLTim7cfGM/9yFprf51vIADLE7EJHvbwg0Vt0j8tlqAwH+CpGqR4D00rNElEW414u3MhrWni
	YfdNu+Xo1a/m2rB3tTAB0fBsPdWZoUqsNQU+3r3r4H8XKVq9AjYIXJK4m0s+XaeHltKQVVz2KZ6
	bc18mcyK70nA5pWcoyzKj/7fMIQsTcaZ74tHru/q+vt/s6/VFaISL98sb+635WtmJOT7SPf7o9E
	kym4wPlGwSr5lsS4vGrUZwU3z05Z+qY0SbVNml2iT5hYv76BsP6+5wMUDMnSlBe+tiHc96GVqjw
	FgDb1bHCEENrHjG3fVN2wvPGN7Al8gzLciZdnKBUkKEUUXup3iay3PyOnpoP6Ygr1nZzeBNOgT2
	raTBnAQQwR3r7Qz+/wzkYDmNLuKDc+fwISdO45nlMqieXPs9BTjoXGFDHc8
X-Received: by 2002:a05:600c:3556:b0:4a0:25c:8af2 with SMTP id 5b1f17b1804b1-4a1d76051b8mr237749825e9.17.1792493833438;
        Tue, 20 Oct 2026 03:57:13 -0700 (PDT)
Received: from [192.168.1.105] (92-184-144-135.mobile.fr.orangecustomers.net. [92.184.144.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1ce3302b5sm231782675e9.4.2026.10.20.03.57.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 03:57:12 -0700 (PDT)
Message-ID: <87d73b29-945b-476b-ba02-71a5bad4b4bb@gmail.com>
Date: Tue, 20 Oct 2026 12:57:04 +0200
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
Subject: Re: [PATCH net] net: jme: keep RX MAC clock enabled for WoL
To: Jakub Kicinski <kuba@kernel.org>, netdev-bot+sashiko@kernel.org
Cc: cooldavid@cooldavid.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261011-jme-wol-submit-v1-1-9cc033e259e4@gmail.com>
 <179181078924.434549.16666867636447785126@kernel.org>
 <20261019182217.18e26e57@kernel.org>
Content-Language: en-US
From: Franck Baur <franck.baur.67@gmail.com>
In-Reply-To: <20261019182217.18e26e57@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Agreed, thanks for the review.

The RX MAC clock should be gated again after WoL is disabled on resume. 
I have added a call to jme_mac_rxclk_off() in jme_resume() to restore 
the expected clock state.

I have also addressed Sashiko's second concern regarding concurrent 
link-change work. The revised code prevents new link-change work from 
being scheduled and drains pending work before arming WoL during suspend 
and shutdown.

The revised driver object builds successfully with W=1. Runtime 
validation on the JMC250 rev 03 hardware is still pending.

I will complete the remaining tests before submitting v2 as a separate 
patch thread.

Thanks,
Franck

pw-bot: changes-requested


On 10/20/26 03:22, Jakub Kicinski wrote:
> On Mon, 12 Oct 2026 13:13:09 +0000 netdev-bot+sashiko@kernel.org wrote:
>> - [Medium] The patch turns the RX MAC clock on before arming WoL, but
>>    resume never turns it back off.
> sounds legit
