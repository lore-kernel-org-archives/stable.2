Received: from mta0.migadu.com (out-92.mta0.migadu.com [91.218.175.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3F61C2AA
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 02:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789700193; cv=none; b=hVs9xN9jWmjTMRyBYPjmPgr9zvFfOLkYQvEd996q+KqVVCqKe6fiVBaBeA1F/7T47msfCrcF8QyOnbRlsoKf1PoI/2mPf+ZHfzQcoMEItVZAq3vOKEuLLRutL/BSgXaZtTrhNH8KXA1n9oWHJhDEQNxGa7fzXXpZZ/cggxpS1AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789700193; c=relaxed/simple;
	bh=6olkN3MFF993IEc0YK161XKRjhyK4yyClEXXjugfK5U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HG3nH49F7FJJ/8tSKqBU+3csthMLdhLznerbTpCbbwVqHozK+uWVTkLNCIxhIr0RUsFXu74zl3ii+z3jgWZaVfUo9ShEcPP/OpnaOd3+GOp1CT5EthPlByeaBN/3K3L0wKmsvjlvokGWXOay6/ujvKO3yGDzbd/PVQ7lR9qdOuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ghvlcicp; arc=none smtp.client-ip=91.218.175.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ghvlcicp"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=6olkN3MFF993IEc0YK161XKRjhyK4yyClEXXjugfK5U=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789700186; v=1; x=1790304986;
 b=ghvlcicpnL0xK6UZMXLU+bpHh++qH/SG3QP7UX0sOAowfd/zilH1uNGyvCPi+rV8DZkKdkZA
 y5/wf+xDrwyf74CR0n3DqLWnjfqB69AmrJiykIryNfVuqB6d4xp/nu1V+JfGsnkvHvpG4FZnxZ6
 gCC6BcNy0/JgouMC3TP+uNsk=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 97b504da42608a61;
	Fri, 18 Sep 2026 02:56:26 +0000
X-Mizu-Trace-ID: 97b504da42608a61
X-Migadu-Flow: FLOW_OUT
From: Hongfu Li <hongfu.li@linux.dev>
Subject: [PATCH v2 0/2] mm/hugetlb_cgroup: move the per-node usage along
 with the folio
Date: Fri, 18 Sep 2026 10:56:09 +0800
Message-Id: <20260918-for-hugetlb-charge-v2-0-2b6d8c2bdc36@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NwQ6CMBAFf4Xs2ZrSIKAn/8NwaMsWVklL2kIkh
 H+3YLx5nGTemxUCesIAt2wFjzMFcjaBOGWge2k7ZNQmBsFFya/5hRnnWT91GAfFkuGTIbSRray
 xLQqENBw9Gnofp4/my2FST9Rxf9qNnkJ0fjmqc757v0D5LzDnjLOKG1XxWgks5P21DGRdOGsLz
 bZtH90sTlnHAAAA
X-Change-ID: 20260915-for-hugetlb-charge-2cfada8ed44e
To: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
 David Hildenbrand <david@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>, 
 Colin Ian King <colin.i.king@gmail.com>, 
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Mina Almasry <almasrymina@google.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, hongfu.li@linux.dev, 
 Hongfu Li <lihongfu@kylinos.cn>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789700179; l=1456;
 i=lihongfu@kylinos.cn; s=20260915; h=from:subject:message-id;
 bh=6olkN3MFF993IEc0YK161XKRjhyK4yyClEXXjugfK5U=;
 b=jQlOWteG7im1UP87y0ch6aWT5/7TKFYwrPyD+MFHD+aPffzfHC8yMSAYwnJ4hpniRNVsUb3yO
 VD73DczGDh5B0oo1EvbsKypHa8PkjLPR7iMjM7nmjT0GMBLjPHoUESB
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

---
v2:
- Drop the unnecessary READ_ONCE() in hugetlb_cgroup_move_usage().
- Add Acked-by tag.

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

