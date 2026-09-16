Received: from mta0.migadu.com (out-102.mta0.migadu.com [91.218.175.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F837469830
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 08:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789547461; cv=none; b=f3nFPqNi0E+cWZpVRP3mtXE2Csd34pQJ4hLtF1yhLuc+m6rpE2qTOfUNNQyjLYZN8Mbfqntnfrh9CfMnjZaItzsYciS5r7a/r0hfB+XE+fg0wBA7gftgBLRWmr4ZbXrdw6GommhJ6MwOqGnz8jV6EKovV/ypXCbDze+d0HicsIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789547461; c=relaxed/simple;
	bh=HVeQNU0VnGAT6KeaYPHUaFiS0r13E4evtRSG/JUmvsE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GLPSkqoCN1k9iJNNrkpGi/YFtYPT4wxXxkJLoiAWsJvHbXSSeLF4tYXZ8iDVlOfdCTfZNjVh+dHNxu3v3oUM3gt+095ChmL5r8H4T/L8Nw6YSCCkNfLeANUluacYj9UbOS9cEQNdNz2mztV0mbLUATLFqbvS50HKi+CeTh+6uyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dsZmTsf/; arc=none smtp.client-ip=91.218.175.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dsZmTsf/"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=HVeQNU0VnGAT6KeaYPHUaFiS0r13E4evtRSG/JUmvsE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789547456; v=1; x=1790152256;
 b=dsZmTsf/C0DUaNE2kutjSWXtlWN2XDHzPCJKQgZ1EigqK16RGj/2H6Mn/rNNWVENm5VKOlI5
 7UF1OC1tY66Z61b9pD84eVinn2V7EBNg1kPU3i/tF6+KUTG4vebn/C5omAgWgD9MpZtdJnKPJu5
 fQEQyaRXbOwa2YzPMxvR/uBE=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c02ff89e00ec8e44;
	Wed, 16 Sep 2026 08:30:56 +0000
X-Mizu-Trace-ID: c02ff89e00ec8e44
X-Migadu-Flow: FLOW_OUT
From: Hongfu Li <hongfu.li@linux.dev>
Subject: [PATCH 0/2] mm/hugetlb_cgroup: move the per-node usage along with
 the folio
Date: Wed, 16 Sep 2026 16:30:26 +0800
Message-Id: <20260916-for-hugetlb-charge-v1-0-70fb708b2e4a@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMwQqDMBAFf0X23IAGLbW/Ij3E5EW3iMpGRRD/3
 a09DszMQQnCSPTODhJsnHgaFYpHRr53YwfDQZlsbp95XVQmTmL6tcMytEYNUcP66IJ7IZQlSMN
 ZEHm/p83nz2ltv/DL70TneQEmAiU1dgAAAA==
X-Change-ID: 20260915-for-hugetlb-charge-2cfada8ed44e
To: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
 David Hildenbrand <david@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>, 
 Colin Ian King <colin.i.king@gmail.com>, 
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Mina Almasry <almasrymina@google.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Hongfu Li <lihongfu@kylinos.cn>, 
 hongfu.li@linux.dev, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789547446; l=1403;
 i=lihongfu@kylinos.cn; s=20260915; h=from:subject:message-id;
 bh=HVeQNU0VnGAT6KeaYPHUaFiS0r13E4evtRSG/JUmvsE=;
 b=rbcRgrAuiTtJsuFFmAg9A4uFfsk82YktFg6/zlGlYIDN6/g4W8mAy0IL0sbKqJBzZhScqrJVm
 CXXJU0TvDpQCfI0GSRejxoItaHDibMUQkdmhhEQ4Im+XTzNM+6LaFdt
X-Developer-Key: i=lihongfu@kylinos.cn; a=ed25519;
 pk=rUpDSpB3neoNZRlGG6dHlFb3RepiJakcev+ucyqaZzw=

The per-node usage reported by hugetlb.<size>.numa_stat is accounted
against folio_nid() in __hugetlb_cgroup_commit_charge() and
__hugetlb_cgroup_uncharge_folio(), so it is only correct while a folio
stays charged on the same node and in the same hugetlb_cgroup.

Two paths move a folio which stays charged, and neither moves the usage
with it. hugetlb_cgroup_migrate() only moves the hugetlb_cgroup pointers
of a folio migrated to another node, and hugetlb_cgroup_move_parent()
only moves the page_counter charges and the hugetlb_cgroup pointer of
the folios of a dying cgroup. In both cases the node (or cgroup) which
was charged keeps a usage which never goes away, while the node
(or cgroup) which ends up uncharging the folio underflows as soon as
the folio is freed.

Patch 1/2 moves the usage along with the folio on cross node migration,
patch 2/2 does the same for the folios a dying cgroup reparents.

Signed-off-by: Hongfu Li <lihongfu@kylinos.cn>
---
Hongfu Li (2):
      mm/hugetlb_cgroup: move per-node usage on cross node migration
      mm/hugetlb_cgroup: move per-node usage on cgroup reparenting

 mm/hugetlb_cgroup.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)
---
base-commit: baa8de2f3448d1466a888a805c18d01c998fe052
change-id: 20260915-for-hugetlb-charge-2cfada8ed44e

Best regards,
--  
Hongfu Li <lihongfu@kylinos.cn>

