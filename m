Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A698480949
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 10:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782986540; cv=none; b=rFpeamMKLEfLTnPWaPoaRhlbDMGK6F8MtiEC/OqYGotPB5njobf1JQ0mqgxhQMI309ooYC1e695ddBaqeS7kxH3d70tHatxKlj96mgrBKCBt6S3NlVvmLc+hoirz/VR2J0unPBebO/G3LlLJAfGBj7i4Na0fTSR9qV0S+XgW1jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782986540; c=relaxed/simple;
	bh=l/4zG+3D9ejOnVWvPH58fKkY+gswQsvE7oQpLDlZzVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ll2b2pLNu6EOGbYQHkGAsEtgjif7nwMqZW8daaqamy/dgP5AyHEpxtJLX9rzwDG4yBevrPSRp3a6EcpRUSK+lNzjtfbHYBqpQyxwNxsj24q2Am/vBikxvsrzQP+75FjdgrRSNFiXnStskh9vINfExzQJMSGHvszcrAt7OG5gq+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P5ms3SYD; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oastiVx2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P5ms3SYD";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oastiVx2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782986538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LfUu6pC7EJB8qiPkqY3N8+Svxs7+7n13Ik8Ta0Guoyw=;
	b=P5ms3SYDYuxgXZ5OShfS9Iehx4CCpELFuI/MNI2jdAPWDWuSOmcH/VtTl2Khni/rCAhIBU
	iymC6c0tpC8Wj64FkLNvm5d8qO/AA/05+5NsA7OxQA9kHVB+VRJjyah/0RHLLUEQlKEFMj
	rbxByKwF5AHCzXobguEj9j+a7V5QKp4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-gohKeCYTO_eLcedJJJrAsA-1; Thu, 02 Jul 2026 06:02:15 -0400
X-MC-Unique: gohKeCYTO_eLcedJJJrAsA-1
X-Mimecast-MFC-AGG-ID: gohKeCYTO_eLcedJJJrAsA_1782986534
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4926d371224so12757615e9.1
        for <stable@vger.kernel.org>; Thu, 02 Jul 2026 03:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782986534; x=1783591334; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LfUu6pC7EJB8qiPkqY3N8+Svxs7+7n13Ik8Ta0Guoyw=;
        b=oastiVx2aWNgeMvEzBzlDXTp2ULJOG/l7LYkAbG+jAOtHz8SUtTId7wAaMBI1ggp5J
         OWjur+qphQ8MZjdkYQDqQpqnY7zXxkwPETVtoS2/1d8a39uFAJpLG5vmbuqYPWj0HjTc
         j7NU0NzCdGzMYlP7oI40QD9vMonxi++xemoogK+nqJ/S1CIwFwaOzj71aWwXqpa8EmrR
         bNwSK7xwGq4mTXih5i0KMlYoz1WiBL91SGTyqFHafq5ba5a9/LKViSZwW8XuR5FEZe9U
         +Ht45Jc1IBRrbbiTz85wwz/3NMaod8ViFir2t3OtX3C5unzc8GPvLaRwBBEUfGXip8k0
         XTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782986534; x=1783591334;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LfUu6pC7EJB8qiPkqY3N8+Svxs7+7n13Ik8Ta0Guoyw=;
        b=C0VNhcm9ksVg7Y/R5gy4DuwIviYntt/7UGp2OLr5ENxZ92LUmmRlPswodkVaiqPsAs
         Ebkgda9PL85fWhsmGFLZeY2Bj+KTIUVO/i3oQcV1D3ifaKZqBBmkLhlPWDYQae2zH9ME
         fv6G7q7TP8AkOjZ8ke37MzQVmlZO3OAkLjsDNTJ7dyMzUca7sxj1rfbF7kQG/0qK2llH
         GdzC/BW1WL+wpIPfpI7AX19P5fK1ylWlpRBniYbny873On6aI9bDimC6zDDfjVmejSc+
         aGkdJJ9L0oEk2E1tEw7diIBSS4/Am5sBDFpdYqmkQOe/sCCj+MtjSJtfqM2/B4IsyPbC
         Y7nA==
X-Gm-Message-State: AOJu0YyACp5RpKra6waiX/3CzUT+6zDUEoTvaC6uagyPqOtUWwHwFs3F
	ccrnpZCWW1ER4X+wPtg9Xf16pM7ezuAXu0rgWqVNWXX/8tKkwEyPo5CuYveuEoBzSLTFv1Wiwa0
	5i8NXEFIYNCVTJCNTikGoeGS7DXWeUGeijAizl3sZxFnkoIdFD7Hr3yOqBA==
X-Gm-Gg: AfdE7clEil17mvLWGqHKuexJdvlXLJBDkegTVqjnBB4F35M/QNWI8A5gtpxcFiGAcWM
	GL2FRs+vTst9x8Zzd8LCPnaAd8MsUi09H2KrjMkVavkt3y2EKEO31Njt88kgAKp/bsiYYkoqGtO
	N9dnijCO34Hj+xV6GqbAgmDShiZFokft+hKMwdlDjMtgCG/tVUslrQBKltNyNgssY94rFQuR4wA
	R/ZSp7Sael/TbvF+ge5swxniDujnBcAw0JcF2FpBIuv9dhhXcBiDq65qONt6eqGxl1VKNAVWgIz
	2xoYvaqtPYVnrbH7kWw4o2mmnmmoiuAgSfu7tgyEo29UYBDUEo6jxJ2gAL49f5+qlrqhg3lAxSX
	Z/v5LftEs40Gh2UdGENPMJW2yocWlkPHeZoTH20EAJUJciH7Wj/aSnH28OnKjStVNIUYngNcehK
	ZC0pf52PV1Og==
X-Received: by 2002:a05:600c:1547:b0:493:b729:3a9 with SMTP id 5b1f17b1804b1-493c3cfb04fmr58962335e9.27.1782986533607;
        Thu, 02 Jul 2026 03:02:13 -0700 (PDT)
X-Received: by 2002:a05:600c:1547:b0:493:b729:3a9 with SMTP id 5b1f17b1804b1-493c3cfb04fmr58961865e9.27.1782986533117;
        Thu, 02 Jul 2026 03:02:13 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:2eb7:f61a:75:4534? ([2a0d:3344:5521:6b10:2eb7:f61a:75:4534])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493bef17c82sm80193455e9.1.2026.07.02.03.02.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 03:02:11 -0700 (PDT)
Message-ID: <3f540a8a-4167-4727-9516-6fb91335333f@redhat.com>
Date: Thu, 2 Jul 2026 12:02:09 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Subject: [PATCH] net: gro: fix double aggregation of
 flush-marked skbs
To: Shiming Cheng <shiming.cheng@mediatek.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 willemb@google.com, daniel.zahka@gmail.com, alice@isovalent.com,
 sd@queasysnail.net, eilaimemedsnaimel@gmail.com, imv4bel@gmail.com,
 nbd@nbd.name, dsahern@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Cc: stable@vger.kernel.org, lena.wang@mediatek.com
References: <20260630023512.26927-1-shiming.cheng@mediatek.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260630023512.26927-1-shiming.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Note: the patch subject is quite uncorrected

On 6/30/26 4:35 AM, Shiming Cheng wrote:
> The new skb_gro_receive_list() function is missing a critical safety check
> present in the legacy skb_gro_receive() path. Specifically, it does not
> validate NAPI_GRO_CB(skb)->flush before allowing packet aggregation.

skb_gro_receive_list() is not very "new" and definitely
skb_gro_receive() is not legacy.

> This allows already-GRO'd packets with existing frag_list to be
> re-aggregated into a new GRO session, corrupting the frag_list chain
> structure. When skb_segment() attempts to unpack these malformed packets,
> it encounters invalid state and triggers a kernel panic.
> 
> Scenario (Tethering/Device forwarding):
>   1. Driver: Generated aggregated packet P1 via LRO with frag_list
>   2. Dev A: Receives aggregated fraglist packet and flush flag set
>   3. Dev A: Re-enters GRO, skb_gro_receive_list() is called
>   4. Missing flush check allows re-aggregation despite flush flag
>   5. Frag_list chain becomes corrupted (loops or dangling refs)
>   6. Dev B: TX path calls skb_segment(), crashes on corrupted frag_list

I can't parse the above. Is this something that can happen with in-tree
drivers or do you need OoT module to trigger it? In any case please
clarify the actual order and the involved driver. Possibly a stack
strace leading to the critical aggregation could help.

> Fix: Add NAPI_GRO_CB(skb)->flush validation to the early-return check in
> skb_gro_receive_list(), matching the defensive programming pattern of
> skb_gro_receive().
> 
> Fixes: 8928756d53d5 ("net: add fraglist GRO/GSO support")

The fix tag is wrong, should be:

Fixes: 3a1296a38d0c ('net: Support GRO/GSO fraglist chaining.')

/P

