Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3EA45D5E0
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 12:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785328698; cv=none; b=eAJSNfvKHGZUS2SvDiQ59U/3MCqxaG1syP5u0QY9pC794ENs0Nau/hK7fNijzTf1p4KGkMIAMgegvfMRaBE6EOcPXw15HOn8FFm9Z/mssVC4OWuiBYy+DSGK4E+zw0pDkG6P389ysF55cnUIUi3tssPUU0ePQh1vVORL27JfVmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785328698; c=relaxed/simple;
	bh=rjIQcx0asdFqMcbgXY0yodsjG1UyS/PJOkbjPituY3o=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=IzJEH3Ox40yq+aK9AzDc3Ern0DoY4gtd+qHvg8tCLNjRBkBMHZ1ht+BcEjTOpyrqHA7frhFZoMQHgdkrl9VzY/gVL+dXERePhFAVFqRgtowmFMPGwBTO8HV1m0bFE6AZYXAYJA0YPbVbvoRYCpH0o+fOvjw5TDJUag8TD30PQEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zOOGDVac; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zOOGDVac"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A918C1F00A3A;
	Wed, 29 Jul 2026 12:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785328691;
	bh=2LUdFVApadzhHfZ/+XxZCy6kHB+1lQQmYNy4wP6/fIA=;
	h=Subject:To:Cc:From:Date;
	b=zOOGDVacRhjt9dlDLC1IJojkfsvBAyGSgIBRyWYTD8uC84CAebJojAHorM0NdR+qL
	 7uA58UwAg0BBpK0M3fEkVOnlofHh0N1u2RnCNstz9VH2ooc57twY7PM47LrwVsJ6+A
	 xK/WgPGK9cqgKFHbkROaiBTWdqyAhwEtu0RPoYj4=
Subject: FAILED: patch "[PATCH] drm/i915/gt: Fix NULL deref on sched_engine alloc failure" failed to apply to 6.1-stable tree
To: joonas.lahtinen@linux.intel.com,andi.shyti@linux.intel.com,daniele.ceraolospurio@intel.com,martin.hodo@intel.com,matthew.brost@intel.com,rodrigo.vivi@intel.com,stable@vger.kernel.org,tursulin@ursulin.net
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 14:37:47 +0200
Message-ID: <2026072947-reconcile-cringing-757f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 82ec992c404c3dc774c5e9f3d4aa858e97187675
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072947-reconcile-cringing-757f@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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
 

