Received: from mail-wr2-f9.google.com (mail-wr2-f9.google.com [74.125.225.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C8B559C8E
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 15:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790090973; cv=none; b=SIq0sH7OfUWFZ8dNu17VQBkiDa7jAt4YCGhwS4RJF2PhfJy1hYadk1hoFFkSFRfE4QGSYRM5nVi+l7stfHiNko+79yP3w0MibAQK7Wxq1MVyKW8cAgVlOf9RYUPnR8BCog9nkH/xjUhiRpOKyeYTTxoTi6vJu6cMk7pVoIE49NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790090973; c=relaxed/simple;
	bh=WGdxf4JWgsj7qXEES4uwLAJCsB8IbrSJIDy8qKtOpcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rbGDw3PY2jagVhwvP0kHtjX5i/Yqky+tg6G/PezI9OVki6gvwHuNP9HSnSJ6M81FFXCQpQ89iuB0qCXH9A9BHVgHpoNVhCCPQ++pnsj/YIjZkA8pzTImfSCtmBYYRIAmfFsnvHMRu7uTNIIzmNqWCVX9p+bSyDg/Y1CRZtIt4m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr2-f9.google.com with SMTP id ffacd0b85a97d-484392e3450so11305f8f.0
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 08:29:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790090970; x=1790695770;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QFN5eT2UnxXyQbw0Bbtp+XvC5zxP4g1xuK4mAIg36L4=;
        b=RLbU/PV2lO4lM+wUyu9XOponx7E7Hu2N7B12SpWhk14JkpTDRBT33VW45IihWsGBKX
         UaLqCCbiPD3cweImrBbL/WZAdMAbwCbaSvcfRVUNzr1dNX7vslDLtQdQHgbyhryFageU
         LgnyNGhQ9XLStfzALVPx8fUgjCvBTyTwck3saKFXBtCevSZBhUnTZQUR5Ey4QKqhAKwc
         AqPVWZ2cU3Kr4n8tfWzMj3D1/XOt9blE1u10ZtkOPfCigMGj9UH+AkJGrnQr53SpQpKa
         YpGeckBok8VTW/kRrigCo24s7Jop9+b0BzWwY1G9H/EE4Ov6SnnsUyileKn8SERz+iKm
         V2cA==
X-Forwarded-Encrypted: i=1; AKwUvBxwyB4LpdrPxMMzP8I2jbU6n1nfChPAkhRNJk1METnAfaWZUCiZ8xQt+8qdzGYSPptl5TmrqsA=@vger.kernel.org
X-Gm-Message-State: AFuF++nC7pfEHtwA+yiq/EtfRr/j62dGyBBxvwLL90eGqs7Rr46ZAMqz
	L1s7Nx3g7ZqGzaoIsQtVatXL98jN5q3HuvGN/daj7RE7bmuthw9jzz1h
X-Gm-Gg: AYBFou0E+CiFIz7818i/aCj36pgGIgPYJuMtsJKAULw/bNaT52rEhl4fDDMr3NPeS11
	kjmE2Mzakw0iTMkbddSLGYQc0/8Fe99BCOvv6sEZMe42vc81B8MdFWir01gRtOFWcyv6hZJSyu8
	iQwGe54a6EOtwtg1TGl1dld8yTPfSxFnP4qwjpzkL9ZG+JGSheSLBNdyzDA0PcgLDBBYZ+ksEDp
	inwbd/FbeXDBoLmd9GyjoS7g/HoiXrfCm9UAXszjMIZybRbK4BMMnErh+impSPgZC3hvivI5MPv
	FoeSoIrc4raN9arKEy+rlJp7Y3/dNyATGSWnXv2uP1zDtFSlFAiVUQozlHqcxPk79nBQAe8y6kM
	4CKQ0eg6H7EhobTgsRXJ46Nu8eBp41EflD1Mi98PNNwC8KsL9RnbD3lfbkwAkEf1e0R9ImCb2WE
	yuLtKhbxX0l4hxsRu3dMEv76uFQsI8ngaDzsCqih65MWFk8yYzw0ZwpV0fs5PaqbtDHU7HQBfag
	2MODxLJMZlVKd9ed310OFEKRLuhSdRvf1WMf/v9s8LCrbk=
X-Received: by 2002:a05:600c:8b10:b0:49d:2936:8ad1 with SMTP id 5b1f17b1804b1-49fd8853834mr49427975e9.1.1790090969679;
        Tue, 22 Sep 2026 08:29:29 -0700 (PDT)
Received: from [192.168.88.241] (78-80-107-225.customers.tmcz.cz. [78.80.107.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fda8f04f7sm96753605e9.0.2026.09.22.08.29.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 08:29:29 -0700 (PDT)
Message-ID: <e3e001ae-cf08-408a-9059-4255de915110@ovn.org>
Date: Tue, 22 Sep 2026 17:29:27 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/6] net: openvswitch: conntrack: remove 'add_helper'
 dead code
To: netdev-bot+sashiko@kernel.org, i.maximets@ovn.org
Cc: netdev@vger.kernel.org, pablo@netfilter.org, fw@strlen.de, phil@nwl.cc,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, aconole@redhat.com,
 echaudro@redhat.com, jhs@mojatatu.com, jiri@resnulli.us,
 lucien.xin@gmail.com, marcelo.leitner@gmail.com,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 linux-kernel@vger.kernel.org, dev@openvswitch.org, stable@vger.kernel.org
References: <20260921145655.3167436-3-i.maximets@ovn.org>
 <179008911774.2160803.5007856848467620850@kernel.org>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <179008911774.2160803.5007856848467620850@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/22/26 4:58 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in case
> you want to address the nit picks below when you respin.
> 
> Low priority / nit picks for your consideration:
> 
> - [Low] Concern: after this patch the comment above the helper call reads
>   '- nf_conntrack_in() was executed above ("!cached"), or - When…
> 
> --
> 
> net: openvswitch: conntrack: remove 'add_helper' dead code
> 
> This drops the add_helper variable in __ovs_ct_lookup(), since it is only
> ever set for unconfirmed connections while it is only read on the
> confirmed branch of the helper-call condition.  The helper-call condition
> is simplified to nf_ct_is_confirmed(ct) ? !cached : info->commit.
> 
>> diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
>> index a733029c28dd0..c20f096eef40e 100644
>> --- a/net/openvswitch/conntrack.c
>> +++ b/net/openvswitch/conntrack.c
> 
> [ ... ]
> 
>> @@ -821,13 +818,10 @@ static int __ovs_ct_lookup(struct net *net, struct sw_flow_key *key,
>>  		}
>>  
>>  		/* Call the helper only if:
>> -		 * - nf_conntrack_in() was executed above ("!cached") or a
>> -		 *   helper was just attached ("add_helper") for a confirmed
>> -		 *   connection, or
>> +		 * - nf_conntrack_in() was executed above ("!cached"), or
>>  		 * - When committing an unconfirmed connection.
>>  		 */
>> -		if ((nf_ct_is_confirmed(ct) ? !cached || add_helper :
>> -					      info->commit)) {
>> +		if ((nf_ct_is_confirmed(ct) ? !cached : info->commit)) {
> 
> [Severity: Low]
> This isn't a bug, but does the reworded comment still match the condition?
> 
> The first bullet now reads as an unqualified statement:
> 
> 	/* Call the helper only if:
> 	 * - nf_conntrack_in() was executed above ("!cached"), or
> 	 * - When committing an unconfirmed connection.
> 	 */
> 
> while the code only honours "!cached" on the confirmed side of the
> ternary:
> 
> 	if ((nf_ct_is_confirmed(ct) ? !cached : info->commit)) {
> 
> For a non-committing ct() action on a new packet in __ovs_ct_lookup(),
> cached is false, the entry returned by nf_ct_get() is not yet confirmed
> and info->commit is 0, so nf_ct_helper() is not called even though the
> first bullet says it should be.
> 
> Worth noting that the following patch in the series, "net: openvswitch:
> conntrack: fix helper UAF due to extensions realloc", rewrites both the
> comment and the condition to:
> 
> 	/* Call the helper only if nf_conntrack_in() was executed
> 	 * above ("!cached").
> 	 *
> 	 * For unconfirmed connections it will be called later during
> 	 * commit as we need to have all the other extensions allocated
> 	 * before the call.
> 	 */
> 	if (nf_ct_is_confirmed(ct) && !cached) {
> 
> so the mismatch only exists in this intermediate commit.  Could the
> deferral note be pulled into this patch to keep each commit
> self-consistent, given this one is tagged for stable?
Comments do not need to spell out verbatim what the code is doing,
it is pointless for the most part.  The current comment, IMO, is
conveying the intention clear enough.  It is also re-written in the
very next patch.

Best regards, Ilya Maximets.
