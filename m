Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FDF48AE12
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 23:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781653829; cv=none; b=H/jRXmPYI8g6LnceMsVG2/+rj6fg1tUb+l+VlKAj1yI6f7MAsPzuPbQ1UwPxB9G4b+5GyUzcz7D/l8JNMiZDnoPvTMpdeuB9j7kF9drw1vP7RjPMVRrw9CotyNtWjIsDCIWIGbzrFfH+wYiX6b7Vq60LiC1uALZE87tZ+Kb3Yoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781653829; c=relaxed/simple;
	bh=d/lyB48HnNIlPASc6akauHF+VHYcnJuFLIz0EP29zqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SNhylY+dw78gqa4FdOFEWxbW5x4OQri3Cm6I6zINBgx1B3pB4LJ8kSmnB+zSuItz5f7bgMqyc+ewQ/BCPntE4YgWrObtadUo9H/zd1bdr6Dk9Yg4MNEq4q2KxNbgGRBc6zJldligfxlMMKFAyc2foJwiR3r6LIEVCAFGGR85Vqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fmYoI7ll; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmYoI7ll"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6913fb25322so6721283a12.1
        for <stable@vger.kernel.org>; Tue, 16 Jun 2026 16:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781653826; x=1782258626; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XYXAdHjBb50GzCmVXSvykxewhsYbV/+YVuzJ3H00HQU=;
        b=fmYoI7lloljaulEUkkMM5iyrsYffw3bxBhXbu3P8h2DsW/BGazWqQ8xanpIkB5/XAh
         kZZYTtrRu1ke1v0I8fjKnPj63ztWp01JJzo6eDZCdcrx9dPVbiRU04YW0OPrx5m2wA7S
         5DO9XAlU9NCi8Yy+U9GlhORI6FuZfx8NhcltUQVtSlGwWHX4OW68aUHwfG6JvEMNPV4x
         6r3OQ+nEF4Yza+yEpe4yYje40nVaG1LPBEf9V+peRsf4lf8ZEhmNvrGZhRNBYqKEI0WC
         C5giuENTswpE53befXep0eGQEj33ejXKMh4S9hTD2omsWL3Fk8Qf1Mh1uGwyPbtXjXQA
         qhZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781653826; x=1782258626;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XYXAdHjBb50GzCmVXSvykxewhsYbV/+YVuzJ3H00HQU=;
        b=qLLwn5Iajak4+TZTCV5p8zAc3mH606g1FUzuuPgaOTo96fuM1eV55jNtgAa9689nf4
         0717XZjTenS3CSKMWHRdP/7lO/rVUZsm/Dh2rQHLnAmct2nidApmQseo4J5YHg4LjAGM
         Jc1wRYYo2hV3gntRMCRcEpeWFJWkEgHP9dbT9w0JhiP+1YktfkwUnGsAF3UtSv9R7PU0
         9x0QS4hovI82REikNoc33TZmiXUIAqM08Wo8Zqipv5p9ge/6WYNrPpdFtvIX3wVOBLaT
         Xqz7cu+IJ6DjL23KTQqPuwaZIAirHsZ3VUP4j3rTNzuTYyyPFtc96cJbJTlNP8SLLrv1
         TMAQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Wyq0OVIHjZf9CXbkmQJY1Rj0VU/24T6zpuly79XbIpl4RU9hhg5ZautBgrgJjozVvmYyUaQA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsf5HNYT+Ivw8SBBctZFnVmsQG+o6w8KvOxSOrrO7goc5y4LEM
	llh6ge4F6EceAniPbwg+DtqIxAbyb4wbOMeJerrZ1fhcjNCIi5G+o4Q1
X-Gm-Gg: Acq92OE0hzrX/BdIrJcFhYr+2r9grVHmdLiNInhb5lpVD8sveMVNIYanLjJY5nTVf2E
	n4s9N02z5hh4DAyseabolJhM5TJOfzKYN2lDqbm/Epfwy7GKrBWyVmo+5sla5ONCzmxR2zbqK+z
	+DaRIiF0T+BdBbsDqpZ37IDiAaAk4flrn1qy+kp679zN+EcIRoMm9iHQecHqXcXGCNGo0LzgnKr
	TNgOVq/fLQueMQvSEJ9whrUADbSRg+0ZoMb1GnxGbJ9V4cogAG5KtiGuf1q0zyIvA4kDne5RSJK
	2ZjkBQXCzidj3Lup472mHkkOTA05jdO59G9Bvy/r1AoW1sEIv1KnzWtWfgUyuaEll9yFmR7dopo
	7GQ3qh55b8DnyanVUegpaLC5QzOvoqrAfcIhrKMc877NyEjWfLl0neijpMm8bGwQgH1adwQRq+1
	Dy0iFMqtMfIVbD1pJz54EiDw==
X-Received: by 2002:a17:907:7387:b0:bec:2d7f:fe03 with SMTP id a640c23a62f3a-c05d215ac07mr40439766b.17.1781653826221;
        Tue, 16 Jun 2026 16:50:26 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb7b6d9b7sm715657866b.41.2026.06.16.16.50.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Jun 2026 16:50:24 -0700 (PDT)
Date: Tue, 16 Jun 2026 23:50:22 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Lance Yang <lance.yang@linux.dev>
Cc: richard.weiyang@gmail.com, akpm@linux-foundation.org, david@kernel.org,
	ljs@kernel.org, riel@surriel.com, liam@infradead.org,
	vbabka@kernel.org, harry@kernel.org, jannh@google.com,
	balbirs@nvidia.com, ziy@nvidia.com, sj@kernel.org,
	linux-mm@kvack.org, lorenzo.stoakes@oracle.com,
	stable@vger.kernel.org
Subject: Re: [Patch v2] mm/page_vma_mapped: revalidate and do proper check
 before return device-private pmd
Message-ID: <20260616235022.iesy2jeb2p7zof2l@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20260616063436.20455-1-richard.weiyang@gmail.com>
 <20260616123001.6501-1-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616123001.6501-1-lance.yang@linux.dev>
User-Agent: NeoMutt/20170113 (1.7.2)

On Tue, Jun 16, 2026 at 08:30:01PM +0800, Lance Yang wrote:
>
>On Tue, Jun 16, 2026 at 06:34:36AM +0000, Wei Yang wrote:
>[...]
>>diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
>>index 2ccbabfb2cc1..21635fab209c 100644
>>--- a/mm/page_vma_mapped.c
>>+++ b/mm/page_vma_mapped.c
>>@@ -243,40 +243,28 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>> 		 */
>> 		pmde = pmdp_get_lockless(pvmw->pmd);
>> 
>>-		if (pmd_trans_huge(pmde) || pmd_is_migration_entry(pmde)) {
>>-			pvmw->ptl = pmd_lock(mm, pvmw->pmd);
>>-			pmde = *pvmw->pmd;
>>-			if (!pmd_present(pmde)) {
>>-				softleaf_t entry;
>>-
>>-				if (!thp_migration_supported() ||
>>-				    !(pvmw->flags & PVMW_MIGRATION))
>>-					return not_found(pvmw);
>>-				entry = softleaf_from_pmd(pmde);
>>-
>>-				if (!softleaf_is_migration(entry) ||
>>-				    !check_pmd(softleaf_to_pfn(entry), pvmw))
>>-					return not_found(pvmw);
>>-				return true;
>>-			}
>>-			if (likely(pmd_trans_huge(pmde))) {
>>-				if (pvmw->flags & PVMW_MIGRATION)
>>-					return not_found(pvmw);
>>-				if (!check_pmd(pmd_pfn(pmde), pvmw))
>>-					return not_found(pvmw);
>>-				return true;
>>-			}
>>-			/* THP pmd was split under us: handle on pte level */
>>-			spin_unlock(pvmw->ptl);
>>-			pvmw->ptl = NULL;
>>-		} else if (!pmd_present(pmde)) {
>>-			const softleaf_t entry = softleaf_from_pmd(pmde);
>>-
>>-			if (softleaf_is_device_private(entry)) {
>>-				pvmw->ptl = pmd_lock(mm, pvmw->pmd);
>>-				return true;
>>-			}
>>+		if (pmd_present(pmde)) {
>>+			if (!pmd_leaf(pmde))
>>+				goto pte_table;
>>+			if (pvmw->flags & PVMW_MIGRATION)
>>+				return not_found(pvmw);
>>+			if (!check_pmd(pmd_pfn(pmde), pvmw))
>>+				return not_found(pvmw);
>>+		} else if (pmd_is_migration_entry(pmde)) {
>>+			softleaf_t entry = softleaf_from_pmd(pmde);
>>+
>>+			if (!(pvmw->flags & PVMW_MIGRATION))
>>+				return not_found(pvmw);
>
>Looked at history a bit, and I wonder if this changed something old
>here ...
>
>Since 616b8371539a ("mm: thp: enable thp migration in generic path"), PMD
>migration handling took PTL before doing PVMW_MIGRATION/PFN checks,
>including not_found() cases. So lockless PMD read was just a filter ...
>
>With this fix, true case gets final pmd_same() check, but this
>not_found() case happens before taking PTL.
>
>So a !PVMW_MIGRATION walker could race with someone, e.g.
>remove_migration_pmd(): we make the not_found() decision from old PMD
>value that still says "migration", while real *pvmw->pmd may already be
>present again. We return without ever taking PTL :)
>

Hi, Lance

Thanks for take a look.

I am trying to understand the scenario you mentioned. Let's say A migrate a
pmd and B want to unmap the pmd.

            A                                        B

  try to migrate a pmd
  pmd is set to migration entry
                                           unmap the pmd ...
  managed to finish migration
                                           ...still see migration entry,
                                           so skipped and unmap fail

Would this be a timing case? Even B grab the PTL, it still could see migration
entry if B visit pmd before A finish migration.

Maybe I miss something, look forward your insight.

>Not sure about practical fallout, but should these PMD-level not_found()
>cases also take PTL and restart if PMD changed?
>

-- 
Wei Yang
Help you, Help me
