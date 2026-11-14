Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794670209;
	b=wT22kkdD2tgjVyfvT5bNqCkYcoSzOaJhnjkwyyClsNk3vooJS4XvvTxFZV/iibV3lkuG
	 xTrhJETyb0CXCrD9rmCHNCCyL4U+1q0e2C5QKv3jVi/S35OYV6Q0jN5WecKFF06cPXTFT
	 i9RS4gKBa4MBRLeRo2fYBh4XgyWz9SJm8G5lTGIDRntT/i79Eggcn7qUNVpkHPktg5QlY
	 Hi1twSaDexu9FDpZ8eK8J/Aw4od5hh9HkbF0W2fvggLYmJ1JezGIY8V8nqk83R1765AdD
	 9zG9x86B7Xc8tSn8PE2219elqOAzJ4NES5IauT0p03VojGFcCOAj/HC4p1xfagde+Zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794670209;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=56cliN4TQxqhSneJ/qvnavyy3hLIEsS8KDk9lKUC9/A=;
	b=Lmq1VQjv/6Ty2jNIPm1pNy04h7PUZxc0hZ2YpH8mXilqoykRzYnBgfAeFctUSi9lzq5F
	 +diSU4Hft5qREkZEBD3HbEssJ8EbnAYwP+pl1fLQ6IUNxAb8+0ti8Giowz1LlCUaXs29w
	 y3gHipmwihymsjkjFb7vAOC2JQVa2xntUd1U6zGwlVymEbbu+qEopqNuHl8VAhnUo+814
	 Ph82kAo6sngt1/BJ+A4i9LPn9UzKFimOiPWbIP4aSB4CBOTixy+aSzzgh+U8D7uY3CN7b
	 GoETW384toG1lzrbLuC+PVNixPTI9/Q5Ktm85tw/IIoaalcIWHhQxK+wUYhrV9gG6IA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YIHQIByb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D81606A329
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 15:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YIHQIByb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8650F1F000C5;
	Sat, 14 Nov 2026 15:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794670209;
	bh=56cliN4TQxqhSneJ/qvnavyy3hLIEsS8KDk9lKUC9/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YIHQIBybZF7zUvd8rCQ39NdzKqj0Jr8YR1cVAEV3GOi+KaiKiEc+gEhtkYfdbmS29
	 6tEwrVHmQWdZy/krr1OtU8dLMZLqiZldrxLlSebuynrjwAaMitzlbf7o/xLiarhAhw
	 ybBjfF3SIzcX6RKaSpAvVprCSQHrSonpsut5QBMHJicFw06JZT9+fkr3NIVNc9lVez
	 Ww4ppZjiS2fF/xS7HCLGKzrVPpYaMRyUXaVqiIdgS3e6HVqoW+bEDy/1+aGV+WFKNz
	 0TsPuZcYo9QGBLIwncixwnadBuQfXooJbMqjMg477tzzXi7Q3rj4w6NvL1SSHL0cOQ
	 JCUcGo7m5WXSA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jann Horn <jannh@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] mm: document mmu_notifier_invalidate_range_start_nonblock()
Date: Sat, 14 Nov 2026 10:30:06 -0500
Message-ID: <20261114152948.3648455-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201831-failed-6.1-6d65925777ec@kernel.org>
References: <20261109201831-failed-6.1-6d65925777ec@kernel.org>
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
index d6c06e1402771..7c81de8e381e2 100644
--- a/include/linux/mmu_notifier.h
+++ b/include/linux/mmu_notifier.h
@@ -461,7 +461,14 @@ mmu_notifier_invalidate_range_start(struct mmu_notifier_range *range)
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

