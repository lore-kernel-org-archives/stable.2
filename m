Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F140F47C0E1
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 17:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789406028; cv=none; b=tYCBCrSOFNps1Cpf+SnGrJWWNLAVv445MdQw6Xrd43hH4PHT7hy82LOZclei8lUEmBI24ogVIB56nL7fcYWIdcDbpXHYHDt8IE1stWO5fFuDf5qLN7Y1gpXuAqDdT3fVtFC7O70TqggvtEADjwsD22R8JeG30P81/BlAm9TRMfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789406028; c=relaxed/simple;
	bh=uLTJwvuhHJuRdXlB1C8pmGPIC2/l0e58nI7GsoLCsMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WJImzMT7vr7DhYZ3ZjuNgkQ5FQlrE6qEe8muH3RtX5HpojEtUDZEt7sTpm6eJA9P3kfof8sMTC+x78qmTXfTlDqgLrf9POBaLPdfllqAa2WOwu8eQXurX6rFZPd/Xf1Bnmo2Mu6hPug/SLdl01kEwsghqlLeMZtVwXOGdo4w9ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nc84pUQX; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nc84pUQX"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-861a2ae9c51so32136407b3.0
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 10:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789406026; x=1790010826; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ovEgINGmapqd39G2xDwqgD2EjPG8Mps/2I0DRD6EygU=;
        b=Nc84pUQXTCBvmG8TuYlKy9cP9R5q8sMN+ygEmfqCIw/5F4Dvc709PTAofOPxe+rRFx
         IZcylKrOoPm4Szlc8GwV/3sp++oiTgwH98v2jy+VOKf1dIR1WIDSxYx3zIWHQUZfLR1r
         SnnfE7IDp4DQltVebKfQGchmacxRPpVLttlXZvnxxIMOphJhIKpLi78p2L2e6BErfGT7
         tjwXpabW0kpr5moKngjSow6kWYeRWMD6eMnneyAjo3wjjmbRCraclqfonuFz899uUCJr
         WaGeLyQoCMkSX3priKG+VejsHg5d8OfTrvHPqV+JfMEt/kalBCyd4hutRcaLnzwW/zDp
         jEHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789406026; x=1790010826;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ovEgINGmapqd39G2xDwqgD2EjPG8Mps/2I0DRD6EygU=;
        b=SHLZWnPzua72uJ533poVwyUcREo9l+kiXEM7+SfiTqC1g+NhVDVO2FQ7RUjxr9k0+E
         mOEU60UIsIUY9GXUI152NwQ3ldKXSTRKgoW94ahJlXN7ljdCpw1Ez0a9WmFKTF4fBjAx
         QjYSpGgdcims4djciMTgkK8RAECGrs5v8nrGcSIQ/jSBj3oCwXGUqttZsCgv/HBC3JeB
         4o2bRwES3bgQ/SN2vo49hcLg74uZYe1HQVM4zNRkHMfjbg2Kls7A3ojrEpiCD/R5Apf/
         ypMyWo2W1sQgU7A62jB4zKEB2eTYfU8dxU7S2jyxQDcfysqkam97yjAcL8NKFE2Ngh/3
         J3MQ==
X-Forwarded-Encrypted: i=1; AKwUvBynuHtMlxCQcSPGoR2MuPydSVovgQ8dJ5fwjf7/hHennNW8/2lYFPsLjOPDnz2CARRvgLfTKs4=@vger.kernel.org
X-Gm-Message-State: AFuF++mjO62rhDf3hXM6ivZt3/sCVyI0oZZXkFgMh5n55tUN4QpTKb3F
	BFVa+TiRjBhdh1DsrmEyfomdI6vRfKbhFYoytH+k3vvDeVQZZcylhI6n
X-Gm-Gg: AYBFou3I+qYfrDVU2xMQ5dhLH2injMPZ1WtfD+FWIcg1hMdBd3wuX77Uzzkl9M8lTx/
	5DQE45bd5JhVZVH2KSh6sKKWasyAK2kFn8L8dvRuPocr2UNu2kGx716fHYnirgUcTIPgl7sKNRJ
	lflJbqr36trxftTGWI3veBBNosAa/0aghJzbL27fgxbeeNd5mQlDiqXPyKHN9e84z1eVagx7Slf
	GXMGOWqNKmhtK97cgec/uUVolC1EKpaOOVy0e5JkRoE5Evhjo0hldfr4zodAVbh8KRUZWKJwhrR
	kUbyvQrKXJ2dHubJ1oB9jK9C7ergOt5eZ+TsggpEpuzUz+ecIwaLTf1uKMDG9XA93N+5TNuJEii
	dMtxoI0w+q/gCz44odarWDMfq9MCx1ELL+3EoV05TdZU9JH78sOVxjweoJjBFuXSpW+Dt5i0l/8
	tlH7AEfEIk4RaoHMporofdbyRGnJvs3GQVdQE7TiGoF7HdBwVrAQteFxw7rENq2Oq6eLO9hxhTx
	0iD95nxmzY3/asOUjiu156Hug==
X-Received: by 2002:a05:690c:12:b0:873:5bb2:6c23 with SMTP id 00721157ae682-88d22ece335mr12117147b3.42.1789406025821;
        Mon, 14 Sep 2026 10:13:45 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8847db4476bsm39563067b3.5.2026.09.14.10.13.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2026 10:13:44 -0700 (PDT)
Message-ID: <72168bd0-27ce-4bf7-82a1-0d1719ddc15f@gmail.com>
Date: Mon, 14 Sep 2026 10:13:39 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 000/798] 5.10.270-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260912065516.948645775@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260912065516.948645775@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/11/26 23:53, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.270 release.
> There are 798 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 14 Sep 2026 06:54:17 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.270-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
