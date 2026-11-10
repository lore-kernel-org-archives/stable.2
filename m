Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794322107;
	b=uz07Irul6uqNKQTBwS7hzoWUBk1Rve1kuFbRmADonQ5SLBhkiRZomzeWzaqnKa7bjnU3
	 qpks11hWwCYM550JPyq1jRuMVWINMmeWEtG49T8KKgwI/sEmH/EwhYaa0r1E7Anp4uJTt
	 qFWjgrDg8jZ8qH1LCuNhSrDs9Gs0mBau+vPvbP5C4QrZEIa9fr1y+1wFf1OTV1T0K2lge
	 JnvGmMTvaImv/WyjmHmRHzuc33ez+WoCbtEupAyHszCNiEsV/pgCe12U5PRCleBRwZRhg
	 a0P+c4rnnxJvfHaaZecj8VRxqRakUuDDAqIQJuLKwQJrLLTlaXCLUnhIMbVuPjSpzIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794322107;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=HReSs8xkCDmn2RFbwNR87Z/8FnpjP8wlH/AJisucaVI=;
	b=RM4kYTJaAjhDMYV8E7UolkbbOhbkn2FEhr6MyWX7vKi3+SY6pbhgH8CvsVfBWrorMuwl
	 ebR7poDAN0Xy8m1km3PU8SoZIBy87L+H0W9IT6pziai8oEJVI+IwBlwMeV/RqzOdwk0r1
	 HGIVsVpaXaXOcRG4bNTEzGN7ztXpWELhshPYZhZaBR+TiRT9d8CmI/f+0y9IuIiXvd/BD
	 YNUjknmvkrvcE1U2jmIy6LVN9wuDh4BWX9/G4bWLa0KoGczdVzvPi+et1YjQBki4x8+jy
	 RWne2Vvmtb4ut219ILyEURd+jNdCleEl6naa79Kuv2wsXDniepu90CNH3X4wiH0kEXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AYsLXZ6h;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Mf6rZt+n;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC5860A263C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:48:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6EC5860A263C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AYsLXZ6h;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Mf6rZt+n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794322105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HReSs8xkCDmn2RFbwNR87Z/8FnpjP8wlH/AJisucaVI=;
	b=AYsLXZ6h6f+QuUpSoEB0XZ+OUuaI7ryBuE2F0uz2IbU3BkAD3TzBZuEud8sg7MDJYA4KJP
	EOZ9ftjO5LvVACZRht/BpHPY9y+YewgV1HE3nQe/Zw4mNUmK9E3WiCVnzmOCwazlUckSGs
	Dnhidj9V08OTktnlKH+8DBKSJ5PDON0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-oeyXfrW6P1y4GAyc6fXTXw-1; Tue, 10 Nov 2026 09:48:24 -0500
X-MC-Unique: oeyXfrW6P1y4GAyc6fXTXw-1
X-Mimecast-MFC-AGG-ID: oeyXfrW6P1y4GAyc6fXTXw_1794322103
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-49034831bb3so1931086f8f.1
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 06:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794322103; x=1794926903; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HReSs8xkCDmn2RFbwNR87Z/8FnpjP8wlH/AJisucaVI=;
        b=Mf6rZt+nD0M+rzWE0lWoLCFKpzfyNhmhY1LwHU1meiHNXvEGhs2nOMiZw1kQcl9G1+
         a6rH4ietR3qT5b57+xAyaAqlteNshFhigxaYbdWCvFq65c/pNmvaIkwGCj/Su/q0BTm/
         JgolJ/fPAZSA7Kz5+e6JrA+7jqNqUuEU0lGjc3wGqPbB5vlv+ayajVb1rJekLo8aNtD2
         t4SMKnUFs5q+jo/gsIkUCg2RtcKMgtYvSChKgnteCPIR/o87uxODFeL4NR+7ruYlHkIs
         +VFfo+x3XOsyEVDuz32CvNxlx2AuOSmam8Mf32O4WuZ1jdCxz5X8wb2cXxBeF2UDDQlM
         LMxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794322103; x=1794926903;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HReSs8xkCDmn2RFbwNR87Z/8FnpjP8wlH/AJisucaVI=;
        b=fUHUTSAu479BxmZa7VlHOctn+TKTA9wysGhWY9NR0nNu8+W2wPtPCtmosg7Ug3ocht
         GZJk7DgacFnpc5VeevJ4B17U4kWLG2pkWj4z1dHbSd1xqMlmuXMWqRmz6AkzOM7N5jad
         tb7LF2+jqoYZUP0fOqIoplhlhfUjGpKVwK59v+wrwPgfmDca+X/VLAWH2/Yc8er+9KDG
         5OZLxvJZHXn2qu6fLBgiS8CDIb9K+BsfTQdkkNZiRvvdHvlSoh61fhpRyNDg/6SF+/QU
         7RQ8laPnzuyIz8rl8gNRmkc/6oFmkKg7eHx8GXaKb5T9ng7n7BiQxVjwzJEUup4SLm+X
         nLgg==
X-Forwarded-Encrypted: i=1; AL+hErGlO78hr9sNQ6h3qLOc/mssIKeyWlrJ2cNmBNYAw1IXF0UGgNnxBm/zR95BhJ0qqRwGR+kkj4A=@vger.kernel.org
X-Gm-Message-State: APuU4Z/TP3tYOpeeSvT3WVfaLxCNfkEz7jJXs4PddR8vB476D0uTy+oK
	RptNMnRNDceOKLGE1tX25dwdv9aoQZPg34I8SuUD86tucQ+CGj/HlOtS8MvUa9Xyoga/2RAec6E
	cR6ECqSnaOUvo9hXB81e+YQuIKCBzPjG/x13mpBw4jD9SvjuA4EoEr6DjSg==
X-Gm-Gg: AYBFou221ybazFS8PGA8Citpasc2OXR18t35qVVe0Osu/NLCkD9wXLML8GDMHNbMvzV
	EpjykH/D2VKyUH/RqAZYG/hAtzF3DPNo9qB14w2uO0sAtC2loxrgQpbONS4rHj7rpRDWdvXb8Zx
	PRJLtLpAnvUlKlynM5qjmz6nzT6Rq3t+sO3GZ2niqVY9j6ggB7WGT7RwMlKuUNh77/Aix3d3KV0
	z3rbwp+56b2ojfneeNINU+iorA++SggdpTpWqeXTkeXRD3aeBV2EIOSmoeOsqAKQDAIoca7wo1y
	ryNm9k+vDcCqVRl9TN9Ettr9d9NKU7KCYHZxCRDWEhmodF2uAcNTkgEq1xf2vGT1fhsyWVMUo+I
	e9C57kD7DtPzmJ1lOwS8Xw4xMXVED4KDU11tfLEoDK6ERzulb1QnN+2XJR/aucjVf7G/3EG6C57
	rZ1r5EdaNrQaTeZHThbEWc9rVTecycvzFw7P6lEzhFr0TG
X-Received: by 2002:a05:6000:3ca:b0:48b:174:eab1 with SMTP id ffacd0b85a97d-49830d81adamr5057442f8f.36.1794322102661;
        Tue, 10 Nov 2026 06:48:22 -0800 (PST)
X-Received: by 2002:a05:6000:3ca:b0:48b:174:eab1 with SMTP id ffacd0b85a97d-49830d81adamr5057392f8f.36.1794322102119;
        Tue, 10 Nov 2026 06:48:22 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4983585923bsm5635389f8f.11.2026.11.10.06.48.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 06:48:21 -0800 (PST)
Message-ID: <984a9f14-d8d3-41d4-a846-6750f710c741@redhat.com>
Date: Tue, 10 Nov 2026 15:48:19 +0100
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
Subject: Re: [PATCH net] igb: do not let a VF set other VMOLR bits through its
 frame size
To: tkusters@aweta.nl, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Alexander Duyck <alexander.h.duyck@intel.com>,
 Eric Dumazet <edumazet@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>
References: <20261104-igb-vf-rlpml-v1-1-729621b60eee@aweta.nl>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261104-igb-vf-rlpml-v1-1-729621b60eee@aweta.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/4/26 07:34, Tjerk Kusters via B4 Relay wrote:
> From: Tjerk Kusters <tkusters@aweta.nl>
> 
> igb_set_vf_rlpml() gets the maximum frame size from the VF's
> E1000_VF_SET_LPE mailbox message and takes it as a signed int. A value
> with bit 31 set is negative, so it passes the "size >
> MAX_JUMBO_FRAME_SIZE" clamp, and it is then ORed into the VF pool's
> VMOLR without masking. Its upper bits set other bits of that register,
> such as AUPE and ROPE.
> 
> A VF whose port VLAN was set by the PF has AUPE cleared, so that it only
> receives frames tagged with that VLAN. Through this message it can set
> AUPE again and receive untagged frames. It can also set ROPE, so that its
> pool accepts unicast frames that match the Unicast Table Array; while the
> PF fills that table, in promiscuous mode or when it has more unicast
> addresses than receive address registers, that is all unicast traffic.
> igb_set_vf_promisc() does not offer this to VFs.
> 
> Take the size as u32, so that such values are clamped to
> MAX_JUMBO_FRAME_SIZE, which fits in the RLPML field.
> 
> Tested on an I350 with two VFs and kernel 7.3.1. VF 0 got port VLAN 100,
> and a test build of igbvf sent its frame size with bits 31, 26 and 24
> set. Before this patch, AUPE, ROPE and STRCRC were then set in that VF
> pool's VMOLR (0x8f010bce); with it they stay clear, and the size is
> clamped to 9728. The normal igbvf still sets its size (3022 at VF MTU
> 3000) as before.
> 
> This was found by the Sashiko AI review of another igb patch.
> 
> Link: https://lore.kernel.org/all/179370458190.488856.17697539789438631896@kernel.org/
> Fixes: 4ae196dfd61d ("igb: Add support for enabling VFs to PF driver.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tjerk Kusters <tkusters@aweta.nl>
I still assume this one will go via the intel tree first. Please LMK
if I should apply it directly, thanks!

Paolo

