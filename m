Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794906139;
	b=cAZfYrj0Gvz5+60ay9bAF+RP7I6MQnyIRMOFzY8nYDGSUlsafZDJscnzbnsegE647z1U
	 goBIUGLbKSO73P68ViyktSJFwLSibX3e4FtdsVrTHqDdcPwrazP5ZkqUn0Qg/KXSRg+l/
	 NYBWcIW9Ww2bRdPZFjwEFgPt5ak8PBmAZZVdQ5LVv4b38oIfkYZ+74d2Fv4MJ8DHBozsv
	 UvyWfXAxzVclzWe2nKCNaARVuBUHCIhd7NBYlrFskHAIzNTIDHSQJUgVjhYRqWRnqCQoB
	 5lQZNZ5YIyju+p1WA79G98myy5SoX5NLxNKb7hfowEZbQUY1raJC+K9KVvw1sdkg0Gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794906139;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Oc7JaEjK7wSuv1BcORZ/w1L9V0je8YNCe6SbYieskA0=;
	b=M3yQws3LGj1d0ARoklp9y8qwDna/dzl/Tzu2W3e+H7I8jqDfbTCV1NJCSaTUSfpmjW+A
	 f8L8OEvgmYrxJnsoSTGCspfIdZB4YgxPZC9rSzY4NQImP8Y5MLHfICnTGnFb+lSC6q1+Z
	 4+v1WHVv4PD5/9Uw2ek4uO0SqT3Ac3C/X9PVb30BkWOuY3OiPq707hqUsxTDdtfsR0gZ3
	 sRf4axWOD+UZD4S5OfvESgazoI/WBoBbfxcLbwKUAw8+bF87GT5bkGDt53OWLfsfOsiEY
	 9W+w2Ssb+ya6976YRD6MYVKyZ2h+S6WNId3rt2YiubX/PGbTdeTLgeuMTatksgQsvXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J3d5D6n6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B17B606A329;
	Tue, 17 Nov 2026 09:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J3d5D6n6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C10D1F000C4;
	Tue, 17 Nov 2026 09:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794906138;
	bh=Oc7JaEjK7wSuv1BcORZ/w1L9V0je8YNCe6SbYieskA0=;
	h=From:To:Cc:Subject:Date;
	b=J3d5D6n6QVbrWgy7xyIl+z6FZghP6lKKgRSkK+w7+ZqUYCDnYlpEp7G3lSlP+TE8Q
	 NmYk9iGSBX7AV1dF+gospoTwm6GS+1OQfjebtA3LQl8XY6Qvs10sHrLGTCzEjIt8EM
	 9VD/SAORPr7yoW8RRm/CwErAWBrWnKFdtkKzeSL9NS4k/Rz+NqZz2S7zMOYACCdfhv
	 u0gHk86ion/xeM91zVqs5Mdx0XLNBgHrmRWiOmoKLQxaaTlVTEJfIAjRikeHZ7+p/6
	 Sdd3q9RMOlI1z87BuESCTPo7u9JG3XvFOFFKDgDcmnsqNSilCmCXEktxQpXWmoEml0
	 K/UgtZiSTvmZg==
From: Philipp Stanner <phasta@kernel.org>
To: Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Philipp Stanner <phasta@kernel.org>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Chris Wilson <chris@chris-wilson.co.uk>,
	Danilo Krummrich <dakr@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	Alice Ryhl <aliceryhl@google.com>,
	Daniel Almeida <daniel.almeida@collabora.com>
Cc: linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] dma-buf/dma-fence: Prevent misordering for error checks
Date: Tue, 17 Nov 2026 10:01:45 +0100
Message-ID: <20261117090144.581909-2-phasta@kernel.org>
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
dma_fence_signal(f); // <- Takes lock, which orders against the above.

// Thread B
if (dma_fence_is_signaled(f)) // <- Does test_bit(), no ordering.
	pr_info("err: %i\n", f->error); // <- Can be loaded first.

There is no memory ordering between reading of the signaled-bit and
reading of the error code. This can result in outdated, wrong error
codes being evaluated by the user.

Though dma_fence_get_status() does take the fence lock, it is equally
broken because the misordering can simply happen within the critical
section.

It's not entirely clear since when this bug exists, but at least since
dma_fence_get_status() was added, which is why its birth commit is
marked as the Fixes commit here.

Ensure ordering for everyone evaluating the error code centrally by
using test_bit_acquire() in dma_fence_test_signaled_flag().

Cc: stable@vger.kernel.org
Fixes: d6c99f4bf093 ("dma-fence: Wrap querying the fence->status")
Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
Changes since the RFC:
  - Order with test_bit_acquire(). (Gary)
  - ^ also makes it easy to backport this for now.
  - Try to document roughly what is even going on.
---
 include/linux/dma-fence.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
index dd07d128adc3..a8d23fed70b9 100644
--- a/include/linux/dma-fence.h
+++ b/include/linux/dma-fence.h
@@ -496,7 +496,16 @@ const char __rcu *dma_fence_timeline_name(struct dma_fence *fence);
 static inline bool
 dma_fence_test_signaled_flag(struct dma_fence *fence)
 {
-	return test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags);
+	// Best-effort ordering of the locklessly evaluated signaled-bit,
+	// especially so that reads of fence->error are not misordered.
+	//
+	// The release counterpart is typically ensured like this:
+	//   a) Error codes must only be set before a fence signals and
+	//   b) The fence's spinlock's barriers effective in dma_fence_signal()
+	//      ensure ordering.
+	//   c) For users of dma_fence_signal_locked(), the barrier implied in
+	//      test_and_set_bit() should do the trick.
+	return test_bit_acquire(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags);
 }
 
 /**
-- 
2.56.0

