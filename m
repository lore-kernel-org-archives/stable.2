Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB2D332909
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 21:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784151111; cv=none; b=HNah4COjFfoeiBXnYC/e/Xu0+WQH6k92RtCeh1t2lGu46JH3kRWY6nrLyMLTmiuQwsMawPBymg+zYm8IC4uUki+3QS+Bqv/xEiXNxE36ToispPOym1hmRl2Z0/ctZJjav2IuNusm5zv0ClTY9jSOFh97Zp6gp0t6XwVmhxX5NQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784151111; c=relaxed/simple;
	bh=F1ic9DHzbBFzd8mPPKeT3OMY2k4Zwq6DTa1iRMfEYos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lizN3bE6UhtW65Ud2bc2VdiecdcEa5fiL06jxE7n2fAFbrEzw7m7XreCUah+EYTMx0F0RjxdDnl9Cl0PRv07XK7qBdzNK99l1R6Vo3yw29K43j6ailvsZs2olX/SPqvKsmMoXVCuJ+ckg7I6WaV13LBtz5EkXFsjX5KozigX0rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P9SN2JX5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P9SN2JX5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F2011F00A3A;
	Wed, 15 Jul 2026 21:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784151109;
	bh=DElDuGtSD2gsi2U/fTloJsrRAuC40yjezYVEu/jUU/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P9SN2JX5i8KiWixhGmOIXEUvN0SIaObCbFSVhyc3Uo1MKhKVpf8zNgfu6DhUcv9ON
	 fGkaAkIDvGRfpCkzTFClEaxtEoC6k2kn7ZY18bKCS8FsDXbEEoEopNKw8AsTwVtYuw
	 FHPSZFfgl4GH5abXYnJDe5Iw4g+oqQAAZmnQwv7ngOMkzqZ4wHms5zLGgLOAbSJYNS
	 Tl3S94M6HaTnaVlxNaTmsfJyWeTPXHE/uw594VCa8GDAkNl4tSQpn5qBF2JepMwhNn
	 oRwvWxljyF3daw5W2Kognu8feng7ab/c81HdYfTnVhaM/4fUg3MSEY0WNUI5KFFhhO
	 lwH6nZFHCOSEg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Florian Westphal <fw@strlen.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] netfilter: ebtables: zero chainstack array
Date: Wed, 15 Jul 2026 17:31:46 -0400
Message-ID: <20260715213146.296837-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715213146.296837-1-sashal@kernel.org>
References: <2026071335-dolly-tinwork-7a6f@gregkh>
 <20260715213146.296837-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Westphal <fw@strlen.de>

[ Upstream commit cbfe53599eebffd188938ab6774cc41794f6f9d5 ]

sashiko reports:
 looking at ebtables table
 translation, could a sparse cpu_possible_mask lead to an uninitialized pointer
 free?

 If cpu_possible_mask is sparse (for example, CPU 0 and CPU 2 are possible,
 but CPU 1 is not), the allocation loop skips CPU 1. If vmalloc_node() fails at
 CPU 2, the cleanup loop will blindly decrement and call vfree() on
 newinfo->chainstack[1].

Not a real-world bug, such allocation isn't expected to fail
in the first place.

Cc: stable@vger.kernel.org
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bridge/netfilter/ebtables.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
index 075387678f8228..355c11b4068374 100644
--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -881,8 +881,7 @@ static int translate_table(struct net *net, const char *name,
 		 * if an error occurs
 		 */
 		newinfo->chainstack =
-			vmalloc_array(nr_cpu_ids,
-				      sizeof(*(newinfo->chainstack)));
+			vcalloc(nr_cpu_ids, sizeof(*(newinfo->chainstack)));
 		if (!newinfo->chainstack)
 			return -ENOMEM;
 		for_each_possible_cpu(i) {
-- 
2.53.0

