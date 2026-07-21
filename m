Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B8F1D7E5C
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 20:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784664985; cv=none; b=RxBPuKN3Tb7RXHR2IgjMvdpZLDMZfOBw5ukVvarlRhgYLpFoA9OHv856+FOVUO0X+1cPxPYBjVxUsHjVXozdckEtQ7A3xnVHtkgShO0XWHYmd9WsNUug/HV7BeegLfSOzelxxjrYxdkR/4ThmyTWrwpSNFcwQpQ7SrYJLpmN79A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784664985; c=relaxed/simple;
	bh=2nW/jag0OFDmdU0QuqvgLMi7C7DzkcAZdE9Mb2LmPvk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=XYPdXLeBFwVrFg6blo10CwPTqwuE5dOaecijvL0qp+AO2+0+JueKEem6zlRkhkt021IXO3ezv/i+J45y3qbl6FTvaV5w4fCzfp3G0B3KvuiLbh+RYfVif6PPIxCzT9kK/3nn+t7Z5xpgiWtkLGzbUqXxDD7A6uDZr0XEvqwqv+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQqQxuwP; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQqQxuwP"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-92e512a9a6bso757398485a.2
        for <stable@vger.kernel.org>; Tue, 21 Jul 2026 13:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784664983; x=1785269783; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Eq/I2Yx4I4ai7680JlcJEOI0mPA0NT1fgrQ0REFG2zw=;
        b=eQqQxuwP9YjTshJNKWyB/e7J6T3rL75d+RF8mD8euxJ7QOy7VC60ODx9l1QdaojeXa
         mZw7YLRjxotZqkAIujYyryIe4NPMuCrG97gu0YeiFF5jfQ0eF6hKc4LkATyN4aMp8X1L
         9f93pGJVrYUPK9de1qCBYHZZKX8TIn1iYts4STl8n1rOlqZlOds27XSeJwYt+PczOIcK
         gM1uRKh1APuVU7t66ajZpuYrIKlJ8JiKYxhGOXW59ZTeCuCxMgVles8os/ZimeMiJRBQ
         Xid/4BAA93RelRJ4w1zVnswCi07huzeHvmH2vVzeru1W/vQKoATHWvHLDqxRgofS+b+H
         AM0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784664983; x=1785269783;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Eq/I2Yx4I4ai7680JlcJEOI0mPA0NT1fgrQ0REFG2zw=;
        b=Sy1lBY2X0zC8cWGjsu9tYxryRD/6sxkmcmzovUtd89GIKRnEMsd7f/U75EZeLXCbmK
         VKmAJoAMqEwQnzpMiWAI+H+s1WVnBFDKiUhGPj3dcIXVoRptGHYZhlBkO/9awvRIgY1k
         4/O9aWsXBlCuUuUqlm/p9JvcOTpiCIaPqFjtMCspF2sW4jtQamq+qV/Ev5Q+WxlwiaYW
         R+JVjFPvs0LV0JjxSOVecnPatwdhTs8m7+luA5x+NDnhX2YpWrvNY8TrjCQDDq1b9f4F
         s2S63ARxQZN1OTk7su00+Lmy0nju2yJPpKjyPt8AxUeIoV/nO1+CnOyr6TNaNglZxh/l
         myxQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro7fwqWc0I0Cqt4JQsD83aCfxXrVldBUCLcVdDEqYR6P7C6lFEbxfLnsj67Gid01sdRnl1myPw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtm9v1Cw3ornnv0SlwFcfNQ1nf4Ob2MdujhpeRRwk3S/yLPVfk
	eki08zy+SxktF8Y9BMHEZEmtbEmrafFuUb2UObEz4XBlbFTKs+PK23o=
X-Gm-Gg: AfdE7ckwhE13JULqkT/GL7kjB6sx7KA7jI22eNV4Td4ndPB/PDqzdLEb2gIaIhgdCpy
	rBrO80hWLpn6WU6OLvQBHbFEiCZBRP9wYauhaqtjKVcQW6O5KSqOryUxCAyfff0/EcSgUOJ8/W8
	mEp4J5b3Atfu9K9HhaOCAsoX+pebzOOZ/5+FKWjyhszET9RoJeSeoYe14Rgycw6jzUzp7YWbNgV
	wRfQCQBDbVP1+bdYE7tAgeE0ZoYdlaaIGDfIqEMpBrJL8eHxdv1OvT3tQzW3aqLdYuBUsaAMcS+
	PsHe9J2DDPENV7Iu/cvFz8PHM4CPyau2xqJmteyhjGCHuEHHqLEP/hPlr19vAiRnJr771jY4WGs
	LCMPKATjypF1h0fhp6S/TmiTkWKfkUIMNWGa87bk8mLee7kQ9p/PGbF2U83MqVYuGWLP94Cwc1A
	I2YtuCcPjdRJtQzqrRR101I+6wGmpjJsCbn6LVK04O
X-Received: by 2002:a05:620a:d8e:b0:92e:f3ca:2ebc with SMTP id af79cd13be357-930b3ed6f01mr2150766185a.37.1784664982638;
        Tue, 21 Jul 2026 13:16:22 -0700 (PDT)
Received: from [120.7.1.23] (135-23-94-154.cpe.pppoe.ca. [135.23.94.154])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b542e60asm1223396085a.31.2026.07.21.13.16.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 13:16:22 -0700 (PDT)
Subject: Re: [PATCH 5.10 000/699] 5.10.261-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260721152355.667394603@linuxfoundation.org>
From: Woody Suwalski <terraluna977@gmail.com>
Message-ID: <eafe67c7-4e17-ce8c-1a93-e018074b6973@gmail.com>
Date: Tue, 21 Jul 2026 16:16:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101
 Firefox/140.0 SeaMonkey/2.53.24
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260721152355.667394603@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.261 release.
> There are 699 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 23 Jul 2026 15:23:00 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.261-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
>
>
Compiled OK for an i386 and runs OK on a 32-bit eeepc. No new problems 
noticed.

Tested-by: Woody Suwalski <terraluna977@gmail.com>

