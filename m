Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E5748094D
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 17:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789407530; cv=none; b=YmJ/QIBR463CvQuDUccr/EewtnRYCYyP9SzLUCMPPqPxmihm/Jh++3vsid6AaZp1KidhnoKCjIQtyD4kP+DhOnr+xFIDIt8jRfBMqZYepSuA55XZhTFA05g0pg1A/ISTTjW5+M00k6nSqiX1VNRKUZIxJhVMh/AjSg8/zbR5ydw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789407530; c=relaxed/simple;
	bh=SbuWO6K3oJD2LhlEEwqlQxpEpDLEqVohKRUVF6OSZS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uXAouJg+De5fQ6KPDD6LB1iNa+Hec2mx+b7w/qaFF3gKtoMOwtwDwJx7CYR0R06RGAvntnNuNonmI7UVhdyvcLQN8dKJjtwQZxyPpzGkmV4ovHyZTTZCoFNkWsOJI0a0meejjk9lrJngmgZY/Sl80ZVd1RycQTCU6nSmGGLrWz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UVaP0o5V; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVaP0o5V"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469d249c6so2341314b3a.1
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 10:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789407529; x=1790012329; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rnT0qav7UwFgOqf+kbm0vIaYG2Z1UVdPy7kC+ivpDo0=;
        b=UVaP0o5V5+ztgTGfG8oqqA7zASZFarfqskHoqB37SH21G1JU1cystmhZmKCDP/X7Ao
         c0TudD1UGgB+Fn7zEbN5eDDPoAOLLBvGZyIpI6yc3QOBAKIKNJ3HkqEzTQ5E+DazWHR/
         ndtnUe50+BjFqwnvZYdw7P9Xpq96O2MdpX1jKN0n6fXjURhyKgKFjG8YS59T3a32dmP3
         iv2osSu9ODma1Tf7aKtBXATvJZfxC29GPBvHhMDmVHlGCcplpGccWB1zxJdGZoBgdwHG
         wtq5dEDCKCSX79Hv35wsINUfTlpmFgZmQeAsQ25tH9CjhJvbtQJPoP+Vi9cFV10qcSRR
         7egg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789407529; x=1790012329;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rnT0qav7UwFgOqf+kbm0vIaYG2Z1UVdPy7kC+ivpDo0=;
        b=PuzK2GSqHesX7rLOZj+ygFQsIQOeHp+tR180Dpotx5B4OaJ4pzChbwc+lcFBznll5x
         eqUbwS1PlDb3Bsq0mRL0/c+Cbe3SzW8VWxh03CymGD70Wina3TyC0jBUymGnUZJr43Xp
         A2jgyr019lx4GdeQWeM+tgmwuxb6R6I/FnmudcK/Dy2ZlK7WZ0DVsa9KZZlrmnC6//jb
         zB3ThCBHlYbWv/bvObnVpNcbI4VuRbyeKPz3tRnwwm5WdESaTHZhZN5dDBOBFneQyTnC
         2bA9bTDrr0Z17pOLixDSwwnTqUoyHYIZwqNdkmr5hpDTPcAdqRShJuVGiRar9S+jKd1/
         NLuw==
X-Forwarded-Encrypted: i=1; AKwUvBy8WI3KCerLOe0nqdH4SaFXdwTllYpHSQFxxFZW+ZMb9krVHMxkIFDLF3JYAlUHqESEUYhWG5I=@vger.kernel.org
X-Gm-Message-State: AFuF++n+uE2SbtQEj5TbBGH786rnbU87pP2BkDmEQhPBdYtyDoVnSvBu
	5MppQWftFjPXifSiPjtzaHLZyJf1QPJW4mR7SH30xEe/tLuwkOG8fjkEOU5d8w==
X-Gm-Gg: AYBFou1z5Rf98ndLdzMhsF4num/yewhEQ13a4w6ihYKdMYm3mfIpdp3iLD9ANQykP+1
	7MC4LdkwbAKuwfNwgL55fspNMqwWLdr2r484yekVy/79+uEiNvmW9nD+zaOw1zDH8YFgbSJLYS8
	Fo5/IZvUPkqVhFS4xEcP278uM+YHBsrcP02A0Gk7PwAFAglpMeOu/XeOgwEQHcPF1HtUMtcyFhb
	kCJdZG+Tkltv6Ptb0tCAJZueSExtgaOFmgFHOo+DcHPgJ1zEeQD6THo61TFxGLQotPtD908+vnY
	xlNHdS0MS8+SPoxosdP9Hy/3HTKy0w8S0DBRgGcZpYoRqqBOdLFUQe6OWMDqPZAChuznlqF0MXv
	2yXnY/bVDhjXavXrPjOBgqliMFdE4xOXGsOgbb7M4lMUDGjHHPLkdO9fuyBUTY/9gujVbBNlxBE
	5pqMdoH5QSBWcf4OmuwvZMi35sBfwQzbA9Uf5+0b11VGAgyrGWmWZd5YjSzKhLf2tC3We3M56A/
	Gae/dF0cGgJrZnCQ2XCzZhO3A==
X-Received: by 2002:a05:6a00:1791:b0:86b:43f6:67b7 with SMTP id d2e1a72fcca58-86f82e5c9admr6736506b3a.4.1789407528681;
        Mon, 14 Sep 2026 10:38:48 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86b2a1b827esm5006038b3a.51.2026.09.14.10.38.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2026 10:38:48 -0700 (PDT)
Message-ID: <64dd0faa-fdfa-45a4-812f-638574beca26@gmail.com>
Date: Mon, 14 Sep 2026 10:38:45 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 0000/1191] 6.1.188-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260912065548.086904252@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260912065548.086904252@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/11/26 23:45, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.188 release.
> There are 1191 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 14 Sep 2026 06:54:17 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.188-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

perf fails to build on arm/arm64/bmips with:

   CC 
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/util/zlib.o
util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c:14:10: fatal error: 
linux/unaligned.h: No such file or directory
    14 | #include <linux/unaligned.h>
       |          ^~~~~~~~~~~~~~~~~~~
compilation terminated.
   CC 
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/util/lzma.o
make[7]: *** 
[/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/build/Makefile.build:97: 
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.o] 
Error 1
   CC 
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/util/cap.o
   CC 
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/util/demangle-ocaml.o
make[6]: *** 
[/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/build/Makefile.build:143: 
hisi-ptt-decoder] Error 2
make[6]: *** Waiting for unfinished jobs....
In file included from util/hisi-ptt.c:24:
util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.h:13:10: fatal error: 
linux/bitfield.h: No such file or directory
    13 | #include <linux/bitfield.h>
       |          ^~~~~~~~~~~~~~~~~~
compilation terminated.

this is due to 6c4b82b50c46842683a3a39e1bc8291581e8b1cb ("perf hisi-ptt: 
Fix PTT trace TLP header parsing")
-- 
Florian
