Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795436865;
	b=HcE2mYLmIdp9tQYGn1V1BhW1/Rxu60i5gBee3KMr30LfSYlpTuIzdTdxTOV6IBAcXtAX
	 phc6Z5iGnK/iFrUI5ZqjWqLdeNz/b5yhKlRFOypfVveiDc7aM4HH/7AkAX0w2g5qGQwil
	 hnGw4x4njoaq9MhFGhH52aC4ucXPzTRgFAQnol5hKpkSZq79fcgDiltlYvJP7i3hkX6Lq
	 MxHELVVClmWXZW61hSTWk8ayaHd+sR9HX/RxuIteayWwZI343FisMYHpDvW1akpmU1ATx
	 ofzpMjQvdjx0E0iKemSPWWBjAqGfjTlInIfg6AvL09cBCPI9kXlbiG0OSB94FjLtJ1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795436865;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=VPJ4qxbI93bPzZzijKlNpT2z2hanGh/YCxc/VAqAnNU=;
	b=fThLp69G7VoSG3wpD/DlSY68zz8wcpaOoxemX06VFGiQJloJnf9tdEXN914GaoSXlD4y
	 A2v6gYhNI16gY/90dWIVmUg3hVD0o/RgIyKZW0612PP3wLndMK8RBoqqR6Xvkx9iOY6KG
	 6YgBSdqnvzb8OfSPFmWHyknZRwq1BNC2P6Egd7ovciI+FaH2qf2quXrdmttXvtJK68sU8
	 Gt63XeNHoSWPITKXeS2qEgg3mhm9D8tZYCxh4OYhaBm48Gsmw0ZA0EakvLSXqG/nuEpYc
	 Ctq/w4TX4RN0T+xwDUQHBKrdUnxxLN4M5sU/oF+0aKmhha5iJwqQJnp0MngA2K/LHfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XC01C9nY;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="YMM0r30/";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF181606A321
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 12:27:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF181606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XC01C9nY;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=YMM0r30/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795436864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VPJ4qxbI93bPzZzijKlNpT2z2hanGh/YCxc/VAqAnNU=;
	b=XC01C9nYqEtraV32g/ZWZHsEyG2VD2VMTF/Hanzkv6nsiHo0IMHHBWUnL3pbV+/wF3kr1W
	ZYX+J/G2Ohm7RgRfTdiCoYov3zuKqxL21CtRNXHgClbEg+xDy+iAr7lyQmhErPHMDJf2zJ
	dIGExyqLXaHJBs6d/L1/oACml2LMro0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-tsUBBC-iO6Ghi5z6ICkFhw-1; Mon, 23 Nov 2026 12:27:42 +0000
X-MC-Unique: tsUBBC-iO6Ghi5z6ICkFhw-1
X-Mimecast-MFC-AGG-ID: tsUBBC-iO6Ghi5z6ICkFhw_1795436861
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48e0af48c18so1955204f8f.2
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 04:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795436861; x=1796041661; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VPJ4qxbI93bPzZzijKlNpT2z2hanGh/YCxc/VAqAnNU=;
        b=YMM0r30/1FOYi0d5us+CD1V8yqGm8dAiU0V3hSguhGVgfBpBxxePLbrR49r3SbQE54
         efGdwpdwwN8cz8+TjcyPH0G4B+4ARjNeP7Dxs6JVANgdFYEfvqYpkUt+pnw4L3YgnmHf
         vDuYplafZglf5pzfmidinFQ5hX7QSKmANdeII1yZpGlZdo1/Av2zA/osHDKpD4oJmYIF
         /9yNOkcWmO9MvnSH2vqjMapBT3c5JYFLvxVi1ZYZoc/8FeFvzjoSOds8J2u3YCOT07gp
         N9x9RH84BtFQ55FgXqxKDA5s/WquJaG53+vw+QzpAx5wobVF2pRqsMShL+Rp7M+UZCNj
         3npA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795436861; x=1796041661;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VPJ4qxbI93bPzZzijKlNpT2z2hanGh/YCxc/VAqAnNU=;
        b=2gUSueGxzjy24BOoV+UEuxUPsOerbZOIyqqLpJt5wgHQVtlejN0bMwZhuZDk/6BcbI
         KFE23syf1zTgIdydtfCcDWT9qKMhnqbKC42vpAIafRB5VpTbfobTPlkgqnx7LYgyIXgw
         P+VrDxHkBtmh7zI2O4Egqv1MGyJZM3//PapZ1RWbPJWBqxQ2MZBVQQLfeN/Slesu9CNF
         lItN/ug+36qbEoDTmOCbciKUZ81v6yNUNf0nuvuggUl9truSi94DrGGztY3COVmXlex9
         yeMFSa/shpoCK+qUbiQrErnD3fFQuRcoE7xJTZk1idx6TPJNlJPW1I21Me12LTgiqyiD
         CZmw==
X-Forwarded-Encrypted: i=1; AL+hErF1WQ6qhgiDhmL+yMyok2U6IultZ6v3D5G/jja88+4F85gsWebVDosTdS1sCLhJtLqIfU5Eml4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9oLoVEefQucFKMi4WM3GOF2k/1s5fHpCgw78LlMLeF+PuUnjQm
	oN9j0Rn8mT78e9czfhsAlq9y+l5J8lt+qDsSYkzjvLB4GP7CAcBFJRoCQHbEJb6HXTRnVTDiPrU
	WatzlbF1KMA7uZLwo73bJlpk0YO+j7/9Li0ofmUlfubKgu4Y6NYrm5ZhFFw==
X-Gm-Gg: AZFdTZf/rFvZvav3coX+EMOWVrOuJjIgaleo/9VjkCtnB24Jb9hsVA1aTWI0cu3bgCh
	4W4dQ6tJ4DUzgR2yTC3Pt5LPxjbp0J8DKI7Wm4oKtW2O70wWEl9YG1UYOPyPuDkwM6lcANUgtK+
	Y/NFEG6liGx2XuKGs3spZIMfSRxOBqjMci+yMM3bzKgZYojfzC+2NZeZtsrCFaBElVJSFIuUutu
	Sswyn6L7pVDCDR+gLaC28yQpdDoat4Zuomj8sdUO6vy4MkamMIszQU+c6sAZ99PHTJoc3lBZNh1
	OFfISApeQ+H2Lro7UaZsxJwzyGS7ugFqkzbdPF9JKokD8rTKuIM5p7WTAwTiHI8L7xQv1T1yoPz
	uw7VrstEekxm+XuLQuqoH/ikT+J9fFd1n9I0SsIsGSh+ppPLqECOVwFYVqJQnc+al2DkhvnIBkX
	xPTSt4nuonnMYVzs+mcl32CPjkTQ35D9LbB0JSHUJBuB7y
X-Received: by 2002:a5d:4492:0:b0:4a8:1b63:215d with SMTP id ffacd0b85a97d-4abb6eed6e7mr16616473f8f.27.1795436860795;
        Mon, 23 Nov 2026 04:27:40 -0800 (PST)
X-Received: by 2002:a5d:4492:0:b0:4a8:1b63:215d with SMTP id ffacd0b85a97d-4abb6eed6e7mr16616425f8f.27.1795436860290;
        Mon, 23 Nov 2026 04:27:40 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b10b5f6sm20481994f8f.34.2026.11.23.04.27.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 04:27:39 -0800 (PST)
Message-ID: <6aae7800-5306-4839-a4c8-56265a0fae45@redhat.com>
Date: Mon, 23 Nov 2026 13:27:38 +0100
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
Subject: Re: [PATCH net v7 1/4] net: hsr: keep GRO disabled on HSR/PRP ports
To: Xin Xie <xiexinet@gmail.com>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 horms@kernel.org, andrew+netdev@lunn.ch, shuah@kernel.org, kees@kernel.org,
 petr.wozniak@gmail.com, qingfang.deng@linux.dev, fmaurer@redhat.com,
 luka.gejak@linux.dev, bigeasy@linutronix.de, xiaoliang.yang_1@nxp.com,
 skhawaja@google.com, liuhangbin@gmail.com, stable@vger.kernel.org,
 sdf.kernel@gmail.com
References: <20261009201324.17-1-xiexinet@gmail.com>
 <20261009201324.17-2-xiexinet@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261009201324.17-2-xiexinet@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/9/26 22:13, Xin Xie wrote:
> HSR/PRP add tags and sequence numbers per wire frame. GRO can merge
> plain interlink traffic before those fields are added, and userspace
> can re-enable GRO after the port is attached.
> 
> Mark slave A/B and interlink devices with a kernel role bit. Filter
> software GRO and configurable GRO_HW requests before ndo_fix_features()
> without changing wanted_features. Filtering before the driver keeps
> feature dependencies intact; fixed-on or driver-required GRO_HW is
> left enabled.
> 
> Apply the policy before registering the RX handler and reject attach
> if software GRO remains enabled. On failure or detach, unlink the
> upper before clearing the role and recomputing features, restoring
> the user's last request.
> 
> GSO skbs may still arrive. A later patch segments valid GSO before
> HSR/PRP processing.
> 
> Fixes: 5055cccfc2d1 ("net: hsr: Provide RedBox support (HSR-SAN)")
> Signed-off-by: Xin Xie <xiexinet@gmail.com>
I don't agree with the goal of this patch. The kernel allows a very large
number of bad configuration. Explicitly preventing one of them may
lead to regressions and leaves the lower device in an inconsistent
state.

Please drop this patch.

/P

