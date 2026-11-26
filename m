Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795710714;
	b=boajwgsirDMtXMLVMsEAGRv6pcJJufxGt9KdWOuBQsu9R4DyWZx5vbnYA1X7vQrV9+HY
	 3hs8hnDkX34VmwHGcrb9bbMpNWZtZ0cWBscmP2LnuyZjpTq30jvkjwnHLk7+9e3gZb/JT
	 n3Nbh8HDDgSwBevycSFK6NufIsz5s2KJsPEmkNQUVU1QIFe80oVvbQQYH4liJNjMnV97a
	 Kd1tegXO/3Xu0jArBJy8XEjm/9yXOz8yVel/nm9Le08qK/obRRa0Y+DEfBx92SW4anopE
	 XiuwLDWD10frRXcGwV69Zz+RVYcM8RTdT4JvIB1eqLDZZfP58WGhJVct4DKGbUM7yOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795710714;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=t9zuf6AtiZX3yOJGNCRqBvoPw6Ll8AmPwZKNUXFPImg=;
	b=gFf1h2wHN/dUglmzLc3ujJ50E2cUH8s3v1oIDmg5/dQjAizS6VZM+J8WCPERd8tPZf98
	 sZ06gvtoFRUO9OfUbO+CxjdxIlrnGK2ackfpMV/Gr5GoXga0FawsGGK7XuaFFUAuj/ya8
	 QZZFG/8juk0RMnXzfJSz0flqEx1Syh3619iAZz+dwRd8hpDKi8XGUge+8aZ9en9Y6YLrH
	 ytmqU4s19veW96uKjg47NlJcAcUvMsviPuHpOFHaD1iQJ+YTp42jRNLmOUxomSB62/tI8
	 zPEiC+A+wfqrRqW8CL4e/LxVjZMbQ2vyfC2N9OnXL+7rXGbUrPqTM56zeVXeiVbP0IQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FNXITSxk;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="slA4/mwR";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDE860A2618
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 16:31:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CDE860A2618
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FNXITSxk;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=slA4/mwR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795710712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t9zuf6AtiZX3yOJGNCRqBvoPw6Ll8AmPwZKNUXFPImg=;
	b=FNXITSxke5jsILp5WcRxckJFkbtVo8niQpqKers6+xbfFFj//VOVmBiOMlXxs8FgcuhwHe
	rBNuNJU8C8eBS/wh8RQdG13ovQCu40zWp2re/c8ueCPboTeytt2ntqs6ptN90PzARCTB6S
	ONVCEF0Xc6Zer3p3wKgUStFxM4J7jH4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-MwoSnkAHO36cMTip217FGQ-1; Thu, 26 Nov 2026 16:31:50 +0000
X-MC-Unique: MwoSnkAHO36cMTip217FGQ-1
X-Mimecast-MFC-AGG-ID: MwoSnkAHO36cMTip217FGQ_1795710709
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a1f03f2e8aso62838545e9.1
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 08:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795710709; x=1796315509; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t9zuf6AtiZX3yOJGNCRqBvoPw6Ll8AmPwZKNUXFPImg=;
        b=slA4/mwRHgGh6eC4qPsg3ma9GBSUsqK+U3eisX/eHTTzuMe9UVW34SAZb2WQ4xwtDW
         +eTlg4zzIEYgRhWv10nWv5x5T3JlI6QddpVrTkOJObIGF+K8LKMBDO7cnu3dPDJtPhQL
         CZDUM2f0Iqxbpm2t6bylh2m331ykHT4Tqcmalk8GGBX/6ci0bI2FsiobISE1FCnytjJ3
         ke1KQ10Q0OcxmAeL15nzspqgR4H+nY7OJmLIzmxbISwCUYA7foftptOIg9PyYcgafjz+
         ozgEUJybOvgv250riBScj739LMHu9Tdm0zKV/z4jwY2nVJg/f1dzlcFk+PO2ga8zC1W8
         wouA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795710709; x=1796315509;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t9zuf6AtiZX3yOJGNCRqBvoPw6Ll8AmPwZKNUXFPImg=;
        b=t+NAADNjAzykZ92tullvhFYyt5dCIC6uMvITN+40MvxSIf4p20qOat+P/Nm/L2uSKQ
         Z/rUfrLqM5ZRXXBfvyAt1xatD8E+vOxeP7HLeyyBBobMEPVbs2HzWBAzadDSjvOyXqC9
         /8ANAiHHBswvHwKqQh9ntRCyo03IlodQqo7/5TsS5Z8xC0MI3s/xMPJ41+weOTi28igk
         FN1DiOb8XYjsvKGhkjsLGiyNcDqDYg1dCjo1dqKMo1DP/R2ehyjC3LzjMkTIMaLNS2wN
         Y8AToeZbtJ6UczVf0t2EFndGIQpTphEs0zEXwauCLeQwntWGo3HvB8rjiUzokReWklhR
         OsQw==
X-Forwarded-Encrypted: i=1; AL+hErHgwI+R/ghVmoqtXtv+uhNJkW6bCXSiFLdC6qSBHau5lh9JHfNCz6vMbV31yHguYiNP3FcJpRc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/aaQfJdgLxSU01+bIlDrt+8Yjct/ZedQuOk4OL4fa1gYB0nd7V
	cwp9LDFngKcjR54R/yZhlnCd8ppYnxgIAeaTLAHC3sjW0nUyGR/xTh7SJvZ/CCHePuXBRJ7JK41
	k7RLIexFyrRdvw24wNG4elIcDdErmUK81KxkkjQE7/N7zYwRnkL829SA2Eg==
X-Gm-Gg: AZFdTZcTeUL1y66uTRK+tYvzI8ceGjNAy0ZpoD6O5ThbRgZPY5/USBH2n6/ufnRiqeE
	9ZpZkWjGUeUR19vAJu2iKuFHdyvReJOvzKAp4enL+QCPGObv/KJZAw73N1cX0qBvHiVKDBy/0Ry
	WKwtQj2EJd4odbc046HOT4roWcyJPlV1zjdUID9Ungzid+HlvpiIZbIkqO0v79E8bMgbyDXKeOw
	jbDucyfb5uTMDwYmYt5owV2KZdJRU0lzMiKjWQtzOrnIp8kAmsHcO5HReBau9sgMhk3RhTXKIr3
	xxjmQNb3DffxHq5weEkFfG92rSU4j4aRyr5yLztdL0y7E7kzw1q5wTedFWa7E+NAMoQC3iSwcld
	D8fuGkWPHWZGttoz4/lDueukWNcwd47oEoMjUwbAOoNx06ZdUHw51SPFTGYR/S7sKu0XLKQ/LJX
	zHsqgj5R2LenzAPFbP4yY2uSD/8b0+0O+AhSIdM6DSFZqY
X-Received: by 2002:a05:600c:6749:b0:4a2:1867:10e8 with SMTP id 5b1f17b1804b1-4bb8881a294mr421918855e9.25.1795710709185;
        Thu, 26 Nov 2026 08:31:49 -0800 (PST)
X-Received: by 2002:a05:600c:6749:b0:4a2:1867:10e8 with SMTP id 5b1f17b1804b1-4bb8881a294mr421918405e9.25.1795710708737;
        Thu, 26 Nov 2026 08:31:48 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b8b7888sm41448852f8f.42.2026.11.26.08.31.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 08:31:48 -0800 (PST)
Message-ID: <72ec342e-18a9-4b40-ac3b-a20e4e9608a6@redhat.com>
Date: Thu, 26 Nov 2026 17:31:46 +0100
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
Subject: Re: [PATCH net 4/4] net: skbuff: limit folio refcount when splicing
 from sockets
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Kiryl Shutsemau <kas@kernel.org>,
 Song Liu <songliubraving@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Rik van Riel <riel@surriel.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Pedro Falcato <pfalcato@suse.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 stable@vger.kernel.org
References: <20261118-skb_refcount_overflow-v1-0-5551b4954c3f@kernel.org>
 <20261118-skb_refcount_overflow-v1-4-5551b4954c3f@kernel.org>
 <14059088-7992-4d89-ac6c-1e6d1f61b3c8@redhat.com>
 <832f42a7-1d44-4138-a7f5-7cead4a28e57@kernel.org>
 <bcbb57bd-6447-4faa-a56c-9bdf1c7bc90a@redhat.com>
 <b36f40f0-3f9c-4ba6-8c1c-a76f99623944@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <b36f40f0-3f9c-4ba6-8c1c-a76f99623944@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/26/26 17:12, David Hildenbrand (Arm) wrote:
> On 11/26/26 17:10, Paolo Abeni wrote:
>> I actually prefer what you suggest here more than the current patch.
>> I suspect Willem may have some other option avail, but he will
>> not back for a few days.
> 
> Okay, just let me now whenever you want a resend with the proposed changes. I
> tested them a bit and they seem to get the job done as well.
Please, go ahead.

Thanks,

Paolo

