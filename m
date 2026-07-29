Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54AD41DE0C
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 10:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785321415; cv=none; b=IL7o61lkXwT1IrpLqvsGsEr2tC2U5rUZ5WrG12VxpP/+KOBKYG4oyGnkiLIY4K2AzQ+xWVCmNErFS3gXPJ5JXyC/eXaVPucfq0kMuPECv4nPLLhd3/Ky3UzvcqEiSkRni0AqY2r8feJsrRnfKhYD2l5oAocDpwxakv2ILAsvefk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785321415; c=relaxed/simple;
	bh=OSiSXkEdDuJ0MpIm+qLPgcX/pyk3awIjIvYBVYyfo3s=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lFpYYmk/hkxPm8zhwrRq6Lk42YtRFMMVoWkt6DOWMO6xqTMvIkj1YDxYqURiRv0Juv2LWfq2b5uEDDxVoYPl08ocF/6SlHOUIcc9eqdgiJpiaG80muaa47bCJYBCHHuq1Q5jpaDLDhVds+cMVm+1cHPIJklgkTkS741hlw9PjgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kWSH6mjt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kWSH6mjt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F315D1F000E9;
	Wed, 29 Jul 2026 10:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785321413;
	bh=AD+0bmWjIMhQl2giQGcco+1TPLiCpLOvReVLp/j7rqg=;
	h=Subject:To:Cc:From:Date;
	b=kWSH6mjtRtqNFrVxVwko+nrAeWgn7GP1o5f518Fh/Tey4t90fLr+skZDEVIDkFinw
	 LXOritrcrzHlU0xaafINnDVAqOBr8h0wKwdv+1hO9h3jspJHWzJtb7rvPXvRF0H6hb
	 FBj1W0gbRNkVg6gO8xPAopSXRg3BYLqSLgSmJ9j8=
Subject: FAILED: patch "[PATCH] drm/xe: Disable garbage collector work item on SVM close" failed to apply to 6.18-stable tree
To: matthew.brost@intel.com,thomas.hellstrom@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 12:36:32 +0200
Message-ID: <2026072932-playing-sprinkled-d61b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 2247feb9badca5a4774df9a437bfc44fba4f22de
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072932-playing-sprinkled-d61b@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2247feb9badca5a4774df9a437bfc44fba4f22de Mon Sep 17 00:00:00 2001
From: Matthew Brost <matthew.brost@intel.com>
Date: Thu, 26 Feb 2026 17:52:25 -0800
Subject: [PATCH] drm/xe: Disable garbage collector work item on SVM close
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When an SVM is closed, the garbage collector work item must be stopped
synchronously and any future queuing must be prevented. Replace
flush_work() with disable_work_sync() to ensure both conditions are
met.

Fixes: 63f6e480d115 ("drm/xe: Add SVM garbage collector")
Cc: stable@vger.kernel.org
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Reviewed-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Link: https://patch.msgid.link/20260227015225.3081787-1-matthew.brost@intel.com

diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
index 5b627eed1eab..5933b2b6392b 100644
--- a/drivers/gpu/drm/xe/xe_svm.c
+++ b/drivers/gpu/drm/xe/xe_svm.c
@@ -931,7 +931,7 @@ int xe_svm_init(struct xe_vm *vm)
 void xe_svm_close(struct xe_vm *vm)
 {
 	xe_assert(vm->xe, xe_vm_is_closed(vm));
-	flush_work(&vm->svm.garbage_collector.work);
+	disable_work_sync(&vm->svm.garbage_collector.work);
 	xe_svm_put_pagemaps(vm);
 	drm_pagemap_release_owner(&vm->svm.peer);
 }

