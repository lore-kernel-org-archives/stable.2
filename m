Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4853D9691;
	Thu, 10 Sep 2026 09:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789032854; cv=none; b=KQbI/I7E4bioXIIjBbYSvyClOT6LkJclksKDoJBnNSufB2wNdN/jH9G2yOPtL1ZB7l0J1MRDqCl2PWIFIYIBRaigoISYmCQt1CWdNZg93FRp4ul1LR+knCCTm1ozBfU/ByNp1Zev/+dXSOvoVx7JwXZSQfTGukPeS9qhZnVJ5eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789032854; c=relaxed/simple;
	bh=HvJgWGi4GL9ZKpD7FsGUlW+AIAMp2vYrszUViiJjstA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rx5IVVpd48m6K6psaG608hGBWcioeKGfp/AREJzwbRJk3rQWfr73n+3dqEKc4zOtnXuFpnn/vuRILwcr/3VLkrqpiIRimx0u/eUAv51UMnaEgV7e0x4siZMSKk7SAjzTYKvIynCTHkk27akmOne/IYAtbse+opm6s9J8b2emHAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Dr5geoxF; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Dr5geoxF"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 02F684E415BF;
	Thu, 10 Sep 2026 09:34:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C984A602B8;
	Thu, 10 Sep 2026 09:34:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9491D11C78279;
	Thu, 10 Sep 2026 11:34:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789032849; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=1owobzy3BRq9SFfOwfU/CvE4VvMt2JngnSld/aGsaHk=;
	b=Dr5geoxFBxVmYooRsucrROQiGay10ZeOmk/7VDz1X4YfNWD88szpMF1G+0tg04v/5gn8Wl
	ztSOz3P2ycE/unkvWydWLPihn92qSd38V0YFGllVeN7nHN5RhY1aCKK/Qa2Fo2aI7UQR38
	c1ZFqD6uWidMYZaJiZrDW7BvpjTSw+JZLpVir/r3lHHkSdUE6JB42TeIqWPkNXLkg1MYQY
	mU3aP8WPGqL0ZrfwvqchOjG7/p7CHq+Ko/PWZ0KfDe/e0pJo0HxjDjZrI3iuwcJVzPaONr
	JbsB7D5vhvYGXjh+lLjZOamquaBpBY4wknPLEI20bSBJJQl1GY3gP8ZJhwc36Q==
Message-ID: <4bbedc45-1f24-4124-87bb-a68da07b10e0@bootlin.com>
Date: Thu, 10 Sep 2026 11:34:05 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10.y] bpf: Enforce expected_attach_type for tailcall
 compatibility
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <kafai@fb.com>,
 Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Andrey Ignatov <rdna@fb.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yinhao Hu <dddddd@hust.edu.cn>, Kaiyan Mei <M202472210@hust.edu.cn>,
 Dongliang Mu <dzm91@hust.edu.cn>
References: <20260908-cve-2025-40123-v1-1-be62451196fb@bootlin.com>
 <2026-09-09-daily-reply-0031-bpf-tailcall-attach-type-5-10@kernel.org>
Content-Language: en-US
From: Miguel Gazquez <miguel.gazquez@bootlin.com>
In-Reply-To: <2026-09-09-daily-reply-0031-bpf-tailcall-attach-type-5-10@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi

Le 09/09/2026 à 22:26, Sasha Levin a écrit :
>> The underlying issue goes beyond XDP though. Another example are programs
>> of type BPF_PROG_TYPE_CGROUP_SOCK_ADDR. sock_addr_is_valid_access() as well
>> as sock_addr_func_proto() have different logic depending on the programs'
>> expected_attach_type.
> 
> Thanks for the 5.10.y backport of 4540aed51b12 ("bpf: Enforce
> expected_attach_type for tailcall compatibility"). Holding this until a 5.15.y
> version exists too, since fixes need to land on newer trees first.
> 

Sorry I missed that there was no 5.15 backport, I sent it.

-- 
Miguel Gazquez, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

