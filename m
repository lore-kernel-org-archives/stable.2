Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A857A53ED04;
	Thu, 15 Oct 2026 16:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792080459; cv=none; b=UP8VhURG3VbHBXk3sKkx5fA0ZzfhcBN18K4sUl8LiKUSuihhUEwoVGwh+PZ1cf7Wt/034apZnVtZUxJ5WSw+xHqEUAKhVLmMiOmFSkc7owaIUWd2aah2C7QvSvrOSaQ73jMo3sOysXPKVZHUP2B9FShGliAPdaAJb4Wg6+XhZpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792080459; c=relaxed/simple;
	bh=bhdP739rykh9+cxbAvZcyJkbfwJi6RgLgraAvwylzjI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZmAxtQ/fsDXv8gmrPwa33E9oqz09bO/ASlWyqD32yG10/lwuP2243h/JP0l0/Di3pmyCClKe4zUIpWTm8eC69EVtmQBso6R4iJA75S/3iP8aZE8fdF87w/0L7WZssZgvXEQslDKTsAtR099+xbm7lOpMiYLMpkr+uhoLjb73cko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9KrD+0Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9KrD+0Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A82751F000C4;
	Thu, 15 Oct 2026 16:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792080443;
	bh=CWGMfzP4w3Zs0Y7JyHkmxA4Ab0jJqfsVdlDpuxARv00=;
	h=From:Subject:Date:To:Cc;
	b=Q9KrD+0QatR2fO6wXqm1uuSgDXYAHIcUEZ1gLROc6UsF07iyL4xlAvO8d7IKEBeqo
	 L0U8huXAcNPaswmMqa/GsAqk/R0RP85ebMSNdU53+QgGfw6qR5cfS+5z5hCW5EBIoI
	 je8vP4WhScOHpnCpssgJLAST+x1VvNuRoc9l4Hr8dD2o+DfAZXOAhhovfRypbfCixh
	 oTTwiLcBxLNcyelXdvHdbeYwv1Mb+ryUXOm0qjmUB0oUucxCjQj3eSETvLEysMy/xx
	 L4pJHMi5C/w+B47GFhmhaZQev3xvsg6Ev8ta8OoH3f7UIdAQkSI6wcQosYKiyCr2lR
	 2xpaPIp8tIs0A==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Subject: [PATCH 00/10] mm: various (urgent?) fixes
Date: Thu, 15 Oct 2026 18:07:06 +0200
Message-Id: <20261015-urgent_fixes-v1-0-42796911043b@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACr60GoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDA0NT3dKi9NS8kvi0zIrUYl1zQ0MjMyNLYxOz1CQloJaColSwBFBHdCy
 EX1yalJWaXAIyQ6m2FgC8oPgdcAAAAA==
X-Change-ID: 20261015-urgent_fixes-7112629346eb
To: Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Muchun Song <muchun.song@linux.dev>, 
 Oscar Salvador <osalvador@suse.de>, Miaohe Lin <linmiaohe@huawei.com>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>, Adam Litke <agl@us.ibm.com>, 
 Mel Gorman <mel@csn.ul.ie>, Rik van Riel <riel@surriel.com>, 
 Peter Xu <peterx@redhat.com>, "Kiryl Shutsemau (Meta)" <kas@kernel.org>, 
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Josef Bacik <josef@toxicpanda.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 "David Hildenbrand (Arm)" <david@kernel.org>, stable@vger.kernel.org, 
 Chris Mason <mason@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2238; i=david@kernel.org;
 h=from:subject:message-id; bh=bhdP739rykh9+cxbAvZcyJkbfwJi6RgLgraAvwylzjI=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIu/DKUPn5d4HXm1P47+z4f2JMwW3+pwclIvoeCrPYHd
 aqnsc3731HKwiDGwSArpsgSFHzf4OXLdbXVbnzMMHNYmUCGMHBxCsBEkjwY/qlb6KbN95oowTDp
 k3uS6kVTO4H13evfCZiZ33u6yilI4ggjw2NDyYNK4kfD7jnXxL79onjyrfschgRBO/ZI6bsrp6W
 tYQUA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

Hi,

here are various MM fixes. The majority was reported by Josef at
Anthrophic, the remainder was found while reviewing/overhauling them.

Two issues/fixes reported are not included, as we are discussing
(better) alternatives on the list already.

I left most of the original commit messages as schloppy as they are: I
don't particularly care as long as the code is in good shape and as long as
they are not actively wrong. But I (and Mike) could not be stopped from
overhauling at least some of them.

While I don't think there is anything too critical in here, I think this
is a good opportunity to see how fast we can get pre-screened/pre-reviewed
fixes upstream that might be security-related.

The majority are hugetlb + uffd issues, that are not actually that
relevant for most installations. But all things that should just get
fixed. Some uffd fixes need proper follow ups to fix some more of the
root causes of leftover UFFD PTE bits (or proof that there are none
remaining).

I ran some MM selftests and nothing popped up.

So let's try to get these upstream in a timely fashion.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
David Hildenbrand (Arm) (4):
      mm/hugetlb: fix use-after-free in hugetlb_mfill_atomic_pte()
      mm/hugetlb: tolerate uffd bits set without uffd for PROT_NONE PTEs
      mm/hugetlb: tolerate UFFD_WP markers outside uffd-wp VMAs
      mm/mremap: fix calling fixup_hugetlb_reservations() on the wrong VMA

Josef Bacik (6):
      mm/vma: don't leak the commit charge on mmap failure
      mm/hugetlb: fix use-after-free of a new anon folio
      mm/hugetlb: unmap the page where the other VMA maps it
      mm/hugetlb: don't clear the resv_map of a VMA whose lock is held
      mm/hugetlb: fix endless write fault on a leftover uffd bit
      mm/hugetlb: don't leave a uffd-wp marker when zapping an RWP entry

 mm/hugetlb.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++--------------
 mm/mremap.c  |  2 +-
 mm/vma.c     | 11 ++++++----
 3 files changed, 62 insertions(+), 21 deletions(-)

---

base-commit: 0fcb05b72344f40806cbe810de8872f1698bf053

change-id: 20261015-urgent_fixes-7112629346eb

--

Cheers,

David

