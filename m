Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795774807;
	b=1Uoja+MqoivnL/+kbK5QgARnxTDwc7k6ndKi83uPMX0slmVS6tcBnlOgYcHFHlNPhUY2
	 ttw0WPhuBuiObMHwUsE5m7Z/i6BYxVyjZcBRKaW7wI5+sNvzQK4c2UMOYR00cYEOmoYsd
	 GwHIS9jfKbLqQSiqTGBX8x3X3MvtFOUcrYkKj/6+G91ExRu2KVfRxxTXQYUjwI1TyY1so
	 sTdIZWT1Fid8EiSoDBt8cUIRF9i9tJl47j+Y+B/IaWLqvpJKmUoA0uQ0L7MEo5bGyDqQY
	 k6Ugm/9QQvTWnPQLcEXz8eL8JgL4tlaQiFWkJresnO1GYatYVAMhyR2aOLlUmOBQkhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795774807;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=yrYR0q6nUuvJ4hHyNfVgv3yvODscAW5Pi/E+MKFC5So=;
	b=3lw24RFrqyjEh0GjZUeVVLgSH7QisyTGg7OfW7gqb8t5PK8q0FfzrKQ3pykGC3eb6lM/
	 ZFlAIYNaQCJgFApN6mHDUqvqQS4NW+XRWyS1HgfDI8WQX/bf/kf3xjiNpfyjT0c0jMSV+
	 he8jzklmPCXDyvXq7mNBsitmBOXg8yJC2slFtYu0Vx9B/ud6nsAqMCedEUyqSdPI2HR/G
	 7lCTRjWexs0SBepn/4YlXXPLOyvx36U2elU91EgafVSDYJh/S1Y30Kt7+RcRi+ACzx+XW
	 tL/sruoTk5VjI1DkFL1aS0HMVwmF0pBF7Eow/cy3zYcc2j9veIL8qOKxWC+Ul+1CsSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZLXVh0Ex;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7AA606A32F;
	Fri, 27 Nov 2026 10:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZLXVh0Ex
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 947621F0089F;
	Fri, 27 Nov 2026 10:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795774807;
	bh=yrYR0q6nUuvJ4hHyNfVgv3yvODscAW5Pi/E+MKFC5So=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZLXVh0Exjw6q+FG8YIJtriF3iMNMHk5Erd6SVVvQRDKyLIni5Fvy1slxdPIESCllT
	 f8s3LQ/5DMXB33otavzQpPTbBNAf5TQN46Bpj0iYPlob1k54gw0jKVXQQWejTPKi0u
	 lOi87lL40zXlXpihdYJSmIwbzTq9GEky4X2GOZHAFcetSdw62IsoT3HSYBvGdlDzjo
	 yiAgxKzBXnsGbLSIQOxSpX5mvn6H6Ymd4jMLac3SalR2VF0GO9Ru/SZ576OI/laHjl
	 AocSc7kT9FCAOobEAF6yGz8+BeRUi84Zs/C/0Pj2++ATr4TppeHzVykqD2yo+FwOT2
	 gw0oU3v78wnwQ==
From: Philipp Stanner <phasta@kernel.org>
To: Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Philipp Stanner <phasta@kernel.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Matthew Brost <matthew.brost@intel.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Ruslan Vagner <rusya92266@gmail.com>,
	Gustavo Padovan <gustavo.padovan@collabora.com>,
	Chris Wilson <chris@chris-wilson.co.uk>
Cc: linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	stable@vger.kernel.org
Subject: [RFC PATCH 1/8] dma-buf: dma-fence: Hot-fix timestamp misordering
Date: Fri, 27 Nov 2026 11:18:06 +0100
Message-ID: <20261127101812.2706432-3-phasta@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261127101812.2706432-2-phasta@kernel.org>
References: <20261127101812.2706432-2-phasta@kernel.org>
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
index ab02afdb0f18..c947aec1bf91 100644
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
index 513d9dbbff47..29c4332c8662 100644
--- a/include/linux/dma-fence.h
+++ b/include/linux/dma-fence.h
@@ -686,10 +686,14 @@ static inline void dma_fence_set_error(struct dma_fence *fence,
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

