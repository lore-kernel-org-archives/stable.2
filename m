Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795624821;
	b=U1hjI3OsXIL/9l2noI+7oJ7UrwYGEVJQkWbd2WALDLl7D1heFHZ+abfHGc2ZZK+a+kW+
	 NMq/WnhFGr5oHl1D1vCjGkJst2WY/pJNIYV4cIBqRZmwQo/XPAwp5si5EbzVZqkiMGK4Y
	 Ag/0vceX2nJdRwD2tM5mHKvwqVQ9x/Iq92V+idEBV7gwtZG5268cxuj7YOZ3kBXoW0iRV
	 qJ5DxYoyWgos9N/WX7QuhqySvk/fpbcEK+0UsyXDaK1aWVUqAWFX1O/F0qJ75XW/jcK1n
	 HsIvVoz1S4yO4Nuc5HdnLxAZ9gwp4djdvzPkEnAZyFMasN7LYmDJRVczrM1CnZR+rEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795624821;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=TghFUnkx2wFDXauXnjqA/lesm0e681hvYxVKPushlxM=;
	b=NUFBEtlx1ryxsuJ6TWvfdkF6bh7zZoAane+ZbaLNbPupIrdst/qHnm7xyEO++R3uLgj7
	 lsLH2COCoHb3GfHu+JUQaJLn73VXwPtQbyajq1qYHm/laZjhRnT1upwLsnLvTfUUXC1up
	 fELGdSpfrQ2aF8/3tgS3O1JYUz+l7iuF2M9dGkvBCu0apkeShQSSb11p73R+chjkelMsC
	 iqfYfkqOvTaHLTaodlJHW0/S/spfaIaBLG6IXQXn7Qke0ikhoWsHQuZ9qXpB8w45ueue9
	 oc3aHxFtHU7kn0azLh9kELftdHa64XNtsEGI1GDqqoTn/HD7g5bmPBooHh0e8YKg9WA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=I7QTxEpS;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=lfv+5Guo;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803CD606A33F
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 16:40:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 803CD606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=I7QTxEpS;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=lfv+5Guo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795624818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TghFUnkx2wFDXauXnjqA/lesm0e681hvYxVKPushlxM=;
	b=I7QTxEpSFFMA009PMJF7VbhvFJ0waViuaEKrgrtDTVTleoqZ1apJCRtoxmXlainAiVxnyU
	Su18BnW47JvWmis7pBYmVvwHD+wZIHTkbgN+i3YHmjkZJsuabjt0ae80o9Zlu/grIJsC+m
	x5t0R4MBk91mwPmny/LCtfSPQQwwWlM=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-51kn3JGDO4K4cBvrcd1Ngw-1; Wed, 25 Nov 2026 16:40:15 +0000
X-MC-Unique: 51kn3JGDO4K4cBvrcd1Ngw-1
X-Mimecast-MFC-AGG-ID: 51kn3JGDO4K4cBvrcd1Ngw_1795624814
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5c324fb5155so607450e87.2
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 08:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795624814; x=1796229614; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TghFUnkx2wFDXauXnjqA/lesm0e681hvYxVKPushlxM=;
        b=lfv+5Guop7Tf7EDEGsp506mI4Pyh5JMsPPHVvJpu7LMvtMwwSl+jBi9a0boHIYm4Zp
         vSxqS9K+qcZj715hAJ3xY6Wnn/wfWQXA1Zk2VvzBb2Yin9vlAUP5WrP4YX4oNSp5ZWyu
         dsTMbwXr3bKOeQmYVBgeLF8hN+kEQI+qmy+QQoAn4D1KhXKGDs/hVYT18+sF2iWbywpZ
         gXXOF9g3Nds6hN2LWrU9aJjAzr6auqEd7uosagvrrvTzuXENz1Oiqb3aUzzJh68GIsul
         XtmSzRIBu7Jx5uo6acJc2BhL0UzIZnnomhX0+Mjfe9Kucm709mLvV9HOedRbl6cCii54
         CuSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795624814; x=1796229614;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TghFUnkx2wFDXauXnjqA/lesm0e681hvYxVKPushlxM=;
        b=MWEZg70F9WvksFefT+kgQOAze43JLeSqaZnrjvTecvunJGz+jcSE5cp1fdm6iyOg2E
         3BSXlEhI4aDB6T3Ztlr2Ux3pphMe2TJg9eISczin/7y2xIh+ELvcHICWEyh4REIKib7m
         7BzbOUXOeu5q2odPH1eJwnVejwUEo/XI/QQ8+JzlsxJQ0s4BKMGHC2q78ixEbESAp2uu
         M8PS510nbJCOKzrRzzewlsC0HsE6JrmHE5vI11Fwgx43e2TB2gMk5dFWjzRJ2a9JtsjP
         1seKJntYQIn4rvHb792aoBGAW+dzcze0KmNRqU5ovxqq/Ptjgg0IiAvSaMIPuIbO7lnr
         mvGA==
X-Forwarded-Encrypted: i=1; AL+hErHiTISGcmWW85UcTzBnjAjfnj2sPLXpU06ufbo0QC9t1Q45GK0bDGUZ8+aB0H89YhwSKal2azU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/2z09IicIgBSomTheHUdGUY+iSvF+S3vldZtTKKiwPq88iBTL/
	kHdsm+wmSm+2EwCHYeVXFw64fRUH5g5J45R8NzpPF33BIB88YjW6cNvVZSfc9Alopmc+v+9LUYO
	6N8ICcXCYXb5y5ajK8jXjRTwTOKK9JkBO9XOmVsehSRheZmhMIWGeOXD4
X-Gm-Gg: AZFdTZe8BicIg/ATvB+xaP+5STInRnB/FSL/bH7J1vhiWSCIA7MZ1sC5jnFtdsjwSkn
	3bz2YJfYq78eKh3zwbhF0VFgHxf1ccSVk8PigTTHdDLHRaMwlcauD6Uc/GiYCx/Wal+buh1m8B+
	oI58JKJeD8t2QfjFhFslK5aFkOMYzA8tL3PTt9FhQSgWzAXnPcrbO1SlsdwpLxb7Lh7mgW0Xyz2
	Z7Kx/Sy1AAr2WUXLGfO0bbjxR1l+y0oYIA+Jwni7qfQ+jAZTGhJdozi4T3/hcG6wARYqi97sY70
	tYWiAV/lixlS/KVwyFxAC2urrxObIC13w1NDXRPCOkhVyzsUj1hLwckmcLK7Wut0ky8My2KxgiA
	nMaa13GdXyuJK9e3msr+OgZrhsHSgEmLpQaJElUe4n2eD0lLtT4KEdfMS7llQ773nl9M9gVXO4h
	0o8eXP
X-Received: by 2002:a05:6512:1320:b0:5c1:a8c0:620f with SMTP id 2adb3069b0e04-5c1bc817e34mr5223605e87.50.1795624814167;
        Wed, 25 Nov 2026 08:40:14 -0800 (PST)
X-Received: by 2002:a05:6512:1320:b0:5c1:a8c0:620f with SMTP id 2adb3069b0e04-5c1bc817e34mr5223585e87.50.1795624813706;
        Wed, 25 Nov 2026 08:40:13 -0800 (PST)
Received: from [192.168.1.86] (89-27-86-246.bb.dnainternet.fi. [89.27.86.246])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c1bd0176fcsm4612398e87.34.2026.11.25.08.40.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 08:40:13 -0800 (PST)
Message-ID: <be640357-419b-4c78-8d96-3c698424ecd8@redhat.com>
Date: Wed, 25 Nov 2026 18:40:12 +0200
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
Subject: Re: [PATCH] lib/test_hmm: invalidate all mirrors on device-private
 migration
To: Alexandru Elisei <alexandru.elisei@arm.com>,
 Aveline Noir <jm5905938@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 Ralph Campbell <rcampbell@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, Shuah Khan <shuah@kernel.org>,
 David Hildenbrand <david@kernel.org>, "Liam R. Howlett"
 <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>,
 stable@vger.kernel.org
References: <bae41f6fc4114357a8a74c8b958f2bdc.1@linux-foundation.org>
 <awbtZjtII9h1oJ5R@raptor>
 <CANOyQmGPHrHAzVW70Q8T3AYtzFi3C7jCQdd-QW0rQCPEf=ycyw@mail.gmail.com>
 <awb5agUP80qz8iss@raptor>
Content-Language: en-US
From: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>
In-Reply-To: <awb5agUP80qz8iss@raptor>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 11/25/26 17:06, Alexandru Elisei wrote:
> Hi,
> 
> On Thu, Nov 26, 2026 at 01:25:41AM +1100, Aveline Noir wrote:
>> Hi Alex
>>
>> On Thu, Nov 26, 2026 at 1:15 AM Alexandru Elisei
>> <alexandru.elisei@arm.com> wrote:
>>
>>> Might be something on my side? I'll investigate further, but I'm not very
>>> familiar with the code.
>>
>> I reproduced the same 0 versus 523264 assertion on x86-64 when the separate
>> mm/hmm: account for subpage offsets in device-private PMDs fix was absent.
>> With that fix, the test passed. May you check whether it is in your test tree?
> 
> Indeed, I didn't have the patch in my tree, now the test passes!
> 
> Tested on a Radxa Orion O6 board (arm64 architecture):
> 
> Tested-by: Alexandru Elisei <alexandru.elisei@arm.com>
> 
> Thanks,
> Alex
> 
Did you run the full selftest? 

Without skipping own invalidations the normal migrate to device test fails
( With no skip, migrate_vma_setup()'s invalidation erases the caller's own entries) : 

#  RUN           hmm.hmm_device_private.migrate_fault ...
# hmm-tests.c:1023:migrate_fault:Expected ret (-2) == 0 (0)
# migrate_fault: Test terminated by assertion
#          FAIL  hmm.hmm_device_private.migrate_fault
not ok 14 hmm.hmm_device_private.migrate_fault


As told I will be sending a proper fix for the two fds invalidaton case as a follow up to my other changes to test.hmm.c

--Mika

