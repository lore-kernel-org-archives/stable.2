Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F8B3BA246;
	Fri, 28 Aug 2026 18:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787942220; cv=none; b=LiyMe5TxFTeNEXw5clvn/8T63Vg6zmY5JaIsfCDgwPdZXzBuokQK/5DvgZ+j7ul2sBJAcXUcD7iw/sNQExZOAy81gBDHqlsfuK3e96R/xZGcSrdVkIMZY7fYIACLn9XT5S/haE1CC7LQQ2oWMRoWYVWeCpoYH96u4FPwb+SJNfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787942220; c=relaxed/simple;
	bh=yua3+vJZxoD4D8iUD7DkUwYEHYEvn7FwxVTEKR9KqT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UTazjpz/rrAf6y5v6hdH7rbgLhxYAPV3UMLjrbFq/+aZt0EdplqgWhWTIrntuS889vO/NJ9EQ2eEM/SAlGARR/24XONbIpgyJNmGIG+mNA5ui5xbSoou/LANyEZj3ywn7tLrhssPFmdsCj+ptQumU3lHQWzMT8n/8CQv1LjdPYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZ9DFD1H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZ9DFD1H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 339101F00ADB;
	Fri, 28 Aug 2026 18:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787942219;
	bh=+IOYzbq22lhYIf1iXAGWkCEwZrUSQpgR/aOknVb4vnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GZ9DFD1HCeOqE9xfWczRsB/Jf8bnqdi6VhHAyJPn52H77HPYsj9JTrPKSty0M2Kk9
	 0UL6R9253A8E9Br970ftJaIx8QNUQOOuwmGdFK4G2/v83ZRt4sfZMJEvZUl8+bXR6M
	 qZ3w4yBwNfMPmRQilj2boskC6V+LcHz+iswV3QK8p+EdHpjoPotT+3I3d+6ghAMHeX
	 A2mHtaVE8+YMuoss7QXfcfx9f4v5fSxNkqf1GlzfBoF46/uRnutowkv4Kx8kHxoBqJ
	 pvr6YxvJYZFIoRGhklUa+6cVySPOxdDQ15BW9/9+joPEm4GH0nnhmMc3VGOlR0nQxp
	 spC+8u8Q+Z7Ww==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Ravi Jonnalagadda <ravis.opensrc@gmail.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.3 3/4] mm/damon/core: copy nid for eligible_mem_bp damos quota goal commit
Date: Fri, 28 Aug 2026 11:36:47 -0700
Message-ID: <20260828183649.71192-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260828183649.71192-1-sj@kernel.org>
References: <20260828183649.71192-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damos_commit_quota_goal_union() is not updating the ->nid union field
when the goal metric is DAMOS_QUITA_NODE_ELIGIBLE_MEM_BP.  Hence, if a
DAMOS quota goal of the type is online committed in a way that it will
reuse other quota goal's memory space, the new goal will work with a
garbage nid value.  As a result, the DAMOS scheme can show unexpected
aggressiveness.  Do the update.

The user impact is not catastrophic.  No leak or crash happens.  Doing
the quota goal online commit that can reproduce the issue is expected to
be not common.  This issue was not found by real users but the AI
review.  That said, the issue can reliably be reproduced.

This issue was discovered [1] by Sashiko.

[1] https://lore.kkernel.org/20260827045035.94611-1-sj@kernel.org

Fixes: 9138e27a3bc3 ("mm/damon: add node_eligible_mem_bp goal metric")
Cc: <stable@vger.kernel.org> # 7.2.x
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 39605e64dabf2..b3f8bea774c2d 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1136,6 +1136,9 @@ static void damos_commit_quota_goal_union(
 		dst->nid = src->nid;
 		dst->memcg_id = src->memcg_id;
 		break;
+	case DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP:
+		dst->nid = src->nid;
+		break;
 	default:
 		break;
 	}
-- 
2.47.3
