Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793739651;
	b=qwwQ9jw9m/B++lTyTL9Zg9heUb3TZNAWRTZSIy3BZGBEAzmsOk9io6ssnMX3C9m9mt0n
	 ud/4qMKsN1w1yxeBplpuRzD8WtdMbtFdVzPSGi7s796EycY2xNtbkrYM1DovipJY0RSr5
	 tf46jL8DBDb672Jm1LFyqJO7dYArx89q7ERq94BBgIndUYWX2HQ6haBdPSDREg4c5QhLH
	 RwEonBi5I/xGl2ATL98Yw0Mo6W19GHNr1x8u/cMKpBwZqE+MVOfsVbRM1Qu+M2oG/TW9O
	 AXWnJ/8Uzq4FePwOxSfSHkk1/N+Hzmi+M+U5BEUm5PVi2CXkJ8i/TgcPLgVw929Mgyg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793739651;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=9oswV/x8AC97gVAw4TBoRfYdc+Ee5b9SxqFobWwGr0c=;
	b=YYAIdtHX4riQ7EZqLkT7AhlpMKxQfzw8naaJcrOF3cXGYHsZtMACn6RNODTLL7CGnp2W
	 j2Bnr2OeP+yzhU94dYojM0SvvenGVvcHWExDmCGCugZAKIIpGjgJ0C22NxCw4qBUskXVN
	 41v/A+n97To0Xd1RKqDUGn+PM/hv/4lZN+o6MU7gYpn8H5SoQsUCaTyby8ZQjLLwdekZL
	 jRKJPdMuI9GeTlpMtB9L0aUHTmY4yB5TGch0pXBI6TZbAUoL42bfHvxyzncBKfl4OWg5C
	 ilsXOPu9RhJGoxz6T39Vd9TMsj8wanD1uP0rAz9Od5TVNfzTZkZ9eaBZvuMotIdGwaw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eVp1FVJ+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACA1606A328;
	Tue,  3 Nov 2026 21:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eVp1FVJ+
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793739650;
	b=l+GMeip7AzakIpGW9XRgXcJmFcwzdPNQHux2TlWf03ZfaKikTYJfptquNkYLfcmRDVM5
	 nQcQ1i+YOweDLGagMcWyj6DVy1zJ/AGzIEdX1/tL07hJ2IqS2p89JEbTq7rtMurhvFbx+
	 Gw3ctFovcD+TYGbnHo7Nl4wGtRkgeqNByPUQ1v3aQB3sKCFPlOCwmfhP6s94nQS56ymFP
	 wLIVj+5JJ9txX6S7QEczty5Cm4FSRQy4vfeDabLSjHQp9F7tSc2oAvmSDsxtkDS5ttrn5
	 VDNXTJk3Y+Kcj6lKXGsRacTwTQMZT7wbLS+mMnPjDHU1Id5L4t8SZZW/qiEG+iWtdQA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793739650;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=9oswV/x8AC97gVAw4TBoRfYdc+Ee5b9SxqFobWwGr0c=;
	b=oxR9pCeuW/GqFz1nprBHU6hF0AVP7qqUV5ciiSjbN7Ee7ErXm4we3QT9wZv2qauKE9lg
	 J9qFZ1XATWTecy/l0V8Mh5xM/9DQDAoIS9u7tvb/z00ulzu9yfxBAlbvWj29Xb8jlBcZC
	 MMwajCcaQ9tDA/2gM5EVeoD94RRSUlXrR4QQlqqxsbOXDvjtVxh5tY3yzxwR28D9DwI37
	 TDFsXdZHTQSNFqweGH/1RfmRxFFReN/LzVLY15c0vwyISIPHYSbhnJuZUSOk3FjW9suIu
	 1V0e/DyBQ28ifo5+MFoxhKw8utEK0p0rhIsHRikwmxHSeMbjH4Wwp2irt+dhEVyN0Hw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id EEC311F00919;
	Tue,  3 Nov 2026 21:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793739650;
	bh=9oswV/x8AC97gVAw4TBoRfYdc+Ee5b9SxqFobWwGr0c=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=eVp1FVJ+Q+U60/uo1p9l0XhIVu5tglyLz1hnR9ZRI0mlrnLn97HsE4Ryqlh0XtxOy
	 pVNEog5k0+bMURcQJpk7zU5NWfTqre35n9jFfPuqtOo8NavQOs/cLAweXHnId5U82v
	 NMI7lqB7mjS6Let/hQOqdO7VXyhewE/PllCjZ1sdTDCp4IJw/J7/9gpzQAddnRbejS
	 9iY70cKRV06to/ygawjDgRJiL22aKTDjcP6lr6+CsRk1i2vly2E991Ub573xcEIF0+
	 kV5O1DEr8wZm2ARGxo+dFPl+RF49xtOYTok4D8Iu4zP/pJ4KDaZuNtP/1rMJloF/sn
	 IG15SFCge70wA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4AD1546B1D;
	Tue,  3 Nov 2026 21:00:49 +0000 (UTC)
From: Mani Tofigh via B4 Relay <devnull+mt4022.columbia.edu@kernel.org>
Subject: [PATCH v2 0/2] mm/hugetlb: clear the hugetlb flag before leaking a
 hwpoisoned folio
Date: Tue, 03 Nov 2026 16:00:48 -0500
Message-Id: <20261103-hugetlb-hwpoison-leak-v2-0-98085750c145@columbia.edu>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNSw6CMBRFt0I69pl++MUR+zAMaHnSp0hJS1FD2
 LuAC3B4knPPXVhATxjYJVmYx5kCuWEDeUqYsc3QIVC7MZNc5oLLEmzscOo12NfoKLgBemweoMt
 WpanKRSoU27ajxxu9j+61/nGI+o5m2mO7YSlMzn+O41ns3r+PWYCAojCY5ZzLTKrKuD4+NTVnb
 COr13X9AjoMILHPAAAA
X-Change-ID: 20261028-hugetlb-hwpoison-leak-b8d344361413
To: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
 David Hildenbrand <david@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: Naoya Horiguchi <nao.horiguchi@gmail.com>, 
 Matthew Wilcox <willy@infradead.org>, Jane Chu <jane.chu@oracle.com>, 
 Zi Yan <ziy@nvidia.com>, Kaitao Cheng <kaitao.cheng@linux.dev>, 
 Mike Rapoport <rppt@kernel.org>, Mike Kravetz <mike.kravetz@oracle.com>, 
 Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, tz2294@columbia.edu, stable@vger.kernel.org, 
 Mani Tofigh <mt4022@columbia.edu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793739649; l=1890;
 i=mt4022@columbia.edu; s=20261026; h=from:subject:message-id;
 bh=Pt9krYX8CsGOTLKtcfpUYXNuinBo/7tPW4KlvXKyiEA=;
 b=02MqQBVkEqAHUZSGVcKHoKLwHhvp4MXoLv73o/U6clby1qlWMLDJX7szSHzPoTqqIJrGoAfBq
 CFQP0xoTxDpAE+YMJFHC0wllKhbMVCv/tSdEtxCu8bk2Xkz7dRP9VIg
X-Developer-Key: i=mt4022@columbia.edu; a=ed25519;
 pk=gljCMQDuxyKPmd5y37CRpEJGSPXDV1MyAnHBhCgXl0I=
X-Endpoint-Received: by B4 Relay for mt4022@columbia.edu/20261026 with
 auth_id=1322
X-Original-From: Mani Tofigh <mt4022@columbia.edu>
Reply-To: mt4022@columbia.edu

If memory_failure() can't save the raw error page of a hugetlb folio,
the folio is marked raw_hwp_unreliable and leaked once it's freed.  With
hugetlb_free_vmemmap=on it's leaked while it's still a hugetlb folio,
and dissolving it then loops forever, e.g., when offlining its memory
block.  Patch 2 leaks it only after the hugetlb flag is cleared, as
without vmemmap optimization.

Miaohe pointed out that unpoison_memory() then doesn't see a hugetlb
folio anymore and unpoisons it.  That already happens without vmemmap
optimization, so patch 1 fixes it on its own and goes first.

Patch 2 lets a raw_hwp_unreliable folio reach the add_hugetlb_folio()
rollback when restoring its vmemmap fails, as
dissolve_free_hugetlb_folio() already does.  It relies on Kaitao's
"mm/hugetlb: preserve persistent flags when returning folios to the
pool" [1] (in mm-new) to keep the flag there.

Reproducer: https://github.com/manitofigh/files/blob/main/linux-repros/hugeoffline.c

[1] https://lore.kernel.org/all/20261102024910.31486-3-kaitao.cheng@linux.dev/

Changes in v2:
- New patch 1 so unpoison_memory() refuses the leaked folio (Miaohe).
- Patch 2: same code, added Fixes: bd225530a4c7 and fixed the commit
  message (offlining still retries until a signal).
- Rebased on mm-new.
- Link to v1: https://lore.kernel.org/all/20261028-hugetlb-hwpoison-leak-v1-1-77ce56002523@columbia.edu/

---
Mani Tofigh (2):
      mm/memory-failure: don't unpoison a leaked raw_hwp_unreliable folio
      mm/hugetlb: clear the hugetlb flag before leaking a hwpoisoned folio

 mm/hugetlb.c        | 15 ++++++++-------
 mm/memory-failure.c |  9 +++++++++
 2 files changed, 17 insertions(+), 7 deletions(-)
---
base-commit: 74d73ffcffe03804f97e9fb82301dadf75671282
change-id: 20261028-hugetlb-hwpoison-leak-b8d344361413

Best regards,
--  
Mani Tofigh <mt4022@columbia.edu>


