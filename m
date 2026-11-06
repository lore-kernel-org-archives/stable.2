Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793934091;
	b=HucVy5Fk79ff3X08QvCiBO2l91ne6M+xBRrI+WdV7RnKEm1zIjMilJ87XWutBXbfsadg
	 floInYRbR6xXRuvFNJb63gSn7+3qQ3o5FskVvkWw/r11QiMzg3eQj8wkDR77Iq6exLYex
	 ugYjSoz9vc8Fh0VXNkjtPcBDJHIXEGGZo0hTd7/eCINqhNcgb8nzLuDBbn7iHe2+bb0X+
	 88F4o9Sg2PG4aiRpfwaTlnQ1Vur55jCN8SpmZR2rV0h/7GQTIaNZImcERXJkfqE7A17an
	 SL7ifQBHR4KLsyYDBQ61JUPaLH2oWcrTQRKs4X0HnOzR6iyOLN9Z5ETpPsCGytRQvZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793934091;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=t6aRulHNXUeC2tlehsSj6ODcF0+cJ04EmVwTbLYgrmk=;
	b=RjSaJBXG7nAm8KkVMh5c0Q2Ax6gtj0pvvii5YjjvkLG584aIqRPBFfwytlos5JVZreYt
	 P7wVldoCYmL1oaKkt3Sq09Al9PZR4FFVb+IHTpEcEoT69gwFw2m1/Jatui59Cp7M5Ct3D
	 p6G6O2/G+Vig739iDXdmGnMazRYwQR2A78065lwiVB65uIAg7GkVjeYwMfFC4UFBWEuVe
	 3jYFyNudnNY1bb0kdVTLhYr2YlrCspwiNa/zwjUStdGN/qFTKgMzTM4T0AlNTRouoWW6N
	 8gLUobvay+JkhrJm/VUMOfMnSi9oc0k1Ax2dSiSCQVd5zmNMMqdVgMKbclhkqwzydCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JCl4Gfy0;
	arc=none smtp.remote-ip=209.85.217.54
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F5F606A32D
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 03:01:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85F5F606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JCl4Gfy0
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-7d27bbe9900so70986137.2
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 19:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793934090; x=1794538890; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=t6aRulHNXUeC2tlehsSj6ODcF0+cJ04EmVwTbLYgrmk=;
        b=JCl4Gfy0EBXXqrT5LV6qnfQdzP0zEsd279x8qeNp9xw1/cvvvBRYQcDjrC6GVeX8h/
         jfNkCTg3MZ5RUsyP2iQuXxG4os7zuN8QwX7y81S6xL7pSjyoZk6R8TkaCu9hAu5Ei2Mh
         ZYkL52QTJfBup6LDoFjp90Hjg/RUnODdQXlU4YnyTkPTvCix/uDocjDzixnymYooFjcG
         mITLgCR0CeXhXzH+uQTVkTtGwBXuEg/5MeuLoAFtpR+R2QCNGMLBO2V/+KSn6tW80Y+t
         z+0aKEtK5SqkEXHYzQKScdpOb75WveqS3Wg+sjB4Bw2zM0KWOR9c4WxkJOWS2cosEbUx
         d+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793934090; x=1794538890;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t6aRulHNXUeC2tlehsSj6ODcF0+cJ04EmVwTbLYgrmk=;
        b=QSReyIt/i6lFHLnG9yHHcpsum3nphHc1K4mzjjRPTN1T/1eALRE7sn61c2VCyh/cAe
         tUB0JV05l7PS5NIJvgC8rYx25Ffo7lb7K2HZYEhWek1WxmZLTCSt7I02EWqxLDvzLV6/
         sPzFIx9JdXFHW/Deinm3Hqa4VacOzvF6R+fjtBo4HZCfkb5bUXY/Qsgu77tmh91hMhi0
         2ERRmWW3Y9Zwk/kceMLW8s0ok2dk7ijmbkymnJX0S//ml9uR+paWUCpZ7Q8FRu0uUY/b
         Ki6MF9zN6CfK8fAcbOjmuobJZjTtQHoLi22yvaotkaaA5MIPm8+ZbhbwHXCGsf+BLxH1
         kHeg==
X-Forwarded-Encrypted: i=1; AKwUvBzEnYc6X94xc0sS1xL7+mEId1lmyhHCeorVv3C+f0lyu3PLseJ9Ujjj4LsuHH1zOzme2XZd7fI=@vger.kernel.org
X-Gm-Message-State: APuU4Z95ho9yMDdpOkEvDHWvjW6X6maTnXdtgwse7j8x51b0W9K6/aVy
	sHiBACh2y37vGzjGvmJsL5M4C9m1R2JoneGXlOIi+oAPFgNy3Cnxh8jd
X-Gm-Gg: AYBFou36UIiRlQtlj6drYp5PoKjBZjqnoiwTm5M0ZZ1HZiDDZ5eV0chayKv7zGqJiSw
	+XSMMt8yYMzzHny/F4BTK0nz7rvuBG3h15GQpvzx2bgVlDlQvdEGMhI+JFQ8C3MaR8BEI952xur
	GfAZv5x4ec7KnyEYlNEDQxkfcf6fRKEfpEp+ll7ORG+IogZuFp0FfIktEZCS5bdWGqcn2J0CUxH
	J/GJ9zjmE6loddz1HRT4xtEhQIesfvGVcNdNBJv8ESQ5UriCQARF00/C+utDcewx8CmYHGJ5c2u
	EiY9HCGTpLAt1g8GEJgLFAklFM8bJU2JzhydoIwLWhXCk+hjgCq8mWUptoNdilFEuJ0dcLyOLHL
	ZXKHD9Q3J70xVsAjLQ3NNHKQPgtdoVbYeXv1t1MNDg9JwFx9TZ8fLK9wgpfjhesLm/DDByjLSJ9
	hV9aRO2KWWA/uRwUnUzYZ01mxSH/dgdOMwRo9HchTvDRiisuFXvyJko28sNQyYzTAiv6+9TRO09
	M1sqM9AHOxv4hRNfrEuAZupLW6wP/3Y5ivor/AU7W84yYWeh7Psdlmzgr5ryOMczzrOmZobqLjR
	XDA9t1Qaor4V9+Rlc4bzgjEc4nKYRYlE8GaYYJb742GfPCXYET7MaMBxf2kV0/j3uN8LP1CHKgp
	Me9jw1uv14a+VLV10T8IEO5iU7Kl5YesmzaSB5IZHrEnkv+cIBKX4WKigqXqu3bjYaZ18lHQ=
X-Received: by 2002:a05:6102:160c:b0:7cb:288a:b66d with SMTP id ada2fe7eead31-7d2a15989e3mr838027137.20.1793934090385;
        Thu, 05 Nov 2026 19:01:30 -0800 (PST)
Received: from gmail.com (223.230.150.34.bc.googleusercontent.com. [34.150.230.223])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99baea8e48csm854885241.10.2026.11.05.19.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 19:01:29 -0800 (PST)
Date: Thu, 05 Nov 2026 22:01:29 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Xia Yan <yanxia@cmss.chinamobile.com>, 
 willemdebruijn.kernel@gmail.com, 
 netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, 
 dsahern@kernel.org, 
 idosch@nvidia.com, 
 davem@davemloft.net, 
 edumazet@kernel.org, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 yana06070@163.com, 
 shuah@kernel.org, 
 linux-kselftest@vger.kernel.org, 
 willemb@google.com, 
 tpluszz77@gmail.com
Message-ID: <willemdebruijn.kernel.1e8c4e152eca9@gmail.com>
In-Reply-To: <20261106021245.246267-1-yanxia@cmss.chinamobile.com>
References: <20261104092240.15649-1-yanxia@cmss.chinamobile.com>
 <179387153949.488856.16266299848614841295@kernel.org>
 <20261106021245.246267-1-yanxia@cmss.chinamobile.com>
Subject: Re: [PATCH net v2 1/2] ipv6: fix cached route reuse for SO_MARK
 control messages
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Xia Yan wrote:
> Hi,
> 
> Thanks for the review. v2 fixes SO_MARK sends, including the concurrent
> sk_mark case that came up during the v1 review. Sends without an SO_MARK
> cmsg keep the current behavior.
> 
> Willem, you also raised the flowlabel and dscp cases in the v1 review:
> https://lore.kernel.org/netdev/willemdebruijn.kernel.6ba984cf38a@gmail.com/
> 
> I'd like to keep the SO_MARK fix targeted at net and handle the
> remaining cache issues separately in net-next. Does that split make
> sense to you?

Agreed that those additional concerns should not block this patch.

Are they net-next material, or similar bugs and thus also net?
 
> I'll wait for your feedback on the scope before posting v3.
> 
> v3 will also add a fwmark 0/0xffffffff prohibit rule to the
> connected-socket selftest, so reusing the cached route instead of doing
> a fresh lookup fails the explicit-zero cases.
> 
> Thanks,
> Xia Yan
> 
> pw-bot: cr
> 
> 


