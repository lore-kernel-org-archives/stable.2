Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795210366;
	b=xzbYcWVJ2ydndJDDpA8fqnlxlaKdQkNYgN0vzxMfFg33TNidv521jNjY7llJU9Unx9cF
	 d+mZAvAv7P+Qen10Elmq0tgsWHtoiQ4c6TsQ9A+8/YkjxMkgpuEHH3x8w2qf8108vo/1Q
	 F6wqMKk1jrhgU3b6DGz7vRj020x3wp8123ovvl+SBN4McgC4zrDdsSifejLMpNZ5rFNxQ
	 jTQRrVwIAp7o2kn5Pu4ifJx6Kll9qqvU1LNN50r53tzccKcnwgbXSqCDSNi8TrTktY+nh
	 iZl5rrzhpyk5izt1rXeF4shLWWWgJWGspn7W7mTsnhJKdX9BOdLkzLgXZ3rDNG27zEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795210366;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=4p2T2Zg2uEfX0S3UgngIvYy2v+9xvr8BhJ1ygzeVIy8=;
	b=tzEYBb6eXWbOFA2Mb2u3MlrfZi+/Q2JDdULQBAiy4ZRCxNKzhCikk/R+7/PK5O2719+L
	 DxqDx+RSM7SYkg7vhn2QgpGWZDxA8rwZYYKyDaUZFjckUg9kDrqZOSbE/qnswZqFOXk/i
	 4brgqz0nhKPhTqGuUSDGKXiHE1VLs5J+Rxxtm615Rr9uAB3XXU6jbzsc4FG2mXXD9E8r/
	 lGscq3TL18TozKlezgUgxef3X5jpHnkMiCjQcCHZog7XIsKt4xVyhA61iv3yAX0HIvOG/
	 isOIawkqw1O+a+VX/WlOd/kh31yQ44/Ux7MuzKuFiokvin8PptFhhuix3Dq83ID/0Fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sEkFnFKr;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E1D606A68A
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 21:32:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33E1D606A68A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sEkFnFKr
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4bb7679f28bso1044205e9.2
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 13:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795210364; x=1795815164; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4p2T2Zg2uEfX0S3UgngIvYy2v+9xvr8BhJ1ygzeVIy8=;
        b=sEkFnFKrbLKiLRg/2IWy9pVLL+6oFVl8o8YQE273/dZ+0JwnhrNtj1iaGush0cEzK0
         INnm+iA6hWaWQX/Fnfv71VP2979ZVUDrHM4EdGUuxr82PKwuFX7vfPUQWnWiVTzpZM6R
         UoayqILUGs/vBMSUfIOnU54pl2JyQ7/LYc+xKEl2eMfFN2Q7IuhnxYL7/x0/GtGb35O/
         LBBIa7W9YuuFOM7IrJaPIWbyqWuhtyXndezJbYptud+1B5quwJoXE2NW5vIvelihvln7
         PA2XZRtm/zIBLKFUCMlT5QBGuGxDVnnQLe44BKMSLuG0Cp+q3i6VCY34uvXl9FhXFYVS
         J79Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795210364; x=1795815164;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4p2T2Zg2uEfX0S3UgngIvYy2v+9xvr8BhJ1ygzeVIy8=;
        b=qM/TxmXJYTcpNK/ZBcMNxiBz5yF/JXr4SXHYf3Z6s8MGQ/QX2WC1CIRC8ooqnjf0Ll
         MvnzZPTB2zqE0JpbiCWnS6R1nubWD70k196s+2FV3lr/WKLHIki7fABC6R5Fgfm1Q/yh
         Ik28iLGfcQP/ry+kANkosn257jycEynhBbgrKiS93UdBt18FIjjkHeTWz2fzmF0YPLdC
         qMDop0Z73w1NgsCto3AtHxONjQQSSDCGuBpnEx9bVLEIyFtLEwlk7l3ICXWGa6X4uBpO
         QmSKo6Cn9dvrV106ZNC5m6ZtaOsrc3udMkTTjl0vcBfF+ML9zW3ChTSSoyoWee4gJpjM
         35/A==
X-Forwarded-Encrypted: i=1; AL+hErEwM8xbxQPIbXWvYRfjO9PKJ1NtZ2eQLUGI3Jur0X7QNMBFKXyC+5RMJ897zdESsxk48TLmXqY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+peWoRW/qnZooeizYLRp7vNeVmlwXOPhLGIB0+TRr9lyLnEGti
	pWI3NoJnM9xEb0RKTZ5fmPsCQAiqgwBS2j66DDsa7aqqItafiuRPf23O
X-Gm-Gg: AYBFou2+CcmDj/ozZ3ulM4kZINsDSxO1pwdtO5cPLXJpu4pF/UtzNyQELdtAAfcQHMs
	oetFh4qtAcXTb/2hevpr0EuPQx7DaGyZ68RoZrOkQfTYuLjLyMkCjKrFTC4KvlkxvloeBVryUGM
	YQ3AypPBDjVdVQ0EYPHKMbx/UI3tASKwv7yRbTq64BE0KA+S69d+I+LOui1/1y3zr5/AQXMVdVZ
	bZuYsMF/L6vT5wcZycf9dxftZ39dO3JuyRE4byTqPsJLlH667D1dEXJ0wCr6oD3be4jku8ofhT0
	DxS0s9TFNAwp8wg8ErQgB6jsXKKlVUF2H0eyw0HEr8lMnMIyr7DOKIsTjfeAnPC4UmSkWJq7v5F
	QAB+NgEvPc3Y/tYtDVtfuDAtoDACFvvb9D90vDYqEZtIDHJn5ioqnZM+3hoee/0KW/vUfLgx5iO
	DmWoGK/lOsfzLi9CxQ2rwR8FZQ/jpHHO4RTJWpEYBc02efhdzuMU+kDKs4t0hg9ri5tTZNti5BV
	GQgCA6IDfADDmk2wKQmQl7Y3zKoHVCVmfzcF7GPeY94Tr9VbMf9UTJo7EH2001FAZrumYjcaQj/
	W64haceqhPQPZ8Y4Zap7OyLM8ChlltoCjOsqN096daREfb+c3HkJmgYb7U7/IU8osdMrvFj7QL1
	IFMjARyTTcgB5A8RUHwi0B7FeyHvQVW0cI88s2YxcniswAyA8CGSZvVUzvUWsj1ZEqHmwgJAL2p
	RJr2t6ipAvEem2kENymTvhQVbQC919AXn97Ni9Gp5HTQzlZRA=
X-Received: by 2002:a05:600c:217:b0:4bb:6a02:d42e with SMTP id 5b1f17b1804b1-4bb887f3fb8mr69797915e9.1.1795210364452;
        Fri, 20 Nov 2026 13:32:44 -0800 (PST)
Received: from ?IPV6:2a02:3100:65ed:8fc:216e:bbeb:a7f9:ea1d? (dynamic-2a02-3100-65ed-08fc-216e-bbeb-a7f9-ea1d.310.pool.telefonica.de. [2a02:3100:65ed:8fc:216e:bbeb:a7f9:ea1d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb895f7bc1sm37514135e9.3.2026.11.20.13.32.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 13:32:43 -0800 (PST)
Message-ID: <caa0bad2-0c73-4cc4-b0ca-360a568a1947@gmail.com>
Date: Fri, 20 Nov 2026 22:32:42 +0100
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
Subject: Re: [PATCH net v10 3/4] net: hsr: segment GSO before per-frame
 forwarding
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch,
 shuah@kernel.org, kees@kernel.org, petr.wozniak@gmail.com,
 qingfang.deng@linux.dev, fmaurer@redhat.com, luka.gejak@linux.dev,
 bigeasy@linutronix.de, xiaoliang.yang_1@nxp.com, skhawaja@google.com,
 liuhangbin@gmail.com, stable@vger.kernel.org, sdf.kernel@gmail.com,
 lukma@denx.de, fmancera@suse.de, danishanwar@ti.com
References: <20261117141922.20-4-xiexinet@gmail.com>
 <179514132368.3136.11119943958824488606@kernel.org>
Content-Language: en-GB
From: Xin Xie <xiexinet@gmail.com>
Autocrypt: addr=xiexinet@gmail.com; keydata=
 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
 sNySbH3veZ/55EtlXA==
In-Reply-To: <179514132368.3136.11119943958824488606@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/11/2026 03:22, netdev-bot+sashiko@kernel.org wrote:
> That covers only the gate drops, not the segment drops counted in
> hsr_forward_skb().

Yes, the sentence is about the aggregates that hsr_forward_input()
drops as a whole. A frame or segment that fill_frame_info() rejects
later takes the existing tx_dropped path in hsr_forward_skb(), which
the patch does not change.

-- 
Xin
