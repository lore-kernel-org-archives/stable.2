Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594A0379C4A
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 18:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788979603; cv=none; b=iO2AqvERKhc4xIj5kqj84GaHDN2KbfES7E3rLgUtN3+4rUvhGRM6XVYaaeeSv6AFncj7rSJUhjVriPVJ4TEQZqsz+r4i2ce5ECuCkg/DY8L7oIjxM2Pr8oFlLWkJoo4OWP0vsLcjvEFA5Wu0suOQ8pngxCmfhG/51n/eNNAQstg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788979603; c=relaxed/simple;
	bh=3HbPAJjnj77kLQtlgGkv07SWWW588WGVuIju5GFuc7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PxtSCWfIy0cpHum55jrGv6MViAK9GqM1gNuEWS/YFHYlAVriRy8/JqMkRZJhdoX8lzb09CTgi57s0FN7LYCXKNKWHjfmn5AhdD01rmMzrZ74NStKUCbYun90UOhU9TV8+cDUNR23Yy0Ym8v4zwh2aNLcZNHq32wsdicLWDsWMvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mj0aSJuj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mj0aSJuj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EDD41F000FF;
	Wed,  9 Sep 2026 18:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788979600;
	bh=3FPZY7lZ00DdTnny6ilxmWTf69HxJ7JXUH3ACtxscFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mj0aSJujABYEk92RV/+7Ty1pGGT/Vn8LtaM2qT3JIHEXQcabIVoOyW0J4JWe922ya
	 +EJuT3jw6/2KQJRKWYuhnb2f7E1ARBv8wVo6at05ljlNoshzwqLhEkMEonQvKzuKBx
	 HwDNKF7HVamDGJL9g7P/996Y/88/bqEwaD4SNnaBE84+PQ017ACbIyChK2iejBBgqI
	 reDuNyBVQAFI084xCbofATmcU2N6Ak+rhdT1OgfwvOpIpT6xXoasIUL2YiufBOzVzW
	 L7NuhvS/oQ3NgQxTFagsXTfvyqTNB54vTrT5Z7SZSJKAeOO4QFaE42Nmwmh2drK3xi
	 TnboZwLO9fvsA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Guangguan Wang <guangguan.wang@linux.alibaba.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] net/smc: Address spelling errors
Date: Wed,  9 Sep 2026 14:46:36 -0400
Message-ID: <20260909184637.3461682-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090313-resupply-paprika-8273@gregkh>
References: <2026090313-resupply-paprika-8273@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Simon Horman <horms@kernel.org>

[ Upstream commit cd959bf7c3bbaf64a29750c5e36776078a18a8fe ]

Address spelling errors flagged by codespell.

This patch is intended to cover all files under drivers/smc

Signed-off-by: Simon Horman <horms@kernel.org>
Reviewed-by: D. Wythe <alibuda@linux.alibaba.com>
Reviewed-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
Link: https://patch.msgid.link/20241009-smc-starspell-v1-1-b8b395bbaf82@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

[Stable dependency adaptation for db51a8658c11a82432b64999519a269c3aabb447:
Keep only the "normal termination" spelling correction in smc_connection.
The target patch changes the freed bitfield on this exact line, so the
correction is required for the target to apply cleanly to Linux 6.1.

Drop the smc_core.h corrections because this stable tree does not contain
the SMC-R v2.1 connection/link negotiation definitions they annotate.
Also drop the unrelated smc_clc.h and smc_core.c spelling corrections.
No functions or executable code are added or changed.]

[ sashal: Reduced backport -- upstream cd959bf7c3bba touches 4 file(s), this
  backport carries 1. Not backported here:
  net/smc/smc_clc.h
  net/smc/smc_core.c
  net/smc/smc_core.h
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: db51a8658c11 ("net/smc: stop killed, freed and out_of_sync sharing a byte")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/smc/smc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/smc/smc.h b/net/smc/smc.h
index f480b956c45ef..ed86e11949ef7 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -234,7 +234,7 @@ struct smc_connection {
 						 */
 	u64			peer_token;	/* SMC-D token of peer */
 	u8			killed : 1;	/* abnormal termination */
-	u8			freed : 1;	/* normal termiation */
+	u8			freed : 1;	/* normal termination */
 	u8			out_of_sync : 1; /* out of sync with peer */
 };
 
-- 
2.53.0

