Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1FF346ACE
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 15:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784044236; cv=none; b=AVLpE66qaj/LbMwXTnbsSBWaSCEXSUEQRYk9eS58HoOppcSWzH/kdUQJdYjN0SEv6Y0/TWvk/JzTvr9a6J09G1ta/S/lnF+ZhVcRisZvINssrlOm+CrRL462RYqPKG4ibMSESR+sV+djZDQmjhrVrOILlH3lgZjwcNqm42Iospw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784044236; c=relaxed/simple;
	bh=9DoS8ibOTIhDPLcRiXoP/D9PV/YvtbRRrvoFIa0RnIM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cUBKzeEfb1Lalk0WYkSkzNif6b+37IzqWDGCfkJmdb3oeoYnScek3dday6pEneOC1MD61bX4aG/EYgsJXppS8M5ZBQk3Vu1nRQSjT/+UwfZGyEwIP12cKAL+9mTg4952g+W13Ch35uLYs+WcNxPprZryw56blH8nlmKrsT/q280=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pJWPzBNo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pJWPzBNo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D36781F000E9;
	Tue, 14 Jul 2026 15:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784044235;
	bh=tBCoDaMkyvhTuyz78qyRg7f4qMzp0S53dd4bZm2DAEM=;
	h=Subject:To:Cc:From:Date;
	b=pJWPzBNo5Igcyli6plvgHhu0e0DVoGLKvHRQ+Gnt4fd2IwM0OQlbFM+oDzgKn53HN
	 Mi5ykhucNH/KfqUEtpAP3aPyxX46JpIGCkk8JPwkzypfDrQJZBzyS7giBsvpAZWM8t
	 qOmYsGwpKpV03NSr9cbH48o/FgG6kZPsJgG6j040=
Subject: FAILED: patch "[PATCH] xfs: use null daddr for unset first bad log block" failed to apply to 5.15-stable tree
To: alhouseenyousef@gmail.com,cem@kernel.org,djwong@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 14 Jul 2026 17:50:29 +0200
Message-ID: <2026071429-showdown-footpad-d6da@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x cc9af5e461ea5f6e37738f3f1e41c45a9b7f45d6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071429-showdown-footpad-d6da@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cc9af5e461ea5f6e37738f3f1e41c45a9b7f45d6 Mon Sep 17 00:00:00 2001
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
Date: Tue, 30 Jun 2026 12:06:07 +0200
Subject: [PATCH] xfs: use null daddr for unset first bad log block

xlog_do_recovery_pass() may return before setting first_bad.  The caller
must distinguish that case from an error at a valid log block, including
block zero after the log wraps.

Initialize first_bad to XFS_BUF_DADDR_NULL and test it explicitly before
treating the error as a torn write.

Fixes: 7088c4136fa1 ("xfs: detect and trim torn writes during log recovery")
Suggested-by: Darrick J. Wong <djwong@kernel.org>
Reported-by: syzbot+b7dfbed0c6c2b5e9fd34@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b7dfbed0c6c2b5e9fd34
Cc: stable@vger.kernel.org # v4.5
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Carlos Maiolino <cem@kernel.org>

diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
index 09e6678ca487..5f984bf5698a 100644
--- a/fs/xfs/xfs_log_recover.c
+++ b/fs/xfs/xfs_log_recover.c
@@ -1028,7 +1028,7 @@ xlog_verify_head(
 {
 	struct xlog_rec_header	*tmp_rhead;
 	char			*tmp_buffer;
-	xfs_daddr_t		first_bad;
+	xfs_daddr_t		first_bad = XFS_BUF_DADDR_NULL;
 	xfs_daddr_t		tmp_rhead_blk;
 	int			found;
 	int			error;
@@ -1057,7 +1057,8 @@ xlog_verify_head(
 	 */
 	error = xlog_do_recovery_pass(log, *head_blk, tmp_rhead_blk,
 				      XLOG_RECOVER_CRCPASS, &first_bad);
-	if ((error == -EFSBADCRC || error == -EFSCORRUPTED) && first_bad) {
+	if ((error == -EFSBADCRC || error == -EFSCORRUPTED) &&
+	    first_bad != XFS_BUF_DADDR_NULL) {
 		/*
 		 * We've hit a potential torn write. Reset the error and warn
 		 * about it.
@@ -3575,4 +3576,3 @@ xlog_recover_cancel(
 	if (xlog_recovery_needed(log))
 		xlog_recover_cancel_intents(log);
 }
-

