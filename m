Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793297804;
	b=nn1CyPWg6P/I8FuY+n04znuZ4g9Z5g75sBQ4R2CLZ6vzhYGUZaV971e1TAYB4+WRbhFx
	 BGf2utqNGsVCI0+pVntVou7irtk4vHCh4Oy0Js8MSBB4p7GWKi+dsJfY91Hv8F6dyD1sC
	 PUyeNiJ54PZyqZn0sP9BcNGoiIjhs4EYZr8qBykgNm4zHJLKRLjj8SktRwc2joOjIVRB1
	 a0T/zfWMsSxuMgdEdAb5SY10ycs8HaYc3v1COeuXarvwm1Uxje+O//Jb0S6zFKDkZqBy/
	 UMqKy/hUowOWb9XAXQFw6INhjvgFw+QpzxKAXtkrERBprppBjrUk2iWxsJtBMGQeeRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793297804;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=99z/FjcazCZQi4D66B/SibaBChuRIkU7h/mfNRp/Qdw=;
	b=s7vVjxml4A3c5DHg+vTobvgpR7xhmbnZE/YE1MH+GG9XJPHMM0azd94rsRgUUBIGoI0+
	 nHqUdsUCcMiK0o0Hv+cNTAyOaRpIQmKanidsmrp/g6MNx3fDeWASN+NppdA5kwSXmlncD
	 k5J3dEvFHsdzsCxGW3GlhMppxUSyHcyARU234dLcq631iDuRrNqtyvu0TFXOTXzMaxQWn
	 hNqxlw5USdDej0l36jqf64xxS3RA4bshd5PbVJ8QtI8RLepmUMxVCCVXkpJOt52L7PkfH
	 GVeV2VZA3eSyOBprWlaakTDCynxUO/4SXkWFOuIDtg3mhF21GUa4TkIK+ME27Atn4cQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VrYzhrJ0;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F27F60A380A
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 18:16:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F27F60A380A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VrYzhrJ0
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cc4aa0246b7so1348916a12.3
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 11:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793297804; x=1793902604; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=99z/FjcazCZQi4D66B/SibaBChuRIkU7h/mfNRp/Qdw=;
        b=VrYzhrJ0pOifKYg/rQ42XohWgLtymI0J3+G2RhlXh7enIkiCM6k7YxfLvUBxT7AnDZ
         aAPpwAHi8PRDK4jJozJOfvwofoG3X4IFvMZHHrsSRva2sviTsNi4nvGHGb14LuJhjlGN
         nfvsdfYg6TvM1P7i244m9nQ4PyiQ68Yt/WYK7WAROj36PqO/CMeHsDSyFofgiaUXy40J
         jJcewKtkafTVl5kD1Z7s5qSzV926t3bMmiAmjJB00M/rhCFwA+onIKZVT6/H5Iw1saXl
         lJGTT0E3DXKvbnu5N6WSDS8TUcfFEHJFYvc7D6zfWvkCCxFQkaaeSROIP3htdPQWJAUt
         6K2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793297804; x=1793902604;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=99z/FjcazCZQi4D66B/SibaBChuRIkU7h/mfNRp/Qdw=;
        b=YYVUUKfFUNOeuOZB1iJkEBqW0tTZbAMaCsnIzycncp6zvIZrlUAREWU2f+Vdl1sA0v
         QhJPbe0lfE0AZpxLDtaEmOvvMXL22y87G/fDHqKTZj1otdh990205pe8aRicIZ9rduRT
         IPTOzw7iK2YtvDLFfAnZct+ZX0Gg+Tg889ep+2olZLBFBjmOUb6iRFgLYASK0hxi4vsx
         1ukYoPN80amjnZbwrvWRlBc6WSLScCwv31LzvfDwU26u4ZK5/ip3n+frR03ZwDxWFfwc
         mdb9GYZIDCGQeBtiWJ70texJ7HuZxkjGZsBFU3oiTa8/RD7Bcr8stAmnBkO6H7XDxq/n
         PRoA==
X-Forwarded-Encrypted: i=1; AKwUvBxvCmrmAJnEdMKrt/skcir90SeIoCuU5ukNXQRLD5tHQ3PJdqj+rtsbDGG/lHwv3MqR7d6dLmI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJqko+q+z80ws28++Bx8WMJQ3t7k96wpwinOgk3GQ95gNSM47M7
	HVATO6ldMukJ18W3g123nyp01TaSY/EFCG+NDHejFePLhE6eoj0RzmDW
X-Gm-Gg: AYBFou1DnG1RhTj5CHcyRpphHgw4DGEFpNCGZAunhJcIoHNIBBNCBX5ocd47+z6ImEo
	nZX6BoX+jYNmiHqAAL8sp6IkcVr8Dtnc1lkNKRnOcZTe4MlhyhuITxT1RTDXnhqa4bCS5/8c2Xi
	3zF7I4OylbhBuB82Qo0oAeWZo9ii/QjZhNyo9KyIB8pYOBqZOX01aTskc+REFdKQsVKmg06jFSK
	/dle5FUN+GhZUkwaNnRhYv45ghklS/ELY8kqDZdnHb/Av4Uh1ZBwrgZJSSibz6QFMJ/31goF5XU
	i80MnGAErWJhAR7tWvPb7nX6jRqzvTJ0Ky4vehTKVsr/TxEqHxlbteoovb6WUa+5Yh7fQKyzywP
	DoDvnqYeBOJFpXMIPxMp3pHKusfFDJsvkdIBmZFOEmKu+H+/TFwrcXKU55uLdNwOdbJ8dbl53i4
	Z2LMWmKBYGsqbqT+gU0P1Bb0ktfUoJ9vev58RAZU1ZwOUmkfEPh0VzufNLDpgoDn1VL52WTr3iQ
	OD7FDGyaYk6nrR94k3BHWXHPJYymy15YCBfxPrtKAbNBGL6QeBBGN4B4GA/7ndc1hY4QHQF0Qtw
	1DzfkVvgQYLgDvWJPFuzd+lL3SodZPo5lDAV5qgzpui/ZkbyGmKVpqBW
X-Received: by 2002:a05:6300:8044:b0:3de:5302:e92a with SMTP id adf61e73a8af0-3e928953719mr74781637.17.1793297803762;
        Thu, 29 Oct 2026 11:16:43 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a98a0bd09fsm192069b3a.51.2026.10.29.11.16.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 11:16:43 -0700 (PDT)
Message-ID: <654c7978-3771-4c09-89f8-c5d23bba42de@gmail.com>
Date: Thu, 29 Oct 2026 11:16:41 -0700
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
Subject: Re: [PATCH 6.1 0000/1879] 6.1.191-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20261029073135.159947193@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20261029073135.159947193@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/29/26 00:33, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.191 release.
> There are 1879 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 31 Oct 2026 07:28:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.191-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

There is a problem with the SCMI fixes that have been back ported: 
scmi_device_request_notifier()'s REQUEST/UNREQUEST cases are empty and 
scmi_probe() never calls scmi_device_create() for DT protocol nodes, so 
no SCMI protocol devices get created and clock consumers defer forever.

We are missing ee5dcedaf72d ("firmware: arm_scmi: Introduce a new 
lifecycle for protocol devices"), with that one cherry picking cleanly, 
the boards work as expected.

Thanks!
-- 
Florian
