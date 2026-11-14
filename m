Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794669608;
	b=EmmzfMwt9rQl7CnyJ6X2EtU4bfqcrKsw7lRcmWYUSvwdNE4YGs21GdeyTBA0V7c9rWSu
	 ot4+2qtG4+U0mgiPyVHBbyvnf1RatC0D+mI2c7t8P9gNgkhmN1sGJDSQudpiNWqKnSnmT
	 rDdBbSdLTrbp7D/bu+Mry9/0ii6oby80TbJ4qthole4PKU+VL52JHu/IRISDEG1VL1U16
	 n5BwqjmaCfVdRaG5rEsrzyGia5FAwuz0/p43Qz4yxIUOFXicMuPibh5VpxcZrTfg7erg4
	 bQ9xsDnojNRSUSalFTmeIGFn1cEGU6MTLab9tU9c9x3SnP1xOn7Xq5WrbPaoGDqVScg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794669608;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=RB0eVZI0IAkxxo/TqcpAKNe2JB7Btnmplse9cg/XHZw=;
	b=GOOCFuWKrc1ZdSci+nu3rHZcjcyulxBbzB+GbZuGyxpVf9e+hKpYQhMz87zIreZ1vJyp
	 RK0bU1d7Ee6vmJnEzZP9w7tg6lIO7WSyuewO7RJNKFlf4seLvPCqGutGJdXIYzhnE81Fy
	 d5nNKF/+CYkre6nO16TyW5npxotP9LYCdHzXbfARCVdi2/Q4lANkPNf5oj1Fyu9I3xBwM
	 G9NazBBb+Uys98of/7JS/UqFe+CBvDYvsMvWhTwavz+l7yYorj/P8fnJsWzvx9Nv7zdkr
	 skl2Fkv6heh8jIlT6GxE4SgQN24uQ1L/uIun+DifT/s61FnTnWgltCAktFjmyD1U/OA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O3kJNzhA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AB1606A323
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 15:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O3kJNzhA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FDAC1F000C4;
	Sat, 14 Nov 2026 15:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794669608;
	bh=RB0eVZI0IAkxxo/TqcpAKNe2JB7Btnmplse9cg/XHZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O3kJNzhABMjtsu0+Kg0+lEcvYE16z5impGn3pTagnNu9CanN8gGFCBPRpeQF9Nb6z
	 iWAUGiYSPmvjZmqQye6a0PpTeOZ7Sg/uIDt40qeRYNwnr2q7H4KHs9n2itgA/7TuN6
	 AC+JKHi4s67Tth4oQXioFouWZPOL3C0hdDNgddnhUE5bU3sQYW8C6r/+lSPZma7YSV
	 h2UmlByCj3iUFPCHfO3vJYOgW0tGsEetkdGKw1a5FEizZvkf1O2NdpJKysCrFNrVmZ
	 99FLlEVAwed6/aF/V5o8rxz7cv91dbYW+zybl4W5IQ8qKqtreNyflDKflSLsdwr3cj
	 L/BbU13CNVCKg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jann Horn <jannh@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] mm: document mmu_notifier_invalidate_range_start_nonblock()
Date: Sat, 14 Nov 2026 10:20:05 -0500
Message-ID: <20261114151943.3437554-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201336-failed-6.6-6d65925777ec@kernel.org>
References: <20261109201336-failed-6.6-6d65925777ec@kernel.org>
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
index 6e3c857606f19..f349e08a9dfe1 100644
--- a/include/linux/mmu_notifier.h
+++ b/include/linux/mmu_notifier.h
@@ -459,7 +459,14 @@ mmu_notifier_invalidate_range_start(struct mmu_notifier_range *range)
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

