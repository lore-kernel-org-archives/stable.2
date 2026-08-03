Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1ED43AE1BB
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 08:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785745270; cv=none; b=LtqS9uhosf+FUqwFv6RpGLXEWgdcYt8MSTXWTYxh0JJaieG47goUWxyMStAIWpTPUnBzVWZEY7F9fSgEV/haN5tQyFwVQBFwHwOndeRJ9JCO++1YHUNhc41N4c2EXo2V0CNopp4mdf0VRfYIggUuixBm5q1RI1GPoTnZZHMaad8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785745270; c=relaxed/simple;
	bh=Pg0dLujnHeta+8k9PUkwaeX7IBhCH3Vp8JK79I4o2qs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=S5NAjOaGC3iviDALeSmMaruAkiBAb7wyl8Bq3pIpFImlOn+vEZOGgrggFx9ROBSwPkDDm0O4DLuihq0TaZwCdd5jT770Ys7WZslIBiVhRJBNsmBcSsqTEV9VrwqfDar7kpDJF+ascq4gp8rwwVB/0vvAPGFAm7UgUo2obdfRDk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=S/vNP+dB; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="S/vNP+dB"
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-2ceb096e675so35814415ad.0
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 01:21:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785745268; x=1786350068;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=umawf+BlMbUojF4hA2eaASvm/LHe9PC11Jo6AdX6bp8=;
        b=DiWq9uu3iETDEG1zTEePdwlm/rgEzfOB0UMpQWq8szk9mKeGrOEUGTBWHB9fxl5Kk2
         vYaNyn9HcliEXaCropu8rqPc0cgZ5iRgJ4qqEnieCuHH7w/Fz2kXwAGU1KF7AgFBeens
         NWRjj/umfQNARR9WfSay8P2ZvPpdbxK92/1yL0f2WxKo10XhVmeyFs+LuRjeD5GO0Gd3
         ziwxVi7j5g3+aSPtDqzu5XvQhu0MbH4UfXtJXMATUUSVgB1Xl4RzqiQkWHH0Fh31hXNi
         4JiP0KiZVjTakw+pZoMWVip6Ec5ePKDu+d0qWPyVU3qpxyH63DAIapeYrLiT3MutrLOP
         3JzQ==
X-Forwarded-Encrypted: i=1; AHgh+RouNWKRcS2U9OFZKDW29GRhcL2x3Wg5Z4yay9lW4fHsV1NiYsHEgj9I7s4bZAMYfgF0313M1tA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4UF+ZleJgywJ+WIpkxZJ1xvrF+uZXOKUaJ1L5j63Um9qRtqoZ
	Mu3gw16Tp8C8SWx8tjKDrmCcQdFXT5vVGDYaa+Sj+an+YXGGMgJh6yDhXlR1ufPp9cDqS3mht46
	5SMeGo1s32EKrcp/xpCp3z4nqaypphrxOHbDJFW/gVYXhMQOvV0BVOhgeymqi7Ze1lv6/nL+K2E
	84vXAYrS5sJxM3S4O41ujOc3qSmRyDz1J/mAGjxJAS/zJxOJKZBw/6NHkTCGWxAlRldYjkOk5bJ
	yJaQKRLNJaPllJkgA==
X-Gm-Gg: AR+sD11t/JnnVsWrfd1GR1svTKYW8Wr9ayO/QfEvm6r2FpKig66u4R52RKiHaqJ5I63
	2PzL0pWuX2Owcf5mpdj2QzDa+rxxpEfqcWgr45d188J1sXPZlLnQtUDDDdASN8sWqmWinm+5AFx
	Npbyi6/C0BVu4SIEY3nm2O7waM52h4vvMKzHvrq2ramZCY1YNvU/Bvorza4MyAOyv+e6Op5vdYY
	cWGNC4otN6uOx3+3OWdUk4xkl7jNZxAlsLJId3mDGb641F0X7W4ApLjm7SouUdv4TLQm7aRN0Oo
	TQ0m0uj/bS74SGUtO+j13+/ooGQdgUof8L4gLTVuvbO/ceLFzLRLrD9rkO7hWDY+z0Cha8eLuEI
	3ZKQ0OVEAZZ8Dg/XKPzmZzL7kRJWQktUIz0wwVi8zIlGnsUzw7fXfbyzP1RwevwBjiIdT43g4PK
	FioSQBLN0ECp2vvaOtXn8Y8mhnsQk9Rof0Ph8OKdk=
X-Received: by 2002:a17:903:2d1:b0:2cc:6817:d9bc with SMTP id d9443c01a7336-2d0523e6ee5mr94784665ad.38.1785745267842;
        Mon, 03 Aug 2026 01:21:07 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-27.dlp.protect.broadcom.com. [144.49.247.27])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2d04b137a8asm9014845ad.42.2026.08.03.01.21.07
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Aug 2026 01:21:07 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e1118e4abso5836594a91.0
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 01:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1785745266; x=1786350066; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=umawf+BlMbUojF4hA2eaASvm/LHe9PC11Jo6AdX6bp8=;
        b=S/vNP+dB2r8dfC99LwWLupiUUelWHCzPGrii4uDLA7/qrFOK/BB2g4nsOt3Hq2yrZq
         8grCzW3/DlwIZmDvFHl/ZpYzxndP1rIF16+/+oJyH2mRTiKXMfjVgC1s1S4D+W0ZPEfB
         Z0nwcSMxoX9LtVgZCiB6i2VJCG9p9iBhd3DgU=
X-Forwarded-Encrypted: i=1; AHgh+RqGQXlFtz3CbvXRM3WJLidOAxKGSjHdvInbnTUStxZiV67MxYRsmKJ8eOiNHxGhvVxBXxVykXg=@vger.kernel.org
X-Received: by 2002:a17:90b:4f48:b0:381:c500:b0d1 with SMTP id 98e67ed59e1d1-38fbc4ff4ccmr8731216a91.20.1785745265910;
        Mon, 03 Aug 2026 01:21:05 -0700 (PDT)
X-Received: by 2002:a17:90b:4f48:b0:381:c500:b0d1 with SMTP id 98e67ed59e1d1-38fbc4ff4ccmr8731186a91.20.1785745265384;
        Mon, 03 Aug 2026 01:21:05 -0700 (PDT)
Received: from [10.176.2.103] ([192.19.176.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153dd9be04sm33069820eec.9.2026.08.03.01.21.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2026 01:21:04 -0700 (PDT)
Message-ID: <c2589f1c-c754-4282-815b-df64f0250623@broadcom.com>
Date: Mon, 3 Aug 2026 10:21:03 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: brcmfmac: Fix memory leak in
 brcmf_sdio_read_control()
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Johannes Berg <johannes@sipsolutions.net>,
 Abdun Nihaal <nihaal@cse.iitm.ac.in>
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
 brcm80211-dev-list.pdl@broadcom.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260722110713.115988-1-nihaal@cse.iitm.ac.in>
 <20260802083905.3819981-2-arend.vanspriel@broadcom.com>
 <e059b52701d3cad4480dfb506e61474924b9f29e.camel@sipsolutions.net>
 <6648c1d61a44ad732550ff20c0b1aecaa43676f6.camel@sipsolutions.net>
 <19fc626a040.2873.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Content-Language: en-US
In-Reply-To: <19fc626a040.2873.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 03/08/2026 07:44, Arend van Spriel wrote:
> Op 2 augustus 2026 18:44:40 schreef Johannes Berg 
> <johannes@sipsolutions.net>:
> 
>> On Sun, 2026-08-02 at 18:41 +0200, Johannes Berg wrote:
>>> On Sun, 2026-08-02 at 10:38 +0200, Arend van Spriel wrote:
>>>> On Wed, 22 Jul 2026 16:37:12 +0530, Abdun Nihaal 
>>>> <nihaal@cse.iitm.ac.in> wrote:
>>>>> The memory allocated for buf is not freed in some of the error 
>>>>> paths in
>>>>> brcmf_sdio_read_control(). Fix that by adding vfree() calls.
>>>>>
>>>>> Fixes: dd43a01c5cdb ("brcmfmac: use dynamically allocated control 
>>>>> frame buffer")
>>>>> Cc: stable@vger.kernel.org
>>>>> Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
>>>>> ---
>>>>> Compile tested only. Issue found using static analysis.
>>>>>
>>>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c | 3 +++
>>>>> 1 file changed, 3 insertions(+)
>>>>
>>>> To be applied to wireless tree.
>>>
>>> I'm going to put this into wireless-next, at this point (-rc6) this just
>>> doesn't cut it, the commit message makes it sound purely theoretical.
>>
>> Actually, I'm not even going to do that - sprinkling vfree()s over the
>> code when moving the one that exists would be sufficient is, and I'm
>> being generous here, not a good change.
> 
> Sorry, Johannes
> 
> I looked at moving the vfree() to the done: label, but the code also 
> gets there in the success path to wakeup waiters. In the success path 
> the buf is stored for further processing so it should not be freed. 
> Maybe better to do:
> 
>         spin_unlock_bh(&bus->rxctl_lock);
>         brcmf_sdio_dcmd_resp_wake(bus);
>         return;
> 
> fail:
>         vfree(buf);
>         /* Awake any waiters */
>         brcmf_sdio_dcmd_resp_wake(bus);
> }
Actually it turns out brcmf_sdio_read_control() is only called once so 
the brcmf_sdio_dcmd_resp_wake() can be taken outside the function.

Gr. AvS
