Received: from mta0.migadu.com (out-229.mta0.migadu.com [91.218.175.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3DA392811
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 09:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792144421; cv=none; b=dY4Q8gG7VwCQjW72SOFKo3W8lowJG5vlzokucPMN4iZ5sLidkFimO327btHYYyROn34IQ5Sw7d3ItWgbNQWN1gHpNj1ELxBXw7Oe8tAvKsbjEr1Fxn/Zpz+iZJmpjS5mXmSSjRdepDDIOYDrDOU+bRKmokbl2pQFLMw8Or4i3ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792144421; c=relaxed/simple;
	bh=AdcwzOjotHxE19RLxZFm3OWWctumeLKS1NSG9llBa2k=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=RANcrFMWchEqQ7x9GEZI/PBgWbwqp6pTHRKic1It0IF8I4uJ5AxKtOUnLBNypNXoB31K9p+MYBri/Ok1d0ULPJg7mybrYKpfr8jI5kacLbRp2eo09FcCcG/JcAJnEyofUfMpiLO09elpZJ4jxqwn3jzQwPspnGRXHlwkQ10dw7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h9ug+C9q; arc=none smtp.client-ip=91.218.175.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h9ug+C9q"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=AdcwzOjotHxE19RLxZFm3OWWctumeLKS1NSG9llBa2k=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792144418; v=1; x=1792749218;
 b=h9ug+C9qaUfR5JSkmmWi910MYY9+pSkIEish8X2qfNLh6R2Wpgx182XL9Jp8qySJu7Dk48Ch
 9CPHaTAhJGKYSz+2PW6exFcFghXyfp80Su2BrTbdLACymOvtbiqVoIgL53WiWJE29O5+hztCC8Y
 W45eoDfaDMlSpb8PJdC1hp4w=
X-Envelope-To: stable@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 2c46a001e07853f7;
	Fri, 16 Oct 2026 09:53:38 +0000
X-Mizu-Trace-ID: 2c46a001e07853f7
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.12\))
Subject: Re: [PATCH 10/10] mm/mremap: fix calling fixup_hugetlb_reservations()
 on the wrong VMA
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20261015-urgent_fixes-v1-10-42796911043b@kernel.org>
Date: Fri, 16 Oct 2026 17:53:20 +0800
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <liam@infradead.org>,
 Lorenzo Stoakes <ljs@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>,
 Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>,
 Oscar Salvador <osalvador@suse.de>,
 Miaohe Lin <linmiaohe@huawei.com>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>,
 Adam Litke <agl@us.ibm.com>,
 Mel Gorman <mel@csn.ul.ie>,
 Rik van Riel <riel@surriel.com>,
 Peter Xu <peterx@redhat.com>,
 "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Josef Bacik <josef@toxicpanda.com>,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <73BE5C1E-5F2E-4F1D-BC8A-24CC8E9F9D34@linux.dev>
References: <20261015-urgent_fixes-v1-0-42796911043b@kernel.org>
 <20261015-urgent_fixes-v1-10-42796911043b@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: Apple Mail (2.3901.100.1.1.12)



> On Oct 16, 2026, at 00:07, David Hildenbrand (Arm) <david@kernel.org> =
wrote:
>=20
> In case we fail to move the page tables, for example, because we fail
> to allocate a page table, we actually keep the old VMA.
>=20
> Calling fixup_hugetlb_reservations() on the old VMA is wrong. Fix it
> by just calling it on the VMA that will be removed.
>=20
> The user-visible impact is that the VMA loses its reservations, =
meaning
> that the existing reservations get stranded (leaked) and new hugetlb =
folios
> that are getting allocated in the VMA cannot make use of the
> reservations, failing these allocations.
>=20
> Fixes: b714ccb02a76 ("mm/mremap: complete refactor of move_vma()")
> Cc: stable@vger.kernel.org
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Acked-by: Muchun Song <muchun.song@linux.dev>

Thanks.

