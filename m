Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795210439;
	b=bInC1j10NajJuNLBnlEtY2M52Mf3P5JbtsZlbbWimrndy9JMQtiYNtrDAqXDg9byX4n1
	 5yQq5OWunCUb8gyaP0UoDqd9qUIstSUUHLkh62JRBDXkAGlaPxWYtGr2yJ87FcXzDQoCT
	 R3uhRTP0tS1+/RXBJ6HmyigGl5HsuzzYOfmVfkU68DOIvEu/C8FYD/hKG4umBMrdZlAsv
	 wk3R2+8D4QgXRJlUH9Q47mnXRrryv9EBg79bU0XLSKGCOjZQoeg+8IJBXwc9Hc/u/nksN
	 oI2Q7HXDWI206rqoE/uV9pr4BFjEl/L3M8Fo9cunK1C1d6EUq/sGIt7l93vvxRAXLKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795210439;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=1djv/Cl6L7baYP2BjEGAGN5zEhkHq4i1i3oynSbuzoc=;
	b=32rrGUnsy1XGGE3ONLBnhaDTPfg1rhySoAESYE9oNe6WGXJm2zpsPbjQfpIfu0fKRjl+
	 c+JtOVea2F+QHKb8Ph4oLT8JqzLNmP+sQXCK9jjxwOr0AOpTiNGoiZsj01DVMAaPD71Ca
	 Wre+Z9JLeY63w+1N6ZaAQBlcNGytIYZKLMIc5WA7YtN1lCEo0lRkIKzadp49b+LFQThEM
	 ALpZKSjK2AKflxBVUXFeoz7vcnXo8U8HO7Ebh2Kfc62Q4eNP6cmBMLt0dFkSP07Q7reeI
	 FbKm0CEQQG7lJZmQ9tZ4BsErhbV2l4Jzocuo96tPhqd7oMOs1Y1K0x/61xKqftn8o1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gUB+PJgB;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D4D606A692
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 21:33:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97D4D606A692
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gUB+PJgB
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-49a357e48a2so109468f8f.3
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 13:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795210437; x=1795815237; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1djv/Cl6L7baYP2BjEGAGN5zEhkHq4i1i3oynSbuzoc=;
        b=gUB+PJgBk5EWk8aijV5j/yAhsI2yNEPiSKzIncNEtmM8AuULD6wSLdCxWTZluOzYFW
         uMFO4LFK9m4DGsLfrlAV1N9MtucGgmQaD4xDooVpWWCh6GZyjLdspa9ffjXHaGRYRlCe
         pyPzFeLQ28QT8ViL7ugWtlHkjrurLJTH4gZRCHMx1NUJfV+YjHkPgcn9wNVvD5sRJ2Hu
         SPjIU1SJ8gT8z3ofkYvh7UNm+0ziT7trdpgkXfPVt3IVr2UTuLY/nrHEgvnyhRnN570w
         GReUoSeziXHP+Q+MEcQjBCFdNhxryBtaUFnFs/V4G4besK5wwbPodpKZw5KrEyt7FJYP
         7mGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795210437; x=1795815237;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1djv/Cl6L7baYP2BjEGAGN5zEhkHq4i1i3oynSbuzoc=;
        b=HCT1lkjbq7nWpk5towgLvR7SRAUb6DmBq6akqOmCCnSU0qwTJqqJfBB5VjdHq/ciPy
         oy2VT9Q0HxUJX9ED5jrZ56uvsmI9AxA8097Xf8W1J2mAL5f91gyd3ruBLmObhZNXvqnW
         IgBgGSQJjqDHNQ6rcFYxNb9lMKKup6a1UzdOnX7WygRa7oL5mzDdqJMIH5bzn/9fs79g
         P74rkH2H3WWz9FmisPNpNORuneuCgptG/4Fp8e5QRMG0DWRu+YvI8hib/BLhmX4a6Ql0
         pg/y94YvEF2S3kiU4ETV89KaNwUTqrxFiNnjfXM45IuEd0wqYhoz8NCEc2FlZrz1IEW+
         HFmg==
X-Forwarded-Encrypted: i=1; AL+hErGYhpU5kiftRDKN8E01j4ZauQwWd3mZbrwQA0KS7YZpWIsEULeAULSDXsCDpLwPRPzN5z38rn8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9cGgJ/ia2Ggq0+4gy1awv9lRMBTBdc0Im2rZPyJoCwwVd/0yKk
	hpuWEzudwj/cA7MXOYK63ZvHjQXvRI2yKd5MEfB7Y4uhsLgdfiWnhepe
X-Gm-Gg: AYBFou0sSyttDgzTG63vafoZVFeFhQII3y2PjqCKoKntRSBjztiluOz1u9R7cMMSZlH
	P1SqbSOXY9Rl9putww1Yv1xkh6+uCPvmsLC+3Fid8aMUZelXq3AgV9NyaYjX4+t0iZoBiiqg4k2
	LpelSAo3wznUB3ZGDNCughRRGTbXlnniJiY4HInyREPx2v650GJbT+1L0haOiyVnRrp97qUXdqQ
	35tA3csHRLDqsrHOduM+nDEcWHqgRNAtuBp0Z+4sxJ/9R4+bkgqIdIGcE3e1qzR5q13r6h9hiIy
	ubSnOYKBdAAb2GE6bw3w4mSIRU0q6KLxzGDt3Gpc4v/9lXYSB+T+mieMMT7zTC6OlESVVhM+iGu
	Zi/R+BNvAMMOc5b8OWy8ea8uOXAHTpQc/pg4a3NxmzTe+ib6DxsjflYOdnPhmUaemAfo0/y4m3K
	AIS/cSpy8Sd1DJoYUf9aOFt4BaBU8L4Ek6Ocsyd/9Fg61nfmq9v8bgTtWj/mPbIWSRmPmUlgGaN
	a6Fur2MY36xfOFdz/4ZngqLuutTUM4f5EGTC+LEB0rbnQTJ3Da19uUU7i2XcOT7xqsNRlcsaRuF
	H3AVOybgJHEXnXZtQW3CmfLlPEHGAuv6UsFa3+Gn9QR68psZcbjAhqmoBrgtPO1GnGvtwHiMCG9
	V0arnMrCBejEZxFqfJrDzQqR0j8Ry2PGGhF2r6okUccsGWGM83CsJ7R+DZN4V4WUI+3NzbCwRpT
	BAZ+rJ20FIeWdS7G23vQKp20hRQSlbqrWBgLQZKGK3KTys4CI=
X-Received: by 2002:a05:600c:8210:b0:4bb:7ad8:99f2 with SMTP id 5b1f17b1804b1-4bb88785da4mr97653945e9.0.1795210436926;
        Fri, 20 Nov 2026 13:33:56 -0800 (PST)
Received: from ?IPV6:2a02:3100:65ed:8fc:216e:bbeb:a7f9:ea1d? (dynamic-2a02-3100-65ed-08fc-216e-bbeb-a7f9-ea1d.310.pool.telefonica.de. [2a02:3100:65ed:8fc:216e:bbeb:a7f9:ea1d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884865b1sm116032335e9.5.2026.11.20.13.33.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 13:33:56 -0800 (PST)
Message-ID: <b4307a19-acaf-4fb6-ba3f-91f029cb30f0@gmail.com>
Date: Fri, 20 Nov 2026 22:33:55 +0100
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
Subject: Re: [PATCH net v10 4/4] selftests: net: hsr: verify GRO policy and
 ordered forwarding
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch,
 shuah@kernel.org, kees@kernel.org, petr.wozniak@gmail.com,
 qingfang.deng@linux.dev, fmaurer@redhat.com, luka.gejak@linux.dev,
 bigeasy@linutronix.de, xiaoliang.yang_1@nxp.com, skhawaja@google.com,
 liuhangbin@gmail.com, stable@vger.kernel.org, sdf.kernel@gmail.com,
 lukma@denx.de, fmancera@suse.de, danishanwar@ti.com
References: <20261117141922.20-5-xiexinet@gmail.com>
 <179514132547.3136.13495496804508264681@kernel.org>
Content-Language: en-GB
From: Xin Xie <xiexinet@gmail.com>
Autocrypt: addr=xiexinet@gmail.com; keydata=
 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
 sNySbH3veZ/55EtlXA==
In-Reply-To: <179514132547.3136.13495496804508264681@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/11/2026 03:22, netdev-bot+sashiko@kernel.org wrote:
> Can the single-producer ordered cases fail on a correct kernel because
> this sender is not pinned to a CPU?

The single-producer cases send from the unpinned main thread, so with
threaded backlogs a migration during the loop could deliver the frames
that enter through veth out of order. That would be a spurious failure
of the test on such a kernel; the forwarding code is not involved. No
change to the series for this.

-- 
Xin
