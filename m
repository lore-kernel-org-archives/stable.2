Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B337636B914
	for <stable@vger.kernel.org>; Sun, 11 Oct 2026 19:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791746930; cv=none; b=sPqvSWPvvKLr71clmMHRqLxt7zJ7ibo4fmx/fGqrMeAWyYAZAh+SRRxN7K/1EA813P2pXiWb+fR2igMVNFtyiQMhMXt/9ENaImV8YXOrEzl+GcR4H9PK8e+Ygkm+pPSbsc3gdhmKHI6+IhAOr1xyjW9q54MZzIPsU06gHOkakgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791746930; c=relaxed/simple;
	bh=QSznnEnpdQVi9WdrWsn++f0OiYNOnZ2QGWOMD1egIC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dRPk2IpbUiIJrU7ALkKHrvjBjCOzXUSFSIDWaOGGbTNzGfIb4vp8kfB/KhuUdThxycM5e/3ft461zcSoRFet7+d2dZcpCwOmzrj0qDKqk+sOzLaFlg4llx4oArVTt4SGKV8JrUntliUjNlqz/csxua89xXkTNKHEAnAZG/Lw3TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KOCt16J9; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOCt16J9"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c31a34de844so187550866b.3
        for <stable@vger.kernel.org>; Sun, 11 Oct 2026 12:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791746927; x=1792351727; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=suZZR6RHE7rP748UZ3zwlAVii9ohslanZfx2IvpYQCU=;
        b=KOCt16J9n1epj/mW71+bxjcuvn7M0Bgip5Dye622mUZhwURjNWBte2A1+6yP7OTdWF
         +M9ytITOvBMLKn/s1StgUNS2UMLFxGHBilwHwNipP/JjOyd+f23Cg2tOysZl7ivXO9Tc
         74x1zRLd4Bqev/kFTL6poOdqSHDkAiACMfyS9GM4KpdaS7PoC2AvOmGwt4cxRQWeR+qc
         mwUXWwB7V5uWnMm1kNA1TL2uEIyghAnyS3fGE6SmxxgQSsZe6i52No4U/dD7ovzaW28u
         7dPRAvZs21FpM/YsvSrS0UVRa8+LGNfyj0Q/91QJNGYU99RaMmaKKR6zGGQU52J/r5Sc
         Z2Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791746927; x=1792351727;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=suZZR6RHE7rP748UZ3zwlAVii9ohslanZfx2IvpYQCU=;
        b=SnhavUkzMMn442eYp1aKDrrgKcCLoKICvW8WbXL7cczuaYSsfkGOe01ngntCNziecD
         9Bg9tTC9qs5Njcal2cI7MTX0ooGDvf0vL+dy4r7BqGn+0eAgnsiwMLJvCx8xv6iQ9OtS
         75sevL1/6rwHaa5mkbbrLfK3mJMd6h2RX0mRlDXPt7oh7Y/O7d0O8r2/G0uEUQ9lYWHO
         WupiYbpxtAn3ySW32Un8qqGOal/QhIqdwr8fnNjAaJTebRwwDzYhYq+ZcQcQ4F3oM7+F
         KmuIkrMyfX2dzctz7E8+9gh/EAL80AuPEDYAD/hGmuFVtUkb0ZOoEVt98D4HX7Jz21l+
         C5FA==
X-Forwarded-Encrypted: i=1; AKwUvByKSBbr8b3VCWkXcvHqy8zhDFCoakuXi74lNuoTWNV7CzII69GG8TIKCfSMgXkoLfmbNlBHBwc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKXigWMLJMH25GnVEhcPewMkAUPEaBTCQvxR9KEW7HNMPlVRr00
	4ZDqldp+NEQAmxic3orv2ha1EonUgpK8VJ6yTxewLfws+vzUwjSQ7U5F
X-Gm-Gg: AYBFou1BMbtjHgerSi0wq8q97oimUIRbMk8zwQJdiQflHX2Q4lUfe2vPFKt/v5JhfEr
	sUyilVUloRwN2X/UDvrPRyCM8zQ/LedarpIUKPBc2rxjJtGe68oVlb+NvLUk93lgd3VmxO870QD
	jXFSLDUemON2HektYU5MGuYQqncspuAYFCw+N8YfLptB5jUFXmgx7ZN2yucM5vf8FaC3h0F2n3p
	/81q297/a9/2M01ERPJFSqzMAVZ4XcqvV+++PQermyJ/GvxECC0U6CF4r92L/dZIlE/2PVlbKtS
	Bv/xacSGrVyEhpYM+wLl2nAwpBrx5VGrHdNDX2f8HlcenRtZ0rilJs5cdjZPhDR12l0bnFoAPn6
	8D6QYPeec9cnL+qvKiFiF0BjFI6z9ym1FjxYqK1aEY5vMF6M7bBsRde637dAySTJXDDbroKG7Ob
	iRn82TRg66gCEsyiIglU5ityrK+kdqLgiSXbnqackAmKf22xfnEpbjXNbyEJnpQaa32mLlgmaQy
	BD1kgVfvMlK0x/5H7ZOdzObM8XW/hvfFbcSsq0qMa7iRv//n6REopJcqzjBggL2qpOtxrFY/5r7
	WJlSh51sMOe8nLa96jWIGg==
X-Received: by 2002:a17:906:f592:b0:c26:19de:912c with SMTP id a640c23a62f3a-c31aa07ba07mr845018766b.31.1791746926798;
        Sun, 11 Oct 2026 12:28:46 -0700 (PDT)
Received: from ?IPV6:2a02:a466:68ed:1:6152:f99d:3762:f020? (2a02-a466-68ed-1-6152-f99d-3762-f020.fixed6.kpn.net. [2a02:a466:68ed:1:6152:f99d:3762:f020])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9ac9ecfsm399541866b.74.2026.10.11.12.28.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Oct 2026 12:28:46 -0700 (PDT)
Message-ID: <2fe443ce-2d3e-4a1d-aaf0-0aef68da4cf0@gmail.com>
Date: Sun, 11 Oct 2026 21:28:41 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] Revert "serial: 8250_port: Drop duplicate NULL
 check"
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 John Ogness <john.ogness@linutronix.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Crescent Hsieh <crescentcy.hsieh@moxa.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
 stable@vger.kernel.org
References: <20261010193755.187706-2-ftoth@exalondelft.nl>
 <2026101151-regroup-caterer-b92d@gregkh>
Content-Language: en-US
From: Ferry Toth <fntoth@gmail.com>
In-Reply-To: <2026101151-regroup-caterer-b92d@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi

Op 11-10-2026 om 07:35 schreef Greg Kroah-Hartman:
> On Sat, Oct 10, 2026 at 09:37:56PM +0200, Ferry Toth wrote:
>> This reverts commit 7885af04df6e4efd72910200c1bfc079d61202e4.
>>
>> Commit 7885af04df6e ("serial: 8250_port: Drop duplicate NULL check")
>> added `up->dma = NULL;` to serial8250_release_dma(), with the stated
>> intent of making sure DMA would not be used again after release.
>>
>> However, up->dma is assigned once at probe time.  serial8250_do_startup()
>> only calls serial8250_request_dma() when up->dma is non-NULL, so after
>> the first close the pointer stays NULL and DMA is never re-acquired.
>>
>> On Intel Tangier (Edison) with HSU DMA this causes a regression: the
>> first port open uses TX DMA, the second and later opens transmit in PIO
>> mode, producing 64-byte FIFO bursts with ~50us gaps between them.
> Ugh, sorry about missing that.  I'll queue this up when I get a chance
> in the next few days, thanks for posting it.
>
> greg k-h

No worries, sorry I found it this late. I have been behind testing 
kernels and only now trying to catch up.

Ferry

