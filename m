Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794532508;
	b=y+FtnD9WPKojym5wpaK/qbeqpg2NvBL2XVRNKulxpId0YlmNPwjh10LrEFvjwhozXuXq
	 IjavT67OsBJUPIXA0Y7PScUO6TBi93TZaOK/ZGVbe6MJmvc8eH6o0R0FIwNyphL35bmHv
	 rRCBGMdESiVaprqLrtfiaqidp+xLrPckNRJchlXU0N6JRF1LPzScLrbGQ3oAd1cFVu9/M
	 orZTmQMI7ekViNOmuBcg7ZgMpfTfTBqb1YwL98/kDGYoNrB6KzO2toMu2mDy4bBMCjMrV
	 /BQLUqjgjlGF9rtw25jXUBUek843Y4mJLa9Zbqz1l6mgbjzsaXwh3BL7lrdjodUjtBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794532508;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=4+sySXGh+AEafyOUZEmSm7ZLCws5y56P9dNZ2B0xry4=;
	b=AZKvaQc63oBvgXX283sxBnTcSdcHA5V8jvBG3xOzw8Y1WKLKgl7ZQd47qcebpZeNiTpv
	 IfmntbLxAh/4HGUWvPOgGgFeEMdM+xdP/xDIfTBTBHVUmU6ZxAQ3SSmlG2ppSYF6J1sfe
	 UmwfXUBoi1fTkurJ+NBp2Ew9c/rwMXkh5xGZ7EABeyExPcb3BjuMAr5Hze2ExzsqbiLin
	 D+IdK6Z2E0FdWtd0o8Yf6Fjk9cPmKD42PfcdACpaAw4doLnIIS7YAkMugWhRgmTX2M0X5
	 OkmC5dFbeO2ma/D1xyRh8DTegRi1iy5eGjLeaiUrtWuDno/A5oL1T5Q3FVTMn3Z/ixA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eTjWU4KE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF87A606A8BB
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 01:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eTjWU4KE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8739F1F000C7;
	Fri, 13 Nov 2026 01:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794532507;
	bh=4+sySXGh+AEafyOUZEmSm7ZLCws5y56P9dNZ2B0xry4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eTjWU4KEhpqA/yXbgl6BCTTJ7g0A0iX8Jm0ihwy8p1YSwzGx7bXXLrHptLB7tqc6M
	 TBHU10SmWyFpa1IUNA+u3sOHd/LWz5uEgqGqJaf6YLbL5zFi3QM05xYRjywj65f3/g
	 pvDp9XAYWl3Z6/1fNG6S0Bv8JItOEk3ma6s8+AOzKbslUZXWd6iJtdXjW7wH0nvuP8
	 uIy43SOYggmDVZ1cSGtES3UQr6c4k3nEK4CEQTDdUFkFwcVQugLInELYgaKNwh2WYL
	 RwLcez4y6TzwQqujpZh+Zkfp+XXhjuYC6uMYhGYzaiIlo7GaXtCKV4xRcoa/7pIRPv
	 rdjMSHPA9iHPg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eva Kurchatova <eva.kurchatova@virtuozzo.com>,
	Pedro Falcato <pfalcato@suse.de>,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	"Gregory Price (Meta)" <gourry@gourry.net>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] hugetlbfs: enforce F_SEAL_EXEC in setattr
Date: Thu, 12 Nov 2026 20:15:05 -0500
Message-ID: <20261113011433.550275-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200255-failed-6.18-b7f570e7cea7@kernel.org>
References: <20261109200255-failed-6.18-b7f570e7cea7@kernel.org>
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

From: Eva Kurchatova <eva.kurchatova@virtuozzo.com>

[ Upstream commit b7f570e7cea761ec7eb4a3a9557a3a082d14e88c ]

F_SEAL_EXEC is enforced by shmem_setattr(), but hugetlbfs_setattr() does
not check it. As a result, fchmod() can change the execute bits of a
sealed hugetlbfs memfd.

Use memfd_check_seals_mode() in hugetlbfs_setattr() to reject changes
to execute bits when F_SEAL_EXEC is set.

This also fixes the memfd_test hugetlbfs SEAL-EXEC subtest, where
fchmod() incorrectly succeeded after applying F_SEAL_EXEC.

Fixes: 6fd7353829ca ("mm/memfd: add F_SEAL_EXEC")
Cc: stable@vger.kernel.org
Signed-off-by: Eva Kurchatova <eva.kurchatova@virtuozzo.com>
Link: https://patch.msgid.link/20260629180247.2343229-1-eva.kurchatova@virtuozzo.com
Acked-by: Pedro Falcato <pfalcato@suse.de>
Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Acked-by: Zi Yan <ziy@nvidia.com>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Muchun Song <muchun.song@linux.dev>
[ david: use common helper; fixup Fixes:; check only regular files ]
Acked-by: Oscar Salvador <osalvador@suse.de>
Link: https://patch.msgid.link/20261029-fixes_shmem-v4-5-392fc715d8f6@kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
[ sashal: Replaced the unavailable memfd_check_seals_mode() helper with its equivalent inline condition. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/hugetlbfs/inode.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 34ed9966f2ea8..f866dbe4c198f 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -854,6 +854,12 @@ static int hugetlbfs_setattr(struct mnt_idmap *idmap,
 	if (error)
 		return error;
 
+	if (S_ISREG(inode->i_mode) && (ia_valid & ATTR_MODE)) {
+		if ((info->seals & F_SEAL_EXEC) &&
+		    ((inode->i_mode ^ attr->ia_mode) & 0111))
+			return -EPERM;
+	}
+
 	trace_hugetlbfs_setattr(inode, dentry, attr);
 
 	if (ia_valid & ATTR_SIZE) {
-- 
2.53.0

