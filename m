Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4FB3C0A12
	for <stable@vger.kernel.org>; Fri, 29 May 2026 23:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780097609; cv=none; b=KsXO2SA5h8kjjcLca8bZwYRp+lyZCOPUfQNWIiw0LAg5+C5qg2jVqWRz01TZZBYeblNkfFjcJZN22VU3NaNQJ5lWmkckfZ1spp83X0WVI6BoKJ3ZHR9x4IpnI790sh6dPEJu9Tpn29y5iN7Ab3/NQweMfRhc71r747WihnRvag4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780097609; c=relaxed/simple;
	bh=1MKLDni8SB4UFA+FMtRekHF1p+ors6PMGRd8O+gFRfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A5Ev3OFyS6IzXBVveTzj0pvf0QzbaaxKkAE2UigmNv5c7G02nZ8qQPc1aaQ4qFkxB58oWpl18fW06ATftq9CixN4zlZ0Ett0wvhvEH4Pdl+e5EuMEtL0CzJMeG56sEm7d72DQFHOhJyU5Slz1Hbgn4pD4It8MgJoaUb0gBwncVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RocYaN3Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RocYaN3Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E4E1F00893;
	Fri, 29 May 2026 23:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780097607;
	bh=gVAJHNxfqYnH3DBLKbSP/o25PtG0/+cNKlA9JqgCWYc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RocYaN3YKMUo6/xQlmNHiguhLjDYRNskcQvf7Y9F79CrTY8F9/d3b7zn+xCvbNjLP
	 QzPbqnrc3CyaZiJgY8GN9HGTvtNb9UrZC3boJ8HjlvjKYWzqyusj5lHYm2jFjoAB6N
	 sHtI2LcVmHuTVG2cHlbU/c4HdBqcndrMp6T/4l5134sBEmijzwS+7msdFMb4u7OVvb
	 kBw2VeEw1JDj30EI/xJqp/9ftWwuYYF8olLjZJsMod4nD8ra/hvtjC4ziY/FoScX32
	 f0YITQQ61T/BcGBrMbVlPdrQR8W/iZlBgzq2DSdKcixFrSMfLKIau0RuCLdB7PnL2v
	 fdB3JmCeDOZHQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] qed: Use the bitmap API to simplify some functions
Date: Fri, 29 May 2026 19:33:24 -0400
Message-ID: <20260529233325.1901920-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052809-snowfall-thermos-6a66@gregkh>
References: <2026052809-snowfall-thermos-6a66@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 5e6c7ccd3ea4b25dd6b4b0363859913f315deacb ]

'cid_map' is a bitmap. So use 'bitmap_zalloc()' to simplify code,
improve the semantic and avoid some open-coded arithmetic in allocator
arguments.

Also change the corresponding 'kfree()' into 'bitmap_free()' to keep
consistency.

Also change some 'memset()' into 'bitmap_zero()' to keep consistency. This
is also much less verbose.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 2bccfb8476ca ("qed: fix double free in qed_cxt_tables_alloc()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qed/qed_cxt.c | 24 +++++------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_cxt.c b/drivers/net/ethernet/qlogic/qed/qed_cxt.c
index 1c3737921b6cf..8fc8f428266a9 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_cxt.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_cxt.c
@@ -1037,12 +1037,12 @@ static void qed_cid_map_free(struct qed_hwfn *p_hwfn)
 	u32 type, vf;
 
 	for (type = 0; type < MAX_CONN_TYPES; type++) {
-		kfree(p_mngr->acquired[type].cid_map);
+		bitmap_free(p_mngr->acquired[type].cid_map);
 		p_mngr->acquired[type].max_count = 0;
 		p_mngr->acquired[type].start_cid = 0;
 
 		for (vf = 0; vf < MAX_NUM_VFS; vf++) {
-			kfree(p_mngr->acquired_vf[type][vf].cid_map);
+			bitmap_free(p_mngr->acquired_vf[type][vf].cid_map);
 			p_mngr->acquired_vf[type][vf].max_count = 0;
 			p_mngr->acquired_vf[type][vf].start_cid = 0;
 		}
@@ -1055,15 +1055,10 @@ qed_cid_map_alloc_single(struct qed_hwfn *p_hwfn,
 			 u32 cid_start,
 			 u32 cid_count, struct qed_cid_acquired_map *p_map)
 {
-	u32 size;
-
 	if (!cid_count)
 		return 0;
 
-	size = DIV_ROUND_UP(cid_count,
-			    sizeof(unsigned long) * BITS_PER_BYTE) *
-	       sizeof(unsigned long);
-	p_map->cid_map = kzalloc(size, GFP_KERNEL);
+	p_map->cid_map = bitmap_zalloc(cid_count, GFP_KERNEL);
 	if (!p_map->cid_map)
 		return -ENOMEM;
 
@@ -1217,7 +1212,6 @@ void qed_cxt_mngr_setup(struct qed_hwfn *p_hwfn)
 	struct qed_cid_acquired_map *p_map;
 	struct qed_conn_type_cfg *p_cfg;
 	int type;
-	u32 len;
 
 	/* Reset acquired cids */
 	for (type = 0; type < MAX_CONN_TYPES; type++) {
@@ -1226,11 +1220,7 @@ void qed_cxt_mngr_setup(struct qed_hwfn *p_hwfn)
 		p_cfg = &p_mngr->conn_cfg[type];
 		if (p_cfg->cid_count) {
 			p_map = &p_mngr->acquired[type];
-			len = DIV_ROUND_UP(p_map->max_count,
-					   sizeof(unsigned long) *
-					   BITS_PER_BYTE) *
-			      sizeof(unsigned long);
-			memset(p_map->cid_map, 0, len);
+			bitmap_zero(p_map->cid_map, p_map->max_count);
 		}
 
 		if (!p_cfg->cids_per_vf)
@@ -1238,11 +1228,7 @@ void qed_cxt_mngr_setup(struct qed_hwfn *p_hwfn)
 
 		for (vf = 0; vf < MAX_NUM_VFS; vf++) {
 			p_map = &p_mngr->acquired_vf[type][vf];
-			len = DIV_ROUND_UP(p_map->max_count,
-					   sizeof(unsigned long) *
-					   BITS_PER_BYTE) *
-			      sizeof(unsigned long);
-			memset(p_map->cid_map, 0, len);
+			bitmap_zero(p_map->cid_map, p_map->max_count);
 		}
 	}
 }
-- 
2.53.0

