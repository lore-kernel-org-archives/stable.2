Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048450;
	b=CjtFt8PlPz3m8yaudu4jY0xgEYgdwhxLjXREViuDNy/SjLvP3G2zWNZykh53qylT39UY
	 gjYxyk4P/HsBlJYoQITbMf5v3JipWShZEbEldTJhUla5Xr/fBo1ei4WHfzWPToc9o+LfR
	 8ZnaVzU0p6Id37fPG0sj+i8QL7iswV6HZxZFgJ1Zx579s/4bLJKKPZWf380iEMcm1kAwE
	 zMnOlTVIwVtawJPPo71qSWi+vTfEjctzb1Ln2ipcNm1HAmXih116UNvU1BxAAZCU7sFsj
	 2IVFuPHBPxn3TjIVMHpE/QrrpZxw5C6m2FvvEGHa5bYMr8KT1PggVTkN4q9Kn2iVprA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048450;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ysoNjOwK7OSgj8dxO6Ma2/5ku2vm6SW2OVw+o/t/gvM=;
	b=S7PyeP/N5N96lHmXVPEvKxT0Md7XjbNF+Av/gSjPgxhR0yzD8uMZdkee9ikhe8b2sNc1
	 kmbWCZZhWJAOwVW9FVx7TqTDffHioAAO8+GhAEWkjA7Ne5Cf6SM8Jm3C7JdHsiHtlYZ2B
	 ocDDZ5ndwUZvhUxHL2orWVWPrxQLWtY0P1fuVK5OjCk3k7XVOggeWmftWxVDOZ0QjfyBW
	 szktmivq1kpo2VHVzAQpcMX7aZmmOHRVnu9nvUdk0TQ4xcqddZD0TxvCPktQwSBG/svYM
	 +PuTVXkXZWnQPF40YFJDab57je4Bnims54D80P2ZwKv2FKL3P9Wdj05sEGTs0xqGLEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GfcJ1Dee;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E7B606A32F
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GfcJ1Dee
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 313281F0089F;
	Sat,  7 Nov 2026 10:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048450;
	bh=ysoNjOwK7OSgj8dxO6Ma2/5ku2vm6SW2OVw+o/t/gvM=;
	h=From:To:Cc:Subject:Date;
	b=GfcJ1DeeRjSADKEH7oyYEGMVoeENEW7+7oT/SmdB9rcZK1WvzuLKyxPxNW1HPipTG
	 hKSSRcurHoBY5gh5g0z+2zgXSHSjGIgjFTELANBquwgTJNj4cxoDf72QOwN0tqiTPm
	 FlRbjyn/HLOeFMCJrq0VEcuM18fFEFI0i8zDUeN8h2ZroO65bHmp0f2rYglSVZ09c8
	 kX7yxlgA1Nqr18uCARd3PRqXpnJ8Qhk3smMHWGMRn/nWdyAi5fCcGzsWqELd3lv2LA
	 XL6LJKu/W4vHC/IqtjM2qV1fUcOPIoaEHF6dKytE8NouTFL4dCngmw5e4MG5BTfxX5
	 +eoGmkt8JwI5A==
From: Sasha Levin <sashal@kernel.org>
To: lihongfu@kylinos.cn,
	akpm@linux-foundation.org,
	muchun.song@linux.dev,
	colin.i.king@gmail.com,
	david@kernel.org,
	kees@kernel.org,
	almasrymina@google.com,
	osalvador@suse.de,
	shakeel.butt@linux.dev
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/hugetlb_cgroup: move per-node usage on cgroup reparenting" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:47:28 -0500
Message-ID: <20261107054727-failed-6.1-23fac055c211@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 23fac055c21176f66ed453394b533bdfc00f7fba
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054727-failed-6.1-23fac055c211@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 23fac055c21176f66ed453394b533bdfc00f7fba Mon Sep 17 00:00:00 2001
From: Hongfu Li <lihongfu@kylinos.cn>
Date: Fri, 18 Sep 2026 10:56:11 +0800
Subject: [PATCH] mm/hugetlb_cgroup: move per-node usage on cgroup reparenting

hugetlb_cgroup_css_offline() hands the folios of a dying cgroup over to
its parent with hugetlb_cgroup_move_parent(), which moves the page_counter
charges and the hugetlb_cgroup pointer of the folio but not its per-node
usage.  The parent's hugetlb.<size>.numa_stat is short by that usage while
they are charged, and underflows once they are freed, exposing incorrect
per-node usage values to userspace.

Move the per-node usage to the parent as well.  The folios keep their node
here, so only the cgroup which holds the usage changes.

Link: https://lore.kernel.org/20260918-for-hugetlb-charge-v2-2-2b6d8c2bdc36@kylinos.cn
Fixes: f47761999052 ("hugetlb: add hugetlb.*.numa_stat file")
Signed-off-by: Hongfu Li <lihongfu@kylinos.cn>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Acked-by: Muchun Song <muchun.song@linux.dev>
Cc: Colin Ian King <colin.i.king@gmail.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: Kees Cook <kees@kernel.org>
Cc: Mina Almasry <almasrymina@google.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: <stable@vger.kernel.org>
---
 mm/hugetlb_cgroup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index 7cf7c18119b43..3fb41311e4c7d 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -241,6 +241,8 @@ static void hugetlb_cgroup_move_parent(int idx, struct hugetlb_cgroup *h_cg,
 	/* Take the pages off the local counter */
 	page_counter_cancel(counter, nr_pages);
 
+	hugetlb_cgroup_move_usage(h_cg, parent, folio, folio);
+
 	set_hugetlb_cgroup(folio, parent);
 out:
 	return;
-- 
2.53.0




