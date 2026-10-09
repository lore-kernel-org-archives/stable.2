Received: from mail-yx1-f100.google.com (mail-yx1-f100.google.com [74.125.224.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DF33446A7
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 11:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791546385; cv=none; b=EfqsmLdJTr8qlA1tw/M27XgZzBzYYTysQ260hYvQstzXFpHP0JjP+ziVQlge80TDWKSNdc5cbYNmvVeNBUyjar8VRZownUwamyORXvgid0ZbRIrdJDGVP1xVGZGqU3dYh+u3NrQCCUNR7nYq0K8U9loG9RHNHS7ujZs39BswOMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791546385; c=relaxed/simple;
	bh=qfn6Chi3zQPoGrRKHUmzBsOFSj22hZyuE74D1Bo2Iiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EzwbHf14NLgN5+sooeV40mxRX+tIVAofr+LARGRGOb/S7oGRif97KOmpD/bvZojAgZnhS+r29N94fRSKMN+qkrS1Z+ucV9vOVRhSRxF9+GKbNAjEtaFscRpMQvOt54swcx8GBLqw1Fg3lb7v8hw0B0xQVNFsV25tQJGgYiVHh4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aRcxVCoV; arc=none smtp.client-ip=74.125.224.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aRcxVCoV"
Received: by mail-yx1-f100.google.com with SMTP id 956f58d0204a3-677aec6ddfcso3914451d50.3
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 04:46:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791546377; x=1792151177;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=BQ6/HQ3rrLrwxJjtL2d0lIbMN8Q2NnassUE+UKdIN9s=;
        b=r4/PCDNtAz1uZveGozkjWwnBsNgSU0OoKDDpqnsDs6scFXdbDHPxNiYo7luqf0jfZR
         sXqcS4ej8H9tFbXakATkARrsZTCDo6Hf7Ndf23D2s7n4JXuw/w+ry7tCLgJLmhaA987M
         ZDtXvdyVvfa9FaVuld2ojevlqE3mNZmGOqud2kitp+fXidGA4utPbTcutxefhUyGnPeB
         djNWiii0OdRPDQSLaPmFhieNtT1h6TWFaVuSPwEwd4CQAEYzLLjLE7jM9ZGJlbBgvZpf
         t2hNNyEKzh++ZyxI7McGdA6JJ0DSbRQZxoCQi+gDRrxOQcZ0P54TnctSC9AWHtMTRUHB
         AbFA==
X-Forwarded-Encrypted: i=1; AKwUvByyP4xEsNkkp2KKydICWzj8KPTbvT3RNc6/W0Ey3yqCwrJqBDXgE2SzleEvSgYW2R2Gsk1gx+g=@vger.kernel.org
X-Gm-Message-State: AFq9FYJFrzZpAPHN3fBGPrlGYHdQa0SJFURAEG+PlG1sT4ltZKC647jn
	xAOPTmY0a4bqS801NU2ifl94XTx+7jpI3AoJBfv+znmVcrTe+hg+FxQtKZG5gqt9f8GDTerWBNk
	LATvVC0UkDBnsZa9XyAgmLLcgvOZNykayMWyhil6FXqSjceje3sCQaSHNZK4fRF7Kr4u4jCRbtS
	+iTMqc/Flpg5YHAcH3wmlCIa0ImI5r20zE1hWsxjR5uWOC6ZRrxxFc1nj1D4+tMSq3GJMjAHJlS
	Q9+BgNS5VEpZgkAdQ==
X-Gm-Gg: AYBFou1BbzB/72NQBTjRjKbJXZhkk7yh9vor2nWtlHTKcUZr8LMl5FDxCEG3Mnknnjj
	3OmOYOulV0+LaDLobdPVOhOERpSEsq9FSW4VlWYVlpPLa7dalpv3n8C7i2zXVQolGHpqlxAQyrs
	mnawOKouNoucwD6Ui3YOPhrhSU3rRX+ZxInXFoYN5Zr41aCCaRDr7LbdH4lyig4JdW6jJpM1nbu
	2/mcLlr+MxQtOyrCGyXq+kLTzUVc4PaemKynkoZagdVSKPWzpT/N61hKIJq+rF54WSe45w2aSrp
	eOIYv+qN9P8Ihi8NO+YGcN1W43TVtQHyKjLLZxiqGN+9KSdiMZRN0SkP3XXpvtWQGV4QKMYY0Zi
	/StDGGqxMVZ5ln7DmMLM9qIFSGGBlz8TuJeCN7kthzxMueMG3sf6SKTcKXz6w7BD47uDvarIVQn
	CmfXBDY5ypYr3Ot8OLoNlpo18KN/6EJAYeTuxQBDx10g==
X-Received: by 2002:a05:690e:11c2:b0:675:5671:b554 with SMTP id 956f58d0204a3-67935f1c4bfmr549535d50.20.1791546376522;
        Fri, 09 Oct 2026 04:46:16 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-67935622fe0sm88728d50.9.2026.10.09.04.46.15
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Oct 2026 04:46:16 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30bcb065bfdso12131726eec.0
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 04:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791546374; x=1792151174; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BQ6/HQ3rrLrwxJjtL2d0lIbMN8Q2NnassUE+UKdIN9s=;
        b=aRcxVCoV30TPCjd3pumAc//8aV2bn3Li3hv12I5s+yKPDfsdyTtnWa6GpUfijnH9Qm
         V+2xRzgJ53sAfL5VOWbWW/kXhfOrSzM3Q9cFJxxAtWCpPiz/z2hAzT+l/KmRWWLdPy85
         SEwMUXFnGrsvsg3PF+u5KjtISXbYyCx6BRCkM=
X-Forwarded-Encrypted: i=1; AKwUvBymM8ftCZHEL+BRChUn48kGPtGtlhTUc7C4pNFlvSvtcbXJX/r0J0/2HM0FPa+jmIGKREww0Wk=@vger.kernel.org
X-Received: by 2002:a05:701b:4583:20b0:151:ece6:b171 with SMTP id a92af1059eb24-16a5dcf6262mr2016596c88.14.1791546374219;
        Fri, 09 Oct 2026 04:46:14 -0700 (PDT)
X-Received: by 2002:a05:701b:4583:20b0:151:ece6:b171 with SMTP id a92af1059eb24-16a5dcf6262mr2016563c88.14.1791546373450;
        Fri, 09 Oct 2026 04:46:13 -0700 (PDT)
Received: from [192.168.178.26] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a442ac67sm9791902c88.18.2026.10.09.04.46.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2026 04:46:12 -0700 (PDT)
Message-ID: <448913a7-809f-4ecb-89cc-3aa3bde08c5c@broadcom.com>
Date: Fri, 9 Oct 2026 13:46:06 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: brcmfmac: avoid sleeping tx locks in netpoll
 context
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: linux-wireless@vger.kernel.org,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, brcm80211@lists.linux.dev,
 brcm80211-dev-list.pdl@broadcom.com, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, stable@vger.kernel.org
References: <20260930185417.61865-1-kmehltretter@gmail.com>
 <20261004122910.1392318-1-arend.vanspriel@broadcom.com>
 <asR1TaKQJlPFqEvR@gmail.com>
 <802a092a-314a-4f77-aa1d-134b3d020069@broadcom.com>
 <asiX75kRueyFqWuO@gmail.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
In-Reply-To: <asiX75kRueyFqWuO@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 09/10/2026 09:30, Karl Mehltretter wrote:
> On Tue, Oct 06, 2026 at 10:27:27AM +0100, Arend van Spriel wrote:
>>>
>>> Lockdep instrumentation in fcmode=1 and 2 confirmed that cleanup enters
>>> without txq_lock.
>>
>> This is an observation unrelated to the patch, right? You mentioned in the
>> patch it only covers fcmode=0, right?
>>
> 
> Yes, the cleanup observation is unrelated to the fcmode=0 fix. I
> mentioned it to explain why I kept brcmu_pktq_penq() for normal calls.
> 
> I'm looking at a separate brcmfmac FWS-path RT/netpoll fix for modes
> 1 and 2. The prototype defers IRQ-disabled transmit to the FWS worker.
> 
> Are modes 1 and 2 used or recommended on SDIO devices? That would
> help me prioritise the follow-up.
To be honest I ported the whole shenanigan to brcmfmac, but I do not 
recall any projects used the functionality in production. It is mainly 
intended for SDIO devices.

Regards,
Arend
