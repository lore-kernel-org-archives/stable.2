Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A604E2378
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788448994; cv=none; b=kTw2X3IzCIoqyTIaxzR6TOYUZFPQQQZD6TopePJT+TCQDirNH5BRUlibJHxn+eqg4Dco5z4XtuD5TO4qwqTYTT13oQmTzIBf0Ku0YOMp1ugCHIpwPPtAmaZ/Y77SK4ZUgXiO3h4uet7r+a5FkNLzi72QGi2rFXFYpvyqzsZsWJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788448994; c=relaxed/simple;
	bh=UPLwManmM2qk4QRa1lHoU3vXlGs/hC58jG/Gvs3qgNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TJ+LLA2y6My9K7/oKHLe14BZNFp8xvJNzAmZUGHsx7zPnK6cxzqS3YsN1U+sb9yBSVEizxM7D/TosRJ+hcRlDuSI4yMIFgRRWTUvB8NJ9l4ZqNpVMFLHBNbHJlZAVXMsZdroVENqYt5oY1efjykWa0JWH/lmtqeNUzmMQjvLC0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NjxO4DjS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NjxO4DjS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23C751F00A3F;
	Thu,  3 Sep 2026 15:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788448992;
	bh=H8d3HdC81IxHHyQXfa047YI1Bv1NMZxsYiDmG9B5PEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NjxO4DjSLx/4SoEUeInIMrAXY1CZS+4IQAcQUQVkF9n9sUSmBKB3ad9Ug8XxX3ziu
	 16mYzj1sRiv4F8C7YYQ71V8q9j3nXKXfveTxLoEUtqbsQagAI6wwLU2BhVCyeRYeo7
	 ymnjC8KXHn2BG67EbyfDK93jbLsiK/jueeE4LqX/x1Z1/qMKe3Y1ESaS8Al+ZFo7KI
	 3QlAZr3FhtdPeTn3cjh8IjzzSiGgtMVwzmNo5M/9/i0rZXJ2AYUECrfUPBnpd9zXyj
	 ThrvVbi41WLN2qdY3eeZoB4yVyxkhpqpgQYIpNDHJzA1mc2PdZiowY0ddz+3RJ9AY4
	 o5hmcDDgG105Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	Barry Song <baohua@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Kairui Song <kasong@tencent.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Baoquan He <baoquan.he@linux.dev>,
	Chris Li <chrisl@kernel.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] mm, swap: ratelimit bad swap entry reports
Date: Thu,  3 Sep 2026 11:23:07 -0400
Message-ID: <20260903152307.887829-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903152307.887829-1-sashal@kernel.org>
References: <2026090322-mating-twice-bdd0@gregkh>
 <20260903152307.887829-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Breno Leitao <leitao@debian.org>

[ Upstream commit f9dc428249ed962a70acf301f01eae8578449161 ]

A corrupt page table hands the same bogus entry to get_swap_device() on
every access to the mapping, and every rejection is logged.  One machine
logged 6185620 copies of the same line in a few hours.

swap_dup_entry_direct() prints the same message from the fork path, once
per call: the WARN_ON_ONCE() guarding it warns once, the pr_err() inside
does not.

Rate limit all three prints.

Link: https://lore.kernel.org/20260818-swap_part_one-v1-1-a4fc58119fc0@debian.org
Fixes: 23b230ba8ac3 ("mm/swap: print bad swap offset entry in get_swap_device")
Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Barry Song <baohua@kernel.org>
Reviewed-by: Nhat Pham <nphamcs@gmail.com>
Acked-by: Kairui Song <kasong@tencent.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Cc: Baoquan He <baoquan.he@linux.dev>
Cc: Chris Li <chrisl@kernel.org>
Cc: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/swapfile.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 49ad86d543f92..965bb1ed3372f 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1284,11 +1284,11 @@ struct swap_info_struct *get_swap_device(swp_entry_t entry)
 
 	return si;
 bad_nofile:
-	pr_err("%s: %s%08lx\n", __func__, Bad_file, entry.val);
+	pr_err_ratelimited("%s: %s%08lx\n", __func__, Bad_file, entry.val);
 out:
 	return NULL;
 put_out:
-	pr_err("%s: %s%08lx\n", __func__, Bad_offset, entry.val);
+	pr_err_ratelimited("%s: %s%08lx\n", __func__, Bad_offset, entry.val);
 	percpu_ref_put(&si->users);
 	return NULL;
 }
-- 
2.53.0

