Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795703806;
	b=EO6o07kcH38SCFJ7dVqJFGMJUmC5nJ+q4HnYaqES4VR5CLkVE0wqJaExzHmLTGGWcBaa
	 ApT6V8HSCA2zb6l5wBYmmwZZNSexUHOQeDM/fLZjPo5OusETtWotTFnlmXRpovazhCCsw
	 uEKFf+b163hBALh42Zq+MeylsaiOyFRkOb+/r0KL4DJTkDYYVHUi4gjrT1eITW9PwCbiG
	 0KXKmDZbuEGkFFL6w8JWlhv6H0dZ+gh6HWp4Z/A3tCyDUBtSTX4a3AS6R0w3C+IqIcEK3
	 Fc4y9f/zTqjbjC+UbYpP7E9p9mQpUHCPoYMtjEN5LNPKGsU2rw2owI7tvLxN1Te5eTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795703806;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=HWwVbgC3hQBvoUc6sh5z0dK7VFVexFJ4/9/7NeiejMA=;
	b=408XNsPnoLcZDp6riXyvbGU6MVXmSRdQ6k67+TMjza58SB9k3NSOOrYFJyidkCHXfR7p
	 pGutM78VVjpuPfeOZelRl3oiAvf1OhD7Mfw66bUuIognYFVvq24rGWjnHL8bRGgORA+Hg
	 jmqTUjnM/W0IPlH1IqvOt64NCsAiQsQBHJLES8kLf2jdocdxcfIdlb0w2Ql0VTukV4qEq
	 nSM/I2SftypQYcjQhB9QUNc29YZYAXiIHU/16S/oDiUdJpIAgySN6ZCQn+UPcTilZRnuf
	 o/zdr7DvGCeAzj9TWuVu9GsK5XErqlmZdfwsCmLDXMvzo7Yj1vZtqjvLppK5oRE5/Kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h8MtRF+E;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED2A606A31E;
	Thu, 26 Nov 2026 14:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h8MtRF+E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E0A1F000EC;
	Thu, 26 Nov 2026 14:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795703806;
	bh=HWwVbgC3hQBvoUc6sh5z0dK7VFVexFJ4/9/7NeiejMA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=h8MtRF+ENe3L9xipiyIDqoLk6jjCxV8nEFreNxURzjgqrUWD5zfcIQ550dF2AYtSH
	 3dwu7wo6JTA9mtshkixNsJlOP2Xf/I45xDABOOE0dpWHTVZNS+qHl6cFdV7pBH90vc
	 spKnnUYA48f7bDEKeeJNVvPi5OznpVOBxV0MnHf/XJJ3AqSE63vzryVDod+M+9/ZpS
	 XtQZ/Nd5eNMfpNNYHRLIrxpPrJ3S/kkPjaeMN7xKH/7iVSPv5fbBM5Lw1MXhXkkuXt
	 cM5tZIuqD62paooZeR/Gjv66g+426H19diB29l9Zyd+KF68H1Bm7tsjMFd0LqVG/v1
	 +lOrWWUlVK3MA==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Thu, 26 Nov 2026 14:36:20 +0000
Subject: [PATCH v4 2/4] mm/memory: remove racy huge PMD assertion from
 walk_to_pmd()
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
Message-Id: <20261126-huge-pfnmap-fault-races-v4-2-feecd58bb14f@kernel.org>
References: <20261126-huge-pfnmap-fault-races-v4-0-feecd58bb14f@kernel.org>
In-Reply-To: <20261126-huge-pfnmap-fault-races-v4-0-feecd58bb14f@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Alex Williamson <alex@shazbot.org>, 
 Peter Xu <peterx@redhat.com>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
 Kiryl Shutsemau <kas@kernel.org>, Wei Liu <wei.liu@kernel.org>, 
 Roman Kisel <romank@linux.microsoft.com>, 
 Saurabh Sengar <ssengar@linux.microsoft.com>, 
 Naman Jain <namjain@linux.microsoft.com>, 
 Michael Kelley <mhklinux@outlook.com>
Cc: ljs@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Eliav Farber <farbere@amazon.com>, stable@vger.kernel.org, 
 "Jose A. Perez de Azpillaga" <azpijr@gmail.com>, 
 "Gregory Price (Meta)" <gourry@gourry.net>, 
 "T.J. Mercier" <tjmercier@google.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1972; i=ljs@kernel.org;
 h=from:subject:message-id; bh=6ZC7l8qNwM1jK/fnJXt1Ba5m5+Sqf+2Q7P2graooo0U=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLI5nF/c43j3JTg6lrWMv322o++yw04r63WnzzB/ekjwD
 8+9ud1eHaUsDGJcDLJiiizPv4jvDxIJm9d5wd8NZg4rE8gQBi5OAZhIdzwjw+anD7dxp835tVv2
 80sLHq+PM2rN87faPuP/+jr7b/TrC7qMDBu+dKj8n/GQeVaUEcvL1dqB7x55zXJvvGGee/gb35N
 UPjYA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

From: Eliav Farber <farbere@amazon.com>

walk_to_pmd() asserts that the PMD entry it returns is not huge, but does
so without holding the PMD lock, so the assertion is only valid if nothing
can concurrently install a huge PMD entry in the range.

This is not the case for a VMA whose driver implements both ->fault and
->huge_fault and which invokes vmf_insert_pfn() from the former.

The existence of prctl(PR_SET_THP_DISABLE) is problematic here, as it only
takes the mmap write lock and faults taken under the VMA lock are
unaffected by this.

This can result in two concurrent threads faulting the same thing
disagreeing as to whether to attempt a huge fault and thus ->fault and
->huge_fault running at the same time and triggering this assertion.

So just remove the assert.

Target the commit which introduced the first driver able to do this for the
fix - vfio-pci. DAX also mixes fault orders within a VMA, but serialises
them using its own mapping entry lock.

Link: https://lore.kernel.org/all/20261112051440.16140-2-farbere@amazon.com/
Fixes: f9e54c3a2f5b ("vfio/pci: implement huge_fault support")
Cc: stable@vger.kernel.org
Signed-off-by: Eliav Farber <farbere@amazon.com>
[ ljs: rewrote commit message ]
Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: T.J. Mercier <tjmercier@google.com>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/memory.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index 0e994f076bf7..c07e1de63043 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2401,7 +2401,6 @@ static int walk_to_pmd(struct mm_struct *mm, unsigned long addr, pmd_t **pmdp)
 	if (!pmd)
 		return -ENOMEM;
 
-	VM_BUG_ON(pmd_trans_huge(*pmd));
 	*pmdp = pmd;
 	return 0;
 }

-- 
2.56.1

