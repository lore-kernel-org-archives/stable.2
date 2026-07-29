Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667DC4418D7
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 12:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785328690; cv=none; b=BURoZUM+uOBwsLCmljliV/3+tIkU+2/zPumx+q2GUwYd0m5vS0DnrqK1MZDgixtIUodK9dtyhVYRfO4hA2/B4W7QluDecWxbrm5kmsBQ8/sZPkfTcyAvUyrbcwPrcuRoCE6ETIJsM6Y45Z2ifAFNXR4NesM/dTUwnx+wi0RvXa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785328690; c=relaxed/simple;
	bh=XfhqGzWnsB2bJj4j6004mvRzp6LB+XpUxn1xqHNJEAs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PZCl/JaomeIPSDHSeF+BLlv3G+SnPn0ZrOvbkeNE801ExbS5VvhSnB+7QZyNO9q4p8x9GzxVlL9qIegVmg5yuvExrBZAutHnwdTncU8WtP2x2ZG7nF2L2cTq6rj0lh4WbeTKCDtA0rLhrUB8UrOa13rClyYICEKWRUMy6WlSa8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0AdXKOOt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0AdXKOOt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E6CF1F00A3F;
	Wed, 29 Jul 2026 12:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785328680;
	bh=Hb9QGTswnvbliVL0d4B/0d+bbLqZfnYGEGBTMQvMojU=;
	h=Subject:To:Cc:From:Date;
	b=0AdXKOOtQuuIqJEJIc/FLn3599yPBBVY6KL+e+8noqD3Fhc37Zy4rmQIiRcmcv335
	 ImKlfUkbPhHxe6lSrTcq/xa2ffK7MU38fv2nnf4FG3JkBdAE2PVcKTuTeelFBQ2nlF
	 ujpzQUc/LR7UfX55ox+JcVHq7u1Pvl8t/rWjnHbw=
Subject: FAILED: patch "[PATCH] drm/i915/gt: Fix NULL deref on sched_engine alloc failure" failed to apply to 6.18-stable tree
To: joonas.lahtinen@linux.intel.com,andi.shyti@linux.intel.com,daniele.ceraolospurio@intel.com,martin.hodo@intel.com,matthew.brost@intel.com,rodrigo.vivi@intel.com,stable@vger.kernel.org,tursulin@ursulin.net
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 14:37:46 +0200
Message-ID: <2026072946-skedaddle-mocker-4292@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 82ec992c404c3dc774c5e9f3d4aa858e97187675
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072946-skedaddle-mocker-4292@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 82ec992c404c3dc774c5e9f3d4aa858e97187675 Mon Sep 17 00:00:00 2001
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Date: Wed, 1 Jul 2026 14:45:13 +0300
Subject: [PATCH] drm/i915/gt: Fix NULL deref on sched_engine alloc failure

Avoid using intel_context_put() before intel_context_init() in
execlists_create_virtual() as the kref_put() inside would lead
to NULL deref on the IOCTL path when sched_engine allocation fails.

Discovered using AI-assisted static analysis confirmed by
Intel Product Security.

Reported-by: Martin Hodo <martin.hodo@intel.com>
Fixes: 3e28d37146db ("drm/i915: Move priolist to new i915_sched_engine object")
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Cc: Tvrtko Ursulin <tursulin@ursulin.net>
Cc: <stable@vger.kernel.org> # v5.15+
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
Signed-off-by: Tvrtko Ursulin <tursulin@ursulin.net>
Link: https://lore.kernel.org/r/20260701114513.221254-1-joonas.lahtinen@linux.intel.com
(cherry picked from commit 4f2a12f2d50e9f48227656e4dcbd6423506be31d)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

diff --git a/drivers/gpu/drm/i915/gt/intel_execlists_submission.c b/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
index 1359fc9cb88e..e693b0c9d2a3 100644
--- a/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
+++ b/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
@@ -3932,11 +3932,11 @@ execlists_create_virtual(struct intel_engine_cs **siblings, unsigned int count,
 	struct drm_i915_private *i915 = siblings[0]->i915;
 	struct virtual_engine *ve;
 	unsigned int n;
-	int err;
+	int err = -ENOMEM;
 
 	ve = kzalloc_flex(*ve, siblings, count);
 	if (!ve)
-		return ERR_PTR(-ENOMEM);
+		goto err;
 
 	ve->base.i915 = i915;
 	ve->base.gt = siblings[0]->gt;
@@ -3968,10 +3968,8 @@ execlists_create_virtual(struct intel_engine_cs **siblings, unsigned int count,
 	intel_engine_init_execlists(&ve->base);
 
 	ve->base.sched_engine = i915_sched_engine_create(ENGINE_VIRTUAL);
-	if (!ve->base.sched_engine) {
-		err = -ENOMEM;
-		goto err_put;
-	}
+	if (!ve->base.sched_engine)
+		goto err_noput;
 	ve->base.sched_engine->private_data = &ve->base;
 
 	ve->base.cops = &virtual_context_ops;
@@ -3987,10 +3985,8 @@ execlists_create_virtual(struct intel_engine_cs **siblings, unsigned int count,
 	intel_context_init(&ve->context, &ve->base);
 
 	ve->base.breadcrumbs = intel_breadcrumbs_create(NULL);
-	if (!ve->base.breadcrumbs) {
-		err = -ENOMEM;
+	if (!ve->base.breadcrumbs)
 		goto err_put;
-	}
 
 	for (n = 0; n < count; n++) {
 		struct intel_engine_cs *sibling = siblings[n];
@@ -4065,8 +4061,13 @@ execlists_create_virtual(struct intel_engine_cs **siblings, unsigned int count,
 	virtual_engine_initial_hint(ve);
 	return &ve->context;
 
+err_noput:
+	kfree(ve);
+	goto err;
+
 err_put:
 	intel_context_put(&ve->context);
+err:
 	return ERR_PTR(err);
 }
 

