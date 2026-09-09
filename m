Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557044B489B
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788952208; cv=none; b=Kd7tAYbFvc9+xzRYC3zahsm8PwrHg1ObxSo/y2uC2VDVyJNuGFyOQi6GKSs9V2ti9SDH4fCY0mHOalvRPv2qw/EqN2lIEvRzSDx06Y/3GFrK2rs5/xpNXkXnwT2yUICfscGavBymxFA2P68gwaRvnE7ksycki8wsLDW80nZH2fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788952208; c=relaxed/simple;
	bh=j1wWFWn50TEncdoYXzp1HnKpU7wQO8tAEcQNtcOtABo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hGT7HQjkwfeQKTxxAyMD+z5xxCSPr/GLthFisW8dCmbvQnL1YABxH48JKu3ltjoBx4LkDRtukYbu1IAlrom4gVBkfHg4ZV5Xv+XjyF817Re2SGejDI+H5zy+RfxJzW6ylTzKNcLv1yLX74BQpN0r2mKtmptW8OWzGGPS8/7Y0VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s9cNdUFq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s9cNdUFq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A11D1F00A3D;
	Wed,  9 Sep 2026 11:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788952205;
	bh=PpO99yLye6gR55FvIO1joYpeNR8Ua+aoRiBR+R0hyDs=;
	h=Subject:To:Cc:From:Date;
	b=s9cNdUFq1c6CkrcruNYcbKKqmdyKb5Zz5TDlvO9oey884Kgr448XqSvvSI5yl/1+D
	 HukJ48UNnzRNZ6B61Hf/aqC7Tk+aOclsKo/OnmGaxuXJSuvbQ+vbMevSqOR4Ess4Vj
	 81qXiVvHzhb9N7JCRMJdB3mhShBMC203S39URqmI=
Subject: FAILED: patch "[PATCH] media: cec: disable delayed work before freeing an" failed to apply to 6.6-stable tree
To: birenpandya@gmail.com,hdanton@sina.com,hverkuil+cisco@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 12:58:30 +0200
Message-ID: <2026090930-spry-diving-8f70@gregkh>
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
git cherry-pick -x 0fbd5c2327020858c45b2d1c65775d64cdeca523
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090930-spry-diving-8f70@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

