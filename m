Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824F652D2DB
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788952213; cv=none; b=AknhaDY3hONHn/TKTJ5kKu5W7ebJ5kC6a+6DvHr7V6FTEBsMSe+8YkrqnSIfiLXWGoCy0I/uicx3IomAAlqZ1Hqb4T49dfKXxL2h9/aQNrZBlktjpuEc9rWUad5FNBiyBLa1+e8WJYIOrflhyjtbDH8Pl4WQKH4aJq4TmYMfFTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788952213; c=relaxed/simple;
	bh=isTxP5PTQFZ1Kg9YBvs8phyARgqO/Wgn7lhaEeqrTmg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pyhSIgZxHlAVkORHnC3606TIOVS7TT0BHtVm504PQjuwtsQZ88O4b2v6uZxuAwOlK8adyJSiP7WlbCxXY3PUNVZsGrLXQRK37AvrL6XTLKYSIpLpxaU2o+yal3IGFoxNht1gtTYHp0Y94R42X/HlCbtJMjNpH2i1+lk5X92D03Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jjNWdOtY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jjNWdOtY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD1B41F00A3D;
	Wed,  9 Sep 2026 11:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788952211;
	bh=IMeXLV/qWdItfl/gx4e8GltETszzKx11X+H2D1aEQCw=;
	h=Subject:To:Cc:From:Date;
	b=jjNWdOtYIEdQ/CbAb7jJ/DkqhfZz5o1fF9QIj9WNByWnFl/EOe4nqf6+9toph+V26
	 G0i7i3BfcoSwUg8g7+8odvEfijkmzVeFvEgUJDrll+J2V8QMA3u6gO1p6fpLv6lzYX
	 v+6S1chGMy1hS+bQJ2xDEdXPVbaTboo6LtJC/+o0=
Subject: FAILED: patch "[PATCH] media: cec: disable delayed work before freeing an" failed to apply to 6.1-stable tree
To: birenpandya@gmail.com,hdanton@sina.com,hverkuil+cisco@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 12:58:31 +0200
Message-ID: <2026090931-stubbed-stunning-8eba@gregkh>
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
git cherry-pick -x 0fbd5c2327020858c45b2d1c65775d64cdeca523
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090931-stubbed-stunning-8eba@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0fbd5c2327020858c45b2d1c65775d64cdeca523 Mon Sep 17 00:00:00 2001
From: Biren Pandya <birenpandya@gmail.com>
Date: Sun, 21 Jun 2026 10:04:37 +0530
Subject: [PATCH] media: cec: disable delayed work before freeing an
 interrupted transmit

cec_transmit_msg_fh() drops adap->lock to wait for a blocking transmit in
wait_for_completion_killable(). If that wait is interrupted by a signal,
cancel_delayed_work_sync() can run before the CEC kthread arms the reply
timeout via schedule_delayed_work(&data->work) in cec_transmit_done_ts().
The work is then armed after the cancel, and the data is freed with its
delayed_work still pending:

  ODEBUG: free active (active state 0) object: ... hint: cec_wait_timeout

Use disable_delayed_work_sync(): it cancels the work and disables it, so
the later schedule_delayed_work() becomes a no-op and the work cannot be
re-armed. The data is freed right after, so it need not be re-enabled.

Fixes: 490d84f6d73c ("media: cec: forgot to cancel delayed work")
Reported-by: syzbot+051024d603432b4ab395@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=051024d603432b4ab395
Suggested-by: Hillf Danton <hdanton@sina.com>
Cc: stable@vger.kernel.org
Signed-off-by: Biren Pandya <birenpandya@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>

diff --git a/drivers/media/cec/core/cec-adap.c b/drivers/media/cec/core/cec-adap.c
index a90cb84a4b4d..829ee4861bf7 100644
--- a/drivers/media/cec/core/cec-adap.c
+++ b/drivers/media/cec/core/cec-adap.c
@@ -965,7 +965,7 @@ int cec_transmit_msg_fh(struct cec_adapter *adap, struct cec_msg *msg,
 	 */
 	mutex_unlock(&adap->lock);
 	err = wait_for_completion_killable(&data->c);
-	cancel_delayed_work_sync(&data->work);
+	disable_delayed_work_sync(&data->work);
 	mutex_lock(&adap->lock);
 
 	if (err)

