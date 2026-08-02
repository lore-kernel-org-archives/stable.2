Received: from mail-qv1-f98.google.com (mail-qv1-f98.google.com [209.85.219.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FE623394E
	for <stable@vger.kernel.org>; Sun,  2 Aug 2026 12:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785673485; cv=none; b=pYDijTgFVivbsIAq3kuGk15A8Wc0d002HokmUFZHsozYJB9jLNtSZYOTH0p3y3pTuq5O4KT4IQCOIlbZjQz8LYZRzGbN3/UYr+UzzeMgJx15a/dAC7bsCxR/XPpF3aNyiBEfHQpsufEV2210yvjS0O+CmUP24EsOmnuv1YhX9TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785673485; c=relaxed/simple;
	bh=IVBACOmNYotUTjgF9C6tiVB81vMoFAfRoriF976EZok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GpsP86mEufkHxYk6FPhJLuija+hpzdpa57VNMBwopzGwoHZtOWdBXzraeZucRAHYEt7bUfk4zjoAjd8a55l6VCuVdeMlgnSAQyui7ALrM64njI7UTmEek+q2jaBXYvvM+21DSxgrqnQJfRLC14EXr2+Ppm78zwR18fHZhDQgHLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=EFVqYM0+; arc=none smtp.client-ip=209.85.219.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="EFVqYM0+"
Received: by mail-qv1-f98.google.com with SMTP id 6a1803df08f44-8f256eaedf8so22658696d6.2
        for <stable@vger.kernel.org>; Sun, 02 Aug 2026 05:24:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785673483; x=1786278283;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=QNXeMyhkpbk8rwnA0O7uBQvIUEYbGICoPWDBw29OKOs=;
        b=agLFgUA8kDPDTJ7GhxuiGECbq6wr3p5c75cuekSTat4INcNiMD6W4QtCl7jBnvh4Nn
         7CoId6UBbEZLf2uu33+0l+n6MRlKONk14saROiZw4abOIBvg8U4d6A0OONkih1Q5NVsN
         ADYBviIGPiR5+HHT6OMjx33cvOorX2sWkMr73/+ER+A2JdqYZnrJW7fd56PzctLdhWJy
         1hHbnpqpOsRFWrvdIdaI2YB6gGe8yzKcjMouIHHcQG8Ik5Db+nslqRKFhPx6rf+Alm2f
         b3UDJ+Pnl46OKnN3vmEtguuIkQwaUQQiyw2b4zcOTcjU2onXopyy3gkSgWKBG8Gjy5Oa
         RdWg==
X-Forwarded-Encrypted: i=1; AHgh+RptsL5ijayeTJPZO7XKvD12dBnyRCKl6clEcBu+FuJaXH9zZLbeFA8A90+gjCkheQRcjbWocUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfKJbL7BfJfrlfwlA/yMcSbJ2oQEr2TRGIThBXTosMS/iAmGrJ
	/HmCgUwInHAKArQ4lje9WqO0NiDzXGqYRl/0S2RW8H8y3DS3ZN10UYR7j47VmjMXUeuwFF/H1xa
	qnC5lfVjr8bNni4K0e5WZupc4c7EPYGeppLWALrB6xwbjfSOu77Imnk+w+BkFqTk2HW5NO1whKE
	iWXaUg5++IKojujnFrDfX6ZMeey35bKA8ZL+bR/fPNp+OGGTi5Fw5TvikVbVfOpmU36tOohCj+M
	xbOfEp7FuO2pXOASA==
X-Gm-Gg: AR+sD114zqqUhNQiciHKk/85Uz8sexHa22t50yNDIly5LhxoYY9YDV6O9gC2yNG71Jq
	7O6eEnYxd81LP1Pk+/k3JnwR9EwoMAROGTqvqhzUGx2ZdmMCbr3WIr/DI2Pcq6T2nCc1wfMVdMx
	NDHIer+B0woDM48f7RQSyeI9QxjMPQgalu7QSArMP+1RHp0thkNW1Pr/UrPg7FEm+URYYq9blyb
	pgI5pm/FDtC9IWQ1FJHi+HE/zaKcNGJ7q4ELzNrktqlgMSPj11bZinIj98Pu0bwWEUwLweRkeJE
	Y65+d8T5584O9yeuasWEOJmQMheHI3hfe5Cv/HpSATRL8JbfVyl3yf9O4qc4SrkXEvlTCAnhh7m
	nPvVYkqwg1MtQ3zmbjrE/PdlofTm59C4f9B5dJRnJcnrbDBypS3IrwRNHJocap2bCne4gdvdXV3
	ngKg6BZakYHrE75CZzqO7lVmCas24qxu4hk78L74w=
X-Received: by 2002:a05:6214:2265:b0:8f3:e97:59c6 with SMTP id 6a1803df08f44-908495f6a58mr135150906d6.20.1785673482774;
        Sun, 02 Aug 2026 05:24:42 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-26.dlp.protect.broadcom.com. [144.49.247.26])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-908435d33fdsm4589656d6.22.2026.08.02.05.24.42
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Aug 2026 05:24:42 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-520a00c7a03so46091161cf.1
        for <stable@vger.kernel.org>; Sun, 02 Aug 2026 05:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1785673482; x=1786278282; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QNXeMyhkpbk8rwnA0O7uBQvIUEYbGICoPWDBw29OKOs=;
        b=EFVqYM0+6NjoE1/o48vIEIOlK/WFaP+c2tlBaJBsgTN82BrpG+vOywIEWIqE7IW0z8
         oAzM01aX1GYOg/u5G6w/bzVOm1pLUoI6H0uPMFQwge9MtkPCOTAwt7UnSAKwUENPiI/m
         itE6qlP/DdeG+4pO6o5pkc0c8bCOympwMkcd0=
X-Forwarded-Encrypted: i=1; AHgh+RpM+KUCzzBh1j+iK51FQUYnTcWMolGrk8IXL0BK4AsIUcf3nnkBSnx7v5wvNMb7zDUK8j3IUPI=@vger.kernel.org
X-Received: by 2002:a05:622a:5906:b0:51c:8439:14e5 with SMTP id d75a77b69052e-52b566951a7mr125476481cf.10.1785673481812;
        Sun, 02 Aug 2026 05:24:41 -0700 (PDT)
X-Received: by 2002:a05:622a:5906:b0:51c:8439:14e5 with SMTP id d75a77b69052e-52b566951a7mr125476081cf.10.1785673481411;
        Sun, 02 Aug 2026 05:24:41 -0700 (PDT)
Received: from [192.168.178.26] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52b4eb6a84csm42125231cf.18.2026.08.02.05.24.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Aug 2026 05:24:39 -0700 (PDT)
Message-ID: <f449500c-74f3-40e0-bbcc-ee560951714d@broadcom.com>
Date: Sun, 2 Aug 2026 14:24:34 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless] wifi: brcmfmac: validate msgbuf flowring IDs
 before use
To: Can Peng <pengcan@kylinos.cn>
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
 brcm80211-dev-list.pdl@broadcom.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260723055618.550834-1-pengcan@kylinos.cn>
 <20260802083905.3819981-3-arend.vanspriel@broadcom.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
In-Reply-To: <20260802083905.3819981-3-arend.vanspriel@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 02/08/2026 10:39, Arend van Spriel wrote:
> On Thu, 23 Jul 2026 13:56:17 +0800, Can Peng <pengcan@kylinos.cn> wrote:
>> Firmware messages carry flow_ring_id values which brcmfmac converts
>> to an internal flowid by subtracting
>> BRCMF_H2D_MSGRING_FLOWRING_IDSTART. The resulting value is used as
>> a bit index in txstatus_done_map and as an array index into
>> msgbuf->flowrings and the flowring state.
>>
>> Validate the firmware supplied flow_ring_id before using it. This
>> prevents flow_ring_id values below BRCMF_H2D_MSGRING_FLOWRING_IDSTART
>> from underflowing and rejects values outside msgbuf->max_flowrings.
>>
>> In the tx status path, complete the packet with an error after
>> removing a valid packet id so the skb is not leaked when the flow
>> ring id is invalid.
>>
>> Fixes: 9a1bb60250d2 ("brcmfmac: Adding msgbuf protocol.")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Can Peng <pengcan@kylinos.cn>
>> ---
>>   .../wireless/broadcom/brcm80211/brcmfmac/msgbuf.c  | 46 +++++++++++++++++++---
>>   1 file changed, 40 insertions(+), 6 deletions(-)
> 
> One nit: there is a double blank line between brcmf_msgbuf_get_flowid()
> and brcmf_msgbuf_dequeue_work() in the resulting code. This comes from
> the pre-existing double blank line that was between
> brcmf_msgbuf_remove_flowring() and brcmf_msgbuf_dequeue_work() -- worth
> cleaning up to a single blank line.
> 
> Minor enough that I will take care of it while applying if you do not
> send a v2.

As I do not apply anything anywhere maybe Johannes will, but feel free 
to send that v2.

Regards,
Arend
