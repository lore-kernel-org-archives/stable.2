Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652F5446C0B
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 18:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791397264; cv=none; b=ffPJwrgCT4J0IeIZwrpGu8CUTwSHp/trpEtK8EonoNKa2Ksc0ZdopPTkurlDKc4Td5E2I9wLTtw5PzddGfe309tDfBofH5MZ3p1Nir/o4iGalFVWZUZwlr9zZ7PIVSGzgDn76SjtVlH0UA1MeWQvx/IWWjzp7uxD94EGf2ZODI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791397264; c=relaxed/simple;
	bh=S8lqsGHYgEi6aN5/92S+XuHxDlvhB7Npr9vaA546jSA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lKdBJZAN+9p2pPmyIZLSolJu8wLbqwFMetzWoCtT3PpV9X6sDk8nEEpXNFlKqxCsypsHASltcYj3+geXOc9xhhcGsC2XclXjmj1UFCOh2Vy3lulcdbYLHvBQyM9xdr+pOB5UZzpx5esMkLNIaO5BodJkCflaphpIN0r9cQH2wUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R0D1T3Xz; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0D1T3Xz"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3a02551822eso2169245a91.1
        for <stable@vger.kernel.org>; Wed, 07 Oct 2026 11:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791397263; x=1792002063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=E0PgEpbZCp+6pcisuCXGJ1lijywoGJRox1hGYTGYf5s=;
        b=R0D1T3Xzw4H2/FtthY7LPLRdi5y8bXdLBvqEiUmp4jjLp5Gg9QxeMyDAyK5TowsqBc
         vEvL9sIjkKp3C9F8k6eyp4j7BCgKJMDiMJCsjNplXzFESqXpwFlTRuaowfY9cSbHG66R
         FyTI55mWXClMcMKx1cHcvG3I4L/OgWq4brm+Bj/wc7Ql6ibIYy4ZYogJKwKXEqF4UsDQ
         3RKF8lbNJmq/XTs+UsmqaC3KDhoC0aMTa+7kROBOAqN8/zN94KFQjpmiAPGqjiQCUd5m
         PJ2R7wyo2JA6d5+UdWyZ9t7MIhG88uqOLgt88vTcmNCdxlnohAwJN1Ga1HHhfaApsXJ+
         ORww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791397263; x=1792002063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E0PgEpbZCp+6pcisuCXGJ1lijywoGJRox1hGYTGYf5s=;
        b=lAStEpT/D2w7WdGnMAG5fw5b1KibN3nDac6af2k6B9V1sWOwEiW/6FBI3IE2YwCiI+
         kfTN97kkFHGBqjuVPy2LZxpQWx9Bbb+CINw31kiFBx+365XopwD886AOxBJjVGivLrhL
         SsOGBVL1APDy3IEPgVGTrntbVwQ2kI9e3CWnhOiny8n3y0I+oROrQnS0OPXiKO2A3XCH
         W29xyp8mRTWnEjV6wddK8+Xf8bbDzZDzaPRBQA2ara4O3u4wvm0TDrNIZGoQtge2fn0v
         wfjuBo5zPs+MUlr+EieelfehIiUNH5K204Pw6ajJPuXy2vdOx/yn4Q1XQPHEhm+GVXNG
         LgGw==
X-Forwarded-Encrypted: i=1; AKwUvBxdItHmJG/FW63mTGK0IA1/vUuGwzEFRKEMRia+MtaBZSPuXLMAb2IEQjF7EcpcdPK/Reig0rQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYIbRKyW2LPC83n2yun99qfMH09T/QU9G4p1v78sGXz7hkLRTs12
	5LIG9efBRTDvm5GpgY3vth1/XZs4R7/BvwQaCQO+1gUtCCYHNeGMVnqq
X-Gm-Gg: AYBFou16myCgSJC997OtKD1Wllr66E0q6vkce4iGvFolM3TaurbINHv6bU+eBCu3gV9
	sYuimQU6ZnhT4C+M+2C1xentNIDcDlJWvcdUwrq0Glctj09pS4Dhl7URrEb+IWtHiPFvOJuA5AL
	Kq9manYXj9K0RnUkchpcyYdWdCwmfJidpPk87b6oYgBI58KhYtxLFf6ouK38YSIuvaVmdHM1FCD
	8UlTbRsOsebDkhxrGJK4dSnJoymJPk3G9uME3XY5ahNiac6dzouNiyouO00bXIY9OllJRUHWWmf
	dMi6sJ5eiDT0lWMYItt7OAooKiRcqKUV3CpB2ItCtzK+X1O4TaEeBO3v7LHTGf4Xw0sFxQ0BQK6
	tkBNUyTZnhwCPlWsU7eFsnkzPef3j7VcBVrkhGhraSiF24gKtoP0ZJXbpzSZiVkJCdBxs8jDyZY
	UqadeKcQQHmqkIU33LxzB+MN2XJY2ErRd/BmNn+fdSA7EkajcW4MwZWkp3MPh/5yk7Ljs=
X-Received: by 2002:a17:90b:5623:b0:3a7:ed4d:afeb with SMTP id 98e67ed59e1d1-3a8a11997c5mr1995981a91.27.1791397262645;
        Wed, 07 Oct 2026 11:21:02 -0700 (PDT)
Received: from dungbv.. ([58.186.69.27])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a9f1ac60b7sm720434a91.8.2026.10.07.11.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 11:21:02 -0700 (PDT)
From: Bui Viet Dung <dungvn2345@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>
Cc: Phil Sutter <phil@nwl.cc>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	linux-kernel@vger.kernel.org,
	Bui Viet Dung <dungvn2345@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] netfilter: nft_set_pipapo: skip transaction elements during GC
Date: Thu,  8 Oct 2026 01:20:57 +0700
Message-ID: <20261007182057.332512-1-dungvn2345@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since nft_set_commit_update() runs set commit callbacks before processing
NEWSETELEM transactions, pipapo_gc_scan() can observe elements added by
the transaction being committed.

The scan evaluates elements in priv->clone without checking the element's
transaction state. Expired elements are deactivated, dropped from
priv->clone, and queued for GC reclaim via pipapo_gc_queue().

When the transaction loop in nf_tables_commit() subsequently processes
NFT_MSG_NEWSETELEM, it calls nft_setelem_activate() on an element pointer
that has already been handed off to GC reclaim, causing a
slab-use-after-free.

Only consider elements that are fully active in both generations, matching
the fix applied to nft_set_rbtree in commit 86b6471e690c ("netfilter:
nft_set_rbtree: skip transaction elements during GC"). Advance first_rule
by rules_f0 before continuing so the loop proceeds to the next rule.

Fixes: 1e3b9e1c77fe ("netfilter: nf_tables: call set ops .commit when building new ruleset blob")
Cc: stable@vger.kernel.org
Signed-off-by: Bui Viet Dung <dungvn2345@gmail.com>
---
 net/netfilter/nft_set_pipapo.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 978bb0c0110..48658c09c59 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -1745,6 +1745,11 @@ static void pipapo_gc_scan(struct nft_set *set, struct nft_pipapo_match *m)
 		i--;
 		e = f->mt[rulemap[i].to].e;
 
+		if (!nft_set_elem_active(&e->ext, NFT_GENMASK_ANY)) {
+			first_rule += rules_f0;
+			continue;
+		}
+
 		/* synchronous gc never fails, there is no need to set on
 		 * NFT_SET_ELEM_DEAD_BIT.
 		 */
-- 
2.43.0

