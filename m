Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795525561;
	b=ZaxK3amob1d1e0bPpqWJNzXdFdEFQtd15oBlxLuIfRL1sIZkxRLllnASdNHxN1Qdx2gq
	 BlClMuIZkhYRXR38c6tScZwwafewvysuDOT1OGyvpch0e3Jvlx43TcrtR8BOujplhEJux
	 meC4riTYGMKsPnx68IRTeOW75oZl7cD5dPAuvvamEIBmTTrBUTfIPxHx9I8Pd38+WdP+P
	 kW/4NWW0Q7P7s4qNEusptMJMnUd8c+fd4zsvd73R9Yt2iZ1oKldw+elw9BinVioaYAQ+I
	 KYXxb3nl6E7jdgD52VjV0P9VZ+P0zQpzbXsYBmeUuFdTarFHjb4ITlpKaGiIj2a2urQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795525561;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Content-Language:From:Subject:To:Content-Type:
	 Content-Transfer-Encoding;
	bh=q5dIIGVihzd+X8s26junyurvtIQM21LadFXMcw50iWg=;
	b=v+xTgFdpEEWJh9nVoc93FumF/iNhJ695bdXv8RGkxEu2BeHxTUInvKZjMqi8vGHCsemp
	 mY3RLJTLiZDgl1VT3c1BjSQSSTgUAQW70LoZGQAOoaB3wDeQByIyUt2zBl4/0Ef3WhA+H
	 ENwQKfjzZkB5g9QIiRcxHQqaLvXK9svMBXWGi8gA/FsPUWQo/BvckTq02kjv/UBhoD3pA
	 CDGQcvsPlgjh+yZXh9Yjk1UziutEOP2M5+Ic0USXjxskRFC6ktwqb+XdnP0FrF8VWKuWP
	 ULsbqagXcLqhnRnLMgNLctSPV7WZdWmAZEAS8CloUOubpTdwEm29ErrCZnBpielvHGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qtec.com;
	spf=pass smtp.mailfrom=qtec.com;
	dkim=pass header.d=qtec.com header.i=@qtec.com header.a=rsa-sha256 header.s=google header.b=WNNJkcU+;
	arc=none smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D33C606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 13:05:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D33C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qtec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qtec.com header.i=@qtec.com header.a=rsa-sha256 header.s=google header.b=WNNJkcU+
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b547d6c07bso5813658a12.1
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 05:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qtec.com; s=google; t=1795525558; x=1796130358; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:from
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=q5dIIGVihzd+X8s26junyurvtIQM21LadFXMcw50iWg=;
        b=WNNJkcU+hewwy5Z6h7YaJui0DtzIC91qzQObk/zfdA+q/tqO/A9xBlErff8CdSBpp7
         77K1aAXEU/R8li2teK/RaRROGtmOhG2s+Js8gprQVlApEV26rtF6+6bI7oJt3OqcfVx4
         CG9m5gwdARQ4Nb2xKdpuJO2fRWh5buHy/STy/7OyCw7Q2ueiu7DTzP54BN973TS+Gv6Q
         VViDBDat/nCmdiwAN7w0Yg7WlEsyW8MnT9UQ4ukmHVSL8C6L3+1UpsgNF5vSnrD+hqHK
         NkQ41ZPQzEPpIrIuXB1MK6nblxsFmto3jahw+FOKtE+usEr3VoHlBd5rCvNL5UyQ6ItR
         2W5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795525558; x=1796130358;
        h=content-transfer-encoding:content-type:to:subject:from
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q5dIIGVihzd+X8s26junyurvtIQM21LadFXMcw50iWg=;
        b=h7MbzmDrsVmMMvcYtynaESy+A2/f02dyrcPyKLQ8i50Ra4UKhZo29PHubChmTp+F53
         SiAIE3nM083woLjlw1t8pW3aiwnBimgedpZF4Ua5HHzM6AbONSrOMsJYujMYDFK3vyXf
         UNDq0mRhZwXyT/2Wuojy983B06xlj63Pd1EB4NBCDXsnCGexGn01eU+ScHbgrN/Dg8Q5
         WuIAIdD3AMY7BExLk4SrbA0wRa54fvmPoYjHJXF55NTHDVCP2oJrLqFa5RI2a33psFjo
         fULGEbTt3xJ2r8DH/PdtrLHSxLoUEQ2SA4MYA6/3tV2pPfKuSOip8mktgr871vxljV7A
         nb8w==
X-Gm-Message-State: APuU4Z9YWtU4pvtPv03/oHhM6D9zMKKZPin5opWQnoG8o8UhqrZcrG8P
	Lowi+xMRZ97T5WN/tULioFRlNVEJ6VmQsm5x8N2QFGCfRHftdlr6FdiJmP93/kmx83XOip47joy
	6D4zF/oE+ge18lmA+YR+B7AItiA0QwVKKFLV5ZSJRIzSl7APmbUUHGc330XrJkAAPLDEB+n3Qle
	dNougm6so0FhE2ymUEoPvtJmm4O+MJoNjt2w==
X-Gm-Gg: AZFdTZcySa1KH4N7++7yRSgW1FO0fYWJSWfzYCbz4SRgutk6BGdzXuTjEnQGM4Qb3+v
	GarUwsVoP6l75bSUwDJAboNeonN/Xig71XJPbJc6x0k4D86hH7F0VyQJ5MzPMIWOv9b1PHoxvbH
	GPqchunffWXUh/B3q/+qZZXVKo+9PZwH6xf09Oxf96MXhjJB70R1Qk/fFyWXPt3w/tZJ5kdaPEa
	2+G/WY7DseDQ6PdfzERG6APG1wk4mGgmrRIlXxCKhduJxZefwjV0JCtDL9KZX3mnIDwB0V+ZhWC
	dVimBKMu3YngyGvFM7W2fEMRy1o+CWlFXEVuuhO6F4yO3kibNYf+jUqUay7zLSROp6M4mOiLK12
	GmcGwgRisrob9QAaNC7a9labbrfayoc3GG36vhDWAWzjUDw6tWoOrWAiZCOkKC1g3HSRFfXrz8D
	5JJfbqNZ1TyWw4grmCGHpULy6Z87wlr96onw3VO/Uaz3LjDyPsyyrxyIZTQcMcCgg32w6ULLlmh
	/I2MYw4gw8sa5AIceJHiPuY2usT9kpspES9wa88tF8Djhrd2QwZw/dN7an+F9AXWDOJwaFQ03Sy
	sqZ8AHJ1QeutCmzu61Y+HLN50CqVn3aTYrKU+8cKoHXxu5Cffs7CY7JHK6NcHwtB7PtYpz/Npu9
	eucfoS3+sm7LmhbT/W01um1IS92VJAy6gUiaVnYSrVWwB/BkPg5eHBSk8A9e3Wur3VtiIxSUCnK
	o/N55s1sLxAXHXkNSU
X-Received: by 2002:a05:6402:274d:b0:6ba:92c3:fef7 with SMTP id 4fb4d7f45d1cf-6ba92c4088cmr6219749a12.19.1795525558062;
        Tue, 24 Nov 2026 05:05:58 -0800 (PST)
Received: from [192.168.2.43] (cpe.ge-3-0-8-100.ryvnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba370cd368sm6790120a12.8.2026.11.24.05.05.57
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 05:05:57 -0800 (PST)
Message-ID: <198b84b7-20ba-4a14-b0dd-35bd83e1aabb@qtec.com>
Date: Tue, 24 Nov 2026 14:05:57 +0100
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
Content-Language: en-US
From: Daniel Lundberg Pedersen <dlp@qtec.com>
Subject: 5.10.y/5.15.y: Missing "nvmem: core: Check input parameter for NULL
 in nvmem_unregister()"
To: stable@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi

5.15.y is missing the commit: 8c751e0d9a52 ("nvmem: core: Check input parameter
for NULL in nvmem_unregister()") which is necessary for the commit: bcf4ef28b083
("mtd: core: Drop duplicate NULL checks around nvmem_unregister()") which has
been backported to 5.15.y.

Regards Daniel
