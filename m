Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794321268;
	b=wlRp3B1fd/kuHswcZCa70KfqhI4CQP2QtNt3W1FiBO3+pCKHFsp0Iq093e2UZAJXaN4T
	 LJmCCAa0EwtLBaNY/kVuuKcjWprx5iB3FBRsgTmCZJFiQxv4bH22m0MibBIMwDKdi8jCn
	 nV0OmPwOvpzfYl+1jcbyJJTBt46NoRtr92xtLb50sJgOR3WLkzyHO1ma3/doPmtYdryut
	 IbEuPavrzDWatPlN9MlNfAqwZvdjS9lOLrnivvCJ2x4JFxoHjjy8x2PB2gAAhk9apPuYm
	 63UsMhRMM2lLaTQHkVqQMeA7zHtemqB2YmkTcKcrU8ItTTHEpD3Qr36WCQ7DIOVMe+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794321268;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=rNZeXU4jLwWU3G8qj2PnTBiKeUXzo1+/0NSAXNJ2HvA=;
	b=Ik7YtJD8/a3aG7KqR+XmegbgUgt8IcDqgV8PYXRUi+Fz2M7Q8fV3pLCNgyii9yFFxoBU
	 87BOcN9q5Cyrx9OsN/1VolQLZwAHn7bGGnGkDjvrjj9dCEDGTx2FEGduxzKVV8SlNj1gg
	 4NEy5P+CYXgRCgfvkzcn2ilNkdEUHVVZ3AlNxjPNiTez2UIWCwzmDz5Uj/glSTUBOJl7I
	 Kd2X17Z0AwAWhjpHQ31tPZPWtHgcz3CoJT8Vj4TEkEye0i5h+5mXEfzC112CKzLleocpP
	 UU5QCcRhlb7n0Kh5dpbpT6cEgHNHM6/qdacicSIxda9F067RP7z9qhD2NbCm5iX8BdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Nm6cSgl/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC918606A339
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nm6cSgl/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F4DB1F00901;
	Tue, 10 Nov 2026 14:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794321267;
	bh=rNZeXU4jLwWU3G8qj2PnTBiKeUXzo1+/0NSAXNJ2HvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Nm6cSgl/U3iSq2zIM9/02L4YYSQDszODN9p+Jc0cbxmq1HEjxTOpxsuIVCVEUsLCa
	 ktPmqF5KzLh6DpZt9BfdFzbXqIgZwWYAe29kUyZCdLaHTxl1GoyNu2nRiRR5lS86kH
	 Z9GyHZNB5S4CDPEVRksy3d23smJchZvdzhj1vYVH+ExVvx6UrvipTNC0Kcp6uTZpYN
	 VSG9EInhXmQgKxXia1JBS2z0cr9sP14nrNks1uM6aaghjECLnpTnGMO57VWoWlGgVS
	 Jha3YK2TaMhwUiEumotnuw8N4dT1AD40JmhnuBimiE/4uiXaO0QnqO5BjlIvTVpaGd
	 8StEslo9Tgl1Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hongfu Li <lihongfu@kylinos.cn>,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Colin Ian King <colin.i.king@gmail.com>,
	David Hildenbrand <david@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Oscar Salvador <osalvador@suse.de>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 4/4] mm/hugetlb_cgroup: move per-node usage on cgroup reparenting
Date: Tue, 10 Nov 2026 09:34:19 -0500
Message-ID: <20261110143410.1902001-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110143410.1902001-1-sashal@kernel.org>
References: <20261107054727-failed-6.1-23fac055c211@kernel.org>
 <20261110143410.1902001-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hongfu Li <lihongfu@kylinos.cn>

[ Upstream commit 23fac055c21176f66ed453394b533bdfc00f7fba ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/hugetlb_cgroup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index f68829f1dabad..b5385068a6ad9 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -240,6 +240,8 @@ static void hugetlb_cgroup_move_parent(int idx, struct hugetlb_cgroup *h_cg,
 	/* Take the pages off the local counter */
 	page_counter_cancel(counter, nr_pages);
 
+	hugetlb_cgroup_move_usage(h_cg, parent, folio, folio);
+
 	set_hugetlb_cgroup(folio, parent);
 out:
 	return;
-- 
2.53.0

