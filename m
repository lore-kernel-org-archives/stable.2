Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795210249;
	b=pT1BO/jTXXHAYDoqeosSshT+2xM72x+V2YHqa/+Xz/aNkRnW+e8NrjnnwmepR9PzijmU
	 ogd9jM+gES7S7TbAnSZ19Di+EOb9ZT/rbXAPm9NlBv1f5UxGowVSsTyzyE4wIXXSBD/4d
	 26UmzQ9USiKSHHTR6zZPEyLbHJSuq7Y2ZJKYOLuDehPDxPUwZPsrEY5djt4Pc/+XYftx+
	 nvR4oUbikM/6nPwLykt4cskZAbRO/ylcIFon8LaauBO51ATFTNMp7g6TQQhhwYfGtQU4d
	 Src3HApkekK0Skgx+oPdwke3//sgIxIUk/MVnQtBrpVHA7/MP3ghVWW55zI4a+frQjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795210249;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=a1ho229usvH7WXbHz/geyTJETW2rhXcPAgdJKyw9+jY=;
	b=2BatoN0r6ShklFBxjHOO8/Nh/JYbFkvyM7g8PPOG6D6hfv5iArNoXfiT5+mf00RrR6rP
	 ndOdA4atLbbShMpH2PZPP3ULzOCA1SHCTK7PIDtAAQfu3tw4LewMLkgWRA/XhmB9DEMld
	 2rlJnrBhDo26Xc6ut0mQ5AHaHsE250YxBS0xRTeedPVDsAEycY9atsrGNjxLzmfAToM7r
	 5cWzun8qwSLUPv0088ro4WIYo0QRq42CbselqRAqtkxxdNAJFrisH69MS95IqLmkVKr5o
	 oyQ+ZnV+DxK+0Gkfnnc/eHsx/iLu0tUW9N4NnPz9rSDNMNbRxS5TCshjuwGMLv/I9gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f7vbJLAa;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBDE606A6BE
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 21:30:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECBDE606A6BE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f7vbJLAa
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4a3dd785f65so120310f8f.0
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 13:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795210246; x=1795815046; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a1ho229usvH7WXbHz/geyTJETW2rhXcPAgdJKyw9+jY=;
        b=f7vbJLAauX1ju+cWR/RmICqMbM2gmqeyAfkOA+IV9lUo0n7cqt3FtIyoEBOCmidg4r
         Y/00HD2ZViRnBRaMyjLwYyxKajWQbPmBRwIQeDGm4dKK72y/JS2CTjPrcFEvWbcOgnlh
         Q0rssmXAUfQVfZ7kspfX7P+ghLUBLZaulP6GmPHa4My1mI8Cq2+Zx7cTQbH8+vqd37zQ
         V1RHgHvnH15edOMT9iXCkWcyvnQ7wnuVKkQ93KHC6SIU4kR8C8ImnONF3sjwstaMPly+
         d3PlW7FycgUnemmyMjswQBXnUXKj2umCWjGtKlroR49RMbH7NOcE+DKJWU5/Lmw3x3QB
         7I8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795210246; x=1795815046;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a1ho229usvH7WXbHz/geyTJETW2rhXcPAgdJKyw9+jY=;
        b=tZ/e1F+QBGsDlP2sZmHhZbXjt0HX6W6MDvj15YNUbHth7995O0pxcm6TtHzKMeHRuZ
         43iQ86mVIibbqbPJx/J+La9Sq460IcV8Cj6CTKzTzZTcoe9E/AyTaCh+LbdjoyzNQEXq
         24KRQIHGfwW0EThI2V4YVCwdbovMp1CyLfxHgDBez8tTo0yhkRimfp1BRhwoR+viQdEI
         A5PU/EwcVny2I9ViHLDmSeVBRqWURhBmBOnBFtgqXgyTL7+NP/SxeS+QeWDE+2sdjfmk
         R6hVdvb7a5LA6xcafh0XQiL1k+8qXD1PCAETU2NNONg2IyBW9jFw6mWuSI4dCzcTXuxZ
         FvTA==
X-Forwarded-Encrypted: i=1; AL+hErFgIBIauYVq4VgLL1bnN8EP50PWdQdJmIY1t+ja+zhOHpaAzMDfe8QnJmuaZN9hv4UmvHPuA34=@vger.kernel.org
X-Gm-Message-State: APuU4Z/IKixmb1e8tHkIKv8Qbie1mv6Mo9KFtZYj+na33jIKUdnIFpS7
	W32BQ0+vF0Ib+6OyHqkwxxbhX3Sm8jLtKfr7wJcoSH9JsVD/40rdp9S/
X-Gm-Gg: AYBFou3MBl2Fg86Xc59Si9HLaNdW6FYqjMMezs25JpQmozPA8mx2KB1wmTlufwKsu9j
	QeMe6qkXrSJ3jUSFBZzGhUSCO8v3nwe145PO0csToImLzZ+4zMRIl6/E/tq72vdxatIaavHeD1a
	OIjfjf1cqVet5afVrwmQjtNY+Kulq103Ffaq/0O45fHERrilFo+p7mAKEIOnbYOSHOyxMUGiDO7
	zzZV7QScraG4Jk9mtGy2tABC4+AtW6a88zqDD427aOnI+YoEq8ZPAwdwvv2gNT4nxW+swUV7H4t
	f/Bjdbt85ka2CdwBozHGfnAzs5Cqq+ai2agDOfI9fbohthm7XuKVeBstc6cKArZqOf3GYSSQuyq
	xxIUpKXfggaYbDgcZXrqD34BammgbgS1OCYGNc80r35saEmgzqRamCgnYiwihiUCwhZoiUacn0o
	xVZA1Sljpy7JH2eEbCf3XeUxBksa1AaMSbS7prKWwjQizJ8kwZNvMo1a8LFRzxsClIt30Ld2SYG
	R4VAT7zeMu/u+BJtIFRyJtjnKDozNmC3qrC4A9qJ3eGFjrr4w0jwgYxZmDvkiNVAid564m0V7Im
	fYRJrF1r+/nyoLG7OCZqJXQ6GYA7A+/0EGAO1EbgsMlxjKpfJPInuMQY3LxMRwRGLEhcdsAtl0z
	EpIPjtbzq8EokysHkCDWd/TIdGucuEMw7vPITrJ/+zggmdu6RdHanir3PtgP12DhvL6mM0+hZgf
	aCuKMqn4nIn8+1FeXDQ6Uk2kSjxkh6lhREDOzvZtpumCNM8N0wx3RUbOdNcq9fAxOtL3NT
X-Received: by 2002:a05:600c:217:b0:4bb:6a02:d42e with SMTP id 5b1f17b1804b1-4bb887f3fb8mr69726355e9.1.1795210246073;
        Fri, 20 Nov 2026 13:30:46 -0800 (PST)
Received: from ?IPV6:2a02:3100:65ed:8fc:216e:bbeb:a7f9:ea1d? (dynamic-2a02-3100-65ed-08fc-216e-bbeb-a7f9-ea1d.310.pool.telefonica.de. [2a02:3100:65ed:8fc:216e:bbeb:a7f9:ea1d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6baa3c4dsm6400500f8f.46.2026.11.20.13.30.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 13:30:45 -0800 (PST)
Message-ID: <1f2ccb87-9017-4053-b8c8-5b31a211bd21@gmail.com>
Date: Fri, 20 Nov 2026 22:30:44 +0100
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
Subject: Re: [PATCH net v10 2/4] net: hsr: refuse forwarding devices as
 HSR/PRP ports
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch,
 shuah@kernel.org, kees@kernel.org, petr.wozniak@gmail.com,
 qingfang.deng@linux.dev, fmaurer@redhat.com, luka.gejak@linux.dev,
 bigeasy@linutronix.de, xiaoliang.yang_1@nxp.com, skhawaja@google.com,
 liuhangbin@gmail.com, stable@vger.kernel.org, sdf.kernel@gmail.com,
 lukma@denx.de, fmancera@suse.de, danishanwar@ti.com
References: <20261117141922.20-3-xiexinet@gmail.com>
 <179514132185.3136.17085396682149520983@kernel.org>
Content-Language: en-GB
From: Xin Xie <xiexinet@gmail.com>
Autocrypt: addr=xiexinet@gmail.com; keydata=
 xsDNBGpiHugBDADJ5KuJaOYfUx7TGbRw0UE1km4dLnJomCSNtgq2T9BqgZ6TRPEy37soAmW3
 XxCPvhfL6CPLldzy6O6EkUD7/8zlbQP1DM6gUIQUyKxxkb8uR+oCogDKjsxt0QPycP/dR9fk
 SL4qKReprnkOOcGeLahLHzofVdn46mc5igCBsAA/PPSpo1GqsfGk+zYV97rSVa8zhnSXsqZ/
 9DbUfQynZKVqYN4tm1B30JE5SEWDCko95Qw9fAORX2W356MOQJGr05z9qMSy7CkF7bAUkziG
 d6ZSPsGEsel5jYByP8ZvwQ2A8kdKpRy8+zQCaC+vEotTH7Fs7SIzE/Z5mEVIi1xQqEzN1rqG
 BW7KgzRDWjw8lKsoBbxv20nfhUzuZLan2HzUJ+LxZ18Os4zkWg9sxHgMi+AGqn/+0ppbDcOH
 9Jm072/xA7O1MCXLgr4FOP+4PJH1vcqU+0EZVz7KCjrwkdz+l5Ojso2FLXq2MGoqWGShIsDV
 bF1JYpgm4spdPbnISkidUC0AEQEAAc0cWGluIFhpZSA8eGlleGluZXRAZ21haWwuY29tPsLB
 DQQTAQgANxYhBAHOahKZFnMu2n/CxrTrSufyPi3LBQJqYh7oBQkFo5qAAhsDBAsJCAcFFQgJ
 CgsFFgIDAQAACgkQtOtK5/I+LctmngwAlmrGPWnWxDW6PSJeR9SM0faqwuY33TWAE35nshm/
 EEkBgpVVhG4z4Cdy7L+6TG6NHVDnvl+IHLyyOZlL3LQPQIpiKVgo6jHmm9TF6mK+Vo3nsXAA
 uSJYu9iY9Aywmy2JVQ15ttQ0NfcoZ0sV14bT7pSr9zXB6D8p3XA4AQI6IBeLvj993Z1+tPyC
 6BJ+2aWWLBx7xGpFo3X8dhjS/Lm8QoietKbI+ACefKKCDNiM2KG53P76wdXJp52u4dqP6eFc
 +Qv35QefnALoPkOGQEdd1qvUycyZhuaCj8h0AxDu7bL3G/IM8G2K8qsbSJuui8zCSZ9b/QZf
 H7u1nevPOgxyWC1Pep/TbRZ62ktn8lrmWA8PZjuaJJQGjahuK1GgTQZNG+7DB7NwjLr6aXIm
 JirtT4FeR+IUovvL/ll+VHzpGpFbgXz4GTsWsikQkT1huFSB8MRLlWMXdAKblL96L754j8Z5
 p/YV26YTppXI56uJ3XyOwZSrfrK1pfqNIp2Yr9vUzsDNBGpiHukBDACePM1YZ1FvAiFay/2v
 KVDNpuazmpVb1CBFy+rqM9HcuHe+5CuxLd4RI4hb0qmjlm5Vi5M8+AuNB/wi/f8oDuhJwlMn
 v9L0lfgpRRdShnB26hnt2wWwWFgOU3BwymSruxhEYq+eIjjxCAo6yW7Qm+ArZ+riETMI67sy
 ZyLx6o4yRiWxOrh1nhwV/f6PIOl+Iv4yLAG3eFXpU7/EZpim610bKMwcXEpiRkf3NjiflIha
 adoKHV0LCiVNrU7r8TICjjnugpl1tXAR2RlaRcSxmvOzrXY2O/xBLpwPr5erbdk8RCaxUzS0
 kK0hw+/On3Sr4Z4gtLl2xtDkjRh3KQ9ZqMPrFD/5XOs842ueNivwIyAf2kQJjKfJGWc771EM
 0ZWo1r1AthbuM+IeN5QM74rMJxaf5WyDX3ZeqBA55fCJGJ3zrp7Tqeoq8DYufiNkppE9S71z
 Cvxva2f8mUWTlTUf8s33sRD7C87XpT0whKpn1I9/nJB9Kb0dKyRCdcsT4o1ynxUAEQEAAcLA
 /AQYAQgAJhYhBAHOahKZFnMu2n/CxrTrSufyPi3LBQJqYh7pBQkFo5qAAhsMAAoJELTrSufy
 Pi3L/iwL/3aoCeq19Pog3fqisRyEZeX8pXw2GYlrJWYoM0mQ1USaTpdsMwCXaoFMoSBqid0F
 VPrqlH4bSIEEAzVmFPX0NjGhREDMrQ9eR5S9yqSpBvX+hz+xgpt4NOPhbVQmV+9f4lX9TJT7
 GOO3EX2eeokg6ZAISycCAx7srXuc8oyRTJtnUQziH9GXrEeon88LHf1QHg0Z0sL/c7DfDqvW
 9924M4ngQAZ8RgCBGZocoWuXCemSPkfQVLt5DzycSgSQODhbNSEmr+jb1V9Svf9D9k0CQfEY
 cB3uwOHWb6Z/yaEARbGZPSPn89YjXBncQTpgSvUM578b5x3pKi6PjZB/hwtUsRgrWGWoIwRi
 +ZmcHnCzsuo6uuNYX8VvmWqYsVajykjnpjdCGmU89QUsVmrtnDPBrfr8VVJcZPnCJhE595Pk
 LO29Oj0au9kr7kMW5Q+fBeHj5zz6VggAaRRU74/sgtwLODBWESPZ9LqUUdB5L/XbrSq2VDlD
 sNySbH3veZ/55EtlXA==
In-Reply-To: <179514132185.3136.17085396682149520983@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/11/2026 03:22, netdev-bot+sashiko@kernel.org wrote:
> Can a plain veth slave still re-enter the xmit path of its own HSR master?

Yes. The redirect case exists without the patch, and the commit message
lists it as not covered. seqnr_lock has been held across the port
transmit since 06afd2c31d33 and 430d67bdcb04. The patch refuses port
types that make no sense as HSR/PRP ports, which covers the syzbot
topology, as Sebastian suggested [1].

> Would it be
> better to stop holding seqnr_lock across dev_queue_xmit() in this fix,
> instead of adding a denylist that the planned lock narrowing would
> replace?

Releasing seqnr_lock before the port transmit closes the whole class,
but it can reorder frames for receivers without aae9d6b616b5 ("hsr:
Implement more robust duplicate discard for HSR"). It is left to
net-next, where Hangbin's patch [2] fits.

> Could this hunk move into the GRO policy patch, or could a stable
> dependency note be added?

No stable backport is requested for this series. The macvlan GRO check
depends on patch 1 and makes no sense in a tree without it.

[1] https://lore.kernel.org/netdev/20261014151838.6RyMIRVM@linutronix.de/
[2] https://lore.kernel.org/netdev/20260805-hsr_deadlock-v1-1-d8a6f06fc5a8@kylinos.cn/

-- 
Xin
