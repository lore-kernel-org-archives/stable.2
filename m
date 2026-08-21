Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331153F412B;
	Fri, 21 Aug 2026 05:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787288518; cv=none; b=pon9zz3+uTTL0lcUa5LpDI+0o7xxa4diNb0u20RLOdWund2//rcNlDVc1/0AZ7uuyYFUvMYS7CRrXAfLW3pGNSVD2X8n3b0wN67SQN0pWbUuRIt42ULQqf4IOMhF4WwCJS3lW/vTg8vP+in9q2XI0QchK9boQLfjyPVmG/1L2qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787288518; c=relaxed/simple;
	bh=/OE697/dAseBhi9BJJ+oi1bQXfTLd9mGFcVvxzADzEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VWJkD404hvLM9115eIx5547xDA3c9NHHNv25fZuQaK6Y+v5cyhLQu1REjTXeO8vzyU5cwUyTr3J8nQcaZCuHRPjI0CjMuOS+1RY8+GSIpukS6+R3V9NICo8DlCQsbQGkDsWIpTBrVsVMNxVyuGCwXzLDwYgdtsfln180QFbFvFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=mwNyiGjI; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="mwNyiGjI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1787288103;
	bh=J1DaprXoeR2KMYd4TnyUd0hxQeVQHIC6XSVDXz1S//k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mwNyiGjIPnBSshE9SCObN3kEL2MDCogLcdKUfm9H9WmFGmB6Ze2hoXP3zVkTXJLWp
	 rnX5zvaKI1SY4WIsy2PasPBko3nSE6QkqdeARK6D4rBdwZMEm0alC0UdhH3yf8n3Cq
	 cPTDFdbcE2kI6ayPL4KrzjSwuI3dzyMLlrc1w0KM=
Received: from [0.0.0.0] (2607-8700-5500-e873-0000-0000-0000-1001.16clouds.com [IPv6:2607:8700:5500:e873::1001])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id B8E1D65983;
	Fri, 21 Aug 2026 00:54:59 -0400 (EDT)
Message-ID: <d307af7c-7344-4420-b14e-aca2463ba7a2@xry111.site>
Date: Fri, 21 Aug 2026 12:54:57 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] cpufreq: loongson3: Replace per-package mutex with
 per-node
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
 Huacai Chen <chenhuacai@loongson.cn>, "Rafael J . Wysocki"
 <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Xuerui Wang <kernel@xen0n.name>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, stable@vger.kernel.org,
 Hongliang Wang <wanghongliang@loongson.cn>
References: <20260818123921.3600606-1-chenhuacai@loongson.cn>
 <20260818123921.3600606-4-chenhuacai@loongson.cn>
 <3f352680-7090-456a-ab08-2d3367641783@oss.qualcomm.com>
 <49b8a931-f814-45c1-97f4-cbb825dec700@oss.qualcomm.com>
Content-Language: en-US
From: Xi Ruoyao <xry111@xry111.site>
In-Reply-To: <49b8a931-f814-45c1-97f4-cbb825dec700@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/8/20 20:35, Zhongqiu Han 写道:
>>> -    unsigned int package = cpu_data[cpu].package;
>>> +    unsigned int nid = cpu_to_node(cpu);
>
> What if NUMA is disabled?

include/asm-generic/topology.h has a fallback:

#ifndef CONFIG_NUMA

/* Other architectures wishing to use this simple topology API should fill
   in the below functions as appropriate in their own <asm/topology.h> 
file. */
#ifndef cpu_to_node
#define cpu_to_node(cpu)        ((void)(cpu),0)
#endif

