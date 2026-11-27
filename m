Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795781615;
	b=1SMJdX1EzVSvTE8aUpBqWh/VsG6kDVrEwlJKYxhihBqMbDvOeH52EY0hO+2ntV8zQ40S
	 qERC4aDeIzMgeVxih6MDvU0ZwfCAOb5tzFK6Q/fIxglsvPRQqkH7cLfigN8VlV6LhjAn9
	 CJwI66epYjOHeBZnlLSnZn23POAZb6e0cmM/sRChdbJzozn7d8VC+pWWa//WONAIKnCGv
	 2QDXwoV+TwEPA3Gd8CU64KXtyf5N8M0a6WfeBvdI60pRhsFyuVaP6nzrgx7SBioVhSRMj
	 OLOBrOej6YiL3T8RXitYHcV/d9ol/AZkQ2fZ5+9haECID25XGShZEXi/zbbBCv0MI4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795781615;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=mjC6FgNIVsXbCg4Aumv/+ieJ0D89Y+p0kgQ3j3ncaCE=;
	b=KZjVH1hpII3T4q38KjCrUQwtN8XfFruw8pJiDjHeQjKdlYwE8o8VqB49MHU2Ij/cLJTT
	 SUUqMz1p6kuQIwJvcLhkIfOSf25qB+/fpB0zYT6kjLhSPhr8lsIq6rWalm2OO7WF4vkmN
	 KywbnY1BOQpMZ45UmzZdFujtYzu+gRFgtg40EnKzJogAA1uYv8LntsrzPP4FsUQWlAYbN
	 QIctV2lzxRbbdO4Z9QRTnOmGfwtZpn5JE0LJSgn5zYCg4kJ/V4Ey2c+MBi6BxvWR1vzVc
	 Cv4zE/4/jYlq/YCbkvJ4DVnHauaFzrLLbYGqHhZ/bS/JnhIf2zWnroD1bVwdJC+PrHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DDtrKGHS;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDB2606A31E
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 12:13:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEDB2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DDtrKGHS
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4a32576da88so4652417f8f.3
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 04:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795781613; x=1796386413; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mjC6FgNIVsXbCg4Aumv/+ieJ0D89Y+p0kgQ3j3ncaCE=;
        b=DDtrKGHS6tTqnBkHJtDIsUNqxeCUOPQ/MUtdxid6v4umieY7WgS+aDrpHFEFhI4hAN
         8rtrMSpbv7iUlW6Cw/nfs2AS+2WDcdfgVf6Sfoo+NsRs6IcgpJAMQmlYDmQpiZU/6vY7
         JRUzKJcWQs7X85oOPaYxkrjxE7nxhsvDWhchTTjkIGZ0j+DzBOH/Z4M+HMxq7fwTQzRJ
         KzFgThhPRBTlH+UUEJp14xU1zRYkR3ZX9YGzrauCGla7R+uvrW34OEnXamprJDgtsn1i
         EAAky3lnEuVWdjVIf7vfrmLXJTZETw6P5iKNpKAmfN+WRkT33Mnu/lqIsf/CsTBJda2W
         HXwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795781613; x=1796386413;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mjC6FgNIVsXbCg4Aumv/+ieJ0D89Y+p0kgQ3j3ncaCE=;
        b=HxD41mo+NOj9vFCpvZmAccaLB24pAXfhU3z0/fuZjRAv1giawLD7BvSNQc4gRFnay2
         M3Jf4cDmnOygzkPxcAYgSNUX1tN2Zzn/I+qxLOF+X2GTT5L5OC/I2MPQFxfQEOgKvPX4
         U+b13aa6nr2gJXxb1WKw18V5kyY/motS+XP/d6IQ//VuJG8GeRaL/Kn+cW7OwCu6Suzu
         HS7WB76NXNxrnfYU/PDDTEt8/XkB9kCPdz35KNkM860ewxw3HzKbMhVp6HVoqFTNejWA
         xmUV/bHmDkZTBCtvam+ydtES8Ad3oqyOytXWrQ3ytFODrH/CRa6V1kFsnIWjVduT/EJN
         +rsA==
X-Forwarded-Encrypted: i=1; AL+hErEVOpwofhgZZ/an5cyRy/QyPPxDs0pvJFCAkR/C99HLF3xLuJ4L/fPX2EljYy3Pe0OSmtT7T3Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z8c9UJJS1Is4HXzWAJ/x9p1obfQkzQY7gOMLryw24vucSIcHr6S
	FG03GMcnWA7XJkhZfoJEvRbUYp8PZNY8F7eZjo9QqrIdmPoRNJVwewmUu/9m1NlB1mo=
X-Gm-Gg: AZFdTZeDbU2H4r4Kp++AX2x/QOSxRN/HwfOCwlyF57hDP0z3O3tnGfo8+PDX9GPMqUX
	Vx08PW8hdWC71FtkaPOEFHRuGfl52O0+OaTlwMORI1V8N1POZCd98Nlb8lQOv1WejwsTlzaog3U
	pMgXWe54yIAUI98p9RW0HpWU5r5qbNHswg+rpslTGLdZcsas6u38WkgQ7/FBhZSH6F3AYdnNyPW
	pSsgJUWovOVBgN7imbbCNjf8KPhD6yhOQYCrjS473GUZs1AD+CXGv2dMiBRKCSNkhxoN4bw821E
	QrOCZ5wKBEcgLWtQocqZJWgHk7k5xNVQCrIRYkfI60+4Gy4CvZ60Lg2wKOuABuLWDkA9nGW3tgH
	6i1+q7u92R3aYptaOM/7YUwxBD+dysLecmGNUQpaN0o0WGVX9hjHtymmqyGXVOo7NuOSH8rxIC4
	YAxYbCLrW9P2ZhiSd8w7EjgSCMnzNnykO313SpqqyQ3szGXFzD0vYrOCyD4Wsob7GIvuho1tt7Z
	wHCUMwJYebzPEv7UinQC56kZafOV0chosevXLc2XJmbQRQROiK9gISeP753S5W2AJFBw2LRxsMb
	k+Hh3rox3ZkDJm2fThbbIBXDoGZqnSRCnCEZo7M2uL89dW72lTB4taJDQjMwkprLe1JkgFtyFC3
	J9q+gEmgw6Tw6xdPzZvLjZYsVALey
X-Received: by 2002:a5d:5c89:0:b0:4b8:6c3e:95e9 with SMTP id ffacd0b85a97d-4b86c3e97a1mr21394747f8f.28.1795781612726;
        Fri, 27 Nov 2026 04:13:32 -0800 (PST)
Received: from [192.168.68.89] (host-87-4-46-207.retail.telecomitalia.it. [87.4.46.207])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a680355sm38572390f8f.27.2026.11.27.04.13.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 04:13:32 -0800 (PST)
Message-ID: <9e86f015-0f0e-4897-80b2-9662b96a98f8@gmail.com>
Date: Fri, 27 Nov 2026 13:13:31 +0100
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
Subject: Re: [PATCH 6.18 000/990] 6.18.66-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Francesco Dolcini <francesco@dolcini.it>
Cc: sungbyeongchan <tjdqudcks0424@naver.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, stable@vger.kernel.org,
 patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261125143822.072087159@linuxfoundation.org>
 <20261126173920.GA180459@francesco-nb> <20261126174236.GA183126@francesco-nb>
 <2026112702-donator-rebuff-16b2@gregkh>
Content-Language: en-US
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
In-Reply-To: <2026112702-donator-rebuff-16b2@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/27/26 10:02, Greg Kroah-Hartman wrote:
> On Thu, Nov 26, 2026 at 06:42:36PM +0100, Francesco Dolcini wrote:
>> On Thu, Nov 26, 2026 at 06:39:33PM +0100, Francesco Dolcini wrote:
>>> +Nishanth, Vignesh, Michael and sungbyeongchan
>>>
>>> Hello Greg,
>>>
>>> On Wed, Nov 25, 2026 at 03:22:47PM +0100, Greg Kroah-Hartman wrote:
>>>> This is the start of the stable review cycle for the 6.18.66 release.
>>>> There are 990 patches in this series, all will be posted as a response
>>>> to this one.  If anyone has any issues with these being applied, please
>>>> let me know.
>>>
>>> Failure on various TI K3 boards (AM62, AM62P and AM69), during our CI/CD tests
>>>
>>> [  477.440292] rtc-ds1307 0-0032: write error -110
>>> [  478.374406] wm8904 1-001a: ASoC error (-110): at snd_soc_component_update_bits() on wm8904.1-001a for register: [0x00000043]
>>> [  478.464258] rtc-ds1307 0-0032: read error -110
>>> [  479.520264] rtc-ds1307 0-0032: write error -110
>>> [  480.342404] wm8904 1-001a: ASoC error (-110): at snd_soc_component_update_bits() on wm8904.1-001a for register: [0x0000005a]
>>> [  480.576282] rtc-ds1307 0-0032: read error -110
>>> [  481.600274] rtc-ds1307 0-0032: write error -110
>>> [  482.310409] wm8904 1-001a: ASoC error (-110): at snd_soc_component_update_bits() on wm8904.1-001a for register: [0x0000000e]
>>> [  482.624288] rtc-ds1307 0-0032: read error -110
>>> [  483.680291] rtc-ds1307 0-0032: write error -110
>>> [  484.278402] wm8904 1-001a: ASoC error (-110): at soc_component_read_no_lock() on wm8904.1-001a for register: [0x0000004a]
>>> [  484.320383] INFO: task kworker/1:5:66 blocked for more than 362 seconds.
>>> [  484.330368]       Not tainted 6.18.66-rc2-8.1-devel #1
>>> [  484.338741] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>>> [  484.350050] INFO: task weston-simple-e:783 blocked for more than 241 seconds.
>>> [  484.360452]       Not tainted 6.18.66-rc2-8.1-devel #1
>>>
>>> According to claude the issue is
>>>
>>> commit e498eb93f961 ("virtio_ring: use shadow flags when detaching split descriptors")
>>>
>>> and those commits should be dropped
>>>
>>>   e498eb93f961 ("virtio_ring: use shadow flags when detaching split descriptors") [22944d517ff8]
>>>   9dc6b944f16c ("virtio_ring: factor out split indirect detaching logic") [44b6e54e4a0a]
>>>   4b7bf8d55032 ("virtio_ring: code cleanup in detach_buf_split") [032159f85f3f]
>>>
>>> I am not able to do any test now or tomorrow, unfortunately. And the
>>> above analysis is just claude. Might be correct, might be wrong.
>>
>> 2 more cents on this, it seems that the issue is the communication with
>> the device manager. 
> 
> What do you mean by this?  What "device manager" and why does virtio
> have anything to do with that?
> 
> confused,
> 
> greg k-h
Hello Greg,

Reverting e498eb93f961 ("virtio_ring: use shadow flags when detaching
split descriptors") on top of 6.18.66-rc2 fixes the issue. The tree at
e498eb93f961 itself works fine, so it seems to break only in combination
with a later patch in the queue. Still investigating.

The "Device Manager" is TI firmware on an R5F core that serves Linux's
TI-SCI power/clock requests. Linux talks to it via remoteproc/rpmsg,
which runs on virtio_ring. With rc2 the rpmsg channels to it are never
created, and I2C transfers start timing out.

Kind regards,
Emanuele
