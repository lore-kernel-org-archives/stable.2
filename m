Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAC742B316
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 16:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783614202; cv=pass; b=tOWN5UrI+iH8qhGTieL1HHD2T4muYYQDEkGBNjIUNsVAYhxzIh5uizcLq4yaqyqgKwiViclCWw/NVwOYzA8p2sEtPTXIt5hQPM4aRcwdR9RDf1SnoNtcJVCCW56OdMnPhOaQqvs0paPCH6abvRI1vb4/8Z8euEf24KQGB+pENL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783614202; c=relaxed/simple;
	bh=AVh0ZhnxfKkObuncY/WYjL9wbU3bZMEhiAJjqdd/5UI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ay1ZxS70TeZ475A81B7WZlLLiH8Mq4xt1zOLs8+dV5TKE3cA9ZUceJh5zJ0JbAlZTMC9MZFF5V6yWA4SuqY2jw2EG9pDY+x73H85cKgyMI6jiFxMyL3gSEIbael5PsWd/7MLn6FnDxkNDjoVmDbi+FoKxGAxgCW/uTZhlyLdEDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nEQ6udyI; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nEQ6udyI"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso21089395ad.2
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 09:23:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783614195; cv=none;
        d=google.com; s=arc-20260327;
        b=gMLui/WOeoffmhDxDd4Cp7QulS3a8Eco3wg5lmulU+k6YV/3oom1wRNiF4gkaY0CyK
         HmQFCe0qgnhrsAp4oxUNPLlri4TL6dfZpVdJ1qbQi5DQfK2QjYGpmCqIQiVEGfTxEY6f
         eLQ0Ym0O4fH/zzLzOS2Ov2kn2DrYsPz9RBa1PkaQ5fIUNAXhlGi9LaXaLQ8JCRi3Bo1y
         GIkhiVOd2GsEItFza9wr8D/1EpqBADqw/OBbFJk0lNbYBwQ0xrRmFbr3KnXa+yAKIrEJ
         K3bfogDR1kHFuVSzwsqi+qPLZWlrdxqtqQyXOJgCylWhNOtI1swb2DeU7xH8+twg4FJf
         TJOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=yXLUlDscKdqaFtWa6gdX4peXTtyRH3C0w3/WMXcttMw=;
        fh=SU3/4NwtM8bWTXj/YeVBDTSKg46CJpcM4KUQm8kwNxQ=;
        b=CGLXLSpSxyGsalc3H6Fhw1dFvRu+pmq6JAqP94aPLsuzT0x/WL19eBL0EEfpRXoY1g
         sxZn3S8d21zNPMuq3VgabzZ80s6EkT9AzTMfse+9/9aeStNCnO1tcNds6N2LeAhDvrTE
         6SMuh5OMxRAa9uD6d7fvFbX8C0tOsxT8PkVD90zJpUSVCAfA5QTleNnrHM6WZiIcT3WI
         RoCdhXiH+pEtfngvbe6W/5UpwVUZW6tC2LPT0nNqdWeqG2AaC6pOh+AnL1FfL+sX2vXp
         lHSCoNvsPA8y9p12vZUZXI4bRcld3GoJT7DiEjy1yDWcC6zTOfhZj/YbhAEBWBiZzhij
         mygQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783614195; x=1784218995; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yXLUlDscKdqaFtWa6gdX4peXTtyRH3C0w3/WMXcttMw=;
        b=nEQ6udyIjyst2rDviYUNfJeywvPt2TkFOAqIAJfCd4d4WcDTQqEKVLCs2ygrX+N3yk
         GaFx7+4bvSX6vuKLIl/KKW19uO8yrtwITwBUwpm4DfiIAEjxouI6+MRMYiP1AHBQm2ti
         wXPkgk+dknKQ8bqSgvyJySzVmDmumYM+SGIPd0RXUN4MA3umPzf+i5MoioLQrQZXiLeq
         Xl4QfFczwiaQvNJDydEtFuCeDajyOuLAtwoFsdbddd1AXy1HWzswoH7f1/SqWJp0uWru
         /KXBGQZw2yQvj7HxOKq7ej8S2CnfIh6gUOyB2+O8bTqEmQ0sz1QpG4zpqCPPUAnkmYzp
         uLtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783614195; x=1784218995;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yXLUlDscKdqaFtWa6gdX4peXTtyRH3C0w3/WMXcttMw=;
        b=ZZQTF2xpRReaxgl6Wkh60iyBevZL8hLP1fNiQJ8XfonyeHvj4QDt1dp5KekuzrWyoH
         79t+efKoMJbaJ86EhdXizpgnPyc3pyuBaAKPxKuyPaZNeflnYrDZg+Hmu9dHSRUFLpme
         JWaA9nsXotOCgUhPFzKHBfEO3hME6tqJTfpeXbfuv4MShJ+sJAGJy8KHXQJr+VQqAx5w
         cYfGZIzFUkM+LP23NFVuuYoAVHlxKVg7bZr6ukiCLSumgxOqUsPMQJ5IXnnMdXX1Q1iq
         cRrqVM6n33rp8UM1QdRG4RO2K0xBUu/AUDfVZ8wr6fh6/WxrGoj/bNEH1/t6VpUI4BfD
         CdKA==
X-Forwarded-Encrypted: i=1; AHgh+Rqr+pkzFQ1ZUVWlAPcMvDQjQuYsxTN+2WfhF1cMJ+pt6NWZUdxxwaSI1vb7qKuZMj4ObEynSO0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1J+P5B0c242I8Wmn6XI4Ap04hP6lheqmy21Kw4EmiUVBa1ECu
	eyzI7qXyeh2Kwu0Dhis0pUi8lIL1YJ0rzCRnWZhVpsiInjI/y0vqesZCZlsuEDJuDDL31ugcOE/
	Iv5TqHYdqZCFI0VhmOF7xkBW7Zl8sODB5xI3+4fa2
X-Gm-Gg: AfdE7cnxLsnKpoRqb2tmq1Q6jdQeIb8PbNgKcFYf7LAVLJw3nYnLErnCELgQYbwAQ3j
	gGgzuIMZDf6vOGQ7gDAlQh7nuKW18gY/naAq6+rYM+xJpCll1mHhHPsALHb50l/lo9fYyfS3gSp
	f39/IGp+cF1lUjazD4zNmwHtYJomdUER3DxWTlZXwIRS6imKltTMAkdT0PfAvr2P+8VW5GS1e4+
	sSvuI1GeuxtfRmWdAXuQMkS91DT3xWWsq4I+wTDS9fNNchdiQTqQ8Jf9IJC+dL2wf7bREHJ184C
	NVJg8S70fn/NbjG2pcXsrBv9X9RXgecXJe4fbI7y/CLTWLtY6YXSIhexb1k=
X-Received: by 2002:a05:6a20:d507:b0:39b:d5f1:4ff with SMTP id
 adf61e73a8af0-3c0bc902b0dmr9484766637.20.1783614194738; Thu, 09 Jul 2026
 09:23:14 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 9 Jul 2026 09:23:13 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 9 Jul 2026 09:23:13 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260709153409.2091070-1-joshua.hahnjy@gmail.com>
References: <20260709153409.2091070-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 9 Jul 2026 09:23:13 -0700
X-Gm-Features: AVVi8Cch-3WqSt7i_HowDJvLyFz1SAr8FV9RFaDIKKJW4K9V-dKOUNAs9cFlW40
Message-ID: <CAEvNRgH9WSF64eKardR9M9VeRiN85UkS=Zsje9H8mqjQQychmw@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] mm: hugetlb: Fix subpool usage leak on allocation failure
To: Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	David Hildenbrand <david@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, Nhat Pham <nphamcs@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>, 
	Wupeng Ma <mawupeng1@huawei.com>, fvdl@google.com, rientjes@google.com, 
	jthoughton@google.com, vannapurve@google.com, erdemaktas@google.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	David Carlier <devnexen@gmail.com>, Zhao Li <enderaoelyther@gmail.com>, lance.yang@linux.dev
Content-Type: text/plain; charset="UTF-8"

Joshua Hahn <joshua.hahnjy@gmail.com> writes:

> Hi Ackerley,
>
> Thank you for this series. I really wanted to work on hugeTLB accounting
> fixes but never got the time to get to it. I'm very grateful that you
> are taking a look!!
>
>> From: Ackerley Tng <ackerleytng@google.com>
>>
>> When alloc_hugetlb_folio() fails early (e.g. buddy allocation failure or
>> hugetlb cgroup charging failure) and gbl_chg == 1 (meaning a reservation
>> was not used, but a global page was allocated instead), the subpool page
>> acquired via hugepage_subpool_get_pages() must still be returned.
>>
>> Currently, the error path out_subpool_put: only calls
>> hugepage_subpool_put_pages() if !gbl_chg is true. If gbl_chg is 1, it
>> skips it, permanently leaking the subpool's used_hpages counter.
>>
>> With the earlier patch to always track used_hpages in the subpool, always
>> call hugepage_subpool_put_pages() if map_chg is true to consistently
>> restore the page to the subpool. Only call hugetlb_acct_memory() to adjust
>> global reservations if gbl_chg == 0 since gbl_chg == 0 indicates a
>> subpool (and global) reservation was used.
>
> So I think that I've seen that this part of the accounting specifically
> is a bit suspicious. There have been two attempts in the past to fix
> this area [1] [2]. I think functionally they are quite similar to this
> fix, they just open-code the contents of the put_pages function inside
> the condition. I've Cc-ed the authors of those two patches in case
> they wanted to chime in.
>

Thanks for connecting us! I didn't realize this was already being worked
on. Also adding Lance, who commented at [3].

> I reference these fixes because I think they handle the minimum
> subpage case a bit differently. To be honest, I recall reading those
> fixes a while back and getting a bit confused on what exactly happens
> when the page is absorbed to fulfill the minimum size...
>
> It does seem like Sashiko also notes this as a possible concern.
> WDYT? Does your reproducer for this issue also work when a minimum
> size is set (let's say, to 1?)
>

Let me look into this more!

> Thanks again. I hope you have a great day!!!
> Joshua
>
>> Fixes: a833a693a490e ("mm: hugetlb: fix incorrect fallback for subpool")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
>> ---
>>  mm/hugetlb.c | 14 ++++++--------
>>  1 file changed, 6 insertions(+), 8 deletions(-)
>>
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index ee5e99c1894b9..4093c1c0a4a1d 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -2852,7 +2852,7 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
>>  	struct hugepage_subpool *spool = subpool_vma(vma);
>>  	struct hstate *h = hstate_vma(vma);
>>  	struct folio *folio;
>> -	long retval, gbl_chg, gbl_reserve;
>> +	long retval, gbl_chg;
>>  	map_chg_state map_chg;
>>  	int ret, idx;
>>  	struct hugetlb_cgroup *h_cg = NULL;
>> @@ -3003,13 +3003,11 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
>>  		hugetlb_cgroup_uncharge_cgroup_rsvd(idx, pages_per_huge_page(h),
>>  						    h_cg_rsvd);
>>  out_subpool_put:
>> -	/*
>> -	 * put page to subpool iff the quota of subpool's rsv_hpages is used
>> -	 * during hugepage_subpool_get_pages.
>> -	 */
>> -	if (map_chg && !gbl_chg) {
>> -		gbl_reserve = hugepage_subpool_put_pages(spool, 1);
>> -		hugetlb_acct_memory(h, -gbl_reserve);
>> +	if (map_chg) {
>> +		long gbl_reserve = hugepage_subpool_put_pages(spool, 1);
>> +
>> +		if (!gbl_chg)
>> +			hugetlb_acct_memory(h, -gbl_reserve);
>>  	}
>
> [1] https://lore.kernel.org/linux-mm/20260428113037.88766-2-enderaoelyther@gmail.com/
> [2] https://lore.kernel.org/linux-mm/20260515202902.461539-1-devnexen@gmail.com/
[3] https://lore.kernel.org/linux-mm/20260428113059.79001-1-lance.yang@linux.dev/
