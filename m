Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A667447D479
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 13:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785330364; cv=none; b=ThW9O0dxdrvslB9irh5K7MQS3pOtwdgXJVLQN8uPv4/M5E2OAmGjEJfu86nlNi0TZyLfVuKuW9xlKF8MMoLJenY8TlLT0iSn0Y1O/NNJw+xes+NDAxxAV9HBZZJhqmMto0qU+T4+SJQ8ZA7i6BLwszKTixcXsoDSSFinVx1Kl8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785330364; c=relaxed/simple;
	bh=0GGDvBKaI4eJTIffjXBI3D3xsm2jbEq/bI3vQBk1nbk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=DfNhWP93Ye4Xaw1N5tpGI/joJTuR566fx4B/4OXlCqlXmlBbVLthuTQbU+emf4vHWdh7z0cGgy2H5A0fIVWS7p6rryhVzrBMu2kuUZ916huUl118T3fh/H5oFRV4YqoOnDpZw8pGpEfixMi7Lh4HiMNBfPnH/U/8eVQqEOnuRVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sHrH33WQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sHrH33WQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFEFB1F000E9;
	Wed, 29 Jul 2026 13:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785330363;
	bh=0JLp4oqHbaex48tREV7oK+VKtU/orj7ZRt1/rwLCyvA=;
	h=Subject:To:Cc:From:Date;
	b=sHrH33WQa+jmbCAR8X086HHpI+WBO6ZbTmDryCqwGhXluHHu41yWc3/PHUBvRpn2N
	 AMG4Xl12URhoL8GWUjIZF/ZZzn4aObqg+pBI2LmSYjszKA1M88+kZw8U2ThmxjMBhC
	 QF3M+XXbG7wxSryFLPq8vQtLKCzo7sUDq78tOndI=
Subject: FAILED: patch "[PATCH] wifi: ath6kl: fix use-after-free in aggr_reset_state()" failed to apply to 6.6-stable tree
To: git@danielhodges.dev,jeff.johnson@oss.qualcomm.com,vasanthakumar.thiagarajan@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 15:05:41 +0200
Message-ID: <2026072941-unstable-worsening-62f2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x ba7debb4dd6427386862220e8335a53a4bfc235d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072941-unstable-worsening-62f2@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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
 

