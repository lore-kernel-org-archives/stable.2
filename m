Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794734702;
	b=GaHzeg1zzi4fqhLTzIldxAVub1VmdNrJtA3BYUwhaz3tn0W2VxXxt9BI9qpbmCIC8uTb
	 WYR0haaMtEA1A2UYEttqob1/ct7xB0AzSTgpO7bNYO9+WMfeqVy93v7j+Gl/n0W2wOkSy
	 VAnodSfLyRrqQJKECtKodaT7G2QEnJFTb75Ga7nZQrMkaZYHuAkS58bjbjRD4KrTC3Ji3
	 80j0uNfww6nR9+4cdK6nCFNltNyaw6u9KOEwtb1pUjviQKLEjj4xc3xQ7Vvyo7YsR/xE4
	 feTfRMeI7JN4zjzxoCQNZ8yRdRCRYrDl+dBmAHL4A64/2lLG7kzcKC6nZJosORkGjzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794734702;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=9c8p7xnMkOo8VygGtCf+xkzjwVTSeX+xnVktgNDwVkU=;
	b=oC5Pl+XdWce5+ZzVId2F6Z9d6p0oSkk8Taqln/AIJ5HmRD7zCZd0F09xoWqb77EMdMC+
	 yvE4OJ3Hi3z9aKNLZPNYjeTRpxmKcICTVa40X6GSS6VuchPIcDSEWmTzkrG1tn2D90iFN
	 +zuDtlP2wGcgHzG/cGroI3On4//1grCmz4Cx1Hp6TKjsG+CyO5XFW/A6grB+t+E8Tu+G7
	 b55ZxJcwT6iX0d55onthOJfJrDRGfZ1wUG45s8il2rcN3ApomMqkMKo9CqdpIsa7CoIZW
	 y1r3C/XbO4af9S6FEZ3Ijf5yToaDt2RFTU4TiKFICuBh/4v3gZcETjIgEot75INMcrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XT6tE8NP;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=OM22gf9d;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69286606A335
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 09:25:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69286606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XT6tE8NP;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=OM22gf9d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794734700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9c8p7xnMkOo8VygGtCf+xkzjwVTSeX+xnVktgNDwVkU=;
	b=XT6tE8NP+kJMmvsdPffQ+ogNkHGDooATl2GCb1VpPj1d6r1BK3L8vfVhY2Rgn1s1oD8dVt
	QhPrPgvV07xrPQ9QbnJEqqrM2epNRX3Sdq7CB5RQLFH/YYzySPBvoD4zZ+5Fqp4Vm4QkiO
	WNzzkbhudn4foXuoO9yNZdKZRfMVt9M=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-kUVUrRt9PwiNYFwRd0HRCQ-1; Sun, 15 Nov 2026 04:24:57 -0500
X-MC-Unique: kUVUrRt9PwiNYFwRd0HRCQ-1
X-Mimecast-MFC-AGG-ID: kUVUrRt9PwiNYFwRd0HRCQ_1794734696
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-3ad09084d85so12962861fa.3
        for <stable@vger.kernel.org>; Sun, 15 Nov 2026 01:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794734695; x=1795339495; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9c8p7xnMkOo8VygGtCf+xkzjwVTSeX+xnVktgNDwVkU=;
        b=OM22gf9dVdnx9TbTO8vNQ9Y8YBWJM2fhKGDxOLV0X6pmaQMXGtuVoJNGXoEpDuyuEF
         HsenWSJaBPqwm4A06rMK0yCOt8cq4fURVt6VduV5MKUGH8lO0CRRXvRCRCl6bk88ang1
         WyL+IbAycwZEZl9BSkmQmIhm3/rpvKHfeaY8piIe0u7RwhQuagKogxLvzgLY+6IChws5
         gKuppmnrjIYqrSkqKRcOC84+toW18d39+PbMxIzRHoVKWD3tpxVGW4Ts5UNw57NB08iX
         jOAEuUt5EaPpVGxlGzuCFNN2J3UROosEEggceQJHEjQZzygFHJhsRVJatiGk7IahmJw+
         Zltg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794734695; x=1795339495;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9c8p7xnMkOo8VygGtCf+xkzjwVTSeX+xnVktgNDwVkU=;
        b=ptnN9sfrfFU1OFZNwTlXElErIHS+u+QQL+UMOtlhpbZ7udX7QfnglLlP5rl+0rSQL9
         f62QMCkB4p+LX4CaZjgYG6y4Ol0OzKVzvJUGPUvdlfM3ds4F1x+nzH1KYex6uvjiQ8kc
         Nrj2ZwYmGAA6sjXKc8iOHqElDxp2YhXpkKfbwYqAblbdOKzkefFIyTuF2v5zkfZGfgkG
         62FhPL4w60Uk84cZTFXYvBj3eEFNOvH+kWBEiWSr57Kn5xaLv63Xmra4YDDHVHQB2mRm
         F71d+kGVApWYv3wr0NzfGP39jKMQA5lzAkKa+n+DnAIn7ZRfj1ddrSP/hJtuaMxydvEc
         jFrA==
X-Forwarded-Encrypted: i=1; AL+hErE5upMgFWNEqR8NyQHcqKEdL+1ZWDfNRzcmWHlpnQnbMTmZf7iLLujTPI/+/D5B4cjPdB30ttA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Ho4HRa906+JUXyoviGVsFxmy2QLCxCFrLN+eh7FhUjHltRVlN
	qXQ8yx1fJFXPTrC0FhGe4Pue21z2dQc6Y3Xg4DQ78xkPAnyDJIB1tOxW1Lnb6lRRl+IZqgjjFln
	DufD1lPSKHYD5bjQGkmiW6NEJ5U+FgHZcZL9G4h8aRoQojCITO5qZcJ8W
X-Gm-Gg: AYBFou3butX0bzWF4RNe1FYksaQhH79Mup/FS1y2fLFzrgPcbFkgP3mRMRazARuhk21
	DZbwAXCxQtWYuJwcfbnByRRQ1UH2EdbdIK4ewS6tVP5Xi+T3s7EWnEsfu4GwgguFZtmdERAcf2I
	Mq+b1DP77aLTXiIcgEv1QqSKdB2mb8/PYTTO9DEdzar7UsGcgIucUHcij0K86YoJMepmmUXWiJD
	1VOXsYNOZl7ygdslNETO3WqKhkshyBLZCowFSxDuxMaL9JePV7yKbGJZPI/uPJTVlRSjrS8ljp4
	g+BLPUpm3DCFoT6AoL5GNIxdqakfZYIUZqupydoHemmtgt9NBaH4l5xdeoVtKzPFlFukma2b/2t
	NCvT7qBBDZdjRA0xviLNgiaEWj2+KkPWGQaAn3MRh9AMdbHDamcCHVBUHncyEVltDglnWUCSj0U
	0/8tpE
X-Received: by 2002:a05:651c:211b:b0:3ab:1639:9a75 with SMTP id 38308e7fff4ca-3ae2b4efaebmr20845221fa.11.1794734695455;
        Sun, 15 Nov 2026 01:24:55 -0800 (PST)
X-Received: by 2002:a05:651c:211b:b0:3ab:1639:9a75 with SMTP id 38308e7fff4ca-3ae2b4efaebmr20844811fa.11.1794734694918;
        Sun, 15 Nov 2026 01:24:54 -0800 (PST)
Received: from [192.168.1.86] (89-27-86-246.bb.dnainternet.fi. [89.27.86.246])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ae2b780517sm24261081fa.15.2026.11.15.01.24.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Nov 2026 01:24:53 -0800 (PST)
Message-ID: <607bc1e3-7f12-429d-8b0b-a24f77b3762f@redhat.com>
Date: Sun, 15 Nov 2026 11:24:52 +0200
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
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Balbir Singh <balbirs@nvidia.com>, David Hildenbrand <david@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
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
 <avfrWjzLQdDcmXO6@parvat> <8c79ce88-7730-44c4-92a0-d760d6f8e9e1@redhat.com>
 <avinH6zgTzpjMCrf@gremlin>
Content-Language: en-US
From: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>
In-Reply-To: <avinH6zgTzpjMCrf@gremlin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 11/14/26 20:34, Lorenzo Stoakes (ARM) wrote:
> On Sat, Nov 14, 2026 at 08:45:55AM +0200, Mika Penttilä wrote:
>> On 11/14/26 07:09, Balbir Singh wrote:
>>>> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
>>>> index 9e5dab8e1b77..28ed706109da 100644
>>>> --- a/mm/migrate_device.c
>>>> +++ b/mm/migrate_device.c
>>>> @@ -257,13 +257,17 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>>>>  	pte_t *ptep;
>>>>
>>>>  again:
>>>> +	/* [start, addr) is collected if we get here after splitting a folio */
>>>>  	if (pmd_trans_huge(*pmdp) || !pmd_present(*pmdp)) {
>>>> -		int ret = migrate_vma_collect_huge_pmd(pmdp, start, end, walk, fault_folio);
>>>> +		int ret = migrate_vma_collect_huge_pmd(pmdp, addr, end, walk, fault_folio);
>>>>
>>>>  		if (ret == -EAGAIN)
>>>>  			goto again;
>>>> -		if (ret == 0)
>>>> +		if (ret == 0) {
>>>> +			if (unmapped)
>>>> +				flush_tlb_range(walk->vma, start, end);
>>>>  			return 0;
>>>> +		}
>>>>  	}
>>>>
>>>>  	ptep = pte_offset_map_lock(mm, pmdp, start, &ptl);
>>>>
>>> Is the intended race a concurrent MADV_DONTNEED reclaiming the PTE table while
>>> PTL is dropped for the split? That would leave pmd_none() true on retry, entering
>>> migrate_vma_collect_huge_pmd() through !pmd_present() and taking its hole path.
> Balbir - yeah exactly the PTE page table removal, and it zaps the migration
> entries installed for [start, adr) too, so those don't keep the table alive.
>
> And yeah, we would then see pmd_none() on retry and
> migrate_vma_collect_hole(start, end, ...) would appends entries on top of those
> already collected.
>
>> I think this is "ok" for the fix, the hole is collected from [addr, end).
> Thanks. Yeah addr > start, so it's not PMD-aligned so always ends up in the
> per-page path.
>
> And if the split happened at the first entry then nothing is collected yet
> anwyay.
>
>> But couple of things follow. It can't be possibly collected as
>> MIGRATE_PFN_COMPOUND entry, only small pages. And the collected entries
>> in [start, addr) are wrong ones.  Finalize will recover, but the
>> migration will fail for those.
> But that's true for any zap that races after collection started, so there's
> nothing for this fix to do here.
Yeah agree this fix is fine and good for stable. To collect the whole
PMD hole a rollback mechanism is needed.
>> These all are handled in the HMM walk based migration series.
> Ack great glad to hear :)
>
> --
> Cheers, Lorenzo

--Mika


