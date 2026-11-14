Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794638763;
	b=xvwk/jl++5fYadkazK/6dTUkuEbsyvcFgVFyC3BXl55ptmM2j+Uo4IfsjZf6QvIpJvov
	 QlS9r4oofIH8leBdhjDKupGIKxmRO4GWbvVxLnUdZrRLZqWaH+4YrnLP1Im5ov2jCiulT
	 ohg2XReKHPXrUMqHJtnzHbwv4ulSHOSm3u1DXswXTAB97YWdJm38sVXqDiQBh0E/OjfZO
	 PioV3C3htHqEByuKw19eJ61Q/+xB8vq8cwh/f5VsVAhSpHOMF4GxnArX3JRu1C5dqwvZY
	 Dwfg/lcBBBW1EsV2+hKB+u38Ls8WBPtM+PsCupBVYVucxWgdhxw+k/updsAqU+u9mFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794638763;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=iHbcITGOkxyEh3nCOC1u0s4lDXjvYPiyn4teM7lM8pk=;
	b=4v5bqlVK5TKdmurjE7sc0aJi+XIl0OCuj/eCrmw5wYQOfe/BvUEZKGxaP041xr16cOyv
	 noxneSkeEBhwzQUMA3KZXk6otBwbvQksi8kMm6sy9R5SK+NTfOqQ5jyKmaDIC8HeEGwjK
	 ISQNcXtgD6HOv/6R0oC+HCferQzxtEQrxYO3tgjSVyKOGerDaMxbgPQfrdtwuN6pzv30u
	 qQ9YPwj6qaCvsSRyWb8e+hvTcdTcayckSwTYw81NFRPX2/G/9W08lxcAFsXKIgGDiUSn8
	 c53omxcDyC+7WjD/Oo7jO0le+hiAprhT32VqxQfkFNGwPBhFbHTok58K/1ZfuVuaJbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eCN44lcA;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Z9JyRNti;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27A6606A327
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 06:46:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B27A6606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eCN44lcA;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Z9JyRNti
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794638761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iHbcITGOkxyEh3nCOC1u0s4lDXjvYPiyn4teM7lM8pk=;
	b=eCN44lcAmg8WWt7EytFdeuDTgnSkRBXZxj85YZi0/8+EJACmLeXPxzbIbddBZXtUyUd7gQ
	b89sRnxuSf5jjRvbNLgy1M2HCZHgMBe0LstSMmAYqW1htqQbKWIdiIbQdLBhBCQ/KY1GBs
	EFnTiKvrq9nz16mtdTLspXCV0btMCgk=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-Y_IK08zYPRGX967JbIeMnQ-1; Sat, 14 Nov 2026 01:46:00 -0500
X-MC-Unique: Y_IK08zYPRGX967JbIeMnQ-1
X-Mimecast-MFC-AGG-ID: Y_IK08zYPRGX967JbIeMnQ_1794638758
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5c157b6cb9fso964458e87.0
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 22:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794638758; x=1795243558; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iHbcITGOkxyEh3nCOC1u0s4lDXjvYPiyn4teM7lM8pk=;
        b=Z9JyRNtiGxsUxOTxjRXOUUYL5sZxLCCF7uohgZH+ACUBNaNK77Gws4JJTUmQ3BqRqf
         xPtOeDPwvzrrQFs3XcIut12Z2E/NBeLooONPXp127Hddp42E0v0aDRUV1x2TdbaDl1Fz
         uqWfRtEB4lnwiP4XohTTUhf3i9H/cscianavIn3W156zfyw1kO2VapArMQwLF3kppbgf
         vCz47bV/WyrVsr+htOoMdeiTr9jOYiR41KXzCv3wzSsDrafgwfXq8b1xiG/tAq8JcW0h
         ZPev1DfOrt8FGDMbwXd/KM66n6uXFpj1v7dYN2umDo1grMqdfnyhCyyZwR0bCahrCo5i
         0b/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794638758; x=1795243558;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iHbcITGOkxyEh3nCOC1u0s4lDXjvYPiyn4teM7lM8pk=;
        b=BwhmpJ2X1U/S4BAZLJXWjSs3CY7+Pqfwif1N5qINjXORv/+OtKjzo3b9AtlD809EQ5
         1LcBY0Fv9syoWYHN16Yz4g5n8WCXLBoQFatlU9M7rUxdoBQrfv/ZePGnUZrtw6pMb2ZO
         Fn4Ejh/QJQEIgTRkYwMHNXY+cj74Uqff6rnO1p7WAD3hbo+g2XVBnics/+HOk41LNIK1
         1Zg1wSTl7qS90IS31j+ldTutJX+qk41w3awIv5jYU+KWjIgYVthFzjcKcCJn7rvk7IrU
         4c5oo+7Ko4y3QaBPHKFhfeQD8DbSAWjJXPkk2QHOMzu7Wu3yQYkk3Ga6+gNyqzem0HnO
         2V3A==
X-Forwarded-Encrypted: i=1; AL+hErGuh0aIUhx9iV25KX5bK5cucjfpjZ6b5oDE8TIkkT0UQGe20ejw1ZeWkTZrVxcAkroEZb+pRTc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8UrXDcxrcH5sP0s4Ex8/MnEBtnqv/A4s3Yyy8OxCf4mNPlUd+R
	MkWyVK6hMmaWiv9CjFnf+Z69NW2yxsFvURpkvmZqytFmDYn0iFxJ7QzkIO3+1Zy97Yf/ZBnNNz6
	SXzJYKvNUrELSskmhkCKXrWzhi0J3ngf8nJp6m2s8O1JHZjdyBXe3KEp4
X-Gm-Gg: AYBFou0CyQNyymjJAqVx1rdWSecAAM5QSQqZV2fEgh1ahY7+Dgm1YHoAajgaM7wu1wl
	NaHR9OPG6O6lQ5PhPqttV3rGzYbI97d5ttt2nwYFkB2udGLfxyVKkoM9DysDFyXynVg80tmEv34
	1/lbEf176TK88j9V/jHeXCVhP0Z87J0tMPaAqzWwigRdFr+WGarVyvV2A08sj+nA4mcXB2ACovO
	U1HXWEjwbs9oHJffcVGdeaVwZJF936kfY06wBTrqB+KVcUB6JE7XmsK9hLuK3pIYVFeaD/f3gRT
	ospw+/353rmvwhdTAmIcPcHHcpwUW6zhL/q0eIWm63NwUKrhIACvudQFhLf2lSvJM+22cAv1syY
	PwF9IprgslZjz4GjjwUmyb9ZzhpUXV7qRiNKBltJn29hsL6X75+uuaYPEdnSwjhvv7hGMKAsri2
	gjnQsy
X-Received: by 2002:ac2:4bc5:0:b0:5b6:4ae:5b83 with SMTP id 2adb3069b0e04-5c1709ca612mr1930535e87.33.1794638758288;
        Fri, 13 Nov 2026 22:45:58 -0800 (PST)
X-Received: by 2002:ac2:4bc5:0:b0:5b6:4ae:5b83 with SMTP id 2adb3069b0e04-5c1709ca612mr1930526e87.33.1794638757811;
        Fri, 13 Nov 2026 22:45:57 -0800 (PST)
Received: from [192.168.1.86] (89-27-86-246.bb.dnainternet.fi. [89.27.86.246])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c17133e3acsm1466215e87.45.2026.11.13.22.45.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 22:45:56 -0800 (PST)
Message-ID: <8c79ce88-7730-44c4-92a0-d760d6f8e9e1@redhat.com>
Date: Sat, 14 Nov 2026 08:45:55 +0200
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
Subject: Re: [PATCH v2 05/13] mm/migrate_device: don't collect a range twice
To: Balbir Singh <balbirs@nvidia.com>, "Lorenzo Stoakes (ARM)"
 <ljs@kernel.org>
Cc: David Hildenbrand <david@kernel.org>, "Liam R. Howlett"
 <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>,
 Gregory Price <gourry@gourry.net>, Ying Huang
 <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>,
 Usama Arif <usama.arif@linux.dev>, Kairui Song <kasong@tencent.com>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Kiryl Shutsemau <kas@kernel.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Dennis Zhou <dennis@kernel.org>,
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>,
 Peng Fan <peng.fan@nxp.com>, Josef Bacik <jbacik@fb.com>,
 Chris Mason <mason@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Mark Brown <broonie@kernel.org>,
 "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org
References: <20261113-mason-migrate-et-al-fixes-v2-0-50a2ed382b61@kernel.org>
 <20261113-mason-migrate-et-al-fixes-v2-5-50a2ed382b61@kernel.org>
 <avfrWjzLQdDcmXO6@parvat>
Content-Language: en-US
From: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>
In-Reply-To: <avfrWjzLQdDcmXO6@parvat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 11/14/26 07:09, Balbir Singh wrote:
> On Fri, Nov 13, 2026 at 09:45:23PM +0000, Lorenzo Stoakes (ARM) wrote:
>> From: Josef Bacik <josef@toxicpanda.com>
>>
>> migrate_vma_collect_pmd() drops the page table lock to split a large folio
>> which it finds in the middle of a page table, and then starts over at the
>> "again" label. The entries for [start, addr) are in migrate->src[] and
>> migrate->dst[] by then.
>>
>> While the page table lock is dropped the page table can go away, in which
>> case the restarted walk invokes migrate_vma_collect_huge_pmd(). However
>> this is passed start rather than addr, so [start, addr) is collected a
>> second time.
>>
>> This can result in migrate->npages exceeding the number of pages the
>> caller asked for, and therefore in writes past the end of the
>> migrate->src[] and migrate->dst[] arrays.
>>
>> Fix this by only handing over what has not yet been collected,
>> page-by-page, and flush the TLB for those entries which have been
>> previously replaced, similar to the other returns in the function.
>>
>> Fixes: 022a12deda53 ("mm/migrate_device: handle partially mapped folios during collection")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> [ ljs: cleanup commit message ]
>> Tested-by: Gregory Price (Meta) <gourry@gourry.net>
>> Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
>> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>> ---
>>  mm/migrate_device.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
>> index 9e5dab8e1b77..28ed706109da 100644
>> --- a/mm/migrate_device.c
>> +++ b/mm/migrate_device.c
>> @@ -257,13 +257,17 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>>  	pte_t *ptep;
>>  
>>  again:
>> +	/* [start, addr) is collected if we get here after splitting a folio */
>>  	if (pmd_trans_huge(*pmdp) || !pmd_present(*pmdp)) {
>> -		int ret = migrate_vma_collect_huge_pmd(pmdp, start, end, walk, fault_folio);
>> +		int ret = migrate_vma_collect_huge_pmd(pmdp, addr, end, walk, fault_folio);
>>  
>>  		if (ret == -EAGAIN)
>>  			goto again;
>> -		if (ret == 0)
>> +		if (ret == 0) {
>> +			if (unmapped)
>> +				flush_tlb_range(walk->vma, start, end);
>>  			return 0;
>> +		}
>>  	}
>>  
>>  	ptep = pte_offset_map_lock(mm, pmdp, start, &ptl);
>>
> Is the intended race a concurrent MADV_DONTNEED reclaiming the PTE table while
> PTL is dropped for the split? That would leave pmd_none() true on retry, entering
> migrate_vma_collect_huge_pmd() through !pmd_present() and taking its hole path.

I think this is "ok" for the fix, the hole is collected from [addr, end). 

But couple of things follow. It can't be possibly collected as
MIGRATE_PFN_COMPOUND entry, only small pages. And the collected entries
in [start, addr) are wrong ones.  Finalize will recover, but the
migration will fail for those. These all are handled in the HMM walk
based migration series.

--Mika


>
> Thanks,
> Balbir
>

