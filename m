Received: from mail-wr2-f11.google.com (mail-wr2-f11.google.com [74.125.225.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAD448383C
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 20:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787775858; cv=none; b=lyrzT9L7cCSePpcSrhmRSoRxtf6pZH8YvNLsHEKC56Ptwr5WquYblHbrNhfwYpWGiiaqgjHQLHSv9ChCN8fXRG+F9TRcmuPgwHeKZe0N1qoVWrqMPZN620rI/45T5X1F3liT+Kt4NbXd8U++xOmApeEM5QanwF0aG1p7gt7gg2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787775858; c=relaxed/simple;
	bh=JP8KsHwhOfS7nIKdqZe6YvWpPJlr0W0G7P17lZ7nTE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f/411YL+6yoOhr2o6xraoOl7x7EcjHpMs4761RWp4UTZxCgufZSqmBBl6yOi1WPo54+cv4nzDH3worQUhma1AzZFGpxQwZLH5giQPEq/DseJx7OR4smGy03qak2tLy93c0Lk2aDAthg27Mz4ZI1VJn5082KouqlQTkG9+K/cn1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr2-f11.google.com with SMTP id ffacd0b85a97d-482e1bf3f18so69607f8f.1
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 13:24:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787775855; x=1788380655;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oSC5H/8dRtlBh3kyNvSSD6HLC6+hQlda/xGM7prGyK4=;
        b=Fv5nwdDg6AuNVMQ9UJLn2voZunpTUtDFzx1Eyo4D+WS2AKpAOmsxQWf/DfEc+K7qa8
         wqtb23XcAdj/PAEjNrt26o5q+5wgiwpgscQf2E12yZ4uimTqPwdMA13tExh2WgkJaqWf
         bbc8XgeyY8Lz/fZxq1RjN2DIMv/L/cqAKhQB86+A/74flIG0HpNDS4ZNzK3jORDB/Wnb
         atp31wISBoo0taNDwdHIXV73HwTggfAFL7oCqyJkgnJjyLC18F47Cqf0Q/WduTJT80/I
         cibaZMAoUDBAlSO+BvoRDaGCpTLYDb742gVkBCk3nXFFICsfN/Dtr/m6SxCIECsKsb6W
         Y45w==
X-Forwarded-Encrypted: i=1; AHgh+Rrv27Nt17nHYKvnEISZmyQ6gJijaBaJaTExtUkccULuUpz1ahR0nmnNwg4z2AS3eOiz7333+ic=@vger.kernel.org
X-Gm-Message-State: AFuF++lKrvGPJZU6DrjZYCaRyDkY2luGhlMxttmy45QExyu4v+2xt7EH
	iKO4uU7lajRrzV6BWKWXeiiCZrOYAUhAD9bb1ilwku5JrTSkvOdPXYTs
X-Gm-Gg: AR+sD11EV1xy44lnY/WcjwGBNalhflGc5WxDgYzl1DaKi70XuzWm7bHFGPrsTJoYjRD
	9GaFvvvZDMkvJIP0+Q0iEFVNJAXbCHrl8mU9cFY1FlWQBfEHDMjOWoFsIiUMMFlNY5A5Pn7YxyC
	v8lnVKsgTCmg6p+uc9SHwU78R+3xWPoDq+ICqM1FbXOwVEEVhvhep7GPaPjFmBMW6vb6TVoKkYh
	Ziccf3nWJsQBZbxU49QTiuKRRqO+5217bt5n4krasywXWtvuRapy3DbkZxuwFUffL0zlb1vSgmN
	879Vml7WsTJAQFd4IYk55ifwz2j1KVeN0XWHI84bQYi4g4jkeXWrxf1vKGEduohxYGJldYPoImG
	cHGci9rKL98GTHa+QXV/pEkl1RU6gs/QXq4H+w4GzeFQrNKy2mI74CG8ZDSe1LXRbf/7aV/yXXb
	7PZNEWopU9H/Akw5SO9igsoNomxrUno2aU5Zyp0HZXvFJbntJWNwC28w2XAHPVo5QbjnmbSmt3A
	N3U13KS42g/NA==
X-Received: by 2002:a05:600c:6792:b0:49a:5b84:a1a6 with SMTP id 5b1f17b1804b1-49b0dec57b6mr17959785e9.5.1787775854527;
        Wed, 26 Aug 2026 13:24:14 -0700 (PDT)
Received: from [192.168.88.241] (37-48-53-4.nat.epc.tmcz.cz. [37.48.53.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b0dd3e148sm5514335e9.1.2026.08.26.13.24.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2026 13:24:14 -0700 (PDT)
Message-ID: <d0d6460a-20db-45f5-a17e-c777a9f832d1@ovn.org>
Date: Wed, 26 Aug 2026 22:24:12 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] netlink: specs: fix the conntrack filter type
To: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>,
 Ilya Maximets <i.maximets@ovn.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Donald Hunter <donald.hunter@gmail.com>,
 "Remy D. Farley" <one-d-wide@protonmail.com>,
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
 Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org,
 netfilter-devel@vger.kernel.org, stable@vger.kernel.org,
 netdev@vger.kernel.org
References: <20260825155832.3685714-1-i.maximets@ovn.org>
 <94842eea-a296-4ab9-a026-2475757a82b8@fiberby.net>
 <7b1f615f-d435-4b83-a180-67cf9a4223a0@ovn.org>
 <2e89120d-c18d-4d0b-9e7c-149611475271@fiberby.net>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <2e89120d-c18d-4d0b-9e7c-149611475271@fiberby.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/26/26 9:40 PM, Asbjørn Sloth Tønnesen wrote:
> On 8/26/26 6:38 PM, Ilya Maximets wrote:
>> On 8/26/26 7:20 PM, Asbjørn Sloth Tønnesen wrote:
>>> On 8/25/26 3:58 PM, Ilya Maximets wrote:
>>>> The CTA_FILTER doesn't contain nested tuple attributes, instead it
>>>> contains bit masks that specify which tuple attributes to filter on.
>>>> The values for filtering are taken from the top-level CTA_TUPLE_ORIG
>>>> and CTA_TUPLE_REPLY.
>>>
>>> As identified by Sashiko-NIPA[1], then CTA_TUPLE_ORIG and CTA_TUPLE_REPLY
>>> are both absent from the GET DUMP request attribute list.
>>>
>>> However this doesn't prevent ynl CLI from sending the attributes:
>>>
>>> $ sudo ./tools/net/ynl/pyynl/cli.py --family conntrack --dump get --json \
>>>     '{"nfgen-family": 2, "filter": {"orig-flags": 1}}'
>>> Netlink error: Invalid argument
>>>
>>> $ sudo ./tools/net/ynl/pyynl/cli.py --family conntrack --dump get --json \
>>> '{"nfgen-family": 2, "filter": {"orig-flags": 1}, "tuple-orig": {"tuple-ip": {"ip-v4-src": "192.255.0.255", "ip-v4-dst":
>>> "192.255.255.0"}}}'
>>> []
>>>
>>> Otherwise, LGTM.
>>>
>>> [1] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260825155832.3685714-1-i.maximets%40ovn.org
>>
>> The reported issue is preexisting and a little orthogonal to the goal of
>> this patch.  I.e. missing dump attributes vs wrong type of attributes that
>> are specified.
>>
>> I can add all the missing attributes: tuple-orig, tuple-reply, mark-mask
>> and status-mask.  Either as a separate patch, or fold the change into this
>> one, but rename it into something like:
>>    "netlink: specs: fix conntrack filtering attributes and types"
>>
>> WDYT?
> 
> I agree that it is a little orthogonal, but OTOH the patch doesn't really fix
> anything meaningful when the YNL spec doesn't allow actually making the request.
> The commit message directly refers to attributes not allowed in the YNL spec,
> without declaring it as intentionally deferred (like the filter bitmasks).
> 
> I see mark-mask and status-mask as a fully orthogonal issue, as they don't
> clash with the commit message.
> 
> I would just fold tuple-orig and tuple-reply into this patch, and leave
> mark-mask and status-mask for another patch.  Alternatively make it a series.

Makes sense.  I'll make it a set:  First patch will be this one with the
tuple-orig and tuple-reply folded in.  The second will add missing
mark-mask and status-mask.

Best regards, Ilya Maximets.
