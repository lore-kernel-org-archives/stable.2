Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AADD4334A9
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 09:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788428163; cv=none; b=mRqA9UQjKI0uoBW4piRQWXq6bJMbZ5UenPrp9jyd9vs6kO1GhC/BL/e0vN48/JRNbQOcqRnEnLfnfAkUW5VjksH+NRoUe2NyNdNpe7i8dXxKk9WtjbY38pjWp5ldrjQvfGFOkdbG8S6uDot5pxmp3e3Mc+vXWUSvHaV4FXIoHiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788428163; c=relaxed/simple;
	bh=oPVsqXoZyPeTg36URmaN5Iw3DnLJlzjYxHnkAlYg7Uc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Gjiw+bVD7vCKuYGieAJ4D2+pVLeIuUCMQzuF207725+3b9NtNIlQwww5bUNvML8pHIbp+uB2TdQ65gcxCPBDP2o1+cICz1ES/NRcXwovfXzU0RUEulLTgHuktnDadSBhUBwlkk9Pq/DnKnL9UQrqAndTGf6pOxaY+PVl514dfCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WNEteMeO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hgAhsGox; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WNEteMeO";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hgAhsGox"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788428161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UIVrwf02TP+O59kLnBOVNF6PWYsBEmmPNbrz+e5p2HQ=;
	b=WNEteMeOlrem7dlzB8hKiwfiweAN0S4d/drYJBkZRigWPd/ZRHdYEOWFie7XK0PXkviIJb
	cz9gdR5FVHm88/jpugoJBhcYxxWnGHuSDZM+blKLG0rKzpIPRWGWXm8ggnl2Le4sk0F7NX
	kJj3/fKCGghqNEgJlCleb71DBnGS5bM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-pMl1aVQxMvGejy3EWMQqNA-1; Thu, 03 Sep 2026 05:35:59 -0400
X-MC-Unique: pMl1aVQxMvGejy3EWMQqNA-1
X-Mimecast-MFC-AGG-ID: pMl1aVQxMvGejy3EWMQqNA_1788428158
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-495529a93f9so20015475e9.3
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 02:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788428158; x=1789032958; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UIVrwf02TP+O59kLnBOVNF6PWYsBEmmPNbrz+e5p2HQ=;
        b=hgAhsGoxKmxmL0DZ/XDJeOFCA7BGVxLu8PasuoWft+zNfwfAkd3Gqg3RUXgHklV97v
         zeLZbDrXP57HoJ7MON4I89MGw/5I7bPzfGmR4ZMmkJcFGRw0vm62kIL7k4QF03Z6NS3D
         gM8yFK/X8U8NNzYgJWk4oOeehnsatu8z1y/jlVGmAJXL3mXgJ7FyBCvencL0vEwVfsmS
         awPYRIdJWJ6Ses4T5E+RbdgVdzgY4CBpyAt0dJtM8OmbEawpePJZsOOCufsiu2f8kl1L
         YKhmHZF7N0j7hy3t+O6vJu1N/Mec3laRonAFDUvI3x0A/wI6UYkFQemSxZq4G+U3FJ1m
         Torg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788428158; x=1789032958;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UIVrwf02TP+O59kLnBOVNF6PWYsBEmmPNbrz+e5p2HQ=;
        b=UpLSK52Ln653Qrt/1oTxO+jZA1JRJ6Hoq7iux4MgcK0wTmq5XeeYXd8w8idt7ZH/p8
         CYmuPgeQasvyzpsVPvGL18tF2oFZL/enVtWAety6S90K3Ux9XifiZiEWdHpM0kFxxkHZ
         86bs85gy/sbUrLk2cI42UhcKr8MhY+QhP/jNeXQ5WiHXW1vMfc/ODn5POM7LV+627MpR
         u8Wj1i3oPA6IJXTq3V6h9jn4iDVNmykL+H7mWRl6WpcKedWOkcORhUuDSarTrDSeksLX
         akHbKFd38w3KGd6e68d3A3ItU0CWMezeioEOjypjYLFSi2yWDwsvCG2bAIkyNO2Nm+vD
         sv5Q==
X-Forwarded-Encrypted: i=1; AKwUvBy7VSOnHaEUJLzt0ysvIwtNrXQMiXscSV9CDN6zpRu5bxGuanj6HTxNuZd34bHqCe2PCht/RtE=@vger.kernel.org
X-Gm-Message-State: AFuF++k1PzyxYGOzumXRlx83kyLuhG6/gXuuUnEEGhHFmZe6j3NIVEYV
	N50Mix+w1+aWO/VckqUxMWNyYp1eziTTfdzfmdcFVGtb4Uq0Io7Wd9fNWtCd39a8h4akTDCnZVR
	udb4J5/U4HdFKo+dCkjBr0o6eAGV/7bhAQWdquXML7a1olbWfq90yQBiNOA==
X-Gm-Gg: AYBFou30GVHIGKBf/DIWN8XPak45faiYRavx8Kp2YH5bHyFOAI5ZKkdjV7C8NMY4gEw
	F7vFYVuQZFtaPyey+9phOGqnRtQ+SFSeE66bcTC5KLPeb7MYwWXTH5bSE2FSTv2CZCA4JQ7N12o
	PgTvXqE0P9gXau6klBJNRHT0Lt7GuHgre5WA1rdsWyScVcSVtUDvW3sMkJLuuT6490mlYF2BEei
	7+fxOAYIoq00pGwf5lJftnWHOqIiWmM4gTuU91tzt+od3QhZBotS30LfmlrJqvWpQVXUbUne0GH
	Q51s6ycGqiwHoTvKp3Xz1zRVgUxK6oZgg6xx48GkMbBi1xgdScIFAWmz1Qj7RXXLPjtJrPDVt+G
	k41MAgAe/M9cwnJGnESxwrWLQrxSRUSYOBty79vWZTVT0cszrYnL5DvY8m9G0XKvGC0M90GlkjA
	==
X-Received: by 2002:a05:600c:4693:b0:499:484a:81d0 with SMTP id 5b1f17b1804b1-49ce5817d63mr163904635e9.9.1788428158006;
        Thu, 03 Sep 2026 02:35:58 -0700 (PDT)
X-Received: by 2002:a05:600c:4693:b0:499:484a:81d0 with SMTP id 5b1f17b1804b1-49ce5817d63mr163904005e9.9.1788428157541;
        Thu, 03 Sep 2026 02:35:57 -0700 (PDT)
Received: from [192.168.188.218] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce55259ecsm81914915e9.2.2026.09.03.02.35.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 02:35:56 -0700 (PDT)
Message-ID: <8f1c4df1-726e-4bcb-addc-b1fcf329013f@redhat.com>
Date: Thu, 3 Sep 2026 11:35:55 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4] bnxt_en: Bound SW TPA IDs to prevent crashes
To: Joe Damato <joe@dama.to>, netdev@vger.kernel.org,
 Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
 Rukhsana Ansari <rukhsana.ansari@broadcom.com>, horms@kernel.org,
 colin.winegarden@broadcom.com, linux-kernel@vger.kernel.org,
 raphaelcf@meta.com, stable@vger.kernel.org, llvm@lists.linux.dev
References: <20260828190900.1767611-1-joe@dama.to>
 <1c87458d-7d76-4da4-9981-51756cef391b@redhat.com>
 <apa9qofhuatqGTra@devvm20253.cco0.facebook.com>
 <b8b6db7b-353d-4d6a-b0b6-3b5e1be22008@redhat.com>
 <apbpWrfu3VQu+CUz@devvm20253.cco0.facebook.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <apbpWrfu3VQu+CUz@devvm20253.cco0.facebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

sorry for the latency here.

On 9/1/26 5:03 PM, Joe Damato wrote:
> On Tue, Sep 01, 2026 at 02:10:04PM +0200, Paolo Abeni wrote:
>> On 9/1/26 1:57 PM, Joe Damato wrote:
>>> On Tue, Sep 01, 2026 at 10:16:54AM +0200, Paolo Abeni wrote:
>>>> On 8/28/26 9:08 PM, Joe Damato wrote:
>>>>>   - Moved bp->max_tpa_roundup_size init out of the early return path and
>>>>>     documented that TPA is unsupported there, as suggested by Michael.
>>>>
>>>> Clashiko quite convincingly elaborates that the above is not enough:
>>>>
>>>> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260828190900.1767611-1-joe%40dama.to
>>>>
>>>> Could you please have a look?
>> [...]
>>> 3.) "The new assignment sits after the max_tpa_v2 == 0 early return, so on a P5+
>>> device whose firmware reports max_aggs_supported == 0, does
>>> bp->max_tpa_roundup_size stay 0 while BNXT_FLAG_TPA is set? ..."
>>>
>>> Michael commented in the v3 that this is a false positive, hence why I changed
>>> the code from what it was in the v3 to this.
>>
>> This is the comment I referred to.
>>
>> AFAICS the problem is that the driver sets
>>
>> 	bp->dev->hw_features |= NETIF_F_LRO;
>>
>> regardless of the supported capabilities, and that seams to disagree
>> with Michael.
> 
> OK, after re-reading this here's what I see: NETIF_F_LRO gets added with no
> capability check and bnxt_fix_features() won't strip it afterwards. I think
> the fix there is to add a BNXT_SUPPORTS_TPA() test, as a Fixes for
> f0aa6a37a3db ("eth: bnxt: always recalculate features after XDP clearing, fix
> null-deref").
> 
> I can send a separate patch for that, but it is unrelated to this patch which
> fixes a crash on boot for Thor2 devices.

With my limited knowledge of this driver, I thought the report being
more strictly related to this patch, and the fix for them should land
together.

I'm fine with v5 approach.

/P

