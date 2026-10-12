Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1444A0EF8
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 15:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819113; cv=none; b=OR19H9jaJ0E/fPLWJBuuZ3FK3fzMhx1LQgzmBBAC9VNxxMkZ8yHp/jsHjk410JXwWQ1/+QiOz4trbX9XifzLHVyIBwAFBVqBzqT2dwNxzINSIZp/W+JbzkYcoGJLOVrPMlwB40waAF/uzVXSKleuFZL2pA4pp9X337iiSILLW1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819113; c=relaxed/simple;
	bh=meukzQdG+wOu3hcWtdORWvvMAatuy7LRwz45skxBhC4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Bm6XFW+jaqMhJ0Vl6H1+SCx3sCQxEgOEVOyu4eBN9ZBF/micCscmIEOOaZhrKTFV/euyqn30DQLUzVurbeuSyzKI3UWDWomNoi/w2hYB6peMV7wNllbsfasGSi88n4WoZpvO0ykpJe9d0kw73t+uGuHuprKD4tdKhHN3QHLLdGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZyHzFkiY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZyHzFkiY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03C2B1F0089B;
	Mon, 12 Oct 2026 15:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791819111;
	bh=H9Ldh9n3OTmLzNfgwiP0noeu7ursF8kFkgGv3F1/kU4=;
	h=Subject:To:Cc:From:Date;
	b=ZyHzFkiYazH3Vl6mmKuYnuKDC78LTHhE3FTaDQpoBSEvkWA2tRuSkUG7iyrx2Hb8k
	 Y8NqROcN5JxRNV0aj11QerIQIkHCIEE27eboEZcmpeuHMxZJggIv/I1xywi+d88MUq
	 1zMBMaykZ+5jgJ/xdOwMl1v5E5M9hPwbZjcVRWVA=
Subject: FAILED: patch "[PATCH] drm/vc4: drain the hangcheck timer and works on V3D unbind" failed to apply to 5.10-stable tree
To: fanwu01@zju.edu.cn,mcanal@igalia.com,songl@zju.edu.cn
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Oct 2026 17:30:47 +0200
Message-ID: <2026101247-modular-greedless-9000@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 94cf5971b1d04c6382437387c4dc3836cc7a1437
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026101247-modular-greedless-9000@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 94cf5971b1d04c6382437387c4dc3836cc7a1437 Mon Sep 17 00:00:00 2001
From: Fan Wu <fanwu01@zju.edu.cn>
Date: Tue, 15 Sep 2026 09:51:03 +0000
Subject: [PATCH] drm/vc4: drain the hangcheck timer and works on V3D unbind
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Nothing stops the hangcheck timer that submitted jobs arm, or the
job_done_work that the render-done interrupt queues, at teardown:
vc4_irq_disable() cancels only overflow_mem_work, and vc4_gem_destroy()
runs from the drm-managed release, after vc4_v3d_unbind() has already
uninstalled the V3D interrupt and cleared vc4->v3d. A timer still armed
by then reads V3D registers through the NULL vc4->v3d pointer, and the
late callbacks run on the vc4_dev embedding them after it has been
freed.

Drain them in vc4_v3d_unbind(): shut the timer down and cancel
reset_work before the interrupt is taken down, because its
vc4_irq_reset() re-enables it, then flush job_done_work so that
completions queued at teardown still release their jobs.

This issue was found by an in-house static analysis tool.

Fixes: d5b1a78a772f ("drm/vc4: Add support for drawing 3D frames.")
Cc: stable@vger.kernel.org # 6.2+
Assisted-by: Codex:gpt-5.6
Co-developed-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
Link: https://patch.msgid.link/20260915095103.156007-1-fanwu01@zju.edu.cn
Reviewed-by: Maíra Canal <mcanal@igalia.com>
Signed-off-by: Maíra Canal <mcanal@igalia.com>

diff --git a/drivers/gpu/drm/vc4/vc4_v3d.c b/drivers/gpu/drm/vc4/vc4_v3d.c
index f32410420d3e..0f0c090afa6e 100644
--- a/drivers/gpu/drm/vc4/vc4_v3d.c
+++ b/drivers/gpu/drm/vc4/vc4_v3d.c
@@ -9,6 +9,7 @@
 #include <linux/component.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/timer.h>
 
 #include <drm/drm_print.h>
 
@@ -497,8 +498,15 @@ static void vc4_v3d_unbind(struct device *dev, struct device *master,
 	struct drm_device *drm = data;
 	struct vc4_dev *vc4 = to_vc4_dev(drm);
 
+	/* A straggler vc4_reset() re-enables the interrupt. */
+	timer_shutdown_sync(&vc4->hangcheck.timer);
+	cancel_work_sync(&vc4->hangcheck.reset_work);
+
 	vc4_irq_uninstall(drm);
 
+	/* Flush rather than cancel, so queued completions release their jobs. */
+	flush_work(&vc4->job_done_work);
+
 	/* Disable the binner's overflow memory address, so the next
 	 * driver probe (if any) doesn't try to reuse our old
 	 * allocation.

