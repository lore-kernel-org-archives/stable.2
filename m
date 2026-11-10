Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272895;
	b=101EnuPDTF0H9VeqOExLoSwAlpXvq0TFKZ8nZEhS505bGec5ZkOhQITM3jGIRhE+mJih
	 lSlaK5LnaROt2KTpu2TErLbJr5ZVGvJnjbX/lW0n6TRiOCR6cGKq8Rkp1Q5YNbGPsIV8H
	 PxNPW3zm2yGYUvmbRmQhYqFPnhDOJg7hsSDgTCrLoy/rRYGyVYXDYHmD++y96XUVjeAzb
	 0dmIe6XCjtAeeLvA7B0Mx4XEB4iW53p5+TiHIHXsSTjf5+GZpo/ex20urhlpZT/75z4FP
	 HHETa+EY4kFOOw8ZMagRjw7TM68LTmcQ5MQOxdwexvh49hJJEsnuyHDxOHT2XOgGFWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272895;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=lxZFuWUPkWD3WsneBpQfeJvKhrwBqlKxc0YReNHyL9s=;
	b=I/eoxE4UcoVQ9UBk2wqSnMH+ilvguR4y2sOsHNPoP9Y3ON3Ko1juTBWSQbD3871fjY0w
	 zyWEpbuYiMjQOQAcrcTDzWCejQNGQWfot+VedjBwwJibcqGuaDhsNF8fA6wIK4lc+yrN6
	 5kWqraxzazZa39Xy2w9tlpLx9q791rYIcDnrqDvXU67wBv5meR5WJQGHC1UXRMbsP1Hql
	 JDSJGmcblCT+pfq4q99j9eS0eBHW4mHBEOvoj9S4EzhtlNWIIoo1GNjK3izGKOw2JfXwR
	 bwiRVbVch87F6ZujRn7i+5jfdjYPa6IsCQxI10X3JkyRFmC0hjuB3X9rMqO7L0DYR7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hwI8Ha5M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F524606A32A
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hwI8Ha5M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53D971F0089F;
	Tue, 10 Nov 2026 01:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272894;
	bh=lxZFuWUPkWD3WsneBpQfeJvKhrwBqlKxc0YReNHyL9s=;
	h=From:To:Cc:Subject:Date;
	b=hwI8Ha5MMIjR27e1qxc4iYd7jU3QLtaelImxGSe7t0ngicQxaPzOKmlowbsUsA+lF
	 JBZjEeFbin9XwKZ7zDJc+7rRNSU4M2Qz9311zNRw48Onz0iLKu4V0Ozi8bOs++yMj+
	 X/sjxqdWx8aNvtOMlVy5mDOe1z+Q3iCtq4SfO4hujpCcqLM5hmrpYeeEEiuobop+Z7
	 BRNrU+HbpGMOakQJ4oUAJ48XmI5Kam2aETKY0j+kM5cAqoaId7+CiBWvOBZdGwD0Yg
	 Xuj+1v5WMljF0vYulbx4lsbv6xzugI1zC0sQFDfJMLbEM56pDVTDvoGi2Im7p8767V
	 gAjWWRPaHexhw==
From: Sasha Levin <sashal@kernel.org>
To: rppt@kernel.org,
	akpm@linux-foundation.org,
	kas@kernel.org,
	pankaj.gupta@amd.com,
	david@kernel.org,
	liam@infradead.org,
	ljs@kernel.org,
	mhocko@suse.com,
	surenb@google.com,
	vbabka@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/cma: accept memory of CMA areas reserved at a fixed address" failed to apply to 6.12-stable tree
Date: Mon,  9 Nov 2026 20:08:12 -0500
Message-ID: <20261109200812-failed-6.12-f8f9cbc34a30@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x f8f9cbc34a309a388c052706f3329d1b52985aa3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200812-failed-6.12-f8f9cbc34a30@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From f8f9cbc34a309a388c052706f3329d1b52985aa3 Mon Sep 17 00:00:00 2001
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 29 Oct 2026 12:18:38 +0200
Subject: [PATCH] mm/cma: accept memory of CMA areas reserved at a fixed
 address

CMA areas allocated from memblock have their memory accepted by
memblock_alloc_range_nid(), but areas reserved at a fixed address with
memblock_reserve() are not.

If a fixed CMA area is requested by the cma=<size>@<base> command line
parameter, it may be in regular RAM and on TDX and SEV-SNP guests it
must be accepted.

Accept the memory of fixed CMA areas as well, so that all CMA areas are
accepted regardless of how they were reserved.

Link: https://lore.kernel.org/20261029-cma-multi-v1-2-2cbced8b5cb7@kernel.org
Fixes: 75d090fd167a ("x86/tdx: Add unaccepted memory support")
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>
Tested-by: Pankaj Gupta <pankaj.gupta@amd.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: <stable@vger.kernel.org>
---
 mm/cma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/cma.c b/mm/cma.c
index 0035efb1130a5..f61d52796f4ef 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -381,6 +381,8 @@ static int __init cma_fixed_reserve(phys_addr_t base, phys_addr_t size)
 		return -EBUSY;
 	}
 
+	accept_memory(base, size);
+
 	return 0;
 }
 
-- 
2.53.0




