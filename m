Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795774814;
	b=bpySgLxKnG0c7UVe72phbLF8Ul4Tk2CAl5lIdDOS369rBY0I4M7Kz1mkBb/sYx5wW+Ak
	 laYycNnSkuzUaUWsjfs+oQAuC+GW3hpPOCkANCJzKorxRAK8ym1j2zN1OUlca50WKPKha
	 8TsvZU1sXYA/r/4bZ0olNazRrjG634cCq1QJ+YkXc8rx8HrL8y8CyJ8X1KRc0FJbntdZQ
	 GZpPNmdbshSCYELyg9srQqJPAG8G1yERjCmXbL0ANvPjpyEU4veFsE4rTlPmYatJYVvCE
	 271tRAcRwzf4Q1lvIuH/QGoJfX6ERkacddb4lUMdiE096i8UiXTpENRcAbV1g6YVaKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795774814;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=XI3Ciojegmg/QsrFpxinInDHofGcD7fIKLbZkFqR/PQ=;
	b=lt94j2ZeQj1n61A1WRndMp0WzWvlmjxYB4Gs2saev/CmVZtZjj/GL/n/DIxloHDGS1AB
	 MpIqwSNpzeDoBDk5Re1ii8V/FVLqwfGUoODPoGvpgovhK4f1lowSBmjHoDXv4D+M5giw/
	 ibJH12xBktM3c/R6cUNzoEELWBgkmU/G5n+Xt9D33QlIKX/l3uPcCIgNuHKmfW2E/m83e
	 BLOeXiRNfgZy4mJaoEXf8mU8zBFRBLN41DuiZmQdECRfLm6jf4H9FLc3pWp3tLZgpF+Az
	 zU8l4uCXp0NbBmsK0fLauiVN89EV3sk3Gq8326ufb3nHvZn1TY9dLo0Z2ueSA0pMZhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MmervoqU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1976B606A333;
	Fri, 27 Nov 2026 10:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MmervoqU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 275C71F0089C;
	Fri, 27 Nov 2026 10:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795774813;
	bh=XI3Ciojegmg/QsrFpxinInDHofGcD7fIKLbZkFqR/PQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MmervoqUHQk0VUJjxSYhBuuxIjh9jrBirotCelf3jTtksXovAh69mywN9cYOGvUIu
	 xLEh6swQxxHQT0E+PgC5PohVoROJ5pa0JMx3+UDm434gGgNEe53FbZOwNloNccAhu4
	 McRiZRnq/2ZUI8mGGaROetEEh2dCVmuCIof6g0FiWxDwR2+P4AgwyEmhD6/jQCHjqv
	 etFFCrDJNZtQCldlnE3MgINssosYZdOl/y08MBIheHEh191csDK2BJC51jSVKmC4DA
	 awesNlhphz0ISq4+6W/uNHFoL9g9stY+sP3AIohY9wL36Y3bpANgU6UOTl75b0wMXA
	 +TFG56Y2nBSug==
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
Subject: [RFC PATCH 2/8] drm/sched: Hot-fix timestamp misordering
Date: Fri, 27 Nov 2026 11:18:07 +0100
Message-ID: <20261127101812.2706432-4-phasta@kernel.org>
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

dma_fence timestamps could so far be written and read without any memory
ordering, a bug that presumably got overlooked because x86 is strongly
ordered.

Hot-fix the scheduler's manual timestamp evaluation until we found a
more suitable solution for mainline linux.

Cc: stable@vger.kernel.org
Fixes: f7fe64ad0f22 ("drm/sched: Split free_job into own work item")
Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/gpu/drm/scheduler/sched_main.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 85a49e219837..44553db9b04c 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -928,8 +928,16 @@ drm_sched_get_finished_job(struct drm_gpu_scheduler *sched)
 		next = list_first_entry_or_null(&sched->pending_list,
 						typeof(*next), list);
 		if (next) {
-			/* make the scheduled timestamp more accurate */
-			if (test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT,
+			/* Make the scheduled timestamp more accurate.
+			 *
+			 * TODO
+			 * The test_bit_acquire() is a hotfix against timestamp
+			 * misordering. Replace it with something better.
+			 *
+			 * The counter-part of the barrier is located in
+			 * dma_fence_signal_timestamp_locked().
+			 */
+			if (test_bit_acquire(DMA_FENCE_FLAG_TIMESTAMP_BIT,
 				     &next->s_fence->scheduled.flags))
 				next->s_fence->scheduled.timestamp =
 					dma_fence_timestamp(&job->s_fence->finished);
-- 
2.56.0

