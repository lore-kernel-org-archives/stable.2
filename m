Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794603715;
	b=QCwPhn1o+SgpJO4CmIpuxxEUTZ8e+zEKZ3VzPJcpB+zmkH49AYOmC7U7OhoeZkO+V+Ib
	 fJaNxolHysFii6AHGa7MiQhigZ3E23px8I+ieD/V8LYTjjuCBxNklrFxts4k/7Eb2CART
	 BL+CE+wji8TnVDQD4iDgwLEKFCVgWxUVy43//jaCm9m7i9oH6h81wDh45X+yFhy14m2RO
	 6rqCpjbfBVXGvMkbBzjiWY4Xmuc+MKZLc159Wg5RHpAYMwhAjFK0hz6tLQezYT1q53SVE
	 pQBB6YLylXqF3tGiZYA2EfmPfmkVsTpytX0jkysp4y2naRXd09vAqITAsybjiO/qLwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794603715;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=pr5CAc1D1gykLwIBUVgTdZA+u4P+OdI+acwqJ5mVYG4=;
	b=BkotfiV+LFg7u9RmDR0mbuRmqjOIp1ZNDiKf+czhXPDq2STENBtwt8z7y5X8/A50PdNN
	 kBtvFIcmUA4W2pwErpH3jy6bssbnaj25Hkp0zxqd5kWpwEtJm09m8WveepFP+wVR0M12u
	 AMyL5BsweaH3CTfMwsRwtiPx4whCJaUYbRgsxMxCEwY1AMDvPMIoeKS9ojVaI/WP+otdu
	 gUpHVR4wlpD8973jF7qK8gGPBUdk2hOFgfcU1UAsfY3ZWvyVdnUqKMi3XWrTZpdgoJSpJ
	 RuvWqRIF759RPDfpOQVRvgshOglyEdr1WuS+AplRGrLO4bS4NFImd6Yc6bfTyIkoS+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ae7ksmQB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6378606A33E
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 21:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ae7ksmQB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A14341F000C5;
	Fri, 13 Nov 2026 21:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794603715;
	bh=pr5CAc1D1gykLwIBUVgTdZA+u4P+OdI+acwqJ5mVYG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ae7ksmQBn5H3wbiNdbpht++Q/81hUQ+KnNnWRx6ZTJQXeV9KRC+QfJ956PCxvc0vy
	 41EfJVsOBv7MguQaMvFYiioXvd2B4qukJm77ZAhZwW1SVnar/UdRo9EwWHQB3zzyKN
	 YDoN5pCzhky/BNwIhrZPw41aKnN+TGNLawiVp/pyyJhhMcYrp++wfa3nFU2pjWOf//
	 KylIBBS2E9szqzAJNOPVcOF7Cge3naETQ9rXoKVN2pEc9nj6Hx0m/bs63kVEuALR+C
	 bTp8KYelqAWguQyngDQAo6p4FH5WfiFYU+dcXSNnQTdPsac5t1Yy5JUwh9aFFZ+h0W
	 J3UqmpUhIlpcA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	Dev Jain <dev.jain@arm.com>,
	Muhammad Usama Anjum <usama.anjum@arm.com>,
	Lance Yang <lance.yang@linux.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] mm/mremap: use pudp_huge_get_and_clear() when moving huge PUDs
Date: Fri, 13 Nov 2026 16:01:53 -0500
Message-ID: <20261113205815.2527553-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201347-failed-6.6-b4417d08034a@kernel.org>
References: <20261109201347-failed-6.6-b4417d08034a@kernel.org>
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

From: "David Hildenbrand (Arm)" <david@kernel.org>

[ Upstream commit b4417d08034a7b4a3083e0e2d95429d4542524f2 ]

move_huge_pud() reads the old PUD and clears it in separate operations.
Hardware accessed or dirty updates between those operations can be lost
when the saved entry is installed at the new address.

The raw pud_clear() also bypasses page_table_check_pud_clear(), while
set_pud_at() accounts for the destination mapping. This leaves the
checker counts unbalanced for mappings tracked by page table checking.

To fix it, simply use pudp_huge_get_and_clear().

Fixes: 7d846db7d0e2 ("mm/mremap: convert huge PUD move to separate helper")
Cc: stable@vger.kernel.org
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Reviewed-by: Dev Jain <dev.jain@arm.com>
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Link: https://patch.msgid.link/20261031-fixes_core-v3-30-d6437171ecc3@kernel.org
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
[ sashal: Replaced pmc->old_addr with the existing old_addr parameter in pudp_huge_get_and_clear(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/mremap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index ea57f3095076b..8c86487d3318c 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -411,8 +411,7 @@ static bool move_huge_pud(struct vm_area_struct *vma, unsigned long old_addr,
 		spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
 
 	/* Clear the pud */
-	pud = *old_pud;
-	pud_clear(old_pud);
+	pud = pudp_huge_get_and_clear(mm, old_addr, old_pud);
 
 	VM_BUG_ON(!pud_none(*new_pud));
 
-- 
2.53.0

