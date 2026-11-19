Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795084908;
	b=A8bl7U8GVMPQZOkPlCZvgx229f8Zu7SE9OFIk1qkPGHCxAdM5vLFyL6b5/Psx1snJpJ3
	 OQPGVl6hxAeHFFX36xUNgweCcQJgIHJ/BJmozVBdObbZxPoxwOP0cQfwrIWVDncxzT25R
	 IR+0dQTaFcLmsUOvGd+RChBeZ4Cmq4PRMMMB4Wh454KrIVZp+wi0WlobKdeDfNHOAIg2X
	 CCtzDXCjnO71A4BkvgKBbUoXriqSLJlwYgN07y8XoGXRZjxHnkiEkMluhf79CiStUjny+
	 qwJk/cSzSbJhEPk8i4cPaLYy3vs3IKrKyt1lngZjf6aSO3u66YlVQg3nfxZeETz7MLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795084908;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=uy4T6cflb/kJniJb1PNJJOnjjLFYntgpduBnhf88Gok=;
	b=LQ1Ysf+zppzhbX2Ux0Cr1YedQiojN361RGpdXMwxpXHTF9rOrxX2iOazGHBk2uFtXrWU
	 RH20JwpQ9qgKjfvJNmVpdU/vmhH3FjeL/1whS8CXth8jd3dry9TW5Mo+sNO3pLmp7zwub
	 BpeU5THh9oAGDAuSv6GJWb8jmmGNRovb9SMm6J+iUPvr8P3A2XMEgIU+5kXID7GImMxc+
	 eOwt2xwqq/q8/p9e1ODBwKT1mpMykZ5Fxk04DvboMCS7VRO3zXUeklQx+7OD3uvIzc/Qu
	 sjlJQI2mscFSjlY/2DskZdHOYdrtYjCd4ztyeOObS+QlKerY9KB2s7YRBcP6fggWwqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G6Wo7S5b;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F20460A260C;
	Thu, 19 Nov 2026 10:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G6Wo7S5b
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 923E81F000C5;
	Thu, 19 Nov 2026 10:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795084907;
	bh=uy4T6cflb/kJniJb1PNJJOnjjLFYntgpduBnhf88Gok=;
	h=From:To:Cc:Subject:Date;
	b=G6Wo7S5bfZhjooeJEaaMz0fss3LMl2nOfy//f10m0ddx5ycM/w0jmulc3fnnB5fa+
	 VtEecDTv/nTmi5zaM+/edchvkq8k4+IgmvY07o5Gk5+XxlK9xOc3J6xRy0v2/p2cdE
	 kjYM753TkVL9k7X5Cq8UNriGpr+Dwn8mRPsK4zfUwDDZ/RFs3oFeMspjaIx0oVITwW
	 LtS314m1mppUWh8a5efSoFX46wO9DcLxvq+bJat7LQqgAujNQ+zsllWiIHrZEderAn
	 aYJYVIwaggNJ+dRnDT7d+sDINkEZHnnHior8dcTJBVkCH5PPxNealu9y9rlBmyXLN1
	 BcoZSoGdCTkyw==
From: Philipp Stanner <phasta@kernel.org>
To: Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Philipp Stanner <phasta@kernel.org>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Chris Wilson <chris@chris-wilson.co.uk>,
	Danilo Krummrich <dakr@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	Alice Ryhl <aliceryhl@google.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3] dma-buf/dma-fence: Prevent misordering for error checks
Date: Thu, 19 Nov 2026 11:40:32 +0100
Message-ID: <20261119104030.2381685-3-phasta@kernel.org>
X-Mailer: git-send-email 2.56.0
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

Many users of dma_fence do things like:

// Thread A
dma_fence_set_error(f, -EINVAL);
dma_fence_signal(f); // <- test_and_set_bit() orders against the above.

// Thread B
if (dma_fence_is_signaled(f)) // <- Does test_bit(), no ordering.
	pr_info("err: %i\n", f->error); // <- Can be loaded first.

There is no memory ordering between reading of the signaled-bit and
reading of the error code. This can result in outdated, wrong error
codes being evaluated by the user. That's a significant bug when we
consider that fences' purpose is to propagate the state of jobs running
on hardware.

dma_fence_get_status() does take the fence lock, presumably to ensure
ordering, but it is broken, too, because the read misordering can simply
happen within the critical section.

It's not entirely clear since when this bug exists, but at least since
dma_fence_get_status() was added, which is why its birth commit is
marked as the Fixes commit here.

Ensure ordering for everyone evaluating the error code centrally by
using test_bit_acquire() in dma_fence_test_signaled_flag().

Cc: stable@vger.kernel.org
Fixes: d6c99f4bf093 ("dma-fence: Wrap querying the fence->status")
Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
Let's go with Gary's proposal for now, and have this patch here remain
simple so that it can be trivially be backported, since this is a
severe potential bug.

Changes in v3:
  - Be more precise in code comments and commit message about how the
    ordering works. (Gary)
  - Update the function's documentation to inform about ordering
    semantics.
---
 include/linux/dma-fence.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
index dd07d128adc3..a41b9a7792e1 100644
--- a/include/linux/dma-fence.h
+++ b/include/linux/dma-fence.h
@@ -487,16 +487,20 @@ const char __rcu *dma_fence_timeline_name(struct dma_fence *fence);
  * with the fence in any way. The user must, therefore, ensure through other
  * means that fences get signaled eventually.
  *
- * This function uses test_bit(), which is thread-safe. Naturally, this function
- * should be used opportunistically; a fence could get signaled at any moment
- * after the check is done.
+ * This function provides acquire ordering. This means that all stores
+ * preceding signaling a fence are visible in correct order to users of this
+ * function.
  *
  * Return: true if signaled, false otherwise.
  */
 static inline bool
 dma_fence_test_signaled_flag(struct dma_fence *fence)
 {
-	return test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags);
+	/*
+	 * The release counterpart is the test_and_set_bit() in
+	 * dma_fence_signal_timestamp_locked().
+	 */
+	return test_bit_acquire(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags);
 }
 
 /**
-- 
2.56.0

