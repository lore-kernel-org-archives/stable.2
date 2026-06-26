Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CA719995E
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 21:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782508640; cv=none; b=UlVSollmmDdzWFHzRDK8UPWhyhhQgGHuF4OBQvoozq6AYx8JrL4nBbE/dEZMdmtaA1TEkSrdPHJe1X04I+ppmRWMSpoatGQhJSC+Q8duGSwrNc16RvoFxR31/A9Cz+VeulskH93ehI8KODMq17strhuNPjQSdJm3Zaj5ciZ6puw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782508640; c=relaxed/simple;
	bh=f8+P0j7bKuD7GBbgiceDtmS1hF48EPud963cenzQPP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KEJqyR4kHXBrboadOLuExQ+0XEMv5d9qXzTDRL1NNOWIkzJNpmVGt8OpbigktSxw3iCWIVaMkHgxtQWwCQ3Zikwf4+RQAZeLVCpJ8chC6Rvl5/Ydh6cOuSu3E3E1UYNUk5oJZnZE6yqvXk0VtL0Ykiclg/psCp6WzDXtQ9/kvRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CEpeZgKe; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEpeZgKe"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-30bf132969bso2206024eec.0
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 14:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782508637; x=1783113437; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5FYxptaek7EQM9lggJzimluJgqrrJTIoBQ9J0q20K0I=;
        b=CEpeZgKeSR2aBH0X+MO5XwWVEuOZzJi3F05ZRrbbbUowQdeHsLRTulTjSe2AoPfB0K
         d1CFP0BjwXfnN5macQPDgy7r3foUIuxF+Okuk7TNOAETwO8vYVvoQz/QiQ3e448fD1YE
         F6Uuzzr6maADTdbI3o/hMH+to/stmcbYxb6Vawwzs/5InoBZShQMV/VqrWp46MwEUNKS
         JFTDCTKXia5gRZhdZ572Ri4ihFY6CL5zjryr4gzeqWWZi3k9HlYpe2XUMBls1yKwqlTF
         jbD1KrSdZMfAQ+oaULE1kns/7i+ID4cw/k2JaHhiORlU1LlzIK2L4qi2zpGXoig8Y6gr
         BHHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782508637; x=1783113437;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5FYxptaek7EQM9lggJzimluJgqrrJTIoBQ9J0q20K0I=;
        b=In5fheZN65l1XQpP/Nf3u8Dw6iGRZUqpXzMFC0ziQyx2Y4bfAEhlOWIc8tSjJPAzaK
         zGBmK9aDvIXoN6IdBbLP7EfzBNljntnEfTd4bD2C5J37TWa8Y2mw3HMtGUvmt9oeaGew
         J1RdComREkPLrsKJzX+t3cWxo2D8oqUsREXmUyu0wWfaMT1uHIrBRjCn5t6hlDvAJgVH
         FBllt/B+HlBR8P/InrHkEUKuQPojH20CL6lXRt5YxKTI37PmEPmBWycUZNR5O9GwS9xR
         ffrXEMYv3s4WcGoXoRUp6/n70J/WsZ/3HypAXnH44p9PG20DLjyKIALcch4q4I8500zS
         EUzA==
X-Forwarded-Encrypted: i=1; AHgh+RqKVwsP/yZFVrv2hHCcqrVY5KkLtUyZckla7BV7332eOGPbKuTTjruCBW0lie/C8nZhoWDXIvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxALxtVQJLMEy/+xp1+ftS2zfNkEpcomVs3+WGh5j80UQZySqHW
	wNAnhtT3HjVQo1HAaPRQLx5hkkL3g8SXqIlIex+nGNEuhzGL0MYehQ7u
X-Gm-Gg: AfdE7clplRVPVPuwRxvvynaoD4D/XDf2vXYCdkxmhFw8DlJ6j5SUnD+Mp36hx3iURjG
	jVPBX/cEl+fqlE2i4bbCbuidAQDT/i7He+gDaB/hd+5CWtClZBS1wOQ33r7AAW40pMpgmB+obIq
	O+NqHYWTgTdUvl5b3tSyQjeiqbnNWPpxlfLiRk3iOtbygrsAdfhjJuDI77wYe6fbhm0XdKElbwR
	RwRA3P/uIDoan5/BPjy5+6GwsoWSZYpOfqqq3uEuyZkKi69n36TLSwtEDuRcY4F1GyDOtgDfKtT
	0Qw1w/Lzw+X4yV7VVd0nTRXt9rY1ZnxlKUM47nSOkCnyZuasp9NxV6ygiq9vowKyAjPo0O1tV6h
	lDtkDCVeyO7vU7DK4Z6e4WerTH1wToeyeEv7HxyH0CMpjNALJTpK2D4YANAGRlVy1FujTHbDzmo
	3nW1CKfOH8HUDPsudjSQJBLrioNC9ozlh11sZbjDToWZ2EBoq2OKr2ag==
X-Received: by 2002:a05:7300:760a:b0:30b:f0c6:12c8 with SMTP id 5a478bee46e88-30c84ba31edmr8054304eec.9.1782508637000;
        Fri, 26 Jun 2026 14:17:17 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:a474:bf4a:4966:8d97])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c8b1a80sm20444292eec.18.2026.06.26.14.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 14:17:16 -0700 (PDT)
Date: Fri, 26 Jun 2026 14:17:13 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	stable@vger.kernel.org, patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@nabladev.com, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de, 
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org, 
	sr@sladewatkins.com
Subject: Re: [PATCH 7.1 00/21] 7.1.2-rc1 review
Message-ID: <aj7r1Eqt2SEnWsMZ@google.com>
References: <20260625125613.243729608@linuxfoundation.org>
 <b7bd471b-e9da-4bfc-ad1d-24b378bd1e44@pobox.com>
 <aj7RmyBck8EkPn_s@google.com>
 <ab7df7bf-1b30-40c0-9463-a469abfa2bda@pobox.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab7df7bf-1b30-40c0-9463-a469abfa2bda@pobox.com>

On Fri, Jun 26, 2026 at 01:41:38PM -0700, Barry K. Nathan wrote:
> On 6/26/26 12:56 PM, Dmitry Torokhov wrote:
> > Hi Barry,
> > 
> > On Fri, Jun 26, 2026 at 10:56:21AM -0700, Barry K. Nathan wrote:
> > > (cc Dmitry Torokhov because this is related to two of your commits)
> > > 
> > > On 6/25/26 6:03 AM, Greg Kroah-Hartman wrote:
> > > > This is the start of the stable review cycle for the 7.1.2 release.
> > > > There are 21 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > > 
> > > > Responses should be made by Sat, 27 Jun 2026 12:54:50 +0000.
> > > > Anything received after that time might be too late.
> > > > 
> > > > The whole patch series can be found in one patch at:
> > > > 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.1.2-rc1.gz
> > > > or in the git tree and branch at:
> > > > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.1.y
> > > > and the diffstat can be found below.
> > > > 
> > > > thanks,
> > > > 
> > > > greg k-h
> > > > 
> > > Unfortunately, 7.1.2-rc1 breaks the Synaptics touchpad on my Lenovo
> > > ThinkPad T14 Gen 1 -- the pointer no longer moves when I touch the
> > > touchpad. Potentially relevant line from dmesg:
> > > 
> > > rmi4_f01 rmi4-00.fn01: found RMI device, manufacturer: Synaptics, product: TM3471-020, fw id: 3972349
> > > 
> > > > Dmitry Torokhov<dmitry.torokhov@gmail.com>
> > > >       Input: rmi4 - refactor register descriptor parsing
> > > > 
> > > > Dmitry Torokhov<dmitry.torokhov@gmail.com>
> > > >       Input: rmi4 - fix register descriptor address calculation
> > > > > Both of these patches seem bad in my testing. Either one, individually,
> > > causes the pointer to no longer move when I touch the touchpad. If I
> > > revert both of them, then my touchpad works again.
> > > 
> > > I have not yet tested 7.0.14-rc1 or 6.18.37-rc1. However, the problem
> > > also reproduces on current mainline as of this writing (commit
> > > 51cb1aa1250c36269474b8b6ca6b6319e170f5a5).
> > 
> > Could you please try applying this debug patch and send me dmesg?
> 
> Sure, I applied the patch on top of mainline, and the dmesg output is
> below.

Thank you! So I messed up and "Input: rmi4 - fix register descriptor
address calculation" is totally wrong.

Can you please revert it (keeping the debug patch) and try booting again
and if the touchpad still does not work post the dmesg again.

Thanks!

-- 
Dmitry
