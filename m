Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFD72D8DBB;
	Wed,  2 Sep 2026 00:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788308855; cv=none; b=cRVmV/lvpk6BlvmfhzvxIIJ85zXXnzf2tM8L8Lz21Vk9+fl2Vs3airD2I+VoO2tAfh5MeTCUtrTP4NOBTr84UDRVGXyowyjdoTwXVciufboGBD455BIYfULebEpP6NV+GMRMNXezV7/hW9y5rsBgqbsqKkA2VTc7uL1lFiyrAaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788308855; c=relaxed/simple;
	bh=nM5ntWNruZ80VccSW5rjD3fIf32vH4ps/z73q2oxrgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JIx/l2fXypS5hwscfJySCRDSRLO6zYCKgstmoBs15bxwUcs62LeRe4GYJDqqbANJc1KV/ahcAl10U8g2fiIjrg/jxoHqJkcKoU2kmPVr86/C43VFs7lhBAaSCpDh7HfkvkRVOPi9NXWiqlY24qnw7sw742MIRx0dGF55/vqbs2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QacSCw1g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QacSCw1g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D5061F00A3F;
	Wed,  2 Sep 2026 00:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788308853;
	bh=KgVH3jXroigXUbQaVhPgGVZ8NdHiYPKQ6daDtsHhDVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QacSCw1gsI5N0HGKudxjhUx3D/hC8VbYXVePH9gDtXWWcKeurZ+Zf11T80nVvNKOM
	 7SK0Nbuhxra1HuTtRAazt2utA3ruJC9trhXfLzMIv329BicGcqudFTXUPS397jimdd
	 xWK6HEcOMwsSRz8kabDpie08JwrvcbqVZAp7WUhpp2TjGJzCOnse8ufokprHt4QR57
	 EOeaEsL0cW496EETLYaOQePpD/0aVH+LRRIDxN3B842siNm8T8PT/VY210obNOS2hy
	 a5wt5cs4S698A5jpWb7apPXmLDPiZLM/D/0qdKvbGGOoAVb6QZWNqyUsPPt3aG1b6W
	 u6YcZcyESewvA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Ravi Jonnalagadda <ravis.opensrc@gmail.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 3/4] mm/damon/core: copy nid for eligible_mem_bp damos quota goal commit
Date: Tue,  1 Sep 2026 17:27:22 -0700
Message-ID: <20260902002725.108635-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260902002725.108635-1-sj@kernel.org>
References: <20260902002725.108635-1-sj@kernel.org>
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
index 20748b0a71026..53c3f97e3f126 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1143,6 +1143,9 @@ static void damos_commit_quota_goal_union(
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
