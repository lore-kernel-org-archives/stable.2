Received: from mta0.migadu.com (out-147.mta0.migadu.com [91.218.175.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFCE366060
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 04:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789533714; cv=none; b=XsLshSals9dK8ejsK49ncpp4YAFDVdK3xNP2gz+ZEnzMNhz2W9ZX3+RhUicKwHvpO5zVUO/BNWgpaR1LI6Nuq3JE1HtTsFw3jDN0d+eNq3fS22qdkQEDMRacmEo5RnZaeSCTVJE59fVc12lvyMTf9TWkqNU/WmyjRVvWqsV5GAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789533714; c=relaxed/simple;
	bh=csk+huPoq9Uf1TQgms2r3QUbeMYTjSPHnReXbJBHu7k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bru1jseP7xUfliIYH0n4KejmWnSLniYBFgGlwM1mc2IR66Jy+Ytda77lW7hYpxYlQrOAVWS5Sc0krKHYLM4PUyGY/6inSOKBWQ3MxTh5RPEJr2j3hOPfLu/f3kAyO02fdTSpZEHiNxlu/SNKeLtdg1KA+Mc01I/9VHN3cHyDF50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QJsjxt7s; arc=none smtp.client-ip=91.218.175.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QJsjxt7s"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=csk+huPoq9Uf1TQgms2r3QUbeMYTjSPHnReXbJBHu7k=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789533708; v=1; x=1790138508;
 b=QJsjxt7sU3hOfSmnjWJGqNuEulsyNrMdbVuv+vVBSm9+kL/EK6w10jPYcgmml536mjnJOmVd
 bVLOkYRtepYdTrWCMGzkxkoGbOeUyPk45UXC5U4Yf9JBEdba3GBoY/xlf3un0HkQlI3J8Z9IkWg
 QXYB9yEG3ABgwDOQQWpc0FpE=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 52e16c50c9bcfb05;
	Wed, 16 Sep 2026 04:41:48 +0000
X-Mizu-Trace-ID: 52e16c50c9bcfb05
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: david@kernel.org
Cc: lance.yang@linux.dev,
	akpm@linux-foundation.org,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	liam@infradead.org,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	usama.arif@linux.dev,
	kas@kernel.org,
	ljs@kernel.org,
	surenb@google.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/1] mm/huge_memory: fix pgtable withdrawal for huge zero PMDs
Date: Wed, 16 Sep 2026 12:41:42 +0800
Message-Id: <20260916044142.95044-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <83a1287b-8589-4408-96f4-4f78dfca1bc9@kernel.org>
References: <83a1287b-8589-4408-96f4-4f78dfca1bc9@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Tue, Sep 15, 2026 at 05:13:17PM +0200, David Hildenbrand (Arm) wrote:
[...]
>
>Ok, it's really only DAX and anonymous VMAs that use the huge zero folio. Other
>(module) code would have a hard time using it, as mm_get_huge_zero_folio() is
>not exported to modules.
>
>DAX uses dax_pmd_load_hole()->vmf_insert_folio_pmd()->insert_pmd() where we
>deposit a page table only if arch_needs_pgtable_deposit().
>
>
>So I think the rule is simply:
>
>arch_needs_pgtable_deposit() -> always deposited
>vma_is_anonymous() -> always deposited
>
>?

YES!

>
>The trick is that we don't have anon THPs in non-anon VMAs.
>
>So could this be simplified further or am I missing something?

Ah, cool! I hadn't thought of that :) You're right, anon THPs cannot live
in non-anon VMAs, so pmdval and folio aren't needed here. Will simplify
it as suggested :) and add a comment explaining the rule.

static bool has_deposited_pgtable(struct vm_area_struct *vma)
{
	return arch_needs_pgtable_deposit() || vma_is_anonymous(vma);
}

Cheers, Lance
