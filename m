Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62F8353A70
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 23:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789083594; cv=none; b=aBHhXWCXBAg3pdy7wPf3nnioFw5RevOHyKK8PK5uGaIkBZqY4a1PHWWppyqQoIq0jrp5d60tGoOCHgHI0pT38PZIVQgvt21CPXu8ljoGKOyMk3BYZJgAqtWUOXFQFTxnBCYja3WKv9zvX0TAK7ddeumEqpObqIl0dnOf1bssONw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789083594; c=relaxed/simple;
	bh=Nc/5x/bAdaU9MK5j5+WOLbyTWQjuo/aO5y7fpkjyeMw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mPBpQDrrQufGAWkIvFXqW3LxKEIaB0+QB6YQYSnVPPfK2kFyrRZCqEkYf634+2d2pJyzJVAI8cBLx5Mbpi8sJnqGZvl6CxMz0CPA5KvjHwX2o2i7oMCLILzp8DcQBOrcGflRVpEiFSfydo+bDZLPxYcEbFmcMu5UaWraXiU8UEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F0C1F000FF;
	Thu, 10 Sep 2026 23:39:52 +0000 (UTC)
From: Andi Shyti <andi@zenone.zhora.eu>
To: intel-gfx <intel-gfx@lists.freedesktop.org>,
	dri-devel <dri-devel@lists.freedesktop.org>
Cc: linux-stable <stable@vger.kernel.org>,
	Chris Wilson <chris.p.wilson@linux.intel.com>,
	Dmitriy Okunev <dokunevdmitriy@gmail.com>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>
Subject: [PATCH] drm: i915: fix sizeof argument in reset_csb_pointers
Date: Fri, 11 Sep 2026 01:37:10 +0200
Message-ID: <20260910233711.2528459-1-andi@zenone.zhora.eu>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dmitriy Okunev <dokunevdmitriy@gmail.com>

In reset_csb_pointers(), drm_clflush_virt_range() is called with a size
calculated using sizeof(execlists->csb_status), which returns the size
of the pointer rather than the size of the object it points to. This
could lead to incomplete cache flushing on 32-bit systems where pointer
size differs from u64.

Replace sizeof(execlists->csb_status) with
sizeof(*execlists->csb_status).

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: dc0406820ee7 ("drm/i915/gt: Drop invalidate_csb_entries")
Signed-off-by: Dmitriy Okunev <dokunevdmitriy@gmail.com>
Cc: <stable@vger.kernel.org> # v5.19+
---
 drivers/gpu/drm/i915/gt/intel_execlists_submission.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_execlists_submission.c b/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
index e693b0c9d2a3..9ac67a0cbb1f 100644
--- a/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
+++ b/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
@@ -2833,7 +2833,7 @@ static void reset_csb_pointers(struct intel_engine_cs *engine)
 	memset(execlists->csb_status, -1, (reset_value + 1) * sizeof(u64));
 	drm_clflush_virt_range(execlists->csb_status,
 			       execlists->csb_size *
-			       sizeof(execlists->csb_status));
+			       sizeof(*execlists->csb_status));
 
 	/* Once more for luck and our trusty paranoia */
 	ENGINE_WRITE(engine, RING_CONTEXT_STATUS_PTR,
-- 
2.55.0

