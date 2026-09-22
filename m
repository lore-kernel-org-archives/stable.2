Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5773454EED9
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 15:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790089939; cv=none; b=JrwkUs2nDHixRk47HywU3wj75qBrq6mTf7nOtzxYNlHqEEKPFfDp0NempdLrG/qKj2pfcKoG1X/R7BD+KZJHF46QVf6F8Dvln9f+6chSZMJSpy2Yz6uAfk030prlHbTj1HzInZoKChiAyxVQW2+En7wusaPFYpgyUe5KutM1E40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790089939; c=relaxed/simple;
	bh=zeqKTZNQ4OsBpexhwkpyKYtq7WtFyZum8KJeOp3YxEM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XWSJUuPBCNBzpxi4MUr0hxyAas44Q/XUyEvLINHHVC8dSf69IrlyQQne/16EYtBh5mwN1uRlxedyEJa78m6/OW2ruNKb//3SvngNbT0yH80uuVBWIoS7jU/LqtkahazEzjOdwFYN0jYDlIP1LpEhXHvOVGxEM0S8/YiFGk/XI7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Cv/ihiSj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Cv/ihiSj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C2DE1F000FF;
	Tue, 22 Sep 2026 15:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790089938;
	bh=gUrpamk16hLPkpMcf4PgoI9jBAtTrfA4f5owWb8BvXQ=;
	h=Subject:To:Cc:From:Date;
	b=Cv/ihiSjgSTOf16kED6rlJ1FQYwdjjl9VxXaTIRVINIii44OG2otYF2yINObR1/CQ
	 n/mM/jEj1HoewL4SbrD/uY+lsF6Lwb7Yrsu+V/vVhqojub+tWEM+Tlbh4YwYHiCRHE
	 +L8hsXZUxvkAmvulvZ05jfY5DWx+JPI2wIWgkQ1M=
Subject: FAILED: patch "[PATCH] drm/msm/dpu: clear pending peripheral flush state" failed to apply to 6.12-stable tree
To: saimzst@gmail.com,dmitry.baryshkov@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Sep 2026 17:02:19 +0200
Message-ID: <2026092219-snout-tubeless-0f8d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x a5b5cc909931572aec446e129c035b76b3f0c1fa
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092219-snout-tubeless-0f8d@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a5b5cc909931572aec446e129c035b76b3f0c1fa Mon Sep 17 00:00:00 2001
From: Saim Shujah <saimzst@gmail.com>
Date: Fri, 28 Aug 2026 11:54:40 +0500
Subject: [PATCH] drm/msm/dpu: clear pending peripheral flush state

dpu_hw_ctl_clear_pending_flush() resets the cached per-block state after a
flush transaction, but misses pending_periph_flush_mask.

The peripheral flush updater accumulates interface bits in this mask. A
later transaction which sets the top-level peripheral flush bit can write
stale interface bits to CTL_PERIPH_FLUSH together with the current state.

Peripheral flush support was added after the helper started clearing every
individual pending flush mask. Clear the peripheral mask together with the
other cached child masks.

Fixes: 64f7b81f0358 ("drm/msm/dpu: add support of new peripheral flush mechanism")
Cc: stable@vger.kernel.org
Signed-off-by: Saim Shujah <saimzst@gmail.com>
Patchwork: https://patchwork.freedesktop.org/patch/748968/
Link: https://lore.kernel.org/r/20260828065440.140410-1-saimzst@gmail.com
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
index 36a497f1d6c1..e8729fe1cfef 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
@@ -118,6 +118,7 @@ static inline void dpu_hw_ctl_clear_pending_flush(struct dpu_hw_ctl *ctx)
 	ctx->pending_intf_flush_mask = 0;
 	ctx->pending_wb_flush_mask = 0;
 	ctx->pending_cwb_flush_mask = 0;
+	ctx->pending_periph_flush_mask = 0;
 	ctx->pending_merge_3d_flush_mask = 0;
 	ctx->pending_dsc_flush_mask = 0;
 	ctx->pending_cdm_flush_mask = 0;

