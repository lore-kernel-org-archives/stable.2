Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793779198;
	b=deHOS45VA7uwZ11Fb5cqoEJce/McINgA2fmBTKuXdRCK3ax9pravDAR76zmxf15CqT6k
	 8xf6NenrRqXO+9H+iekv+70LzZnKYodmhEzvtS3rtnflidDhFCV57I1/FQi0yw7ahfcgD
	 1/NnkIHzcPqYJHgMJrHEbMOdwA5DjWTd7yR/ototUaYSP4+XSekBCq3xJ5lPcob6xcZrw
	 7CqUNCYSCGwtWVn8xctTsAF35isigJW5jkcUgjv6Xp9VAIwvyfJ3N2DQxLS/L6gNETchk
	 acu5izq8WDNLRcEf4yXTF5NeEWHFPTpSuLdtb5p/SgAMAYXMekuXRVUpptTO1Dy2Beg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793779198;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=5yiChu8vq+edNPq126HUtF4j2CY5fLpw6fU/VctFSVc=;
	b=viDevJnvM1KNWbGMDJ7XWXZGyB81EOJNcozxwLBfYsl6KMeil9uUqge0pblhaMeoqX4Z
	 r5sH0PjpPYAcb9y+0AI87B6j5Jyp9so/IkiDKiLRg+T9y/0oQ3jKhDbgZHAXONV9mx51y
	 adnsOQ7//HcAe3o1cHYOiIbE+9v7bNZPUU4/0M5bo492GULnz6dVGQtdVNxo5escwoLyf
	 JSTrW36HeILl+Yvlv7KsmzgX3U6aZqblrx/QD5Ecw9QfzGjS6ni3aE4Gcs/ruKjlTm2Og
	 itN81cUVrYn65KL9bg4TV1jEaEmsmC0IO7029mhsDTjQhwVI5+pT/ARwppuG12UEheg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ddXc6inf;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=lJ9pI+Wq;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE41606A338
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 07:59:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEE41606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ddXc6inf;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=lJ9pI+Wq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793779196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5yiChu8vq+edNPq126HUtF4j2CY5fLpw6fU/VctFSVc=;
	b=ddXc6infJChBR5EIA6jhMicUz87pgdMvhP4wkAzX5UtrlJlV3tY7Rpiu6+WICVE81V4yXi
	fXj2na+pYPKgYpv1emDCwIF1O6sBppAcRHoAJMe06K8Xom02MjvPI8cRyQyzxM+bvEm5BL
	6go4JqfXrqpyclFsNjJQi9HTOoK0ip8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-HysYGtjdOUKaJLRnyS-kwQ-1; Wed, 04 Nov 2026 02:59:53 -0500
X-MC-Unique: HysYGtjdOUKaJLRnyS-kwQ-1
X-Mimecast-MFC-AGG-ID: HysYGtjdOUKaJLRnyS-kwQ_1793779192
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a1d1f26a63so2907655e9.1
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 23:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793779192; x=1794383992; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5yiChu8vq+edNPq126HUtF4j2CY5fLpw6fU/VctFSVc=;
        b=lJ9pI+WqL7ENyNnr5t3T0zNlG/tVhXquMfqele0iakChOwrXCf4jgI+IdPTUpVdfyB
         4MGUOB+SNgdqmQ9dYKsHxnwxe91E21AOBMwFDyxuqM71NZJT7eGNq0NUx7BwslSUTf7b
         7UFdPly5PUn6VXbIAvmkLisrXB8MS8MUkd8CGjfcdruc5vPg2Nwkm82cOXpJwYN+6eKc
         SCWKP25hDnzDNAuS2MYDMFn85c7fLrNNNIZ1vjqWsMSqrwlB4HuVDkv9gvbEIVQlTxVl
         2igz1L+34KSvsobyPczXeTs2d6Bxt+to3tsTRSiifSkVULvPMvvqehzw/FJUHN1zsvOB
         6QvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793779192; x=1794383992;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5yiChu8vq+edNPq126HUtF4j2CY5fLpw6fU/VctFSVc=;
        b=TLHeMv0PJu9/XRy4lV/E3VQTU9U9HZfqwkCdxuhWaknjwFAD9l1CMM5e5pirMUMVnG
         QlC+wMWv1mFeNkdMoFoJwON5e/C5g4+Fv2of+ZSFp/BdpLe9yOIA9DOnPfLRECbdppls
         LtfYvAC3ijwIBMFAZFf28D9/OL+TDNxNew2+czZLqi83ZGrXx55NC5IRumhtOLXmJJfj
         Aoa5qEDr0vouXczirAHNpTOoSWiQWVZWqYHgsDb6s1hpjPxW3/bJWY4Qm2rArtde+k12
         xAhkz/enyd6+3YLc1Cw5IKHulX2ROyD5DgGGQhAJyv8jcrVs/5O9mrqtzhvb/BLidlN7
         OxhA==
X-Forwarded-Encrypted: i=1; AKwUvBxm0inf9KRXVedhefAqQ1cOfztMcTKI9HuQKE/Sd8bEVKY4OQmRubTGY5+G2GJl4qViuZ0gZzk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+YCvg3DjPB8CaRSZqxQMfXJ/ZEggXCJLZkWUiqmNA/rzPY5EfJ
	cJBaxWGFLUi+ZHYHblN25SD/ke/Bw1NDwuVmo+QvCXuP470UFUIIyJrlgM/XR/xrpgqa9hPbo0B
	P2P/M93KnPE47TRS/M1IHpff2ss3o5xT3kBPXhf2TYjUA9R/RjyY0CU/5bw==
X-Gm-Gg: AYBFou10VbWrOJBHDOw2SBQb2iYWeDHGC6SVtGQD3a7nmCGGUsxBFjynXXo7UrUrP4P
	vN79D29NwDWCzmPbuW3SSa0tAxiqpVrbyp8GBDqfb8NEGl/wdwUSxApY9uXzoKwSlNO/aCdx8jP
	JbIhtT8CfGq8pv4wd8p1QTVHC7sYXkc3AYvqWIqsFEIGzYG+oGsy5/4YksobbFvLyBoeIJ4Q4jo
	+GcbAtRl+jIfsNow4ZfodE5jXA6MyLg5tyOJB+mlaAexq8GdB++4sw0u1oo3ft8L7c51i6AntIm
	IcnwTo49xFnM8jVenrbKUfjGLNtKYRBxoSQvhcRcPMoD/d8TuY3ykBaZHOOBDQL9P+0L2kLtR61
	q8GVD6SUriN5FxtvXzz+Hbdf40yTJWpIZRkE+3v+bdDpFRDofb7LrM9hcH2Dtu0xzgvV3MRRfAh
	HukbsAUYNPkMlK8RvhW5/xRl+/WVRBOSPh9uBFsrhU5Bs=
X-Received: by 2002:a05:600c:1f93:b0:4a3:2f35:38b6 with SMTP id 5b1f17b1804b1-4ac180f1e69mr337279655e9.24.1793779192285;
        Tue, 03 Nov 2026 23:59:52 -0800 (PST)
X-Received: by 2002:a05:600c:1f93:b0:4a3:2f35:38b6 with SMTP id 5b1f17b1804b1-4ac180f1e69mr337279325e9.24.1793779191790;
        Tue, 03 Nov 2026 23:59:51 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b452cd020csm29683995e9.4.2026.11.03.23.59.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 23:59:51 -0800 (PST)
Message-ID: <7f8bd24d-7538-423d-b2a9-f5b0eae99d41@redhat.com>
Date: Wed, 4 Nov 2026 08:59:50 +0100
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
Subject: Re: [PATCH net v5 2/2] net: restore refcount ordering for lockless
 socket access
To: Hyunwoo Kim <imv4bel@gmail.com>, Eric Dumazet <edumazet@kernel.org>
Cc: ncardwell@google.com, kuniyu@google.com, davem@davemloft.net,
 kuba@kernel.org, horms@kernel.org, martin.lau@linux.dev,
 john.fastabend@gmail.com, weiwan@google.com, sd@queasysnail.net,
 jiayuan.chen@linux.dev, netdev@vger.kernel.org, stable@vger.kernel.org
References: <20261029214219.1035176-1-imv4bel@gmail.com>
 <20261029214219.1035176-3-imv4bel@gmail.com>
 <CAL4WiioDoAT-50wStYDOy0b7f972QivB=Zk_7TCDrVPfOY665A@mail.gmail.com>
 <auqJOj7RVCWn7Ucl@v4bel>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <auqJOj7RVCWn7Ucl@v4bel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/4/26 02:24, Hyunwoo Kim wrote:
> On Tue, Nov 03, 2026 at 03:49:40PM +0100, Eric Dumazet wrote:
>> Le jeu. 29 oct. 2026 à 22:42, Hyunwoo Kim <imv4bel@gmail.com> a écrit :
>>>
>>> Before commit fb041bb7c0a9 ("locking/refcount: Consolidate implementations
>>> of refcount_t"), default builds implemented refcount_inc_not_zero() using
>>> atomic_add_unless(), which provided full memory ordering on success. The
>>> commit removed that ordering on weakly ordered architectures, allowing
>>> accesses after a successful reference acquisition to be reordered before
>>> it.
>>>
>>> Use refcount_inc_not_zero_acquire() in the IPv4 and IPv6 established
>>> lookups and in inet_twsk_purge(), where the socket is validated again
>>> after taking a reference.
>>>
>>> bpf_sk_assign() can receive a socket pointer obtained through BTF
>>> without a reference. Use acquire ordering when it takes its own reference
>>> for a refcounted socket.
>>>
>>> Use refcount_set_release() when setting refcounts in the SYN cookie,
>>> TCP Fast Open, request migration, and TIME_WAIT paths. Keep the existing
>>> TIME_WAIT smp_wmb(), which separately orders the refcount store before
>>> ehash publication.
>>>
>>> Fixes: fb041bb7c0a9 ("locking/refcount: Consolidate implementations of refcount_t")
>>> Fixes: 27e5203bd9c5 ("bpf: Change bpf_sk_assign to accept ARG_PTR_TO_BTF_ID_SOCK_COMMON")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
>>> ---
>>
>> Lack of links to prior versions is rather annoying.
> 
> Is the cover letter alone insufficient?
> 
> Should the changelog be in each patch?

Ideally the cover letter should include a very quick/short overview of the
changes, and a per patch changelog should include a more detailed list
(no entry added when the patch is unmodified).

Thanks,

/P

