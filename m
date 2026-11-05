Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793918606;
	b=OgHaMyBxytXWubuJohco/leFeAw8Yz4EqWbuC1vI4uCCKNSywrLKO1BMmpp34Cr1eRyK
	 PpUgmsk/VwzK7LYGmn9TXW38SEsjCThGVruzMTSWDggwZ+Vnm1Oick6zD5VZnMso+YwI3
	 H4mBjxM0CAl/To2CQc96R6MNepTufFrOtDMPGO14ne/kQHihU7ixOa+iVZZ0seQTcCDW1
	 2eWgxPA2q586Br8kOeitvbal3VrNIBfqm6C+fU4cZbjoI0UJqDvTSiJ8BTDRTODfqYq5e
	 OTivt0D7MrvMZl+SpeMACNgtNLvFyBdnQQpuKoLXht9rAnFfSgK6tGr2z5YJBTeWtCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793918606;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=JOpRBPshV3gRP/lPEEbp1JMlpxX4CyZP+32ZaHNPJd0=;
	b=uCTwakbaKxn1PjHT4uHqa4d5GC6TXwKBrJP/q21oQ9PtexGIzfUYFBBrDPw2yuB4M4BW
	 64GYOmxwtjedMZg7IcKYvVXmSsyidNBqpB9DSB14PdgEyMLpTSGKsE/1VYcgI+e4qqSAr
	 6Iob8bQJVkLUzM4vK+eQusgUWgWjIo/NZiVbNnpksNJKovaYKKzdJjp1Rz7eztOaF8rdI
	 KqR/r7t3OLy0opfdl5MU1FWn4oS3DKg+yrX+FBd1lFC1zsEhtBlUBSyL8XSuG8/kuoznW
	 JAvQWIEhdFZptx24xATuXafyRJ65/o6PQ/PmkyvtFg9uGqZIvBhRYnNVxhNXeyW2GPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=TrD7Cxpu;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D51606A326
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 22:43:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31D51606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=TrD7Cxpu
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4ac95761c85so192865e9.2
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 14:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1793918599; x=1794523399; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JOpRBPshV3gRP/lPEEbp1JMlpxX4CyZP+32ZaHNPJd0=;
        b=TrD7CxpucIFDuoAAY/Fvrj2jfILQmhNwzHdFdCRXPCKVoHUIEwuUgoot25W0qsUDDf
         jPvxuQEWGYrKZoZ1/7z+cwqm3lRJ0irRQMoAUDmFJKVlWsO5y7tL6Z6V0w0OdjVw7TCH
         WHY9G6871WNF6FJUKFYj/14I+0N4ZE2xTiuVYSDYLhzBm7O2V3X40HgC7eKL7qY2C7Tu
         igjHHtiqCol764W6FpsRczGLkJzOADgMTgTuIgG5oKVobZumKLixG2hDCUEqq92Joq3F
         TmeIpDNDkPB9ZmVaP5kZ6TLmE098EcltprL+IUs5KbTqxA8/ws84Q8cSmMRDgYCgUplC
         AHrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793918599; x=1794523399;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JOpRBPshV3gRP/lPEEbp1JMlpxX4CyZP+32ZaHNPJd0=;
        b=cYUwx7DJxpQ7MWStz5jMQ5jzym7JDFCW5FoodNiYPbIzPDzZFSfLxsOsPp5FBXRN3r
         t+fD9L5VsBXV9O+/SoL8Wd9FeQrMaDkjFmSok+9Nk1srll6sLnzzJNc1vYmC2BUK5V3E
         Kvqbf+1dS81AZp6AbEWI3ie65RArE90PGHfd8rbZhZvAP/A5aIUrgBNlVUSByesL263+
         JA5jg/ofPIBn6uS44MC+bUCOzrHnW0ckaQ9eT+pgA0TKpm5Z0/vQdoNb+Wjh/nfNKwvy
         2SlYuEicM8kz6FLjWAtmYC+SA3SdbKATAtLjfC9Y7sV/9OcQOhf1rP7SGID7f1+fA0T0
         e7IQ==
X-Forwarded-Encrypted: i=1; AKwUvBzv974cNvBOvP+7RCXvOt0CF7ymVaYmWEZty2gBxyokrsfD8hbBmrNS5jt8IbGuF6ESV1oemWg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9RNJgDchYoiOD8zrbkzTTpTUQ6H8HyWe/VlyD1pWaW9A7WIrpj
	hnoHKFPT78A9t9U2xL+p+sReRCvgqTL7O7q3Oz/6UKgPz8B5O4pKGud9Vif8QcFw1zk=
X-Gm-Gg: AYBFou2QVLr1hdp4GloAVwVU5BlxxyjNY4LnVC5qa4tGS0o43K2pP/5RDTRiQeMCuhW
	FaVjSadObHqqjzJ+xXRFDNxaroZreAuwF2bJ+r4URpfPuVR6S4VjJsUbdU7pnsJ+qDJCopuQXIu
	LrQ6mpITh1X4eQrBxtS1Hj1b0q1H9MvjB6es1k+R1hFwZIotyjleKbOqW3KbkS+a85/ELJ8mt7Y
	a40B1FckrXQsmI5p9qXO4mNln1xL/ltQK0n9ZmNxo7laLtqdrKbnKQwEud7y4gbYSyTvy17lzPX
	4v1HVJ2pTakdLQThX779TlgcioOIGEfUKSN3VMoRcXVGNRSAVzHl/7oU1gYmUTNBstqLVfZJ+ct
	DtD2dROojXYqbBoGz1fqtnrPgjM0rdk2fPMUQwGIeQ1TB3QYd/VRlaaaVfAZY5Xm0q2FCHF85lR
	0EckuF4JjjXgcozmk7/rT/zO/kwBrHs8h+bG4GchQjPtO+SWt500BTrTljfHwLCJ3nrzTGvOlj/
	FUr9ozdKGpeNNWU8qeMrR9Go+g7A/hNmDwTbc5KsQGYe/p4gOQrWD8BvdCN5vYB2HH5fjM0/xJ0
	C2XYI9ASNQ9Y3Qih2cPR
X-Received: by 2002:a05:600c:3f12:b0:4a2:1a:a11d with SMTP id 5b1f17b1804b1-4b6d82b2c91mr9773435e9.0.1793918599570;
        Thu, 05 Nov 2026 14:43:19 -0800 (PST)
Received: from [172.16.0.229] ([159.196.52.54])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0d7c8a3d9sm1005430a91.10.2026.11.05.14.43.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 14:43:18 -0800 (PST)
Message-ID: <c6d8ece0-cbb8-4479-977a-6306b1c02ae7@suse.com>
Date: Fri, 6 Nov 2026 09:13:11 +1030
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
Subject: Re: [PATCH 1/2] btrfs: overwrite a leftover balance item instead of
 BUG_ON()
To: Siddharth Mishra <smish149@asu.edu>
Cc: dsterba@suse.com, mason@kernel.org, josef@toxicpanda.com,
 fdmanana@kernel.org, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+dc9291cf132691aeb478@syzkaller.appspotmail.com, stable@vger.kernel.org
References: <20261105214738.111967-1-smish149@asu.edu>
 <20261105214738.111967-2-smish149@asu.edu>
 <4c59541a-3f19-4ad3-bef3-59b9c42c2e90@suse.com>
 <20261105224022.254528-1-smish149@asu.edu>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJq3ujyBQkUpLw5AAoJEMI9kfOh
 Jf6o8OIH/0mqW+TQM4m2x3hCsnK+oB4yJH1qnGvIhFF/Lhs48wI02sGh6/4aA0hkCDfd9LHQ
 +ci4FUepZ9y4VS01+oIExbg/8ytzGYTzLtb44jK2GBOBVSJkMiha6jp22XFt7WUkT/tvbreu
 WWdGsaJIRQaZChy7xsMI8lqQ2WdmluZJ4LT0wD3l/l6QU1ZseMGySebdY9sVOQEOJNV7Qj92
 /KOAFNmeZshV/qDI8Iw1RTs6TvLqCcqmlZLCmJkYSVhT1RonWRren8xIRcFEgMe004IDnt7V
 qdQhk/nhTS9x9MBAhMRl0TTE1VKDLvVALsud3iZLrmmtYvwPApzGJk052f0m28vOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJq3ukKBQkUzDspAAoJEMI9kfOhJf6o
 SNsH/1ysUWOKmzY0rGS3ZdS61QgqMGhSWD/EJ4UiPw+xO4l4+GtX0fOAqxqsmBKqje3vyhBa
 Z5o/1Y+gNiN+E6RBcSz4b1TAd78sQ2bvT5DWOvBjeeVxHdiuQMIn4S8xk5ZpySBw5ifjoiuL
 0M33UVtJOzM8yfAeL+d/Rp4leJw72SutjkLyZTG/gJIp4pJGD/kFHn24OLL0IxEcO0gOekNZ
 os5e1R6jAJ2ILk7+MDnvU8wXHcCiVzuDhJLI1tih1uUIE50muHQJWbYuVBbdJeu8WlIDDssx
 UOCxLylNG3gDXV5MhLubPTOpp9OiFc/XC37nvkgEcrlmlOFBv4/NJCbECpo=
In-Reply-To: <20261105224022.254528-1-smish149@asu.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/11/6 09:10, Siddharth Mishra 写道:
> On Fri, Nov 06, 2026 at 08:39:01AM +1030, Qu Wenruo wrote:
>>>
>>> Both assumptions can be wrong:
>>>
>>> - insert_balance_item() inserts the item, then commits the transaction.
>>>     btrfs_commit_transaction() can fail without aborting the
>>>     transaction, for example when btrfs_start_dirty_block_groups() fails
>>>     to allocate a path.
>>
>> I think no call site can handle a btrfs_commit_transaction() failure
>> without transaction abort.
>>
>> This is a way bigger problem than what you're fixing.
> 
> Are you suggesting that the right fix is to make
> btrfs_commit_transaction() abort the transaction when
> btrfs_start_dirty_block_groups() fails?

At least one should check if all btrfs_commit_transaction() callers can 
handle such error correctly.
