Received: from mta1.migadu.com (out-162.mta1.migadu.com [95.215.58.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A386331A66
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 07:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792134970; cv=none; b=Uge1RFSi4V6D5EiatdfuValdG8DYY01WuL0laaqKWYTjO7OzuC4VJkGsPLPNOnkid2zd0cCiwicTc6nlmpQjiSeX0UixUDp946ClbkwgtUlIhcYQmHjo+4xqyEOHWFxzvAPff5hXRdGY4wlepvO8MQ4xlEL8XYzEzH2vQNOC/pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792134970; c=relaxed/simple;
	bh=xgR1cjGY6ygGqvZie7u+u7EotdvcRJPIfh8Sp0piRWA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=rZYnn7e9o+vUV9fs0pRTN/5UayhbqQ4pxXDYOJhLVR5KUEe5ZAkgTS2aRPGTi1Ykwe0uGUxjdKiibnhQpLY1Ilj1E9nucvEEapBCO1d5QSjr8MaUkW5CjoqDA9IeVKiG7EAOnDMGQGaO+qnntzLw8O678j9yZHnpJiTGnWOT5MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Gh+C1jE5; arc=none smtp.client-ip=95.215.58.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Gh+C1jE5"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=xgR1cjGY6ygGqvZie7u+u7EotdvcRJPIfh8Sp0piRWA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792134966; v=1; x=1792739766;
 b=Gh+C1jE5wn1ZarWB5JQV5xiMzm8445W0lzudkTz3wslMuSkdchSOteQiYbBTMPuEinwJNEyQ
 TNtaNC8dz+GxI8cPoLvenIPip8P+IGUnqnLHjAEKTJUdGF6wjW0ti4NKVkuWm2MzWcIxtRlsrps
 7rlNqFFBGDJxeBFwbcLfnT5c=
X-Envelope-To: stable@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 1ef1cef91026e4e4;
	Fri, 16 Oct 2026 07:16:05 +0000
X-Mizu-Trace-ID: 1ef1cef91026e4e4
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.12\))
Subject: Re: [PATCH 00/10] mm: various (urgent?) fixes
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20261015-urgent_fixes-v1-0-42796911043b@kernel.org>
Date: Fri, 16 Oct 2026 15:15:44 +0800
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
 stable@vger.kernel.org,
 Chris Mason <mason@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A061083A-3A02-4ADB-9CFB-7CF6C731A872@linux.dev>
References: <20261015-urgent_fixes-v1-0-42796911043b@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: Apple Mail (2.3901.100.1.1.12)



> On Oct 16, 2026, at 00:07, David Hildenbrand (Arm) <david@kernel.org> =
wrote:
>=20
> Hi,
>=20
> here are various MM fixes. The majority was reported by Josef at
> Anthrophic, the remainder was found while reviewing/overhauling them.
>=20
> Two issues/fixes reported are not included, as we are discussing
> (better) alternatives on the list already.
>=20
> I left most of the original commit messages as schloppy as they are: I
> don't particularly care as long as the code is in good shape and as =
long as
> they are not actively wrong. But I (and Mike) could not be stopped =
from
> overhauling at least some of them.
>=20
> While I don't think there is anything too critical in here, I think =
this
> is a good opportunity to see how fast we can get =
pre-screened/pre-reviewed
> fixes upstream that might be security-related.
>=20
> The majority are hugetlb + uffd issues, that are not actually that
> relevant for most installations. But all things that should just get
> fixed. Some uffd fixes need proper follow ups to fix some more of the
> root causes of leftover UFFD PTE bits (or proof that there are none
> remaining).
>=20
> I ran some MM selftests and nothing popped up.
>=20
> So let's try to get these upstream in a timely fashion.
>=20
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
> David Hildenbrand (Arm) (4):
>      mm/hugetlb: fix use-after-free in hugetlb_mfill_atomic_pte()
>      mm/hugetlb: tolerate uffd bits set without uffd for PROT_NONE =
PTEs
>      mm/hugetlb: tolerate UFFD_WP markers outside uffd-wp VMAs
>      mm/mremap: fix calling fixup_hugetlb_reservations() on the wrong =
VMA
>=20
> Josef Bacik (6):
>      mm/vma: don't leak the commit charge on mmap failure
>      mm/hugetlb: fix use-after-free of a new anon folio
>      mm/hugetlb: unmap the page where the other VMA maps it
>      mm/hugetlb: don't clear the resv_map of a VMA whose lock is held
>      mm/hugetlb: fix endless write fault on a leftover uffd bit
>      mm/hugetlb: don't leave a uffd-wp marker when zapping an RWP =
entry

HugeTLB is really nasty, while no new features are landing, we have a =
steady
stream of bug fixes coming in.

Thanks,
Muchun

>=20
> mm/hugetlb.c | 70 =
++++++++++++++++++++++++++++++++++++++++++++++--------------
> mm/mremap.c  |  2 +-
> mm/vma.c     | 11 ++++++----
> 3 files changed, 62 insertions(+), 21 deletions(-)
>=20
> ---
>=20
> base-commit: 0fcb05b72344f40806cbe810de8872f1698bf053
>=20
> change-id: 20261015-urgent_fixes-7112629346eb
>=20
> --
>=20
> Cheers,
>=20
> David
>=20

