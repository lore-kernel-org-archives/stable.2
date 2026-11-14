Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794670954;
	b=2vzBt96icTKdfDcbCH1ApyOMTzh1jqIvT9wsK7WQ5cXHVde/bPlDEPx3zt5zLWCZu1zt
	 cAgQXEnb6UCsWiGsoiM/i9Cx1ljVV2w6qkdlbomcp5Vyo9+dBzto8W2E9s8Imff8XyqmR
	 zzIQF8dDuNNou7yRCadBQ6w1OJcoY832S+Y7IajuOLUucc0OnM16jvxsBqMoL2AJS10iL
	 jAu8IImEzqdeGI65g707UVciHmYAdCCHajVJKFae2Fp91SQZc0saF/wCETvJ+sfrI0sAP
	 vxxZgn17tkFE4sncEvgQ0lagR9z/5pNYrAt6SffHHhP3QumlB3KnZ6HQVNVVucZLgyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794670954;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vtnm88Qw26gzpcN4DdofOecT2p+CTJuk9agVfJYL+i0=;
	b=MnOE1CuEVojQNeMA18/j7jHJTReywdaDVmOhaOf9Yd7M6p1otkx1gmZ6lSQVDDj8Pm4b
	 tjm8uM2DNlsmoo10PKodPaBSvduC3IbkxHxCPNmZqr6YLoJGiA6TtecalvN+mTQu48rx6
	 mh9g0HT7n2Os+eX85bNzhCDYEcQB/G9m2QSMQSJbvzuzuEMFwTsF1zuul6+2fPfrWURux
	 3XuyfLeG1BlM1jkdzSujNCLk2cE0ulZrJ5/KnYzwDu2X0J3zvxn6Dp5UcFVT+EX0Rr1ic
	 HheeMTDqBQ9MtiyRf0eKSCnT3atxaTlig/XmerOYGBG9DGP2JF1Vu6YbqAcZ6b1Wy2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MtGUXzmW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94985606A323
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 15:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MtGUXzmW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 785031F000C4;
	Sat, 14 Nov 2026 15:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794670954;
	bh=vtnm88Qw26gzpcN4DdofOecT2p+CTJuk9agVfJYL+i0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MtGUXzmWCcjoM1B1pUetKYr9U9sk3dhbfP/kIJCldouUmjW9QLrTTEgWEXizddwMz
	 q//lTPKluydRpyCtNKfWnNfZE6W9V+rx3fXpbdMvee+ZOZNoa57WGysPqRD92ucHgA
	 nIwGqlGrmS569iYVP33ijU5Fc926LS+vZGBy9DBhO0ADS/RU+LALysKpiokkkK0yXS
	 dyg4YT2we0RVinSuCHVb7pydCwT3CJI5ts8yb300V4/3gT+AxANPVdrTGbVaBV181m
	 BIJ6uRDiIXf33qr9PyqyjsJl3ogws9gBU9EppKIEftU2/nKgjxDi3uvogzg1rNO4m8
	 yZFsduFT+tU9w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jann Horn <jannh@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] mm: document mmu_notifier_invalidate_range_start_nonblock()
Date: Sat, 14 Nov 2026 10:42:31 -0500
Message-ID: <20261114154209.3700331-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202809-failed-5.10-6d65925777ec@kernel.org>
References: <20261109202809-failed-5.10-6d65925777ec@kernel.org>
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

From: Jann Horn <jannh@google.com>

[ Upstream commit 7ced098fcfe596feab3cea4f40128b0119c7bf1a ]

Document what mmu_notifier_invalidate_range_start_nonblock() is for.  Also
add a __must_check annotation to signal that callers must bail out if a
notifier vetoes the operation.

Link: https://lkml.kernel.org/r/20230918201832.265108-1-jannh@google.com
Signed-off-by: Jann Horn <jannh@google.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Alistair Popple <apopple@nvidia.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 6d65925777ec ("mm/mmu_notifier: finish non-blocking interval invalidation on error")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/mmu_notifier.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
index 1a6a9eb6d3fac..0346fffecb6c6 100644
--- a/include/linux/mmu_notifier.h
+++ b/include/linux/mmu_notifier.h
@@ -455,7 +455,14 @@ mmu_notifier_invalidate_range_start(struct mmu_notifier_range *range)
 	lock_map_release(&__mmu_notifier_invalidate_range_start_map);
 }
 
-static inline int
+/*
+ * This version of mmu_notifier_invalidate_range_start() avoids blocking, but it
+ * can return an error if a notifier can't proceed without blocking, in which
+ * case you're not allowed to modify PTEs in the specified range.
+ *
+ * This is mainly intended for OOM handling.
+ */
+static inline int __must_check
 mmu_notifier_invalidate_range_start_nonblock(struct mmu_notifier_range *range)
 {
 	int ret = 0;
-- 
2.53.0

