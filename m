Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1035437CF
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788953096; cv=none; b=GQyjOOL+ueZIkXb+hBBqK/z5TToIytSlJQrGJ18K9AiNbf5Nn48aezYjHKuuckC+eRbR4k6WNY6rXxLuPrTeSqAt4CKrautnZGO6Q1hcDC+S/sElQGcyq6HAOUgeHA42KVhoVYpLY/BDW76FR4H/goIBkUhffDw31RnXnOSTMbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788953096; c=relaxed/simple;
	bh=lIXMiQANIqXzMTpTqGHydsdyAAmWXcaaHsd/CQZstxw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HU8wEG6bicoqs3guDewVyonLA8F8aClaKi0Ziff0nhcSTzNSLmM3xEmFHlBWHaMbHt9Pr/YPciT+LMojnHkPvQFLmyd7UmwuErlgi7y7F3wfyITcWDloZ5TqwRK2gxFpOGnf7k8qxstvmo692ZXEO0JHOv7R6BNbCil9U9QAYng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A/O0F8XB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A/O0F8XB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 939241F00A3A;
	Wed,  9 Sep 2026 11:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788953095;
	bh=qNlQeR1lPCK0mCP4hXorcsXt2VSXmfobfAHQ44JBvbU=;
	h=Subject:To:Cc:From:Date;
	b=A/O0F8XBQNxZic/cqq4ZH1w7lzV8xImbVOurmX2VdDW9afz0OBh0UPWDRz8hJ8ZsZ
	 9ggl1uPqpXmZBtY7ViMGsrjnpLaCNbX2EM3y9TMwB6gqXsEuuANwGrqmcqyuDk1gLg
	 Lno/ktaqphY4vaySouqyAey6CZlpauveIpqa5O5Q=
Subject: FAILED: patch "[PATCH] scsi: qla2xxx: Zero dport diagnostics buffer to avoid info" failed to apply to 6.6-stable tree
To: njavali@marvell.com,hare@kernel.org,mkp@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 13:16:29 +0200
Message-ID: <2026090929-willpower-demise-a921@gregkh>
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
git cherry-pick -x a152edab3854f01dd2daf3eaf8f32cbabdb3834e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090929-willpower-demise-a921@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

