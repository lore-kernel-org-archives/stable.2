Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C31F395AF4
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 10:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785321406; cv=none; b=VagzJ6LghZVSRqP1sz3nITFmc4vVfSHQ0m1D35ljgUg8RmxH8x7xHDBMR4By8631fM5kiV9CKo0Wu7uFOVxWtg2QfC8Asphu15k25vbJAdRPX/MjIUh7NOLYfDnobdSjO25WOac+QqXKA2391QzM6AEFF7yY3sFnYAnkNJ7vkB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785321406; c=relaxed/simple;
	bh=FT2FIq1NySuunfmYcHpCIVm/atucWGbNbt9b1TkiOYo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UEeRDJcCdADclGbyIAOboaX2+mu2/aLjf+1blPdDA53IgYCYZpDGHXb+W/h4a3AJzNDr9c35KB/UkgqkTz78J7ezQLfwBRkhvUxL997HePFWO9CN+4zjTZqxPPmDlJQDto2QJoEwHHFK5m19L+jxyGKJ6bswGAylIvfxT+w73z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eZUepobx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eZUepobx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CE8A1F00A3A;
	Wed, 29 Jul 2026 10:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785321405;
	bh=c58z/6TXsperM+517SNbrQ5//R21iIXHXVle0lLEOMw=;
	h=Subject:To:Cc:From:Date;
	b=eZUepobx2ubyTlJLqS3XzpG7LeR09ym3A69HP/3V/Fi8Mad4XpFD9/y54k09+JJJ/
	 H5NyZQynCY0Tg0/CJ8+OuU6mRofQYA6mYwvcE28BGwl2hQBJCejwBug95W46j0jOq6
	 Djdr4wxEJ0vz8KaIZKEFa9SWk7NDkU3qY4R/gM/0=
Subject: FAILED: patch "[PATCH] drm/xe: Disable garbage collector work item on SVM close" failed to apply to 7.1-stable tree
To: matthew.brost@intel.com,thomas.hellstrom@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 12:36:31 +0200
Message-ID: <2026072931-unaligned-vacate-6866@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.1.y
git checkout FETCH_HEAD
git cherry-pick -x 2247feb9badca5a4774df9a437bfc44fba4f22de
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072931-unaligned-vacate-6866@gregkh' --subject-prefix 'PATCH 7.1.y' 'HEAD^..'

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

