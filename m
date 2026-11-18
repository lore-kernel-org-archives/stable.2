Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795030687;
	b=A0ZYSKT6PGlJqVKzzk7oKWEDGrD94dnv2QaOUhhzlQSRUJRbqr/FCT2sDgWCVHT8Q2MX
	 hW66XGlrG8JF6Rr2+tt7jaHMP8UJGJvxVBep8gu/9yMn0/Sqd6Fs/yU+E/0kvIyrL39QH
	 smpS3hDX84RAnCkb+EjfQpladXNf4kmIw7e7u8cCBOK1RgvNSsJso5yFLyapmGLiX0Nc4
	 DS0PYKHMJ/tR1POCBUvKzxoFAqajH9ifpPUIF/zY2jybowVTQfK/wOk06sFP2eGi0GozB
	 OtkxAnop/4zWuti1udxECFmO4GgJ+w7VwpfM9kEw2k5qLoPfCYO+D/8p+m+2Tjp4lIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795030687;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=c66EFlOJVYnnxUqxIZvQrJ/FVmfJ5lBMhar3bfkOCRs=;
	b=dY5pKYEWcgquHM925ep/Pdu0YiXbYukhrbtlc/qePl+KUEpmwJaUUgqtfSPBW8U8hx5/
	 ZxzezOBzbnX5zUQjNzAXUdnLDw3BhWVcrBhZwcXbukY7uGLJq8MShPMqcPQCY3v7wJ6rL
	 radS3A3U4r2a3yIKaEt0HVHXobscxKH7ixAjUSKTFSh3B1styEdC9GQ1nvshjLQ/KYf1Y
	 82Mef9IvxrHMvEFvAAcbKUqxtnGkVZxBTrF+oiAr5/to3mLQ33bAahFzxcxYzEIrCk7kO
	 TR/F3pO97IHJRU/B7w9Ztvc5p96rgh0RfA3VSw+F2dJCelQupMs9TooD8FrDvnjPhMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EnMdscv8;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43480606A7C6
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 19:38:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43480606A7C6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EnMdscv8
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1ae58d17cd9so1284805c88.1
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 11:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795030686; x=1795635486; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c66EFlOJVYnnxUqxIZvQrJ/FVmfJ5lBMhar3bfkOCRs=;
        b=EnMdscv8hwvfSOcoWdXoAholEjGvjRFy+uqBYbzeehG+zgiSKLV5jQBVF21THsEkbk
         JvBDKg3vb/cWyyVEBxuPq6NIgy4dU3fXi3Veqd4xNFeqFVpxxn0WrD2KdfkiHUX/l4gH
         8oEosYa8vmivrJsdKZva8DwajohPFW85WzgopMfivnR+xfdVz4rNsR1iv8Y+Pjfj0SBw
         zOk1fauefMci0WlQhzmxvxT5NgfPbdGAS+bYBAR66oH4rsmVaYci1wiPR0xRakLUj+x6
         u000t3LXlWBvXtAo5lbrK39CqhpOL5Ihy8d0CyCW9OmzfYjidAZwi5YkA1WeUHuUU+/Q
         QQ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795030686; x=1795635486;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c66EFlOJVYnnxUqxIZvQrJ/FVmfJ5lBMhar3bfkOCRs=;
        b=0CI4HPe7cj9ErkiQBeK57z4PG0MfJ/e9r5xvVBw0TUk3QTREf/yxACJNuJEdzygrzw
         JP+9YZjtBOwPUaFpgSHjZHv4YnAV3TLabdAGZJh4ohOPiPmuwgcV5vRDdnvh0I6PKLRm
         7K5A0Vd13HMF321viqYMwuAioWUyitTwZByf4huWNFmp33LMpoV355YNV0iNl2R53Myd
         ZmtwXdS5tXCeJtki8dSCibIeuW2uvFgcYf4PPUFXXkDX8ZLBDbAB5thmSE59AKEmAzmN
         0Zft4g+QYWoSAS6iLjIq5hit6xkTtm8KjKKdkMKt7zXeCwslnOex2e9wU8WD+BqRpgob
         VExQ==
X-Forwarded-Encrypted: i=1; AL+hErEKR4pOpnIeCNyg2V6giqU5rfaFeEL0+c9mklwzgKqOGkPd8134OZI2JhU+FqthJ9dGmABEb3Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z/U6ENlX3LG3IlV7WsyxFoGTiBqKkrGKuf+XLw1OvGtx8wbwtSe
	oGtdKaUzhyfRuS15osCSW0iCAqCwP+x1gxv49K50t4nx/1rZENeu2vB4
X-Gm-Gg: AYBFou1uSPus6tFcY9SS/DBVVAD5Te1WZNzlNSBrs9eJUgpYuSO0QTGZjHVzIIzRJY5
	kiTHZTIc/2azfFOAAQerim88q4HBYZJYB6ermupPsUZzkq6Ml6+6R/Gd+REWpl4LZMoiN1UzvRg
	nnPrLuWV0DboGrwn3HSyvta5u4aAKE5lh1y3JKLSwuxlAtHbTYUFgkLBTbGjVcSaNwZzt+hYAn7
	0cDM1x08TgUuZnUbvz4w5RxRy6M34cB8t2VeRZz9R72KMxmyFS1CQy7CzpQndDjL1ONZZMsE4t3
	ehz7tjO0ZA8koZIMkH5fr8RVGxFLmbJIm9DgKBOdCQlXH8wdReOmhmiF0t2L+fE0hleNA7q4bRX
	mzYbCWGqmRkHWM60wuIHrokgj0sF0bXvyr/Iw1qD4RsYldo377jk5mgBf/zDkl4Ga/chEPgRxXu
	Vz1eepoPcog+TnWtxIfYUy67DLkStWxVOpk2G3BQTsb3j8tc9bVS6rgZlE73cyfQ8H5CB9/8DEn
	tQjZ4o1XZUakOm3EocBSAGhD8SJSQOu7Gg9fd7373hZLE5gLKjF4HU9dlHzZ8O7cr2sWOMbg/tB
	JLwi+zJB8Nx9zIMisuf4sCSltlvzfkCrM2+Klh+/F24VYhkxCuJgpEiI
X-Received: by 2002:a05:7022:7f15:b0:1b2:3448:840f with SMTP id a92af1059eb24-1b543cb4093mr3136249c88.7.1795030686140;
        Wed, 18 Nov 2026 11:38:06 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b544784017sm8261719c88.4.2026.11.18.11.38.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 11:38:05 -0800 (PST)
Message-ID: <9bf135b3-455f-4463-bf6a-b80faa2e4606@gmail.com>
Date: Wed, 18 Nov 2026 11:38:03 -0800
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
Subject: Re: [PATCH 6.6 0000/3318] 6.6.163-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20261118150313.527275416@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20261118150313.527275416@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/18/26 06:10, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.163 release.
> There are 3318 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 20 Nov 2026 14:55:42 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.163-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Same perf build failure as with 5.15 and 6.1:

/local/users/fainelli/buildroot/output/arm/host/bin/arm-linux-ld: 
warning: 
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/arch/perf-in.o: 
requires executable stack (because the .note.GNU-stack section is 
executable)
   LINK 
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/perf
/local/stbopt_p/toolchains_303/stbgcc-12.4-2.0/bin/../lib/gcc/arm-unknown-linux-gnueabihf/12.4.0/../../../../arm-unknown-linux-gnueabihf/bin/ld: 
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/perf-in.o: 
in function `test_truncated_branch_stack':
sample-parsing.c:(.text+0xaa774): undefined reference to 
`__evsel__parse_sample'
/local/stbopt_p/toolchains_303/stbgcc-12.4-2.0/bin/../lib/gcc/arm-unknown-linux-gnueabihf/12.4.0/../../../../arm-unknown-linux-gnueabihf/bin/ld: 
sample-parsing.c:(.text+0xaa784): undefined reference to `perf_sample__exit'
/local/stbopt_p/toolchains_303/stbgcc-12.4-2.0/bin/../lib/gcc/arm-unknown-linux-gnueabihf/12.4.0/../../../../arm-unknown-linux-gnueabihf/bin/ld: 
sample-parsing.c:(.text+0xaa78c): undefined reference to `evsel__put'
/local/stbopt_p/toolchains_303/stbgcc-12.4-2.0/bin/../lib/gcc/arm-unknown-linux-gnueabihf/12.4.0/../../../../arm-unknown-linux-gnueabihf/bin/ld: 
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/perf-in.o: 
in function `test_truncated_swapped_raw':
sample-parsing.c:(.text+0xaa93c): undefined reference to 
`__evsel__parse_sample'
/local/stbopt_p/toolchains_303/stbgcc-12.4-2.0/bin/../lib/gcc/arm-unknown-linux-gnueabihf/12.4.0/../../../../arm-unknown-linux-gnueabihf/bin/ld: 
sample-parsing.c:(.text+0xaa94c): undefined reference to `perf_sample__exit'
/local/stbopt_p/toolchains_303/stbgcc-12.4-2.0/bin/../lib/gcc/arm-unknown-linux-gnueabihf/12.4.0/../../../../arm-unknown-linux-gnueabihf/bin/ld: 
sample-parsing.c:(.text+0xaa954): undefined reference to `evsel__put'
/local/stbopt_p/toolchains_303/stbgcc-12.4-2.0/bin/../lib/gcc/arm-unknown-linux-gnueabihf/12.4.0/../../../../arm-unknown-linux-gnueabihf/bin/ld: 
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/perf-in.o: 
in function `test__kallsyms_fixup_end':
symbols.c:(.text+0xc189c): undefined reference to `dso__symbols'
/local/stbopt_p/toolchains_303/stbgcc-12.4-2.0/bin/../lib/gcc/arm-unknown-linux-gnueabihf/12.4.0/../../../../arm-unknown-linux-gnueabihf/bin/ld: 
symbols.c:(.text+0xc18b4): undefined reference to `dso__symbols'
collect2: error: ld returned 1 exit status
make[4]: *** [Makefile.perf:697: 
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/perf] 
Error 1
make[3]: *** [Makefile.perf:267: sub-make] Error 2
make[2]: *** [Makefile:70: all] Error 2
make[1]: *** [package/pkg-generic.mk:286: 
/local/users/fainelli/buildroot/output/arm/build/linux-tools/.stamp_built] 
Error 2
make: *** [Makefile:29: _all] Error 2

-- 
Florian
