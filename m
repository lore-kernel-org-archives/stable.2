Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708CB43991B
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 14:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785247415; cv=none; b=UpJkyzOEsIc8SHtrqxILHnGz+fe2VzsJtxOUdyKdYUtICCRHQMWMyl8k+HhbiTWlkjr3oM3hIqd4MfJw8lStk3Sds0nXFTI58g6YWsu+f3QfFmKCoKgxZUEq+NRjxGFHCUkNWWJ/SpUjI1GP+bgH9l89Fh+MhZD79LY3U1ViAus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785247415; c=relaxed/simple;
	bh=vRnBca00tyeZKK1fwXf18bbC4/LTulGT8DBbhVrqJUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=agAO0t6w1sh4I4Rb8nX4gK+jr400MNTqTlu4PyLEZ54zAY/dvr1MS6P1kUCAXIQ7XQy5TXbtG/pVBoCwdLhcxBLHPzkEYbr9r73gZy/i0oLObrWR8LpAQ3nVZE/ANR/CGQOClEJqPaLCiBg5jPKrTa/csKNgyzF12D7weJdKo/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fhk7WXW0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=L4YmUT6p; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fhk7WXW0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="L4YmUT6p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785247413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=44/b/tchI/kXTVmC+LeNLesnctyWoFMi/+uiRQ6TASo=;
	b=Fhk7WXW0jlgtMuFHudiKQGG/bjVzoM9Wl/UnKUMH1IgXd8hyEGKntd3faNes+M2qaRGHZ1
	DKC3HAskk2d0RBnSDBFrzV+Rv4zwDJTs0NUB8s1qJn74EoYcuv6uJNo2U67xN5LiAdnt1j
	jpS5H2ty39pWO/a4uQFUmppj7a0ty50=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-fPQF219aNcOk74N0W1JrdQ-1; Tue, 28 Jul 2026 10:03:31 -0400
X-MC-Unique: fPQF219aNcOk74N0W1JrdQ-1
X-Mimecast-MFC-AGG-ID: fPQF219aNcOk74N0W1JrdQ_1785247410
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47f6e658363so2778614f8f.3
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 07:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785247410; x=1785852210; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=44/b/tchI/kXTVmC+LeNLesnctyWoFMi/+uiRQ6TASo=;
        b=L4YmUT6pQ0XeG6iU6LCnWHfgIxHOxiKbiojjRdHA5UXRBuacH5V4oVjlJVR91HKxNb
         Ok10+5tovHMLjfeyE6sPIDgmvh0gKE7VRTWU4oXeLR3QCrsSUgfi6HH9C7CiN012GKo8
         gkpltkuySOP5m2vaeN70C7rT1HmOqRakXXzJve6tfgMaBHXg1VjdYnYLcxd3CCLVU/ph
         FCdohfH7Syxzr865kVlb8ZDRlhd2/NMkWBQ5cduFi65Q+RYm2p3CLHVDySRvmOwqI6BZ
         2j9XL5wsZPxsbc3FQd8Re5+zZaYnY5k9SEM89yo0Dj9kmf8rAlh8ULOjR5+JVYruIei/
         LLpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785247410; x=1785852210;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=44/b/tchI/kXTVmC+LeNLesnctyWoFMi/+uiRQ6TASo=;
        b=WVjASTpJonZ7x1vRrlBuB3QKQqOLxyVYiRlLQANeuw0Z8/embtpfOKDn1mRBYjsCds
         1YvJCk0U/Ih2xDTLyI25c2Bs8ELHLE8vvD92Ol4t23KmkTjNDHnh+jO87pfpXjSqM1J4
         7i+PMDyVUiSk3NP3UFJ2ERXfxl/FjbDQyikR57zhc8rfKukM2s8qUaU9VopgWEVlpbzK
         FR+K36nfvACqcMlxBd+WxrdNTHPfKeovuFzy71ZPEIrQPoB9yRZL9RwWAuLXKNogkJSV
         u4umdW/dnyq+YDifUoT7IjVqJPmRKalf5po346hMlheZaaauT+QdblaJbzuHGxX5MBnh
         zV5Q==
X-Forwarded-Encrypted: i=1; AHgh+RpsRUMd3ELywALFSrwaY4npzV3R5mX/ChjMF6GhscN4O3hjOIZk4ul3Xd0hiMCh2z7v2H4KGXk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+cEtMLZVlRKHFxknW90qsgWOuhaEIsUNN4pEX3ueXDCe3FvvV
	0Rs0nFI9lkEA+JkcDNZmJ+82JpCMAJRZjORmc5wbfEgvfAI/Hqz2I6zZjAoEtjoOuq5o+GEfXgE
	Cq1jgDMPgbwoDZJktDm/XMtP4gUQRnHWt5xkn4S3yWSnTjEIudXvTTXhkxg==
X-Gm-Gg: AR+sD1276MXB9MZSvcpD1vOKQ+knHIf2VaBD7lJjT+nes/y49Q8p+jaiXw3EUi7aeU1
	3hy85yX+ksCyEx9QPhCANzJol+Ht9nMw7lJH6ATdFirGwHlgVw/kYf4WsYn6ntRlXpFk6M4jdcw
	KMPabasGrKqtAjmJas2Qr+vRAWKjo5fcjMyL1iEvh21jzed03o5ZopxhvJHOX87j1asUQh00nop
	Nh218u2zyallmUSFCSdHjAD36UU/v7QT3uzGKLgDlXo0eSpUGQc7JFAn9b+kyDM2pfWp0q57AQI
	WQ+iz7j2is0BrSy8Ly+NMaNrp8GGCkaEC8JfWKxr2g488hPagG2t+oNluW+b6P3YJlzDSIxPNCx
	trRlxMdL3VcmrLV+HULv3bkUorvYFefOc7yeZO/qVq2jKpWmVaIHmWlxdqBm//vGpEonjgAFVml
	x9sw==
X-Received: by 2002:a05:6000:2085:b0:47f:6dcb:3737 with SMTP id ffacd0b85a97d-47fb1ecdfd7mr3048023f8f.29.1785247410051;
        Tue, 28 Jul 2026 07:03:30 -0700 (PDT)
X-Received: by 2002:a05:6000:2085:b0:47f:6dcb:3737 with SMTP id ffacd0b85a97d-47fb1ecdfd7mr3047931f8f.29.1785247409495;
        Tue, 28 Jul 2026 07:03:29 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bd77a9sm55496191f8f.14.2026.07.28.07.03.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2026 07:03:28 -0700 (PDT)
Message-ID: <a4bda84e-3041-49b7-8863-e09862b2739e@redhat.com>
Date: Tue, 28 Jul 2026 16:03:27 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] net/sched: cls_route: fix fastmap use-after-free
 on filter
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, john.fastabend@gmail.com,
 jiri@resnulli.us, zdi-disclosures@trendmicro.com, sh.kalluri129@gmail.com,
 victor@mojatatu.com, security@kernel.org, stable@vger.kernel.org,
 Santosh Kalluri <santosh.kalluri129@gmail.com>
References: <20260723105210.817079-1-jhs@mojatatu.com>
 <3914dd5c-77c8-4f96-8bfc-986f0a00f722@redhat.com>
 <CAM0EoMn6sLJ_OMXY8-B4RE3r9XunFB=OkHbYJ-c-VBpADyO29Q@mail.gmail.com>
 <da0313c5-1060-49fb-a1a3-72197eda4d8e@redhat.com>
 <CAM0EoMkRMOBmrGW3fAcxxhTxcLaP44zr4m5Ds8G2VFT1CissNA@mail.gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <CAM0EoMkRMOBmrGW3fAcxxhTxcLaP44zr4m5Ds8G2VFT1CissNA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/28/26 3:12 PM, Jamal Hadi Salim wrote:
> On Tue, Jul 28, 2026 at 9:05 AM Paolo Abeni <pabeni@redhat.com> wrote:
>> On 7/28/26 2:37 PM, Jamal Hadi Salim wrote:
>>> On Tue, Jul 28, 2026 at 6:34 AM Paolo Abeni <pabeni@redhat.com> wrote:
>>>> Since there is already a
>>>> synchronization point for both reader and write while acquiring the
>>>> fastmap_lock, I'm wondering if something alike the following could work ?!?
>>>> (completely untested!!!):
>>>
>>> Your approach has some holes, example misses the most dangerous part -
>>> destroy(), etc
>>> I will mull over it and see if it can be fixed to handle all the
>>> issues. I think it's possible i just need to put time to
>>> validate/test.
>> I would appreciate that, thanks!
> 
> See attached. Untested (compiles) -  addresses my destroy() concern
> eaerlier _i think_ (unless something pops up in testing)

FWIW, the changes LGTM, thanks!

Paolo

