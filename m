Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045803;
	b=UmYGbxdx1eeAEDV9w2kxNjYv0hpKlMYAe3V5uvMtD3+PGuJoVBR/Hdbba7FPTdpMsKBq
	 SVBhVWSX8N+z/65HdLmDTPCJVhSeCOx6t8081TKnnAaIGS81so4hXV4i7Pc/o0fK8R4LK
	 DrU9REyztF7afVuhaRXf+LucKY7Vs5CRxQjfoffZXAIyYNMnr0Q7G+ZGkMYjQvC2OYcvd
	 4nK7z70uZx9qYfhsbA8RzudlWv/LqSz5fXWFy/vHmPgrwTfI+W/ZjZT9K2Y2UobVqWMFh
	 YYpbxtf+vgUr1kx/o5hydSqg0kHH3qlRa9TtA35e/1xc7CJ4xNM2t53ZK8B7nkj6rIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045803;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=XEdUDU9+uy//1f6sH85pJ2llYr4nZa/ui6MMvo7fk68=;
	b=SgvWd8SWoYIQZ7X8EGeTe05qVXrIQ6ry5XEL6luolIHo76AoxMVXallrzTXYNoOR2Yyi
	 9PjYIOAg4J9zr+jYNaYM+ux+Y7WaSNnKnP+iG4tQtwhUrLlG1MLF9yDoQpCafEEWEPSnR
	 IFklMCVFNZBqLqEHqfctFBtprE3UNDElPauDzYLo3MJl53fSb6tq9kkiyLLGWMAnjlM0q
	 mRfGK6SYkELZxMxnJwOgPV89QkaJK7hWMuX0+fDJAGdfFUfWGFrPL3GNSfLSMdp5PDq4q
	 zb56r6dq43wPzBEG6wQ0HIwCYSiwS5ezn094MQfFmbRtIjy64Ssd5/j5jHIu5b7zXfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dtCZK+dh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4C4606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dtCZK+dh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 104831F0089F;
	Sat,  7 Nov 2026 10:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045802;
	bh=XEdUDU9+uy//1f6sH85pJ2llYr4nZa/ui6MMvo7fk68=;
	h=From:To:Cc:Subject:Date;
	b=dtCZK+dhSOh8vjPdg21vcQGLOY6AJS4Ag0k9Jwbn7ttO3ubYWSKq6ZyXZC1aGI0UB
	 ChPSYgyNlYF3bbAY8wHA9AeXm2IJ+G5PbK1PY4m2eLfKriopTxtjcLfxDnAAr1EBq5
	 W9G5eIC1BNSy9QVIuzTQUeZfUVXaC1P591SCNSfUB5Qa4ooOiEqN2cnCcZv+woPMJG
	 Cx453njpRX2CiUI8amyVSN6xpFb4vpb1Hx5oGk5iTTb1jVuzzj5+enoip99hipjHpx
	 Qi7ABUs8jLNKlmrocToOKVF055ix1c+9rdySpaxjmYrhijCl23/6nUkeLL92UVZB/T
	 4gjaIGUQsEnWw==
From: Sasha Levin <sashal@kernel.org>
To: matthew.brost@intel.com,
	himal.prasad.ghimiray@intel.com,
	rodrigo.vivi@intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/xe: Keep walking on SVM eviction failure" failed to apply to 7.3-stable tree
Date: Sat,  7 Nov 2026 05:03:21 -0500
Message-ID: <20261107050321-failed-7.3-36a86c23588b@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x 36a86c23588b8f57c9d20feb4cf5a2ab27e3baba
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050321-failed-7.3-36a86c23588b@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 36a86c23588b8f57c9d20feb4cf5a2ab27e3baba Mon Sep 17 00:00:00 2001
From: Matthew Brost <matthew.brost@intel.com>
Date: Thu, 17 Sep 2026 13:31:58 -0700
Subject: [PATCH] drm/xe: Keep walking on SVM eviction failure

The desired behavior for SVM eviction failures, which can occur due to
various uncontrollable races, is for TTM to continue walking the LRU
list and look for another eviction candidate. This is expressed by
returning -ENOSPC from the ->move() callback.

Adjust the SVM eviction failure path because of races in ->move() to
return -ENOSPC so that TTM continues searching for another buffer to
evict.

Fixes: 3ca608dc7561 ("drm/xe: Basic SVM BO eviction")
Cc: stable@vger.kernel.org
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Reviewed-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Link: https://patch.msgid.link/20260917203158.292823-1-matthew.brost@intel.com
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
---
 drivers/gpu/drm/xe/xe_bo.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 9f3f0cb95afa8..f2ab9bf43a864 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -1044,6 +1044,13 @@ static int xe_bo_move(struct ttm_buffer_object *ttm_bo, bool evict,
 		} else {
 			drm_dbg(&xe->drm, "Evict system allocator BO failed=%pe\n",
 				ERR_PTR(ret));
+			/*
+			 * The semantic we want upon SVM eviction failure
+			 * because of racing access is keep walking for
+			 * eviction, which is -ENOSPC.
+			 */
+			if (ret == -EBUSY)
+				ret = -ENOSPC;
 		}
 
 		goto out;
-- 
2.53.0




