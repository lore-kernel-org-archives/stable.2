Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A34485CFD
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 13:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785330370; cv=none; b=o6MTOf/hF3T5uLUz6Vk39h8PYj8P8S4r/eLJzZMqUzUcRKh/iDuu2p1WUz9oI6sff052eMyBojCeHgvMPR3apa3u5TQT5vyqax0NZymMp/hMKUigcmSLRoI4o5Ju5D/FYWRNlxmNEv2skWKi0U/FcGSDUaZif1lajFyH1n1PFV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785330370; c=relaxed/simple;
	bh=EYgPnucNoms/6jMCm8RzsvlOyF6nGmk94zv2rJKYsWA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=QnbDPTiVG+jchAZ6ibJP+n7iQEb9sQaM+W08EmdwfBPCsGY31aTM04NQy9Kw3+oF3QiBSAehSem8zIP8yxig2ob8mIrFITfKMcVCy+0iHEwdMjTadI1wfTsqUzgbzfReXeuCn9bkFqKXm6V/XTgRtLmt8Cs9NTU5LKFQFRV1vpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ggaGoG5F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ggaGoG5F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C9981F000E9;
	Wed, 29 Jul 2026 13:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785330368;
	bh=xgHrOzc1w39EkbOMgjlHQmLYJXCA+tPwFlu64fK/W8I=;
	h=Subject:To:Cc:From:Date;
	b=ggaGoG5FfNE9MibyCN6pRrj4HdE04vsXUwNCfVIsHXGTCf4q12LLrkoAbw+EU07I+
	 xLbQULLjwwBdoyD0CXQvVlxdgZamfGkNkJEyzf0wOCF2qXqT0kwXHbBo+eu5SUMqK1
	 enQLkDsdYm0/UsTeIrtXHxn+iUHXTuT5Pk6yqRww=
Subject: FAILED: patch "[PATCH] wifi: ath6kl: fix use-after-free in aggr_reset_state()" failed to apply to 6.1-stable tree
To: git@danielhodges.dev,jeff.johnson@oss.qualcomm.com,vasanthakumar.thiagarajan@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 15:05:42 +0200
Message-ID: <2026072942-curator-autopilot-b92d@gregkh>
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
git cherry-pick -x ba7debb4dd6427386862220e8335a53a4bfc235d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072942-curator-autopilot-b92d@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ba7debb4dd6427386862220e8335a53a4bfc235d Mon Sep 17 00:00:00 2001
From: Daniel Hodges <git@danielhodges.dev>
Date: Fri, 6 Feb 2026 13:52:07 -0500
Subject: [PATCH] wifi: ath6kl: fix use-after-free in aggr_reset_state()

The aggr_reset_state() function uses timer_delete() (non-synchronous)
for the aggregation timer before proceeding to delete TID state and
before the structure is freed by callers like aggr_module_destroy().

If the timer callback (aggr_timeout) is executing when aggr_reset_state()
is called, the callback will continue to access aggr_conn fields like
rx_tid[] and stat[] which may be freed immediately after by
kfree(aggr_info->aggr_conn) in aggr_module_destroy().

Additionally, the timer callback can re-arm itself via mod_timer() while
aggr_reset_state() is running, creating a more complex race condition.

Use timer_delete_sync() instead to ensure any running timer callback
has completed before returning.

Fixes: bdcd81707973 ("Add ath6kl cleaned up driver")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Hodges <git@danielhodges.dev>
Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Link: https://patch.msgid.link/20260206185207.30098-1-git@danielhodges.dev
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>

diff --git a/drivers/net/wireless/ath/ath6kl/txrx.c b/drivers/net/wireless/ath/ath6kl/txrx.c
index 97fdac7237e2..0e268017af52 100644
--- a/drivers/net/wireless/ath/ath6kl/txrx.c
+++ b/drivers/net/wireless/ath/ath6kl/txrx.c
@@ -1828,7 +1828,7 @@ void aggr_reset_state(struct aggr_info_conn *aggr_conn)
 		return;
 
 	if (aggr_conn->timer_scheduled) {
-		timer_delete(&aggr_conn->timer);
+		timer_delete_sync(&aggr_conn->timer);
 		aggr_conn->timer_scheduled = false;
 	}
 

