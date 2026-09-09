Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDE14CC27C
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788953107; cv=none; b=iyQyQX1QkbZU2W0SGWLEU8qD3Ul8DjTA1C0AFAGLkG4CBmF99fvLLDalCKBWVq92KewR5DUE+eqkmErOG24OOu4vn5DOtCiZ/CeyF48OY1xkC+sP7WW+Vi7X8FliMpLqJ+aQQ2SzAB9EUTG/xeFDy6bv1jsH0GB/hiDfmtM4m6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788953107; c=relaxed/simple;
	bh=oD2Fp3UU6U9/YBHsWAJ0vgDHbWsB/uJgBzrNjym2lV0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ly4zEeU2DkzeXIi7TYnIWqxtBhuIJ5YOERoAyL8jgCri0mcN5oiTuccqgOLP/7OvQK/JKKTGAnPsd8ksEKtawOzySugMoc+GyZ5QrWd+K1e+FFtGBYat5sAFQkp/7xjHUKvZ0G584ax6VwRx4q7x616yjvBIUC+yBYjRCFZxmro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BRbPNVqf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BRbPNVqf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9B391F00A3A;
	Wed,  9 Sep 2026 11:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788953106;
	bh=bKA5LQswgW4okoCBKI0SAToQv/CfF4GeS31yBV2/sXY=;
	h=Subject:To:Cc:From:Date;
	b=BRbPNVqfzq3WKNneDJ30MAx5kG1NmOSaB6ior7XE2LEqYPujv51asaT+HQbZe7HH4
	 AHn0/iHSeWCcfngkPv0sdGywDbD6/oXfVPlU+KKTWHwWNrfwBKnXRqIxCmz90vhNdA
	 UTeLMln03i03owk9VoiG+xwfEtm3qAtnOBhOO20U=
Subject: FAILED: patch "[PATCH] scsi: qla2xxx: Zero dport diagnostics buffer to avoid info" failed to apply to 6.1-stable tree
To: njavali@marvell.com,hare@kernel.org,mkp@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 13:16:30 +0200
Message-ID: <2026090930-headgear-bunion-b504@gregkh>
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
git cherry-pick -x a152edab3854f01dd2daf3eaf8f32cbabdb3834e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090930-headgear-bunion-b504@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a152edab3854f01dd2daf3eaf8f32cbabdb3834e Mon Sep 17 00:00:00 2001
From: Nilesh Javali <njavali@marvell.com>
Date: Thu, 23 Jul 2026 10:34:10 +0530
Subject: [PATCH] scsi: qla2xxx: Zero dport diagnostics buffer to avoid info
 leak

qla2x00_do_dport_diagnostics() allocates the qla_dport_diag response
buffer with kmalloc_obj() (non-zeroing) and, on success, copies the full
sizeof(*dd) back to user space via sg_copy_from_buffer(). The inbound
sg_copy_to_buffer() only fills as many bytes as the user request payload
provides, and qla26xx_dport_diagnostics() zeroes only dd->buf. The
options and unused[] fields are therefore copied out uninitialized,
leaking kernel heap contents to user space.

Allocate with kzalloc_obj(), matching qla2x00_do_dport_diagnostics_v2().

Fixes: ec89146215d1 ("qla2xxx: Add bsg interface to support D_Port Diagnostics.")
Cc: stable@vger.kernel.org
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Link: https://patch.msgid.link/20260723050413.3897522-54-njavali@marvell.com
Signed-off-by: Martin K. Petersen (Oracle) <mkp@kernel.org>

diff --git a/drivers/scsi/qla2xxx/qla_bsg.c b/drivers/scsi/qla2xxx/qla_bsg.c
index f9f9687316b5..4a9cf8da67a6 100644
--- a/drivers/scsi/qla2xxx/qla_bsg.c
+++ b/drivers/scsi/qla2xxx/qla_bsg.c
@@ -2806,7 +2806,7 @@ qla2x00_do_dport_diagnostics(struct bsg_job *bsg_job)
 	    !IS_QLA28XX(vha->hw) && !IS_QLA29XX(vha->hw))
 		return -EPERM;
 
-	dd = kmalloc_obj(*dd);
+	dd = kzalloc_obj(*dd);
 	if (!dd) {
 		ql_log(ql_log_warn, vha, 0x70db,
 		    "Failed to allocate memory for dport.\n");

