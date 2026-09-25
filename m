Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871E948423C
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 09:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790329979; cv=none; b=mY8ujPJBMMbHsr7HL6wf/tWGMnAPgfIW2S+lYvpormRPXg1/V6bcEAZJxYo/hRSNtrJsbgO2hePgpvtGW5EqsKjq8KgxvZJ+HeYMf0ioHCFaxOpuwDmu8Or7cLqRUAWoWqvuDJfW6jCiIvZHWpkqeYbE6r4mzqCgYCQ+Bt6OqRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790329979; c=relaxed/simple;
	bh=nvyA3TDTbhtrxdFzEjqfVphfihD1nWdpT6xp1d3CrP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sg83z1n4y228jtQXPM03oOdNRsplNo2xqLC1SHG2Z1JbnGsu482Rt1lWgWjUk7BqKS2bUEaEtv+oykbcRVrz8aElNeiKIl/dqehMI7cFBiCCh30VwkKwE/YDJ1WmdGusnWWxcDaaJcLUcGSIX9Ed71qUlq+qIOG+uH0T+qw2FbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fvSr9cB3; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvSr9cB3"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-4887ebc85eeso34767f8f.2
        for <stable@vger.kernel.org>; Fri, 25 Sep 2026 02:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790329974; x=1790934774; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wnKtVfuA6DDtxDljFMt/DQAZ8I6CllqSJuo16Cr5Xvo=;
        b=fvSr9cB36vtc62nWqPWi5GwtqeyaqXo5+12p1oMlSp6oVN8Ha1/2Dkq+hhSD6Zq63w
         t7JB64usB4P6BEoQF7mehPiqyGz6ePx/WO7tm6jIrxvL3R8dgCfHaI9a8Mpfxa6AK8Qq
         kTMpNS94C6UtgbxQAjpOuhKcYQ2PS4PcG3jVJj1VD6WerbO+uVlnxvDFjUrm7Pi95nHv
         tdC6wb4QkuH+Uk7yruyYfD8voNJKk0YMPECNMBpTc1fAcdi2iIwK7V3+L9VPIB2IzaUW
         +7VQ02CjQaTZ/f2hwsKvE7HOgAm7KuoqX8ORqstjxnFrcfJ64vkrEc86tvdfMEUd4GZk
         9lsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790329974; x=1790934774;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wnKtVfuA6DDtxDljFMt/DQAZ8I6CllqSJuo16Cr5Xvo=;
        b=iHIZVS4P1e2vDmMW/JUNN+Xy/iJ8IF5xZyjdwrsjvm/BmLexAEH9wqe/sDMoCV9Z3t
         DeCqYg1+hzGJ5C36KpaKf3i+rh38h2AjeuNQJHI/pbn7rO9DI8mKT/IYCdER0mjbAjt2
         WvJUS/6xw7I8j+QcecgSqEa3BJ1dtOhPxTTcW2aI9xhqXAnEsP4QmhscB3sLiHWi76vA
         3gZa+kng5To+CzGwQt4d8Gc2omw2+bAdB+6GZcrnVsfQvoaK2GLnXsVCh3wOTubFbINd
         jq/iQukQbmR9sjusjMAn1+A90yCWyNgI0ErNiTLflL+IxylK+f9v4GpZEeihzBXJ7fbo
         llvw==
X-Forwarded-Encrypted: i=1; AKwUvBxCb5lTkn1arF8UqeA4KhiwT/9z+tstFolO0/SJirhQt/z2s+kUjiWYcHR9hp4L9DwSmYPfdYY=@vger.kernel.org
X-Gm-Message-State: AFuF++n3jSKWFOYz82sJJSMAz7gzB+UkjEuxvYBd7GCr38x8V3ABEpGB
	xlFNayiQdS2L+/MXtSL1zo3UnrQhRSq6Ih6oNesLnoF1+remF5VixMA8IaFohcRVPCQ=
X-Gm-Gg: AYBFou0Sr4XbPupf1a089CyGs5Isu7Oa6CsTuIkXOw6ot/PO+euumD597MgfdNYw9A7
	eQKnObZqcw/VXLSXXCoTll3MmjmAAigps/P1SUCbCiZuyyIKk77W+FyXWJrxnow7ryNXrtfEEPU
	i6OmQO7tz9yk57sTEnBhC85NA3eSpBCnKfHhlmYbdcMv3rjIssMJsvDJMRXgpDqt57vWaWX7wvj
	hocaGMBIPlyjt2kfLih2Gyp4NDaU1VaMclpTcdWWNm2Xpx5CCedKSiS1Enn/DOGedwsPJnvkw7e
	FJmEf4WWrFiuNOg6G9QzyQlABl6lbIvW3+vHl57+mEdzDk30ydagcTNUdbexJzo73AJpdlw42a4
	gjf6INacfJ+7sEzaXtMaaxN7lbsc5NkXCgeRir8nXk47VEgxhiT5VkUeYwu2Z82jJmMANoY/bxg
	ayxxP2fXbs8cZP+wAcjPgH6nCzsZTcAFFuQsx8ArSeaPDk/ts7EgTrFXmeE8zBe2ucXtCSgFo1p
	M+ISY+40hgxwcZs/GWJjrSjLuF1g0JIAyOvC8j3bxlv8Yvy1U/31es6v+jOQ0Rl2egsd+18pEdq
	WdJtOBgLl/wuTwSTK5p3N+BKeAbJbN4Xb/wrtPwlxvMOMZSo396/hRWE5vLe9WaN1HU77j7sJHr
	ye6WszYoyd6jG/B7FqN0=
X-Received: by 2002:a5d:5d0d:0:b0:488:79d9:ef3a with SMTP id ffacd0b85a97d-4887a89f181mr3916537f8f.2.1790329974230;
        Fri, 25 Sep 2026 02:52:54 -0700 (PDT)
Received: from ?IPV6:2a02:3100:5dd2:bcfc:4dfb:2ac9:70ba:48bd? (dynamic-2a02-3100-5dd2-bcfc-4dfb-2ac9-70ba-48bd.310.pool.telefonica.de. [2a02:3100:5dd2:bcfc:4dfb:2ac9:70ba:48bd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a355c65sm5863049f8f.19.2026.09.25.02.52.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2026 02:52:53 -0700 (PDT)
Message-ID: <21bfa8a9-c488-49aa-b2a1-4d282fd51c42@gmail.com>
Date: Fri, 25 Sep 2026 11:52:52 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] net: hsr: unfold GSO super-packets at the forward
 entry
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch,
 shuah@kernel.org, kees@kernel.org, petr.wozniak@gmail.com,
 qingfang.deng@linux.dev, fmaurer@redhat.com, luka.gejak@linux.dev,
 xiaoliang.yang_1@nxp.com, skhawaja@google.com, liuhangbin@gmail.com,
 stable@vger.kernel.org, sdf.kernel@gmail.com
References: <20260809121455.1745-1-xiexinet@gmail.com>
 <20260809121455.1745-4-xiexinet@gmail.com>
 <20260923104346.ur63K3h2@linutronix.de>
 <2cf54664-c07d-471f-af6d-4b70e09626b4@gmail.com>
 <20260925082954.MYDugnDU@linutronix.de>
Content-Language: en-GB
From: Xin Xie <xiexinet@gmail.com>
Autocrypt: addr=xiexinet@gmail.com; keydata=
 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
 sNySbH3veZ/55EtlXA==
In-Reply-To: <20260925082954.MYDugnDU@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/09/2026 10:29, Sebastian Andrzej Siewior wrote:
> So you disable GRO on the interlink port and still receive GRO packets?
> Or is this performance related where you want to keep GRO enabled on the
> interlink port?
I am not trying to keep GRO enabled for performance. The difference
is between a physical interlink and a veth interlink.

With a physical interlink, TCP data is split into packets before it
goes onto the wire via TSO/GSO. If GRO is off at the receiver, this
interlink RX path needs no extra segmentation. Patch 3 is indeed
unnecessary in this case.

With a veth interlink, there is no physical wire:
TCP -> prp0-peer -> prp0-int (interlink) -> PRP

A veth pair is simply an in-kernel memory pipe. When a large TCP skb 
arrives at prp0-peer, veth does not trigger TSO or software segmentation,
it simply hands over the intact skb pointer directly to prp0-int.

Turning GRO off on prp0-int does not force prp0-peer to split it. I 
confirmed this with ordinary TCP traffic in a VM, with GRO off on both 
veth ends.

Patch 3 splits that skb before PRP assigns sequence numbers and adds
RCTs. Each resulting frame needs its own sequence number and RCT.
Ordinary non-GSO skbs skip the segmentation path.

In addition, if GRO disablement fails (e.g., buggy drivers or
hardware-fixed GRO_HW that cannot be turned off via ethtool), Patch 3
also acts as a fallback defense for these edge cases.

--
Xin
