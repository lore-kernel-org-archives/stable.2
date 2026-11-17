Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794911640;
	b=4QKUc8osoJZnWK1b5K+PvbhoqTVJvNTIArtYQLJVt0f8o8YvIqciuw3xd9uy2ASYxxuF
	 oeuhLG0md9VMhwqECdadr43lfJ6QQSVqRVM44F/mS6FGdo2tZ3PePiUfx3kIri+Qq9m1n
	 XkA7dgha2tt3eizQeYSJwxpFaf56TJ0MMKLe33U3IY/JeerFTJ/mDmpiYk70I2oeggaSg
	 D2zBWZqFIn1+r34dUXiUBuSAWMPaQHM8G/MZ6G4vmEqAMNiHLRQJflTVigP9X9uqys36r
	 vFZnySgB+X5Yk+bgl8X4mv/Ghn+9Mez3pcV4iANIePATVQO5mescc7KTYJo0n+Fqw0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794911640;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=9Y6jdRs43MMUd5mnE51/FCbB/e1QngRZEN/6HJJEEn8=;
	b=XOF7uIrPjGMQQ/kvkiURWOpS4SudxC1EeWT2vLZI/xpbLIMzbbblEIL/SRrdyg1624Dq
	 IsoRjIF3dJq2KiabEg96Z1voXQ17oVAgs68XdN9nuW1DjTcorPXy37rUsQCXSSsIAIm9V
	 RmJ/yJ4Ljz7ZDtlGqAAzZMYLop3HMmifpx5/eM8wa0kQOP1xgbWB89pPLWJs7bsdzuWZI
	 5NYO8xWv/OhiiPT/e8+bGKnFH/AVQaVaIHngt7AjNN6/cVTXLO4JyFlqgIV50n1L2vq8c
	 bKOHr6fp3hAdLRTSo+QBBoJoURWFY4+Z9Pm43/XVz9/T38tEU67KRegPYIjKuiStKFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZcuBnwNe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885CA606A32A;
	Tue, 17 Nov 2026 10:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZcuBnwNe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3B391F000C9;
	Tue, 17 Nov 2026 10:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794911640;
	bh=9Y6jdRs43MMUd5mnE51/FCbB/e1QngRZEN/6HJJEEn8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZcuBnwNeDiCXzLwxbBkXg8DN3x/a7sDzhYg+N2XKZy75f29UaQRknKbgElnPdPze5
	 yV2H1UjUo7+IX3YkYZ+FXiYYvKNsavZeIsOXhzS7uybD8fvnLbBNEMfHq6+c2mz8yi
	 rc35XfpYmAYdYeplpLsYqqJ3k5t1OYA0ZtcGEvLzHpwCpF0jQTUiz5fqi/WueiEJTs
	 OTos4PjiXMwps7EMQcnRm5IQpXIlsW3L80jDAy79QbzcCD3HzsrMclnxsvjcRLbMG6
	 4arbBL5n8x2OvH1/qEZNNmCjD1ctsk0JC5bSUixoiLZFe5qDfKHrkWXWyoHSd+BbQE
	 28lq34RCxxPDg==
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfauth.ams.internal (Postfix) with ESMTP id 367B11980047;
	Tue, 17 Nov 2026 05:33:51 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 17 Nov 2026 05:33:56 -0500
X-ME-Sender: <xms:ji38al9U-A9k9GqY5Vjo6Wlp300UGDaK750bgl1O6jnux9bo3o5-hQ>
    <xme:ji38agYYWZT4Oylp-ZIjxdISzQbNyW08g44Opy1PUbkJ5_BAjdztGux4wAVob-ubF
    sGPFtoBD68Swc3B45Gp26HVb73yHY3HasbRLHPddQOTS4i04CCVjAJS>
X-ME-Received: <xmr:ji38anfzunD68jqATVMcyffrfLUwjJrMTeHab3NZ6oSzI8ot9X95jKgIBl4>
X-ME-Proxy-Cause: dmFkZTGPoCZIOo/tLs+Jt+MNHEmRpH88IwE5gjVBo57y2PhV3xWyC7Orpw8u3hp9Sbsccf
    sXwt6xUeMAogQH7zZvv/pYlPFYqWnSoj1Rdm2isbXzFwg6zfm38sm+AQpZvy49cVwXdb7r
    vVlDCMrtvmBVbG0q+uBYPlLixR8jQfegKQU0DMP3tRnaXusL5beUtu65ZIuBoACs9qAJnO
    omyZk6X+S08zPnin8zP6uc/QQjwy9dVJp4qPj/VrzVDDlxNGwYHUx3loE+Ute9wlrCfK6Z
    fE23V+MKFqIh5EKMNNDVh8scW8u3EEK/CgMlNw+xqUGFFsvMYQ/ROnA+NPMY6/OHiO1SMu
    Llo8g7ojqT75VbxWo5K+LFkZVEo/rBG59vu1epq9BFxhrECQ9+7upcL/ZIv88Vp1qr3Kdn
    w+cJ4GLs0MJMFFNjsC0mgyfGTJgXJYCxsPiALYLd3+5vOXbHayeaaXCNOv3ECHgO7PrHEB
    LS9ptwb+Nz8o+Nx2gdYuKxTRu5QjJv/+TTlM1OInQxL95R5VPySwvBds6Jkp8SSqVa8aA6
    WpfEFBCXDfQBHlHX/LLFFlUUQoFakSH6XhebYIY3Gm5EyPZf9uGeaHEHpsK47gblP6/yOP
    xM2WhpaJAgTHegCsiQIfKYIwh3upci4zvXmLjwR0HLdlPoIhYddkxGKVHaUA
X-ME-Proxy: <xmx:ji38anriSs2E8qw_U6l9QyA8TecYQEH3pa0tNws1LYfT0wFGFXoTHQ>
    <xmx:ji38ag84_WU6TMq3OYf9z6IWk2cPUzK8V8LeZZL951tvIqHwSxqvSQ>
    <xmx:ji38arISS9EdnkQK94hqvguI-cTUOEI5QfrugXTHLcrEspAUGbpLtg>
    <xmx:ji38amOnf0c-5KjEHTTH38TWSpEGmU3PkR2uCycMfvadPdGaqPUjIA>
    <xmx:ji38an_oN9qoF0edvVZ0A4Eu4hqrbBuA7Alhxc9znTtQp8_OHztP9YFm>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Nov 2026 05:33:49 -0500 (EST)
Date: Tue, 17 Nov 2026 10:33:48 +0000
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Usama Arif <usama.arif@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, apopple@nvidia.com, byungchul@sk.com, gourry@gourry.net, 
	jannh@google.com, joshua.hahnjy@gmail.com, liam@infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, ljs@kernel.org, 
	matthew.brost@intel.com, mhocko@suse.com, pfalcato@suse.de, rppt@kernel.org, 
	surenb@google.com, vbabka@kernel.org, ying.huang@linux.alibaba.com, ziy@nvidia.com, 
	hannes@cmpxchg.org, riel@surriel.com, shakeel.butt@linux.dev, kernel-team@meta.com, 
	baolin.wang@linux.alibaba.com, Nico Pache <nico.pache@linux.dev>, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/4] mm/migrate_device: avoid leaking folio references
 during THP splitting
Message-ID: <avwtWUVHwcJJKfWR@shutemov.name>
References: <20261116063624.1382944-1-usama.arif@linux.dev>
 <20261116063624.1382944-2-usama.arif@linux.dev>
 <40f86b39-96cb-4fb3-9282-ec06504774e5@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40f86b39-96cb-4fb3-9282-ec06504774e5@kernel.org>

On Mon, Nov 16, 2026 at 07:44:42PM +0100, David Hildenbrand (Arm) wrote:
> On 11/16/26 07:34, Usama Arif wrote:
> > migrate_vma_split_unmapped_folio() takes an extra folio reference because
> > split_huge_pmd_address(..., true) drops one when it splits a PMD.
> > 
> > However, migrate_vma only holds mmap_lock for reading. A concurrent
> > MADV_DONTNEED can clear the migration PMD, or split it into PTE migration
> > entries, before the split helper takes the PMD lock. The helper then does
> > nothing and leaves the extra reference behind. folio_split_unmapped()
> > fails with -EAGAIN due to the unexpected reference, and the reference is
> > never dropped, so the source THP is leaked.
> > 
> > If a THP is faulted in at the same address inside that window it is
> > worse: freeze = true replaces the new folio's mappings with migration
> > entries that nothing will ever remove, and drops a reference the caller
> > never took.
> > 
> > An existing migration PMD is expanded into PTE migration entries even
> > with freeze = false. Use that mode and remove the extra folio_get(). The
> > reference already held by migration keeps the source folio alive whether
> > or not its PMD migration entry still exists.
> > 
> > Reported-by: Zi Yan <ziy@nvidia.com>
> > Closes: https://lore.kernel.org/all/DLZ48KMS7YG8.3BTM0UUU8CTU2@nvidia.com/
> > Fixes: 4265d67e405a ("mm/migrate_device: add THP splitting during migration")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Usama Arif <usama.arif@linux.dev>
> > ---
> >  mm/migrate_device.c | 7 +------
> >  1 file changed, 1 insertion(+), 6 deletions(-)
> > 
> > diff --git a/mm/migrate_device.c b/mm/migrate_device.c
> > index 9e19fadfa65c6..3286bb8a4b73e 100644
> > --- a/mm/migrate_device.c
> > +++ b/mm/migrate_device.c
> > @@ -920,12 +920,7 @@ static int migrate_vma_split_unmapped_folio(struct migrate_vma *migrate,
> >  	unsigned long flags;
> >  	int ret = 0;
> >  
> > -	/*
> > -	 * take a reference, since split_huge_pmd_address() with freeze = true
> > -	 * drops a reference at the end.
> > -	 */
> > -	folio_get(folio);
> > -	split_huge_pmd_address(migrate->vma, addr, true);
> > +	split_huge_pmd_address(migrate->vma, addr, false);
> >  	ret = folio_split_unmapped(folio, 0);
> >  	if (ret)
> >  		return ret;
> 
> Oh, that means we can remove the parameter from split_huge_pmd_address no? Best
> as a cleanup patch once this is in for-next-fixes.

Yeah, that's would be great.

> Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>

The patch looks good to me too:

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
