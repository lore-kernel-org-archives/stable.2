Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091E83C062C
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 10:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783593974; cv=none; b=WBZ6unU2f1ZbnxlZcbWQAcEqWrcRNuUIX+F7+3LY/M52tZlLmtxNopy4eyS0RLctHAOQFbfAVcTHUKXLqA/iPm379xIq3OkGeCvga+63EfLdYDzIMtW8GEG7zwwcSN2mBUdQELmMwSBEegKZKaDtwLZ8JGlvfPB5sC4+020N/DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783593974; c=relaxed/simple;
	bh=ALw1vDHV5L4nvGbJoc+jSU8mWvhkA4JdMp1Q/Jp5JGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sjxij7g2a4qhb6NlNdpPjy2Hw88T5EK6mMHipHc6JjV/MBY0ZKUHk7xy3oP+qrnoFk2P8fxt+53Tot1lwuImHG9tQ2JV8rYnxCxllQ4eUNsIEfdVWVheju6Mhub8tBZB54Iq+B5gxoDe81xeJ/W0tmWnu/3P2qCdrHDInXezNFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NPkDu97n; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ecF1zYb7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NPkDu97n";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ecF1zYb7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783593969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I49PQ9PyUdCuLERxmFaB0ytRW4SbKdB8bINg9r85uDU=;
	b=NPkDu97nwWj9NsH7veYbpDazTADQpgfeXF6EkKNWydRl1vR9ENNO9xj7MuJMY+CYDZU/CF
	1cNhETh+hdQ6Y7hP1cUeNYqnHN8FHBh3D76qdDIv6HvlipssLYtfzxX9Jbvoc+93kIOU+q
	ltHF7EAsCbn0Pgoiij9GIhmWIklxltg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-2_VO2kyrMbSRyg4BtwW08g-1; Thu, 09 Jul 2026 06:46:08 -0400
X-MC-Unique: 2_VO2kyrMbSRyg4BtwW08g-1
X-Mimecast-MFC-AGG-ID: 2_VO2kyrMbSRyg4BtwW08g_1783593967
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-475e540a0ffso417430f8f.3
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 03:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783593967; x=1784198767; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=I49PQ9PyUdCuLERxmFaB0ytRW4SbKdB8bINg9r85uDU=;
        b=ecF1zYb7w3M4xqQYWX9RKP8KMzzL4+bUF0n5t9qxP9i1nFdFw9i4d/+QuB3HoFMjB/
         1q9lPrW5ekmrSyEequpx6aNt+Abax7MBnR7o8/34prZ64axx+t5m9r1jj1sWBTEh+Ufz
         0OKqaEpnlQxR2tDTR7mfORPRXAtBz7q2qmWNbXnnDpLZmVvmUdS5Af3Wp4t1g/xVO3Cp
         bjhw/+Lmd2+w2F8F5aqg15aKDMUW3V2uQ9JCRCdukge7RhxEpa1oWsTWpZV534CLp4zq
         ngtRJCEwTbagSM1Blyaj3Pwm6ECQCqZkk0h4grsl65YFckPzKzl9BJV/TalHjrI6zPBA
         pnEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783593967; x=1784198767;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I49PQ9PyUdCuLERxmFaB0ytRW4SbKdB8bINg9r85uDU=;
        b=U81Ej7ktYOYBhPOZztvZgpemJ4WLQJEXGAnf8nHsKW5L15mpUoBTXLO115jeDpSapO
         eYc9viRRMLbI9wve7X79Q/+XQFssfHSQz5tegWORenR2WrLP03dCD0XZHMgH8jXG0DJg
         IxmcXOf8UPcxNpE+8Cnr/pUte1PFTMH41sHAMXlwthrxMtosoIpS28AS74V/cU1ZdWma
         fgZI4IuP9U1gpisX78Fz1cVU6mhdgE6E5/BP0zfwzD6E7H8qUH+4Db5JBKsS+LAIFtTW
         45RkbQXR2v/TcdcXsMEduEvOmeCFZeRX3XKEya5BPKc76fPAKZcMQ58NYTT3Lv9cxXyu
         wvPw==
X-Forwarded-Encrypted: i=1; AHgh+RplRHQ9Uapp++kKWMzTw5vQxSeGcclpP/GcabVodTc1sElWerrUfHA4N/Xndq2D3tnOsuHmQVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNgzxXTJsJ6EGkZuYFAqsTuQYtBHWDm3+Bv7er86qVLLIykFDX
	dvyG5NfQUo+46XjJ12Bv1sHML/RYqsGYj1xLtdxRnvvT49LyCAJhFQMSLVLXbvSaHVqMWEREy9t
	Q2PLpR86jwo9xb4ERXS8v+JV8qegbApoHepTgBnVcftlEw8RxrSDRteuapll/2mPJGQ==
X-Gm-Gg: AfdE7ckfNKEqRlBVGwkDeDbcfQ4F3R7SUPzy1gT6yyrEysW1WUnEnT88nSz2BM0MCpD
	r/5vuefMgskvz5UZFsJ7UsZ378lghxuk+RyICXSdCgyNhAtPQpSmZaQxtDsXc7TKOhtrlKRWv3F
	kxcKX34uwnrSkwmyI6TwaIFssJ0aCOu2cvTzQaDUT9lZPURbOxs12dkBSd7g0C9xXo7wLR/ZwEr
	sJTZAzlHIdjhkSp1+YpH/wSDH79fcI2etNmq911EUsL5jrJprWHk5GO+xTpGuS5lI23+yXrDsB6
	IRmjkNzpnb6HoPxUFH5Yd7nboBveBfN0mbN1tiZfOF4l86RQRkbxwwfBvv10e5JBb7a9nZdxx9U
	L/jO/VQ06TWq6lpi7gdN2BdIXCU9pKhsVbHORvCOOkx3aLzjkielp8cgEGpycH1Ejcuv5X1FPHP
	xoLvV7XWEzcpRt
X-Received: by 2002:a5d:5f50:0:b0:47b:69a5:7263 with SMTP id ffacd0b85a97d-47df071c18fmr7139202f8f.5.1783593966985;
        Thu, 09 Jul 2026 03:46:06 -0700 (PDT)
X-Received: by 2002:a5d:5f50:0:b0:47b:69a5:7263 with SMTP id ffacd0b85a97d-47df071c18fmr7139165f8f.5.1783593966534;
        Thu, 09 Jul 2026 03:46:06 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0960634sm51419282f8f.26.2026.07.09.03.46.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 03:46:06 -0700 (PDT)
Message-ID: <ca70ed92-087d-4e73-88a9-428172e9cce2@redhat.com>
Date: Thu, 9 Jul 2026 12:46:04 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] dibs: loopback: validate offset and size in
 move_data()
To: Andrew Lunn <andrew@lunn.ch>, Dust Li <dust.li@linux.alibaba.com>
Cc: Alexandra Winter <wintera@linux.ibm.com>,
 Wenjia Zhang <wenjia@linux.ibm.com>, Wen Gu <guwen@linux.alibaba.com>,
 Mahanta Jambigi <mjambigi@linux.ibm.com>,
 "D . Wythe" <alibuda@linux.alibaba.com>,
 Sidraya Jayagond <sidraya@linux.ibm.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Federico Kirschbaum <federico.kirschbaum@xbow.com>
References: <20260707074318.1448662-1-dust.li@linux.alibaba.com>
 <ak0NpKUDkvrkuSOm@linux.alibaba.com>
 <c09ac69d-5f69-4634-81a0-5e629cf135ba@lunn.ch>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <c09ac69d-5f69-4634-81a0-5e629cf135ba@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/7/26 8:31 PM, Andrew Lunn wrote:
> On Tue, Jul 07, 2026 at 10:31:00PM +0800, Dust Li wrote:
>> On 2026-07-07 15:43:18, Dust Li wrote:
>>> The loopback move_data() performs a memcpy into the registered DMB
>>> without checking whether offset + size exceeds the DMB length.  Unlike
>>> real ISM hardware, which enforces memory region bounds natively, the
>>> software loopback has no such protection.
>>>
>>> A peer-supplied out-of-bounds offset or oversized write would result in
>>> an OOB write past the allocated kernel buffer.  Add an explicit bounds
>>> check before the memcpy to reject such requests with -EINVAL.
>>>
>>> Fixes: f7a22071dbf3("net/smc: implement DMB-related operations of loopback-ism")
>>> Cc: stable@vger.kernel.org
>>> Reported-by: Federico Kirschbaum <federico.kirschbaum@xbow.com>
>>
>> Reported-by: Baul Lee <baul.lee@xbow.com>
> 
> Could you provide a link to the report?

Since both reporters belong to the same org, I assume they
co-partecipated at the initial report.

Also there is a problem with the fixes tag that I'll address while
applying the patch.

/P

