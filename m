Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792432198;
	b=lltf819uhxTSJ8wAjh+4++HfPBgwD2eLYi17qd/4TzGpWc7UAFVNbH+H1RL7DwF7xEuX
	 TZbZxEBSS37o0IX4xmRzIoXYrSijPZ4bxM8XKMdy/2FI/Wf2/6WMbQwa2s/OSBOVB7mrD
	 midqBVGuDfsjXDciQGep2gnLWZUCw288VJ+DJY/hEjuDHO/LuQ5BcDc9qO5NNWQ+dCF61
	 cJxbe7Fll9S1pF6oNYgad3/YgB8N9MTmjCyYtz1WXHZImOsiIIe3DG+5MeLcDR2rNnR9X
	 E6FoMfdwUTsXq+CoTUzO+kZcAWYBC5gE6EnQVPWFXyfBqAbKeHF5GElNQMN8BAv4+KA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792432198;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=639/CBjTq+N5Owb6RBW7UK/oNchKs9KrTos6BTqd4Y0=;
	b=fA2uMvxGBmbxLrSHL5AhBqGw2Xe7t/YytEj6jfMf11PrDmCaO8dB5U6KG/LM3XV9OeSU
	 fy1qRoh2cV4ivy8ploGE0I+dtOeoDdqKcgFpdmtST10b3VUOSNUOC29HmsByXhqNgiWQs
	 8U+f2QDF/c5Y1W+l9zKC7cQ/biHAByO07Y/Wndlg5vZDKryNhRrVv45p/SqVtqQj0VV/E
	 /pK1TMeg3nBQVTCk8gX5qKJYNor9UKHu+zDSpahaklYnTTpZfBLGm/qpXfy+agROoK7GC
	 VfdE2e69I0R7xySg/0gsGq55burtWculdM+j+ZVYi6uEP2fw8dHS0oPoAOE0JMFgOGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TrpmEFI7;
	arc=none smtp.remote-ip=209.85.222.180
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2B4606A320
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 17:49:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A2B4606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TrpmEFI7
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-93f259cdc86so240954485a.3
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 10:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792432197; x=1793036997; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=639/CBjTq+N5Owb6RBW7UK/oNchKs9KrTos6BTqd4Y0=;
        b=TrpmEFI7tgmuxaiLFhOG1AfLDCzh9t38tdaNq4TC34QmZWpMMsIQhLwWy3Sh7ijCYx
         pzpvDD5z0Y69K9YZ35fk6nObTGwLtHSvnI6MbVCXdWKVcbDG5zdaWKWMLhC9rr/koPKK
         y4ZPae8rIOQWAY3VgxcGUftjggF5vUPeVVsPkoaC8TPxtSguw9get4ubsu/KYfBMBn6D
         Ll7UNzML1468VNpDI46hqB310SFY+K7icsuHYIPtj66PBlOIo5H3xk3qL2PHBQirAt9H
         2ZNYdYwBob2Z+jiH28e6HL/xN9qHQJ2DIl5BKOcB/gZaIx8duypZz54wIoGpVlgzPcTu
         4qwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792432197; x=1793036997;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=639/CBjTq+N5Owb6RBW7UK/oNchKs9KrTos6BTqd4Y0=;
        b=bL0hz1F/cLzUsiRcs7jO1EZEymWnqgyw1qzP2mh94xnRrm4MMZt44D55bx3R/M7xKZ
         3lMSDPRjvXTBT5coMRNUFqCthUXljSwXSu8wfWBI6vVYW5QVyhggEwUMVbntBPNbzERf
         SyD2344g4viX+QpKKdlA7YiIj7F2lFvKlgYlSUlfCpTX5OL7fuc5I/ytVFq70Pz4rqbC
         qGq2y6hbo2BwbcqbsG9ZpRHtf6sYPnBGvfn5f8gckfDgXDJIoGGD+Gb+Tmh2qGvnCRDY
         9lUBNKzIYx11zVW3Txzm0eUkMlRt9QmvQ+sUkP0yqZYtx7W/1XfetXzQGOdS0SMmFOZi
         yBAA==
X-Forwarded-Encrypted: i=1; AKwUvByZRAh/tw4Nwhc5/BMpL7WM8LZmsDiydDjNJPWxjiHYwLlozRS9WcwMh9LSG+lCgOiPLxeGv2s=@vger.kernel.org
X-Gm-Message-State: AFq9FYJqpw0c5SZ5VAGlSJda1m6+i2WGtFm06AA5tR8yiUpNX5Hlf8qT
	u5DRbmFYRCSpw9uz8JofCMoSpPTaPpEvYaLrpMymUaMG7f5apelT/DfR
X-Gm-Gg: AYBFou3tsjaYzmcMI5GCk5vO165Dq3iu7iR3/BIxODeb+iPBYWql0yfdFhbsqzNcdnF
	j8F21+xFTGy8w6Iiw3BHETDQ2cJVivkxgcjt+koh8k3bAwgjz1/owcFjp0sup/U9QVVKLPc1EZ0
	EEoHQYUxjKI9zsq5CR7eFjnmc128lOi270Nk5KHChMyIM935pMi4Cw43oLJk06/IcHwded9p0bG
	qcQOsAXRA5FnhLvnH0Jo5m9FHChAPnhGgAOFWoJkKH6hyzEsQC4GGXbee5ToiODlqXgE9dteNav
	d6OwXITH4dXz/NfhWm7NRlPIr7+Co++MU7STxCDGV6/+CqDjCEvCY7QpdpcH5HAWRjek79r+jwF
	nihg0OhBDvi4qufj52lPQjoz+0HvM+aoL7xH30tTa0PmaWnh1n0W3RZj7fijzmjNUk5S57fPp3h
	sE7f5srdsb1TGMf+V6xF1UOos1AzlCMRGchLA3ZIhLsN8Yx15+ugoFkT2u8U9Ir8qrHta6lcbek
	mJro3ear7z8XWFmSlDK869r
X-Received: by 2002:a05:620a:410a:b0:93e:c12c:f127 with SMTP id af79cd13be357-93f29db24f9mr1288869885a.83.1792432196991;
        Mon, 19 Oct 2026 10:49:56 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f4af465c2sm17387785a.4.2026.10.19.10.49.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2026 10:49:55 -0700 (PDT)
Message-ID: <41fd012e-e699-4165-8224-e0f65f4a4a8d@gmail.com>
Date: Mon, 19 Oct 2026 10:49:38 -0700
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
Subject: Re: [PATCH 6.12 000/869] 6.12.114-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20261017160036.979869304@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20261017160036.979869304@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/17/26 08:47, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.114 release.
> There are 869 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 19 Oct 2026 15:59:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.114-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

perf fails to build for ARM/ARM64/BMIPS_GENERIC with:

util/event.c: In function 'machine__resolve':
util/event.c:775:32: warning: implicit declaration of function 
'perf_env__get_cpu_topology'; did you mean 
'perf_env__read_cpu_topology_map'? [-Wimplicit-function-declaration]
   775 |                         topo = perf_env__get_cpu_topology(env, 
(struct perf_cpu){ al->cpu });
       |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~
       |                                perf_env__read_cpu_topology_map
util/event.c:775:30: warning: assignment to 'struct cpu_topology_map *' 
from 'int' makes pointer from integer without a cast [-Wint-conversion]
   775 |                         topo = perf_env__get_cpu_topology(env, 
(struct perf_cpu){ al->cpu });
       |                              ^

-- 
Florian
