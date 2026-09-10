Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711A43914F8
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 14:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789051178; cv=none; b=Khny8XYFLtJHMP2jYPqOxdUkojlzqPzY2ySjFCSnirlxPcEwobPSx9KZ6gsYnPEyQIXDFkZ3dfT9CYN+wfjfr1aXfn/zumlq0VJDWD3ueaZtero9YiBI4KPthJ2Z7GLn7/LFu+jeX32tK7XGg0I029CISpNauLAVtyrdzMBrE5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789051178; c=relaxed/simple;
	bh=dPqkiHIVv5s5k5VvVSMbABgxj9gWDZDyBbcBBjpkI4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WhdQ2iIScUuEAe7BJdy5TNCdUxIu1saS9jS9dXBpRnGrFHoj+fg92GrXOpyLpQOzDcoAhZ7mVDFH5hA/yv9vGQYFa1l7VMsj9XWCqInLAwjTGIjqfm+2FNz7mvZ9zoINRT4AvlnBfD9EKtXuJ3B+TIdeCV0lgeYgsrkaK1IE3sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/HghQ+N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/HghQ+N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AD231F00899;
	Thu, 10 Sep 2026 14:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789051176;
	bh=eHCb8ZfpJrkwAtuJ2+dExFkFvREVl0LZFbf/lvxguLc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d/HghQ+NFZskffkHKX4VAYUcP5G0nX+30p1f6yCvciSInWJVXA9U8YfnZSHw8rrrU
	 byp8sQQ3OkT6ifFM74AqUeQSKXaPVVTE7tgF/Gx+wZPDHl7mdrCkQ2yd/jyYPZ7Ky5
	 Kit6mHs8L/r6zkDwJcLrbWaqJCbF3PGzoTIJVq8ddbsERWvptrvenY2GNNqlSNH3N9
	 7e7R/EduXqmbd+UugS53ly62BFRMVfiE6GQ0PWB+GeenJUbUE32nwRux+vR9xNIHbe
	 TXAkHL1q9aSM5TmbSp0AS5fRsTCbdKQRzRADuTwXKMCJYuvuR0EsFroG6GBNCXO3b3
	 +H8/lQg0bKX/A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Robin Murphy <robin.murphy@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 03/10] dma-direct: fail allocations that can't be made coherent
Date: Thu, 10 Sep 2026 10:39:24 -0400
Message-ID: <20260910143932.771351-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910143932.771351-1-sashal@kernel.org>
References: <2026090811-unwound-smuggler-adf1@gregkh>
 <20260910143932.771351-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 955f58f7406ad912825fc344c7825fd904b124a0 ]

If the architecture can't remap or set an address uncached there is no way
to fullfill a request for a coherent allocation.  Return NULL in that case.
Note that this case currently does not happen, so this is a theoretical
fixup and/or a preparation for eventually supporting platforms that
can't support coherent allocations with the generic code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Stable-dep-of: 94a04ad732c9 ("dma-direct: return struct page from dma_direct_alloc_from_pool()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/dma/direct.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 517ca0e61a57c..0d6467b6553b7 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -236,8 +236,9 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 				return dma_direct_alloc_from_pool(dev, size,
 						dma_handle, gfp);
 		} else {
-			if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED))
-				set_uncached = true;
+			if (!IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED))
+				return NULL;
+			set_uncached = true;
 		}
 	}
 
-- 
2.53.0

