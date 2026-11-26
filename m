Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795713675;
	b=c0/OCA4lDkMWydwfg1m0lC1E6gH6NCcdd11pJv9hO9Pwk+iSyCThP1Atbk1PuoxYVOBu
	 kB47UQJWCkfXfsGBF+3ebK+ntHOjV8Zodr7Y4nTGRoflG0Xnf0ySailSDVsxdRkqoSJ+T
	 as5KG6W3mQ0z9jPJWyYM3uGQRN/hZqFgb33NNovhjMidoIyW84K/YzEICOFxsjIXFJ3vB
	 +I8MM+TjcFhWsGwtF2ZvvNQUob0LAmUnNITThueGqfHlVIdoBUqTAXSdmpamQ1ZwBh3uD
	 pFhrs0X3N7F+CMW0f4Ycf9desAnX2gR9a0x/BRSsLNY0kUrHKDJ9EOIhMSWbsfaV1hA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795713675;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=84lfspAujxWatUK6nKbRCWveeDZXMspVq2UyqNuKz60=;
	b=Jj2u8YhIfFfeYHQ6Yw8YjSbB76IurCALneqYu7sm3uT0ss6sBGJNpdZhafuQcJOtAuOA
	 T+PHMiiVGVdGgM+tdsAIST1LNLzGev2LJe779mISFxRXMsium+f8c2sHdbDFUGAfekbyv
	 bmABzZ5+QE2pjCLAkrtAyZ+5PZ5HYV8lnAqoKVlU7qum7jeoIO6G/4sfiVmq7QNVQ89Zi
	 GEzuCYpY6BfJXPGHSoyiP/N0qEG6IrlCWH7J8V9WkRHZUYR8VfMmWtP50Tv/X7LFJVq1M
	 sot8ouzqlfWChq3UgK3GLzXv/vImqCZDNrqMamdul1FqVU5DDrxN/vuk7kqxUGtVN/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RSb3dD0F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EFF606A31E;
	Thu, 26 Nov 2026 17:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RSb3dD0F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04F6A1F000C4;
	Thu, 26 Nov 2026 17:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795713674;
	bh=84lfspAujxWatUK6nKbRCWveeDZXMspVq2UyqNuKz60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RSb3dD0FYkKYzmj+j0RNPHk6jGetS4tHhO4QV/aNGksxYSQ/gxNul5VsT7CxSj27a
	 bbhDrvUnW8wVrwmjHsFTJT7M3owq2ohkLtfoaBv8rkiOwnQXL4nJgkmOEFynVbZGK1
	 3/lSmoaFA5poNXLmPXMRIFR45di+UwQ7lZK9Yk8o8swkQ3+SEK+dQp0c+AGXg7/m7K
	 Mgh8wobwFMzaPbwuQNBrYYu1fo87vb+WL3wVlkT/tT/nNd3KL6h+VYkmpaWOqkr4tZ
	 yWI+r7K2DpSq/QUMvbnXKWr1AWYxqJBGxCryUwT8xUS4jKbw5pKmRb9atdvkxehWBE
	 F9xkQmE++Kd7Q==
From: Philipp Stanner <phasta@kernel.org>
To: Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Philipp Stanner <phasta@kernel.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Matthew Brost <matthew.brost@intel.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
	Gustavo Padovan <gustavo.padovan@collabora.com>,
	Chris Wilson <chris@chris-wilson.co.uk>,
	Luben Tuikov <ltuikov89@gmail.com>,
	Shashank Sharma <shashank.sharma@amd.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Gary Guo <gary@garyguo.net>
Cc: linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org,
	stable@vger.kernel.org
Subject: [PATCH 1/3] dma-buf: dma-fence: Hot-fix timestamp misordering
Date: Thu, 26 Nov 2026 18:20:45 +0100
Message-ID: <20261126172046.2473303-3-phasta@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261126172046.2473303-2-phasta@kernel.org>
References: <20261126172046.2473303-2-phasta@kernel.org>
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

fence timestamps can be written and read without any memory ordering
since, presumably, forever. This can cause real bugs, other than false
accounting, for parties whose algorithms depend on the timestamp.

Hot-fix the problem for now so that it can be backported until we found
a suitable way forward for mainline.

Cc: stable@vger.kernel.org
Fixes: 76250f2b743b ("dma-buf/fence: Avoid use of uninitialised timestamp")
Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/dma-buf/dma-fence.c | 9 +++++++++
 include/linux/dma-fence.h   | 8 ++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index bd58688b81a7..8a842fc8168f 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -378,6 +378,15 @@ void dma_fence_signal_timestamp_locked(struct dma_fence *fence,
 	list_replace(&fence->cb_list, &cb_list);
 
 	fence->timestamp = timestamp;
+	/*
+	 * TODO:
+	 * This is a temporary hotfix to prevent misordering until we
+	 * can completely remove the TIMESTAMP bit.
+	 *
+	 * The counterpart of this barrier are the test_bit_acquire()s in
+	 * dma_fence_timestamp().
+	 */
+	smp_mb__before_atomic();
 	set_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &fence->flags);
 
 	list_for_each_entry_safe(cur, tmp, &cb_list, node) {
diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
index 64330bf52561..6b16095e8521 100644
--- a/include/linux/dma-fence.h
+++ b/include/linux/dma-fence.h
@@ -715,10 +715,14 @@ static inline void dma_fence_set_error(struct dma_fence *fence,
  */
 static inline ktime_t dma_fence_timestamp(struct dma_fence *fence)
 {
-	if (WARN_ON(!test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags)))
+	/*
+	 * The test_bit_acquire() calls order against the
+	 * smp_mb__before_atomic() in dma_fence_signal_timestamp_locked().
+	 */
+	if (WARN_ON(!test_bit_acquire(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags)))
 		return ktime_get();
 
-	while (!test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &fence->flags))
+	while (!test_bit_acquire(DMA_FENCE_FLAG_TIMESTAMP_BIT, &fence->flags))
 		cpu_relax();
 
 	return fence->timestamp;
-- 
2.56.0

