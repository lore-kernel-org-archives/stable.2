Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795173394;
	b=YKVw+uwipdDraFwsZJhD2rLkSoVaZnlRk2IHv9diJh0qI2Ofv19rbwpfGRosOHoSyj0i
	 UFHhspHUfG38ylp9LAsJff39oL2lKFqS4gmmF8hCMQq7h/w6BHIo00SFdnHldqPAm7QDW
	 ER59yuAvW26s3qo+ALlpWr8/0ItSNqclUAqp/7T55IDk35JEkLocTDdfa8QokjoFC6bcN
	 90eTsz9Gd6DSbUjzAmYCPmY5ansEy8N+5Uctd5HUqCk6oeXBk+zfei9yiDnUk1pGs0e12
	 rp6zODIT814ko2ksU5+3c+MwgGlCxkrojQPBFD5z1l3v5BnezKRRF6Z8f35LCi6fEEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795173394;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=1rA97F5/npt/N9vCtRHW4c9+9dN2t8X2ZribjEzABLY=;
	b=KktHN+jyPoQVUNjhjvKcgvJEILldr1Ouj9XxQNRVnxmqQT4/4atXmqGYDlJ2HeG+a/Jl
	 U1O5ITe3e+OkEqeInfssGDwQy/zwDtgUchpkOQd25RoziGfmIWAJSTnOxdzEkLMgmufye
	 8663QPW75UkaAem5dgoN+rMdamB+bQdUabjuokMw69YD3Q7ki8PJm014VxRmopqTKWnr4
	 rzxClIm/mzYNQ4SlA5EgNeB9THyHuE3kI+kcYMQCHlB0+RtQTasIWRRFG6biPcD+9EkZV
	 n2lB38tjeIFFIbQ3nYv14qCJcl86HwDb4PXdBo7N2Ta0KfBzLUsojsvjchN6717JFDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=luUsY8wS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E7A606A334;
	Fri, 20 Nov 2026 11:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=luUsY8wS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E411F000CA;
	Fri, 20 Nov 2026 11:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795173393;
	bh=1rA97F5/npt/N9vCtRHW4c9+9dN2t8X2ZribjEzABLY=;
	h=From:To:Cc:Subject:Date;
	b=luUsY8wSZU63nKy52IFDDfqhhiq+t+o+hbbc/+Gd5ufIEz12jspoREg0hXHaDM0g2
	 4vywmRiBQTJA9vtfNKZdpz/vBuQnEOMbD6wj4/QdQZAXihIoqmYtXdFWdonlCJ1TD1
	 WWZJcI4PnLlKrTiUOX+vl+u2U7jCCeMDWw5F2AsDs5RwFz15dHivHC2RoB75rJBw9N
	 gdOqhTarpq+gXjliwH93PoH5hpi3br5bYXk4lgcuOgxcptm8Twc+rtDvmJ1vN6pU3m
	 3TwCyECKZPZxWoO6scqt8iVrSMKu0aFfNJyF3SEsoD2FHnZSY83xIaM9CV1iMXhbWq
	 AjvfBKriIPurA==
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
Subject: [PATCH v4] dma-buf/dma-fence: Prevent misordering for error checks
Date: Fri, 20 Nov 2026 12:16:16 +0100
Message-ID: <20261120111615.2940647-2-phasta@kernel.org>
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
Changes in v4:
  - Keep the hint at the function being opportunistic. (Christian)

Changes in v3:
  - Be more precise in code comments and commit message about how the
    ordering works. (Gary)
  - Update the function's documentation to inform about ordering
    semantics.
---
 include/linux/dma-fence.h | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
index dd07d128adc3..64330bf52561 100644
--- a/include/linux/dma-fence.h
+++ b/include/linux/dma-fence.h
@@ -487,16 +487,23 @@ const char __rcu *dma_fence_timeline_name(struct dma_fence *fence);
  * with the fence in any way. The user must, therefore, ensure through other
  * means that fences get signaled eventually.
  *
- * This function uses test_bit(), which is thread-safe. Naturally, this function
- * should be used opportunistically; a fence could get signaled at any moment
- * after the check is done.
+ * Naturally, this function should be used opportunistically; a fence could get
+ * signaled at any moment after the check is done.
+ *
+ * This function provides acquire ordering. This means that all stores
+ * preceding the signaling of a fence are visible in correct order to users of
+ * this function.
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

