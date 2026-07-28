Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1FA42BE8A;
	Tue, 28 Jul 2026 12:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785240372; cv=none; b=YGOF1fxuXg3Vn5UwPBTAYk3hfXS3E5T0ea8sk1THa6evyuxoz4dH6KZMDNdiXvm+9CHM1iYQHds2wFPDr27tgEIHiy6BQf4MDf1lHAaRmCvOlcRUnsSBSuFHzthzGde9HLxekTz3RjpekvZRVTkAR/X2E7aY3Z/geGn8q/4Eiww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785240372; c=relaxed/simple;
	bh=1iRX8kwEWPFZ/gPBRMQWQ6bqUokZs9NDs71srGyCKHM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VZh+W3tUZ/n+8FK2tqRMxj1h8AERxuEjaO8A+bcBg15GsOtyHkFWhe8QXCgmo1Y/A6bSzoeYh+/6e56D+6DrjME7cXoafRPz2glhTLZvsLHEL0WwKzzB16UjbJHCdU2VkfwOMpp9Krw6ou3hJSEXtqXTVf4oATjDtrzemxnzU64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oq88gclT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oq88gclT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7DE91F000E9;
	Tue, 28 Jul 2026 12:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785240371;
	bh=utjVBhbZuqYLFro69FeNoLP7coVedkrv95kY4LIv95s=;
	h=From:Subject:Date:To:Cc;
	b=Oq88gclT4KvJyLnpoLcLM/OQkXLQRJTwu08ZSLC1AERu8MUMHfYCOwEy0yhXqTwGr
	 3hhunOZcngO3vhYrNPohYMXXH2TLCDMQ5JGf+jEX3rsQH+yl/MAkKg91ZTIZSreEvQ
	 DcXOQi964ll7aS8TlZDOtjWCtjpPPV6Oksjnzyx+a/jFHqSPkg7QU4gslj+XVGn+4j
	 pnX3IS+r2cxUwKbgC9lfq/jibv3kI81cTH16KJgHp/tp8GJAkCBdr1xhpgXApDPms5
	 U/CK1Bo7mouAzyrvi14Un5LQ0147KATZc82A99nUYKMSgEgeA1mnBv5vbAW8R7kBSq
	 VeG7Oi8U0CXEg==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Subject: [PATCH mm-hotfixes 0/2] mm/huge_memory: fix huge_zero_pfn race
Date: Tue, 28 Jul 2026 13:05:43 +0100
Message-Id: <20260728-fix-refcounted-huge-zero-v1-0-3f261f5447b4@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABebaGoC/yWMywqDMBBFf0Vm3YGYllr6K9KFiRMzgonkUaTiv
 3dal4d77tkhU2LK8Gx2SPTmzDEItJcGrB/CRMijMGil76rTD3S8YSJnYw2FRvRVlA+liLq1RnX
 m5oYrgdxXsXj7p3tYFvSxnPw6x1zNTLb84nAcX22LjvuJAAAA
X-Change-ID: 20260728-fix-refcounted-huge-zero-21cb07b4fa3e
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <npache@redhat.com>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, Pankaj Raghav <p.raghav@samsung.com>, 
 Hannes Reinecke <hare@suse.de>, Hugh Dickins <hughd@google.com>, 
 Yang Shi <shy828301@gmail.com>, Kiryl Shutsemau <kas@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Hengbin Zhang <uqbarz@gmail.com>, "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1751; i=ljs@kernel.org;
 h=from:subject:message-id; bh=1iRX8kwEWPFZ/gPBRMQWQ6bqUokZs9NDs71srGyCKHM=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLIyZiv5P81KUQzfX27YtHf1/kXnIp7xOkfoOL5L/9Wyz
 4Hn91bnjlIWBjEuBlkxRZbnX8T3B4mEzeu84O8GM4eVCWQIAxenAEzkvDUjQ0vRRakf3DnuqvVW
 K3j0zr59z7+iyskxpIDD/kVL9empbxkZji1Z6rcjmc38r8dTD6F2zwU1y5n5TjTJ/blWY6D8uDa
 IFwA=
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

There is a subtle race in the reference-counted huge_zero_folio
implementation.

The fast path atomic logic fails to account for the fact that the
shrinker (which drops the final huge_zero_refcount pin) can overwrite
huge_zero_pfn with the ~0UL sentinel value in shrink_huge_zero_folio_scan()
after a racing get_huge_zero_folio() installed a valid value there.

This results in huge_zero_folio being correctly set but huge_zero_pfn being
set incorrectly and thus is_huge_zero_pfn() and consequently
is_huge_zero_pmd() will misidentify the huge zero folio as being an
ordinary THP folio.

This can result in the huge zero folio being split and otherwise treated
incorrectly.

The solution to this is very subtle as there is an atomic fast path, and
thus ordering in weakly ordered architectures has to be treated very
carefully.

As a result, this series first reworks the
CONFIG_PERSISTENT_HUGE_ZERO_FOLIO logic so it is separated from the
refcounted code in order to make the subsequent fix reasonably
understandable.

The second commit fixes the issue by introducing a spinlock around
huge_zero_[pfn, folio, refcount] write, with careful consideration paid to
load/store ordering in the fast path.

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
Lorenzo Stoakes (ARM) (2):
      mm/huge_memory: separate out CONFIG_PERSISTENT_HUGE_ZERO_FOLIO logic
      mm/huge_memory: fix huge_zero_pfn race

 mm/huge_memory.c | 189 ++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 116 insertions(+), 73 deletions(-)
---
base-commit: 5db85e34ec49beee590676d55f13e8e2b14c742f
change-id: 20260728-fix-refcounted-huge-zero-21cb07b4fa3e

Cheers,
-- 
Lorenzo Stoakes (ARM) <ljs@kernel.org>

