Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A26729B77C
	for <stable@vger.kernel.org>; Wed, 24 Jun 2026 02:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782266972; cv=none; b=T2D0d9UOdfN6yYDRcW/dsojOFsO9u4mpHvhxIcWfv2JEx0DiKZkC9lFygDLTnqOrYx9ZO3JB5vqEd1qAetAN6puMW4gRTR68L18tuxzaS3DXVAuYESDMjx+0DW4UqgB5k9Bsg5IizsCiYmjcIWPvDSO6SYHokGtL9WjkbOM/quc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782266972; c=relaxed/simple;
	bh=E7b8aiHUJxxp6b18iAyjv9pELyE1uy9CwX8yPlbPKls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFM5rqXIU5OgfsuXb+6CPKirm1azywqlyQlI4tSxySESQeFgiUza1ABAuR641pRg9tN7kSwX4/fBFXOzoMnuISqdCPP26LWPWu9DWfA1hbOJUolFDEZYFhWAd4JHAeLBmYMGjIz3RFafETX1aEEaXQctDSFhNTmkZ+glM35LMKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJlLLrbu; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJlLLrbu"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-befee9e5ef7so58267566b.0
        for <stable@vger.kernel.org>; Tue, 23 Jun 2026 19:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782266969; x=1782871769; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+Dbr5cCySdCqBqi2ttFxVY6H+Q6f9EeFLzVyFXEO3Y=;
        b=QJlLLrbuI04n4onk1HwSht5i53LS19Y2CCJ8WnlRhCIH2CFv1hFHWhfjA19UwhX+ym
         NIXhZKteCElDjl3RNKTwCAKtDwsmEzt6pxIhAcG7r9wFnqqhLMPb26isyz4QQBu7PR+K
         qQtURdIEI60BPvuv+rjPysbnfiBNBsqhNQ8dWSUd/6E08RXN/wQoaMhGemRZkk67wRlV
         xwxe5QPO31UzFCREd+zFNDDC2+GsHUoYUrBksM+3o6Qj7JvuHj/g2C549Sv6XcqKsNxn
         QmJ7eqgrgbSYifVRe/q6jHSGaywMK7rR6/YSvQpLDQFA+DrS2wsPPy04AkbgmbkTwwP8
         sfRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782266969; x=1782871769;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T+Dbr5cCySdCqBqi2ttFxVY6H+Q6f9EeFLzVyFXEO3Y=;
        b=AiXEUVEdgfBdzLiAU6oDaQSlskmRYa2mWGO4kaTJ4X0vu2ObJVCLb7m4tJSxPkVzRF
         hE6nViWj93J/eC2LZgJ9mKS3Rlnuh1lpTRTIrqAxCpgeUXzCYVjD8G4S6g1IswCX6+30
         C01Gpfl3y9nAcmvR7/J/nyqj8uA+6VueKNUbZzmeT/lRnhNPmNvVCuUtmzTZvxsVzOQL
         KAeOAh4bIn25XTSu4H43Ach0RucaSd96uNykOAZK9diZnJr3D6SBmv2UsFAZJnSD6FsA
         yEwQca7hvPQLvfXKZjP6CDvHIicuh3MsI0J7G9J7ml3otFXQP8r0Wj7b9dDIJlVg7itK
         RhlQ==
X-Forwarded-Encrypted: i=1; AFNElJ8K0gdgNyqOKhdsMVzu6cfCvZ5oTzcZftOq4VXaxD4AeLBIsjLHpRuutE0y8BOwXEbz1LMvriU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu5ZIPuRlXBbtQI8Hdg3hJ+rUTBXno3BbddH42wKLFLKJ07vK0
	ehUQjXmM681L5TYtuCkWgyX3ADqHvZgvYjhLH39AO8ygrhqk1MsYf081
X-Gm-Gg: AfdE7clhm+sqraLjFihdRoi4ZAAe1n4DAZQMRMNhUMgSK493mPk2kapKRDSGq2xzltW
	QFHI3my62YSKmREtclw56OBU9fls9W4QtutlfqtcQ1YfuoLpZLYBZSZkco8e1Ag7NlQmu1C2ckl
	9W7yzEJRwz/lWuRdB21Onoorbx4SYr3zCErgP1xCdMsAlBjDqDDtt8QIilH1I6qfk6fZ2Pwlnp2
	7m4IrSqCtKtafm6fX3X1AK9a7BH2TquAai7GxP90/w5NKHYJFAoTYXV1CvIXUDZ2xduXl+YPrXP
	EZp2sOqajOTS+iU1rTHu0lkiZksnzfuGkCobLv6dijkHm2Sm2g0chp8joVjJ5axK99ye/aoCG6u
	CzRtN3jrs4VpQ1xpTHlIv4n5/cImYhjAxAIZ4kL0KU0LMdw4Yc4Tv2YNtXPUvNh/C9SLEglpNrY
	dUqQR8PPSD3/ZD3dmvbou66A==
X-Received: by 2002:a17:907:6ea3:b0:c0d:46ca:3ae9 with SMTP id a640c23a62f3a-c119de5e9b5mr42425466b.3.1782266968386;
        Tue, 23 Jun 2026 19:09:28 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c5e998d90sm598331066b.17.2026.06.23.19.09.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Jun 2026 19:09:27 -0700 (PDT)
Date: Wed, 24 Jun 2026 02:09:25 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
	david@kernel.org, riel@surriel.com, liam@infradead.org,
	vbabka@kernel.org, harry@kernel.org, jannh@google.com,
	sj@kernel.org, ziy@nvidia.com, balbirs@nvidia.com,
	linux-mm@kvack.org, stable@vger.kernel.org,
	Lance Yang <lance.yang@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_vma_mapped: revalidate and do proper check
 before return device-private pmd
Message-ID: <20260624020925.3lbraicwe4uzhn3h@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20260622130651.23359-1-richard.weiyang@gmail.com>
 <ajk0N3Aekapljaoh@lucifer>
 <20260622142102.pcmr5pftshj5lvju@master>
 <ajld6RKK02Vi-LxM@lucifer>
 <20260622234518.nnx3r7ckphlxn5vm@master>
 <ajq4_VndR8gwponS@lucifer>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajq4_VndR8gwponS@lucifer>
User-Agent: NeoMutt/20170113 (1.7.2)

On Tue, Jun 23, 2026 at 06:02:56PM +0100, Lorenzo Stoakes wrote:
>On Mon, Jun 22, 2026 at 11:45:18PM +0000, Wei Yang wrote:
>> On Mon, Jun 22, 2026 at 05:11:02PM +0100, Lorenzo Stoakes wrote:
>> >On Mon, Jun 22, 2026 at 02:21:02PM +0000, Wei Yang wrote:
>> >> On Mon, Jun 22, 2026 at 02:46:40PM +0100, Lorenzo Stoakes wrote:
>> >> >+cc Lance, linux-kernel
>> >> >
>> >> >Your subject line is 83 characters long and is way too detailed how about 'fix
>> >> >device-private PMD handling'?
>> >> >
>> >>
>> >> Got it.
>> >>
>> >> >You forgot to include linux-kernel@vger.kernel.org on the mail, lore seems to be
>> >> >a bit broken atm but in general it's helpful to include that.
>> >>
>> >> Got it.
>> >>
>> >> So usually we send a patch to both linux-mm and linux-kernel? If so, I
>> >> remember is later actions.
>> >
>> >Yeah it's better for dealing with kvack going wrong etc. :)
>> >
>> >>
>> >> >
>> >> >Also is useful to make this [PATCH mm-hotfixes] to make it really clear it's
>> >> >intended as a hotfix.
>> >> >
>> >>
>> >> Got it.
>> >>
>> >> >Some commit msg language nits:
>> >> >
>> >> >On Mon, Jun 22, 2026 at 01:06:51PM +0000, Wei Yang wrote:
>> >> >> For pmd_trans_huge() and pmd_is_migration_entry(), we does following
>> >> >> before return the pmd entry:
>> >> >
>> >> >Sounds better as:
>> >> >
>> >> >	For PMD entries that satisfy pmd_trans_huge() or pmd_is_migration_entry(), we
>> >> >	perform the following actions:
>> >> >
>> >>
>> >> Sure.
>> >>
>> >> >>
>> >> >>   * re-validate pmd entry after PTL
>> >> >>   * check PVMW_MIGRATION
>> >> >>   * check_pmd()
>> >> >>   * handle on pte level if split under us
>> >> >>
>> >> >> But for device-private pmd, we just return after pmd_lock().
>> >> >
>> >> >->
>> >> >
>> >> >	However, for device-private PMD entries, we simply acquire the PMD lock
>> >> >	and return.
>> >> >
>> >>
>> >> Sure.
>> >>
>> >> >Also can you please give some justification here as to why all this also applies
>> >> >to device-private PMD? Right now it sounds hand wavey.
>> >> >
>> >>
>> >> I thought below paragraph explain it. Not sure what justification is preferred.
>> >
>> >Something about device private PMDs splitting the same way THP ones do, in the
>> >pmd_is_device_private_entry() branch of __split_huge_pmd_locked().
>> >
>>
>> Hi, Lorenzo
>>
>> Thanks for your detailed suggestions.
>>
>> I tried to add the justification here, and the following is the commit log
>> after consolidate your suggestions.
>>
>>     For PMD entries that satisfy pmd_trans_huge() or
>>     pmd_is_migration_entry(), we perform the following actions:
>>
>>       * re-validate pmd entry after PTL
>>       * check PVMW_MIGRATION
>>       * check_pmd()
>>       * handle on pte level if split under us
>>
>>     However, for device-private PMD entries, we simply acquire the PMD lock
>>     and return. This is not enough, as __split_huge_pmd_locked() would split
>>     a pmd device-private PMD under us just as it does for THP PMD.
>>
>>     This is particularly problematic when PVMW_MIGRATION is set (meaning a
>>     migration entry is sought), as it causes a device-private PMD entry to
>>     be returned with a different data layout, causing memory corruption.
>>
>> Just feel this is not that smooth. Would you mind taking another look to see
>> if I get your point correctly?
>
>Honestly I'd just drop the whole pmd_trans_huge()/pmd_is_migration_entry() bit
>and say:
>
>	Commit 65edfda6f3f2 ("mm/rmap: extend rmap and migration support
>	device-private entries") introduced the concept of device-private
>	PMD entries, but did not correctly update the rmap walk code to
>	account for them.
>
>	As a result, when page_vma_mapped_walk() encounters device-private
>	PMD entries, it takes no action other than to acquire the PMD lock
>	and exit.
>
>	However this is highly problematic for two reasons - firstly,
>	device private entries possess a PFN so check_pmd() needs to be
>	called to ensure an overlapping PFN range.
>
>	Secondly, and more importantly, if PVMW_MIGRATION is set the
>	caller assumes the returned entry is a migration entry, resulting
>	in memory corruption when the caller tries to interpret the device
>	private entry as such.
>
>	In addition, commit 146287290023 ("mm/huge_memory: implement
>	device-private THP splitting") allowed device private PMDs to be
>	split like THP mappings, but again did not update this code path.
>
>	As a result, we might race a PMD split prior to acquiring the PMD
>	lock.
>
>	This patch addresses all of these issues by invoking check_pmd(),
>	ensuring PMVW_MIGRATION is not set and checks whether a split raced
>	us we do for PMD THP and migration entries.
>

Have to say this is much much better, thanks!

>
>Cheers, Lorenzo

-- 
Wei Yang
Help you, Help me
