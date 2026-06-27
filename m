Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9174722097
	for <stable@vger.kernel.org>; Sat, 27 Jun 2026 11:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782560511; cv=none; b=WI7nfeV8Bxew7BUzFd5Qp+PyYABWitnCAiAwcUxvISNTqkpEBvXGoon2oHYBvTJy4H2sTt9jcLMQ7SlJQNxPsaWetoIoo9gtN96Tb2jsLrAlLl/E919HyCHsOFbrLAObvNpnE6wGQwRlkbop9nLZLZuTHJ/xIA/ypm+KnBIpo4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782560511; c=relaxed/simple;
	bh=euKj73nb/oKaG6oK8vnS8Te7tyBUZFb4ZRGbSHlk+lY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qaVzMa2Ywq969/pW43vWBPZ04/qEkqqcmo35afwJcXKzh07J+jBJKlKHhip1cY9fxipfLT19fATBO0l0UuS+4f48dC2u9OOvvMQ5dGK4qqhXp/zAQNflTK3EQtdwDaaaYroFFboah15pwMFIwxSQHVV2017QA2w+IHs0c8Vnw5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=emMGtJpl; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="emMGtJpl"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-697f3af8749so2785867a12.2
        for <stable@vger.kernel.org>; Sat, 27 Jun 2026 04:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782560509; x=1783165309; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5MsGEy5Adg9XX//QZzyVthhl1GGb0HZKXz/vMlwCOV0=;
        b=emMGtJplRFMv+JWsJpxfEudL9OauEhobNhBKBG6UiehojXBdfhxdI6QeViLhq9R8cn
         qP9qVtP1eVMOQnjyxVASzDdG9qeNveUzjXgE8lGUU03YC4tHaHiQ/2gyeyFS1WHrzB3s
         Fk670dnUzZFUw3Tog3kxN2KNqGehbx+LHhX88+7+ebNpcedvG6bKJsAmmkB1xEgdLZnV
         MSqQQwfAUF+e72ilSY5suixR7WPfJjxsGsp2t5B4XrE5iXt5CDTk6O/QC9JJTfw5dOYi
         ceDF5PIn2W6UEo8A85f8Rlb7ldFAZB9egOh2SwtJoMM47A2/WUGO5ASgj8KU8LWPjJ4h
         SOkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782560509; x=1783165309;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5MsGEy5Adg9XX//QZzyVthhl1GGb0HZKXz/vMlwCOV0=;
        b=I9cPjp7PdHPiI8QAkUnbGXvlfF36Hvdbxy6nVRFvd8UleGuSnRV1BYn6fohF4dCwN/
         eRvbup1Lk0W/IzKy5GGi6D1jJHok8oRLuq3rkrro0sW7Lg8UmQus8sfiFqCxyvxSIeGR
         mqc3T9eIeNYNlMgAeLHyKyu+f/92IrDXKjFxA8o9M8UHjwFj6AchJVsUz6fcsgVH3m4i
         qqzMwqAh6wbFRUTovj9Np4atut9tThJ5lpwM+YVNmmQOR0T5Jq72KKrLTr3d2mthlTAZ
         /4ReUEYGjCmmCxG8Muc8ia0XPErZytJM7fPZJ/cKVaYYPDrOXns/XWmgIoADU+n9tKMx
         hFtw==
X-Forwarded-Encrypted: i=1; AHgh+RodIXCFz86hucQQUWDsuo1nf97qDSvJ4cF5k/bUNQb6JQGdjajGqwk9MXpkNlzHXvw3DdzUkoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YytNOtJV4VkuaFRS4z3xzwJb3Rg9zOY7GORfhPbFhTPa16Z+U40
	OqfY8QDsh4vbR87ZqmyD9dTPEXpdZo5Xzex0JiiO8NNd0fDJgNJSbNZO
X-Gm-Gg: AfdE7ckKlJp+82BhKVLwLYKA4AJ80wBrapWByTYFukz3vl8dD3wTNmshPMDuKmrKBTO
	ReCL4XYBt+JtzdCbJNKQj0/SJCn7BvUEUF2LrOZE7kOTswmSfjkA3rNXKzdKR4+Yqz+y2/GdTHT
	Ulr0n1RQ/jHS4FPR9tQe0fdbD7W0zTM4RlMPgw4wo9aCIO4bLudmFTnQll7bPO/jA13in7Q9vLz
	FP9Azi2U28UTSzcAgMCsVTw+hyxFea0nKQUAXCm1AnICCvFIe9vbty9FoM+5aiaorY//NHYBxI5
	ynWcd+b1PemZGOehU02OyULM9TTVZI+5yRQ8KbRWui76N5n4x7EBe0IrFHrKdYINECaB1/Fkh9a
	I1PbNGi4c/g3Qjvh2OefMH1oQCSJ1MswYgat8R1aErF7liwDhmfaUz54IFsTVkFoWkhXJQMUQVZ
	a6UwOssKSFEN8=
X-Received: by 2002:a17:907:c705:b0:c12:3d5e:65f8 with SMTP id a640c23a62f3a-c123d5e7db2mr75082266b.4.1782560508661;
        Sat, 27 Jun 2026 04:41:48 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c11fbec3514sm467854066b.57.2026.06.27.04.41.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Jun 2026 04:41:47 -0700 (PDT)
Date: Sat, 27 Jun 2026 11:41:47 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Lance Yang <lance.yang@linux.dev>
Cc: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
	ljs@kernel.org, riel@surriel.com, liam@infradead.org,
	vbabka@kernel.org, harry@kernel.org, jannh@google.com,
	ziy@nvidia.com, sj@kernel.org, balbirs@nvidia.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	"David Hildenbrand (Arm)" <david@kernel.org>
Subject: Re: [Patch mm-hotfixes v4] mm/page_vma_mapped: fix device-private
 PMD handling
Message-ID: <20260627114147.d6csxmiha6whfyb2@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20260624065353.1622-1-richard.weiyang@gmail.com>
 <d060cadd-34f8-42da-b7f7-c8d295050436@kernel.org>
 <20260627020719.ipzfrlhfbvr6ac35@master>
 <b7cfc04e-7a57-489e-9459-82d7eb818675@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7cfc04e-7a57-489e-9459-82d7eb818675@linux.dev>
User-Agent: NeoMutt/20170113 (1.7.2)

On Sat, Jun 27, 2026 at 10:59:16AM +0800, Lance Yang wrote:
>
>
>On 2026/6/27 10:07, Wei Yang wrote:
>[...]
>> 
>> Hi David
>> 
>> I did a little adjustment like below. Want to check with you at first.
>> 
>> > 
>> > >From 048ecd33673ec649e168fbbb97749a7c0e344fcd Mon Sep 17 00:00:00 2001
>> > From: "David Hildenbrand (Arm)" <david@kernel.org>
>> > Date: Fri, 26 Jun 2026 12:03:40 +0200
>> > Subject: [PATCH] tmp
>> > 
>> > Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>> > ---
>> > mm/page_vma_mapped.c | 29 +++++++++++++++++------------
>> > 1 file changed, 17 insertions(+), 12 deletions(-)
>> > 
>> > diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
>> > index 2ccbabfb2cc17..ed2a23a90e8dd 100644
>> > --- a/mm/page_vma_mapped.c
>> > +++ b/mm/page_vma_mapped.c
>> > @@ -243,21 +243,31 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>> > 		 */
>> > 		pmde = pmdp_get_lockless(pvmw->pmd);
>> > 
>> > -		if (pmd_trans_huge(pmde) || pmd_is_migration_entry(pmde)) {
>> > +		if (pmd_trans_huge(pmde) || pmd_is_migration_entry(pmde) ||
>> > +		    pmd_is_device_private_entry(pmde)) {
>> > 			pvmw->ptl = pmd_lock(mm, pvmw->pmd);
>> > 			pmde = *pvmw->pmd;
>> > -			if (!pmd_present(pmde)) {
>> > +			if (pmd_is_migration_entry(pmde)) {
>> > 				softleaf_t entry;
>> > 
>> 
>> How about:
>> 				const softleaf_t entry = softleaf_from_pmd(pmde);
>> 
>> > -				if (!thp_migration_supported() ||
>> > -				    !(pvmw->flags & PVMW_MIGRATION))
>> > +				if (!(pvmw->flags & PVMW_MIGRATION))
>> > 					return not_found(pvmw);
>> > 				entry = softleaf_from_pmd(pmde);
>> 
>> could be removed.
>> 
>> > +				if (!check_pmd(softleaf_to_pfn(entry), pvmw))
>> > +					return not_found(pvmw);
>> > +				return true;
>> > +			} else if (pmd_is_device_private_entry(pmde)) {
>> > +				softleaf_t entry;
>> 
>> The same.
>> 
>> > 
>> > -				if (!softleaf_is_migration(entry) ||
>> > -				    !check_pmd(softleaf_to_pfn(entry), pvmw))
>> > +				if (pvmw->flags & PVMW_MIGRATION)
>> > +					return not_found(pvmw);
>> > +				entry = softleaf_from_pmd(pmde);
>> > +				if (!check_pmd(softleaf_to_pfn(entry), pvmw))
>> > 					return not_found(pvmw);
>> > 				return true;
>> > +			} else if (!pmd_present(pmde) ){
>> > +				return not_found(pvmw);
>> > 			}
>> > 			if (likely(pmd_trans_huge(pmde))) {
>> > 				if (pvmw->flags & PVMW_MIGRATION)
>> 
>> How about merge this with above? And put at the first case?
>> 
>> Below is what it looks like:
>
>Why add more churn to a fix with a stable tag? Cleanup can come later no?
>

OK, will leave it for future cleanup.

-- 
Wei Yang
Help you, Help me
