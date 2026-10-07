Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41881EE7C6
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 06:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791352873; cv=none; b=VqpHIQR9BY1FLeKUKwLnqKrn2FJ3zcyA8qb2H1cE3HuiKHTPFGMlFlEJock8QOdGcLD/QVrLHDy4lFoZKAeZCas+mrerHJVBFq9t2FCW+Y9oX2NOxTu68vxWCy7zCaQUDrMsgFby6YR6SPJRTzAXovV8ZBOu1mDmD5e02pwF9P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791352873; c=relaxed/simple;
	bh=44gmmM9oEH5/TVerkgLJ1mXkmCq7t1aLZaAtaClW8/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gWCu6cWrpEkIh9NkF5ehrVkLn5Kbi7nwK7iDCH4JO1cAqN+9XDLrNRPKpMF44J8Jlc1SvaSN53+gcrpn5X2aS+393/vO+O43D/RS6gpi0qQg/6TGI+6To8exoKGv+0d4d8DFbzdsnViaMsRfA2trRWZJcYJJxH/+3j5OlGnc4Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DDSCJQVt; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDSCJQVt"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-533972e0cccso12827771cf.0
        for <stable@vger.kernel.org>; Tue, 06 Oct 2026 23:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791352871; x=1791957671; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Nfq/HGRukfZcQBpC30XOdveBT0IdwDENsOU1DxIVVJg=;
        b=DDSCJQVthpfjYG7ohZTHgwatt6RJFFXnzT9IbzUVqRo35PU8MwwLDGmSnwE/fZLu4A
         wsmNkpHIw13cwsFMBdphj0BIJaxeevcB/zvRHQsqsHOjkYFdrOIF8HszH6rra05o2cp/
         Er0fx3n+PiMYW1SjCAdWuqb0Vyol6BemtAMc6ia656tXKXuZchvCJgLYYYjHH4lnRGeJ
         yTmK3HJSQA2WuPFeyJ85MNGDaZt4FGKbLqS+/ghBEBj08EVfJk27N7mC0PTwN32iyR/i
         itgkxdPtkMP4v3yihLwAxchVLb5lRc7fKtIoXONkkPDwxWe+IHNoNb1GB3MhhC/PLGAS
         Ds3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791352871; x=1791957671;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nfq/HGRukfZcQBpC30XOdveBT0IdwDENsOU1DxIVVJg=;
        b=zSTKjFWiTkfAkeUa0zBCGFd16i3uYPPfz+k7wPUv0nJS7CFLp5Cjfz7nSn7YoifK8L
         PBQX8tTfUkpAD53IBUfOQzMH461nbpkWEc14g14NVtdmEGm/AqNG3kRnYoIrS6EtR4xk
         SC4R4HG4DguOdQyPWqBldwdgE/v4+0gvFkTIp4PxdBMgov4Gs/hqE7DKqHfAYChbuQ8V
         dRC3r5ZXzL6OeGPv+3H3NZMKJeO5QDueZvUM6GUZlylGWuaya8ZBbZ7rODmm7ebAA7jQ
         3aopNAtU+VwJSR3qBzHaO5IsqzGU+ne5Iaz7TWLjdYbouXD3fzBrQ2/ZyaFCsaaOXy0Y
         QAgw==
X-Forwarded-Encrypted: i=1; AKwUvBw5pQgx0SIw+xrEbKRCuh7oxDnwKiCEPUTcO5tkbq2XlwLDR1vNPeVxyRjXcyrUlfOngsaW+GQ=@vger.kernel.org
X-Gm-Message-State: AFuF++llumSTMbLiZ5MRy7V5eB/snq7q8s7YbFnIvdAAI+Ar9qD1JL+h
	JRy/MMo9kmEoMp3beYJwDDguMglV5hMvDzuR9j0lwFNDpH/izdVzyDfF
X-Gm-Gg: AYBFou0K/iXDFTDiY86Njk+IGcL1dwXzZJwmhQDUq+F9EmYjztzWF76g49r3hLrVvec
	hf4fR0ZUawdxGCWgPpL7oKk8Wzh9/HP277mIOpZKuZn8fVpf/UQMU6/PpHVIncqWefWJ5DFtzw0
	Tp2rPmh+DCHGBwA1JMrGOf8vGp6g4Qa058OGuA0yK8Nb/JvCXneWTvDp3yA3Z5Wkp+YPryL/K0S
	X+dg/eSvejWx6+j4Ku4k2X+W+GKUjLZxIxs/XXRYI/16ozKouSAsUJHqk9G+F6wArO9ExVRTq2i
	HRePMUoLIEMNRHlllYF+P7aHKNU6EZureTJTJs9Hu96JXJiFh53pycKY839/zpOl2vcAo+hEuiV
	h2Br6KePjsGuowEjPOC1y9I6XdZh6EtVPoR4NxxgRiAWwwVMZouahnLQHb8KHO4Bk1B8UAxgS1F
	wWXz5B+lThMnKdFg3RqQ5F62bZDWPkYyrFn9eXD/25FEORPJ1SeANUe85bGb8Js9GOfFHrLvWJR
	O6fv2C4aANln4gAOplLfDSS2Itp0qY/AN3/dnoVG50+q1hXfXg1/2oUoFUti2S9Kg/G5YG+xhIc
	K6+05EHlSKNV3rbPnejoJqucfR7gtPo=
X-Received: by 2002:a05:622a:4d44:b0:535:1241:965f with SMTP id d75a77b69052e-535756ac39bmr20079451cf.40.1791352870621;
        Tue, 06 Oct 2026 23:01:10 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f23:8600:d56a:6e66:bc:e98e? (p200300ea8f238600d56a6e6600bce98e.dip0.t-ipconnect.de. [2003:ea:8f23:8600:d56a:6e66:bc:e98e])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5357217327asm12835161cf.22.2026.10.06.23.01.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2026 23:01:10 -0700 (PDT)
Message-ID: <9777c133-0d46-4efe-88d7-8a519f38b0f8@gmail.com>
Date: Wed, 7 Oct 2026 08:01:06 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1 1/1] r8169: disable EEE on RTL8168h/8111h
To: Dennis Piecha <d.piecha@ymail.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 "patchwork-bot+netdevbpf@kernel.org" <patchwork-bot+netdevbpf@kernel.org>
Cc: "andrew@lunn.ch" <andrew@lunn.ch>,
 "nic_swsd@realtek.com" <nic_swsd@realtek.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@kernel.org" <edumazet@kernel.org>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20260925071040.2137178-1-o.rempel@pengutronix.de>
 <179081461327.2189941.5041238879527277665.git-patchwork-notify@kernel.org>
 <503211732.1051249.1791285565321@mail.yahoo.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <503211732.1051249.1791285565321@mail.yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06.10.2026 13:19, Dennis Piecha wrote:
> Hi Oleksij,
> 
> I tested this on the affected machine with a Home Assistant OS test
> build that includes the patch (kernel 6.18.54-haos).
> 
> Hardware: Intel NUC11ATKPE, RTL8168h/8111h (XID 541), FRITZ!Box 6690
> as link partner, no VLANs.
> 
> With the patch the NIC reports EEE as not supported and the RX stall
> is gone: more than 4 hours without a single drop, everything on
> defaults, no workaround. Before, on 6.18.52 without the patch, it
> stalled every 7-20 minutes.
> 

I'm pretty sure that EEE was active for this chip version in earlier times.
Are you sure it's not an issue on the link partner side? Did you test with a
switch between your system and the FRITZ!Box?

> Since 6.18.y stable is affected (that's where the PHY EEE fix was
> backported), it would be great to see this there too.
> 
> Tested-by: Dennis Piecha <d.piecha@ymail.com>
> 
> Thanks for the fix!
> Dennis
> 
> 
> 
> 
> 
> 
> Am Donnerstag, 1. Oktober 2026 um 02:30:16 MESZ hat <patchwork-bot+netdevbpf@kernel.org> Folgendes geschrieben: 
> 
> 
> 
> 
> 
> Hello:
> 
> This patch was applied to netdev/net.git (main)
> by Jakub Kicinski <kuba@kernel.org>:
> 
> On Fri, 25 Sep 2026 09:10:40 +0200 you wrote:
>> Force EEE off on the RTL8168h/8111h (RTL_GIGA_MAC_VER_46) at PHY connect
>> with phy_disable_eee().
>>
>> Commit 202fef9bbbf5 ("net: phy: realtek: fix EEE advertisement write on
>> the internal PHY MMD path") made EEE actually advertise on the generic
>> Realtek PHY; the write had been a no-op before. On the RTL8168h that
>> un-masks a latent defect: once EEE negotiates, RX silently stalls after
>> ~7-20 minutes. The carrier stays up, no counter or dmesg moves, and only
>> "ip link set down/up" recovers it; disabling EEE keeps the link stable.
>>
>> [...]
> 
> Here is the summary with links:
> - [net,v1,1/1] r8169: disable EEE on RTL8168h/8111h
> https://git.kernel.org/netdev/net/c/3cdeaef1754a
> 
> You are awesome, thank you!

